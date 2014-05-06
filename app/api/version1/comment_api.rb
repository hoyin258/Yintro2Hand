module Version1
  class CommentAPI < Grape::API

    resource :comments do

      # Post
      desc 'Add Comment'
      params do
        requires :id, type: Integer, desc: "Item id."
        requires :message, type: String, desc: "Comment ."
      end
      post do
        authenticate!

        comment = Comment.new(
            message: params[:message],
        )

        if item.save
          present :status, "Success"
          present :data, comment, with: Version1::Entities::Comment
        end
      end




    end
  end
end