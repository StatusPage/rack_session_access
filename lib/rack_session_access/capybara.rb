module RackSessionAccess
  module Capybara
    def set_rack_session(hash, host_with_port=nil)
      data = ::RackSessionAccess.encode(hash)

      visit "#{host_with_port}#{::RackSessionAccess.edit_path}"
      has_content?("Update rack session")
      fill_in "data", :with => data
      click_button "Update"
      has_content?("Rack session data")
    end

    def get_rack_session(host_with_port=nil)
      visit "#{host_with_port}#{::RackSessionAccess.edit_path}.raw"
      has_content?("Raw rack session data")
      raw_data = find(:xpath, '//body/pre').text
      ::RackSessionAccess.decode(raw_data)
    end

    def get_rack_session_key(key)
      get_rack_session.fetch(key)
    end
  end
end

require 'capybara/session'
Capybara::Session.send :include, RackSessionAccess::Capybara
