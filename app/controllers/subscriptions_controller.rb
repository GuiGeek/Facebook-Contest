class SubscriptionsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "password", only: [:index, :subscriptionsToCsv]
  
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
	
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  #Export DATA in CSV format
  def subscriptionsToCsv
    @subscriptions = Subscription.all
    
    require 'csv'
    
    csv_data = CSV.generate :col_sep => "," do |csv|
      #header
      csv << ["title","firstname", "lastname", "email","city","telephone","newsletter"]
      @subscriptions.each do |subscription| 
        csv << [subscription.title, subscription.firstname, subscription.lastname, subscription.email, subscription.city, subscription.telephone, subscription.newsletter]
      end
    end
    
    send_data csv_data, :type => "text/csv", :disposition => 'attachment'
  end
  
  # GET /subscriptions/thanks
  def thanks
    @subscription = Subscription.find(params[:id])
	
    respond_to do |format|
      format.html # thanks.html.erb
    end
  end
  
  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/liked
  def liked
    #Get FB http parameters
    #Parse it with Canvas rb class
    begin
      @decoded_request = Canvas.parse_signed_request("YOUR APP SECRET",params[:signed_request])
      @liked = @decoded_request['page']['liked'] #Store if page is liked by the user
    rescue
      @liked = false
      @alert = "ERROR : You don't connect to facebook. Set up AppID & App Secret"
    end
    
    respond_to do |format|
      #If user like the page
      if @liked
        format.html { redirect_to '/subscriptions/new' } #Access to register form
      else
        format.html #Else go to liked page
      end
    end
  end
  
  # GET /subscriptions/closed
  def closed
    respond_to do |format|
      format.html # closed.html.erb
    end
  end
  
  # GET /subscriptions/new
  # GET /subscriptions/new.json
  def new
    @subscription = Subscription.new
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subscription }
    end
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.find(params[:id])
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(params[:subscription])

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to thanks_url(:id => @subscription) }
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.html { render action: "new" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])

    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end
end
