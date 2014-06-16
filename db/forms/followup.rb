followup_subform_fields = [
  Field.new({"name" => "followup_type",
             "type" => "select_box",
             "display_name_all" => "Type of followup",
             "option_strings_text_all" =>
                           ["Follow-Up After Reunification",
                           "Follow-up in Care",
                           "Follow up for Service (need list)",
                           "Follow up for Assessment (need list)"].join("\n")
            }),
  Field.new({"name" => "followup_needed_by_date",
             "type" => "date_field",
             "display_name_all" => "Followup needed by"
            }),
  Field.new({"name" => "followup_date",
             "type" => "date_field",
             "display_name_all" => "Followup date"
            }),
  Field.new({"name" => "child_was_seen",
             "type" => "select_box",
             "display_name_all" => "Was the child/adult seen during the visit?",
             "option_strings_text_all" => ["Yes", "No"].join("\n")
            }),
  Field.new({"name" => "reason_child_not_seen",
             "type" => "check_boxes",
             "display_name_all" => "If not, why?",
             "option_strings_text_all" =>
                          ["Abducted",
                           "At School",
                           "Child in Detention",
                           "Moved onto street/Market",
                           "Moved to live with another caregiver",
                           "Visiting Friends/Relatives",
                           "Working /At work "].join("\n")
            }),
  Field.new({"name" => "action_taken_already",
             "type" => "select_box",
             "display_name_all" => "Has action been taken?",
             "option_strings_text_all" => ["Yes", "No"].join("\n")
            }),
  Field.new({"name" => "action_taken_details",
             "type" => "text_field",
             "display_name_all" => "Details about action taken"
            }),
  Field.new({"name" => "action_taken_date",
             "type" => "date_field",
             "display_name_all" => "Date action taken?"
            }),
  Field.new({"name" => "need_follow_up_visit",
             "type" => "select_box",
             "display_name_all" => "Is there a need for further follow-up visits?",
             "option_strings_text_all" => ["Yes", "No"].join("\n")
            }),
  Field.new({"name" => "when_follow_up_visit_should_happen",
             "type" => "text_field",
             "display_name_all" => "If yes, when do you recommend the next visit to take place?"
            }),
  Field.new({"name" => "recommend_case_closed",
             "type" => "select_box",
             "display_name_all" => "If not, do you recommend that the case be close?",
             "option_strings_text_all" => ["Yes", "No"].join("\n")
            }),
  Field.new({"name" => "followup_comments",
             "type" => "text_field",
             "display_name_all" => "Comments"
            })
]

followup_subform_section = FormSection.create_or_update_form_section({
  "visible" => false,
  "is_nested" => true,
  :order => 1,
  :unique_id => "followup_subform_section",
  "editable" => true,
  :fields => followup_subform_fields,
  :perm_enabled => false,
  :perm_visible => false,
  "name_all" => "Nested Followup Subform",
  "description_all" => "Nested Followup Subform"
})

followup_fields = [
  Field.new({"name" => "followup_subform_section",
             "type" => "subform", "editable" => true,
             "subform_section_id" => followup_subform_section.id,
             "display_name_all" => "Followup"
            })
]

FormSection.create_or_update_form_section({
  :unique_id => "followup",
  "visible" => true,
  :order => 7,
  "editable" => true,
  :fields => followup_fields,
  :perm_enabled => true,
  "name_all" => "Followup",
  "description_all" => "Followup"
})