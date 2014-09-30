require 'json'

describe "json-grep.rb" do
  it "should handle expectedly" do
    expect( `ruby ../json-grep.rb a <bad.json` ).to eq( "" )
    expect( JSON.parse `ruby ../json-grep.rb a <valid.json` ).to eq(
      { "a"=> "a string" }
    )
    expect( JSON.parse `ruby ../json-grep.rb e <valid.json` ).to eq( 
      { "e"=> [ "an", "array", "of", 5, "values" ] }
    )
    expect( JSON.parse `ruby ../json-grep.rb f <valid.json` ).to eq( 
      {"f"=>{"g"=>"subhash", "h"=>{"i"=>"subsubhash", "i2"=> "morehash"}, "j"=>-2.153}}
    )
    expect( JSON.parse `ruby ../json-grep.rb f h < valid.json` ).to eq(
      {"f"=>{"h"=>{"i"=>"subsubhash", "i2"=> "morehash"}}}
    )
    expect( JSON.parse `ruby ../json-grep.rb f h 'i$' < valid.json` ).to eq(
      {"f"=>{"h"=>{"i"=>"subsubhash"}}}
    )
    expect( `ruby ../json-grep.rb f y z < valid.json` ).to eq(
      ""
    )
    expect( `ruby ../json-grep.rb f h z < valid.json` ).to eq(
      ""
    )
  end
end
=begin
=end
