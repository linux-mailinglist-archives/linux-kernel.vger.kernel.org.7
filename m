Return-Path: <linux-kernel+bounces-840570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476DBBB4B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C8A7B31FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30529270EDE;
	Thu,  2 Oct 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="czC93znZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF532701CC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759426199; cv=none; b=hfxQepcdgOfaW1V7T35lJGTJCnx/nirC/g/h3sUJ0uLpX2rbDOy3Lsp0lk+L2N87WIVvWoCxD9bZcw0nObnjAUHBhNLrAkIeP4MjCBFzgcfohSgzxbmsP1IEZjkm7Tgw/e014pM4EOMDe0LYvzQu8ks2qv8pvY/9ie9V1OX4QvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759426199; c=relaxed/simple;
	bh=OHoKfenkkZeUL4aEKkXWaDMS5xwa9OVcn8G+fJH/DwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X2+50nMM4ktg/82011rD7yVnhztpz0sJxGF7jm7hSl9BvcSVkjSX+OMIMUBO3oqz/WA4TaCYZSxsJePbB0dG1I4BKtdpoVa9CPh9uxDvmInsOrChZND9tU/eDff0986KxHMKN6M1ebNMu+OF1kjQ0wKIIBW/bICqA0XC6HoIrTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=czC93znZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929JIwQ010615
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 17:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2K4WALy+qgmjcjsUYfMFbKUPzKV0gN6DWu3
	a+fvLGiM=; b=czC93znZd5pUxJvPY66H/uaaTFdHbaRozXM3s7YrGOyfWxWc5r5
	HI09nU6HiCYhzDwlNRJSqO4qzJJaQoMRDg07qV8/+I+z9b7YulMQ2+JluTEdeyIA
	EOJYXMPBOrEOUiR//O5T1lLu5+NVLx7WFgvmLsQU2HTxMgURGD0g+nkAh2ZO25AY
	517XueFVV1iWej4IxG7Mmj9gv4ZUlZq2jl9m4TPE9zJvMuZQsTS1OsVs7BDDyJUl
	DZZDAA+mCkFJ8jsh4PGdDiIRxXLlr5bk85aD2aT2eq/K4UJen/Rhd8n0bmIwi5F6
	iRCS1H8Gjcw76b0opwE8bQbcZY/EmXbvj3Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hr7fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:29:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1279958a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759426195; x=1760030995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2K4WALy+qgmjcjsUYfMFbKUPzKV0gN6DWu3a+fvLGiM=;
        b=a6ACJQoXWv7/cNDcZC0LhVtE15qtFbxcCf8+9NChPFQcWCMKGPxQuI4Tz6RnrbY4qU
         9mjCNk2u5NVb45LgzrgDWBzZFk4LEjeyVyZk5L5YYwXT0Q/6lNIXDT/Bj0exaj/JyTMF
         2Q+n4Bs5J9s1fZHIS0jyEp/CG8t/Z+5vvQFnP5XGf3/tV5c9T27EIeRszr9Oc20Znfmm
         PyifJf1TBnW/MQouDEOxm/1AxlZ7BU7VgBlWn2fI9x2+gBTQJ6Dt7QzhDSKzhn/7w4DO
         10YDNuuuSPQiQcIT/Gu/g+GU5o23i7cv7pKKrusW1s+BHq6d5h3PuLosspaJrlbvuU1i
         Jlkg==
X-Forwarded-Encrypted: i=1; AJvYcCXN//4U+JRbNFtAGKAk76iESqXijUlgvo6RHpkkew7No6mDhy9xGdONyTq2iu0tzbddhJ0rn77swbP0JpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicSei6AmLIHsMUJeni4o3Amg7cY0It7UGUtdUmfXNFUyrJSUx
	KNDuveTP6LKabIJI1j+kICl4rr8ttNAEmpj5G3PWpovANHpnPzPniQuTb7iL3rUOAjgX3E+tJjw
	zrS6B9ijUOlEqAZPbG2663VT7qXb5+donXGSO5H8dSmiPlgvgbHZWWuPwovWn1W11OB3AwQY1Qz
	o=
X-Gm-Gg: ASbGncunqaO4sGFZq0pelLcMX2FjkBZG+SGWRlekR8hQ7ggq9VT4sPqK21fS5/sQuaG
	w9+KBcklKccIsp7ZOT3wUJkqR+/fbhAlXvfRBY+8exRZbBFnxZTYD1h6EBIpT4zwhqh9FAXMJOY
	+2GGJjnv1JmAB2OTQSfvAseacgGLFcZUGXPzwvBZv4AQA9CM/OAJB/u/gTcTId3tMsRPv10K49Y
	P0YmqDn7LuzAPs/lSKTpSmdVCCWYPIv2Gct5Ctd/JCwuEdt0YYFfQSqmBKmeQmoSMheBtbcQrIs
	ufUoEWh2sp6rgo3cdHsjBRBtSub9gmFHGgbgZWSiVU2KHsHI1L0a3Rrj7it0WqFgGondnGH5VTY
	FvGLWERE=
X-Received: by 2002:a17:90b:1b0e:b0:32d:ea1c:a4e5 with SMTP id 98e67ed59e1d1-339c27408fdmr161448a91.1.1759426195195;
        Thu, 02 Oct 2025 10:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTWw1Wn704AZLarxwHPh5CPrR0ny524F3pzD140Nw5R/Lo81Fvo1DKRlLwaL2oOOfz/aU6zA==
X-Received: by 2002:a17:90b:1b0e:b0:32d:ea1c:a4e5 with SMTP id 98e67ed59e1d1-339c27408fdmr161427a91.1.1759426194780;
        Thu, 02 Oct 2025 10:29:54 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm2384206a12.4.2025.10.02.10.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:29:54 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH] arm64: dts: qcom: lemans-evk: Add OTG support for primary USB controller
Date: Thu,  2 Oct 2025 22:59:46 +0530
Message-Id: <20251002172946.589061-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfXwykRwQHV+23a
 x6bqb+u77j5BFKQVhYM1rpSfH3hdI8Hmuf4xHJvWGclMA0+ZiDRpdyMTiNLj2ks7NtJ/DSpvVkP
 j2ZK//VfdP4PoGo98OFGn8AM8SJ3jAk1zDCOmKBN7fhDCEkdzA5oOHn75LpyWcVOSQ2UWM2RNX0
 DeOSKWMUfB8GenK98mXY07OaI35brOkoR+zgMYs2+3vu7u0CBpJcXRoYhsPl9xN3Qqbk4UIPbWA
 jgfRd/cxC94gFYkzma3Jm8Esxs0PN+Pbjbxr82/pCfXnmgYp0yaaxDwHMJWoP4MDVmV9LgRYsAa
 B1AbiDCRGXM/7vEP1qp52NdYxapbtXr6sm43zX46FqK1XrxEqndftKoK4FvJRxc9oPvyqik0fMS
 KAnS11DTxEPY9GutDo5DIjmk08tzNg==
X-Proofpoint-GUID: svntSSAwsB_LNitWBEdBVcg-1PpnBnHx
X-Proofpoint-ORIG-GUID: svntSSAwsB_LNitWBEdBVcg-1PpnBnHx
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68deb694 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IWPWNUkvg928VfuaY9kA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

Enable OTG support for primary USB controller on EVK Platform. Add
HD3SS3220 Type-C port controller present between Type-C port and SoC
that provides role switch notifications to controller.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Link to driver and binding changes:
https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/

 arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f4457..0b6d8d2d19d6 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -37,6 +37,32 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector0 {
+		compatible = "usb-c-connector";
+		label = "USB0-Type-C";
+		data-role = "dual";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				usb0_con_hs_ep: endpoint {
+					remote-endpoint = <&usb3_hs_ep>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+
+				usb0_con_ss_ep: endpoint {
+					remote-endpoint = <&hd3ss3220_in_ep>;
+				};
+			};
+		};
+	};
+
 	edp0-connector {
 		compatible = "dp-connector";
 		label = "EDP0";
@@ -101,6 +127,15 @@ platform {
 		};
 	};
 
+	vbus_supply_regulator_0: vbus-supply-regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_supply_0";
+		gpio = <&expander1 2 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+
 	vmmc_sdc: regulator-vmmc-sdc {
 		compatible = "regulator-fixed";
 
@@ -453,6 +488,55 @@ &gpi_dma2 {
 	status = "okay";
 };
 
+&pmm8654au_2_gpios {
+	usb0_intr_state: usb0-intr-state {
+		pins = "gpio5";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		power-source = <0>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	hd3ss3220@67 {
+		compatible = "ti,hd3ss3220";
+		reg = <0x67>;
+
+		interrupts-extended = <&pmm8654au_2_gpios 5 IRQ_TYPE_EDGE_FALLING>;
+
+		id-gpios = <&tlmm 50 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&usb_id>, <&usb0_intr_state>;
+		pinctrl-names = "default";
+
+		vbus-supply = <&vbus_supply_regulator_0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hd3ss3220_in_ep: endpoint {
+					remote-endpoint = <&usb0_con_ss_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hd3ss3220_out_ep: endpoint {
+					remote-endpoint = <&usb3_role_switch>;
+				};
+			};
+		};
+	};
+};
+
 &i2c18 {
 	status = "okay";
 
@@ -718,11 +802,24 @@ wake-pins {
 		};
 	};
 
+	qup_i2c11_default: qup-i2c11-state {
+		pins = "gpio48", "gpio49";
+		function = "qup1_se4";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	sd_cd: sd-cd-state {
 		pins = "gpio36";
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	usb_id: usb-id-state {
+		pins = "gpio50";
+		function = "gpio";
+		bias-pull-up;
+	};
 };
 
 &uart10 {
@@ -751,9 +848,32 @@ &ufs_mem_phy {
 };
 
 &usb_0 {
-	dr_mode = "peripheral";
+	dr_mode = "otg";
+	usb-role-switch;
 
 	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			usb3_hs_ep: endpoint {
+				remote-endpoint = <&usb0_con_hs_ep>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			usb3_role_switch: endpoint {
+				remote-endpoint = <&hd3ss3220_out_ep>;
+			};
+		};
+
+	};
 };
 
 &usb_0_hsphy {
-- 
2.34.1


