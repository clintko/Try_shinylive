library(tidyverse)
library(shiny)

# Load data
txt_furl = "https://www.dropbox.com/scl/fi/1sdttdmk29fxjduw1pe3x/fcc_starrmpracrispr_vote2.umap.chipseq_score.tsv?rlkey=jskwb0hxuvxwdo5evd6qjjvnm&raw=1"
dat_region_umap = read_tsv(txt_furl)

# Get feature names
vec_txt_feature = setdiff(colnames(dat_region_umap), c("UMAP1", "UMAP2", "Region", "Chrom", "ChromStart", "ChromEnd"))

# UI
ui = fluidPage(
    titlePanel("UMAP Embedding of CREs based on ChIP-seq Signals"),
    sidebarLayout(
        sidebarPanel(
            selectInput("txt_feature", "ChIP-seq Factor", choices = vec_txt_feature, selected = "H3K4me3")
        ),
        mainPanel(
            plotOutput("plot_fcc_umap")
        )
    )
)

# Server
server = function(input, output) {
    output$plot_fcc_umap <- renderPlot({
        ggplot(dat_region_umap, aes_string(x = "UMAP1", y = "UMAP2", color = input$txt_feature)) +
            geom_point(alpha = 0.5) +
            theme_minimal()
    })
}

shinyApp(ui, server)