
describe "Parser vars" do
  it "does not allow invalid characters in final replacement" do
    input = %[
      BLACK = ~~~~ ;
      div { background-color: {{BLACK}} ; }
    ]

    expect_raises(DA_STYLE::Parser::Invalid_Property_Value) {
      SPEC_PARSER.new(input, __DIR__, :css).to_css
    }
  end # === it "does not allow invalid characters in final replacement"
end # === desc "Parser vars"