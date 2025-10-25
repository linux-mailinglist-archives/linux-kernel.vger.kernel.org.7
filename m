Return-Path: <linux-kernel+bounces-869666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6AC08770
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1814EE5AE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FFD1E51EC;
	Sat, 25 Oct 2025 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mKp/9JhZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501C1F1315
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353280; cv=none; b=cjzpoMkRIuW9krwaKpMCz5tjkdLCnmlRNNIdSMqTCsjNkI90NXBdPvdyV0jPYGIsFXCIcaVtABuC9mdWpsZAL6TF4ADVx2+OIIe8WMhGpahIyoGgI/k0Je5Lvif/mkpHpgzJ+ggnXcwO1HrP+urMkukPN5kZzxlODFYVaUEH+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353280; c=relaxed/simple;
	bh=8f3QLSZbdMi9oAnzA0d0BJSP3MSQ5ZUA7CnreHeSgY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRC+n5krungaMv8v44YU1ZpXDqbXceoaVRONhj2LAq0eBJbMVoVwDjF2FLGcAjXvFA11sy6JWjA10rjjgcJFQRjYfBXZBx/ADA2uUseRWdiKuG39J4qXPuWYhmxSLNQXSt50dwA75VzkvaMYJwt/6hHUR6g7ilxR5yoUrWYj8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mKp/9JhZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P0lwJS028098
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OiyCrMPdV7eNoEt1MqrMVwtFtL3LASmksliQC+JXb54=; b=mKp/9JhZhZZ1TD7W
	PyTs+CK1Oinl6Ufl8v93qCKzz7bu0yEgtKx6LvhltTCQzViqTp2kiK21HYRXrNak
	4QFZOXKdIL3UdQKau7G00TJP1zNk8W3aZvNB8fqaaonXuWx1dtzY+s1WCwln78Zu
	MZZXl3Zf30YXGIA3Ao2Ycy76LZpft5xmPz33aK/rh9wGXggN7ZLPYMGG+argMi7+
	xlWHHMGmpp8hd3EhlJEap7jVsC8pcS0oqUbxpdFCEWt3ELDEnexjkP82da/kOy3X
	Y7a5VCKSLNuyX8GzTEuICmTG+EQV7GmrVzyip1wCnHr5KZ5tYQot72IR8teaRhKe
	8UJCJQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jdh4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33826e101ecso4216561a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353276; x=1761958076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiyCrMPdV7eNoEt1MqrMVwtFtL3LASmksliQC+JXb54=;
        b=BMIRJusfh9AvB/GiULESEaSjvjyhga7zVYa6R1RRpvlNebpbbBvSU1SqZZQDFJ3xh0
         SgGvfNDdPE6qC/fOPFL59rZW6dsbLFScryMqevq0xPwNg4WQX3aUaIQ7PZcAnIxp72yj
         30SzjAgDnkH33kISfhCDP3m7HblJ3KDsPrL72AIGbKGftXpNCnYn+4nJKSz5j37tnL2X
         BnPP2C/2r7P+75SfA1Tq+WSwMGq+jVZ0lw1w+q6/AFifwMaV5uvDdsclJsltqRFmU16N
         lkr95F/1tMmRABg6IHZvDXpTEa4H/0zFREMluyKtK5qcdVWLh6cDEaWtwxiE58Kj/8TD
         rj7g==
X-Forwarded-Encrypted: i=1; AJvYcCW2Sk7P4gbR6KjvvxYkT9I8ou2tYVV7R6sleS2uM2HNiIii47+d1JdOnSW5FilCDYrfdqan8dPFMSWMILA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbR5GbIKDghYd/E8yaPcW5amGNG1X1Bv6aCtxhN/ZflLphFub
	22qMlC9JgZLX1jeCoL4Ih+bi8ZEm58j9L6Wi6wYSsJWNu/M4dBs4ve0ySL6sybC/bPdVqKD/MwZ
	9jRG/GPp71AG2uqEBdHJ7/t3jYWq1L7pNWcAAOossNxl9sUWyBCnGpG9M14gx8TJIQQg=
X-Gm-Gg: ASbGncsDcWudng/1lYkQeaaKo+xoM1aLmtOaxWLMK5R53vade5+0Z9jDCnhLglqvZbS
	OqAHQrg/TxU2VazASgIpE0xpaoXG+0ZO2Cfon6D4KrI8DvraD0ZBEOq6Y9vqp0+dnuU4GiAXux4
	Ymp/Ap+gq1TOirkKhjVkD6fTv8XA0ps7bSR0C29sfH5xz0UQB3iiDwRBZ7b+wu5WdJthDzXaTx8
	YxMW/NPEBMxQ1DfIggnyZwWrOgQce+j+W7nKHfjNqGyIDKx6Xbn3KsUfvBOnbT8JbWDDzXsDENW
	fNZSTQQM7uMhyPvDjPxD/GbcEUui92FfmwR4IMgMwfOXp1ZoYey7ZeTwasWKQWuRZVQq/ELRtL6
	ucOeBVdnwTCr0/GgvPvtmTU4ZuS6ivg7oGnUHRUuuvniE8gCqIDo=
X-Received: by 2002:a17:90b:3a81:b0:335:2d25:7a7a with SMTP id 98e67ed59e1d1-33fd3d2f95fmr5490256a91.10.1761353276305;
        Fri, 24 Oct 2025 17:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMxipVLSbzaSHbq2CMVQ8XouhSVyv3oe+2+wmcnIacWAZFWHjqUBUerrKYH+e1VF1BVwR2NA==
X-Received: by 2002:a17:90b:3a81:b0:335:2d25:7a7a with SMTP id 98e67ed59e1d1-33fd3d2f95fmr5490230a91.10.1761353275807;
        Fri, 24 Oct 2025 17:47:55 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3eca8dsm167352a91.0.2025.10.24.17.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:47:55 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 17:47:40 -0700
Subject: [PATCH v6 2/8] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI
 PHY compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-glymur_usb-v6-2-471fa39ff857@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfXwKVRuKRL6wFH
 tdZGMafcywZyV6Bh0gsTbPSN7lNPXQkyDwLK4+NMZ5yp6G7f1ot8lytpiatDVRq02VwypNpIHbN
 6F9PX4PTYau2km6HBgLCZLGD1ZWNmv7IiltIgv8usu5fS3+Dv0EpFtUAoCowDOtLb4GEStw9nWw
 Gx1TcdC22PALNCWy2D1PmTtjQ5eXiDkrxUZ/TIc/RzT/L4fCfLji6on0gpE15uTnoBlGAhiFIg0
 VtIPcj6hqQ54I1AR4Iu7V/GFm8VZSN0GX2m0R+/sCafhqyb/mvbXuGioLGmI9CQQJXR4n9gdjSb
 i/Tan411nDo5fVpQLYMsOb3ZjrMM/iw+z8Wj03OQAw6Xhd3IWg7Oex6hzCmAgpKlpdQf2lb64Yk
 sKdCNCvYsj61F+9e3RICnl2Cv41orw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fc1e3d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=hwycSGIRGvt53hta3DgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 7XLyY_H47Dwran2eF2Ibpo-A7POfemsN
X-Proofpoint-ORIG-GUID: 7XLyY_H47Dwran2eF2Ibpo-A7POfemsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

The Glymur USB subsystem contains a multiport controller, which utilizes
two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC, and
the required clkref clock name.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index a1b55168e050..f277fd547746 100644
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
 
@@ -114,6 +117,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,qcs8300-qmp-usb3-uni-phy
               - qcom,qdu1000-qmp-usb3-uni-phy
               - qcom,sa8775p-qmp-usb3-uni-phy
@@ -126,6 +130,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 4
           maxItems: 4
         clock-names:
           items:
@@ -157,6 +162,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,sa8775p-qmp-usb3-uni-phy
               - qcom,sc8180x-qmp-usb3-uni-phy
               - qcom,sc8280xp-qmp-usb3-uni-phy
@@ -165,6 +171,19 @@ allOf:
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

-- 
2.34.1


