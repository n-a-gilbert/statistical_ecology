# A century of statistical *Ecology*

### [Neil A. Gilbert](https://gilbertecology.com), [Bruna R. Amaral](https://scholar.google.com/citations?user=iJAjVTQAAAAJ), [Olivia M. Smith](https://smithagroecology.wixsite.com/oliviasmith), [Peter J. Williams](https://scholar.google.com/citations?user=WbtvB8oAAAAJ), Sydney Ceyzyk, [Samuel Ayebare](https://scholar.google.com/citations?user=520344UAAAAJ), [Kayla L. Davis](https://davisk93.github.io/), [Jeffrey W. Doser](https://www.jeffdoser.com/), [Elise F. Zipkin](https://zipkinlab.org/)

### Data/code DOI: To be added upon acceptance

#### Please contact the first author for questions about the code or data: Neil A. Gilbert (neil.allen.gilbert@gmail.com)

__________________________________________________________________________________________________________________________________________

## Abstract
As data and computing power have proliferated in recent decades, statistical modeling has become an important tool for understanding ecological patterns and processes. Statistical modeling in ecology faces two major challenges: first, ecological data may not conform to traditional methods, and second, professional ecologists often do not receive extensive statistical training. In response to these challenges, the journal *Ecology* has published many innovative statistical ecology papers that introduce novel modeling methods and provide accessible guides to statistical best practices. In this paper, we reflect on *Ecology’s* history and its role in the emergence of the subdiscipline of statistical ecology, which we define as the study of ecological systems using mathematical equations, probability, and empirical data. We showcase 33 influential statistical ecology papers that have been published in *Ecology* and in so doing comment on the evolution of the field. As data and computing power continue to increase, we anticipate continued growth in statistical ecology to tackle complex analyses and an expanding role for *Ecology* to publish innovative and influential papers, pushing forward the discipline and guiding practicing ecologists. 

## Repository Directory
### [code](./code)
* [create_plots_and_stats.R](./code/create_plots_and_stats.R) Create Figures 1-2 and review stats

### [data](./data)
*[ecology_statistical_ecology_classification_v01.csv](./data/ecology_statistical_ecology_classification_v01.csv) File with data from literature view

| Variable name | Meaning |
|---------------|---------|
| authors | Author list of paper |
| title | Title of paper |
| year | Year of publication |
| volume | Volume of publication |
| issue | Issue of publication |
| start_page | Starting page number of publication |
| end_page | Ending page number of publication |
| citations | Number of citations the paper has |
| q75_citations | The 75th percentile of number-of-publications for the journal for the given year |
| prop_rank | Proportional rank citations, calculated as rank(citations) / max(rank(citations)) |
| omit | Each paper is coded as omit (e.g., erratum) or keep (research article) |
| statistical | Yes/no, does the paper have a focus on statistical ecology |
| individual | 1/0 Is the paper focused on models for individuals (only for statistical ecology papers with citations > q75_citations) |
| population | 1/0 Is the paper focused on models for populations (only for statistical ecology papers with citations > q75_citations) |
| community | 1/0 Is the paper focused on models for communities (only for statistical ecology papers with citations > q75_citations) | 
| ecosystem | 1/0 Is the paper focused on models for ecosystems (only for statistical ecology papers with citations > q75_citations) |
| spatial | 1/0 Is the paper focused on models for space (only for statistical ecology papers with citations > q75_citations) |
| validation_selection | 1/0 Is the paper focused on model validation or selection (only for statistical ecology papers with citations > q75_citations) |
| tools_practices | 1/0 Is the paper focused on general modeling tools or best practices (only for statistical ecology papers with citations > q75_citations) |

### [figures](./figures)
*[figure_01.png](./figures/figure_01.png) Figure 1: time series of the proportion of statistical ecology papers in *Ecology*
*[figure_02.png](./figures/figure_02.png) Figure 2: breakdown of the categories of the highly-cited statistical ecology papers
*[figure_03.pptx](./figures/figure_03.pptx) Figure 3: timeline of the showcased papers
