require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ListsHelper. For example:
#
# describe ListsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ListsHelper do
  describe '#link_to_lists_page' do
    it 'renders expected html' do
      link_to_lists_page.should == '<a href="/lists">Back</a>'
    end
  end
end
