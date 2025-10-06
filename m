Return-Path: <linux-kernel+bounces-843528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA0BBFA86
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E17E4E809E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9F1EB195;
	Mon,  6 Oct 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPSHGI4n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC44196C7C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789212; cv=none; b=F/CMtQAgifAuaF4uDbIkMruDBbFZih0r7wLdlPXn2n2HOV1wSxYbU+iodpbPp2JJuAAf6NwxBL2yTONxwQZ7I3kT+3IRmH93SRWHI7qJqVZVD1je+VB23kHnTBGhPzNcsmdC9FPpD/TNQiaLW2lGxKbp6C/U5k/BCESoQfcHeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789212; c=relaxed/simple;
	bh=WfcBDR9DIRDJLIXrzb9ShDflaFdoNyv5c5lXHKgErm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mieS5OTkoRSK5Qn6fvI8WAPa4hhPLFyHToMMnIFQtUUyKwJyiuEKYozOy+ZTWCEPp6vjNncI/CBVcdz2ckvjKffnHLh93kVhbVlxFZUsuXfRiyUmgmnHu0HbO1JWt3UizIHXHuwXXDuA+3W0X3RfIWK3CBvjlDR9u1RZcvEEVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPSHGI4n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FBpD5006260
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kwVAXCKZYFJ
	vmBevVk49WwQx9cQq3YCpTTCCiPQjazY=; b=BPSHGI4nNgZYIza6e2xmMVNUpKh
	AgFkqW9hMAneI4jZIFgIcS7cEooZYKTK637AE/muzQkBEC84tZ6pe11M07C5HWTI
	2xrMwQWOP+FQ9mxK1fQdpzuwOaB+frF84SHXDxZQvi2evIVsqYhuXWAPZ3kUNp7w
	HX2likY0LEshp2HRmJMklrty+/QQBw+sntnrTwYG/ZJQFRufrPEgoD4FXj9oavO0
	2lkV/nYw3vrwvzntqXTwOUuMGh9IWBk0U5wJJ5H3vXplWuTjgy36rcfm+DpSrkEV
	ZNFULx97kOltnHz19G97iv/XhZD+SFaLrk1jfA/BvtkSmkMA0SrJ2IrEBcQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu5bvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so9263205b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789208; x=1760394008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwVAXCKZYFJvmBevVk49WwQx9cQq3YCpTTCCiPQjazY=;
        b=ephI3Hj+YNJ2/6M1xfuvRukayqYvHIxLx/K5sZukUKk0abGbOBWUKgiI85ikDnG7kM
         LF7m2+KS6wZKs5TYpEBGMhy5xvidGxw42SlruOzQ7kp6ZyvnRUCkWn1vGFVrjfbR1Quv
         JfhEpCy2M/S3ymzf6OZzU7qKxHFxn1Ry/ccVE/H/rRJTtCwQHBhQHtshTagYDLRxYjfd
         eFv6T/HfYKHZUx7rO5di8RmASqPPBfvf3aJ1vTfZA5RqaVMUz4CO0cucCv66ydLJcE/d
         T+nCczkjtQyrXoP5QyTEO7QnJjiugpnrUxLH2yE615T9zulzdUzbZlvOoKj3RNKsKTT1
         xMHA==
X-Forwarded-Encrypted: i=1; AJvYcCUXMyYXiYo+LLIi4K+WqMgsPfI6tPCgDFBrdM+s/Epjzy7dwQJgFMshRQrhk8wU1JsalNihhdEWKzSBS0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXH5lB5nlY4euKAhCbrMKU2lt8AttgFFa6SGHktlNsxcXPPFLf
	2Wsqn7ml6kohKg/eltn+l53fR8HKUgWhxyPJE4gBwReA8B6hOCGU15l2b7Kefe0Ug6IYBLlEujV
	E8J9QqmDfvPfxwZtGuQRlUdH3hLxkt14jpWrwblBsX1iJX+TjIRG+FfBhS4X94rhIK28=
X-Gm-Gg: ASbGncuC9P7Radbjr9ltbbcmnzYX8FZMhqlw5xp4EnZkuXACXCHqLzXRQsh5PGdIDNb
	7dGZf+p9sPq7Orz/0wJVreJkiqsIdy+XG1QJP6u4sLI+Y+ko/qj74mUuO61EvJqfx5gnlPz/KQ3
	E3GK1uFAdGHkpN8k/VVIiLx8RtDXdLn/YZL0JeqyoRBfpWfPmkiAtg218hJ4kdNdx1d7c3M05ve
	eAKwluPdedVsCM5tTcwl5MmxqNAoffiGIijp0NZLlWHaywKmXYKAjlI99et4UaklblDFa8nOqGa
	z5/LJDUQp8g/f58r/p9JorRXuE0yhlK5Zpyl0/hbGI2vIi31o5Hsbmdmig9xUwMnYi2z9GcqvVC
	ad2ag3F/WW05yO9o9+tkIzQ==
X-Received: by 2002:a05:6a00:2305:b0:781:1bf7:8c5a with SMTP id d2e1a72fcca58-78c98a40a3bmr18785123b3a.1.1759789208239;
        Mon, 06 Oct 2025 15:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5R1SLObP0kiPoqDNLoC1YWFmO7iQQWvlu+1UAlluy50qQoqzliZ7CViBxbPnbk0mDKuzpGg==
X-Received: by 2002:a05:6a00:2305:b0:781:1bf7:8c5a with SMTP id d2e1a72fcca58-78c98a40a3bmr18785097b3a.1.1759789207808;
        Mon, 06 Oct 2025 15:20:07 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:07 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 01/10] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
Date: Mon,  6 Oct 2025 15:19:53 -0700
Message-Id: <20251006222002.2182777-2-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RfbSecYu2WEBZ-vM2EoYZxIbX_177vQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX0HaiN1RovWKx
 oLo1bs0+xL66Qt+Hn20M8qzVIbJSmjELqonnc3L/IDYNcRHt5TN/n/on5DD4xOHzGv5XTYhewE3
 eF1+AdJ+9um6KAiMYfEYus8qeNxpVkCM2Ji/zwH8PoT/KXbf2brrjD+vNYL/Z1hetfhBcW2yDA1
 FCqvpI0W3BIb3jSicQi9DJneiay3C1zvS4g0Mku2nGngwdIDM2uPgJ2p/pxsZCY3nanuVbPqggQ
 deORUcrCpph9tA+ZQaRYPRjPIZYlUsPuScrDfWgVFB72IOfHuSmFkGJ57ANdM8jNZEqGBcoLAz3
 TzCJtCf9zimIy36KjXor+TgfPca3CcGTVurCzmNdueRhYRfeek3W6MK20+7Ye8DLuRTRI5dmhjj
 6X//V7RdE4Ln0g39eQ/WyV49CbRnoA==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e44099 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=7IGZojk4TMugEFbIs7wA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: RfbSecYu2WEBZ-vM2EoYZxIbX_177vQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

Define a Glymur compatible string for the QMP PHY combo driver, along with
resource requirements.  Add a different identifier for the primary QMP PHY
instance as it does not require a clkref entry.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 72 +++++++++++++++++--
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b..315723a87f4e 100644
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
@@ -41,12 +42,7 @@ properties:
 
   clock-names:
     minItems: 4
-    items:
-      - const: aux
-      - const: ref
-      - const: com_aux
-      - const: usb3_pipe
-      - const: cfg_ahb
+    maxItems: 5
 
   power-domains:
     maxItems: 1
@@ -63,6 +59,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 1
     description:
@@ -105,6 +103,24 @@ required:
 
 allOf:
   - $ref: /schemas/usb/usb-switch.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,glymur-qmp-usb3-dp-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          maxItems: 5
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+            - const: usb3_pipe
+            - const: clkref
+
   - if:
       properties:
         compatible:
@@ -117,17 +133,47 @@ allOf:
           maxItems: 5
         clock-names:
           maxItems: 5
-    else:
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+            - const: usb3_pipe
+            - const: cfg_ahb
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sar2130p-qmp-usb3-dp-phy
+            - qcom,sc7280-qmp-usb3-dp-phy
+            - qcom,sc8180x-qmp-usb3-dp-phy
+            - qcom,sc8280xp-qmp-usb43dp-phy
+            - qcom,sm6350-qmp-usb3-dp-phy
+            - qcom,sm8150-qmp-usb3-dp-phy
+            - qcom,sm8250-qmp-usb3-dp-phy
+            - qcom,sm8350-qmp-usb3-dp-phy
+            - qcom,sm8450-qmp-usb3-dp-phy
+            - qcom,sm8550-qmp-usb3-dp-phy
+            - qcom,sm8650-qmp-usb3-dp-phy
+            - qcom,sm8750-qmp-usb3-dp-phy
+            - qcom,x1e80100-qmp-usb3-dp-phy
+    then:
       properties:
         clocks:
           maxItems: 4
         clock-names:
           maxItems: 4
+          items:
+            - const: aux
+            - const: ref
+            - const: com_aux
+            - const: usb3_pipe
 
   - if:
       properties:
         compatible:
           enum:
+            - qcom,glymur-qmp-usb3-dp-phy
             - qcom,sar2130p-qmp-usb3-dp-phy
             - qcom,sc8280xp-qmp-usb43dp-phy
             - qcom,sm6350-qmp-usb3-dp-phy
@@ -142,6 +188,18 @@ allOf:
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

