json.extract! transaction, :id, :amount, :target_name, :source_name, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
