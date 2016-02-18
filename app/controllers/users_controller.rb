class UsersController < ApplicationController
  def index
  	@users = User.all
  	@user  = User.new
  end

  def create
  	@user=User.new (users_params)

  	respond_to do |format| 
 		if @user.save
  			format.html {redirect_to @user,notice:"User Created"}
  			format.js {}
  			format.json {render json:@user,status: :created,location: @user}
 	 	else
 	 		format.html {redirect_to users_url}
 	 		format.json {render json:@user.errors,status: :nprocessable_entity}
  		end
  	end

  end

  def destroy
  	@user=User.find(params[:id])

  	respond_to do |format|
  		if @user.destroy
  			format.html {redirect_to users_url}
  			format.json {head:no_content}
  			format.js   {render :layout=>false}
  		end
  	end	
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.js
     #format.json {render json:@user}
    end
  end


  def update
    @user=User.find(params[:id])
    @user.update_attributes(users_params)
    respond_to do |format|
      format.js
    end 
  end

  private
  	def users_params
  		params.require(:user).permit(:name,:email)
  	end
end
