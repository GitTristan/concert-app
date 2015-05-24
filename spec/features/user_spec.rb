require "rails_helper"

feature "as a user" do
	scenario "a user can sign up, sign out, and sign back in" do
		visit root_path
		expect(page).to have_link "Sign In"
		expect(page).to_not have_link "Sign Out"
		expect(page).to_not have_content "Logged in as drippy hippy"
		expect(page).to_not have_content "Thanks for signing up! have fun at the show!"

		click_on "Sign Up"
		expect(current_path).to eq(sign_up_path)

		fill_in "Username", with: "drippy hippy"
		fill_in "Password", with: "password"

		click_button "Sign Up"
		expect(current_path).to eq(root_path)

		expect(page).to have_content "Thanks for signing up! have fun at the show!"
		expect(page).to have_content "Logged in as drippy hippy"
		expect(page).to_not have_link "Sign In"
		expect(page).to_not have_link "Sign Up"

		visit current_path
		expect(page).to have_content "Logged in as drippy hippy"
		expect(page).to_not have_content "Thanks for signing up! have fun at the show!"

		click_on "Sign Out"

		expect(page).to have_content "Signed out!"
		expect(page).to_not have_content "Logged in as drippy hippy"

		click_on "Sign In"

		fill_in "Username", with: "drippy hippy"
		fill_in "Password", with: "password"

		click_button "Sign In"
		expect(current_path).to eq root_path
		expect(page).to have_content "Thanks for signing in! Welcome back!"
		expect(page).to have_content "Logged in as drippy hippy"
		expect(page).to_not have_link "Sign In"
		expect(page).to_not have_link "Sign Up"

		visit current_path
		expect(page).to have_content "Logged in as drippy hippy"
		expect(page).to_not have_content "Thanks for signing in! Welcome back!"
	end
end
