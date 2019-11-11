import React, { useState } from "react";
import PropTypes from "prop-types";
import { useDispatch } from "react-redux";
import * as Yup from "yup";
import { Formik } from "formik";

import { useI18n } from "../../../../i18n";
import { saveReferral } from "../../action-creators";

import MainForm from "./main-form";

const ReferralForm = ({
  handleClose,
  userPermissions,
  providedConsent,
  recordType,
  record
}) => {
  const i18n = useI18n();
  const dispatch = useDispatch();
  const [disabled, setDisabled] = useState(false);

  const canConsentOverride =
    userPermissions &&
    userPermissions.filter(permission => {
      return ["manage", "consent_override"].includes(permission);
    }).size > 0;

  const mainFormProps = {
    providedConsent,
    canConsentOverride,
    disabled,
    setDisabled,
    handleClose,
    recordType
  };

  const validationSchema = Yup.object().shape({
    transitioned_to: Yup.string().required(
      i18n.t("referral.user_mandatory_label")
    )
  });

  const formProps = {
    initialValues: {
      referral: false,
      remoteSystem: false,
      services: "",
      agency: "",
      location: "",
      transitioned_to: "",
      notes: ""
    },
    onSubmit: (values, { setSubmitting }) => {
      const recordId = record.get("id");

      dispatch(
        saveReferral(
          recordId,
          {
            data: {
              ...values,
              consent_overridden: canConsentOverride || values.transfer
            }
          },
          i18n.t("referral.success", { record_type: recordType, id: recordId })
        )
      );
      setSubmitting(false);
    },
    render: props => <MainForm formProps={props} rest={mainFormProps} />,
    validationSchema
  };

  return <Formik {...formProps} />;
};

ReferralForm.propTypes = {
  handleClose: PropTypes.func.isRequired,
  providedConsent: PropTypes.bool,
  record: PropTypes.object,
  recordType: PropTypes.string.isRequired,
  userPermissions: PropTypes.object
};

export default ReferralForm;
