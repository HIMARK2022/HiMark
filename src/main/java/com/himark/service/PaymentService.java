package com.himark.service;


import java.util.List;

import com.himark.domain.BoardAttachVO;
import com.himark.domain.PaymentVO;

public interface PaymentService {
	public void register(PaymentVO payment);

	public List<PaymentVO> getList(String userId);
	
	public List<PaymentVO> getSearchList(List<String> filterList,String userId);
 
	public PaymentVO get(int requestNo);
	
	public void updateApprover(String userId);

	public List<PaymentVO> getPaymentList(String userId);

	public List<PaymentVO> getCompletePaymentList(String userId);

	public List<PaymentVO> getBackPaymentList(String userId);

	public void updateFdate(int requestNo, String imp);

	public void updateState(int requestNo, String state);

	public void updateReason(int requestNo, String reason);

	public List<PaymentVO> getCompleteList(String userId);

	public List<PaymentVO> getBackList(String userId);
	
	public List<String> getUpperCategory();
	
	public List<BoardAttachVO> getAttachList(int rno);

	public String getTempManager(String userId);

	public void register(PaymentVO payment, int requestNo);

	public List<String> getCategory();

	public List<String> getManager(int requestNo);

	public List<String> getUser(int requestNo);

	

}
