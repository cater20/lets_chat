class PostsController < ApplicationController
    before_action :redirect_if_not_signed_in, only: [:new]
    
    def index
        @hobby_posts = Post.by_branch('hobby').limit(8)
       @study_posts = Post.by_branch('study').limit(8)
        @team_posts = Post.by_branch('team').limit(8)
      end

      def new
        @branch = params[:branch]
        @categories = Category.where(branch: @branch)
        @post = Post.new
      end
    
      def create
        @post = Post.new(post_params)
        if @post.save 
          redirect_to post_path(@post) 
        else
          redirect_to root_path
        end
      end

    def show
        @post = Post.find_by(params[:id])
    end

    def hobby
        posts_for_branch(params[:action])
        respond_to do |format|
            format.html
            format.js { render partial: 'posts/posts_pagination_page' }
        end
    end

    def study
        posts_for_branch(params[:action])
        respond_to do |format|
            format.html
            format.js { render partial: 'posts/posts_pagination_page' }
        end
    end

    def team
        posts_for_branch(params[:action])
        respond_to do |format|
            format.html
            format.js { render partial: 'posts/posts_pagination_page' }
        end
    end

    private
    def posts_for_branch(branch)
        respond_to do |format|
            format.html
            format.js { render partial: 'posts/posts_pagination_page' }
        @categories = Category.where(branch: branch)
        @posts = get_posts.paginate(page: params[:page])
        end
      end

      def post_params
        params.require(:post).permit(:content, :title, :category_id)
                             .merge(user_id: current_user.id)
      end

      def get_posts
        PostsForBranchService.new({
            search: params[:search],
            category: params[:category],
            branch: params[:action]
          }).call
    end
end
