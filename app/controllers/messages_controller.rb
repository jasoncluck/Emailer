class MessagesController < ApplicationController
  #sort the messages
  before_filter :sort
  #authorize for certain actions
  before_filter :general_authorize, only: [:inbox, :outbox, :archive, :reminder, :update, :sendmessage, :destroy, :create]
  before_filter :admin_authorize, only: [:update, :sendmessage, :destroy, :reminder]

  #sort the messages based on whether they have been sent or not
  def sort
      all_messages = Message.all

      @sent_messages = Array.new  #archive
      @unsent_messages = Array.new  #outbox
      @received_messages = Array.new #inbox

      all_messages.each do |m|
        if m.receive_flag
          @received_messages << m
        else 
          if m.sent_flag
            @sent_messages << m
          else
            @unsent_messages << m
          end
        end
      end

      #now sort according to what type of message they are
      #received messages - from earliest to oldest
      @received_messages = @received_messages.sort_by( &:received_time ).reverse
      #unsent messages from oldest to earliest
      @unsent_messages = @unsent_messages.sort_by(&:send_date)
      #sent messages from earliest to oldest
      @sent_messages = @sent_messages.sort_by( &:sent_time )

  end
  # GET /messages
  # GET /messages.json
  def outbox

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unsent_messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  #index - just redirect to the outbox page
  def index
    redirect_to outbox_path
  end
  #function to send the mail
  def sendmessage
    @message = Message.find(params[:id])

    #get result path
    if @message.receive_flag
      result_path = inbox_path
    elsif @message.sent_flag
      result_path = archive_path
    else
      result_path = outbox_path
    end
    #check send date
    if @message.send_date > Date.today
      redirect_to result_path, alert: "Send date is still in the future.  Either change the send date or wait"
    else
      MessageMailer.generic_email(@message).deliver
      #change the sent flag to true and update the sent date
      @message.sent_flag = true
      @message.sent_time = Time.now
      @message.save
      redirect_to result_path, notice: 'Message was successfully sent!'
    end
  end

  #inbox
  def inbox
  end

  def archive
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sent_messages }
    end
  end

  def reminder
  end 

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save

        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])

    if @message.receive_flag
      result_path = inbox_path
    elsif @message.sent_flag
      result_path = archive_path
    else
      result_path = outbox_path
    end

    @message.destroy

    respond_to do |format|
      format.html { redirect_to result_path }
      format.json { head :no_content }
    end
  end
end
