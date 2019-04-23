# app.rb

require 'sinatra'

require_relative 'models/models.rb'

class App < Sinatra::Base

    

    # Home
    # Should have field to quickly create a thing
    # Should list all things by due date
    # Should allow thing completion
    # Should allow thing editing
    # Should allow thing deletionr
    get '/' do
        # Count of tasks with no due date, no category
        @inbox_count = Thing.where(created_at: Date.today).count
        # Things for today
        @things = Thing.order(:created_at).all()
        erb :index, :layout => :template
    end

    # Quick Create thing
    post '/quick-create' do
        task_string = params["task"]
        thing = Thing.new(
            created_at: Date.today,
            title: task_string
        )
        thing.save
        redirect to("/")
    end

    # Create thing
    post '/create' do 
    end

    # Edit thing
    post '/task/:id' do |i|
        # Check if title is empty!
        @task = Thing.where(id: i).update(
            :title  => params["title"],
            :note   => params["note"],
            :category   => params["category"],
            :due_on => Date.parse(params["due_on"]),
            :completed  => params["isCompleted"] == "on" ? true : false
        )
        redirect to("/")
    end

    # Edit view thing
    get '/task/:id' do |i|
        # Count of tasks with no due date, no category
        @inbox_count = Thing.where(created_at: Date.today).count
        # Get the main task
        @task = Thing.where(id: i).first
        erb :task, :layout => :template
    end

    # Delete thing
    get '/delete/:id' do |i|
        Thing.where(id: i).delete
        redirect to("/")
    end

    # Complete thing
    post '/complete/:id' do |i|
        Thing.where(id: i).update(:completed => true, :completed_at => DateTime.new)
        redirect to("/")
    end

    # Un-Complete thing
    post '/uncomplete/:id' do |i|
        Thing.where(id: i).update(:completed => false, :completed_at => nil)
        redirect to("/")
    end

end