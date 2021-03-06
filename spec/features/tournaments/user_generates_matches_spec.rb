require "rails_helper"
require "support/features/clearance_helpers"

feature "User generates matches" do
  let(:user) { create(:user) }
  let(:player1) { create(:user) }
  let(:player2) { create(:user) }
  let(:player3) { create(:user) }
  let(:tournament) { create(:tournament, owner: user) }

  scenario "with less then 2 players registered" do
    create(:registration, player: player1, tournament: tournament)
    visit tournament_path(tournament, as: user)

    expect(page).to_not have_link("Generate Matches")
  end

  scenario "with 2 players registered" do
    create(:registration, player: player1, tournament: tournament)
    create(:registration, player: player2, tournament: tournament)
    visit tournament_path(tournament, as: user)

    click_link "Generate Matches"
    expect(page).to have_content(player1.email)
    expect(page).to have_content(player2.email)
    expect(page).to have_content("Regenerate Matches")
  end

  scenario "with 3 players registered" do
    create(:registration, player: player1, tournament: tournament)
    create(:registration, player: player2, tournament: tournament)
    create(:registration, player: player3, tournament: tournament)
    visit tournament_path(tournament, as: user)

    click_link "Generate Matches"
    expect(page).to have_content(player1.email)
    expect(page).to have_content(player2.email)
    expect(page).to have_content(player3.email)
    expect(page).to have_content("Regenerate Matches")
  end
end
