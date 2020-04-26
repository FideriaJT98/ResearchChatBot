module Staff

export search_staff

using Cascadia, HTTP, Gumbo

function search_staff(search_name, baseURL, choice)
    r = HTTP.request("GET", baseURL; verbose=3)
    h = parsehtml(String(r.body))
    qs = eachmatch(sel".main", h.root)
    tables = eachmatch(sel".views-table tbody",qs[1])
    
    for table in tables          
        names = eachmatch(sel".views-field-field-full-name a",table)
        
        if choice == "1"
            names = eachmatch(sel".views-field-field-full-name a",table)
            titles = eachmatch(sel".views-field-field-job-title a",table)    
            profiles = eachmatch(sel".views-field-view-user a",table)
            
            x = 0
            for name in names
                txt_name = string(name.children[1])
                x = x + 1
                if occursin(lowercase(search_name), lowercase(txt_name)) == true
                    println("HERE")
                    return getattr(profiles[x], "href"), string(titles[x].children[1]), txt_name
                end
            end
        elseif choice == "2"
            names = eachmatch(sel".views-field-view-user-1 a",table)#views-field views-field-view-user-1, eng & nat
            titles = eachmatch(sel".views-field-field-job-title a",table)    
            profiles = eachmatch(sel".views-field-view-user a",table)
            
            x = 0
            for name in names
                txt_name = string(name.children[1])
                x = x + 1
                if occursin(lowercase(search_name), lowercase(txt_name)) == true
                    println("HERE")
                    return getattr(profiles[x], "href"), string(titles[x].children[1]), txt_name
                end
            end 
        end             
    end
end

end # module
