class RestsController < ApplicationController
  def search
    
  end
  
  def create
    require 'open-uri'
    require 'json'
    require 'net/http'
    require 'uri'
 
    uri   = 'https://api.gnavi.co.jp/RestSearchAPI/20171213/'

    format= "json"
    lat = params[:lat]
    lon = params[:lon] 
    range = params[:range]
    # @range = range

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
    json = Net::HTTP.get(URI.parse(url))
    
    @rests = JSON.parse(json)["rest"]
    
    @rests_id = Array.new
    
    if @rests
      @rests.map{ |rest|
        # create or update
        @rest = Rest.find_or_initialize_by(id: rest["id"])
        @rest.update_attributes(id: rest["id"], name: rest["name"])
        p "------------------------------@rest id name(in create) =", @rest["id"], @rest["name"]   #debug
        @rests_id << @rest["id"]
      }
      # p "------------------------------@rests_id (in create) =", @rests_id   #debug
      
      # Save value(@rests_id)
      session[:rests_id] = @rests_id
      
      redirect_to :action => "index"
      
    else
      # redirect_to :action => "create"
    end
  end
  
  def index
    # Get value(@rest_a)
    @_rests_id = session[:rests_id]
    
    # paging(10 on each page)
    @some_rests = Kaminari.paginate_array(@_rests_id).page(params[:page]).per(10)
    
    # p "------------------------------@_rests_id (in index) =", @_rests_id   #debug
    # p "------------------------------@some_rests(in index) =", @some_rests   #debug
  end
  
  def show
    @rest = Rest.find(params[:id])
  end
  
end