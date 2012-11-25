# coding : utf-8
class BookSearchHistoriesController < ApplicationController
  # GET /book_search_histories
  # GET /book_search_histories.json
  
  # Custom Method by me
  def increase_history_count
    
    # find book name from DB
    an_book_search_history = BookSearchHistory.find_by_book_name(params[:book_name])

    # if exist, increase count of that item    
    if an_book_search_history
      an_book_search_history.search_count += 1
    # if not, create new item and set count to 1
    else
      an_book_search_history = BookSearchHistory.new
      an_book_search_history.book_name = params[:book_name]
      an_book_search_history.search_count = 1
    end
    
    # save db
    an_book_search_history.save  
  
    # temp : show items
    @book_search_histories = BookSearchHistory.all

    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.json { render json: @book_search_histories }
      format.xml  { render xml:  @book_search_histories }
    end
    
    # 옛 날 거 - 동 작 안 함
=begin
    @book_search_history = BookSearchHistory.find_by_name(params[:book_name])
    
    if book_search_history == nil
      @book_search_history = BookSearchHistory.new
      @book_search_history.book_name = params[:book_name]
      @book_search_history.count = 1
      @book_search_history.save
    end  
    
    @book_search_histories = BookSearchHistory.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @book_search_histories }
    end
=end
    
  end
  
  def find_histories
    # use like + wild card to find histories
    book_search_histories = BookSearchHistory.select("book_name").
      where("book_name like ?", "%" + params[:book_name] + "%").
      order("search_count DESC, book_name").    # 1. count / #2. alphabetical order in same count
      limit(params[:limit])   # grab book_search_histories of 'limite' numbers
    
    # return items to the client
    respond_to do |format|
      format.json { render json: book_search_histories }
      format.xml  { render xml:  book_search_histories }
    end
  end
  
  def delete_history
    book_search_history = BookSearchHistory.find_by_book_name(params[:book_name])
    book_search_history.destroy
    
    @book_search_histories = BookSearchHistory.all
    
    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.json { render json: @book_search_histories }
      format.xml  { render xml:  @book_search_histories }
    end
    
  end
  
  # RESTful Method (Default)
  def index
    @book_search_histories = BookSearchHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @book_search_histories }
    end
  end

  # GET /book_search_histories/1
  # GET /book_search_histories/1.json
  def show
    @book_search_history = BookSearchHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book_search_history }
    end
  end

  # GET /book_search_histories/new
  # GET /book_search_histories/new.json
  def new
    @book_search_history = BookSearchHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book_search_history }
    end
  end

  # GET /book_search_histories/1/edit
  def edit
    @book_search_history = BookSearchHistory.find(params[:id])
  end

  # POST /book_search_histories
  # POST /book_search_histories.json
  def create
    @book_search_history = BookSearchHistory.new(params[:book_search_history])

    respond_to do |format|
      if @book_search_history.save
        format.html { redirect_to @book_search_history, notice: 'Book search history was successfully created.' }
        format.json { render json: @book_search_history, status: :created, location: @book_search_history }
      else
        format.html { render action: "new" }
        format.json { render json: @book_search_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /book_search_histories/1
  # PUT /book_search_histories/1.json
  def update
    @book_search_history = BookSearchHistory.find(params[:id])

    respond_to do |format|
      if @book_search_history.update_attributes(params[:book_search_history])
        format.html { redirect_to @book_search_history, notice: 'Book search history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book_search_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_search_histories/1
  # DELETE /book_search_histories/1.json
  def destroy
    @book_search_history = BookSearchHistory.find(params[:id])
    @book_search_history.destroy

    respond_to do |format|
      format.html { redirect_to book_search_histories_url }
      format.json { head :no_content }
    end
  end
end
