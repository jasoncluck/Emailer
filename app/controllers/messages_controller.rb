class MessagesController < ApplicationController
  #sort the messages
  before_filter :sort
  #authorize for certain actions
  before_filter :illegal_session
  before_filter :admin_authorize, only: [:sendmessage, :sendallmessages, :reminder, :editall]

  #sort the messages based on whether they have been sent or not
  def sort
      @sent_messages = Message.where(:sent_flag => true) #archive
      @unsent_messages = Message.where(:sent_flag => nil) #outbox

      #now sort according to what type of message they are
      #received messages - from earliest to oldest
      #unsent messages from oldest to earliest
      @unsent_messages = @unsent_messages.sort_by( &:send_date )
      #sent messages from earliest to oldest
      @sent_messages = @sent_messages.sort_by( &:sent_time ).reverse

      #get all the signatures too
      @signatures = Signature

  end
  # GET /messages
  # GET /messages.json
  def outbox

    #handle new signatures
    @general_signature = params[:general_signature]
    @gw_signature = params[:gw_signature]
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
    @message.signature = 1
    @message.send_date = Date.today
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

  def sendallmessages
    @unsent_messages.each do |m|
      if m.send_date <= Date.today
        #check send date
        if m.send_date > Date.today
          redirect_to result_path, alert: "Send date is still in the future.  Either change the send date or wait"
        else
          MessageMailer.generic_email(m).deliver
          #change the sent flag to true and update the sent date
          m.sent_flag = true
          m.sent_time = Time.now
          m.save
        end
      end
    end
    redirect_to outbox_path, notice: "Messages succesfully sent!" 
  end

  def reply
    old_message = Message.find(params[:id])
    @message = Message.new
    @message.body = nil
    @message.email = old_message.email
    @message.subject = old_message.subject
    @message.signature = 1
    @message.send_date = Date.today
    @message.save
  end

  #inbox
  def inbox

    #get rid of all received messages that are older than week
    Message.destroy_all :received_time => 1.year.ago..2.days.ago
    @received_messages = Message.find_all_by_received_time(1.week.ago..Time.now)
    

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

        format.html { redirect_to outbox_path, notice: 'Message was successfully created.' }
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
        format.html { redirect_to outbox_path, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  def editall

  end

  def updateall
    Message.update(params[:messages].keys, params[:messages].values)
    redirect_to outbox_path, notice: "Emails updated!"
  end

  def signature
    
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
