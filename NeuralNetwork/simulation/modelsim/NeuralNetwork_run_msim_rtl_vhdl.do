transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/adder_16bit.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/multiplier_8bit.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/perceptron.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/storage_datapath.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/RAM.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/layerConnections.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/reg_file.vhd}
vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/pLayer.vhd}
vlib hps
vmap hps hps

vcom -93 -work work {C:/Users/Sparkles/Documents/Rowan/Senior/Spring/ComplexDig/Project/NeuralNetworks/LayerConnections_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -L hps -voptargs="+acc"  LayerConnections_tb

add wave *
view structure
view signals
run -all
