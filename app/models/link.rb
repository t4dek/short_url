class Link < ActiveRecord::Base
  validates :given_url, format: { with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}/, message: 'Please provide a valid url' },
                        presence: {  message: 'You should enter URL first' }
  
  CHARSET = (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a.map(&:to_s)).delete_if do |c|
      c =='1' || c =='l' || c =='I' || c =='0' || c =='O'
    end
    
  before_create :_set_uniq_key
  
  def self.uniq_key
    last_key  = Link.last.try(:uniq_key) || '9999'
    prev_combination = last_key.split('').map{|letter| CHARSET.find_index(letter)}
    new_combination = Link.increase prev_combination
    new_combination.map{|n| CHARSET[n]}.join
  end
  
  private 
    def _set_uniq_key
      self.uniq_key = Link.uniq_key
    end
    
    def self.increase combination
      changed = false
      charset_size = CHARSET.count - 1
      combination << charset_size if !combination.any? {|n| n != charset_size}
      new_comb = combination.reverse.map do |n|
        if n == charset_size && !changed
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
