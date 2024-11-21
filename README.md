# AXI-communications


# Bus Architecture


![image](https://github.com/user-attachments/assets/f2515db3-ddb3-4e1f-b402-5a8f6d14094b)


  1.AXI design


  下圖為本次 AXI 的架構，包含兩個主設備（Master 0 和 Master 1）以及兩個從屬設備（Slave 0和Slave 1），其中箭頭表示通道的資料流向。Master 0 負責與從屬設備進行讀取Instruction的動作，從 Slave 0 中獲取Instruction的資料進行後續CPU解碼運算；Master 1 則負責與從屬設備進行寫入或存取的Slave 1的動作，像CPU運算完的結果存入Data memory或讀取Data memory 資料進行運算。
        在 AXI 協議中，讀取和寫入操作透過多個不同的Channel來實現，在本設計中這些Channel包括AR Channel、R Channel、AW Channel、W Channel和B Channel。在AR Channel中為發送讀取SRAM資料的地址，R Channel為讀取SRAM傳送的資料，AW Channel為寫入為SRAM資料的地址，W Channel為寫入SRAM的資料，B Channel為寫入操作的結果進行回應，其中每一個Channel會透過VALID和READY 這種handshake機制確保master端和slave端之間訊息的交握。


![image](https://github.com/user-attachments/assets/57462c70-f264-4181-83b1-f25d6d749210)



2.CPU Wrapper design


Fig 1.為M0的狀態機，主要是負責Instruction memory取值的部分，首先當Reset訊號來時，會進入INITIAL state中，進行初始化動作，接著在Reset訊號結束時則會跳至IDLE state，在此狀態主要是閒置狀態，準備接收新的讀取請求，在條件成立時下一個clock進入READ ADDRESS state，此時ARVALID訊號會拉高，並且進入SRAM取值的狀態，所以整個CPU會暫停動作，直到完成取值，在條件成立時下一個clock進入READ DATA state，此時RREADY訊號會拉高，在此狀態下會進行SRAM取值並且將資料傳至CPU進行解碼運算，在下一個clock回到IDLE state，CPU暫停結束，完成一次M0與SRAM資料交握。
Fig 2.為M1的狀態機，主要是負責Data memory取值與存值的部分。在Data memory取值的部分，首先當Reset訊號來時，會進入INITIAL state中，進行初始化動作，接著在Reset訊號結束時則會跳至IDLE state，在此狀態主要是閒置狀態，準備接收新的讀取請求，在條件成立時下一個clock進入READ ADDRESS state，此時ARVALID訊號會拉高，並且進入SRAM取值的狀態，所以整個CPU會暫停動作，直到完成取值，在條件成立時下一個clock進入READ DATA state，此時RREADY訊號會拉高，在此狀態下會進行SRAM取值並且將資料傳至CPU進行解碼運算，在條件成立時下一個clock回到IDLE state，CPU暫停結束，完成Data memory取值。在Data memory存值的部分，當CPU計算完的結果要存入SRAM時，寫入訊號DM_WEN_BIT和DM_write_en決定是否進入WRITE_ADDRESS state，當在WRITE_ADDRESS state時，AWVALID訊號會拉高，傳送要寫入SRAM的地址，在條件成立時下一個clock會進入WRITE_DATA state，WVALID訊號會拉高，將要寫入SRAM資料傳輸，並且WLAST訊號會拉高，即表示傳輸最後一筆數據，在條件成立時下一個clock會進入WRITE_RESPONSE  state，當接收到BVALID時即表示SRAM已完成寫入動作，此時拉高BREDAY及會在下一個clock回到IDLE state。


![image](https://github.com/user-attachments/assets/156da76f-f4d0-40cc-9ff0-8faa3d683139)

Fig 1.


![image](https://github.com/user-attachments/assets/dd59e3e8-e090-4cc2-9484-44dcf63f31b1)

Fig 2.




  



