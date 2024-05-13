# frozen_string_literal: true

class SearchesController < ApplicationController
  before_action :find_search
  before_action :ensure_search_exists, only: %i[show stop]
  before_action :prevent_new_search, only: %i[new create]

  def new
    @search = Search.new
  end

  def create
    @search = Search.create!

    redirect_to search_path, notice: 'Search started'
  end

  def stop
    @search.destroy!

    redirect_to new_search_path, alert: 'Search stopped'
  end

  private

  def find_search
    @search = Search.first
  end

  def ensure_search_exists
    redirect_to new_search_path if @search.nil?
  end

  def prevent_new_search
    redirect_to search_path unless @search.nil?
  end
end
