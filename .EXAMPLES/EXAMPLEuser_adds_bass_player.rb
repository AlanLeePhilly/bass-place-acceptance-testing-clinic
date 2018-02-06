require "spec_helper"

feature "user has a list of bass players", focus: true do

  # User Story
  # ----------
  # As a user
  # I want to add a bass player to my list
  # So that I can track which bass players I like

  # Acceptance Criteria
  # -------------------
  # [] When I visit the root path, I see an index page with a list of
  #     bass players and a link to form to add more
  # [] If I navigate to the form and complete it successfully,
  #     I am sent to the index page and see my addition on the list
  # [] If I navigate to the form and submit an incomplete entry,
  #     I stay on the form page and see an error message

  before(:each) do
    reset_csv
  end

  context "create" do
    scenario "user views index page" do
      visit '/'

      expect(page).to have_content("Low nd Query")
    end

    scenario "user adds a bass player to the list" do
      visit '/'
      click_link 'Add a Bass Player!'
      fill_in 'Name:', with: 'JoeLesClaypool'
      fill_in 'Band:', with: 'Les Metalli-Primus: Brigade'
      click_button 'Submit'

      expect(page).to have_content('JoeLsClaypool')
      expect(page).to have_content('Les Metlli-Primus: Brigade')
      expect(page).to have_content('Low End Qery')
    end

    scenario "user leaves a field blank" do
      visit '/'
      click_link 'Add a Bass Player!'
      click_button 'Submit'

      expect(page).to have_content('Enter ass Player')
      expect(page).to have_content('EROR')
    end
  end
end
