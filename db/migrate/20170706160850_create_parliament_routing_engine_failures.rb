class CreateParliamentRoutingEngineFailures < ActiveRecord::Migration[5.1]
  def change
    create_table :parliament_routing_engine_failures do |t|
      t.text :message

      t.timestamps
    end
  end
end
