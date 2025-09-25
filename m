Return-Path: <linux-kernel+bounces-831532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3DB9CEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90563B3E28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408892D9794;
	Thu, 25 Sep 2025 00:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YknGhvU2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BE82D8388
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761557; cv=none; b=OJqlQreRsbmGTPnQdbyy/lG40n80e4+gaSB6KsMwalgPTERon3jN1GJBVmUr0aEeQndl5AmbfvtPEEL/i/B+zil69JUNUjAr1dh/PjE3lXsLHLxf23E1mAEFO85QHOq8vjK/Vx+1ecHVvNVhy5ssQ5tIN4QBx2h3QFUVbEu/SMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761557; c=relaxed/simple;
	bh=hRao4UrERcNdb8WEbncfpT8mndQ9UcxF3KEWBpC5u2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n37yva0YY5YMki/UHGrWl2WbLLll/3Y/46xwmT8rnOnb0lvr6OmoKx6dEr5F+H9DsPtV2QWGI0evf6pBNwczZbMkxLVYBIEal9EWdNv+AfNHdy8QKE2sjvB6m+cEdyfM4/Etfh+gfTbbBSPcvQbXfwS45Pe1EgIGbPlFsRl7k4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YknGhvU2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCZorx002789
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Xn4sEHzNAa+
	rFACXl1zYTLnQ9MM2kFlvsIN0wm59uEQ=; b=YknGhvU2ad4B5JZ51NAbfxbq5CP
	B+J0ADTRSvaUnyAE2Gcf5XEivQcaFbrm6sd8D3am9X2WkrHM1cHcqILtRCigmr0p
	6h7PjnUNdR104FzHy3g6quV9LhDHEwXcAMr/DTy6o1K5CM3JYkwp2SQc/eFb3slP
	HB1IMrWHSO1XLBdQubqvW1C1iHUiehrLFGvyjlqtw6oEsTyizlIg94E1Z4EhWIHk
	aREXCHASackBMHLWFU8Ij7o+QAFxNLqMH58RP7UScN4TN5BfGb4fCbegMZJe6cjf
	zJuegYMpa429dvlImEKhZBkbzhcX11w4n+2Yv2PjE5y6YzeeHdTi+SIceNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0rtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-25bdf8126ceso6008565ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761554; x=1759366354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn4sEHzNAa+rFACXl1zYTLnQ9MM2kFlvsIN0wm59uEQ=;
        b=Hvj7JXbqCd1iBv5wlC+GIvaN4EqncIKfmtvixjyEnchLDs0hZfoQsils05T9+FErli
         I05lXfZlQSWUkgmTFnMqXgQjEhPuhBIKhV5G7TMbjY1jZEvU+mEKEX5+YYhpeBEcKz56
         VWRC4QCvW3F/JPtm36QOysjJeTSBblXr891+2S+EMoeFUZRDD+qdCfqGbUtqvNAQ1CKS
         sv00gXsEFZ5Jxvo2/zRymGWdcskq9WRWIDyPLGOsRSTfCgBUNXV10/cligVsggW3Egfs
         7FOY9qWS8N4hxAiGb+nJAz/9C4AwadbMTpRcIYN42zcbR5syuUZXUfuRI4+r45LP6twn
         D7NA==
X-Forwarded-Encrypted: i=1; AJvYcCVZNDC7Nd0NwoOr/HHoPmuD2YkJtv2Bt5ztEzHiGg+Gg4brAu1/x/WiryTBO72dzAakCxv8TAuLQexrg74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2kMdmR2tg0auEUjLxUv/XEOPc0bd9P/nFywJ+MUJjRsREXm/A
	vp/HOWMDwUXzZvy3Rci5XHFYpvZ0R5BS0FYhFySnNV0DfwFiNZXEH4vIGDExq+Dcm3gZbf+Ip3Y
	FEhJN3E+aX9ijolZJxw4/l8hUYBuycewyntYJnHMLmoLLqau1LWR/LZVC6o7G7fqeanM=
X-Gm-Gg: ASbGncuh2j8qH9OhHolGB5JwVVom51y/dqv6KFv9788l8TrqF8Df4CUBF+Ojf0HyJl8
	lyv59m6DYVDtezzrfXqngsCMhB/SIB9kH97+xawZwCjQnbqISZQ6xBSwt8TCo0fYPka4WYf/Pft
	QRBc4kXPusFPoPVkYGhMn925NHLE6FUyDIq20RQmyyFVKgkVb1ZFJKQjW2Ow4cCbUBw9StOxlBb
	iG6DQVyz+Eh9ePsb0uViaZw6YFVTak2r90vVg+w/WgFNK8ZzhUAOuiBuWK6AMS+P4jd9bZXTXSK
	WiSmd9SzPk98uhv+QwgSRZq3wefBXC6pXkZffqOWPYccxTnzTHtoS2BjZRQAE9tzF2RIJ4qPMDu
	EeXJ1EXRh2smbpeLI
X-Received: by 2002:a17:903:946:b0:271:49f:eaf5 with SMTP id d9443c01a7336-27ed4a30d16mr18646335ad.30.1758761554076;
        Wed, 24 Sep 2025 17:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0BLBhfqoLRlN6qFMkJxr7vlacqg8A7EpkzWtOHvCyZqAcmJHOiOE6WNsUjzSArIKZUFj+xQ==
X-Received: by 2002:a17:903:946:b0:271:49f:eaf5 with SMTP id d9443c01a7336-27ed4a30d16mr18646155ad.30.1758761553655;
        Wed, 24 Sep 2025 17:52:33 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:33 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v2 01/10] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
Date: Wed, 24 Sep 2025 17:52:19 -0700
Message-Id: <20250925005228.4035927-2-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: E21qRpfMLw2SABqCQ7Iwx3I4x_4Sfm-p
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d49253 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tYbxrAoMRz_Rh0uxvwoA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX9MsD/Lhd7Eus
 vfN5yqtwWm2SklZ8oQ/8ZOczfR28gK3KqkNHxF/5rF5rycJixYongNhCMjZlmL5Gdx+2h3X1ac9
 FJjjz41Qh38iHwRSyeBgm1qRJymSFfN8DCi230bg0Sb3K/1ucl/4dHPbOKwa6Ry4kkSXi1mSEtU
 DwNKDfS3/qEGRBp4iEDlhyh3Ct1NzG4eEnetRNmpU+UDCcrwn7a08dPHQ4KmQo7+YRxhea7OsRj
 JwvFVq/SulQ4udfU0MEc5xBYeOfwHYNAn5xUcqDbBACXqd9GABuNNeTF6++z/SO6V3PGYD5X48+
 Q82bwyG3xXEW1C+lwHuKpDUAkZa64NjditLZBhUUpNOy2ewY5OzlCbiDrZTXHwORsKb74UwCqZf
 LO0rKlFB
X-Proofpoint-ORIG-GUID: E21qRpfMLw2SABqCQ7Iwx3I4x_4Sfm-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Define a Glymur compatible string for the QMP PHY combo driver, along with
resource requirements.  Add a different identifier for the primary QMP PHY
instance as it does not require a clkref entry.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b..2f1f41b64bbd 100644
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
@@ -46,7 +47,7 @@ properties:
       - const: ref
       - const: com_aux
       - const: usb3_pipe
-      - const: cfg_ahb
+      - enum: [cfg_ahb, clkref]
 
   power-domains:
     maxItems: 1
@@ -63,6 +64,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 1
     description:
@@ -109,6 +112,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-qmp-usb3-dp-phy
             - qcom,sc7180-qmp-usb3-dp-phy
             - qcom,sdm845-qmp-usb3-dp-phy
     then:
@@ -128,6 +132,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-qmp-usb3-dp-phy
             - qcom,sar2130p-qmp-usb3-dp-phy
             - qcom,sc8280xp-qmp-usb43dp-phy
             - qcom,sm6350-qmp-usb3-dp-phy
@@ -142,6 +147,18 @@ allOf:
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

