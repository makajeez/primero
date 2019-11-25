import { List, Map } from "immutable";

import * as Actions from "./actions";
import NAMESPACE from "./namespace";

const DEFAULT_STATE = Map({});

const reducer = (state = DEFAULT_STATE, { type, payload }) => {
  switch (type) {
    case Actions.SET_UP_CHIPS:
      return state.set(payload, List([]));
    case Actions.RESET_CHIPS:
      return state.set(payload, state.get(payload).clear());
    default:
      return state;
  }
};

export const chipsReducer = { [NAMESPACE]: reducer };