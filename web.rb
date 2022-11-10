require 'sinatra'

get '/' do
  erb :index
end

get '/:nombre' do |n|
  erb :cliente, :locals => {:nombre => n}
end

post '/:nombre' do |n|
  erb :nuevo_cliente, :locals => {:nombre => n}
end