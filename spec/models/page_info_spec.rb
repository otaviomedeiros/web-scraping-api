require 'rails_helper'

RSpec.describe PageInfo do

  describe '.cache_key(link)' do
    [
      'https://12factor.net',
      'http://12factor.net',
      'https://www.12factor.net',
      'https://www.12factor.net',
      'www.12factor.net'
    ].each do |url|
      it { expect(PageInfo.cache_key(url)).to eq('12factor.net') }
    end
  end

  describe '#to_json' do
    let(:page_info) do
      PageInfo.new(title: 'title', description: 'description', image: 'http://mydomain.com/image.png')
    end

    context 'when duration is blank' do
      it { expect(page_info.to_json).to eq({ title: 'title', description: 'description', image: 'http://mydomain.com/image.png' }) }
    end

    context 'when duration is not blank' do
      before { page_info.duration = '12M10S'}
      it { expect(page_info.to_json).to eq({ title: 'title', description: 'description', image: 'http://mydomain.com/image.png', duration: '12M10S' }) }
    end
  end
end
