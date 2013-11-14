class Subscription < ActiveRecord::Base

	attr_accessible :title, :firstname, :lastname, :email, :city, :telephone, :newsletter
 
	validates :title,  :presence => true
	validates :firstname,  :presence => true
	validates :lastname,  :presence => true
	validates :email,  :presence => true,
				:uniqueness => true,
				:format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	validates :telephone,  :presence => true
    validates :terms, :acceptance => { :accept => 'yes' }
	
	#validate :oneSubscriptionByDay?
	
	#Add one subscription per day instead uniqueness email
	def oneSubscriptionPerDay?
		@subscription = Subscription.where(:email => email, created_at => Date.today.to_s)
		
		if @subscription
			errors.add(:email, "One subscription by day"+@subscription.to_s+Date.today.to_s)
		end
	end
	
	def self.total_by_day(date)
      where("date(created_at) = ?",date).count()
    end
  
end
