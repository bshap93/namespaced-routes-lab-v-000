class Admin::PreferencesController < ApplicationController
  def index
    @preference = Preference.first_or_create
  end
end
