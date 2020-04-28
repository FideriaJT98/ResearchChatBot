const profile_url ="http://fci.nust.na/"

println("STARTED")

fci_URL = "http://fci.nust.na"
eng_URL = "http://fe.nust.na"
health_URL = "http://fhas.nust.na"
human_sc_URL = "http://fhs.nust.na"
manage_URL = "http://fms.nust.na"
natural_URL = "http://fnrss.nust.na"

baseURL = string(fci_URL, "/?q=list-all-staff")

println("1")

#include("utilities/Staff.jl")

using Genie
using Genie.Router
using Genie.Deploy
using JSON, PyCall
#using TensorFlow

#=
using HTTP, Gumbo, Cascadia, Genie
using Genie.Requests
using TextAnalysis, WordTokenizers
=#

println("2")

@pyimport nltk.tag as ptag
@pyimport nltk.sentiment.vader as Sentiment


println("3")


route("/", named = :root) do
    Router.serve_static_file("/bot.html")
end

function get_noun(x)
    for t in x
        if t[2] == "NN" || t[2] == "NNP"
            println(t[1])
            return string(t[1])             
        end
    end
end

function rebuild(z)
    cnt = 1
    sentence = ""
    for i in z
        if cnt == 1
            sentence = string(sentence, i)
            cnt = cnt+1
        else
            sentence = string(sentence, " ", i)
            cnt = cnt+1
        end
    end
    return sentence
end

function get_mood(sentence)
    sid = Sentiment.SentimentIntensityAnalyzer()
    scores = sid.polarity_scores(sentence)
    println(scores)
    if scores["neg"] > .5 
        return "negative"
    elseif (scores["pos"] > .5) && (scores["neg"] <= 1)
        return "positive"
    elseif  scores["neu"] == 1
        return "neutral"
    end 
end

route("/pass_val", method=POST, named = :randommap) do
    text_dirty = @params(:human)
    
    var = split(lowercase(string(text_dirty)) ,r"[_]")
    z = String.(var)                 
    x = ptag.pos_tag(z)
    
    text_clean = rebuild(z)    
    mood = get_mood(text_clean)
    
    type_res = "mood"
    alt_value = "mood"
    res = JSON.json(Dict(:type => type_res, :alt => alt_value, :info => mood))
    
    #=
    println(x)
    
    person_name = ""
    person_name = get_noun(x)    
    println(person_name)
    
    link, title, name = Staff.search_staff(string(person_name), baseURL,"1")
    
    alt_value = string(title, " ", name)
        
    image_link = "$profile_url$link"
    r = HTTP.request("GET", image_link; verbose=3)
    h = parsehtml(String(r.body))
    qs = eachmatch(sel".user-picture img", h.root)
    
    image = getattr(qs[1], "src")
    type_res = "image"
    
    res = JSON.json(Dict(:type => type_res, :alt => alt_value, :info => image))
    println(res)
	=#
    
    "$res"
end

println("ALMOST THERE--")

up()

#Deploy.Docker.dockerfile()
#Deploy.Docker.build()
#Deploy.Docker.run(mountapp = true)