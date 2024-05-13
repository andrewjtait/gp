# frozen_string_literal: true

class SearchesController < ApplicationController
  before_action :find_search
  before_action :prevent_new_search, only: %i[new create]

  def index
    redirect_to new_search_path if @search.nil?
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.create!

    redirect_to searches_path, notice: 'Search started'
  end

  def destroy
    @search.destroy!

    redirect_to new_search_path, alert: 'Search stopped'
  end

  private

  def find_search
    @search = Search.first
  end

  def prevent_new_search
    redirect_to searches_path unless @search.nil?
  end
end
