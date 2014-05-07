module Version1
  class CommentAPI < Grape::API

    resource :comments do


      desc 'Add comment'
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


      desc "Update comment"
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


      desc "Delete comment"
      delete ':id' do
        authenticate!
        comment = Comment.find(params[:id])
        comment.destroy
        present :status, "Success"
      end


    end
  end
end