class Visitor < ActiveRecord::Base
  validate :email, presence: true
end
