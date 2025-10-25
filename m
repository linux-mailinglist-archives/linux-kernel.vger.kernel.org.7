Return-Path: <linux-kernel+bounces-869665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CDC08785
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A74A3B66A3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF31F4615;
	Sat, 25 Oct 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkE5zmEL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C721E3787
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353279; cv=none; b=OxPawmeXMpF+FgjQv3wYVhrgnFsT42ZeFvbTlRI0ibqemCvO3xgHWTbYMi8eGnRM7VAa5BEohLusgKSQm5/HZRl+MK0CNbM7hu2XvVXTV7pgVh7IETtrJmc0v9+8lQb7x4lje6yJIDHg7uBLT5KQ/EMhwMRLqW/llBc1AUF35mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353279; c=relaxed/simple;
	bh=1Ss4IHvUR0Qc/qOVO/ljfPe73HHlUmVAfb94GZe7OO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L48ebgzq4S9gsnzsN76YAMhTEWYb2EHG6Zt9XFICVpSHPNKHHdiQcJf4e+WNk2HNm6ULZbcQE5M/QXnjAsADj5XEubtaIsbHcIMiv7Z+60zF2sAuf2qLsa0Wv88b/OXttmWp175ZUkUDX5HZDexZBT73J6SoI/+Z8RlbhWMtKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkE5zmEL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P0lq1Z006725
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F/a1kob5ZcmeRBTwqpB3Ugws3u5wdaGjY6oAzB1/mpc=; b=kkE5zmELkqhqNl71
	yqLxN9Msfga82XSsXF3aU8T7ff1XDbEeM+1gwcfCFQFj0iVurFJvvdwxOlpmArFe
	chMsXHXrcAlq+Dxkhm+PkCtLjAiTlafamNDb6xhTwb9DbGsuG7jBx9XK3X/OwE3z
	TiXOgw/jomfLlB3Z90HFPW6AaqLyjzRINdYeyEd07P8oFiIWnxc91vAWYAN5924N
	MMvsEo2Gnij/VoRc4xkklI3qmEIp+lkZZbdSyear8bQnrRfNkwUbRlgutPlyThAq
	khb4N4MNPxKpvcrctggsge+ZRndW4gqeQmeKUEBKiU3M0/yUPKQ3xiMZvOIvX+1s
	yQuL2g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0kwn0155-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1798779a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353275; x=1761958075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/a1kob5ZcmeRBTwqpB3Ugws3u5wdaGjY6oAzB1/mpc=;
        b=nJs/zUc/qZCq1csNFrIHG3VKzV75xK2J/4K3/tyKae9/81YpYTvOtYYX/FGvId6wx+
         ZIfKsc1UrCxvu22P5pqdy3+/FFEnX62lQRxMl3nqWAgQx+EV3qJINstR0ENdXGJYOmPO
         t8B9pAS/zl7hN5RYo0VNPudARYr7FB4hk+NgpIWoAiaNzzLNlpN1OjV8o70Wg9x/ztJE
         uHxlu7a6Ni7R9W+ZhenbS3CGHebTngo0qrzjWgyqA2t8774uTxnc4Hzfvasb5OLdZCGf
         ts0H/Z391OklJvU4rJA1k79ML9wTd2OBh/iYejuJkXFyXUPbX7Kqqz/R7zOd0i35t1IG
         A0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxYCbpfr1sBoQnmSLrrG7H4SKPpJ+9vwlqtLttK+mO+g8g3fpxDxlbY7zn+lvSxAt1Xs8AbtWtPGn0n7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzuNvtIQLJFz6x2Qfng2CVMnA4D5++NJR2WVhZwx6tFR3OYZu
	AOK9WBgkJfPh94A4ohW6N9eBGI35tMVkTwggB9VZSIjrEVxT7R9KXQa1EPE6qF0cficwHrgfVAj
	aRrQUT9MZNwLTHb5FLLkThujKQIv0ccBNB+bS8HlVXcUQ/5b9upiIBWSerdUg+v5SwcU=
X-Gm-Gg: ASbGncuOiwTu0ZehlaP56ZGTFHXJ/aPhfKFbUi1aNXcd4MeOW/YXGftWjUzJ+uaV8mX
	J4ZMxKMEuCaXSYrQaDPq5rPjMzuPjPGBvmXuhYiRCO3nCMP9VeMxW3668M185Hb3/oNxYkn00hK
	cZ+HNLwiLn98JJLATbdDW8u9HatIMIhBPOxAr57cgaCfdswJNRHB7j8fTwf2c5D9790fG8hQe0R
	yzAENL39MhppTlZKfi5wA+6J49JwQ/Y7DpcCA6CrnP2jMKhEoDczTKibUoGTmZNUGa5tD+RS8i0
	ArkXL+pnrmeNaEiB0u8y0tcs58cZtf2gUUwe2LJeBp9m8WoqbFJERbZKSUiMrxm6OeKGOWry6tZ
	Of9RBOgGIwEQbKhY2o81mFrp3Re9ulKCZiHRPnbfP2u/hZLb/Vt8=
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr38230868a91.24.1761353274894;
        Fri, 24 Oct 2025 17:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWduzpj9A0+6O0Mb4Y5n3tBIAhWy4IVRZU2n2C8/tYxem2hrCBYq4qjS6B1Ab7R1Pf4uGJA==
X-Received: by 2002:a17:90b:28c4:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-33bcf8e4f50mr38230842a91.24.1761353274331;
        Fri, 24 Oct 2025 17:47:54 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3eca8dsm167352a91.0.2025.10.24.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:47:53 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 17:47:39 -0700
Subject: [PATCH v6 1/8] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Add Glymur compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-glymur_usb-v6-1-471fa39ff857@oss.qualcomm.com>
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
In-Reply-To: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=MJ1tWcZl c=1 sm=1 tr=0 ts=68fc1e3c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=10t125jH_Dd_vgTH4ywA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: EiOAwGKd76dn7G_tAD7Mq7e_wP6gf98x
X-Proofpoint-ORIG-GUID: EiOAwGKd76dn7G_tAD7Mq7e_wP6gf98x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX8lwi/MAbGmva
 aAFa31nIHzOzNX7b8MvMG1b2CEMv9r2heRhO0CowpZcvzXDLI0jMCNNUuEaelZzHU8VYZBSEapT
 2vHmpkNZrQ1BeUxWDPI6nWLbBtjVpHsDaLYb2LL/jfZbm3c+55DacptZps9rcAdDU0n+Kd3o9n7
 ZK4WgKi+6Cn6UhyoCCG43gOc1J1KaVh1AR8bTPJQS+/YX67s6KoO+SDR2YPR/saDyFwfwLnTaXb
 ADCnobSXZqWOub1mFtQo++lkMg3SIhDr5jV6aa03T8iUB3AfRK81L1fvBCZbb5HvI1AKA8nekbV
 8pxiXXp4WaL28ibbw0neuFqj3iKKl5PmEwg1spfryltc96Y6aGJKoFZoGVnWQCzIzfgIqyr8wBb
 V5azM0z67xEqbNIxiYLpNrl4MPu96w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250001

Define a Glymur compatible string for the QMP PHY combo driver, along with
resource requirements.  Add a different identifier for the primary QMP PHY
instance as it does not require a clkref entry.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b..915e6024d3e4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-usb3-dp-phy
       - qcom,sar2130p-qmp-usb3-dp-phy
       - qcom,sc7180-qmp-usb3-dp-phy
       - qcom,sc7280-qmp-usb3-dp-phy
@@ -63,6 +64,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 1
     description:
@@ -128,6 +131,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-qmp-usb3-dp-phy
             - qcom,sar2130p-qmp-usb3-dp-phy
             - qcom,sc8280xp-qmp-usb43dp-phy
             - qcom,sm6350-qmp-usb3-dp-phy
@@ -142,6 +146,18 @@ allOf:
       properties:
         power-domains: false
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,glymur-qmp-usb3-dp-phy
+    then:
+      required:
+        - refgen-supply
+    else:
+      properties:
+        refgen-supply: false
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


