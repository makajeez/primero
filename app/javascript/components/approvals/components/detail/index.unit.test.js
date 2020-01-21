import { expect } from "chai";

import * as index from "./index";

describe("Approvals - Detail - index", () => {
  const indexValues = { ...index };

  it("should have known exported properties", () => {
    ["ApprovalDetail"].forEach(property => {
      expect(indexValues).to.have.property(property);
      delete indexValues[property];
    });

    expect(indexValues).to.be.empty;
  });
});
