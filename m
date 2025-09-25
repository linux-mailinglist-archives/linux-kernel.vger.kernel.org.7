Return-Path: <linux-kernel+bounces-831624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8AB9D28E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B52C2E7F45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CBE2E7BCC;
	Thu, 25 Sep 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NU3C+jqN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D0482EB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767338; cv=none; b=LdBkc4peuTbFqEUFGZ31Z5Nxp+b1ptpoqYrlYQVT8Bgu1sHoabI9aUOfXzU+2igxgdeO8LLle0m5dDtXPZlvuZAs0HS34LwKFjpd/dFsoLX6B2aWLxBSOYiOYsJGYh4fw/Xuj6NYQlSELyPvTP5lWdtjlFMrX+lfuunGuFtXi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767338; c=relaxed/simple;
	bh=hRao4UrERcNdb8WEbncfpT8mndQ9UcxF3KEWBpC5u2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoL7tb5Xw+0zZ4jgkz35iNc/rYf3lqqjoAYe45Fz28hmBOLknSlkxHHKdUnyO8eN3eyQqrMBj075H1b1qKDRtU3V0OdeBADSdHFDh1GYugwWQtJ0SCMuB1VSaMHyuew0ISt1IzTJ+U/R07J/Z5Gcg9IHL9w3T5B++OsX26a+bTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NU3C+jqN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0mPHn029712
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Xn4sEHzNAa+
	rFACXl1zYTLnQ9MM2kFlvsIN0wm59uEQ=; b=NU3C+jqNPZacV30BvLQjAJXyLUa
	Ha9UuAi21OPzL78F4peQ7R2+UpVCyq8q/RqMUrFUVZrlPTuRWRHSmou8CP/JoRlo
	GvyhSdpbulTjrwiyie7YNASuENxa73PmvIMylnmH9qetR3PBZzlovik4X+jupowx
	NNKIiODvep37KvZ1BzKIqGhrftqbvZSsb1y6aadu8LXLOoVlbdAUrQl/OF2B3CdC
	xdv3CPEUxs/aUseEejWTRyW9VOLVlCfch+i1aWoSxMStywL8JbiVIYygW64AjGa+
	/j/IpptsWSvMGYsPllwhsX6abcjP3I8wdstjVb1MAB0B+u1rNpKUycI/Z6g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:28:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-324e41e946eso759743a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767336; x=1759372136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn4sEHzNAa+rFACXl1zYTLnQ9MM2kFlvsIN0wm59uEQ=;
        b=R1PVWdgJeN0AqvljwA8faXrZfMqL5VlWYQ6PHb2DatJr7LUeWhsN95GYfhnBibd7GY
         Om3G1xCn6v40PUK7IjeKFfvZ0FxiCAFDdSF82Lj0VRzs0kETQU5ZQvjFwgtYHYwM6GI9
         4/ORCVHkB8KWZKVbiY19FR+2wx0WBc3aWXZ7JjAz3ru767K/rZmEW8Rtxdh2wyyoBGTt
         MXo075nWb+ZAxfYvSKaIuF/XJWSSaql+pTpyBeXdL3u8L8ysSE7/p0vjalkNMeNHIYjf
         VHwAAWRdd3L/lRsKKoSDaHYh93gh3E53cTIwKxQArrS1Rwkes8B172MHM6Pii0H6SH6G
         ozyA==
X-Forwarded-Encrypted: i=1; AJvYcCU7STTotKs23E5/YR9ugDl3IATBUkWwxEiOjOK3PLSMoUL4PkkKmVz6wf0p7lvBFVNlGw7BihjuhHeXZLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0mmnwtl4QSYEGN5OAr1cvIra1oRLh3MUGS0bXt9OiY9MwNaV
	urVNsJO6UwNjCrM1thwneLzA6M8dNiQpV6MRKvXCCXnD1DggSo3935cQ4tMGJA20ojyoPJEUJ2i
	9jm4wDlKQycJBLZsZtQAsqdkzLJRnRAqJIw2ZzjLww9PEwZW2hMvxFqU9N5mCYnSMyGU=
X-Gm-Gg: ASbGncsUdReafakz3UFLr68SnmV30t4M0O7wPMhMDZeXVZEiMoC2cz2AjN+pMufp9OQ
	mA5ab1mhKO4CxTlNadq9mwO9p51BRUmuQ/clo+h8ARL6GRehM/X28X/PJAIGYeI2KE1bqY7dica
	525TJPVWUgt1l3gn6bk4GY1zrpfNQ90jGOitgtV6oJjpkUdeuyEGf40yU1duM8nNDDuRuHjlhmT
	ncHEo0At/Vl3dvcrVGB6sIZvh1HLjwlQ8nH4zX+va2kbvtZI4RnjgqsQDc6jqfFfFZ730AnB3eA
	h0OJy3xbwwFJY48Z8mFTrmXfu0uShqSUvXQ40mqtgCzcblI15oDRXj8ETD72s4yvgfbbL0BDRhf
	hwFSsHT8kzZ8ml1lC
X-Received: by 2002:a17:90b:4c86:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-3342a79339cmr1495555a91.27.1758767335543;
        Wed, 24 Sep 2025 19:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgXeMBQTVJUw09Ed16G9vpiBcqbEqjObxvR8uAyaAS4aBdffTCSPvxaIOoG4hdBmWBMeZxSQ==
X-Received: by 2002:a17:90b:4c86:b0:32b:623d:ee91 with SMTP id 98e67ed59e1d1-3342a79339cmr1495526a91.27.1758767335040;
        Wed, 24 Sep 2025 19:28:55 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:28:54 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 01/10] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: Add Glymur compatible
Date: Wed, 24 Sep 2025 19:28:41 -0700
Message-Id: <20250925022850.4133013-2-wesley.cheng@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: YEOW0LIA-ByuKZK8Zons4fwIoMvnPj7R
X-Proofpoint-GUID: YEOW0LIA-ByuKZK8Zons4fwIoMvnPj7R
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4a8e8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=tYbxrAoMRz_Rh0uxvwoA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX+dZeyo7HKPrp
 eAFrK4SH08a8N6qCckJMpRl1b23YYUGHL4F6xltUb4mIrbbzkSQ1dQk9WKral2Tixre9iNmT1MN
 XblEhpIQdKD4XqWO2ZVS5g8JdbNzcB7Pd9uFg17mZntvFFUFPaiRHZLJa5cadD73QC2lklYu8UG
 oJ5OG2FxTpcfm1F8L9BRofMWYuHgBEcxCv3x2daBDKerRumsyrpwDTB5JlHdVTUWw+v/SRdtjWP
 3g+TrKD+h+aIdI2sQjt0clZtVMjIcnj5rsa0r8cpvfd8aWUVKR+HQS/tpVxLEpcrNpk+q3k0cRJ
 Oj7d0UK9UyVSr93tMHqzDgdIZ52W+9eA2k1jSeQRaDyMY6SmQtrZSaEcX5oCxqbod9wDcwUSdaq
 2Sq8P5ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

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

