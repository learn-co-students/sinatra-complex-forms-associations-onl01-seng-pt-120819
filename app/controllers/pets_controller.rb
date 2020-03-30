class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @pets = Pet.all
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    pet = Pet.create(name: params[:pet_name])
    if !params[:owner][:name].empty?
      owner = Owner.new(name: params[:owner][:name])
      owner.pets << pet
      owner.save
    else
      owner = Owner.find(params[:pet][:owner_id])
      owner.first.pets << pet
    end
    #binding.pry
    redirect to "/pets/#{pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    #binding.pry
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet_name]
    #binding.pry
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    else
      @pet.owner = Owner.find(params[:pet][:owner_id]).first
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
