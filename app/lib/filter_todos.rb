class FilterTodos
  def self.filter(user, params, is_owner)
    if is_owner && params[:visibility] == "private"
      filtered_todos = user.private_todos
    elsif params[:visibility] == "private" # sem permissão
      filtered_todos = []
    elsif params[:visibility] == "public" || !is_owner
      filtered_todos = user.public_todos
    else # dono e não passou a propriedade de visibilidade
      filtered_todos = user.todos
    end

    if params[:status] == "done"
      return filtered_todos.where(is_done: true)
    elsif params[:status] == "not_done"
      return filtered_todos.where(is_done: false)
    else
      return filtered_todos
    end
  end
end