require_relative '../filter_contents.rb'

describe "filter_contents" do
  it "should filter appropriately string vs hash" do
    expect( filter_contents "hi", [ "hi" ] ).to eq("hi")
    expect( filter_contents "bye", [ "hi" ] ).to eq(nil)
  end
  it "should filter appropriately array containing string to string" do
    expect( filter_contents ["hi"],  [ "hi" ] ).to eq(["hi"])
    expect( filter_contents ["bye"], [ "hi" ] ).to eq(nil)
  end
  it "should filter appropraiately on key of hash " do
    expect( filter_contents( { hi: 3, bye: 4 }, ["hi"] ) ).to eq({hi: 3})
    expect( filter_contents( { greets: 3, bye: 4 }, ["hi"] ) ).to eq(nil)
  end
  it "should filter a key of a hash with arrays within" do

    data = { greetings: { hi: 3 }, others: [ "hi" ] }
    expect( filter_contents( data , [ "greetings|others", "hi" ])
    ).to eq( data )

    data = { greetings: { hi: 3 }, others: [ { hi: 3 }, "hi", "igloo" ], bye: 4 }
    expect( filter_contents( data , [ "greetings|others", "hi" ])
    ).to eq( { greetings: { hi: 3}, others:[ { hi: 3} , "hi" ]  }  )
    expect( filter_contents( data , [ "greetings|others", "hi", 3 ])
    ).to eq( { greetings: { hi: 3}, others:[ { hi: 3}  ]  }  )

    expect( filter_contents( data , [ "greetings", "hi" ])
    ).to eq( { greetings: { hi: 3} }  )
  end

end
