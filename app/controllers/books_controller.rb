class BooksController < ApplicationController
  before_action :find_book, only: %i[show update destroy]
  skip_before_action :check_user
	skip_before_action :check_admin, only: :index

  protect_from_forgery

  # Show all books
  def index
    books = Book.all
    if books.present?
      render json: books
    else
      render json: { message: 'No books exist' }
    end
  end

  def create
    book = @current_member.books.new(set_params)
    if book.save
      render json: book, status: :created
    else
      render json: { error: book.errors.full_messages }
    end
  end

  # Show a particular book
  def show
    book= @current_member.books
    render json: book
  end

  # Update a book
  def update
    if @book.update(set_params)
      render json: @book
    else
      render json: { errors: @book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Delete a book
  def destroy
    if @book
      @book.destroy
      render json: { message: 'Deleted successfully' }
    else
      render json: { message: 'Failed to delete the book' }
    end
  end

  private

  def set_params
    params.permit(:title, :author, :price, :quantity)
  end

  def find_book
    @book = Book.find_by_id(params[:id])
    return if @book

    render json: 'Book not found'
  end
end
