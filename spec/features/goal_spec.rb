require "rails_helper"

  feature "Goals CRUD" do
    user = FactoryGirl.create(:user)
    before :each do
      sign_up(user)
      make_goal("Test Goal", "Test Goal Body")
    end

    scenario "create a new goal" do
      click_button "New Goal"
      fill_in "Title", with: "Goal #1"
      fill_in "Body", with: "Finish App Academy!"
      click_button "Save"

      expect(page).to have_content "Goal #1"
    end

    scenario "view a goal" do
      visit user_url(user)
      click_link "Test Goal"

      expect(page).to have_content "Test Goal Body"
    end

    scenario "edit a goal" do
      click_link "Test Goal"
      click_link "Edit"
      fill_in "Body", with: "This goal has been edited"
      click_button "Save"

      expect(page).to have_content "This goal has been edited"
    end

    scenario "delete a goal" do
      click_link "Test Goal"
      click_link "Delete"

      expect(page).not_to have_content "Test Goal"
    end
end

feature "Goals Visibility" do

  before :each do
    user = FactoryGirl.create(:user)
    sign_up(user)
    goal = make_goal("Public Goal", "Public Goal Body")
    goal = make_goal("Private Goal", "Private Goal Body", false)
  end

  scenario 'Private goals should not be visible to non-creator' do
    user2 = FactoryGirl.create(:user)
    sign_up(user2)

    expect(page).not_to have_content("Private Goal")
    expect(page).to have_content("Public Goal")
  end

  scenario 'User can see own private goals' do

    expect(page).to have_content("Private Goal")
    expect(page).to have_content("Public Goal")
  end
end
