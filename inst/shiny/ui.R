library(shiny)

clusterChoice <- ''
alertText <- ''
if(!is.null(getShinyOption("inputSCEset"))){
  clusterChoice <- colnames(pData(getShinyOption("inputSCEset")))
  alertText <- HTML("<div class='alert alert-success'>Successfully Uploaded from Command Line!</div>")
}

# Define UI for application that draws a histogram
shinyUI(
  navbarPage(
    "Single Cell Toolkit (alpha)",
    #bootstrap theme
    theme = "bootstrap.min.css",

    #Upload Tab
    tabPanel(
      "Upload",
      tags$div(
        class="jumbotron",
        tags$div(
          class="container",
          h1("Single Cell Toolkit"),
          p("Filter, cluster, and analyze single cell RNA-Seq data")
        )
      ),
      tags$div(
        class="container",
        #http://shiny.rstudio.com/articles/html-tags.html
        tags$div(id="uploadAlert", alertText),
        fileInput('countsfile', 'Upload a matrix of counts here',
                  accept = c(
                    'text/csv',
                    'text/comma-separated-values',
                    'text/tab-separated-values',
                    'text/plain',
                    '.csv',
                    '.tsv'
                  )
        ),
        fileInput('annotfile', 'Upload a matrix of annotations here',
                  accept = c(
                    'text/csv',
                    'text/comma-separated-values',
                    'text/tab-separated-values',
                    'text/plain',
                    '.csv',
                    '.tsv'
                  )
        ),
        actionButton("uploadData", "Upload")
      ),
      includeHTML('www/footer.html')
    ),
    tabPanel(
      "Data Summary",
      tags$div(
        class="container",
        h1("Data Summary"),
        fluidPage(
          fluidRow(
            column(8, tableOutput('summarycontents')),
            column(
              4,
              wellPanel(
                numericInput('minDetectGenect', label = 'Minimum Detected Genes per Sample.', value=1700, min = 1, max = 100000),
                numericInput("LowExpression", "% Low Gene Expression to Filter",value=40, min = 0, max = 100),
                actionButton("filterData", "Filter Data"),
                actionButton("filterData", "Reset")
              )
            )
          ),
          fluidRow(
            dataTableOutput('contents')
          )
        )
      ),
      includeHTML('www/footer.html')
    ),
    tabPanel(
      "Clustering",
      tags$div(
        class="container",
        h1("Clustering"),
        fluidPage(
          fluidRow(
            column(4,
                   wellPanel(
                     selectInput("selectCustering","Clustering Algorithm",c("PCA","tSNE")),
                     selectInput("colorClusters","Color Clusters By",clusterChoice),
                     actionButton("clusterData", "Cluster Data")
                   )),
            column(8,
                   plotOutput("clusterPlot"))
          )
        )
      ),
      includeHTML('www/footer.html')
    ),
    tabPanel(
      "Batch Correction",
      tags$div(
        class="container",
        h1("Batch Correction")
      ),
      includeHTML('www/footer.html')
    ),
    tabPanel(
      "Differential Expression",
      tags$div(
        class="container",
        h1("Differential Expression")
      ),
      includeHTML('www/footer.html')
    ),
    tabPanel(
      "Pathway",
      tags$div(
        class="container",
        h1("Pathway Profiling")
      ),
      includeHTML('www/footer.html')
    ),
    navbarMenu(
      "More",
      tabPanel(
        "Sub-Component A",
        includeHTML('www/footer.html')),
      tabPanel(
        "Sub-Component B",
        includeHTML('www/footer.html'))
    )
  )
)
