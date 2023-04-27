
# ECG human-machine competition dataset

This dataset includes data from eight ECG-based human-machine competitions, designed to evaluate the performance of machine learning algorithms in detecting and diagnosing cardiovascular diseases. The dataset contains ECG recordings from multiple subjects, with corresponding annotations indicating the presence or absence of various cardiovascular diseases.

## Competitions

The dataset includes data from the following competitions:

1. Myocardial infarction
2. Arrhythmia
3. Pericarditis
4. Digoxin toxicity
5. Pneumothorax
6. Aortic dissection
7. Pulmonary embolism
8. Dyskalemia

## Data format

Each dataset is stored as a CSV file, with each row representing a single ECG recording. There are three CSV files "label.csv", "user_results.csv", and "AI_pred.csv" describing the groundtruth, human answer, and AI predictions. The columns of the CSV file include:

hash_id: The unique identifier for the ECG recording.

LABEL[...]: The groundtruth of corresponding ECG using 0 (without) and 1 (with). The labels column contains a list of labels indicating the presence or absence of cardiovascular diseases, as determined by human experts or medical records.

DOCTOR_ID: The human's specialty and level of experience.
USER_ANSWER[...]: The answer given by human corresponding to the ECG recording using 0 (without) and 1 (with).

AI[...]: The predictions given by the baseline models, which was a likelihood ranged 0 to 1.

The signal column contains the raw ECG recording, with each value representing the amplitude of the ECG signal at a given time point. All ECGs are 12-lead and 10 seconds with 500 Hz. Therefore, the length of number sequence is 5,000 for each lead. The unit of value is 0.01 mV, which is the standard Philip record system. 

### Related publication

| Dataset | Title                                                        | Paper                  | Citation |
| ------- | ------------------------------------------------------------ | ---------------------- | -------- |
| Dyskalemia | [A Deep-Learning Algorithm (ECG12Net) for Detecting Hypokalemia and Hyperkalemia by Electrocardiography: Algorithm Development](https://medinform.jmir.org/2020/3/e15931/) | JMIR Med Inform, 8(3):e15931. | [![citation](https://img.shields.io/badge/dynamic/json?label=citation&query=citationCount&url=https%3A%2F%2Fapi.semanticscholar.org%2Fgraph%2Fv1%2Fpaper%2F8296e995198e06a8026ce6a45b9bdeebdd1b099a%3Ffields%3DcitationCount)](https://www.semanticscholar.org/paper/A-Gentle-Introduction-to-Graph-Neural-Networks-S%C3%A1nchez-Lengeling-Reif/8296e995198e06a8026ce6a45b9bdeebdd1b099a)
