Return-Path: <linux-kernel+bounces-831625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD7B9D297
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B636F426D83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F9A2E8894;
	Thu, 25 Sep 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1wDHdzW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074D2E6CDC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767340; cv=none; b=Tu4K/1+aOBqZGFduiPLMC6Q4ofPmwNqU7SwSK9nsy+2W/fK4qSLoHsFyIeELDf9uP0ZLjEGnyXBY1rNjkc8wyC5s6WUQeoG8AsNnR3If6TVv3A9H3TZl3hYaqh1m9sj4PU39rGkq3ZAUzGBFxuIJ3qUZwsYKR34XvjpjLF4suPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767340; c=relaxed/simple;
	bh=Li7Axgqj1Qyy3uX3oX9irsrd0UwAJw/MhTIJL1ssmMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIjGOot3fTRf5kPpmC3Y/9Z2+16k3EJ7myMrvRwdlfAH2wn9lFQSqizqmH01/FXVc39ylTBmtm5MW97TEHV6ZsN+obbr2CUFVB4XPczWyV+tz0R+rTMrJRUcdaKB9BuEyeSAYwZwychPjI86AAEjfUdECn2OusZpXDEa0HnkXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1wDHdzW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Z4fk019915
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NkSIvXe2PoZ
	kc0A70JhcEzpgbRLO6/8AmGazVnh8Tx0=; b=J1wDHdzWsDKpAy1PIx5WXXmAS5l
	4Y0MZfOTMAW/u23Ac2cX6SBTPZtKF6dEFNSo5/UzFw0jNDmNce8SdXUyBrDEBSJS
	Xpn8rrAoyStypUmA6i3vfWrphgI84b8QR04b6T4HwTwUcTU+xtdUstAjnDkzziuw
	Q3REK25run5gZ0vvVpC+LgUsarJth8J+UPeuoLQrwU/zBXdqJMoOdkIo50Ii8yJQ
	IBPE580NzBnclsiLED4mjk2qVKMpm5W5PMrzz5hdxWX8L3Y68SVq6nVpjrlJWX+Y
	OGcqqWgiUHWFu0uUJ2500C8RYAfCgkpZHCa74xrpVpL14+d17sX68SKupXw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdyng4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so482986a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767337; x=1759372137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkSIvXe2PoZkc0A70JhcEzpgbRLO6/8AmGazVnh8Tx0=;
        b=cFc63cj73t474o46L3G6EZoJ14dAqpqM1fK2PIaO/B2bxx+JEVMMt5xERqs7kAkseg
         LHoFG6xvo63tM5S0wfOo6Kk2zfJHWTdMstdgcF9Hz9CtG4B9tCuMnBtBC1YmuDX7tRkB
         1u2IEN64MjiwHYUOe2BwUy6oF/sWksttYJe66elBVqjc8poZqgwSU8k+T4E6K0B4LUm2
         qYdkOCZEso4Q2RaToenkaYj2Zyqlaqev/2DiBS5SmHI3YcgAH8SOlDt7N2HQPyjT2wTs
         zBjQkCJH0nfQ75u487DC11jsxrWPjSUrQrTt7/DoN4Jk5Wh7CdDFSBeraI/MplhST4lD
         458g==
X-Forwarded-Encrypted: i=1; AJvYcCXL37d99jWYSrPOhMlX6g1b16T8RsnbK0IiESuMY3tI9OfxTZ0DHTFgQ1dPE91zdv78TrMRGgHGHtcjK1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XxmZjrVX9mcd7L5QuP/CHCkjQP3IkWfkRRQ12dgIC8vaVn/x
	8kDewjasyp7Sftln9vY6s1MW4A9LRg2FN//KZSZeimESmrSvF2Tk64pH4c7pgLzZrp4Kb6xwHG/
	sOPjqlPxugCmUITQFUvdAbz8aRwnMlXet88NMfW/cF4yuEA1IT6jqNNXxIn799eBN3ss=
X-Gm-Gg: ASbGnctBN1O+HJQ92IlGgL26kscNREb2tMfsTWRumAeZXhzbjzibIKC6b25dH8IR8kl
	OfR4xozfgTj5I8kYmNwS4CJkQ2+zP53lRFwwSBKgzFCo7l1ewxU9MmRsyXwgaPY3/Iv6/WfC5+N
	39H6dnHIt7D/kAbBMVK2gT8E7ifoFXCw8C7PMaYY72RFt+nQEf++JcjVHHw5hw/F/erVeKuPGaR
	m55HthBHFnFzBeDQrrMsbJLGibuGmpWJ0EUTx08DsH929vimGYMuS3ZTHrFHcmtRbrqZKKjftr0
	rJAb4OSX+xXDMUqQVzgvNDyc8WF1YEEQk9g/VNHR3rh6hrTZI9gaj3EMwEQsNMY+oJkhFzfIcex
	xn3evnxwZYfgkc10j
X-Received: by 2002:a17:90a:e705:b0:32e:7270:94a1 with SMTP id 98e67ed59e1d1-3342a2b94aamr2128069a91.17.1758767336933;
        Wed, 24 Sep 2025 19:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU67qmxExDZGHwTuZe0bg+hJ3mFuAKodDprKDYzQgHWUaEECh5/A/FMklWCasb9xyD1Ojlog==
X-Received: by 2002:a17:90a:e705:b0:32e:7270:94a1 with SMTP id 98e67ed59e1d1-3342a2b94aamr2128050a91.17.1758767336533;
        Wed, 24 Sep 2025 19:28:56 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:28:55 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 02/10] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
Date: Wed, 24 Sep 2025 19:28:42 -0700
Message-Id: <20250925022850.4133013-3-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XWyVTG9j_wDZQ_fy1_BUpUWAoPTNdDvn
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4a8e9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=e4LYGitkWRZSOGXTHbEA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: XWyVTG9j_wDZQ_fy1_BUpUWAoPTNdDvn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX8wxk9SlDMjt5
 Z7lVGARtq1po6RIoPAAOGGI+oNbP0SHmS8lSfWciaYHa5etfT+25/soy32t3d3HvwHPIWqR0X/j
 vPbwutv4FIVT5eRTOwuIa483ivKUQ+iu7XCJHQBGDcZJMm51XbMDPTfyVeLTsp8NSrRfGzlkTQN
 ifB3TL2T+DGr4kz9GRcR+g2I+ACyGBJe2/sNYWm1fNTI3n1zub8n50Ij6B44qtmZTznrYNqp682
 zZld/x+hFayDxKBd6Sozo2ixmeaA+Om4eBLCvmBGmlSptrNQyv307YpRqsNY+yA2WJrpwmVmxYw
 iFsFyI4P8RRF8pZY78jF5RNI7mQ7/YipIsb/wXfZ+sxjRW7ad1+0vlf0YfG0DCbvCjU7KPv62UF
 vzouX107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

The Glymur USB subsystem contains a multiport controller, which utilizes
two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index a1b55168e050..b0ce803d2b49 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-usb3-uni-phy
       - qcom,ipq5424-qmp-usb3-phy
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-usb3-phy
@@ -62,6 +63,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 0
 
@@ -157,6 +160,25 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: aux
+            - const: clkref
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,sa8775p-qmp-usb3-uni-phy
               - qcom,sc8180x-qmp-usb3-uni-phy
               - qcom,sc8280xp-qmp-usb3-uni-phy
@@ -165,6 +187,19 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-qmp-usb3-uni-phy
+    then:
+      required:
+        - refgen-supply
+    else:
+      properties:
+        refgen-supply: false
+
 additionalProperties: false
 
 examples:

