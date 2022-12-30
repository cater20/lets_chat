class PostsController < ApplicationController

    #def index
       # @hobby_posts = Post.by_branch('hobby').limit(8)
       # @study_posts = Post.by_branch('study').limit(8)
        #@team_posts = Post.by_branch('team').limit(8)
      #end

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

      def get_posts
        PostsForBranchService.new({
            search: params[:search],
            category: params[:category],
            branch: params[:action]
          }).call
    end
end
