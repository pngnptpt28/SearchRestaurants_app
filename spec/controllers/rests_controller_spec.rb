require 'rails_helper'

describe RestsController, type: :controller do


    describe 'GET #search' do
        before do
            get :search
        end
        it "render the :search template" do
            expect(response).to render_template :search
        end
    end

    describe 'GET #show' do
        before do
            rest = create(:rest)
            get :show, params: { id: rest.id }
        end
        it "render the :show (rest to @rest) template" do
            expect(response).to render_template :show
        end
    end


    describe 'Use Function : measures_one_search' do
        before do
            @value_a = Array.new([{"num"=>"1", "color"=>"red"}])
            @value_h = Hash.new
            @value_h = {"num"=>"1", "color"=>"red"}
        end
        context 'argument type is Array' do
            it "Return value is array" do
                type = RestsController.new
                expect(type.send(:measures_one_search, @value_a)).to eq @value_a
            end
        end
        context 'argument type is Hash' do
            it "Return value is array" do
                type = RestsController.new
                expect(type.send(:measures_one_search, @value_h)).to eq @value_a
            end
        end

    end

    describe 'Use Function : reate_rest_DB' do
        before do
            @rest_data = Array.new([{"id"=>"t1", "name"=>"{}", "access"=>{"station"=>"{}", "walk"=>"{}"},
                                    "image_url"=>{"shop_image1"=>"{}", "shop_image2"=>"{}"},
                                    "address"=>"{}", "tel"=>"{}", "opentime"=>"{}"},
                                    {"id"=>"t2", "name"=>"{}", "access"=>{"station"=>"{}", "walk"=>"{}"},
                                    "image_url"=>{"shop_image1"=>"{}", "shop_image2"=>"{}"},
                                    "address"=>"{}", "tel"=>"{}", "opentime"=>"{}"}])
        end
        describe 'create or update DB' do
            context 'new db' do
               it "create correct data" do
                    rest = RestsController.new
                    rests = rest.send(:create_rest_DB, @rest_data)
                    expect((Rest.find("t1")).valid?).to eq true
                    expect((Rest.find("t2")).valid?).to eq true
                end
                it "create all data" do
                    rest = RestsController.new
                    rests = rest.send(:create_rest_DB, @rest_data)
                    expect(rests.length).to eq 2
                end
            end
            context 'already exist db' do
                before do
                    # @rest_data[1]["id"] = "t1"
                end
                it "correct DB is update" do
                    # rest = RestsController.new
                    # rests = rest.send(:create_rest_DB, @rest_data)
                    # p "---------------length", (rests.length)
                end
            end
        end

        describe 'return value' do
            it "is correct" do
                rest = RestsController.new
                expect(rest.send(:create_rest_DB, @rest_data)).to eq [@rest_data[0]["id"], @rest_data[1]["id"]]
            end
        end
    end

    

end