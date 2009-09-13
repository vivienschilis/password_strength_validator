# PasswordStrengthValidator

module PasswordStrengthValidator

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    
    def acts_as_strengthful
        send :include, InstanceMethods
        validate :is_strengthful?
        # def validate_password_strength
        #   validate do
        #      strength = PasswordStrengthMeter::evaluate_strength(@username, @password)
        #      case strength
        #      when BAD_PASSWORD
        #        return false
        #      else
        #        return true
        #      end
        #    end
        # end
    end
    
    module InstanceMethods
      
      BAD_PASSWORD = 0
      GOOD_PASSWORD = 1
      STRONG_PASSWORD = 2
      
       def testmethod
         puts "test"
       end
       
       def is_strengthful?
         strength = evaluate_strength(self.username, self.password)
         
         case strength
         when BAD_PASSWORD
           errors.add(:stengthfulness, "This is a bad password")
           puts "BAD"
           return false
         else
           puts "OK"
           return true
         end
         
       end
       
       def evaluate_strength (username, password)
         score = evaluate_score(username.to_s, password.to_s)
         puts "score: " + score.to_s

         case score
         when 0..33
           return BAD_PASSWORD
         when 34..67
           return GOOD_PASSWORD
         when 68..100
           return STRONG_PASSWORD
         else
           return BAD_PASSWORD
         end
       end

       def evaluate_score(username, password)
         score = 0
         return BAD_PASSWORD if password.include?(username)
         return BAD_PASSWORD if username.include?(password)
         return BAD_PASSWORD if password.size <= 4

         score += password.size * 4

         score -= password.repeated_chars(1)
         score -= password.repeated_chars(2)
         score -= password.repeated_chars(3)
         score -= password.repeated_chars(4)

         score += 5 if password.has_numbers? == 3
         score += 5 if password.has_special_chars? == 2
         score += 10 if password.has_up_down_case?
         score += 15 if password.has_numbers? and password.has_chars?
         score += 15 if password.has_chars? and password.has_special_chars?
         score += 15 if password.has_special_chars? and password.has_numbers?

         score -= 10 if password.has_only_numbers?
         score -= 10 if password.has_only_chars?

         if score > 100 
           100
         else
           score
         end
       end
       
    end
  end
end