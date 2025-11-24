class Api::V1::TimesheetsController < Api::V1::ApiController
  before_action :set_time_sheet, only: [ :show, :update, :destroy ]

  def index
    @timesheets = current_user.time_sheets.includes(:line_items)
    render json: @timesheets, include: :line_items
  end

  def create
  time_sheet = current_user.time_sheets.new(time_sheet_params)
  if time_sheet.save
    render json: time_sheet, status: :created
  else
    render json: time_sheet.errors, status: :unprocessable_entity
  end
end

  def show
    render json: @time_sheet, include: :line_items
  end

  def update
    if @time_sheet.update(time_sheet_params)
      render json: @time_sheet, include: :line_items
    else
      render json: @time_sheet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @time_sheet.destroy
    head :no_content
  end

  private

  def set_time_sheet
    @time_sheet = TimeSheet.find_by_hashid!(params[:id])
  end

    def time_sheet_params
        params.require(:time_sheet).permit(
            :description,
            :rate,
            line_items_attributes: [ :hashid, :date, :minutes, :_destroy ])
    end
end
