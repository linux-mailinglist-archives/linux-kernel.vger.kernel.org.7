Return-Path: <linux-kernel+bounces-825473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC2B8BDF1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A4AA061A3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C622A817;
	Sat, 20 Sep 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RD62JpHU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867D222587
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338479; cv=none; b=ulFGnTPwpI3p/2GWgTPqS3GbVbbOqXSpFdXNwJHHDSQ7BoNwV6cPjjgkIzqZNN7viCYzVxtRTn4/yPoZzWXlqUNbY7MJECo46d+dVBDluSxNJhY1m5MBq8YguxYXQEIm11YnbHh2eVluvwnzjlFkA1r/vUdsg0Hh7jY95os0rwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338479; c=relaxed/simple;
	bh=YDlSoeRw2VbtYRMNUeSZVwJW+SmI0llmlSIr9kcNQWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jve9rz8tZfPyOqet3Ptc/efxuxm/E5LBouK7ci1aVWfbKxmnioh7yBQm8V2oO311u+puD90R6OINkTFq0iX0hSFDuFDUAcvaeeLJBFXiSMcdWHrluqN/EFtNUnsrJNex273qHnLPrM35CmhrJ55hIyBSItEXqg/zzqUDACwYF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RD62JpHU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FWdw032256
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P4afTs2BZob
	5xp1NXhLP4wPYTnI4iHBaCCe4NNMHtss=; b=RD62JpHUQDrLOassI4J3yoVNtA4
	Xpfd5zUsF/IkTIdzVGulZKCQZvpHKcXFoep/5QXSItxcCXg3CcNvLlk918glR11l
	31hneOnrWcaeS5nnlz9zw5OPM/N1we7G/muPyXtDwOKp1Q0kkD4SfrgHNLHpGQ7C
	GxL37cVPtNsVoyQh5nILm6qJCAx4zV+TUh3xK0uVl/jJyoJir5tsTMCZh/op2QPD
	yMEP93rS/TRF8skqZ7NUkYKvE56XtXE43MysOF/PZk63L1dvSmxmn3B1tqzvAgoQ
	AQnbMd4PsPGu3T70HG+53huNp6C0EpDzragSEGsm+8J2gMdfiLi7pmihWeQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982deh3qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7722ef6c864so2236010b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338475; x=1758943275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4afTs2BZob5xp1NXhLP4wPYTnI4iHBaCCe4NNMHtss=;
        b=h16odSeHXYUKxxVWi+1SQPQtjNkDcs+Rv8J6N62TYEHl9CNBnZQzTOw+RecREZtGqd
         Vu1gxItjj7jwsv9NqQWIz1jWrcFpI/dLMtXRlscuabxNgi0R9LdHj+HWZxYOlpqg7oKo
         SMGRh6oe6RRWikG9NG8l/b+nckoLolqyMitxH19pc7vUGoAxBn6B4QmBQ7/YeRd8ZE0o
         qrAkVyJ7e2LoZirzETXFT5Bzc7O5B7g6NEJGoR5xd1M2G+/5nv6laPWLEUpGxNpiJ5WJ
         SF99SOBOG3qsfG7PLRvk3dpYNiu9WRcHf/+nTynSu31mBnGj2Cfaa3EO5I/pVOyd6+Ij
         +JIA==
X-Gm-Message-State: AOJu0YzHBSzEeV6W2U9pvB5xBXBX9m+s7Hxgewz4SqGi7ILzq+dPauGE
	mP/t7bWjeTupwhQOaROtOrNF8jQ5svF8dw6X9rOztBjBbStSi2Tmg+XUs7P734+byW+BTv5e4ZB
	c47Lyg/+gzOZwrP+2pMBHfQBsmxIrVoYNFzKNKZqbnXv4INa2vL1wz96PH2MHC7GvBSrK9QaXp3
	w=
X-Gm-Gg: ASbGncs8zIXQTn5QowHhq8gts+aFRGyO4WUWWtHuOTGpa01W8xqVBAw/IAYkSthb+6u
	0346x+soLfdTPILO0G61J2mvGdvVkUtQUGghMKEFTek1CvBj0vfbFvCzc7q2QTHEyUFHfP1pOe3
	stGl1jdkTQolYc1vMQjZuXtNFpqdLQGyY8N3qgvu2fKH5pyKGGfihOa9FzLYXf0tDmcxsq4AXjN
	iLgYyVYkLfHnqLN+3JRvEoQr8BuLDXKlpDY2hthK9N2BS2Tq16X0VYjc+QbjO/qLa7UuM4GAv5x
	lrLXZge2sgOf0sxiDOS8Ui3PB3xDsuSWNafGLZMPjydBntAR90I0zZQOAMNERyXJWsc7ClsSrnR
	fo52fZF501yUwt8nx
X-Received: by 2002:a05:6a20:12c5:b0:250:e770:bcbc with SMTP id adf61e73a8af0-2927480f320mr7972239637.50.1758338475168;
        Fri, 19 Sep 2025 20:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjG+ljXA2NFGb12pwEQzj9q71gZ/HW4nxBM/YVfEycE18N8jKbIJHZotVnXmuXiSTZeajTQA==
X-Received: by 2002:a05:6a20:12c5:b0:250:e770:bcbc with SMTP id adf61e73a8af0-2927480f320mr7972210637.50.1758338474766;
        Fri, 19 Sep 2025 20:21:14 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:13 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 1/9] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
Date: Fri, 19 Sep 2025 20:21:00 -0700
Message-Id: <20250920032108.242643-2-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68ce1dac cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gJ-VRbHUVreD3CQON-0A:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: AY3006MqTzlrSJz53JiBIogDZJMl_Qbs
X-Proofpoint-ORIG-GUID: AY3006MqTzlrSJz53JiBIogDZJMl_Qbs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfX/V9QAoRKvZok
 tESQCm/CwYVOf5qwOIPeDA29ol2LSq2Y/TgGTWin7XrBS5kUuH9zuTcsiDzthGABRIWA3oBWrqb
 3EVG+QCNPr6cLWh8F0X0Dnk4li2vWzYY3CrDpNAVeEmID/W0J0r+/CS0Rj3JWIL+Zku9BPDTDPz
 ll3klKYLYa3M4YW4OW38DENdZFPO452f+x+/MzD1OSAOWotOm0k7WY2oMs3AevY/Nxcp1XeoZcb
 /PjP4QOEnZlbvKydbw9OcfI+E64iWbJ3vOpiaJ6OxH62MD4zGW6aQJLep2Yh3MmtiKjz7bkXcdZ
 Whgxo+LHC+XOgyh4+Nm2mKnK/QoEgellwwegFLbKWt1WcEFnRkEu3+CB2RM6jlutX4UINpY9s0f
 YuKOA943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

Define a Glymur compatible string for the QMP PHY combo driver, along with
resource requirements.  Add a different identifier for the primary QMP PHY
instance as it does not require a clkref entry.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 45 ++++++++++++-------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index 38ce04c35d94..e0b10725a1c5 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -15,22 +15,28 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sar2130p-qmp-usb3-dp-phy
-      - qcom,sc7180-qmp-usb3-dp-phy
-      - qcom,sc7280-qmp-usb3-dp-phy
-      - qcom,sc8180x-qmp-usb3-dp-phy
-      - qcom,sc8280xp-qmp-usb43dp-phy
-      - qcom,sdm845-qmp-usb3-dp-phy
-      - qcom,sm6350-qmp-usb3-dp-phy
-      - qcom,sm8150-qmp-usb3-dp-phy
-      - qcom,sm8250-qmp-usb3-dp-phy
-      - qcom,sm8350-qmp-usb3-dp-phy
-      - qcom,sm8450-qmp-usb3-dp-phy
-      - qcom,sm8550-qmp-usb3-dp-phy
-      - qcom,sm8650-qmp-usb3-dp-phy
-      - qcom,sm8750-qmp-usb3-dp-phy
-      - qcom,x1e80100-qmp-usb3-dp-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-qmp-usb3-prim-dp-phy
+          - const: qcom,glymur-qmp-usb3-dp-phy
+      - enum:
+          - qcom,glymur-qmp-usb3-dp-phy
+          - qcom,sar2130p-qmp-usb3-dp-phy
+          - qcom,sc7180-qmp-usb3-dp-phy
+          - qcom,sc7280-qmp-usb3-dp-phy
+          - qcom,sc8180x-qmp-usb3-dp-phy
+          - qcom,sc8280xp-qmp-usb43dp-phy
+          - qcom,sdm845-qmp-usb3-dp-phy
+          - qcom,sm6350-qmp-usb3-dp-phy
+          - qcom,sm8150-qmp-usb3-dp-phy
+          - qcom,sm8250-qmp-usb3-dp-phy
+          - qcom,sm8350-qmp-usb3-dp-phy
+          - qcom,sm8450-qmp-usb3-dp-phy
+          - qcom,sm8550-qmp-usb3-dp-phy
+          - qcom,sm8650-qmp-usb3-dp-phy
+          - qcom,sm8750-qmp-usb3-dp-phy
+          - qcom,x1e80100-qmp-usb3-dp-phy
 
   reg:
     maxItems: 1
@@ -46,7 +52,7 @@ properties:
       - const: ref
       - const: com_aux
       - const: usb3_pipe
-      - const: cfg_ahb
+      - enum: [cfg_ahb, clkref]
 
   power-domains:
     maxItems: 1
@@ -63,6 +69,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 1
     description:
@@ -110,6 +118,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-qmp-usb3-dp-phy
             - qcom,sc7180-qmp-usb3-dp-phy
             - qcom,sdm845-qmp-usb3-dp-phy
     then:
@@ -129,6 +138,8 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-qmp-usb3-dp-phy
+            - qcom,glymur-qmp-usb3-prim-dp-phy
             - qcom,sar2130p-qmp-usb3-dp-phy
             - qcom,sc8280xp-qmp-usb43dp-phy
             - qcom,sm6350-qmp-usb3-dp-phy

