require "rails_helper"

feature "movie management" do
	scenario "logged in user can book a show" do
		user = User.create(username: "Sideshow Bob", password: "railsWAT")

		visit root_path
		click_on "Book Show"
		expect(current_path).to eq root_path
		expect(page).to have_content "Please log in to book that show"

		click_on "Sign In"

		fill_in "Username", with: "Sideshow Bob"
		fill_in "Password", with: "railsWAT"

		click_on "Sign In"
		expect(page).to have_content "Thanks for signing in!"

		visit root_path
    click_on "Add New Band"
    expect(current_path).to eq(new_band_path)

    fill_in "Name", with: "The Rails Incident"
    click_on "Create Band"

    expect(page).to have_content("The Rails Incident Successfully Added")
		expect(current_path).to eq band_path(Band.last)

    click_on "Edit Band"
		expect(current_path).to eq edit_band_path(Band.last)

		fill_in "Name", with: "The jQuery Incident"

		click_on "Update Band"

    expect(page).to have_content("The jQuery Incident Successfully Updated")
		expect(page).to_not have_content("The Rails Incident")
		expect(current_path).to eq(band_path(Band.last))




		click_on "All Show Times"
		expect(current_path).to eq(show_times_path)
		expect(page).to have_content("The Empire Strikes Back: Showing 9:10PM 10:10PM")
		expect(page).to have_content("The Last of the Mohicans: Showing 12:10PM")

		click_on "The Empire Strikes Back"
		expect(current_path).to eq(movie_path(movie))
		expect(page).to have_content("The Empire Strikes Back")
		expect(page).to have_content("Today's Show Times: 9:10PM 10:10PM")

		click_on "Buy Ticket"
		expect(current_path).to eq(new_movie_ticket_path(movie))

		select "9:10PM", from: "Show Times"
		fill_in "Quantity", with: "1"

		click_on "Purchase"
		expect(current_path).to eq(movie_ticket_path(movie, Ticket.last))
		expect(page).to have_content("1 Ticket for The Empire Strikes Back at 9:10PM")

		visit root_path
		click_on "All Show Times"
		expect(current_path).to eq(show_times_path)
		expect(page).to have_content("The Last of the Mohicans: Showing 12:10PM")

		click_on "The Last of the Mohicans"
		expect(current_path).to eq(movie_path(movie2))
		expect(page).to have_content("The Last of the Mohicans")
		expect(page).to have_content("Today's Show Times: 12:10PM")

		click_on "Buy Ticket"
		expect(current_path).to eq(new_movie_ticket_path(movie2))

		select "12:10PM", from: "Show Times"
		fill_in "Quantity", with: "2"

		click_on "Purchase"
		expect(current_path).to eq(movie_ticket_path(movie2, Ticket.last))
		expect(page).to have_content("2 Tickets for The Last of the Mohicans at 9:10PM")

		visit root_path
		click_on "My Movies"
		expect(current_path).to eq user_path(User.last)

		expect(page).to have_content("You have seen: The Empire Strikes Back, The Last of the Mohicans")
	end
end
