Return-Path: <linux-kernel+bounces-831813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2271B9D9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A11D1BC38A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D242E9EAC;
	Thu, 25 Sep 2025 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OJ0ztLTd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AA2EB85A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781773; cv=none; b=AuNChL6Z4jujUw9jIwW+njqoiddd9GO241CnfLKUwDRdV+np3mfuC47wfnD+bFNt4FO2DrWAPWSWMajVQABTRHZVRDA5o/BBiTCveBSbsNxpoK9rHhr0vzvlo/4dS6LgizGzbgkxZBgLjrlswBD251QcsyTDX09+Kge8NGvuacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781773; c=relaxed/simple;
	bh=sKIpQJiz5n+iJRMJnnf9m2DoIPG33elp5oBZ4OmiH7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzm8b3srR+V33B0xKhpbrRYopa+7lsFnbDCOROu9YRp6OA91uIraEiRKP9JejMhpvASrd/upehSSSp1jEONMSsYf4gJLp3/1pq+hGn5wk6nWBNYrtWiQCVSJyGShTvvtatT8ArrkJvZaEsSnXWnVqV9/kUgVlVvohnNGbC1buy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OJ0ztLTd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Hj01021489
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LwMildERMeP5s/2LAPgO3c6kJVjWS2uLmJeeFeaZY8A=; b=OJ0ztLTdvBVxbVJH
	+2/eFGdd/yVCjx1JinzfQhfAXebLG/NF/EWili/sKLKOS7yBKgHecaOFsFkAJW/8
	dzDxmblKGVnb5Oye8UjNG1iwWUXsb5uBjbNA/qjCqAXQ7PIlc7ptKemOFSjs5UZD
	QuOtiq6MwCWYI7F70U6DFpRqKA4vmaj+52C6b/DB6qDaB6T9JLxrFdQDGnPyV8Li
	5ZFX6xTvlieXtFv9Qw2gzQAKvf4ySRixNgUMjfj1xTPfRBbsKXupPkuUVx1xWrsI
	CM+e0M8l5OuspfNVLnI0R0HklteyFwkln/zuf4/pQVVkUhYrjV6rwQqRj9iazqY0
	PZ+0/A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaek0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so565191b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781770; x=1759386570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwMildERMeP5s/2LAPgO3c6kJVjWS2uLmJeeFeaZY8A=;
        b=OuTH00XGcPsDVAaPEyA8dE08MAi3ghHxHPqydsojf85QREuDDcGS88cscowSt/pYq7
         sywpZ7QwldSKFfLNJgddDfRt/EBD0X+HvWhAIlF1SznxudgGXDNQ55JlNlnKT0zrtIa+
         lpv+KyyNg8l6am0YMfoMD0wLPxcyMGqZNeJPfTvlacVSkLfGb7lkXVLjPCq2t3yyKBif
         rRFo3YeP2YtE9o51mT3gQupLnoydTZ4akBzP0XTQ2+7L7WDasxdtJ3Xp8V59mtGX4eog
         +/UWlWQDCn5CDaEg94oMM8Lz2DDO60uVMFCe54E+qOD1ue6HLf8a76ghlNJ6XA3Dek7I
         zQSg==
X-Forwarded-Encrypted: i=1; AJvYcCXOI9oYo0XRpHTYkCruBKSOvSke5KDQsqscE2A/XODeuG4i4shbGei/sP8QP03FBCENalXpBExPBtkSGm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAvU8sJq0zDiDLbN8qexUi5h47cWoS96K5NH4kUr5ReOPYqVso
	Wx93P++FdOZJ8dxrbk0Na3YWYBUCh7SBk9agbUFP0/LFBQEq5gzWtwNHssQD9nKrmSdIwASClw8
	v3gYvNjk92F3qpOD0liAagGwOq01z32gJX4htaFqJjFEVbf+MrUVCr928pgDYEf9dvQ8=
X-Gm-Gg: ASbGncsjJqSgTVC3C8qsAO3X48SEy93vNYh/p2iZw94jPIqwRU1HNVEToigiKNsr0wq
	t/KlDb5BILyeh8su5UjnZcKVtFemlD6u/EDn4fqit2HwZLn7zjqbuIvN3gz8psIGzuct/b8dCHz
	3/vZk4wwYB1jz+GQ2yindsu7UpSZV506KoVeNlCtyQRo988un7M+a68eIGoHxd+I/ebUiUGciH7
	JpVugZ3JTOeEci4CXnotmYDoARULxpwDfo/hL5Pz26aOSBITmYuadSLORAEzqX6FF1YoksgiTH8
	CqkptiYaVwP+xHYtY/90bZfKPgqulIdXN4ugwb9JzWbkH50zbyIKAokx1CzHbsHxD8bSIZ9ODKn
	B5oXNV2R7BcAl1NosKW0UlBxHTCzvRutJSdsU05m1bfng0FsQhQeb74gh/ace
X-Received: by 2002:a05:6a00:92aa:b0:780:7bb:1c1c with SMTP id d2e1a72fcca58-780fcefe433mr2797816b3a.31.1758781769702;
        Wed, 24 Sep 2025 23:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSS6IK6n8mJg0t3jzwZnpeW/iAxvGyyHynBSGHvywzCy+qTUTCVekLpU5s1BhtEPlCXGcp/A==
X-Received: by 2002:a05:6a00:92aa:b0:780:7bb:1c1c with SMTP id d2e1a72fcca58-780fcefe433mr2797792b3a.31.1758781769288;
        Wed, 24 Sep 2025 23:29:29 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:28 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:16 +0530
Subject: [PATCH v2 10/24] arm64: dts: qcom: glymur: Add SPMI PMIC arbiter
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-10-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: NudAc6oNVQ3BHst-uWA0B_f9tGEdQeAl
X-Proofpoint-ORIG-GUID: NudAc6oNVQ3BHst-uWA0B_f9tGEdQeAl
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4e14b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fj32sBe4WaP-u41FRDUA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX3tZNchbEz9tV
 3jeTKu6/wv1ATblVa9gw5FNobsDSuGSd7YdYrktrMh1ym+0R1OxMRh1FqPQcVa+09T3uv7R9GOq
 IjjTBTf1kUhjAy1ZqNWJj2Vqd/WcPEAK3eSxM0PqzohEGHtAxWX82SCB1LpI4c9rhggGMmymg0Z
 NId8Us7eLGcQr0Vtz0jsjdrOEEaqsMjJ19IzB754BAHiyXdbuHRRab+hsH+J+QZU9nPUeDmnQBy
 3/HQGt043Zwh/fHBKznZtbZ+xG3P8mvRozyZciLD9YZnFet0ZKON37A5/wyQ4KuPpMNXvSe7yqS
 JW5drPJXG4NbH9mAn//tqzt5EOp/NrBRxfBkyeSVSrBIrXdN7sGGtJP7tgk1/CvzhHcGLMQls2t
 erG2IAc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add spmi-pmic-arb device for the SPMI PMIC arbiter found on
Glymur. It has three subnodes corresponding to the SPMI0,
SPMI1 & SPMI2 bus controllers.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 2632ef381687c2392f8fad0294901e33887ac4d3..e6e001485747785fd29c606773cba7793bbd2a5c 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -2600,6 +2600,68 @@ sram@c30f000 {
 			reg = <0x0 0x0c30f000 0x0 0x400>;
 		};
 
+		pmic_arbiter: arbiter@c400000 {
+			compatible = "qcom,glymur-spmi-pmic-arb";
+			reg = <0x0 0x0c400000 0x0 0x00003000>,
+			      <0x0 0x0c900000 0x0 0x00400000>,
+			      <0x0 0x0c4c0000 0x0 0x00400000>,
+			      <0x0 0x0c403000 0x0 0x00008000>;
+			reg-names = "core",
+				    "chnls",
+				    "obsrvr",
+				    "chnl_map";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			qcom,channel = <0>;
+			qcom,ee = <0>;
+
+			spmi_bus0: spmi@c426000 {
+				reg = <0x0 0x0c426000 0x0 0x00004000>,
+				      <0x0 0x0c8c0000 0x0 0x00010000>,
+				      <0x0 0x0c42a000 0x0 0x00008000>;
+				reg-names = "cnfg",
+					    "intr",
+					    "chnl_owner";
+				interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "periph_irq";
+				interrupt-controller;
+				#interrupt-cells = <4>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+
+			spmi_bus1: spmi@c437000 {
+				reg = <0x0 0x0c437000 0x0 0x00004000>,
+				      <0x0 0x0c8d0000 0x0 0x00010000>,
+				      <0x0 0x0c43b000 0x0 0x00008000>;
+				reg-names = "cnfg",
+					    "intr",
+					    "chnl_owner";
+				interrupts-extended = <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "periph_irq";
+				interrupt-controller;
+				#interrupt-cells = <4>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+
+			spmi_bus2: spmi@c48000 {
+				reg = <0x0 0x0c448000 0x0 0x00004000>,
+				      <0x0 0x0c8e0000 0x0 0x00010000>,
+				      <0x0 0x0c44c000 0x0 0x00008000>;
+				reg-names = "cnfg",
+					    "intr",
+					    "chnl_owner";
+				interrupts-extended = <&pdc 72 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "periph_irq";
+				interrupt-controller;
+				#interrupt-cells = <4>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,glymur-tlmm";
 			reg = <0x0 0x0f100000 0x0 0xf00000>;

-- 
2.34.1


