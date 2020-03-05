require 'sinatra'
#require 'sinatra/json'
#require 'sinatra/reloader'
require 'pry'
require 'json'
require './lib/webhook'
require './lib/target_branch'
configure do
  set :server, :puma
end

before do
  content_type :json
end

get '/' do
  { message: 'server is up' }.to_json
end

post '/webhook' do
  begin
    target_branch = TargetBranch.new(payload['pullrequest'])
    return if target_branch.send_message_for_master_only && !target_branch.master?

    Webhook.new(action, payload).call
    { staus: 200 }.to_json
  end
end

def action
  env['HTTP_X_EVENT_KEY']
end

def payload
  JSON.parse request.body.read
end

def message_only_for_master
  true
end


