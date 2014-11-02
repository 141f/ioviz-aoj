describe "DataResolver", ->

  load_modules(
    "ioviz/aoj/resolvers/data_resolver"
    "ioviz/streams/graph/adjacent_list_stream"
  )

  context "when resolve GRL_1_A#input", ->

    before ->
      @stream = DataResolver.resolve
        problemId: "GRL_1_A"
        type: "input"

    it "returns AdjacentListStream", ->
      expect(@stream).to.instanceof AdjacentListStream

