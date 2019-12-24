#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
ui<-navbarPage("Model Developement by Sunil Kappal | Data Dojo",
               img(src= "https://skappal7.files.wordpress.com/2017/08/datadojo7.jpg?w=50"
                   , style="float:right; padding-right:15px"),
               tabPanel("Data Import",
                        sidebarLayout(sidebarPanel( fileInput("file","Upload the binary data",multiple = FALSE),
                                                    tags$hr(),
                                                    h5(helpText("Select the read.table parameters below")),
                                                    checkboxInput(inputId = 'header', label = 'Header', value = FALSE),
                                                    checkboxInput(inputId = "stringAsFactors", "stringAsFactors", FALSE),
                                                    radioButtons(inputId = 'sep', label = 'Separator', 
                                                                 choices = c(Comma=',',Semicolon=';',Tab='\t', Space=''), selected = ',')
                        ),
                        mainPanel(uiOutput("tb1"))
                        ) ),
               tabPanel("Model Creation",
                        sidebarLayout(sidebarPanel(
                            uiOutput("model_select"),
                            uiOutput("var1_select"),
                            uiOutput("rest_var_select")),
                            mainPanel( helpText("Dependent Variable"),
                                       verbatimTextOutput("other_val_show"))))
)
server<-function(input,output) { data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()} 
    read.table(file=file1$datapath, sep=input$sep, header = input$header, stringsAsFactors = input$stringAsFactors)
    
})  
output$table <- renderTable({
    if(is.null(data())){return ()}
    data()
})
output$tb1 <- renderUI({
    tableOutput("table")
})
output$model_select<-renderUI({
    selectInput("modelselect","Choose from Models",choices = c("Logistic_reg"="logreg","SVM"="svm"))
})
output$var1_select<-renderUI({
    selectInput("ind_var_select","Select Target Variable (Dependent)", choices =as.list(names(data())),multiple = FALSE)
})
output$rest_var_select<-renderUI({
    checkboxGroupInput("other_var_select","Select Predictor Variables",choices =as.list(names(data())))
})
output$other_val_show<-renderPrint({
    input$other_var_select
    input$ind_var_select
    f<-data()
    
    library(caret)
    form <- sprintf("%s~%s",input$ind_var_select,paste0(input$other_var_select,collapse="+"))
    print(form)
    
    logreg <-glm(as.formula(form),family=binomial(),data=f)
    print(summary(logreg))
    
})

}
shinyApp(ui=ui,server=server)
