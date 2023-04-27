
library(magrittr)
library(pROC)
library(ggplot2)
library(cowplot)

# Path

plot_path <-  'result/myocardial infarction.png'

label_path <-  'data/myocardial infarction/label.csv'
user_path <-  'data/myocardial infarction/user_results.csv'
AI_path <-  'data/myocardial infarction/AI_pred.csv'

# Read data

READ_DATA <- function (filename) {
  
  data <- read.csv(filename)
  
  headers <- readLines(filename, n = 1)
  headers <- strsplit(headers, split = ',') %>% unlist %>% gsub('"', '', .)
  
  colnames(data) <- headers
  
  return(data)
  
}

label <- READ_DATA(label_path)
user <- READ_DATA(user_path)
AI <- READ_DATA(AI_path)

# Plot-0 Legend

legend_data <- data.frame(x = 1, y = 3.5, name = 'CV-V', shape = 22, fill = '#E64B35B2')
legend_data <- rbind(legend_data, data.frame(x = 2, y = 3.5, name = 'ER-V', shape = 22, fill = '#F39B7FB2'))
legend_data <- rbind(legend_data, data.frame(x = 1, y = 2.5, name = 'CV-R', shape = 23, fill = '#91D1C2B2'))
legend_data <- rbind(legend_data, data.frame(x = 2, y = 2.5, name = 'ER-R', shape = 23, fill = '#4DBBD5B2'))
legend_data <- rbind(legend_data, data.frame(x = 3, y = 2.5, name = 'R', shape = 23, fill = '#3C5488B2'))
legend_data <- rbind(legend_data, data.frame(x = 1, y = 1.5, name = 'PGY', shape = 24, fill = '#00A087B2'))
legend_data <- rbind(legend_data, data.frame(x = 2, y = 1.5, name = 'M', shape = 24, fill = '#7E6148B2'))

## Legend plot

legend_p <- ggplot(legend_data, aes(x = x, y = y))
legend_p <- legend_p + geom_text(label = legend_data[,'name'], color = 'black', size = 4, fontface = 1, hjust = 0)
legend_p <- legend_p + ylim(c(0.5, 4.5))
legend_p <- legend_p + xlim(c(0.5, 3.5))
legend_p <- legend_p + ggtitle('')
legend_p <- legend_p + theme(plot.title = element_text(color = "#000000", size = 7), legend.position = "none")
legend_p <- legend_p + theme_void()
legend_p <- legend_p + annotate(geom = "point",
                                x = legend_data[,'x'] - 0.2,
                                y = legend_data[,'y'],
                                shape = legend_data[,'shape'],
                                size = 3,
                                fill = legend_data[,'fill'],
                                color = '#000000A0')

# Plot-1 STEMI

## Generate label and prediction

label[,'y1'] <- apply(label[,c('LABEL[STEMI-LAD]', 'LABEL[STEMI-LCx]', 'LABEL[STEMI-LMCA]', 'LABEL[STEMI-RCA]'),drop = FALSE], 1, sum)
AI[,'x1'] <- apply(AI[,c('AI[STEMI-LAD]', 'AI[STEMI-LCx]', 'AI[STEMI-LMCA]', 'AI[STEMI-RCA]'),drop = FALSE], 1, sum)
label <- merge(label, unique(AI[,c('hash_id', 'x1')]), by = 'hash_id', all.x = TRUE)

## Generate user accuracy

user[,'x1'] <- apply(user[,c('USER_ANSWER[STEMI-LAD]', 'USER_ANSWER[STEMI-LCx]', 'USER_ANSWER[STEMI-LMCA]', 'USER_ANSWER[STEMI-RCA]'),drop = FALSE], 1, sum)
user <- merge(user, unique(label[,c('hash_id', 'y1')]), by = 'hash_id', all.x = TRUE)

TP <- tapply(user[,'x1'] %in% 1 & user[,'y1'] %in% 1, user[,'DOCTOR_ID'], sum)
FP <- tapply(user[,'x1'] %in% 1 & user[,'y1'] %in% 0, user[,'DOCTOR_ID'], sum)
FN <- tapply(user[,'x1'] %in% 0 & user[,'y1'] %in% 1, user[,'DOCTOR_ID'], sum)
TN <- tapply(user[,'x1'] %in% 0 & user[,'y1'] %in% 0, user[,'DOCTOR_ID'], sum)

user_summary <- data.frame(user = names(TP),
                           sens = TP / (TP + FN),
                           spec = TN / (FP + TN),
                           stringsAsFactors = FALSE)

user_summary[grepl('V[0-9]', user_summary[,'user']),'shape'] <- 22
user_summary[grepl('R[0-9]', user_summary[,'user']),'shape'] <- 23
user_summary[grepl('PGY[0-9]', user_summary[,'user']),'shape'] <- 24
user_summary[grepl('M[0-9]', user_summary[,'user']),'shape'] <- 24

user_summary[grepl('R[0-9]', user_summary[,'user']),'fill'] <- '#3C5488B2'
user_summary[grepl('PGY[0-9]', user_summary[,'user']),'fill'] <- '#00A087B2'
user_summary[grepl('M[0-9]', user_summary[,'user']),'fill'] <- '#7E6148B2'
user_summary[grepl('CV\\-R', user_summary[,'user']),'fill'] <- '#91D1C2B2'
user_summary[grepl('ER\\-R', user_summary[,'user']),'fill'] <- '#4DBBD5B2'
user_summary[grepl('CV\\-V', user_summary[,'user']),'fill'] <- '#E64B35B2'
user_summary[grepl('ER\\-V', user_summary[,'user']),'fill'] <- '#F39B7FB2'

## ROC curve

roc_curve <- roc(response = label[,'y1'], predictor = label[,'x1'])

roc_data <- data.frame(spec = roc_curve[['specificities']], sens = roc_curve[['sensitivities']])
roc_data <- rbind(data.frame(spec = 0, sens = 1), roc_data, data.frame(spec = 1, sens = 0))
rownames(roc_data) <- 1:nrow(roc_data)

roc_p.1 <- ggplot(data = roc_data, aes(x = spec, y = sens))
roc_p.1 <- roc_p.1 + geom_line(colour = '#000000A0', size = 1)
roc_p.1 <- roc_p.1 + theme_bw()
roc_p.1 <- roc_p.1 + coord_equal()
roc_p.1 <- roc_p.1 + ggtitle('STEMI vs. not-STEMI') + xlab('Specificity') + ylab('Sensitivity')

roc_p.1 <- roc_p.1 + annotate(geom = "point",
                              x = user_summary[,'spec'],
                              y = user_summary[,'sens'],
                              shape = user_summary[,'shape'],
                              size = 3,
                              fill = user_summary[,'fill'],
                              color = '#000000A0')

roc_p.1 <- roc_p.1 + theme(plot.title = element_text(color = "#000000", size = 14),
                           axis.title = element_text(color = "#000000", size = 12),
                           legend.position = "none")

# Plot-2 NSTEMI

## Generate label and prediction

label[,'y2'] <- apply(label[,c('LABEL[NSTEMI]'),drop = FALSE], 1, sum)
AI[,'x2'] <- apply(AI[,c('AI[NSTEMI]'),drop = FALSE], 1, sum)
label <- merge(label, unique(AI[,c('hash_id', 'x2')]), by = 'hash_id', all.x = TRUE)

## Generate user accuracy

user[,'x2'] <- apply(user[,c('USER_ANSWER[NSTEMI]'),drop = FALSE], 1, sum)
user <- merge(user, unique(label[,c('hash_id', 'y2')]), by = 'hash_id', all.x = TRUE)

TP <- tapply(user[,'x2'] %in% 1 & user[,'y2'] %in% 1, user[,'DOCTOR_ID'], sum)
FP <- tapply(user[,'x2'] %in% 1 & user[,'y2'] %in% 0, user[,'DOCTOR_ID'], sum)
FN <- tapply(user[,'x2'] %in% 0 & user[,'y2'] %in% 1, user[,'DOCTOR_ID'], sum)
TN <- tapply(user[,'x2'] %in% 0 & user[,'y2'] %in% 0, user[,'DOCTOR_ID'], sum)

user_summary <- data.frame(user = names(TP),
                           sens = TP / (TP + FN),
                           spec = TN / (FP + TN),
                           stringsAsFactors = FALSE)

user_summary[grepl('V[0-9]', user_summary[,'user']),'shape'] <- 22
user_summary[grepl('R[0-9]', user_summary[,'user']),'shape'] <- 23
user_summary[grepl('PGY[0-9]', user_summary[,'user']),'shape'] <- 24
user_summary[grepl('M[0-9]', user_summary[,'user']),'shape'] <- 24

user_summary[grepl('R[0-9]', user_summary[,'user']),'fill'] <- '#3C5488B2'
user_summary[grepl('PGY[0-9]', user_summary[,'user']),'fill'] <- '#00A087B2'
user_summary[grepl('M[0-9]', user_summary[,'user']),'fill'] <- '#7E6148B2'
user_summary[grepl('CV\\-R', user_summary[,'user']),'fill'] <- '#91D1C2B2'
user_summary[grepl('ER\\-R', user_summary[,'user']),'fill'] <- '#4DBBD5B2'
user_summary[grepl('CV\\-V', user_summary[,'user']),'fill'] <- '#E64B35B2'
user_summary[grepl('ER\\-V', user_summary[,'user']),'fill'] <- '#F39B7FB2'

## ROC curve

roc_curve <- roc(response = label[,'y2'], predictor = label[,'x2'])

roc_data <- data.frame(spec = roc_curve[['specificities']], sens = roc_curve[['sensitivities']])
roc_data <- rbind(data.frame(spec = 0, sens = 1), roc_data, data.frame(spec = 1, sens = 0))
rownames(roc_data) <- 1:nrow(roc_data)

roc_p.2 <- ggplot(data = roc_data, aes(x = spec, y = sens))
roc_p.2 <- roc_p.2 + geom_line(colour = '#000000A0', size = 1)
roc_p.2 <- roc_p.2 + theme_bw()
roc_p.2 <- roc_p.2 + coord_equal()
roc_p.2 <- roc_p.2 + ggtitle('NSTEMI vs. not-NSTEMI') + xlab('Specificity') + ylab('Sensitivity')

roc_p.2 <- roc_p.2 + annotate(geom = "point",
                              x = user_summary[,'spec'],
                              y = user_summary[,'sens'],
                              shape = user_summary[,'shape'],
                              size = 3,
                              fill = user_summary[,'fill'],
                              color = '#000000A0')

roc_p.2 <- roc_p.2 + theme(plot.title = element_text(color = "#000000", size = 14),
                           axis.title = element_text(color = "#000000", size = 12),
                           legend.position = "none")

# Merge plot

final_p <- ggdraw()
final_p <- final_p + draw_plot(roc_p.1, x = 0, y = 0, width = 0.4, height = 1)
final_p <- final_p + draw_plot(roc_p.2, x = 0.4, y = 0, width = 0.4, height = 1)
final_p <- final_p + draw_plot(legend_p, x = 0.8, y = 0, width = 0.2, height = 1)

png(filename = plot_path, width = 875, height = 350)
print(final_p)
dev.off()
