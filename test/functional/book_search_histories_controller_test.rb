require 'test_helper'

class BookSearchHistoriesControllerTest < ActionController::TestCase
  setup do
    @book_search_history = book_search_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_search_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_search_history" do
    assert_difference('BookSearchHistory.count') do
      post :create, book_search_history: { book_name: @book_search_history.book_name, search_count: @book_search_history.search_count }
    end

    assert_redirected_to book_search_history_path(assigns(:book_search_history))
  end

  test "should show book_search_history" do
    get :show, id: @book_search_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_search_history
    assert_response :success
  end

  test "should update book_search_history" do
    put :update, id: @book_search_history, book_search_history: { book_name: @book_search_history.book_name, search_count: @book_search_history.search_count }
    assert_redirected_to book_search_history_path(assigns(:book_search_history))
  end

  test "should destroy book_search_history" do
    assert_difference('BookSearchHistory.count', -1) do
      delete :destroy, id: @book_search_history
    end

    assert_redirected_to book_search_histories_path
  end
end
