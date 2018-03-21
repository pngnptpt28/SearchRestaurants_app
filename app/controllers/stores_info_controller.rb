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
    # lat   = 35.670083
    # lon   = 139.763267
    lat = params[:lat]
    lon = params[:lon] 
    range = params[:range]
    # range = 5
    @range = range

    # ハッシュをパラメーターにする関数
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

    url =  uri + to_params({'format'=>format, 'keyid'=>ENV["GNAVI_ACC_KEY"], 'latitude'=>lat, 'longitude'=>lon, 'range'=>range})
    json = Net::HTTP.get(URI.parse(url))

    @rests = JSON.parse(json)["rest"]

    # # map : 各要素に同じ挙動させる
    # rests.map{ |rest|
    #   @rest = rest
    # }

    # @rest1 = JSON.parse(json)["rest"].first
  end
  
  def detail
  end
end
