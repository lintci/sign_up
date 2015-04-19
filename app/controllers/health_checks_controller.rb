# Heart beat endpoint
class HealthChecksController < ApplicationController
  def index
    render text: 'up', status: 200, layout: false
  end
end
