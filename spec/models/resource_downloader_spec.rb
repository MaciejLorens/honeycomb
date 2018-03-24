require 'spec_helper'
require 'rails_helper'

describe ResourceDownloader do

  context '#download' do
    it 'should download a Resource by class method' do
      expect {
        ResourceDownloader.download
      }.to change { Resource.count }.by(2)
    end

    it 'should download a Resource by instance method' do
      expect {
        ResourceDownloader.new.download
      }.to change { Resource.count }.by(2)
    end

    it 'should download only not existing Resources' do
      subject.download
      expect(Resource.count).to eq(2)

      Resource.first.destroy
      expect(Resource.count).to eq(1)

      expect {
        subject.download
      }.to change { Resource.count }.by(1)

      expect(Resource.count).to eq(2)
    end
  end
end
