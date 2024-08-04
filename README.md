# Legal Case Reports

## Overview
This dataset contains Australian legal cases from the Federal Court of Australia (FCA). The cases were downloaded from [AustLII](http://www.austlii.edu.au). 

We included all cases from the year 2006, 2007, 2008 and 2009. We built it to experiment with automatic summarization and citation analysis. 

For each document we collected catchphrases, citations sentences, citation catchphrases, and citation classes. Catchphrases are found in the document, we used the catchphrases are gold standard for our summarization experiments. 
- Citation sentences are found in later cases that cite the present case, we use citation sentences for summarization. 
- Citation catchphrases are the catchphrases (where available) of both later cases that cite the present case, and older cases cited by the present case. 
- Citation classes are indicated in the document, and indicate the type of treatment given to the cases cited by the present case.

## Data Source
[UC Irvine Machine Learning Repository - Legal Case Reports](https://archive.ics.uci.edu/dataset/239/legal+case+reports)

[Kaggle - Legal Case Reports in Australia](https://www.kaggle.com/datasets/thedevastator/legal-case-reports-in-australia-2006-2009?select=06_1041.xml)

## Download the Dataset
You can download the dataset directly from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/Legal+Case+Reports) or [Kaggle](https://www.kaggle.com/datasets/thedevastator/legal-case-reports-in-australia-2006-2009?select=06_1041.xml).

Or, you can download the dataset via `curl` in command line:
```sh
source download.sh [<save_path>]
```
If `<save_path>` is not provided, the dataset `legal_case_reports.zip` will be downloaded to the current directory.

## Structure
After unzipping downloaded zip file, the dataset  `corpus` contains:
- readme.txt
- citations_class: 2754 `.xml` files that contain citation class element for each case.
- citations_summ: 3891 `.xml` files that contain citations element for each case.
- fulltext: 3890 `.xml` files that contain full text and the catchphrases of all the cases from the FCA.

## License
CC BY 4.0