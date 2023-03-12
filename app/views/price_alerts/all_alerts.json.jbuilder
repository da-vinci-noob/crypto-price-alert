if @alerts.empty?
  json.message 'There are no Alerts set by You'
else
  json.alerts do
    json.array! @alerts, partial: 'alert', as: :alert
  end
  json.pagination do
    json.current_page @pagy.page
    json.current_page_items @pagy.in
    json.per_page_items @pagy.items
    json.total_items @pagy.count
    json.total_pages @pagy.pages
  end
end
