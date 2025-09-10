Return-Path: <linux-kernel+bounces-811098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E13FB5246E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EC3A823DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87430BB96;
	Wed, 10 Sep 2025 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gXj3aQ7Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4895313278
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545568; cv=none; b=YRN3wFvSlT5kInr2uY4Qikvmjh48xu3tHsHTPuRH6lEiVuUeY3NL78sIbiawTK3XpVy3zC6uXwU8vJqAqcWplU8MTpKcrjfLVio1mLPhkc+9P6/l1ZF2ZMxokJOUpZIsnXNK4Wl4/uqVv4MZ/wpHQCRhUyJkj8/XQJdLcMQTKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545568; c=relaxed/simple;
	bh=t2qrqMR/G+G+54L4hxD+xVPKf9gtr+WKrEvF6P4UdTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C/WL8uPtRWPDwawGDUa3EVXNzl42ViB9CjNzX9LhcM9UkmVnBojJppbwjKTN4KJQqXH5npC/KOk5EyVwhvme21G9eX+ieDZVB8gZ4Op/zzZJczddtSL2W1eZrsXOftU26zw6SP9Xj9tZ5Rx0VpaQaWt0dgnJ+22FS09UCGQ4IbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gXj3aQ7Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ACgGIw011377
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CgMJr+SMduLpu1LRf9u4NOLYSl+sqmYe/+pzch7UptQ=; b=gXj3aQ7YlvzrxSl9
	4DourV5bNefiiAor2m8E4JTf2vGyqHph55iJrZM3whKoVFep+5zmhk/6Mz/E45ll
	l0rQRDQV8cmbsVggZls9LX4kRqAdcb9WOyuu5oRof7vAWjgXxCeahmdT7bMblVF/
	9ABKpXF7H+xrPN1kIFYXNo8OVxIIsOWMNoeCfhRcbFOam8TiBnlO1AQAmROilBln
	0K2WWaRwulkXg3c39b8nqdqsVoDAl0fnaFrtm+/4yNrN+2k8jDyNjtvTzLoxU3JH
	XuQHAzUM7VmdcrHMtQKeYVIETgMFgm1db+VUjdSspPC9D481olHp6TjyFv9AKnSY
	BQZMLw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0wg88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:05:59 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-43839a2ba78so11253b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757545558; x=1758150358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgMJr+SMduLpu1LRf9u4NOLYSl+sqmYe/+pzch7UptQ=;
        b=nSUyJ/RZLs+trpPYdwprhS4MGjW6hVFwIyD/x4vT4EaijxgnwRU7ObMNo9umQYxy9a
         PO0DBrECbrfVAerjFpAAPIE4dgTSahnYtadaodZY1KgSNexe13aZNktr+T5LkBsqNOWJ
         fosLxIqqTUAMGS/DSS8E9/ZVZZKFcUa9CJWPxo+J5Lp4Z7QRZwXjFGD/Zky51kl4L0uQ
         oQoSfDTenVqkOHdLglvkrmzUAAVsvINYh4nrx06zZx3fiXhKeaD+DwZ7hprp4A3b5lXX
         yKxPaD19RxL91x0Iqd24wIhbf1M/qFYlIBVJnRoDnI2IFZzNY2ZWyASYIfG5ec7hL3vx
         hPow==
X-Forwarded-Encrypted: i=1; AJvYcCW12GExwAVsTRTycYDa5Xb3b+rAbeGvpMALpFWRqloK4iGcFd+to1nO7yzfuxaqvpSg5KrAjRKorwLJ1io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpVjAF2/lmhtaqCOdpHGLLORit0zcoSKxej0Zij23APAMwKqB
	qYYDuZnpEJuwBVWQRcCXmTFr+4dduwz0EGhRQTr0L6Pvoq9tTwftTU1Bu5OdQ66ffw1yrwwhZt/
	lAzRXFKl6WurnIoyWYEJUa9ynJMgv+3PTTEPtsRpTD6i45Go0wAZgBp+Hix7a3CmQK+8esyhHCM
	U=
X-Gm-Gg: ASbGncuka18THvWBMbW8RpaTGUk3rO8oChUqbnJ1pKClx9WcyqSS2okhtetmm+56xya
	SNCb4sVgI9SHeU+oyjh4gr4Uh9zbYl0niXvM7Rw+SXyJJ28rp2RlEVWymJq1WKlpiI8gRxC7krL
	OaCWWa/aEkpxeN8jCi3u0GBseSsX905jM29z0J0lmDJ0Jk/VoDqPJw5avNS1T7rZ1iIx5MZsGbh
	ZxH86QQX4dXt+qtv2A/zPPNAaNuGnHKhnoPOwaP08u+Cxw6ZGxyKOlenfAqvORH1gRm6JsUreKV
	AgwDuKU2Cng9wh8sLTNcizk+Z3qi+XR+fsaqPZqetrFLiiPus08DcVFHDJ6sL/BbZI5mCfEV18e
	nWq56V1NORgJRKrsGUMALHc/sdP7x+4D+nWs0BvA=
X-Received: by 2002:a05:6808:3192:b0:438:26fc:b635 with SMTP id 5614622812f47-43b298d6740mr7011378b6e.0.1757545557677;
        Wed, 10 Sep 2025 16:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzha0Dag0S33gAaDh70IwT8Yd+wWecKECOYRW0w9Uik7rZ1MHNLc+cpPWtALr4Pg6wGnPpsg==
X-Received: by 2002:a05:6808:3192:b0:438:26fc:b635 with SMTP id 5614622812f47-43b298d6740mr7011366b6e.0.1757545557122;
        Wed, 10 Sep 2025 16:05:57 -0700 (PDT)
Received: from [192.168.86.59] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b7f1f7d63sm23944b6e.29.2025.09.10.16.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:05:56 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 18:05:39 -0500
Subject: [PATCH 3/3] arm64: dts: qcom: qcm6490: Introduce the Particle
 Tachyon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-tachyon-v1-3-5090bfd133e0@oss.qualcomm.com>
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
In-Reply-To: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=22416;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=t2qrqMR/G+G+54L4hxD+xVPKf9gtr+WKrEvF6P4UdTc=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBowgRQREDK6XbTXMSJ0xzPSna7I0Ec0GUyTI5K0
 MZ8joYN8nSJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaMIEUBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcULDw/+PtCFNbvsJ9W2y3ewDRd2P1ZOn7CVqcRd17IsAoH
 9//+VsGHBUcmHadarxLKQ+MZ91uBCVScdLJpLxsDWTMiOO1NedSvfLMgDdyS/T2H4FAxk5yQbaM
 gBiWQGTUefDxajHIJeoILYpPDWo1MwoLc6GYw14M58vTE/zym3oNzny3DAxyCvFd9NH9RIST9hn
 a/Pszthv6i0Gokc3zOyODG7w+8Q3RIbH1OGkI2nKp1wp4yucyhegtiXIn6iCINfyAkCNMHG6/jh
 DNOKI1qpz3X0h45SH2Gx8WxVNvKWnn7vK5XMYRGI/CNsBFPsaNLYi6Aqu6qiHwhjrQw87MaVt1q
 BlGmN65WPJYFY5DEGXrvdOo7OCRKTxYjK9oUsxG/LldOyp3p8Sc30HYjiAtc04ecacnWjV7y96K
 2yqmAAQNoSJmhVvXDih8bYo9/r+gzPRWmSCJkYG8UfeHEy6uojP6hK36lxh6McDSiEe5znjZjlt
 P96h/wIYKkHJ0J6GjLccfRJEuW/F/jMCrft75tSuWi0swiNzDEzoZQDmpRrCbphMgP11IOrHRpi
 ADrqwv7bv0mwzdPl08mSiYcS+XImySXKNrowDGYN3sbONVrr89uku39n271QkgEMxmUJU0yECDk
 MyvsW1OV1vHMm1IWDPKKWGbpc+X4ll7h3h4hWpJdVSSY=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: 2z-rGMfZhX9cQJIUsGU6fvWzrj9ou2ai
X-Proofpoint-GUID: 2z-rGMfZhX9cQJIUsGU6fvWzrj9ou2ai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXwzOX5j/puOaN
 gwh1WTVGKV9ZuQo/0lgympAqoJ9f1qY/J1T6/q3joYysBMCipunEKCaz2+zu3iDaSJHdwSZEBim
 6/uCUYcDIJ/9ec0izBUzQtmiwe5Q+A8xK4V3bvbIVCkRX2LuUbCZO2Qw3andsOg3QCvwG3I2h3S
 MhRtouubnkggiiaPPb3qZ+PrLMfieilunRYjtrMLW3NQFTqlHzHPZ6wK46/3h0NHhcDsEdrNMdA
 nMoOCvHwZFQwmPjNs2QVZqAlZ3f+JlmwDLaA1D4bLE5sBEwdD213wT4UbFU1NDE9pMecUXo0Mbg
 kDfk59kUMEpYq15NoBmRqEqZjBAaS2Ut6hNlH1O5UhJopHTtD+sXEvxjmhAc1sj8NFH3DkiXvMG
 DMTmcFVf
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c20457 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6H0WHjuAAAAA:8
 a=V4SrPvAJSiTePHaaKYkA:9 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

The Particle Tachyon is a single board computer with 5G connectivity
with AI accelerator, based on the Qualcomm QCM6490 platform.

Introduce the board, with support for UFS, USB, USB Type-C PD and
altmode (DisplayPort), GPU, charger/battery status, PCIe shield,
SD-card, and remoteprocs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../boot/dts/qcom/qcm6490-particle-tachyon.dts     | 877 +++++++++++++++++++++
 2 files changed, 878 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 5b52f9e4e5f31ac5a398d0762337a0a31af1f4dd..76d275991e83c013698dd98b467d42e74f2c21e6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -116,6 +116,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-particle-tachyon.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts b/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts
new file mode 100644
index 0000000000000000000000000000000000000000..893b998065557bc2dc63f9b1ba98a55cd0593795
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts
@@ -0,0 +1,877 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * Copyright (c) 2023, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sc7280.dtsi"
+#include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
+
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &rmtfs_mem;
+/delete-node/ &xbl_mem;
+/delete-node/ &adsp_mem;
+/delete-node/ &cdsp_mem;
+/delete-node/ &wpss_mem;
+
+/ {
+	model = "Particle Tachyon";
+	compatible = "particle,tachyon", "qcom,qcm6490";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart5;
+		serial1 = &uart12;
+		serial2 = &uart7;
+		serial3 = &uart8;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&activity_led_state>;
+
+		led-activity {
+			function = LED_FUNCTION_ACTIVITY;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&tlmm 14 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			panic-indicator;
+		};
+	};
+
+	pmic-glink {
+		compatible = "qcom,qcm6490-pmic-glink", "qcom,pmic-glink";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 140 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu_in: endpoint {
+						remote-endpoint = <&usbdp_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
+	vreg_power_5v: regulator-power-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "power_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&tlmm 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	reserved-memory {
+		xbl_mem: xbl@80700000 {
+			reg = <0x0 0x80700000 0x0 0x100000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat@c0000000 {
+			reg = <0x0 0xc0000000 0x0 0x100000>;
+			no-map;
+		};
+
+		tags_mem: tags@c0100000 {
+			reg = <0x0 0xc0100000 0x0 0x1200000>;
+			no-map;
+		};
+
+		qtee_mem: qtee@c1300000 {
+			reg = <0x0 0xc1300000 0x0 0x500000>;
+			no-map;
+		};
+
+		trusted_apps_mem: trusted-apps@c1800000 {
+			reg = <0x0 0xc1800000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		debug_vm_mem: debug-vm@d0600000 {
+			reg = <0x0 0xd0600000 0x0 0x100000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@86100000 {
+			reg = <0x0 0x86700000 0x0 0x2800000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp@88900000 {
+			reg = <0x0 0x88f00000 0x0 0x1e00000>;
+			no-map;
+		};
+
+		wpss_mem: wpss@9ae00000 {
+			reg = <0x0 0x9ae00000 0x0 0x1900000>;
+			no-map;
+		};
+
+		mpss_mem: mpss@8b800000 {
+			reg = <0x0 0x8b800000 0x0 0xf600000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw@8b300000 {
+			reg = <0x0 0x8b700000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: ipa-gsi@8b310000 {
+			reg = <0x0 0x8b710000 0x0 0xa000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@f8500000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf8500000 0x0 0x600000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>, <QCOM_SCM_VMID_NAV>;
+		};
+	};
+
+
+	usbdp-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 108 GPIO_ACTIVE_HIGH>;
+		select-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbdp_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			usbdp_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu_in>;
+			};
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm7325-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-l1-l4-l12-l15-supply = <&vreg_s7b_0p972>;
+		vdd-l2-l7-supply = <&vreg_bob_3p296>;
+		vdd-l6-l9-l10-supply = <&vreg_s8b_1p272>;
+		vdd-l8-supply = <&vreg_s7b_0p972>;
+		vdd-l11-l17-l18-l19-supply = <&vreg_s1b_1p872>;
+		vdd-l13-supply = <&vreg_s7b_0p972>;
+		vdd-l14-l16-supply = <&vreg_s8b_1p272>;
+
+		vreg_s1b_1p872: smps1 {
+			regulator-name = "vreg_s1b_1p872";
+			regulator-min-microvolt = <1840000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s7b_0p972: smps7 {
+			regulator-name = "vreg_s7b_0p972";
+			regulator-min-microvolt = <535000>;
+			regulator-max-microvolt = <1120000>;
+		};
+
+		vreg_s8b_1p272: smps8 {
+			regulator-name = "vreg_s8b_1p272";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
+		};
+
+		vreg_l1b_0p912: ldo1 {
+			regulator-name = "vreg_l1b_0p912";
+			regulator-min-microvolt = <825000>;
+			regulator-max-microvolt = <925000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p072: ldo2 {
+			regulator-name = "vreg_l2b_3p072";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3b_0p504: ldo3 {
+			regulator-name = "vreg_l3b_0p504";
+			regulator-min-microvolt = <312000>;
+			regulator-max-microvolt = <910000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b_1p2";
+			regulator-min-microvolt = <1140000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_2p952: ldo7 {
+			regulator-name = "vreg_l7b_2p952";
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b_0p904: ldo8 {
+			regulator-name = "vreg_l8b_0p904";
+			regulator-min-microvolt = <870000>;
+			regulator-max-microvolt = <970000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-name = "vreg_l9b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11b_1p504: ldo11 {
+			regulator-name = "vreg_l11b_1p504";
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b_0p751: ldo12 {
+			regulator-name = "vreg_l12b_0p751";
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13b_0p53: ldo13 {
+			regulator-name = "vreg_l13b_0p53";
+			regulator-min-microvolt = <530000>;
+			regulator-max-microvolt = <824000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b_1p08: ldo14 {
+			regulator-name = "vreg_l14b_1p08";
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b_0p765: ldo15 {
+			regulator-name = "vreg_l15b_0p765";
+			regulator-min-microvolt = <765000>;
+			regulator-max-microvolt = <1020000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16b_1p1: ldo16 {
+			regulator-name = "vreg_l16b_1p1";
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_1p7: ldo17 {
+			regulator-name = "vreg_l17b_1p7";
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b_1p8: ldo18 {
+			regulator-name = "vreg_l18b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l19b_1p8: ldo19 {
+			regulator-name = "vreg_l19b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-l1-l12-supply = <&vreg_s1b_1p872>;
+		vdd-l2-l8-supply = <&vreg_s1b_1p872>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob_3p296>;
+		vdd-l6-l9-l11-supply = <&vreg_bob_3p296>;
+		vdd-l10-supply = <&vreg_s7b_0p972>;
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_s1c_2p19: smps1 {
+			regulator-name = "vreg_s1c_2p19";
+			regulator-min-microvolt = <2190000>;
+			regulator-max-microvolt = <2210000>;
+		};
+
+		vreg_s9c_1p084: smps9 {
+			regulator-name = "vreg_s9c_1p084";
+			regulator-min-microvolt = <1084000>;
+			regulator-max-microvolt = <1170000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-name = "vreg_l1c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_1p62: ldo2 {
+			regulator-name = "vreg_l2c_1p62";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_2p8: ldo3 {
+			regulator-name = "vreg_l3c_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3540000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4c_1p62: ldo4 {
+			regulator-name = "vreg_l4c_1p62";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5c_1p62: ldo5 {
+			regulator-name = "vreg_l5c_1p62";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c_2p96: ldo6 {
+			regulator-name = "vreg_l6c_2p96";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-name = "vreg_l7c_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p62: ldo8 {
+			regulator-name = "vreg_l8c_1p62";
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p96: ldo9 {
+			regulator-name = "vreg_l9c_2p96";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_0p88: ldo10 {
+			regulator-name = "vreg_l10c_0p88";
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_2p8: ldo11 {
+			regulator-name = "vreg_l11c_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12c_1p65: ldo12 {
+			regulator-name = "vreg_l12c_1p65";
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13c_2p7: ldo13 {
+			regulator-name = "vreg_l13c_2p7";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob_3p296: bob {
+			regulator-name = "vreg_bob_3p296";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+		};
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&ipa {
+	firmware-name = "qcom/qcm6490/particle/tachyon/ipa_fws.mbn";
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+
+	status = "okay";
+};
+
+&gcc {
+	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
+			   <GCC_MSS_CFG_AHB_CLK>,
+			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
+			   <GCC_MSS_OFFLINE_AXI_CLK>,
+			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
+			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+			   <GCC_MSS_SNOC_AXI_CLK>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_SEC_CTRL_CLK_SRC>,
+			   <GCC_WPSS_AHB_BDG_MST_CLK>,
+			   <GCC_WPSS_AHB_CLK>,
+			   <GCC_WPSS_RSCP_CLK>;
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/qcom6490/particle/tachyon/a660_zap.mbn";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dp {
+	status = "okay";
+};
+
+&mdss_dp_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+};
+
+&pcie0 {
+	perst-gpios = <&tlmm 87 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 89 GPIO_ACTIVE_HIGH>;
+
+	pinctrl-0 = <&pcie0_reset_n>, <&pcie0_wake_n>, <&pcie0_clkreq_n>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>, <&pcie1_clkreq_n>;
+	pinctrl-names = "default";
+
+	vddpe-3v3-supply = <&vreg_power_5v>;
+
+	status = "okay";
+};
+
+&pcie1_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&pmk8350_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
+&pmk8350_rtc {
+	status = "okay";
+};
+
+&pmk8350_vadc {
+	status = "okay";
+
+	channel@44 {
+		reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+		qcom,pre-scaling = <1 1>;
+		label = "pmk8350_xo_therm";
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/qcom6490/particle/tachyon/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/qcom6490/particle/tachyon/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/qcom6490/particle/tachyon/modem.mbn";
+	status = "okay";
+};
+
+&sdc2_clk {
+	bias-disable;
+	drive-strength = <16>;
+};
+
+&sdc2_cmd {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdc2_data {
+	bias-pull-up;
+	drive-strength = <10>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&vreg_l9c_2p96>;
+	vqmmc-supply = <&vreg_l6c_2p96>;
+
+	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&tlmm {
+	activity_led_state: activity-led-state {
+		pins = "gpio14";
+		function = "gpio";
+		bias-disable;
+	};
+
+	bt_en_state: bt-default-state {
+		pins = "gpio84";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-up;
+	};
+
+	pcie0_reset_n: pcie0-reset-n-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-disable;
+	};
+
+	pcie0_wake_n: pcie0-wake-n-state {
+		pins = "gpio89";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	pcie1_reset_n: pcie1-reset-n-state {
+		pins = "gpio2";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-disable;
+	};
+
+	pcie1_wake_n: pcie1-wake-n-state {
+		pins = "gpio3";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
+		pins = "gpio28";
+		function = "gpio";
+		/*
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
+		 */
+		bias-bus-hold;
+	};
+
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
+		pins = "gpio29";
+		function = "gpio";
+		/*
+		 * Configure pull-down on RTS. As RTS is active low
+		 * signal, pull it low to indicate the BT SoC that it
+		 * can wakeup the system anytime from suspend state by
+		 * pulling RX low (by sending wakeup bytes).
+		 */
+		bias-pull-down;
+	};
+
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
+		pins = "gpio30";
+		function = "gpio";
+		/*
+		 * Configure pull-up on TX when it isn't actively driven
+		 * to prevent BT SoC from receiving garbage during sleep.
+		 */
+		bias-pull-up;
+	};
+
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
+		pins = "gpio31";
+		function = "gpio";
+		/*
+		 * Configure a pull-up on RX. This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module
+		 * is floating which may cause spurious wakeups.
+		 */
+		bias-pull-up;
+	};
+
+	usbdp_sbu_default: usbdp-sbu-state {
+		oe-n-pins {
+			pins = "gpio108";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio42";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+	};
+
+	wlan_en_state: wlan-default-state {
+		pins = "gpio85";
+		function = "gpio";
+		drive-strength = <16>;
+		output-low;
+		bias-pull-up;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart7 {
+	/delete-property/interrupts;
+	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-1 = <&qup_uart7_sleep_cts>,
+		    <&qup_uart7_sleep_rts>,
+		    <&qup_uart7_sleep_tx>,
+		    <&qup_uart7_sleep_rx>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&uart8 {
+	status = "okay";
+};
+
+&uart12 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l7b_2p952>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <900000>;
+	vccq2-supply = <&vreg_l9b_1p2>;
+	vccq2-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	dr_mode = "otg";
+	usb-role-switch;
+
+	status = "okay";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_dwc3_ss {
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p88>;
+	vdda33-supply = <&vreg_l2b_3p072>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p912>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_2 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_2_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p88>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	vdda33-supply = <&vreg_l2b_3p072>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp_out>;
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};

-- 
2.51.0


