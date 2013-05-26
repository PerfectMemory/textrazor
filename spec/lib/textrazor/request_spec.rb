require 'spec_helper'

module TextRazor

  describe Request do

    context ".post" do

      context "default options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words dependency-trees relations entailments),
                     cleanup_html: false, filter_dbpedia_types: [], filter_freebase_types: []}

          ::RestClient.should_receive(:post).
            with("http://api.textrazor.com/", { "text" => 'text', "apiKey" => 'api_key', "cleanupHTML" => false,
            "extractors" => "entities,topics,words,dependency-trees,relations,entailments", "entities.filterDbpediaTypes" => "",
            "entities.filterFreebaseTypes" => ""}, accept_encoding: 'gzip')

          Request.post('text', options)
        end

      end

      context "custom options" do

        it "should make correct calls" do
          options = {api_key: 'api_key', extractors: %w(entities topics words), cleanup_html: true,
                     filter_dbpedia_types: %w(type1), filter_freebase_types: %w(type2)}

          ::RestClient.should_receive(:post).
            with("http://api.textrazor.com/", { "text" => 'text', "apiKey" => 'api_key', "extractors" => "entities,topics,words",
            "cleanupHTML" => true, "entities.filterDbpediaTypes" => "type1", "entities.filterFreebaseTypes" => "type2" },
             accept_encoding: 'gzip')

          Request.post('text', options)
        end

      end

    end

  end

end

#curl -X POST \
  #-d "apiKey=11b3780617dbbc8dcfb481449b2b158ab516cffc3d905d9a95618b3c" \
  #-d "extractors=topics" \
  #-d "text=Spain's stricken Bankia expects to sell off its vast portfolio of industrial holdings that includes a stake in the parent company of British Airways and Iberia." \
  #http://api.textrazor.com/
#
#
