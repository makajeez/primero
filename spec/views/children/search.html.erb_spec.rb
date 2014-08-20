require 'spec_helper'
require 'hpricot'

include HpricotSearch


describe "children/search.html.erb" do
  describe "rendering search results" do
    before :each do
      @user = double(:user)
      @user.stub(:time_zone).and_return TZInfo::Timezone.get("UTC")
      @user.stub(:localize_date).and_return("some date")
      @user.stub(:has_permission?).and_return(true)
      controller.stub(:current_user).and_return(@user)
      view.stub(:current_user).and_return(@user)
      
      @results = Array.new(4){ |i| random_child_summary("some_id_#{i}") }
      @results.stub :total_entries => 100, :offset => 1, :total_pages => 10, :current_page => 1

      @highlighted_fields = [
        Field.new(:name => "field_2", :display_name => "field display 2", :visible => true ),
        Field.new(:name => "field_4", :display_name => "field display 4", :visible => true ) ]
      FormSection.stub(:sorted_highlighted_fields).and_return @highlighted_fields
      assign(:current_user, @user)
      assign(:results, @results)
    end
    
    # TODO: full text searching not implemented yet
    # it "should render items for each record in the results" do
    #   render
    #   expect(rendered).to have_selector("tr.child_summary_panel", count: @results.length)
    # end

    #TODO this might not be necessary based on the change in the way we're displaying the records
    # We're not highlighting the fields in the same way
    #it "should show only the highlighted fields for a child" do
    #  child = Child.create(
    #  "_id" => "some_id", "created_by" => "dave",
    #  "last_updated_at" => time_now(),
    #  "created_at" => time_now(),
    #  "field_1" => "field 1", "field_2" => "field 2", "field_3" => "field 3", "field_4" => "field 4",
    #  "current_photo_key" => "some-photo-id")
    #  child.stub(:has_one_interviewer?).and_return(true)
    #  child.create_unique_id
    #  @results.clear
    #  @results << child
    #  assign(:results, @results)
    #
    #  render
    #
    #  fields = Hpricot(rendered).search(".summary_panel")
    #  fields.search(".summary_item").size.should == @highlighted_fields.size + 2 #including the registered by and last_updated_by keys
    #
    #  fields.search(".key").first.inner_text.should == "Field Display 2:"
    #  fields.search(".value").first.inner_text.should == "field 2"
    #end

    #TODO We're going to need to put this back in when we do image thumbnails
    #it "should include a column displaying thumbnails for each child if asked" do
    #  assign(:show_thumbnails, true)
    #
    #  render
    #
    #  first_content_row = Hpricot(rendered).photos
    #  first_image_tag = first_content_row.at("img")
    #  raise 'no image tag' if first_image_tag.nil?
    #
    #  child = @results.first
    #  first_image_tag['src'].should == "/cases/#{child.id}/thumbnail/#{child.primary_photo_id}"
    #end

    #it "should show thumbnails with urls for child details page for each child if asked" do
    #  render
    #
    #  first_content_row = Hpricot(rendered).photos
    #  first_href = first_content_row.at("a")
    #  first_href.should_not nil
    #
    #  first_href['href'].should == "/cases/#{@results.first.id}"
    #end

    #TODO We're going to need to put this back in when we do checkboxes
    #it "should include checkboxes to select individual records" do
    #  render
    #
    #  select_check_boxes = Hpricot(rendered).checkboxes
    #  select_check_boxes.length.should == @results.length
    #  select_check_boxes.each_with_index do |check_box,i|
    #    check_box['name'].should == "selections[#{i}]"
    #    check_box['value'].should == @results[i]['_id']
    #  end
    #end
    
    # TODO: full text searching not implemented yet
    # it "should have a button to export to pdf" do
    #   render

    #   export_to_photo_wall = Hpricot(rendered).submit_for("Export Selected to PDF")
    #   export_to_photo_wall.size.should_not == 0
    # end

    # TODO: full text searching not implemented yet
    # it "should have a button to export to photo wall" do
    #   render

    #   export_to_photo_wall = Hpricot(rendered).submit_for("Export Selected to Photo Wall")
    #   export_to_photo_wall.size.should_not == 0
    # end

    def random_child_summary(id = 'some_id')
      child = Child.create("age_is" => "Approx", "created_by" => "dave", "current_photo_key" => "photo-id")
      child.create_unique_id
      child.stub(:has_one_interviewer?).and_return(true)
      child
    end

    def time_now
      Clock.now.strftime("%d %B %Y at %H:%M (%Z)")
    end
  end
end
