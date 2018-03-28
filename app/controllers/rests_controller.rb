class RestsController < ApplicationController
  
  def search
    
  end

  
  def create

    session[:rests_id] = @rests_id

    require 'open-uri'
    require 'json'
    require 'net/http'
    require 'uri'
    require 'parallel'
    
    @start_time_ALL = Time.now                  # debug
    
      uri   = 'https://api.gnavi.co.jp/RestSearchAPI/20171213/'

      format= "json"
      lat = params[:lat]
      lon = params[:lon] 
      range = params[:range]
    
      # function : hash->paramater
      def to_params(params_h)
        params = ""
        params_h.each_with_index { |(k, v), i|
          if i == 0 then
            params = params + "?"+ k.to_s + "=" + v.to_s
          else
            params = params + "&"+ k.to_s + "=" + v.to_s
          end
        }
        return params
      end

      # to json
      url =  uri + to_params({'format'=>format, 'keyid'=>ENV["GNAVI_ACC_KEY"], 'latitude'=>lat, 'longitude'=>lon, 'range'=>range, 'hit_per_page'=>100})
    
      @start_time_API = Time.now                # debug
      json = Net::HTTP.get(URI.parse(url))
      # processing time(API)
      @time_API = Time.now - @start_time_API    # debug
      
      @rests_json = JSON.parse(json)["rest"]
      
      @rests_id = Array.new
    
      
      if @rests_json
        @start_time_DB = Time.now               # debug
        
        # DB create or update(N+1)
        p "---------------------------------N+1"
        @rests_json.each{ |rest|
          # DB create or update
          @rest = Rest.find_or_initialize_by(id: rest["id"])
          @rest.update_attributes(id: rest["id"], name: rest["name"], station: rest["access"]["station"], 
                                  walk: rest["access"]["walk"], shop_image1: rest["image_url"]["shop_image1"], 
                                  shop_image2: rest["image_url"]["shop_image2"], address: rest["address"],
                                  tel: rest["tel"], opentime: rest["opentime"])
          # Pass each ID to array
          @rests_id << rest["id"]
        }
        p "---------------------------------rests_id:", @rests_id

        
        # DB create or update(fix)
        # @select_rests = Rest.find_or_initialize_by(id:@rests_id)
        # p "---------------------------------select_rests:", @select_rests
        # @select_rests.each{ |select_rest|
        #   @rests_json.each{ |rest_json|
        #     if @select_rest["id"] == @rest_json["id"]
        #       select_rest.update_attributes(name: rest_json["name"], station: rest_json["access"]["station"], 
        #                                     walk: rest_json["access"]["walk"], shop_image1: rest_json["image_url"]["shop_image1"], 
        #                                     shop_image2: rest_json["image_url"]["shop_image2"], address: rest_json["address"],
        #                                     tel: rest_json["tel"], opentime: rest_json["opentime"])
        #     end
        #   }
        # }
        
        # processing time(DB)
        @time_DB = Time.now - @start_time_DB     # debug

        # Save value(@rests_id)
        session[:rests_id] = @rests_id
        puts "redirect!!"
        redirect_to :action => "index"
      
      else
        # redirect_to :action => "create"
      end
    @time_ALL = Time.now - @start_time_ALL       # debug
    p "処理時間", "DB: #{@time_DB}s","API: #{@time_API}s", "ALL: #{@time_ALL}s"     # debug
  end

  
  def index
    # Get value(@rest_a) & find data from DB(Resr)
    @_results = session[:results] 
    @_rests_id = session[:rests_id]

    @rests = Rest.find(@_rests_id)
    
    # paging(10 on each page)
    @some_rests = Kaminari.paginate_array(@rests).page(params[:page]).per(10)    
    
  end
  
  def show
    @rest = Rest.find(params[:id])
  end
  
end