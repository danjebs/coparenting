class Task < ApplicationRecord
  belongs_to :board
  belongs_to :task_status
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  acts_as_list scope: :task_status

  before_save :set_position, if: :new_record?

  scope :ordered, -> { order(position: :asc) }

  def status_label
    task_status&.name
  end

  private

  def set_position
    self.position ||= Task.where(task_status_id: task_status_id).count + 1
  end
end
