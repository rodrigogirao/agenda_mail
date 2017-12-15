module ApplicationHelper
  def active?(path)
    "active" if current_page?(path)
  end

  def message_date(message)
    message.created_at.to_date == Date.today ? message.created_at.to_s(:time) : message.created_at.strftime("%d/%m/%Y")
  end
end
