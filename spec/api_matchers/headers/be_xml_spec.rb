require 'spec_helper'

describe APIMatchers::Headers::BeXML do
  describe "actual.should be_xml" do
    it "should pass when the actual is json response" do
      "application/xml; charset=utf-8".should be_xml
    end

    it "should not pass when the actual is not a json response" do
      expect {
        "application/json; charset=utf-8".should be_xml
      }.to fail_with(%Q{expected a XML response with 'application/xml; charset=utf-8'. Got: 'application/json; charset=utf-8'.})
    end
  end

  describe "actual.should_not be_xml" do
    it "should pass when the actual is not a json response" do
      "application/json; charset=utf-8".should_not be_xml
    end

    it "should not pass when the actual is a json response" do
      expect {
        "application/xml; charset=utf-8".should_not be_xml
      }.to fail_with(%Q{expected to not be a XML response. Got: 'application/xml; charset=utf-8'.})
    end
  end
end