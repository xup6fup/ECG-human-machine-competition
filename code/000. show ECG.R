
library(magrittr)
library(rsvg)
library(OpenImageR)
library(imager)

# Path

selected_ecg_path <- 'ecg/0012f4de4fb5910c230dbfa455a59143.csv'
SVG_CODE_path <- 'svg_code.RData'

out_svg_path <- 'result/0012f4de4fb5910c230dbfa455a59143.svg'
out_png_path <- 'result/0012f4de4fb5910c230dbfa455a59143.png'

# Functions

SVG_FUNC <- function (ecg_list,
                      emp_list = c('Rate' = '', 'PR' = '', 'QRSd' = '', 'QT' = '', 'QTc' = '', 'Axes_P' = '', 'Axes_QRS' = '', 'Axes_T' = ''),
                      department = 'Unknown',
                      show_full = FALSE) {
  
  line_pos.basic = c("leadI" = 210, "leadII" = 219, "leadIII" = 228,
                     "leadaVR" = 237, "leadaVL" = 243, "leadaVF" = 249,
                     "leadV1" = 255, "leadV2" = 261, "leadV3" = 267,
                     "leadV4" = 273, "leadV5" = 279, "leadV6" = 285,
                     "rhythmII" = 291)
  
  line_pos.standard = c("leadI" = 224, "leadII" = 233, "leadIII" = 242,
                        "leadaVR" = 251, "leadaVL" = 260, "leadaVF" = 269,
                        "leadV1" = 278, "leadV2" = 287, "leadV3" = 296,
                        "leadV4" = 305, "leadV5" = 314, "leadV6" = 323)
  
  wavedata_code.1 = '      <path id=\"wavedata\" style=\"fill:none;stroke:black\" stroke-width=\"3\" d=\"M 0 0 L '
  wavedata_code.2 = '\" />'
  
  for (i in 1:12) {
    if (length(ecg_list[[i]]) >= 5000) {
      ecg_list[[i]] <- ecg_list[[i]][1:5000]
    } else {
      ecg_list[[i]] <- c(ecg_list[[i]], rep(0, 5000 - length(ecg_list[[i]])))
    }
  }
  
  if (show_full) {
    
    #Get the standard code
    
    svg_code <- svg_standard_code
    
    # Department
    
    svg_code[38] <- paste0('    <text x=\"2325\" y=\"50\" id=\"departmentname\">', department, '</text>')
    
    # ECG morphalogy
    
    svg_code[55] <- paste0('    <text x=\"200\" y=\"0\" fill=\"black\" id=\"heartrate\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Rate']], '</text>')
    svg_code[57] <- paste0('    <text x=\"200\" y=\"40\" fill=\"black\" id=\"print\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['PR']], '</text>')
    svg_code[59] <- paste0('    <text x=\"200\" y=\"80\" fill=\"black\" id=\"qrsdur\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['QRSd']], '</text>')
    svg_code[61] <- paste0('    <text x=\"200\" y=\"120\" fill=\"black\" id=\"qtint\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['QT']], '</text>')
    svg_code[63] <- paste0('    <text x=\"200\" y=\"200\" fill=\"black\" id=\"qtcb\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['QTc']], '</text>')
    svg_code[66] <- paste0('    <text x=\"200\" y=\"270\" fill=\"black\" id=\"pfrontaxis\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Axes_P']], '</text>')
    svg_code[68] <- paste0('    <text x=\"200\" y=\"310\" fill=\"black\" id=\"qrsfrontaxis\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Axes_QRS']], '</text>')
    svg_code[70] <- paste0('    <text x=\"200\" y=\"350\" fill=\"black\" id=\"tfrontaxis\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Axes_T']])
    
    # ECG wave
    
    for (i in 1:12) {
      
      seq_dat.y = as.character(-ecg_list[[i]])
      seq_dat.x = formatC((1:length(seq_dat.y))/2, 2, format = 'f')
      seq_dat = paste0(wavedata_code.1, paste(paste(seq_dat.x, seq_dat.y), collapse = ' '), wavedata_code.2)
      svg_code[line_pos.standard[i]] = seq_dat
      
    }
    
  } else {
    
    #Get the basic code
    
    svg_code <- svg_basic_code
    
    # Department
    
    svg_code[35] <- paste0('    <text x=\"2325\" y=\"50\" id=\"departmentname\">', department, '</text>')
    
    # ECG morphalogy
    
    svg_code[52] <- paste0('    <text x=\"200\" y=\"0\" fill=\"black\" id=\"heartrate\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Rate']], '</text>')
    svg_code[54] <- paste0('    <text x=\"200\" y=\"40\" fill=\"black\" id=\"print\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['PR']], '</text>')
    svg_code[56] <- paste0('    <text x=\"200\" y=\"80\" fill=\"black\" id=\"qrsdur\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['QRSd']], '</text>')
    svg_code[58] <- paste0('    <text x=\"200\" y=\"120\" fill=\"black\" id=\"qtint\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['QT']], '</text>')
    svg_code[60] <- paste0('    <text x=\"200\" y=\"200\" fill=\"black\" id=\"qtcb\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['QTc']], '</text>')
    svg_code[63] <- paste0('    <text x=\"200\" y=\"270\" fill=\"black\" id=\"pfrontaxis\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Axes_P']], '</text>')
    svg_code[65] <- paste0('    <text x=\"200\" y=\"310\" fill=\"black\" id=\"qrsfrontaxis\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Axes_QRS']], '</text>')
    svg_code[67] <- paste0('    <text x=\"200\" y=\"350\" fill=\"black\" id=\"tfrontaxis\" text-anchor=\"end\" visibility=\"visible\">', emp_list[['Axes_T']], '</text>')
    
    # ECG wave
    
    ecg_list[[13]] <- ecg_list[[2]]
    for (i in 1:3) {ecg_list[[i]] <- ecg_list[[i]][1:1250]}
    for (i in 4:6) {ecg_list[[i]] <- ecg_list[[i]][1251:2500]}
    for (i in 7:9) {ecg_list[[i]] <- ecg_list[[i]][2501:3750]}
    for (i in 10:12) {ecg_list[[i]] <- ecg_list[[i]][3751:5000]}
    
    #Generate seq data
    
    for (i in 1:13) {
      
      seq_dat.y = as.character(-ecg_list[[i]])
      seq_dat.x = formatC((1:length(seq_dat.y))/2, 2, format = 'f')
      seq_dat = paste0(wavedata_code.1, paste(paste(seq_dat.x, seq_dat.y), collapse = ' '), wavedata_code.2)
      svg_code[line_pos.basic[i]] = seq_dat
      
    }
    
  }
  
  svg_code <- paste(svg_code, collapse = '\n')
  
  return(svg_code)
  
}

Show_svg_img <- function (SVG_code) {
  
  par(mai = rep(0, 4))
  plot(as.raster(rsvg(charToRaw(SVG_code), width = 1000, height = 762)))
  
}

# Load 

load(SVG_CODE_path)

# Read data

ECG_DATA <- read.csv(selected_ecg_path)
ECG_LIST <- as.list(ECG_DATA)

# Plotting

svg_code <- SVG_FUNC(ecg_list = ECG_LIST)

# Saving

cat(svg_code, file = out_svg_path)

png(filename = out_png_path, width = 1000, height = 762)
Show_svg_img(SVG_code = svg_code)
dev.off()

