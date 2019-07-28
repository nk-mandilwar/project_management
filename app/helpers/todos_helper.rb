module TodosHelper

  def edit_todo_link(todo, link_name)
    if policy(todo).edit?
      link_to link_name, edit_todo_path(todo)
    elsif link_name == 'Assign'
      ''
    else
      link_name
    end
  end

  def show_status(todo)
    if todo.open?
      "New"
    elsif todo.progress?
      "In Progress"
    else
      "Done"
    end
  end

end