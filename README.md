# AXI-communications


# Bus Architecture

  1.AXI design


  下圖為本次 AXI 的架構，包含兩個主設備（Master 0 和 Master 1）以及兩個從屬設備（Slave 0和Slave 1），其中箭頭表示通道的資料流向。Master 0 負責與從屬設備進行讀取Instruction的動作，從 Slave 0 中獲取Instruction的資料進行後續CPU解碼運算；Master 1 則負責與從屬設備進行寫入或存取的Slave 1的動作，像CPU運算完的結果存入Data memory或讀取Data memory 資料進行運算。
        在 AXI 協議中，讀取和寫入操作透過多個不同的Channel來實現，在本設計中這些Channel包括AR Channel、R Channel、AW Channel、W Channel和B Channel。在AR Channel中為發送讀取SRAM資料的地址，R Channel為讀取SRAM傳送的資料，AW Channel為寫入為SRAM資料的地址，W Channel為寫入SRAM的資料，B Channel為寫入操作的結果進行回應，其中每一個Channel會透過VALID和READY 這種handshake機制確保master端和slave端之間訊息的交握。


  ![image](https://github.com/user-attachments/assets/2458a541-aa87-4c36-b10b-10177bfef353)

  



