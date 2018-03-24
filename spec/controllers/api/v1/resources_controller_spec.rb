require 'spec_helper'
require 'rails_helper'

describe Api::V1::ResourcesController do
  render_views

  context '#show' do
    before { @resource = create(:resource) }

    it 'should return resource object' do
      get :show, params: {id: @resource.id}, format: :json

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body['id']).to eq(@resource.id)
      expect(body['supplier_name']).to eq(@resource.supplier_name)
      expect(body['title']).to eq(@resource.title)
      expect(body['duration']).to eq(@resource.duration)
      expect(body['delivery_date']).to be_nil
    end

    context 'check history' do
      let!(:old_title) { @resource.title }
      let!(:old_duration) { @resource.duration }
      let!(:old_delivery_date) { @resource.delivery_date }
      let!(:old_supplier_name) { @resource.supplier_name }

      before do
        @resource.update(title: 'new_title')
        @resource.update(duration: '00:21:54:43', delivery_date: '2016-11-23')
        @resource.update(supplier_name: 'new_supplier_name')
      end

      it 'should return resource history' do
        get :show, params: {id: @resource.id}, format: :json

        expect(response.status).to eq(200)
        history = JSON.parse(response.body)['history']

        expect(history[0]['changed_fields'].keys).to include('delivery_id', 'resolution', 'supplier_name', 'duration')
        expect(history[1]['changed_fields'].keys).to eq(['title'])
        expect(history[2]['changed_fields'].keys).to eq(['delivery_date', 'duration'])
        expect(history[3]['changed_fields'].keys).to eq(['supplier_name'])

        expect(history[1]['changed_fields']['title']).to eq([old_title, 'new_title'])
        expect(history[2]['changed_fields']['delivery_date']).to eq([old_delivery_date, '2016-11-23'])
        expect(history[2]['changed_fields']['duration']).to eq([old_duration, '00:21:54:43'])
        expect(history[3]['changed_fields']['supplier_name']).to eq([old_supplier_name, 'new_supplier_name'])
      end
    end

  end

  context '#index' do
    before do
      @resource1 = create(:resource)
      @resource2 = create(:resource)
    end

    it 'should return array of resources object' do
      get :index, format: :json

      expect(response.status).to eq(200)
      body = JSON.parse(response.body)

      expect(body[0]['id']).to eq(@resource1.id)
      expect(body[0]['supplier_name']).to eq(@resource1.supplier_name)
      expect(body[0]['title']).to eq(@resource1.title)
      expect(body[0]['duration']).to eq(@resource1.duration)
      expect(body[0]['delivery_date']).to be_nil
      expect(body[0]['history']).not_to be_empty

      expect(body[1]['id']).to eq(@resource2.id)
      expect(body[1]['supplier_name']).to eq(@resource2.supplier_name)
      expect(body[1]['title']).to eq(@resource2.title)
      expect(body[1]['duration']).to eq(@resource2.duration)
      expect(body[1]['delivery_date']).to be_nil
      expect(body[1]['history']).not_to be_empty
    end
  end

end
