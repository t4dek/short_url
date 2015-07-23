require 'rails_helper'

RSpec.describe Link, :type => :model do
  subject (:link) { create(:link) }
  
  it { should be_valid }
  
  it 'has uniq_key after creation' do
    expect(link.uniq_key).to_not be_nil
  end
  
  it 'has right shortened link' do
    expect(link.shortened_link).to eq(ENV['BASE_URL'] + '/' + link.uniq_key)
  end
  
  it 'generates new uniq_key per link' do
    new_link = create(:link)
    expect(new_link.uniq_key).not_to eql(link.uniq_key)
  end
  
  it 'add new symbol for uniq_key if all combinations are used' do
    charset = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a.map(&:to_s)
    uniq_key = '99999' #suppose it is the last combination in given CHARSET in Link model 
    combination = uniq_key.split('').map{|letter| charset.find_index(letter)} # => [61, 61, 61, 61, 61]
    expect((Link.increase combination).size).to be > uniq_key.split('').size
  end
end
