//
//  MemoListVC.swift
//  MyMemory
//
//  Created by JUNGINJAE on 2018. 6. 4..
//  Copyright © 2018년 JUNGINJAE. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {
    // 앱 델리게이트 객체의 참조 정보를 읽어온다.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 테이블 뷰의 셀 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memoList.count
        return count
    }

    // 테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼냄
        let row = self.appDelegate.memoList[indexPath.row]
        
        // 2. 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 3. 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받음
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MemoCell
        
        // 4. memoCell의 내용을 구성한다.
        cell?.subject?.text = row.title
        cell?.contents?.text = row.contents
        cell?.img?.image = row.image
        
        // 5. Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell?.regdate?.text = formatter.string(from: row.regdate!)
        
        // 6. cell 객체를 리턴
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("세그웨이 시작")
        if segue.identifier == "read_sg" {
            print("세그웨이 실행 성공")
            if let destination = segue.destination as? MemoReadVC {
                if let selectIndex = self.tableView.indexPathForSelectedRow?.row {
                    destination.param = self.appDelegate.memoList[selectIndex]
                }
            }
        }
    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        // 1. memolist 배열에서 선택된 행에 맞는 데이터를 꺼냄
//        let row = self.appDelegate.memoList[indexPath.row]
//
//        // 2. 상세 화면의 인스턴스를 생성
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else {
//            return
//        }
//
//        // 3. 값을 전달한 다음 상세화면으로 이동
//        vc.param = row
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    // 디바이스 스크린에 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        // 테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
        self.tableView.reloadData()
    }
}
