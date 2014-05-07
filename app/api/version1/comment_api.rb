module Version1
  class CommentAPI < Grape::API

    resource :comments do


      # Get
      desc 'Returns comment list by user id'
      params do
        requires :id, type: Integer, desc: "User id."
      end
      get :user do
        comments = Comment.where(user_id: params[:id]).order(updated_at: :desc)
        present :status, "Success"
        present :data, comments, with: Entities::Comment, type: :full
      end

      # Get
      desc 'Returns comment list by item id'
      params do
        requires :id, type: Integer, desc: "Item id."
      end
      get :item do
        comments = Item.find(params[:id]).comments.order(updated_at: :desc)
        present :status, "Success"
        present :data, comments, with: Entities::Comment, type: :full
      end


      # Post
      desc 'Add Comment'
      params do
        requires :id, type: Integer, desc: "Item id."
        requires :message, type: String, desc: "Comment ."
      end
      post do
        authenticate!
        comment = Item.find(params[:id]).comments.build(
            message: params[:message],
        )
        if comment.save
          present :status, "Success"
          present :data, comment, with: Version1::Entities::Comment
        end

      end


      # PUT
      desc "Update Comment"
      params do
        requires :id, type: Integer, desc: "Comment id."
        requires :message, type: String, desc: "Comment ."
      end
      put do
        authenticate!
        comment = @current_user.comments.find(params[:id])
        comment.update({
                           message: params[:message],
                       })
        present :status, "Success"
        present :data, comment, with: Version1::Entities::Comment
      end
    end
  end
end