class Api::V1::LineItemsController < Api::V1::ApiController
    before_action :set_time_sheet
    before_action :set_line_item, only: [ :update, :destroy ]

    def create
        @line_item = @time_sheet.line_items.new(line_item_params)
        if @line_item.save
        render json: @line_item, status: :created
        else
        render json: @line_item.errors, status: :unprocessable_entity
        end
    end

    def update
        if @line_item.update(line_item_params)
        render json: @line_item
        else
        render json: @line_item.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @line_item.destroy
        head :no_content
    end

    private

    def set_time_sheet
        @time_sheet = TimeSheet.find(params[:timesheet_id])
    end

    def set_line_item
        @line_item = @time_sheet.line_items.find(params[:id])
    end

    def line_item_params
        params.require(:line_item).permit(:date, :minutes)
    end
end
