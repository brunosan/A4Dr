class RankingsController < ApplicationController
  # GET /rankings
  # GET /rankings.xml
  def index
    @rankings = Ranking.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rankings }
    end
  end

  # GET /rankings/1
  # GET /rankings/1.xml
  def show
    @ranking = Ranking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ranking }
    end
  end

  # GET /rankings/new
  # GET /rankings/new.xml
  def new
    @ranking = Ranking.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ranking }
    end
  end

  # GET /rankings/1/edit
  def edit
    @ranking = Ranking.find(params[:id])
  end

  # POST /rankings
  # POST /rankings.xml
  def create

    @votes= -1
    @app=params[:ranking][:app_id]
    url='http://appsfordevelopment.challengepost.com/submissions/'+@app.to_s
    html=open(url) {|f| f.read } rescue '404 error'
    doc = Nokogiri::HTML(html)
    v=doc.xpath("//ul[@class='vote-button']/li[1]/p/text()").to_s.split.first
    @votes=v.to_i

    @ranking = Ranking.new(:app_id => @app, :votes =>@votes )
      if @ranking.save
        redirect_to(@ranking, :notice => 'Ranking was successfully created.')
      else
        render :action => "new"
      end
  end

  # PUT /rankings/1
  # PUT /rankings/1.xml
  def update
    @ranking = Ranking.find(params[:id])

    respond_to do |format|
      if @ranking.update_attributes(params[:ranking])
        format.html { redirect_to(@ranking, :notice => 'Ranking was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ranking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rankings/1
  # DELETE /rankings/1.xml
  def destroy
    @ranking = Ranking.find(params[:id])
    @ranking.destroy

    respond_to do |format|
      format.html { redirect_to(rankings_url) }
      format.xml  { head :ok }
    end
  end
end
