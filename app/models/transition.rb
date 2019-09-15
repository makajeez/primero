class Transition < ApplicationRecord

  #REFERRAL = "referral" ; REASSIGN = "reassign" ; TRANSFER = "transfer" ; TRANSFER_REQUEST = "transfer_request"

  STATUS_PENDING = "pending" ; STATUS_ACCEPTED = "accepted" ; STATUS_REJECTED = "rejected"
  STATUS_INPROGRESS = "in_progress" ; STATUS_DONE = "done"

  belongs_to :record, polymorphic: true
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_name',
             primary_key: 'user_name', optional: true
  belongs_to :transitioned_by_user, class_name: 'User', 'foreign_key': 'transitioned_by',
             primary_key: 'user_name'

  validate :consent_given_or_overridden
  validate :user_can_receive

  after_initialize :defaults, unless: :persisted?
  before_create :perform

  def defaults
    self.created_at ||= DateTime.now
  end

  def perform ; raise NotImplementedError ; end
  def accept! ; raise NotImplementedError ; end
  def reject! ; raise NotImplementedError ; end

  def in_progress?
    status == Transition::STATUS_INPROGRESS
  end

  def assigned_to_user?(user_name)
    to_user_name == user_name
  end

  def consent_given_or_overridden
    return if consent_given? || consent_overridden

    errors.add(:consent, 'transition.errors.consent')
  end

  def consent_given?
    false
  end

  def user_can_receive
    return if user_can_receive?

    errors.add(:to_user_name, 'transition.errors.to_user_can_receive')
  end

  def user_can_receive?
    (!to_user.disabled) &&
    (to_user.role.permissions.any? { |ps| ps.resource == record.class.parent_form }) &&
    (to_user.modules.pluck(:unique_id).include? record.module_id)
  end

end
