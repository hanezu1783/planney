class EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.new
  end

  def index
    @events = current_user.events.order(start_at: :asc)
  end

  def create
    @event = Event.new(event_params)
    # 「終日」が選択された場合の処理
    if @event.all_day?
      # start_atには日付のみが送られてくるため、end_atをその日の終わりに設定する
      @event.end_at = @event.start_at.end_of_day
    end

    if @event.save
      redirect_to root_path, notice: 'スケジュールを登録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :event_title, :start_at, :end_at, :all_day, :description
    ).merge(user_id: current_user.id)
  end
end
