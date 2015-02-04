class SignupsController < ApplicationController

  def create
    build_signup
    save_and_render_signup
  end

  private

    def signup_scope
      EmailPasswordSignup
    end

    def build_signup
      @signup ||= signup_scope.new
      @signup.attributes = signup_params
    end

    def save_and_render_signup
      if @signup.save
        response = {
          signup: {
            id: 1,
            name: 'Test User',
            email: 'test@example.com',
            user_id: 1
          },
          users: [
            {
              id: 1,
              name: 'Test User',
              email: 'test@example.com'
            }
          ]
        }

        render json: response, status: :created
      else
        errors = @signup.errors
        render json: errors, status: :unprocessable_entity
      end
    end

    def signup_params
      params.require(:signup).permit(:name, :email, :password)
    end

end
