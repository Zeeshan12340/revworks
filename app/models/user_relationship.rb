class UserRelationship < ApplicationRecord
	belongs_to :user
	belongs_to :related_user, class_name: 'User', foreign_key: 'related_user_id'
end
