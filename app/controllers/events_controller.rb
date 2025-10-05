class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def new
    @event = Event.new(all_day: false)
  end

  def index
    @events = current_user.events.order(start_at: :asc)
  end

  def create
    @event = current_user.events.new(event_params)

    # all_day の場合、end_at を start_at と同じ日の終わりに設定
    if @event.all_day?
      @event.end_at = @event.start_at.end_of_day
    end

    if @event.save
      redirect_to events_path, notice: 'スケジュールを登録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      # all_day の場合、end_at を start_at と同じ日の終わりに設定
      @event.update(end_at: @event.start_at.end_of_day) if @event.all_day?
      redirect_to events_path, notice: 'スケジュールを更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'スケジュールを削除しました。'
  end

  private

  def event_params
    params.require(:event).permit(
      :event_title, :start_at, :end_at, :all_day, :description
    )
  end

  def set_event
    @event = current_user.events.find(params[:id])
  end
end
