class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end
  
  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user #URLを入力しても画面に飛ばせない
        render :edit
    else
        redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
    end
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
