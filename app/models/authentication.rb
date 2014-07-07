class Authentication < ActiveRecord::Base
	belongs_to :user

	def Authentication.find_by_provider_and_uid(provider,id)

			u = self.find_by({provider: provider, uid: id})
			return u
	end
end
