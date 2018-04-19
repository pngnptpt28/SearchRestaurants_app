class RestsController < ApplicationController
  
  def search
    
  end
  
  def create
    require 'open-uri'
    require 'json'
    require 'net/http'
    require 'uri'
    
    uri   = 'https://api.gnavi.co.jp/RestSearchAPI/20171213/'
    format = "json"
    @rests_id = Array.new
    @_rests_json = Array.new
    # from form value
    lat = params[:include_lat]
    lon = params[:include_lon]
    range = params[:range]

    # to json & save 
    url =  uri + to_params({'format'=>format, 'keyid'=>ENV["GNAVI_ACC_KEY"], 'latitude'=>lat, 'longitude'=>lon, 'range'=>range, 'hit_per_page'=>100})
    json = Net::HTTP.get(URI.parse(url))
    rests_json = JSON.parse(json)["rest"]

    if (rests_json)
      # Measures when search store is one
      @_rests_json = measures_one_search(rests_json)
      # DB create or update & Pass each ID to array
      @rests_id = create_rest_DB(@_rests_json)

      # Save value(@rests_id)
      session[:rests_id] = @rests_id
      redirect_to :action => "index"
    else
        flash[:notice] = "該当する店鋪がありませんでした"
        redirect_to :action => "search"
    end

  end

  def index
    # Get value(@rest_id) & find data from DB(Rest)
    @_rests_id = session[:rests_id]
    @rests = Rest.find(@_rests_id)
    
    # paging(10 on each page)
    @some_rests = Kaminari.paginate_array(@rests).page(params[:page]).per(10)

    p "---------range:"
    
  end
  
  def show
    @rest = Rest.find(params[:id])
    @url = request.url
  end


  private

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

  # function : Measures when search store is one
  # if search sotore is only one, json change Hash -> array
  def measures_one_search(rests)
    _rests = Array.new

    if rests.instance_of?(Array)
      _rests = (rests)        # As it is (Array)
    else
      _rests[0] = (rests)     # Array <- Hash
    end
    return _rests

  end

  
  # function : DB create or update
  def create_rest_DB(rests)
    id = Array.new

    rests.each{ |rest|
      @rest = Rest.find_or_initialize_by(id: rest["id"])
      @rest.update_attributes(id: rest["id"], name: rest["name"], station: rest["access"]["station"], 
                              walk: rest["access"]["walk"], shop_image1: rest["image_url"]["shop_image1"], 
                              shop_image2: rest["image_url"]["shop_image2"], address: rest["address"],
                              tel: rest["tel"], opentime: rest["opentime"])
      # Pass each ID to array
      id << rest["id"]
    }
    return id

  end

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

end