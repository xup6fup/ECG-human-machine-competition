
# ECG human-machine competition dataset

This dataset includes data from eight ECG-based human-machine competitions, designed to evaluate the performance of machine learning algorithms in detecting and diagnosing cardiovascular diseases. The dataset contains ECG recordings from multiple subjects, with corresponding annotations indicating the presence or absence of various cardiovascular diseases.

## Data format

Each dataset is stored as a CSV file, with each row representing a single ECG recording. There are three CSV files **"label.csv"**, **"user_results.csv"**, and **"AI_pred.csv"** describing the groundtruth, human answer, and AI predictions. The columns of the CSV file include:

**hash_id**: The unique identifier for the ECG recording.

### label.csv

**LABEL[...]**: The groundtruth of corresponding ECG using 0 (without) and 1 (with). The labels column contains a list of labels indicating the presence or absence of cardiovascular diseases, as determined by human experts or medical records.

### user_results.csv

**DOCTOR_ID**: The human's specialty and level of experience. **CV** means cardiologist; **ER** means emergency physicians; **V[..]** means the year of attending physician;  **R[..]** means the year of resident; **PGY[..]** means the year of post graduate year;  **M[..]** means the grade of medical students.  

**USER_ANSWER[...]**: The answer given by human corresponding to the ECG recording using 0 (without) and 1 (with).

### AI_pred.csv

**AI[...]**: The predictions given by the baseline models, which was a likelihood ranged 0 to 1.

The signal column contains the raw ECG recording, with each value representing the amplitude of the ECG signal at a given time point. All ECGs are 12-lead and 10 seconds with 500 Hz. Therefore, the length of number sequence is 5,000 for each lead. The unit of value is 0.01 mV, which is the standard Philip record system. 

The overall file structure is as follows:

```shell
ECG-human-machine-competition
├── result
│   ├── ...
├── ecg
│   ├── 0a5e481205fb668d8d60f6f99a6500b1.csv
│   ├── ...
│   ├── ffcc3cddec66e58ff7952b254844e2a5.csv
├── data
│   ├── myocardial infarction
│   │   ├── AI_pred.csv
│   │   ├── label.csv
│   │   ├── user_results.csv
│   ├── arrhythmia
│   │   ├── ...
│   ├── pericarditis
│   │   ├── ...
│   ├── digoxin concentration
│   │   ├── ...
│   ├── pneumothorax
│   │   ├── ...
│   ├── aortic dissection
│   │   ├── ...
│   ├── pulmonary embolism
│   │   ├── ...
│   ├── dyskalemia
│   │   ├── ...
├── code
│   ├── 000. show ECG.R
│   ├── 001. myocardial infarction.R
│   ├── ...
│   ├── 008. dyskalemia.R
```

**Note: The raw data is expected to be published in August 2023**

## Competitions

The dataset includes data from the following competitions:

**1. Myocardial infarction**

Acute myocardial infarction (AMI) is a critical medical emergency that requires urgent and specialized attention. It is caused by the sudden blockage of a coronary artery, resulting in the loss of blood supply to the heart muscle. This can lead to severe and potentially irreversible damage to the heart, with serious consequences such as heart failure, arrhythmias, or even death. It is essential to recognize the signs and symptoms of AMI, including chest pain or discomfort, shortness of breath, nausea or vomiting, and lightheadedness or dizziness. Timely diagnosis and appropriate treatment are critical for improving outcomes and reducing the risk of complications. This may include interventions such as percutaneous coronary intervention (PCI), thrombolytic therapy, or coronary artery bypass grafting (CABG), as well as ongoing medical management and lifestyle modifications. Overall, the importance of AMI lies in its potential to cause significant morbidity and mortality, highlighting the need for timely and effective management to optimize patient outcomes.

Electrocardiogram (ECG) is a fundamental tool for the diagnosis of AMI. The ECG allows healthcare professionals to detect and analyze changes in the electrical activity of the heart that occur during an AMI, such as ST-segment elevation or depression, Q waves, or T-wave inversions. These changes can provide valuable information about the location, extent, and severity of the myocardial damage, which can guide treatment decisions and prognosis. ECG is also critical for differentiating AMI from other cardiac and non-cardiac conditions that may mimic its symptoms, such as unstable angina, pericarditis, or pulmonary embolism. Rapid ECG interpretation and reporting are essential for timely diagnosis and initiation of appropriate management, which can significantly improve outcomes and reduce morbidity and mortality. Therefore, the ECG is a vital tool for the diagnosis of AMI and should be performed promptly in all patients presenting with suggestive symptoms.

This dataset contains 175 STEMI ECGs (n. STEMI-LMCA = 2; n. STEMI-LAD = 95; n. STEMI-LCx = 12; n. STEMI-RCA = 66), 137 NSTEMI ECGs, and 138 not-AMI ECGs. All ECGs were obtained from the emergency department, while STEMI and NSTEMI were annotated by follow-up cardiac catheterization results. The baseline model has been published in [EuroIntervention, 17(9):765-773.](https://eurointervention.pcronline.com/article/a-deep-learning-algorithm-for-detecting-acute-myocardial-infarction). Using the sum of four STEMI likelihood (AI[STEMI-LMCA] + AI[STEMI-LAD] + AI[STEMI-LCx] + AI[STEMI-RCA]) to distinguish STEMI (LABEL[STEMI-LMCA] + LABEL[STEMI-LAD] + LABEL[STEMI-LCx] + LABEL[STEMI-RCA]) or not (LABEL[NSTEMI] + LABEL[Normal]), an area under receiver operating characteristic curve (AUC) of 0.9717 will be presented. There are some tricks to improve this AUC, like adding up the likelihood of NSTEMI. Therefore, the AUC here is different with the published paper. However, this simple example still can be used as a reference for future benchmark. The AUC is 0.8586 using the likelihood of NSTEMI (AI[NSTEMI]) to identify NSTEMI (LABEL[NSTEMI]). The ROC curve and human accuracies were shown as follows.

<img src="result/myocardial infarction.png" width="875px"/>

**2. Arrhythmia**

<img src="result/arrhythmia.png" width="1000px"/>

**3. Pericarditis**

This dataset contains 17 pericarditis ECGs (LABEL[Pericarditis]) and 70 not-pericarditis ECGs (LABEL[Normal]). All ECGs were obtained from the emergency department and the annotations were defined by review of medical records. The baseline model has been published in [J Pers Med, 12(7):1150.](https://www.mdpi.com/2075-4426/12/7/1150). Using the likelihood of pericarditis (AI[Pericarditis]), the area under receiver operating characteristic curve (AUC) is 0.9437, which is in full agreement with the previous study. The ROC curve and human accuracies were shown as follows.

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

Dyskalemia, an abnormal serum potassium level, is an essential electrolyte disturbance that can lead to severe and life-threatening consequences if left untreated. Potassium plays a vital role in various physiological processes, including cardiac and neuromuscular function, acid-base balance, and renal function. Therefore, dyskalemia can affect multiple organ systems and cause a range of clinical manifestations, such as cardiac arrhythmias, muscle weakness, renal impairment, and gastrointestinal disturbances. Dyskalemia can result from various factors, such as medications, renal impairment, endocrine disorders, or acid-base disturbances. Monitoring and managing serum potassium levels are crucial to preventing and treating dyskalemia, depending on the underlying cause and severity of the disturbance. Treatment options may include dietary modifications, medication adjustments, intravenous or oral potassium supplementation, or other interventions such as renal replacement therapy or dialysis. The importance of dyskalemia lies in its potential to cause significant morbidity and mortality, highlighting the need for early recognition, prompt management, and close monitoring to optimize patient outcomes.

Electrocardiogram (ECG) is a valuable tool for diagnosing and monitoring dyskalemia, an abnormal serum potassium level. Potassium is essential for the proper functioning of cardiac myocytes, and even minor fluctuations in serum potassium levels can lead to significant changes in cardiac electrical activity. As such, dyskalemia can cause various ECG abnormalities, including peaked T waves, prolonged QT interval, ST segment changes, and even ventricular arrhythmias. These ECG changes can provide important clues to the diagnosis of dyskalemia and guide the management of the condition. ECG monitoring is especially important in patients at risk of dyskalemia, such as those with renal insufficiency, endocrine disorders, or taking medications that can affect potassium homeostasis. Timely recognition of dyskalemia through ECG can allow for early intervention to prevent potentially life-threatening complications such as cardiac arrhythmias or sudden cardiac death. Therefore, ECG is a crucial tool for the diagnosis and management of dyskalemia, and healthcare professionals should be vigilant in monitoring ECG changes in patients at risk of this electrolyte disturbance.

This dataset contains 60 severe hypokalemia (LABEL[K: <= 2.5]), 60 mild-to-moderate hypokalemia (LABEL[K: 2.5 ~ 3.5]), 60 normokalemia (LABEL[K: 3.5 ~ 5.5]), 60 mild-to-moderate hyperkalemia (LABEL[K: 5.5 ~ 6.5]), and 60 severe hyperkalemia (LABEL[K: >= 6.5]). All ECGs were obtained from the emergency department and the potassium level were annotated by the central laboratory reports within 1 hour. This competition was first appeared in [JMIR Med Inform, 8(3):e15931.](https://medinform.jmir.org/2020/3/e15931/), however, the model here is an unpublished improved version. The area under receiver operating characteristic curves (AUCs) for detecting severe hypokalemia, mild-to-severe hypokalemia, mild-to-severe hyperkalemia, and severe hypokalemia were 0.9561, 0.9226, 0.9128, and 0.8342, respectively. They are different with previous publication since the details of analysis is different. For example, the paper mentioned above using LABEL[K: >= 6.5] vs. LABEL[K: <= 2.5]+LABEL[K: 2.5 ~ 3.5]+LABEL[K: 3.5 ~ 5.5] to achieve an AUC of 0.976, but here we use LABEL[K: >= 6.5]+LABEL[K: 5.5 ~ 6.5] vs. LABEL[K: <= 2.5]+LABEL[K: 2.5 ~ 3.5]+LABEL[K: 3.5 ~ 5.5] to achieve an AUC of 0.8342. Compared to the previous prospective validation pubished in [npj Digital Medicine, 5(1):8.](https://www.nature.com/articles/s41746-021-00550-0), the lower accuracy of this data set is due to the different distribution of potassium ion concentration. Normally, more than 80% of the cases should have a potassium ion concentration between 3.5 and 5.5, and it is easy for the model to identify them. The ROC curve of this benchmark were shown as follows.

<img src="result/dyskalemia.png" width="875px"/>

## Codes

The folder **"code"** contains the code to draw ROC plot for each dataset. Moreover, an ECG is also provided as following using a SVG format.

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
