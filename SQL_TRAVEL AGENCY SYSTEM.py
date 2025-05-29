import tkinter as tk
from tkinter import messagebox, ttk
import psycopg2
from psycopg2 import Error
import random

class TravelAgencyApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Long Island Travel Agency")
        self.root.geometry("750x800")

        # Database connection parameters
        self.db_params = {
            "host": "localhost",
            "database": "TRAVEL AGENCY SYSTEM",
            "user": "postgres",
            "password": "12345",
            "port": "5432"
        }

        # Create main frame with scrollbar
        self.main_canvas = tk.Canvas(self.root)
        self.main_canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        
        self.scrollbar = ttk.Scrollbar(self.root, orient=tk.VERTICAL, command=self.main_canvas.yview)
        self.scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        
        self.main_canvas.configure(yscrollcommand=self.scrollbar.set)
        self.main_canvas.bind('<Configure>', lambda e: self.main_canvas.configure(scrollregion=self.main_canvas.bbox("all")))
        
        self.main_frame = ttk.Frame(self.main_canvas, padding="10")
        self.main_canvas.create_window((0, 0), window=self.main_frame, anchor="nw")

        # Travel Agency Name
        ttk.Label(self.main_frame, text="Long Island Travel Agency", font=("Arial", 18, "bold")).grid(row=0, column=0, columnspan=2, pady=10)

        # From and To locations
        ttk.Label(self.main_frame, text="FROM:").grid(row=1, column=0, pady=5, padx=5, sticky=tk.W)
        self.from_location = ttk.Combobox(self.main_frame, width=30)
        self.from_location.grid(row=1, column=1, pady=5, padx=5)

        ttk.Label(self.main_frame, text="TO:").grid(row=2, column=0, pady=5, padx=5, sticky=tk.W)
        self.to_location = ttk.Combobox(self.main_frame, width=30)
        self.to_location.grid(row=2, column=1, pady=5, padx=5)

        self.load_locations()

        # Travel Type (Flight or Cruise)
        ttk.Label(self.main_frame, text="Travel Type:").grid(row=3, column=0, pady=5, padx=5, sticky=tk.W)
        self.travel_type = ttk.Combobox(self.main_frame, values=["FLIGHT", "CRUISE"], width=30, state="readonly")
        self.travel_type.grid(row=3, column=1, pady=5, padx=5)
        self.travel_type.set("FLIGHT")  # Default selection

        ttk.Button(self.main_frame, text="Next", command=self.show_transport_options).grid(row=4, column=0, columnspan=2, pady=10)

        # Class/Category selection
        self.class_label = ttk.Label(self.main_frame, text="")
        self.class_combobox = ttk.Combobox(self.main_frame, width=30, state="readonly")
        
        # Price selection
        self.price_label = ttk.Label(self.main_frame, text="")
        self.price_combobox = ttk.Combobox(self.main_frame, width=30, state="readonly")
        
        # Transport options
        self.transport_label = ttk.Label(self.main_frame, text="")
        self.transport_combobox = ttk.Combobox(self.main_frame, width=30, state="readonly")
        
        # Accommodation type
        self.accommodation_label = ttk.Label(self.main_frame, text="")
        self.accommodation_combobox = ttk.Combobox(self.main_frame, width=30, state="readonly")
        
        # Total amount button and display
        self.total_amount_button = ttk.Button(self.main_frame, text="", command=self.generate_total_amount)
        self.total_amount_label = ttk.Label(self.main_frame, text="")
        
        # Payment type
        self.payment_type_label = ttk.Label(self.main_frame, text="")
        self.payment_type_combobox = ttk.Combobox(self.main_frame, width=30, state="readonly")
        
        # User details
        self.name_label = ttk.Label(self.main_frame, text="")
        self.name_entry = ttk.Entry(self.main_frame, width=30)
        
        self.address_label = ttk.Label(self.main_frame, text="")
        self.address_entry = ttk.Entry(self.main_frame, width=30)
        
        self.card_label = ttk.Label(self.main_frame, text="")
        self.card_entry = ttk.Entry(self.main_frame, width=30)
        
        # Submit button
        self.submit_button = ttk.Button(self.main_frame, text="", command=self.submit_payment)
        
        # Rating and Review Section (initially hidden)
        self.rating_frame = ttk.LabelFrame(self.main_frame, text="Rate Your Experience", padding="10")
        self.rating_label = ttk.Label(self.rating_frame, text="Rating (1-5 stars):")
        self.rating_var = tk.IntVar(value=0)  # Initialize with 0 (no selection)
        
        # Create star rating buttons
        self.star_frame = ttk.Frame(self.rating_frame)
        self.star_buttons = []
        for i in range(1, 6):
            btn = ttk.Radiobutton(
                self.star_frame, 
                text=str(i), 
                variable=self.rating_var, 
                value=i,
                command=lambda v=i: self.update_stars(v)
            )
            btn.pack(side=tk.LEFT, padx=2)
            self.star_buttons.append(btn)
        
        self.review_label = ttk.Label(self.rating_frame, text="Your Review:")
        self.review_text = tk.Text(self.rating_frame, height=5, width=40, wrap=tk.WORD)
        self.submit_review_button = ttk.Button(self.rating_frame, text="Submit Review", command=self.submit_review)
        
        # Arrange rating widgets
        self.rating_label.grid(row=0, column=0, sticky=tk.W, pady=5)
        self.star_frame.grid(row=0, column=1, sticky=tk.W, pady=5)
        self.review_label.grid(row=1, column=0, columnspan=2, sticky=tk.W, pady=5)
        self.review_text.grid(row=2, column=0, columnspan=2, pady=5)
        self.submit_review_button.grid(row=3, column=0, columnspan=2, pady=10)

        # Display results area
        self.result_text = tk.Text(self.main_frame, height=15, width=60, state="disabled")
        self.result_text.grid(row=20, column=0, columnspan=2, pady=10)

    def update_stars(self, rating):
        """Update star buttons appearance based on selected rating"""
        for i, btn in enumerate(self.star_buttons, start=1):
            if i <= rating:
                btn.config(style="Selected.TRadiobutton")
            else:
                btn.config(style="TRadiobutton")

    def submit_review(self):
        """Handle review submission (not saved to database)"""
        rating = self.rating_var.get()
        review_text = self.review_text.get("1.0", tk.END).strip()
        
        if rating == 0:
            messagebox.showwarning("Input Error", "Please select a rating between 1-5 stars.")
            return
        
        # Display thank you message
        messagebox.showinfo("Thank You", "Thank you for your feedback!\n"
                              f"Rating: {rating} stars\n"
                              f"Review: {review_text if review_text else 'No review text provided'}")
        
        # Reset the entire form for new booking
        self.reset_form()

    def reset_form(self):
        """Completely reset all form fields to initial state"""
        # Clear all entry fields and comboboxes
        self.from_location.set('')
        self.to_location.set('')
        self.travel_type.set("FLIGHT")
        self.class_combobox.set('')
        self.price_combobox.set('')
        self.transport_combobox.set('')
        self.accommodation_combobox.set('')
        self.payment_type_combobox.set('')
        self.name_entry.delete(0, tk.END)
        self.address_entry.delete(0, tk.END)
        self.card_entry.delete(0, tk.END)
        self.rating_var.set(0)
        self.review_text.delete("1.0", tk.END)
        self.total_amount_label.config(text="")
        
        # Reset star buttons appearance
        for btn in self.star_buttons:
            btn.config(style="TRadiobutton")
        
        # Hide all dynamic widgets
        self.clear_selections()
        
        # Clear result text
        self.result_text.config(state="normal")
        self.result_text.delete(1.0, tk.END)
        self.result_text.config(state="disabled")
        
        # Hide rating frame
        self.rating_frame.grid_remove()

    def connect_db(self):
        """Establish connection to the PostgreSQL database."""
        try:
            connection = psycopg2.connect(**self.db_params)
            return connection
        except Error as e:
            messagebox.showerror("Database Error", f"Error connecting to database: {e}")
            return None

    def load_locations(self):
        """Load travel locations into the combobox."""
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("SELECT LOC_ID, CITY, LOC_STATE, COUNTRY FROM TRAVEL_LOCATION ORDER BY CITY")
                locations = cursor.fetchall()
                location_names = [f"{loc[1]}, {loc[2]}, {loc[3]}" for loc in locations]

                self.from_location['values'] = location_names
                self.to_location['values'] = location_names

                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching locations: {e}")
            finally:
                connection.close()

    def show_transport_options(self):
        """Show the available transport options based on user selection."""
        travel_type = self.travel_type.get()
        from_location = self.from_location.get()
        to_location = self.to_location.get()

        if not travel_type or not from_location or not to_location:
            messagebox.showwarning("Input Error", "Please select a travel type and both source and destination locations.")
            return
        
        if from_location == to_location:
            messagebox.showwarning("Input Error", "Source and destination cannot be the same.")
            return
        
        # Clear previous selections
        self.clear_selections()
        
        from_location_id = self.get_location_id(from_location)
        to_location_id = self.get_location_id(to_location)
        
        self.from_loc_id = from_location_id
        self.to_loc_id = to_location_id
        self.selected_travel_type = travel_type

        # Show class/category options based on travel type
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()

                if travel_type == "FLIGHT":
                    cursor.execute("SELECT DISTINCT CATEGORY FROM FLIGHT_TRANSPORT")
                    options = [row[0] for row in cursor.fetchall()]
                    label_text = "Class:"
                else:  # CRUISE
                    cursor.execute("SELECT DISTINCT CATEGORY FROM CRUISE_TRANSPORT")
                    options = [row[0] for row in cursor.fetchall()]
                    label_text = "Category:"

                if not options:
                    messagebox.showwarning("No Options", f"No available categories found for {travel_type}.")
                    return

                # Show class/category selection
                self.class_label.config(text=label_text)
                self.class_label.grid(row=5, column=0, pady=5, padx=5, sticky=tk.W)
                self.class_combobox['values'] = options
                self.class_combobox.grid(row=5, column=1, pady=5, padx=5)
                self.class_combobox.bind("<<ComboboxSelected>>", self.show_price_options)

                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching {travel_type} categories: {e}")
            finally:
                connection.close()

    def show_price_options(self, event=None):
        """Show price options based on selected class/category."""
        category = self.class_combobox.get()
        travel_type = self.selected_travel_type
        
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()

                if travel_type == "FLIGHT":
                    cursor.execute("SELECT DISTINCT PRICE FROM FLIGHT_TRANSPORT WHERE CATEGORY = %s", (category,))
                else:  # CRUISE
                    cursor.execute("SELECT DISTINCT PRICE FROM CRUISE_TRANSPORT WHERE CATEGORY = %s", (category,))

                options = [row[0] for row in cursor.fetchall()]

                if not options:
                    messagebox.showwarning("No Options", f"No available prices found for selected {category}.")
                    return

                # Show price selection
                self.price_label.config(text="Price:")
                self.price_label.grid(row=6, column=0, pady=5, padx=5, sticky=tk.W)
                self.price_combobox['values'] = options
                self.price_combobox.grid(row=6, column=1, pady=5, padx=5)
                self.price_combobox.bind("<<ComboboxSelected>>", self.show_transport_list)

                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching prices: {e}")
            finally:
                connection.close()

    def show_transport_list(self, event=None):
        """Show available flights/cruises based on selections."""
        travel_type = self.selected_travel_type
        from_loc_id = self.from_loc_id
        to_loc_id = self.to_loc_id
        
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()

                if travel_type == "FLIGHT":
                    cursor.execute("SELECT FLIGHT_NAME FROM FLIGHT WHERE SOURCE_ID = %s AND DEST_ID = %s", 
                                 (from_loc_id, to_loc_id))
                    transport_label_text = "Available Flights:"
                else:  # CRUISE
                    cursor.execute("SELECT CRUISE_NO FROM CRUISE WHERE SOURCE_ID = %s AND DEST_ID = %s", 
                                 (from_loc_id, to_loc_id))
                    transport_label_text = "Available Cruises:"

                options = [row[0] for row in cursor.fetchall()]

                if not options:
                    messagebox.showwarning("No Options", f"No available {travel_type.lower()}s found between selected locations.")
                    return

                # Show transport selection
                self.transport_label.config(text=transport_label_text)
                self.transport_label.grid(row=7, column=0, pady=5, padx=5, sticky=tk.W)
                self.transport_combobox['values'] = options
                self.transport_combobox.grid(row=7, column=1, pady=5, padx=5)
                self.transport_combobox.bind("<<ComboboxSelected>>", self.show_accommodation_options)

                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching {travel_type.lower()}s: {e}")
            finally:
                connection.close()

    def show_accommodation_options(self, event=None):
        """Show accommodation options."""
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("SELECT DISTINCT ACC_TYPE FROM ACCOMMODATION")
                options = [row[0] for row in cursor.fetchall()]

                if not options:
                    messagebox.showwarning("No Options", "No accommodation types found.")
                    return

                # Show accommodation selection
                self.accommodation_label.config(text="Accommodation Type:")
                self.accommodation_label.grid(row=8, column=0, pady=5, padx=5, sticky=tk.W)
                self.accommodation_combobox['values'] = options
                self.accommodation_combobox.grid(row=8, column=1, pady=5, padx=5)
                self.accommodation_combobox.bind("<<ComboboxSelected>>", self.show_total_amount_button)

                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching accommodation types: {e}")
            finally:
                connection.close()

    def show_total_amount_button(self, event=None):
        """Show button to generate total amount."""
        self.total_amount_button.config(text="Generate Total Amount (Transport + Accommodation)")
        self.total_amount_button.grid(row=9, column=0, columnspan=2, pady=10)
        
        # Show payment type options
        self.show_payment_options()

    def generate_total_amount(self):
        """Generate and display a random total amount."""
        total_amount = round(random.uniform(800, 1499), 2)
        self.total_amount = total_amount
        
        self.total_amount_label.config(text=f"Total Amount: ${total_amount}")
        self.total_amount_label.grid(row=10, column=0, columnspan=2, pady=5)

    def show_payment_options(self):
        """Show payment type options."""
        connection = self.connect_db()
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("SELECT DISTINCT PAY_TYPE FROM PAYMENT")
                options = [row[0] for row in cursor.fetchall()]

                if not options:
                    messagebox.showwarning("No Options", "No payment types found.")
                    return

                # Show payment type selection
                self.payment_type_label.config(text="Payment Type:")
                self.payment_type_label.grid(row=11, column=0, pady=5, padx=5, sticky=tk.W)
                self.payment_type_combobox['values'] = options
                self.payment_type_combobox.grid(row=11, column=1, pady=5, padx=5)
                
                # Show user details fields
                self.show_user_details()

                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching payment types: {e}")
            finally:
                connection.close()

    def show_user_details(self):
        """Show fields for user details."""
        self.name_label.config(text="Name:")
        self.name_label.grid(row=12, column=0, pady=5, padx=5, sticky=tk.W)
        self.name_entry.grid(row=12, column=1, pady=5, padx=5)
        
        self.address_label.config(text="Address:")
        self.address_label.grid(row=13, column=0, pady=5, padx=5, sticky=tk.W)
        self.address_entry.grid(row=13, column=1, pady=5, padx=5)
        
        self.card_label.config(text="Card No:")
        self.card_label.grid(row=14, column=0, pady=5, padx=5, sticky=tk.W)
        self.card_entry.grid(row=14, column=1, pady=5, padx=5)
        
        # Show submit button
        self.submit_button.config(text="Submit Booking")
        self.submit_button.grid(row=15, column=0, columnspan=2, pady=10)

    def clear_selections(self):
        """Clear all previous selections and hide widgets."""
        widgets_to_clear = [
            self.class_label, self.class_combobox,
            self.price_label, self.price_combobox,
            self.transport_label, self.transport_combobox,
            self.accommodation_label, self.accommodation_combobox,
            self.total_amount_button, self.total_amount_label,
            self.payment_type_label, self.payment_type_combobox,
            self.name_label, self.name_entry,
            self.address_label, self.address_entry,
            self.card_label, self.card_entry,
            self.submit_button,
            self.rating_frame
        ]
        
        for widget in widgets_to_clear:
            widget.grid_remove()

    def get_location_id(self, location_name):
        """Retrieve location ID from the name."""
        connection = self.connect_db()
        location_id = None
        if connection:
            try:
                cursor = connection.cursor()
                cursor.execute("""
                    SELECT LOC_ID FROM TRAVEL_LOCATION
                    WHERE CONCAT(CITY, ', ', LOC_STATE, ', ', COUNTRY) = %s
                """, (location_name,))
                result = cursor.fetchone()
                if result:
                    location_id = result[0]
                cursor.close()
            except Error as e:
                messagebox.showerror("Query Error", f"Error fetching location ID: {e}")
            finally:
                connection.close()
        return location_id

    def submit_payment(self):
        """Handle the payment submission."""
        # Validate required fields
        if not all([
            self.name_entry.get(),
            self.address_entry.get(),
            self.card_entry.get(),
            self.payment_type_combobox.get(),
            hasattr(self, 'total_amount')
        ]):
            messagebox.showwarning("Input Error", "Please complete all fields before submitting.")
            return
        
        # Display confirmation message
        messagebox.showinfo("Booking Confirmation", "Booking successful! Thank you for choosing Long Island Travel Agency.")
        
        # Show rating and review section
        self.rating_frame.grid(row=16, column=0, columnspan=2, pady=10, sticky="ew")

if __name__ == "__main__":
    root = tk.Tk()
    
    # Create a custom style for selected stars
    style = ttk.Style()
    style.configure("Selected.TRadiobutton", foreground="gold", font=('Arial', 10, 'bold'))
    
    app = TravelAgencyApp(root)
    root.mainloop()
