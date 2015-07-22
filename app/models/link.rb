class Link < ActiveRecord::Base
  validates_format_of :given_url, with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}/
  
  CHARSET = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a.map(&:to_s)
    
  before_create :_set_uniq_key
  
  def self.uniq_key
    last_key  = Link.last.try(:uniq_key) || 'aaaaa'
    prev_combination = last_key.split('').map{|letter| CHARSET.find_index(letter)}
    new_combination = Link.increase prev_combination
    new_combination = new_combination + [0] if new_combination == prev_combination
    new_combination.map{|n| CHARSET[n]}.join
  end
  
  private 
    def _set_uniq_key
      self.uniq_key = Link.uniq_key
    end
    
    def self.increase combination
      changed = false
      new_comb = combination.reverse.map do |n|
        if n == CHARSET.count - 1
          0
        elsif changed
          n
        else
          changed = true
          n + 1
        end
      end
      new_comb.reverse
    end
end
