
# ECG human-machine competition dataset

This dataset includes data from eight ECG-based human-machine competitions, designed to evaluate the performance of machine learning algorithms in detecting and diagnosing cardiovascular diseases. The dataset contains ECG recordings from multiple subjects, with corresponding annotations indicating the presence or absence of various cardiovascular diseases.

## Competitions

The dataset includes data from the following competitions:

**1. Myocardial infarction**

<img src="result/myocardial infarction.png" width="875px"/>

**2. Arrhythmia**

<img src="result/arrhythmia.png" width="1000px"/>

**3. Pericarditis**

<img src="result/pericarditis.png" width="525px"/>

**4. Digoxin toxicity**

<img src="result/digoxin concentration.png" width="525px"/>

**5. Pneumothorax**

<img src="result/pneumothorax.png" width="525px"/>

**6. Aortic dissection**

<img src="result/aortic dissection.png" width="525px"/>

**7. Pulmonary embolism**

<img src="result/pulmonary embolism.png" width="525px"/>

**8. Dyskalemia**

<img src="result/dyskalemia.png" width="875px"/>

**Note: The raw data is expected to be published in August 2023**

## Data format

Each dataset is stored as a CSV file, with each row representing a single ECG recording. There are three CSV files **"label.csv"**, **"user_results.csv"**, and **"AI_pred.csv"** describing the groundtruth, human answer, and AI predictions. The columns of the CSV file include:

**hash_id**: The unique identifier for the ECG recording.

### label.csv

**LABEL[...]**: The groundtruth of corresponding ECG using 0 (without) and 1 (with). The labels column contains a list of labels indicating the presence or absence of cardiovascular diseases, as determined by human experts or medical records.

### user_results.csv

**DOCTOR_ID**: The human's specialty and level of experience.

**USER_ANSWER[...]**: The answer given by human corresponding to the ECG recording using 0 (without) and 1 (with).

### AI_pred.csv

**AI[...]**: The predictions given by the baseline models, which was a likelihood ranged 0 to 1.

The signal column contains the raw ECG recording, with each value representing the amplitude of the ECG signal at a given time point. All ECGs are 12-lead and 10 seconds with 500 Hz. Therefore, the length of number sequence is 5,000 for each lead. The unit of value is 0.01 mV, which is the standard Philip record system. 

## Codes

The folder **"code"** contains the code to draw ROC plot for each dataset. Moreover, an ECG is also provided as following.

<img src="result/0012f4de4fb5910c230dbfa455a59143.png" width="1000px"/>

The ECG also can be presented as a SVG file.

<img src="result/0012f4de4fb5910c230dbfa455a59143.svg">

## Related publications for the datasets

Below papers provided the baseline model to predict the likelihood of each label.

| Dataset | Title                                                        | Paper                  | Citation |
| ------- | ------------------------------------------------------------ | ---------------------- | -------- |
| Myocardial infarction | [A deep-learning algorithm for detecting acute myocardial infarction](https://eurointervention.pcronline.com/article/a-deep-learning-algorithm-for-detecting-acute-myocardial-infarction) | EuroIntervention, 17(9):765-773. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2F1ce16e3039606943d287da23c8510b2d3e66ed28%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/1ce16e3039606943d287da23c8510b2d3e66ed28)
| Pericarditis | [A Deep Learning Algorithm for Detecting Acute Pericarditis by Electrocardiogram](https://www.mdpi.com/2075-4426/12/7/1150) | J Pers Med, 12(7):1150. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2F2270bf57bd38d133486f5d24e387179ce15b1d4e%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/2270bf57bd38d133486f5d24e387179ce15b1d4e)
| Digoxin toxicity | [Detecting Digoxin Toxicity by Artificial Intelligence-Assisted Electrocardiography.](https://www.mdpi.com/1660-4601/18/7/3839) | Int J Environ Res Public Health, 18(7), 3839. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2Fc45eeabc541e4068ab93f293e40ea711da2899ab%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/c45eeabc541e4068ab93f293e40ea711da2899ab)
| Pneumothorax | [A deep learning-based system capable of detecting pneumothorax via electrocardiogram](https://link.springer.com/article/10.1007/s00068-022-01904-3) | Eur J Trauma Emerg Surg, 48(4):3317-3326. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2Ffaf727f89c1ce8ee8bf88c351044c11ed7143927%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/faf727f89c1ce8ee8bf88c351044c11ed7143927)
| Aortic dissection | [A Deep-Learning Algorithm-Enhanced System Integrating Electrocardiograms and Chest X-rays for Diagnosing Aortic Dissection](https://www.sciencedirect.com/science/article/pii/S0828282X21007492) | Can J Cardiol, 38(2):160-168. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2Fa63e02c581425a038d410a32e0c3a747bf4754c6%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/a63e02c581425a038d410a32e0c3a747bf4754c6)
| Dyskalemia | [A Deep-Learning Algorithm (ECG12Net) for Detecting Hypokalemia and Hyperkalemia by Electrocardiography: Algorithm Development](https://medinform.jmir.org/2020/3/e15931/) | JMIR Med Inform, 8(3):e15931. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2F8296e995198e06a8026ce6a45b9bdeebdd1b099a%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/8296e995198e06a8026ce6a45b9bdeebdd1b099a)
