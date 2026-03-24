# frozen_string_literal: true

require_relative "../lib/our_web_gem"

RSpec.describe OurWebGem::Renderer do
  subject(:renderer) { described_class.new }

  it "renders heading" do
    ast = [
      {
        type: :heading,
        level: 1,
        children: [{ type: :text, value: "Hello" }]
      }
    ]

    expect(renderer.render(ast)).to eq("<h1>Hello</h1>")
  end

  it "renders inline code" do
    ast = [
      {
        type: :paragraph,
        children: [
          { type: :text, value: "Use " },
          { type: :code_inline, value: "puts" }
        ]
      }
    ]

    expect(renderer.render(ast)).to eq("<p>Use <code>puts</code></p>")
  end

  it "renders code block" do
    ast = [
      {
        type: :code_block,
        value: "puts 'Hello'"
      }
    ]

    expect(renderer.render(ast)).to eq("<pre><code>puts 'Hello'</code></pre>")
  end

  it "renders blockquote" do
    ast = [
      {
        type: :blockquote,
        children: [
          {
            type: :paragraph,
            children: [{ type: :text, value: "Quote" }]
          }
        ]
      }
    ]

    expect(renderer.render(ast)).to eq("<blockquote><p>Quote</p></blockquote>")
  end
  it "renders empty input" do
  expect(renderer.render([])).to eq("")
end

it "raises on unknown node" do
  ast = [{ type: :unknown }]
  expect { renderer.render(ast) }.to raise_error(ArgumentError)
end
end