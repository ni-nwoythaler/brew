# typed: true
# frozen_string_literal: true

require "formula"
require "cli/parser"

module Homebrew
  extend T::Sig

  module_function

  sig { returns(CLI::Parser) }
  def formula_args
    Homebrew::CLI::Parser.new do
      description <<~EOS
        Display the path where <formula> is located.
      EOS

      switch "--formula", "--formulae",
             description: "Treat all named arguments as formulae."
      switch "--cask", "--casks",
             description: "Treat all named arguments as casks."

      conflicts "--formula", "--cask"

      named_args [:formula, :cask]
    end
  end

  def formula
    args = formula_args.parse

    args.named.to_paths.select do |path|
      if ! path.exist?
        next
      else
        puts path
      end
    end
  end
end
