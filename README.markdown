# API Matchers

Collection of RSpec matchers for create your API.

## Matchers

* be_in_xml
* be_a_json
* create_resource
* be_a_bad_request
* be_unauthorized
* be_internal_server_error
* have_node
* have_json_node
* have_xml_node
* be_json_eql
* be_xml_eql

## Install

      gem install api_matchers

## Usage

### Including in RSpec

To include all this matchers you need to include the APIMatchers::RSpecMatchers module:

    RSpec.configure do |config|
      config.include APIMatchers::RSpecMatchers
    end

### Have Node Matcher

The have_node matcher parse the actual and see if have the expcted node with the expected value.
**The default that have_node will parse is JSON.**

You can verify if node exists:

      "{ 'transaction': { 'id': '54', 'status': 'paid' } }".should have_node(:transaction)

Or if node exist with a value:

      "{ 'transaction': { 'id': '54', 'status': 'paid' } }".should have_node(:id).with(54)

      "{ 'error': 'not_authorized', 'transaction': { 'id': '55' } }".should have_node(:error).with('not_authorized')

To see the json node and see if include a text, you can do this:

      { :error => "Transaction error: Name can't be blank" }.to_json.should have_node(:error).including_text("Transaction error")


### HAVE NODE Matcher Configuration

You can configure if you want xml(**JSON is the default**):

      APIMatchers.setup do |config|
        config.content_type = :xml
      end

      '<transaction><id>200</id><status>paid</status></transaction>'.should have_node(:status)

Using the with method:

      '<transaction><id>200</id><status>paid</status></transaction>'.should have_node(:status).with('paid')

Or you can use the **have_xml_node** matcher:

      "<error>Transaction error: Name can't be blank</error>".should have_xml_node(:error).with("Transaction error: Name can't be blank")

To see the xml node and see if include a text, you can do this:

      "<error>Transaction error: Name can't be blank</error>".should have_xml_node(:error).including_text("Transaction error")

**If you work with xml and json in the same API, I recommend that you check the have_json_node and have_xml_node matchers.**

You can configure the name of the method for example:

      ## Instead of this
      response.body.should have_node(:foo)

      ## YOU can do this
      APIMatchers.setup do |config|
        config.body_method = :body
      end

Then you can use without call the **#body** method:

      response.should have_node(:foo).with('bar')

### Have JSON Node Matcher

    "{ 'transaction': { 'id': '54', 'status': 'paid' } }".should have_json_node(:id).with(54)

### Have XML Node Matcher

    "<product><name>gateway</name></product>".should have_xml_node(:name).with('gateway')


### Create Resource Matcher

This matchers see the HTTP STATUS CODE is equal to 201.

     response.status.should create_resource

### BAD REQUEST Matcher

This BAD REQUEST is a matcher that see if the HTTP STATUS code is equal to 400.

    response.status.should be_a_bad_request
    response.status.should be_bad_request

### UNAUTHORIZED Matcher

This UNAUTHORIZED is a matcher that see if the HTTP STATUS code is equal to 401.

    response.status.should be_unauthorized
    response.body.should have_node(:message).with('Invalid Credentials')

### INTERNAL SERVER ERROR Matcher

This INTERNAL SERVER Error is a matcher that see if the HTTP STATUS code is equal to 500.

    response.status.should be_internal_server_error
    response.body.should have_node(:message).with('An Internal Error Occurs in our precious app. :S')

### HTTP STATUS CODE Configuration

You can configure the name method to call the http status code:

     APIMatchers.setup do |config|
       config.http_status_method = :status
     end

Then you can use without call the **#status** method:

    response.should create_resource

This configurations affects this matchers:

* create_resource
* be_a_bad_request
* be_internal_server_error
* be_unauthorized

### Be in XML Matcher

This is a matcher that see if the content type is xml:

    response.headers['Content-Type'].should be_in_xml

### Be in JSON Matcher

This is a matcher that see if the content type is in JSON:

    response.headers['Content-Type'].should be_in_json

### Headers Configuration

You can configure the name method to call the headers and content type:

    APIMatchers.setup do |config|
      config.header_method           = :headers
      config.header_content_type_key = 'Content-Type'
    end

Then you can use without call the **#headers** calling the **#['Content-Type']** method:

    response.should be_in_json
    response.should be_in_xml

### Acknowlegments

* Special thanks to Daniel Konishi to contribute in the product that I extracted the matchers to this gem.