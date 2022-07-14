require "json"
require "excon"
require "tk"

# API_KEY = 221a4d722ef1468aa94e9ac9157c4f85

    root = TkRoot.new { title "News APP | Soumya" }
    root['geometry'] = "900x600"
    root['background'] = "#2d2d2d"
    root['pady'] = 20
    root['padx'] = 40

    label = TkLabel.new(root) do
        text "Welcome to News App!"
        font TkFont.new("Arial 18 bold")
        pady 20
        pack('fill' => 'x')
    end
    label["background"] = "#2d2d2d"
    label["foreground"] = "white"

    $newsLabel = TkLabel.new(root) do
        text "Welcome to News App!"
        font TkFont.new("Arial 10 bold")
        pady 5
        padx 5
        pack('side' => 'top')
    end
    $newsLabel["background"] = "#1d1d1d"
    $newsLabel["foreground"] = "white"

    def setNews(news_text)
        $newsLabel["text"] = news_text
    end

    button = TkButton.new(root) do
        text "Fetch News"
        command { fetchNews}
        padx 7
        pady 10
        pack('side' => 'bottom')
    end
    button["background"] = "black"
    button["foreground"] = "cyan"

def requestApi(url)
    response = Excon.get(url)
    return nil if response.status != 200
    JSON.parse(response.body)
end

def fetchNews
    puts "Fetching News..."
    setNews("Fetching News...")
    news_text = ""
    url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=221a4d722ef1468aa94e9ac9157c4f85"
    response = requestApi(url)
    if response == nil
        puts "Error fetching news"
        setNews("Error fetching news")
    else
        puts "News fetched successfully"
        setNews("News fetched successfully")
        news_array = response["articles"]
        news_text = ""
        news_array.each do |news|
            if news["title"] != nil
                news_text = news_text + news["title"] + "\n"
            end
        end
    end
    setNews(news_text)  
end

# myCanvas.setNews("Fetching News...")
Tk.mainloop()