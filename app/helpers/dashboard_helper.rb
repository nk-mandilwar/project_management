module DashboardHelper

  def done_todos(todos_statuses)
    todos_statuses.split("#").each do |todos|
      if todos.include? "$2"
        return show_todos(todos).html_safe
      end
    end
    ''
  end

  def progress_todos(todos_statuses)
    todos_statuses.split("#").each do |todos|
      if todos.include? "$1"
        return show_todos(todos).html_safe
      end
    end
    ''
  end

  def new_todos(todos_statuses)
    todos_statuses.split("#").each do |todos|
      if todos.include? "$0"
        return show_todos(todos).html_safe
      end
    end
    ''
  end

  def show_todos todos
    res = ""
    todos.split("$")[0].split("*").each do |todo|
      res += "<p>#{todo}</p>"
    end
    res
  end
end
