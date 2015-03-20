


class HomeController < ApplicationController

  @session_id
  @planning_folder_id
  @motion_mobile_project_id = "proj1038"

  Gyoku.xml({ :camel_case => "key" }, { :key_converter => :camelcase })


  def index
    
    @session_id = login
    getArtifactList    

  end


  def get_all_planning_folders

    login

    session = @session_id

    client = Savon::Client.new do |wsdl, http| 
      wsdl.document = "http://teamforge.corp.motion-ind.com/ce-soap60/services/PlanningApp?wsdl"
      wsdl.endpoint = "http://teamforge.corp.motion-ind.com/ce-soap60/services/PlanningApp?wsdl"
    end
    
    
    response = client.request  :ser, :get_planning_folder_list do      
      soap.namespaces["xmlns:ser"] = "http://schema.open.collab.net/sfee50/soap60/service"
      soap.body = {
        sessionId: session, 
        parentId: 'proj1038',
        recursive: true
      }
    end   


    render :json => response


  end


  def set_tracker_data
    login
    session = @session_id       


    namespaces = {
      "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
      "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
      "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:ser" => "http://schema.open.collab.net/sfee50/soap60/service",
      "xmlns:soapenc" => "http://schemas.xmlsoap.org/soap/encoding/"

    }

    teamforge_keys = {
      "actual_effort" => "actualEffort",
      "artifact_group" => "artifactGroup",
      "assigned_to_username" => "assignedTo",
      "category" => "category",
      "close_date" => "closeDate",
      "created_by" => "createdBy",
      "created_date" => "createdDate",
      "estimated_effort" => "estimatedEffort",
      "folder_id" => "folderId",
      "last_modified_by" => "lastModifiedBy",
      "last_modified_date" => "lastModifiedDate",
      "planning_folder_id" => "planningFolderId",
      "remaining_effort" => "remainingEffort",
      "reported_in_release_id" => "reportedReleaseId",
      "resolved_in_relsease_id" => "resolvedReleaseId",
      "status_class" => "statusClass"


    }

    new_hash = {
      "actualEffort" => params["actual_effort"],
      #{}"artifactGroup" => params["artifact_group"],
      "assignedTo" => params["assigned_to_username"],
      "autosumming" => params["autosumming"],
      "category" => params["category"],
      #{}"closeDate" => params["close_date"],
      #"createdBy" => params["created_by"],
      #{}"customer" => params["customer"],
      "description" => params["description"],
      "estimatedEffort" => params["estimated_effort"],
      #flexFields" =>
      "folderId" => params["folder_id"],
      #{}"group" => 
      "id" => params["id"],
      #{}"lastModifiedBy" => 
      "lastModifiedDate" => params["last_modified_date"],
      #{}"path" => 
      "planningFolderId" => params["planning_folder_id"],
      "points" => params["points"].to_s,
      "priority" => params["priority"],
      "remainingEffort" => params["remaining_effort"],
      #{}"reportedReleaseId" => params["reported_in_release_id"],
      #{}"resolvedReleaseId" => params["resolved_in_release_id"],
      "status" => params["status"],
      "statusClass" => params["status_class"],
      "title" => params["title"],
      "version" => params["version"]      
    }


    #my_xml = Crack::XML.parse(response)
    #updated_params = Hash[params.map { |k, v|  [teamforge_keys[k], v] }]


    client = Savon::Client.new do |wsdl, http| 
      wsdl.document = "http://teamforge.corp.motion-ind.com/ce-soap60/services/TrackerApp?wsdl"
      wsdl.endpoint = "http://teamforge.corp.motion-ind.com/ce-soap60/services/TrackerApp?wsdl"
    end
      
    
    response = client.request  :ser, :set_artifact_data do 
      
      soap.namespaces["xmlns:ser"] = "http://schema.open.collab.net/sfee50/soap60/service"
      soap.body = {
        sessionId: session, 
        artifactData: new_hash
      }

    end         

    render :nothing => true      
    
    
  end


  private


  def login

    Gyoku.xml({ :camel_case => "key" }, { :key_converter => :none })

    namespaces = {
      "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
      "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
      "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:ser" => "http://schema.open.collab.net/sfee50/soap60/service",
      "xmlns:soapenc" => "http://schemas.xmlsoap.org/soap/encoding/"

    }

    client = Savon::Client.new do |wsdl, http| 
      wsdl.document = "http://teamforge.corp.motion-ind.com/ce-soap60/services/CollabNet?wsdl"
      wsdl.endpoint = "http://teamforge.corp.motion-ind.com/ce-soap60/services/CollabNet?wsdl"
    end

    
    
    response = client.request  :ser, "login" do 
      
      soap.namespaces["xmlns:ser"] = "http://schema.open.collab.net/sfee50/soap60/service"
      soap.body = {
        userName: "dp078971", 
        password: "Geddy321!"
      }
    end   
  
    @session_id = response.body[:login_response][:login_return]

  end


  



  def getArtifactList     

    if params[:planning_folder_id]
      planning_folder_id = params[:planning_folder_id]
    else
      planning_folder_id = params["planning_folder_id"]
    end


    
    session = @session_id
    namespaces = {
      "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
      "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
      "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:ser" => "http://schema.open.collab.net/sfee50/soap60/service",
      "xmlns:soapenc" => "http://schemas.xmlsoap.org/soap/encoding/"

    }

    Gyoku.convert_symbols_to :none # or one of [:none, :lover_camelcase]

    client = Savon::Client.new do |wsdl, http|
      wsdl.document = "http://teamforge.corp.motion-ind.com/ce-soap60/services/PlanningApp?wsdl"
      wsdl.endpoint = "http://teamforge.corp.motion-ind.com/ce-soap60/services/PlanningApp?wsdl"

    end
    
    response = client.request  "ser", "getArtifactListInPlanningFolder" do       
      soap.namespaces["xmlns:ser"] = "http://schema.open.collab.net/sfee50/soap60/service"
      soap.body = {
        sessionId: session, 
        parentId: planning_folder_id,
        recursive: true
      }
    end       

        
    response.body[:session_id] = session
  
    data = response.body
    
    render :json => data
    
    
  end



  def getPlanningApp_SAVON2  
    @planning_folder_id = "plan1334"
    session = @session_id
    namespaces = {
      "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
      "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
      "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:ser" => "http://schema.open.collab.net/sfee50/soap60/service",
      "xmlns:soapenc" => "http://schemas.xmlsoap.org/soap/encoding/"

    }

=begin
    client = Savon.client(
      convert_request_keys_to: :camelcase,
      wsdl: "http://teamforge.corp.motion-ind.com/ce-soap60/services/PlanningApp?wsdl",
      namespaces: namespaces,      
      endpoint: "http://teamforge.corp.motion-ind.com/ce-soap60/services/PlanningApp?wsdl",
      log: true
    )
=end

    client = Savon::Client.new do |wsdl, http|

    end   
    
    response = client.call(:get_ranked_artifact_list, message: { sessionId: session, planningFolderId: @planning_folder_id })

    
    my_xml = Crack::XML.parse(response.to_s)


    
    my_json = my_xml.to_json
   
    response_hash = my_xml.to_hash  

    data = response_hash["soapenv:Envelope"]["soapenv:Body"]["multiRef"]
    
    render :json => data
    
    
  end






  


end
