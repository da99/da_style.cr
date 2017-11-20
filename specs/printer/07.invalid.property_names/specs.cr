
describe "Parser invalid property names" do
  it "does not allow: behaviour" do
    input = %[
      body {
         behavior: url('/user/uploadedfiles/file.png');
      }
    ]

    expect_raises(DA_CSS::Invalid_Property_Name) {
      SPEC_PARSER.new(input, __DIR__).to_css
    }
  end # === it "does not allow: behaviour"

  {% for x in system("grep  '# Family' \"#{__DIR__}/../../../src/da_css/list.txt\"").split("\n").map { |x| x.split.first } %}
    {% if !%w(padding border margin).includes?(x) %}
      it "does not allow family names as property names: {{x.id}}" do
        input = %[
          div { {{x.id}}: none; }
        ]
        expect_raises(DA_CSS::Invalid_Property_Name) {
          SPEC_PARSER.new(input, __DIR__).to_css
        }
      end # === it "does not allow family names as property names:"
    {% end %}
  {% end %}
end # === desc "Parser invalid property names"