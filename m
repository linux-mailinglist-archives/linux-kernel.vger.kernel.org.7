Return-Path: <linux-kernel+bounces-881687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA583C28C17
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 09:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62F874E3718
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C61DDC2C;
	Sun,  2 Nov 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZyNHr8+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LRalQll1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0D265CC8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762071540; cv=none; b=cF7sZ7p266h/so46TGjJhOCpX3zy9toLiO/ANJSaFQEsNAOZ8wFmXaxE7V3zRHMH3pGFvUecU3SZDp3+bo1jvxgiDUNduzeZmZB62Tod0vuB2ksrAFNPUpD9gQEpxcnKTXbmlnk45SC3a+Z88uS+u4yX6LKz3IeuAYCRdx7DdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762071540; c=relaxed/simple;
	bh=Pj6fmxKR8ELWKjyF4djDBZSoVHYf8O5N6J21P/Eq6fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+chKoP97JQaquNDdPMKyoOGCCE6IZWDspBnVG0iK77v33NqpqdTtXqF2GGAL5lWZLdAwyTMmGR34uf8Z2mAbqIjhRooaw5lTyj8o+89YKiL+G1QmjKtTHTB6XHWTKXax0xSkjwaJXVPa9ScCmTd4pweBP9gDNsjUm8SsQCoTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZyNHr8+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LRalQll1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A25k20s3556438
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 08:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7cN9GjjRICyTwcxEqP7bIDDsK/QDYedKNAOkcRvp2I=; b=TZyNHr8+nIo3MW0/
	UiXPr7uHAj5xID0I5cMxqs5TEnP57kmJZeeLbk38Yqt3+kIX2Xo98obgsyM9JO0i
	n6QlAh6SazdHtFEtGX7o/o4PPOorA8tFfyOYSa6Xkq9U/Gd+X/XWZ+EEhosJgpP1
	9nje+BZc+D46QP6vD0pYuz0dEGbZOsofDd/+6uk9fcXeoTbrmHjBiAkmU0MbhJZY
	cUGEaCHamtZK+mEaQb4h503/GvvKVrjZ9UoGlpi9OC+yOTZ9WrKYBMRH52obIYZU
	jsRFa5K79oShnM8DQRX1VPy1xVW5LuTFKLEoRVXC7kY0KzQZF8xB7o6T+XEd/qV6
	dQWeZg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ayf9sh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 08:18:57 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a2885329beso3112227b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762071537; x=1762676337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7cN9GjjRICyTwcxEqP7bIDDsK/QDYedKNAOkcRvp2I=;
        b=LRalQll14XCL2nYtAvx3WJ/MDNl6RI8QXK/LWQUJFYKZdEj/y2hSA6lVmjR/CWiBMe
         XhjyzH2ouvmoG9Sl9ux0y3y+uGwD4FIDW8hgohS58j9eHjzlL2c8ncocFFLgG0iWix6t
         gXaptPlKBIGBndyT79PqZy8mKFBzgatUak8yBf5yfMED9JXpk2w2L1nAJXBeIj35CJqk
         Anc8rA8DrukgOoqPiRTBRZArninDUOQDs0SOFrFXE+OsbXM1u4MAInNTM4e/0aGDuvy3
         cMBeMsF5LLodJYo1uDqbroPe0n5Yrzp0XMEDWAnBJW47kcKqerYGEfCLWB5zmn+yXtLk
         trzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762071537; x=1762676337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7cN9GjjRICyTwcxEqP7bIDDsK/QDYedKNAOkcRvp2I=;
        b=RdCnnzATnmcvGWepc8ImwfgeUTZnUNkpuVhIUzMJGhL1MUBmpnxBKJ5BznWZefZtcT
         8+908BsoAIgegfqNhUYGp6Sir3gZ3fiOjQI4hU1dwFWs5xFyAWvbemh3aik3yTVNeoIv
         YzvKsmCtZPXauvvYvLMicDa7xys4ZJ7QHEQgl7D6RVCqpkEr+TSMPnSiYFqPZahqs8b/
         AzPcE+gQoM/xrIRe2vwfzEf14Gdq2OezhVNhnv2nQpcNkbIP7JPudkredtRS+8qJedAz
         KknkR33B7/VHemQAUmbPZuNp1dyE4hfZ5fqupeLNQQx4xAEzNxTY1iYcaCSTICI0PeSL
         RvqA==
X-Forwarded-Encrypted: i=1; AJvYcCUPzYkWGqFNFp+bCvo3BLbUnI9bsHSYmQXAAOLEbT/Bxt9abCp3Qn0PHzOivxRCpbqMM2Yto1ZbswIznXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBHLuo3ds5oNr8E/LVaHdxj65hRiL6be+k+9zvJrkw2I4EPPQQ
	nSXG8P+SJBthYmm02J8oxB18SmEeofMOuYf48Kb7eSSRHrFw7igw156Ab2qqC0g277//zFTHLwy
	Qal4YdrpLgSFeE5v3oPn+o/5TT8ER/5PwrPTPPycd4ZaOhP/a08frQFDGP2ZRENzFn07nbllak0
	s=
X-Gm-Gg: ASbGnct1Y+q8pIxsIWP1FhwkfYaZ9AtVH/ENIhtwqu4cjmjV+FAPXENyAgIPLE+yrJ9
	dZ6SQsEadBOISFfPpA4FmI99z/87l1Xg/4GsmfEYhEs/DUqGvd8uaDlUlqh3fN7IBbnsHca0f4p
	9bQkwSMStHxBhGVt/MLEgWRrrs9jxDWAyZFnPoeiFrtm3uChfb8c6lIP5C0WAjxfqJXh4h9qvM5
	f5HveJsyPQ8NptbQ3pb7jmEBEhG5V/qAgfincQAg7ESVfBhR5QxqJcOOrREdDCizEfFDLJfWU4K
	EReQsLplB1blcueMTfcgSnrL/v5qNm6BDAr8keM9dM6BZkvgtSPe3eRrVmlaHJm77rBgW7h2cA2
	XLDd4C0QPjfHRrezhp+PeGUGaIuT/LLyDDVk=
X-Received: by 2002:a05:6a00:2293:b0:7aa:8c11:b520 with SMTP id d2e1a72fcca58-7aa8c11cf1cmr974270b3a.7.1762071536956;
        Sun, 02 Nov 2025 01:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLSZOXj82FIyL38g8tkb0yX6STnnoCGK5c4Fw07Rb5drgca6p/WK47EXoa6Nx9ZNfJ9InAQ==
X-Received: by 2002:a05:6a00:2293:b0:7aa:8c11:b520 with SMTP id d2e1a72fcca58-7aa8c11cf1cmr974251b3a.7.1762071536462;
        Sun, 02 Nov 2025 01:18:56 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897e862sm7440630b3a.8.2025.11.02.01.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:18:56 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 02 Nov 2025 13:48:47 +0530
Subject: [PATCH v8 3/3] firmware: qcom_scm: Check for waitq state in
 wait_for_wq_completion()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-multi_waitq_scm-v8-3-d71ee7b93b62@oss.qualcomm.com>
References: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com>
In-Reply-To: <20251102-multi_waitq_scm-v8-0-d71ee7b93b62@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762071526; l=1025;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=qz1q5j9hqE0xZGY9pHK5++uoJ0GiuanH49MmX9IBeYo=;
 b=Q3KvgLsfgToKX/gqzONsJaYP7g46KDaZkULeltTlHCVNxaZzoh9YjCkohnwYudpJN7oubr05O
 I/Z7qFuGAU+B6pIR1Q01Fvdkcw7/NL7dmSlQyODbr05JvWXNBHlMqxM
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDA3NiBTYWx0ZWRfXxXLULaLvauay
 oFJQgon4mbvqDw0+NV0Qe9hUCE7l9kL8hJ+uch7mFNeWyuMzuqlG7xgrcLorkahVjYrRpOtTF+Z
 Pgj3EGekIogukvWLU3SisEnWSRyXszGAAKbRhbmkRJM1T3gEea+IJSHMPRL8OyIYFMJcE92Ccpe
 yREKEqreo3dnQs9w3T5RPRZ9bWnRhD4Lm1WDkaw09UTyIU082J4ltqfeTmKmzBNUbJ+Sjmy0kX3
 IzhcD6j7+VU9s1jRuhuFalkOn0NpR/gUtiPIcETPmQe6UCNlZCqZoTfviYiIRXAPMEqGbJNH9Io
 5uDJm2GTzJcvaXuNbOlp9YLy0rPba3CNDvYh0Q/dLsVcAWt2T5TW3KEsoXabxIRGBlxoe1oBWTR
 lwHpsOmJMZEg50wueEZnlzmqROseVw==
X-Authority-Analysis: v=2.4 cv=Scj6t/Ru c=1 sm=1 tr=0 ts=690713f1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lN7msHIwsqhiS44j3GAA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 49V54bk6z1V_9qtZXZNMlqzxlNtODzwW
X-Proofpoint-ORIG-GUID: 49V54bk6z1V_9qtZXZNMlqzxlNtODzwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020076

From: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>

Modify wait_for_wq_completion() to check if task is in idle state using
wait_for_completion_state().

This allows for detecting when waitq contexts are in idle state and
propagates it to __scm_smc_do(), which is beneficial when task is idle
and waiting for a kick to accept new requests.

Signed-off-by: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 0b6efa7c2bdc25a3ba152c25d5451d1154779ddd..38c1c8aff9fa3a90eca9dba700611dd12c4d82a5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2320,7 +2320,7 @@ int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
 	if (IS_ERR(wq))
 		return PTR_ERR(wq);
 
-	wait_for_completion(wq);
+	wait_for_completion_state(wq, TASK_IDLE);
 
 	return 0;
 }

-- 
2.34.1


