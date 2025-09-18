Return-Path: <linux-kernel+bounces-822982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F58B8536F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA9D7C2C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC792C15B1;
	Thu, 18 Sep 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oC3361X0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51FB19F121
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205085; cv=none; b=JgXUS6sRvyupJJxJ+xKhFWkxQQUA4HmI1gY1NuWBI+VG7SkwDbuN4k5TWYMP5qA/mB3R7cAI/FQwlBizvBodBliTPcVePS6a9wT6HHNfB0c9PELtismenTw7aStGRX8xfCtF5EeQOGXLrov5MnlBHRUZ1NfEo091G8wvgmIXTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205085; c=relaxed/simple;
	bh=FeBX+HSSs9IEe71buzXePciBnj1ZprF+m2AhT79/71c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YdXBPgyQaan3p4RjQkDhK+WHgCWEI2yQW28jVdQ59Y3MIfiTOSXjLH99TAuZ75qsxnnea4By26s/dC79nQac4XADfoyJqvfWYedywqYbGapMLrAoDRmGmzZJWXxb561uqH+4otkwWj7uL/rXr6xWHmOPkPr/5uMpYyb5YAnGglY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oC3361X0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBKITS021427
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gbUpwgl2gVJtGvPZLoqAOrcxVHhW3Mn4hcy
	2C7dvYMc=; b=oC3361X02xe8pa/PrFejyspvCbv/WSukDoQ9yoYrMYfTw6N05ps
	gnTJoWedS/pok+mX97DZBaGKu9kMEmDwWcI3sDOkON6/ibd95rLmbkdNuB81hJpS
	QxHhAP9PEdhY4cinIGGZcI29g3MM9zzvrsAJ4aWPidtRUEYYu2F3M8UV3IVP74Y7
	LiLi9u6EKQ9bZmg+uZWhvua2bX5PfJWjEpHloU8TIeiY3bhZ/sYr9ySA7ZhjVG55
	DWf3oxjD6emZWdZSnpi5VY233YixoTYZDToNLwhyMr4o9lUhaNCR+1o0ziPkhvn7
	wf784iAyyavdbhtXVb7R8UOBSsiOxAXeRhA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5enxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:18:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-268141f759aso10758625ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205081; x=1758809881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbUpwgl2gVJtGvPZLoqAOrcxVHhW3Mn4hcy2C7dvYMc=;
        b=sDvN74cRQq8WSaqNHX6EMzexGFU4GkLm27bDekOBIYEurlMQkprjN1n4oZlupHIdcO
         TAhLDHZG65gAhgNF3z65oZdn8fgLOiSGvE6ih0upwVXZGEZgqxx179eWCynp6jRaQXLw
         sjFV9h6Uz1I9RhO4crE50ZwxHJjpYHkE2a4PAY1PvHvrwrksYbi180OqWe3dARfZnhK7
         Jdy9IaetXbJIb0I87FXiUTxGuX24O/njxiDECjzIsdanioe9cuMFVBIR9uW6CYERwhiB
         ETEtKpqmKh4iH+LdISqjOUJPjaHC0sdj34zv5Hy00FwSclPK/22SBLf04QYqEfaPoM9h
         L4RA==
X-Forwarded-Encrypted: i=1; AJvYcCXR/YsS0BhWLJZUBrL86/YCoWyjw8OMdZaGeDyNRCNpCpEhuZF087KirtRjeP4hQMeOyVrTDLiE/EatblM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6p3dktdBvVLTEfcTNmNPJTOAmGI9oMUUC7bg3+Yn3OS9NgLht
	zXf+fLocwNBhT4Eb8tnhFPtpURh17C/xLEeQaQ1Xk/n0a3i1q5qRLCD0ixz3Zkw8DGkea50K7gi
	OTKM2c8DtkmE00fmpY+pROQfFVj6EAE1LEdgPPRVtqVkqx02IQxp6JrPr7AsZz6YFS/s=
X-Gm-Gg: ASbGnctWzHz3qBd+wYY5gZ7iotzOh3Od8GAb74xNgIYSPiytyrHSLxWkh/ZgdIKoXvz
	g/9mt4+XWraOfNj+YsqwtFGlo283s0Q5bztyIqC5HRVrD5rmy8rGZG628XrJsfC/QRz5fw5IcQ5
	qbO3plWeIFfhdWoWk5mcUXsh20gMW2h99AUbmLMgzlgIfn7LQOXONAW7dR0BbAJahFceYaQNdPa
	ic2KGx9G5YQaQ7kQ9jd2e5HpIC+QyylwgBMuqlWxhSBok/1KhWm5hvZRvxvCSO9o7Eneuyrf8va
	C37LSmI6nmoAD9sqAC+FZUV8tsliaYfaSCX94RyBK7dnNhP2cyqRtDc3vrhC3NkfLnZf3ie8Uyi
	PCDNRrfBtHg1vtuhwTph+KNfn6uX6ju7p2CyD5T+MQObXQ4hw6EK05y8uUZHK
X-Received: by 2002:a17:902:cccc:b0:24c:6125:390a with SMTP id d9443c01a7336-268118b95cdmr67967895ad.10.1758205081258;
        Thu, 18 Sep 2025 07:18:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMTr+Hviu5xVz64sb+cRHSIYzwwRe51hCX57g4JuYl5QlZXywoi9MT8CptGQ2hO9UuNMtKlg==
X-Received: by 2002:a17:902:cccc:b0:24c:6125:390a with SMTP id d9443c01a7336-268118b95cdmr67967445ad.10.1758205080726;
        Thu, 18 Sep 2025 07:18:00 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053da4sm27692365ad.20.2025.09.18.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:18:00 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com,
        quic_gurus@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: firmware: qcom,scm: Document Glymur scm
Date: Thu, 18 Sep 2025 19:47:38 +0530
Message-Id: <20250918141738.2524269-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3zWZ2WCB2RonpHZsWFHTQJwnLCR6Ltfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzRptAhO8f9gN
 mNurew9nKh7tbYzuME6GtcX2Zg7IGTJ9lvjQPU5Pnk0N2zPR8GWKcNDbvh8DWhjoF0nJ+6oenVN
 kcfi2a5P3IR0/xdu80TZQQUiIptL6y3rLJGmJzdvqdjWfOsV83Sxfu3wPRrR4hzBfh7rq7bVFMw
 dkRvIRoc0sND3+i5XnWc3vOkc+oU1DUdG9pUdFNWW/4v2GzXPqanMKYBSe+o6pQp3xhAGx+N+O1
 lmp8kmou7ywHRfNe9UX+9OIJ8s9jwj/NrlDeVS6fiHacZmOSGrcGcdYmF2WiErXT4fGBvAvIPdz
 gFsQ2FiqFaYAL+gw573b9BdxWIAJlpa+0oyd1zqBbJfJFmHUdKHzrdtd2lgWcd+WL5rZhTzXPFJ
 BQYU6m4Y
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cc149a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DJLe3x1ex_q8U2ZOUMYA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 3zWZ2WCB2RonpHZsWFHTQJwnLCR6Ltfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

Document the SCM compatible for Qualcomm Glymur SoC.
Secure Channel Manager(SCM) is used to communicate
with secure firmware.

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index ef97faac7e47..38c64c3783f8 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - qcom,scm-apq8064
           - qcom,scm-apq8084
+          - qcom,scm-glymur
           - qcom,scm-ipq4019
           - qcom,scm-ipq5018
           - qcom,scm-ipq5332
-- 
2.34.1


