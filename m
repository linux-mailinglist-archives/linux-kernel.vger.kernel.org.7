Return-Path: <linux-kernel+bounces-869379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F237C07BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E631C82802
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FF257841;
	Fri, 24 Oct 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiIxXjrI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C52219A8A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330111; cv=none; b=elivCCN/TYEw7eOOPy9O4haHv2816jK5uTshNl3fGF9iaYlkdWYaas+fjOjUpZjePj2SrVr4R0O0jU75FgEG18qKdm2vUi0taWGFIX/kLh6E+wZbdpC0IjzR43OUONmZdkESRbZHx+27tbCSG7a2yVUr40j+bEjQ2MDsrvqQR3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330111; c=relaxed/simple;
	bh=7yw31bKvWUXdvacjCgGUN3ci8Wb+0zbHalVNF1rBPcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FHbJG4b4oq0cr/bx2Z2P9+Y83wsfZAjz+mYZh9C3aeUS2aMi8n371nTRzTUdR8sI18BTNx+aqtXNRTSgBluWQ6mShpCBv3meII50Bfvi0e2IXNwKbS4MLdbOJR3wyE6KUlu32keQZaEU8G5JuLcHN1lT9y1xjgoYkmkh8pjRlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IiIxXjrI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9TFl009789
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NYTo5MWdhu8itDq1/g3Rc83Xox23JPr1moP
	RAN/6mts=; b=IiIxXjrIgUrUI8rZ3VlKwK8BsUnMoIPJx8Xp+sF/GNeCTWbmk09
	Y45EzylHKaoZ7cIqGM2RsdTlnCDSxmcpPopZNa6wGgaHVclUP0Rid07x7aPbs7Xx
	v+F65OFqSYBLxonE+Xgqu+8X+WmGHM310Pt3er0V4gJIDl6wdbjQUvP7Ix91O2CT
	Fo/i/LgiNBwRwjqJiGdTVMxuouDUAJfiGK/a8cEY2YHCV2Br1/m1Y8kmh4pL4DOV
	GFpKMB4+ujkJvp7B2/F0TT1XKOoECnXu/N+/fs8P10U5S/Vzx/sVEKa/SoR8pXXX
	a50PQmoAT3DrS54/6SGgP3xPnMxKI098KhA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j4hrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:21:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b60992e3b27so1728511a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330107; x=1761934907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYTo5MWdhu8itDq1/g3Rc83Xox23JPr1moPRAN/6mts=;
        b=IEGwb/A7EqloHLBT83xyen0QpiQ8YIDaiUSwdbJOJr9kPhbpafAHxuXtZ8MuZ3Ii/6
         7QhbUE7NDLJ2dKJ/mmNiVbtVuHdo0Sv8bgdSAz757Jfq0lUaKYd6I2bE01mjkdZJ1vSa
         C2x9e9BiNiz6Y2OXY72UfWKNjGJC/xdGTRC7bZoJ7gyOiBEg5lTaEbb1LiME/Rp/TK1a
         Y9he56pkfmebGLCNswoTr4fjgFzqWocP+TRW0cftR+y9iNwGQcDyLeDBdn/a4KaljMJg
         5QNi1qpd0mqfY5Au/g8oYCbvC8idXbKRKZuJZ910FO82GJF6EVv2H8BqCWtl1KMB3U4j
         a/nA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vsbALtQkDMo9GVERUbUmElOMd8Ag2xAkv9YxGpZZQjWiG7duRkCr7C6MbymCPM7yOS9EPuRL+24avgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysAalml+Ayn+ets4+W602DqiK1mHORB+LVgfKqUz17cFyJWyr9
	5tOFZXC0DdxL5UNNGmQragmQPOHfUvCHgBNctY7fjawGtD4aI93xan9KHAvt09bZip8IirbxG8m
	WI6ulOl80qKtt/B7vvkXtEq/9AUkIXz4E5gAEjPMV1+ECAK6kdhORqr4LqJtMt2/NZ/o=
X-Gm-Gg: ASbGncu+16xKmu/GutQd/JOYxhb73thN2sjBgOwDyyMneU4OY6fiYVifqt7MjvtOY1e
	bfdLzfbsFaE6Ar73rQL8xvsC8whUjrQFNKM0l7VHD9Zn/I+C4HfAHRsxCwa4bUTL+IzxsLsmatK
	sg+BeBAyMmE/7UXoDC1hVHT02TUukq/REbld2GtXptdIIP4TEDPPtp2vTlf/6wKou7YwseapSNo
	15z44rJ/1l8l5embLnn/yeO4YtTNn2zlk3DypIilLr4xUmw5H2obbMQun+wf7h9r7YFA3kc7+ft
	azAysopkEQ2rh00mYppECWKY3jJ1AOkgivh6G3m6W3+I0psu7+fXkfU7tBobiu+zoe0HOJJND1I
	2KpcFY5sysj+qqpXpK6uSFCCGMXbORjoKYlCF
X-Received: by 2002:a05:6a20:258a:b0:340:cc06:94ef with SMTP id adf61e73a8af0-340cc069898mr876516637.56.1761330107031;
        Fri, 24 Oct 2025 11:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEByz0nyj2zcoNef7NunU6xkWZY16Ha1VVUMQcY0WT/uHuWevE8eC1lu5R2c6w/pwEuqUNT+A==
X-Received: by 2002:a05:6a20:258a:b0:340:cc06:94ef with SMTP id adf61e73a8af0-340cc069898mr876490637.56.1761330106550;
        Fri, 24 Oct 2025 11:21:46 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb01724a5sm6501423a91.15.2025.10.24.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:21:46 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v3] arm64: dts: qcom: lemans-evk: Add OTG support for primary USB controller
Date: Fri, 24 Oct 2025 23:51:38 +0530
Message-Id: <20251024182138.2744861-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fbc3bc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ZnWjciNKi5aIwXxU4VsA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfXxO1RSqFqjogs
 bhPTRufwEgTvHWLC1EVY2rY/9Yp1sfHDTksQ3D921NJjjTGmZWy4QKIywyjRBrsgyIdMOSFM1l5
 76RSVbWq9eSEBKDDFCV3LGA5mYd/VlbmO5NnSkmAFMlk14jGwBxD6atbaH9h1L5YYjFPaW9BTbe
 3fK0Eqe//2hCIWMS7hDTZ04biZkcZBtpbMOsmZFGb0gokGOCcc1RiEJj4py/QhaL7vOPZ3DGT5/
 NhBUxBdtLT6LRRBkNijt6f+SD5H/mR5kaf8QsQlIUARvKFwewrTUlQDEn7/y6JMjeHHWVHYkuAp
 4Xswcmd2F5qjQWfByzRXu5bTrskj9uKKs4nTRkuVlBmV+9s1Yd+1MFOJOZ3dw2gLUnGvQlUA8Lu
 bL23dG9ByNL6Z0sl9MyVJBEeAeaSkQ==
X-Proofpoint-GUID: 2KWqHmv4UlD4z-IADCM1evhHnAIVTCfN
X-Proofpoint-ORIG-GUID: 2KWqHmv4UlD4z-IADCM1evhHnAIVTCfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112

Enable OTG support for primary USB controller on EVK Platform. Add
HD3SS3220 Type-C port controller present between Type-C port and SoC
that provides role switch notifications to controller.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v3:
- Moved "usb-role-switch" to lemans dtsi file
- Moved vbus supply to connector node

Link to v3 bindings and driver support:
https://lore.kernel.org/all/20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com/

Link to v2:
https://lore.kernel.org/all/20251008180036.1770735-1-krishna.kurapati@oss.qualcomm.com/

 arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi    |   1 +
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f4457..2baad2612b16 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -37,6 +37,35 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	connector0 {
+		compatible = "usb-c-connector";
+		label = "USB0-Type-C";
+		data-role = "dual";
+		power-role = "dual";
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
@@ -101,6 +130,15 @@ platform {
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
 
@@ -453,6 +491,53 @@ &gpi_dma2 {
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
+					remote-endpoint = <&usb3_ss_ep>;
+				};
+			};
+		};
+	};
+};
+
 &i2c18 {
 	status = "okay";
 
@@ -718,11 +803,24 @@ wake-pins {
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
@@ -751,9 +849,29 @@ &ufs_mem_phy {
 };
 
 &usb_0 {
-	dr_mode = "peripheral";
-
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
+			usb3_ss_ep: endpoint {
+				remote-endpoint = <&hd3ss3220_out_ep>;
+			};
+		};
+
+	};
 };
 
 &usb_0_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index cf685cb186ed..f624d8d4aa9d 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3970,6 +3970,7 @@ usb_0: usb@a600000 {
 			snps,dis-u1-entry-quirk;
 			snps,dis-u2-entry-quirk;
 
+			usb-role-switch;
 			status = "disabled";
 		};
 
-- 
2.34.1


