//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by JUNGINJAE on 2018. 6. 4..
//  Copyright © 2018년 JUNGINJAE. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {
    // 콘텐츠 데이터를 저장하는 변수
    var param : MemoData?
    @IBOutlet var subject: UILabel!
    @IBOutlet var contents: UILabel!
    @IBOutlet var img: UIImageView!
    
    override func viewDidLoad() {
        // 1. 제목과 내용 이미지를 출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        // 2. 날짜 포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        // 3. 내비게이션 타이틀에 날짜 표시
        self.navigationItem.title = dateString
    }
}
