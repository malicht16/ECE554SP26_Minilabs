module bus_interface(
    inout logic [7:0] databus,
    input       [7:0] rec_buffer,
    input       [1:0] ioaddr,
    input             rda,
    input             tbr,
    input             iocs,
    input             iorw
);

    // https://stackoverflow.com/questions/40902637/how-to-write-to-inout-port-and-read-from-inout-port-of-the-same-module

    logic [7:0] databus_driver;

    // When iorw is LOW, we are writing - so databus will be set to rec_buffer
    // When iorw is high, we are reading
    //assign databus = (~iorw | rda) ? rec_buffer : 8'bz; 
    assign databus = databus_driver;
    always_comb begin
        case (ioaddr)
            2'b00: databus_driver = (~iorw | rda) ? rec_buffer : 8'bz; //either writing data or reading data
            2'b10: databus_driver = rec_buffer;    //sending low byte
            2'b11: databus_driver = rec_buffer;    //sending high byte
            default: databus_driver = 8'bz; 
        endcase
    end

    //assign trans_control = ((ioaddr == 2'b00) && ~iorw);
    //assign receive_control = ((ioaddr == 2'b00) && iorw);
    //assign trans_buffer = ((ioaddr == 2'b00) && ~iorw) ? databus : 8'b0;

endmodule