Return-Path: <linux-kernel+bounces-831424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D46B9CA05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97BD1BC487D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0A2D0601;
	Wed, 24 Sep 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="phhJzxyw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86B2C0F8E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756921; cv=none; b=aLJAHIUYT9Q+0+8M1p5zoM71J/UOvsfK9B5NPqzjtGA28k0a7mg8X0ogTzwoq+GdvprA34/QnVZSnzDk0NBvcCPxJf1r8ondnQ+ajo0WnlN1I8vYGEMEc4gaBXO5bnHzv6N0CUtD7zsbhtWVo3qbhYFpMLpqLKvPz3jDlEsh9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756921; c=relaxed/simple;
	bh=hU4ophAaEAd6H7eRZm1uuGkEAXFGtcDMUcpBkxQVHUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufzZSmaiVk1jzW6NbVGPM48ngZdBUm5FbPoWvKf7OwI8Mm42k64l9smyEw8pNslc5L68XfcK7IRbbfFTGdu1ng13et27sM8Jec2hQwbpk/HkTuz4wSqPmgM0hlbXRIn2BWL7i3EwssQIAEAyeOIYkYl3uJKIK6wSLdcelce6o58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=phhJzxyw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCxCBc025158
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWqICJbVMy0RpODDALIty+rOGzCBRBu0xbDRo92ujfQ=; b=phhJzxywA9wrOq6t
	Cyty256UpxzAYkUiVTu9ZbneuG3pkOZBj+WsJ24fsAo5XF1pvHzwRqPRNi/nlJOU
	2xOzZaUSGo46reGxoTJ3VT2mp+76HBDPrMrdQjJbzUZJ8pA9HIDlKxAPiGbVrdMG
	9xXRxdPOPbe8QE8jJCZtGceKkgrI19Pnol1BlQyb6/Z7lq4zN0V58BFbFod81WOQ
	zjMx9d6VBrAEE6TXIa7LYQJBULY6DdsDPUtXoHvoit9/Qzk7YN6k0skexPLc1Y7W
	1Rtx1XarO7FBQUeGscxGHDazh4Hgn9S/kji3+y6d5mo+zw+OkgkUBD1amkYlialb
	rQTqPw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv162qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso250183b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756909; x=1759361709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWqICJbVMy0RpODDALIty+rOGzCBRBu0xbDRo92ujfQ=;
        b=FNlaiABqKouH8/8LRODsqNaXVyPpAgeD9GY5RMI5bB9tvYLnvxFDFaRut5KPPOt7rO
         BXL2LnwcZAvVQKx2y8wzJhALazSKyAmLbGGPHR3Ag6ty4CBNazp83jF5w2KN5raJwvBW
         2Z8IRYBw/HNYmi3p4pIVuyqzI03K1g3aY6p/kgGIHq/ZWzF1DftrVWql05c9yRHvGWJM
         BsL+1AocdZQx1GNuYh8uUqZKeXbUraePrNfiLfglvs38M1+0ar+vgOj/l8qVGkosEJbb
         GuekuJfyvjp/HdpvgBXEYsRALrii4MUig/cj+ieF1P6XTQd5LmFoTq3VGy31KftNwwlW
         DLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEqthHYUqKMVow8eYW9Ca8OlzypEWH4FFWihOZja+ahdKJUp/73GzQEg3DOyuzj8RUN49CXsuu2tb2Fm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSo6CMICQvsjF6oRXqjaG0yAemzWNSzotNdn5ay1eI9wo29JB
	JKtb0p8k7fDGrDqm7IHZBnj00E+Z8z+pwK6JCV9VcqAt8dFFEvLoRVCfkMCWq2bSR6Z4dx7sq8S
	OOjLsGfGm99K3xvXfyQzoUGYUYly3EqglxMcVibGVVa0oNWYpuMbz8pfpRB5TtinV5zs=
X-Gm-Gg: ASbGncurZeE0vj9aay9XM0o7RCd2Le7kWiVAruPdZspjRw7RTbaLAzzIIK8YCy+CscD
	9VgtDzzwYXYRNBlt33++Jm/Y8ao3i6Ve7h5tW6ajkoYzJQjqskhnHHhmNSzddyDpfSodW7MMx/V
	3Vqx/3ECDtmk4DTopfIGe5GVMY2PaYVRL4VtuwPIt+Yf+V0WhVbubXpHQxpUrUQwyltcGRcp4st
	QdVxo+0DZqhyrQxuiYJUqYSmIQvImqGko7DZtUQaP6JKN5NbGxA51oPjlB/gpIu7esx5VGkCisd
	Z3KbfSbp1cl9Ha/INH6IkcbbhXMRumq8ajpCi7+evyUbc68BTDj7OYpTuERbBDX08SSbTvZVvsn
	c09yJgOUy3RG3h+8=
X-Received: by 2002:a05:6a20:1588:b0:2d5:e559:d24b with SMTP id adf61e73a8af0-2e7cdda1022mr1646267637.32.1758756908638;
        Wed, 24 Sep 2025 16:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiJ/zMalK4Rfhi+KRWDxvhLRY72fdHDoPyo5I/09BwNd98hpdC08x8DXI7JsGifufRFFlfPg==
X-Received: by 2002:a05:6a20:1588:b0:2d5:e559:d24b with SMTP id adf61e73a8af0-2e7cdda1022mr1646245637.32.1758756908189;
        Wed, 24 Sep 2025 16:35:08 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e9a9sm212379b3a.15.2025.09.24.16.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:35:07 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:34:54 -0700
Subject: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add
 Kaanapali QMP PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-usb-v1-1-48bf9fbcc546@oss.qualcomm.com>
References: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
In-Reply-To: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Ronak Vijay Raheja <ronak.raheja@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756905; l=3174;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=KM21eRPw1BjO3tWglGr4aBncFUF2vQ3eFtUu9OugNJA=;
 b=zFJE8FT4iTnf2yqujsSkjV8dmDKm55xtIEX4wmJa8Y4mo4yvYckHXkpnIkbGaFnepoNyTcSZB
 PXaiYpG0fohCy3P3qBf6UPHN4u46CRHhqcgVPyUghKrv90jmiWpQKXi
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: oKt8WUUOmyRperQOpLuXu_TH54gAo5hc
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48036 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2IkYd7TCTIqYiAcLhPQA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX7KGPbJkcFiMU
 V6v1cRI2sLrvfvnScONaKfs8tf/vVUo9dwr5sf5D9F7Y6g0D/2Xx6pRhMbskae5GiZ4hEzGCf6K
 6i2bvzQQpx5cgEcKhuB8ueR2lpHdUFNZNfIggBdKCcCuoq9M/GvHNuV7ucGNH7YvRXfJfNearT7
 bkgDQnloa7ajWdgCoskWCPzdAaIZonbcthZbP/YoPBzox3ylA09ktgXuL1jhrnUZvlb03zXK7YI
 7JB2y2sw1+lnDX7XgBDq5ptDK0px3YjtuTViwksgoebsqlsxD5mq6dwDCZ3UClPEPp51KApQ+dB
 Wsmdik6fNoG2z43jxmR/ayE298cuHPFYAPQOgYm5rrDucEXDjc3ZZtNUg3yws+L1ykqJlrGoZJQ
 pH+K7/0e
X-Proofpoint-ORIG-GUID: oKt8WUUOmyRperQOpLuXu_TH54gAo5hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Ronak Vijay Raheja <ronak.raheja@oss.qualcomm.com>

Document QMP combo PHY for Kaanapali. Use fallback to indicate the
compatibility of the QMP PHY on the Kaanapali with that on the SM8750.

Signed-off-by: Ronak Vijay Raheja <ronak.raheja@oss.qualcomm.com>
Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 54 ++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b..8fa919ea3318 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -15,22 +15,27 @@ description:
 
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
+              - qcom,kaanapali-qmp-usb3-dp-phy
+          - const: qcom,sm8750-qmp-usb3-dp-phy
+      - enum:
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
@@ -127,14 +132,15 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sar2130p-qmp-usb3-dp-phy
-            - qcom,sc8280xp-qmp-usb43dp-phy
-            - qcom,sm6350-qmp-usb3-dp-phy
-            - qcom,sm8550-qmp-usb3-dp-phy
-            - qcom,sm8650-qmp-usb3-dp-phy
-            - qcom,sm8750-qmp-usb3-dp-phy
-            - qcom,x1e80100-qmp-usb3-dp-phy
+          contains:
+            enum:
+              - qcom,sar2130p-qmp-usb3-dp-phy
+              - qcom,sc8280xp-qmp-usb43dp-phy
+              - qcom,sm6350-qmp-usb3-dp-phy
+              - qcom,sm8550-qmp-usb3-dp-phy
+              - qcom,sm8650-qmp-usb3-dp-phy
+              - qcom,sm8750-qmp-usb3-dp-phy
+              - qcom,x1e80100-qmp-usb3-dp-phy
     then:
       required:
         - power-domains

-- 
2.25.1


