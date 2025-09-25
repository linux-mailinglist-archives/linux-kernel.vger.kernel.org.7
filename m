Return-Path: <linux-kernel+bounces-831841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DB3B9DADA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22DF1890342
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C082F0673;
	Thu, 25 Sep 2025 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Od/8hjz1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575982EF67F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782036; cv=none; b=jreAKVHrFYKf/Q3UBPJIUCXWboGtzbefDa2nVdII6IlEFtK8VsK+E7X6PpGXbNwn/mLhbzE25JtLBPNk1XkbMnQSU+IZ0ftfvRDq6Zuh1zg3jSFOOLYTWP/Xy6BjtbwgSRk3JrFuWTmfm2pqOc2GO+7O+1CbqLPgazmiqN7TVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782036; c=relaxed/simple;
	bh=sKIpQJiz5n+iJRMJnnf9m2DoIPG33elp5oBZ4OmiH7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwZWnlC5/RKEuj93cW4aJm8iHRItvJbnLQs/GhhD0Lt4DNQwouYYrihlyRW9LDC9tebXdwL9XHTn8QYI7NuO+DluQHQ/ZFUzAX9ouXiVEK6EWhvSus26gds0iZnVPphYVJixkIPfK3449zc7GB+Hc+rwc/Jtvp4lkJIK3YWTbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Od/8hjz1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aWs0027688
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LwMildERMeP5s/2LAPgO3c6kJVjWS2uLmJeeFeaZY8A=; b=Od/8hjz1gNy5qM5s
	fVdjsJFiDN3PPHSyTxFxolsoMNlcKxn8e5QJWDlMuZjJzsRulsRLFRDVS04cSvE3
	GrUdIRfwGAYktS1pAQ44/vzH1sCqCynKnrpXn+QZZCtAGHLXifEppCYl95mQiBlC
	p62Z6fV9U3GW4WNuVHPIw1YTY/bme4xnt19qxYQrbHr6NWaNfhidflIHN7bpbqtf
	Oxduj1GDvoJ1rlsGfv6u1VrV3vxE5QS3lvKtgyQ1ieRHMsNBuVAtramnsIYZqhvD
	p3symyND3YQQDkqv0qpCVg+1TzfJGXBfBKnLVrujIjGvxWPPy+45OPAgZxxpPuCT
	1O2Y4w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup08v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25d21fddb85so11137925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782033; x=1759386833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwMildERMeP5s/2LAPgO3c6kJVjWS2uLmJeeFeaZY8A=;
        b=Sq3TmmLlgVXbwFA6rj60ZGu6gRBl9a0qtGPiy4J2N19H1nGsOimRFZm7ajfs/L8ju6
         WRjDcyVxveD9Va5TM2mBuPUiYEiEFjsqOucPlhHB4a3FD2DWOfh4VqvvCnZTv1Dzfogk
         8CfddyEgoxG9Cc897sDE7JhPzmmSRMIUgqXL0EwzatROwxO61JG61HFUoIHORKFXvc99
         0e/mtKlKZz5lYkp6AgiYdKCxjEcbuO/UBABAC5uZ+yDbSDVZEMPeb1CzewoXaCR/tL44
         y4Q9StJcs2R0AHoPkdfaNgNqW2DbtGNkev16pOMgLYV4rUXuKcL9kxt6OFeMFM1vAC/u
         VC8A==
X-Forwarded-Encrypted: i=1; AJvYcCXamO1aiH4nWZ4OQ0Z6g6/oKbwtRLaOXTV0L23WvgNV8S/zxl2CgehiW/Fp1xLZV/Rj+u1EUpJ5sv897P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMzkVqgdal2qAQTxqOkra6ethFMw+a1Wl3wpkcfz7i+ecc1MT
	i4WmFGZ5NnUY6g0wKd52YrI49ka/QkNWspQ0Mv6EaZcSkCKMCJA0o5RAvdMkZBu8/w/sTGo/lVK
	5zw5hDIWiUYPLVwYI5My/V2GT6oab4nnMc7+uebUMAWyf/ROni3d2dRSMBMR6H2XTfbo=
X-Gm-Gg: ASbGnctglLsqcw6llw3AtkL+9TasoWoq5h7zlmLaVnchQugAk5hUWteSRmAGENljsxC
	Nf+MV3997jcuCApyU7ffuErVTVvpy6n1xRDo/lvmdR8pgpZ1zak7snwPIunOt9qcUjyQONUuVn7
	/Tx+nbRJwIjm7XNRUk/K4US16qOUOki4StMiQlsGNcC0IG2qTeMOLsrI5soxeaBSemgA3KxALAA
	tdNFp+8wh4fjSel2TYmn6gG9UCsCxhkpXx/BmlW3IOxd/31pdj3I2xkxITx2i8yojSaaDfwZuZH
	b3HPgZOaL9Pj3lcm7gwI086r7MQE4gYafyCOzqeVmrdtot92T9bO+9cgnwV4xGSGgsXQC1CsUN6
	d5WrOruFsKrW3FB4VuBS6euHWM8RybgLZ6oA3U1J8mM4C/NpX+PeNcWFZCImt
X-Received: by 2002:a17:902:e88d:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-27ed4a5e907mr21537955ad.50.1758782032513;
        Wed, 24 Sep 2025 23:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy9xf+4ZfODJwxxZSZfr51YdmBTrmJhyNT7pD8G9hsp0frJmhp6gtCuPlJmDRkAV6whVx4pw==
X-Received: by 2002:a17:902:e88d:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-27ed4a5e907mr21537815ad.50.1758782032097;
        Wed, 24 Sep 2025 23:33:52 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:51 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:18 +0530
Subject: [PATCH 10/24] arm64: dts: qcom: glymur: Add SPMI PMIC arbiter
 device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-10-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4e251 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=fj32sBe4WaP-u41FRDUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX0FDRQHidieKk
 1flthAA//V2UTZX4sa+dxvBhSZgfIprJl2VPkp9BtjYhcxk1gB/rx6lKBwVjhvQyzT6oaI5OkQi
 Fx6YINcj4gMDsHEKrlCyipGkFptCwjA26nbLqgL1O3Y2nvUMhN9XKFUtZctv1+3nUHnLL3HUoiw
 QQj9P3CUnvhIujkSCXJ7M2RoaEdLzBvJi7NL6JpVjQaO2gFgV+Xvb8dXp8nE2CFvXFNg91ykFNo
 K6EGfBPhIcgxfRrGS2bNgVdvM5lebjuUmkwvhXxv67UPuAs1+xmnCNmSQ5WXxEWgOwpG5d8yaCc
 abEktPjBhfg8D/1+AFTKRabxHfYGqsnQsAvu/sE4+k5bvZ1zSYE1VM1qyFB2EgwHGsMkiR7yYv+
 IXY8BOBB
X-Proofpoint-GUID: CxMQaLod9jKHhVPXC4qGMjaW-0FBb2Ic
X-Proofpoint-ORIG-GUID: CxMQaLod9jKHhVPXC4qGMjaW-0FBb2Ic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

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


