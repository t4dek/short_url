require 'rails_helper'

RSpec.describe Link, :type => :model do
  subject (:link) { Link.create(given_url: 'http://example.com/foobar') }
  
  it { should be_valid }
  
  it 'has uniq_key after creation' do
    expect(link.uniq_key).to_not be_nil
  end
  
  it 'generates new uniq_key per link' do
    new_link = Link.create(given_url: 'http://example.com/foobaz')
    expect(new_link.uniq_key).not_to eql(link.uniq_key)
  end
  
  it 'add new symbol for uniq_key if all combinations are used' do
    charset = Link::CHARSET
    uniq_key = '99999' #suppose it is the last combination in given CHARSET in Link model 
    combination = uniq_key.split('').map{|letter| charset.find_index(letter)} # => [61, 61, 61, 61, 61]
    expect((Link.increase combination).size).to be > uniq_key.split('').size
  end
end
