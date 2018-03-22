class StoresInfoController < ApplicationController
  def input
  end
  
  def name
    require 'open-uri'
    require 'json'
    require 'net/http'
    require 'uri'
 
    uri   = 'https://api.gnavi.co.jp/RestSearchAPI/20171213/'

    format= "json"
    lat = params[:lat]
    lon = params[:lon] 
    range = params[:range]
    @range = range

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
    
    rest_a = Array.new
    
    if @rests
    @rests.map{ |rest|
        # create or update
        @rest = Rest.find_or_initialize_by(id: rest["id"])
        @rest.update_attributes(id: rest["id"], name: rest["name"])
        rest_a << @rest
    }
    end
    
    # @some_rests = rest_a.paginate(:page => params[:page], :per_page => 10)
    
  end
  
  def detail
  end
end
