class Api::V1::BaseController < ApplicationController
  before_action :authenticate_api_user!
end
