module ApplicationHelper
    def traducao
        I18n.locale == :en ? "Ingreis " : "Portugues"
    end

    def reloginho
        traducao == "Portugues" ? Date.today.strftime("%d/%m/%Y") : Date.today.strftime("%Y/%m/%d")
    end
    
end
