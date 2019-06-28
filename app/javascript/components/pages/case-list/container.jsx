import PropTypes from "prop-types";
import React from "react";
import { connect } from "react-redux";
import { useI18n } from "components/i18n";
import {
  RecordList,
  fetchRecords,
  selectRecords,
  selectMeta,
  selectFilters,
  selectLoading,
  buildTableColumns
} from "components/record-list";
import NAMESPACE from "./namespace";

const CaseList = ({ records, meta, filters, loading, getRecords }) => {
  const path = "/cases?fields=short";
  const i18n = useI18n();

  const defaultFilters = {
    child_status: "open",
    record_state: true
  };

  const data = {
    filters: Object.assign({}, defaultFilters, filters),
    records,
    meta
  };

  const columns = buildTableColumns(records, "case", i18n);

  const recordListProps = {
    title: i18n.t("cases.label"),
    columns,
    data,
    loading,
    path,
    getRecords,
    namespace: NAMESPACE
  };

  return (
    <>
      <RecordList {...recordListProps} />
    </>
  );
};

CaseList.propTypes = {
  records: PropTypes.object.isRequired,
  meta: PropTypes.object.isRequired,
  filters: PropTypes.object.isRequired,
  loading: PropTypes.bool,
  getRecords: PropTypes.func.isRequired
};

const mapStateToProps = state => ({
  records: selectRecords(state, NAMESPACE),
  meta: selectMeta(state, NAMESPACE),
  filters: selectFilters(state, NAMESPACE),
  loading: selectLoading(state, NAMESPACE)
});

const mapDispatchToProps = {
  getRecords: fetchRecords
};

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(CaseList);