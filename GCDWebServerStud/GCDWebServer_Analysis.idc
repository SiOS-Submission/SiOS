// https://github.com/nil1666/IDC4Android

#include <idc.idc>

//return obj_name or ""
static search_inheritance_obj(obj_name, segm_name)
{
  extern objPrefix;
  extern objGCDWebServer;
  extern objGCDWebDAVServer;
  extern objGCDWebUploader;
  
  auto ref_to_ea;
  auto stru_name;
  auto ea;
  
  ea = get_name_ea(0, obj_name);
  if(ea != BADADDR)
  {
    Message("search_super_obj: > 0x%x\n", ea);
    for(ref_to_ea = get_first_dref_to(ea); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea, ref_to_ea))
    {
      Message("search_super_obj: >> 0x%x\n", ref_to_ea);  
      if(strstr(get_segm_name(ref_to_ea), segm_name) != -1)
      {
        Message("search_super_obj: >>> 0x%x\n", ref_to_ea);      
        stru_name = get_name(ref_to_ea - 8);    
        Message("search_super_obj: >>> %s\n", stru_name);      

        if(strlen(stru_name) != 0 && isExpectedName(stru_name) == 1)
        {
          return substr(stru_name, strlen(objPrefix), -1);
        }        
      }        
    }
  }  
  return substr(obj_name, strlen(objPrefix), -1);  
}

static search_obj_ref(search_pattern, segm_name)
{
  auto ref_to_ea;
  auto ref_to_ea1;
  
  auto ea;
  auto ea1;
  auto ea_tmp;
  
  auto func_name;
  
  ea = get_name_ea(0, search_pattern);
  if(ea == BADADDR)
    return -1;
  Message("search_obj_ref: > 0x%x\n", ea);
  
  ea_tmp = ea;
  ea = BADADDR;  
  for(ref_to_ea = get_first_dref_to(ea_tmp); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea_tmp, ref_to_ea))
  {
    Message("search_obj_ref: >> 0x%x\n", ref_to_ea);      
    if(strstr(get_segm_name(ref_to_ea), segm_name) != -1)
    {
      Message("search_obj_ref: >>> 0x%x\n", ref_to_ea);    
      ea = ref_to_ea;
    }
  }
  if(ea == BADADDR)
    return -1;
  Message("search_obj_ref: > 0x%x\n", ea);
  
  ea_tmp = ea;  
  for(ref_to_ea = get_first_dref_to(ea_tmp); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea_tmp, ref_to_ea))
  {
    Message("search_obj_ref: >> 0x%x\n", ref_to_ea); 
    if(get_segm_name(ref_to_ea) == "__text")
    {
      func_name = get_func_name(ref_to_ea); 
      Message("search_obj_ref: >>> %s\n", func_name);  
      if(isExpectedName(func_name) == 1)
        return 1;  
    }
  }  
  return -1; 
}


static search_method_ref(search_pattern, segm_name)
{
  auto ref_to_ea;
  auto ref_to_ea1;
  
  auto ea;
  auto ea1;
  auto ea_tmp;
  
  auto func_name;
  
  ea = find_binary(0, SEARCH_DOWN | SEARCH_NEXT | SEARCH_CASE, search_pattern); 
  if(ea == BADADDR)
    return -1;
  Message("search_method_ref: > 0x%x\n", ea);
  
  ea_tmp = ea;
  ea = BADADDR;  
  for(ref_to_ea = get_first_dref_to(ea_tmp); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea_tmp, ref_to_ea))
  {
    Message("search_method_ref: >> 0x%x\n", ref_to_ea);      
    if(strstr(get_segm_name(ref_to_ea), segm_name) != -1)
    {
      Message("search_method_ref: >>> 0x%x\n", ref_to_ea);    
      ea = ref_to_ea;
    }
  }
  if(ea == BADADDR)
    return -1;
  Message("search_method_ref: > 0x%x\n", ea);
  
  ea_tmp = ea;  
  for(ref_to_ea = get_first_dref_to(ea_tmp); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea_tmp, ref_to_ea))
  {
    Message("search_method_ref: >> 0x%x\n", ref_to_ea); 
    if(get_segm_name(ref_to_ea) == "__text")
    {
      func_name = get_func_name(ref_to_ea); 
      Message("search_method_ref: >>> %s\n", func_name);  
      if(isExpectedName(func_name) == 1)
        return 1;  
    }
  }  
  return -1;          
}


static search_str_ref(search_pattern, segm_name)
{
  auto ref_to_ea;
  auto ref_to_ea1;
  
  auto ea;
  auto ea1;
  auto ea_tmp;
  
  auto func_name;
  
  ea = find_binary(0, SEARCH_DOWN | SEARCH_NEXT | SEARCH_CASE, search_pattern); 
  if(ea == BADADDR)
    return -1;
  Message("search_str_ref: > 0x%x\n", ea);
  
  ea_tmp = ea;
  ea = BADADDR;  
  for(ref_to_ea = get_first_dref_to(ea_tmp); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea_tmp, ref_to_ea))
  {
    Message("search_str_ref: >> 0x%x\n", ref_to_ea);      
    if(strstr(get_segm_name(ref_to_ea), segm_name) != -1)
    {
      Message("search_str_ref: >>> 0x%x\n", ref_to_ea);    
      ea = ref_to_ea;
    }
  }
  if(ea == BADADDR)
    return -1;
  Message("search_str_ref: > 0x%x\n", ea);
  
  ea_tmp = ea;  
  for(ref_to_ea = get_first_dref_to(ea_tmp); ref_to_ea != BADADDR; ref_to_ea = get_next_dref_to(ea_tmp, ref_to_ea))
  {
    Message("search_str_ref: >> 0x%x\n", ref_to_ea); 
    if(get_segm_name(ref_to_ea) == "__text")
    {
      func_name = get_func_name(ref_to_ea); 
      Message("search_str_ref: >>> %s\n", func_name);  
      if(isExpectedName(func_name) == 1)
        return 1;  
    }
    else if(get_segm_name(ref_to_ea) == "__const")  // deal with NSString const * MyStr1 = GCDWebServerOption_BindToLocalhost;
    {
      for(ref_to_ea1 = get_first_dref_to(ref_to_ea); ref_to_ea1 != BADADDR; ref_to_ea1 = get_next_dref_to(ref_to_ea, ref_to_ea1))
      {
        Message("search_str_ref: >>> 0x%x\n", ref_to_ea1); 
        if(get_segm_name(ref_to_ea1) == "__text")
        {
          func_name = get_func_name(ref_to_ea1); 
          Message("search_str_ref: >>>> %s\n", func_name);            
          if(isExpectedName(func_name) == 1)
            return 1;  
        }
      }
    }
  }  
  return -1;        
}

static isExpectedName(func_name)
{
  extern objGCDWebServer;
  //extern objGCDWebServerOrInheritance;
  extern objGCDWebDAVServer;
  //extern objGCDWebDAVServerOrInheritance;
  extern objGCDWebUploader;
  //extern objGCDWebUploaderOrInheritance;
  
  
  if(strstr(func_name, objGCDWebServer) != -1) return -1;
  if(strstr(func_name, objGCDWebDAVServer) != -1) return -1;
  if(strstr(func_name, objGCDWebUploader) != -1) return -1;
  //if(strstr(func_name, objGCDWebServerOrInheritance) != -1) return -1; 
  //if(strstr(func_name, objGCDWebDAVServerOrInheritance) != -1) return -1; 
  //if(strstr(func_name, objGCDWebUploaderOrInheritance) != -1) return -1; 
  
  return 1;    
}


static main()
{
  //http://www.bejson.com/convert/ox2str/
  //https://www.hex-rays.com/products/ida/debugger/scriptable.shtml
  //https://www.hex-rays.com/products/ida/support/idadoc/162.shtml
  
  auto logfile = fopen("/Users/demo/Desktop/vetting_ios_app_local_server/code/poc/GCDWebServerStud/log.txt", "a+");
  
  auto addDefaultHandlerForMethod = 0;
  auto addDefaultHandlerForMethod_async = 0;
  auto addHandlerForMethod = 0;
  auto addHandlerForMethod_reg = 0;
  
  auto startWithOptions = 0;
  auto BindToLocalhost = 0; 
  auto isObfuscated = 0;
  
  extern objGCDWebServer;
  objGCDWebServer = "GCDWebServer";
  extern objGCDWebServerOrInheritance;
  auto isGCDWebServerOrInheritanceLive = 0;

  extern objGCDWebDAVServer;
  objGCDWebDAVServer = "GCDWebDAVServer";
  extern objGCDWebDAVServerOrInheritance;
  auto isGCDWebDAVServerOrInheritanceLive = 0;

  extern objGCDWebUploader;
  objGCDWebUploader = "GCDWebUploader";
  extern objGCDWebUploaderOrInheritance;
  auto isGCDWebUploaderOrInheritanceLive = 0;

  extern objPrefix;
  objPrefix = "_OBJC_CLASS_$_";
  
  //https://www.hex-rays.com/products/ida/7.2/the_mac_rundown/the_mac_rundown.shtml
  load_and_run_plugin("objc", 1);
  auto_wait();
  
  //find inheritance firstly, this will init other global variable
  objGCDWebServerOrInheritance = search_inheritance_obj(objPrefix + objGCDWebServer, "__objc_data");
  objGCDWebDAVServerOrInheritance = search_inheritance_obj(objPrefix + objGCDWebDAVServer, "__objc_data");  
  objGCDWebUploaderOrInheritance = search_inheritance_obj(objPrefix + objGCDWebUploader, "__objc_data");
  
  Message("main: %s, %s, %s", objGCDWebServerOrInheritance, objGCDWebDAVServerOrInheritance, objGCDWebUploaderOrInheritance);
  
  
  //search ref to "addDefaultHandlerForMethod:requestClass:processBlock:"
  auto search_pattern1 = "61 64 64 44 65 66 61 75 6c 74 48 61 6e 64 6c 65 72 46 6f 72 4d 65 74 68 6f 64 3a 72 65 71 75 65 73 74 43 6c 61 73 73 3a 70 72 6f 63 65 73 73 42 6c 6f 63 6b 3a";
  if (search_method_ref(search_pattern1, "__objc_selrefs") == 1)
  {
    addDefaultHandlerForMethod = 1;
    Message("main: addDefaultHandlerForMethod handlers found!\n");
  }

  //search ref to "addDefaultHandlerForMethod:requestClass:asyncProcessBlock:"
  auto search_pattern2 = "61 64 64 44 65 66 61 75 6c 74 48 61 6e 64 6c 65 72 46 6f 72 4d 65 74 68 6f 64 3a 72 65 71 75 65 73 74 43 6c 61 73 73 3a 61 73 79 6e 63 50 72 6f 63 65 73 73 42 6c 6f 63 6b 3a";
  if (search_method_ref(search_pattern2, "__objc_selrefs") == 1)
  {
    addDefaultHandlerForMethod_async = 1;
    Message("main: addDefaultHandlerForMethod_async handlers found!\n");
  }

  //search ref to "addHandlerForMethod:path:requestClass:processBlock:"
  auto search_pattern3 = "61 64 64 48 61 6e 64 6c 65 72 46 6f 72 4d 65 74 68 6f 64 3a 70 61 74 68 3a 72 65 71 75 65 73 74 43 6c 61 73 73 3a 70 72 6f 63 65 73 73 42 6c 6f 63 6b 3a";
  if (search_method_ref(search_pattern3, "__objc_selrefs") == 1)
  {
    addHandlerForMethod = 1;
    Message("main: addHandlerForMethod handlers found!\n");
  }

  //search ref to "addHandlerForMethod:pathRegex:requestClass:processBlock:"
  auto search_pattern4 = "61 64 64 48 61 6e 64 6c 65 72 46 6f 72 4d 65 74 68 6f 64 3a 70 61 74 68 52 65 67 65 78 3a 72 65 71 75 65 73 74 43 6c 61 73 73 3a 70 72 6f 63 65 73 73 42 6c 6f 63 6b 3a";
  if (search_method_ref(search_pattern4, "__objc_selrefs") == 1)
  {
    addHandlerForMethod_reg = 1;
    Message("main: addHandlerForMethod_reg handlers found!\n");
  }
  
  //search ref to "startWithOptions:error:"
  auto search_pattern5 = "73 74 61 72 74 57 69 74 68 4f 70 74 69 6f 6e 73 3a 65 72 72 6f 72 3a";  
  if (search_method_ref(search_pattern5, "__objc_selrefs") == 1)
  {
    startWithOptions = 1;
    Message("main: startWithOptions found!\n");
  }
  
  //search ref to (cstring)"BindToLocalhost"
  auto search_BindToLocalhost = "42 69 6e 64 54 6f 4c 6f 63 61 6c 68 6f 73 74";
  if (search_str_ref(search_BindToLocalhost, "__cfstring") == 1)
  {
    BindToLocalhost = 1;
    Message("main: BindToLocalhost found!\n");
  }    

  if(get_name_ea(0, objPrefix + objGCDWebServer) == BADADDR && get_name_ea(0, objPrefix + objGCDWebDAVServer) == BADADDR && get_name_ea(0, objPrefix + objGCDWebUploader) == BADADDR)
    isObfuscated = 1;
   
  if(search_obj_ref(objPrefix + objGCDWebServerOrInheritance, "__objc_classrefs") == 1)
  {
    Message("main: objGCDWebServerOrInheritance: %s is Live!\n", objGCDWebServerOrInheritance);  
    isGCDWebServerOrInheritanceLive = 1;
  }

  if(search_obj_ref(objPrefix + objGCDWebServerOrInheritance, "__got") == 1) // as a framework
  {
    Message("main: objGCDWebServerOrInheritance: %s is Live!\n", objGCDWebServerOrInheritance);  
    isGCDWebServerOrInheritanceLive = 1;
  }


  if(search_obj_ref(objPrefix + objGCDWebDAVServerOrInheritance, "__objc_classrefs") == 1)
  {
    Message("main: objGCDWebDAVServerOrInheritance: %s is Live!\n", objGCDWebDAVServerOrInheritance);
    isGCDWebDAVServerOrInheritanceLive = 1;
  }

  if(search_obj_ref(objPrefix + objGCDWebDAVServerOrInheritance, "__got") == 1)  // as a framework
  {
    Message("main: objGCDWebDAVServerOrInheritance: %s is Live!\n", objGCDWebDAVServerOrInheritance);
    isGCDWebDAVServerOrInheritanceLive = 1;
  }

  if(search_obj_ref(objPrefix + objGCDWebUploaderOrInheritance, "__objc_classrefs") == 1)
  {
    Message("main: objGCDWebUploaderOrInheritance: %s is Live!\n", objGCDWebUploaderOrInheritance);  
    isGCDWebUploaderOrInheritanceLive = 1;
  }

  if(search_obj_ref(objPrefix + objGCDWebUploaderOrInheritance, "__got") == 1)  // as a framework
  {
    Message("main: objGCDWebUploaderOrInheritance: %s is Live!\n", objGCDWebUploaderOrInheritance);  
    isGCDWebUploaderOrInheritanceLive = 1;
  }
  
  //Message("main: DefaultHandlerForMethod:%d; DefaultHandlerForMethod_async:%d; HandlerForMethod:%d; HandlerForMethod_reg:%d; startWithOptions:%d; BindToLocalhost:%d; isObfuscated:%d; %s:%d; %s:%d; %s:%d;\n", addDefaultHandlerForMethod, addDefaultHandlerForMethod_async, addHandlerForMethod, addHandlerForMethod_reg, startWithOptions, BindToLocalhost, isObfuscated, objGCDWebServerOrInheritance, isGCDWebServerOrInheritanceLive, objGCDWebDAVServerOrInheritance, isGCDWebDAVServerOrInheritanceLive, objGCDWebUploaderOrInheritance, isGCDWebUploaderOrInheritanceLive);
    
  fseek(logfile, 0, 2);
  fprintf(logfile, "%s; DefaultHandlerForMethod:%d; DefaultHandlerForMethod_async:%d; HandlerForMethod:%d; HandlerForMethod_reg:%d; startWithOptions:%d; BindToLocalhost:%d; isObfuscated:%d; %s:%d; %s:%d; %s:%d;\n", ARGV[1], addDefaultHandlerForMethod, addDefaultHandlerForMethod_async, addHandlerForMethod, addHandlerForMethod_reg, startWithOptions, BindToLocalhost, isObfuscated, objGCDWebServerOrInheritance, isGCDWebServerOrInheritanceLive, objGCDWebDAVServerOrInheritance, isGCDWebDAVServerOrInheritanceLive, objGCDWebUploaderOrInheritance, isGCDWebUploaderOrInheritanceLive);
  fclose(logfile);

  Exit(0); // Exit IDA Pro
  // todo: 
  // addDefaultHandlerForMethod:requestClass:processBlock: handler
  // 
  // addHandlerForMethod:path:requestClass:processBlock:
  // addHandlerForMethod:pathRegex:requestClass:processBlock:
  
  
}