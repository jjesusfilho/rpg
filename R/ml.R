
#' veiculos
#'
#' @param n Número
#'
#' @return
#' @export
#'
ml_veiculos <- function(n){
  
 `%>%` <- magrittr::`%>%`  
  
  n <- as.integer(n)
  
  if (is.na(n) | length(n) != 1){
    
    stop("Você deve fornecer um e somente um número")
    
  }
  


  url <- "https://lista.mercadolivre.com.br/veiculos/carros-caminhonetes/"
  
  df <- data.frame(marca = character(0), ano = integer(0), km = integer(0), preco = integer(0))
  
  i <- 1
 while(!is.na(url)){
    
   # pb$tick()
    

    conteudo <- httr::GET(url) %>% 
                httr::content()
    
  
      url <- conteudo %>% 
                xml2::xml_find_all("//a[@class='andes-pagination__link ui-search-link']") %>% 
                xml2::xml_attr("href") %>% 
         dplyr::last()
    
      
    preco <- conteudo %>% 
             xml2::xml_find_all('//span[@class="price-tag-fraction"]') %>% 
             xml2::xml_text() %>% 
      stringr::str_remove_all("\\D+") %>% 
      as.integer()
      
    ano <- conteudo %>% 
           xml2::xml_find_all('//li[@class="ui-search-card-attributes__attribute"][1]') %>% 
           xml2::xml_text() %>% 
           as.integer()
    
    km <- conteudo %>% 
      xml2::xml_find_all('//li[@class="ui-search-card-attributes__attribute"][2]') %>% 
      xml2::xml_text() %>% 
      stringr::str_remove_all("\\D+") %>% 
      as.integer()
    
    
    marca <- conteudo %>% 
      xml2::xml_find_all('//h2[@class="ui-search-item__title ui-search-item__group__element"]') %>% 
      xml2::xml_text()
    
   df1 <- data.frame(marca, ano, km, preco)
    
   df <- dplyr::bind_rows(df, df1)  
        
 i <- i + 1
 
 if (i > n){
   
   break
 }
 }
  return(df)
}


  
