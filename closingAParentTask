#Если в трекере "Акцептирование" статус задачи меняется на "Закрыта"
if saved_change_to_status_id? && @issue.status_id == 4 && @issue.tracker_id == 3
  # Получаем родительскую задачу
  parent_issue = @issue.parent
  return unless parent_issue #ыход если нет родительской задачи

  # Получаем всех потомков родительской задачи
  child_issues = parent_issue.children

  # Проверяем, закрыты ли все потомки
  all_children_closed = child_issues.all? { |issue| issue.status.is_closed? }

  # Закрываем родительскую задачу, если все потомки закрыты
  if all_children_closed
    parent_issue.update(status_id: IssueStatus.where(is_closed: true).first.id)
  end
end
 
