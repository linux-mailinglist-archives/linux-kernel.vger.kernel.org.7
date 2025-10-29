Return-Path: <linux-kernel+bounces-877028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF59C1D02D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58D184E282B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9C35A147;
	Wed, 29 Oct 2025 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB3cQBUY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4372359FAA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766156; cv=none; b=NNBnc5InZQB8FFI1wvYxPgfKUkD0DA8tTr2ET4hGA9FWHy/KJyWQkqlZmyQ7Gt+L8dKPjRR1SuZpQWNFJ3ifEIDoSwnO0pYy5G1YgsJIPIoAEPtCozATSAK+QzAaS/3uy9z5gVsiDNd7JUjIMfTDmUrnCGSBICH7lkMPSu0sv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766156; c=relaxed/simple;
	bh=L4cc62I8VBtR9WYn3KE48vIMlnYDeTk5okhOWpkUMz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPlp+cBrfi/RDPT5uU6No2qeQewhgSLZ9LT52Pqyzsnzuw/d1DOAzyNqNekCgHIR0pHOaC47kuQJOTwqBpdTaFrcvfllYtt+wwVDNAzOIU9VYm0O4np876Gr+Zw0vSy6PXCQhEyX+C5RF7inr3vD7PhR3CMYJsY5My20g7UC5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB3cQBUY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so57281166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761766153; x=1762370953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QiFp/LdLdfHAJfOJPJO9VTxDlMuNiD8Zbuk8ezHLYs=;
        b=bB3cQBUY2Sk+BlS028oWK0FNDLPcooOY0/tR3murTWV+dYNrJ0sCAXxVwfPk+mArJD
         oVX4HFde/NBVr4e9Lhs6Am5aettcsVLSJ5Bl5J6jAfe2wQ/Dq0e6uM6wydU8cnUQii8c
         Y9is9pdnDXhBh5LOnTCgbti4SB4z4A1SuRICYtpaMGrTeKJaAZC83aZgHCpOX6Ar+OVt
         5OcVxDeXvPgTM/TSVo22ZxxyQUMRt+cj5YF8Hl7jBjOrqahOWOvtzgpOoQK2YXx0xgSR
         9SKlSd8+VSYnATkf8cbJG2qyv//9Ph3eKgAA+udRGEnpkXu+0h0sbEhnH7ucYkwJDb17
         MxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766153; x=1762370953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QiFp/LdLdfHAJfOJPJO9VTxDlMuNiD8Zbuk8ezHLYs=;
        b=esDnr7zpiWBh7bYJziDAEbj4hQivAy/Y24W3+cbVi9YFHeiTW34oHCISIFQLNITy//
         E98TEDa+ROlUpwuG09qxgkACHx0WaCxoREcW9nOpnqRm5KFVLY9f5FL2mC1ixg9HkaI5
         XQcx/DI2H0fUTdjb78Bv2EUz5T5Al0z+7MGgZHXZcxoBArp8u50zNLsmgcWXCL4fAY9B
         EtW8qFNIagszMwh2IlQ6MbWeG1A24eFoxXogsELHPI1/+i/jE14/TReTAe0RBUdgQw8p
         gWQxy+orK49ayDmVCRNTgTcfQ0ZiI3pm5T4nBlP4Bwpwyu7DurG+N7zZ9f67WDQbIhgT
         9EDA==
X-Forwarded-Encrypted: i=1; AJvYcCUUCZlVI5ug3fLUtQfjpU1S7fU28Twi0xgGhgDylI3U8Ui4rfOJnS/7RykR88rqfw2de2Txg2ptZ6A1qWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHPK+PlJ5jUneN/lSToLbAWHn93CwAKFoaZ/EYlnQuQ0Lql6Ze
	M6SA2+hBtkvWgeFag1GTlYNyKvTiJx8tS5xBkJAngYbGvVzLw8CLUVxJ
X-Gm-Gg: ASbGncssJY881z3k58qCpASY6Mf8EGcK7FiubxFqz8gYwTlcQ1H5PXSDIHGWR5/LScs
	dNXeNSGD36JqEPgswN0QIplO8ytEpbwK3TipZIoWbqFvW7RgwYf8xzrVhuiAgewQO4lCY2KdiN3
	ubL7xTfwewG53R0u6irapVbR+eTOmqpCjNmvDDSJOXjeue4IFvnlEF+hPWFWZeAJXd5546c2xB2
	egLhAAfozcx+BYo05DcFKR9uuXg7mmW054VBuB1Vty/LSHTilgYgbL7NZcGwrrhLr+XZBUpKudo
	XzFm53113HHfHX3V50K2j13tLBCIMAn8rSIxxQZZGAR9G94sI4giU84IxdbGw8rZoS/0KA/kcxy
	fhpWYRuLjv7tUGHnS7ZyDZuL6cnHaH7JNTAHtLySo7Ai08UIXgOUiePkvCBdyP7hAEGRCDxIyL9
	UeK1+Kf5pBMDtRjYnZYKQpAG7u1wi9WiHkMW9QlFoBPtcmSSJbUFCHdNq+uAEwtQ==
X-Google-Smtp-Source: AGHT+IFMO9AToKhALDtmsrq81s5iqoQxzOiv7HbkBgHJatpEZpryGrj89HkqN9nJYwlK5nQZ6d5XOA==
X-Received: by 2002:a17:907:c0f:b0:b6f:9da9:4b46 with SMTP id a640c23a62f3a-b703d5333b1mr421529766b.43.1761766152587;
        Wed, 29 Oct 2025 12:29:12 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm1496673266b.75.2025.10.29.12.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:29:12 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 3/4] arm64: dts: freescale: imx93-var-som: Add support for WM8904 audio codec
Date: Wed, 29 Oct 2025 20:28:48 +0100
Message-ID: <20251029192852.656806-4-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029192852.656806-1-stefano.radaelli21@gmail.com>
References: <20251029192852.656806-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VAR-SOM-MX93 can integrate the WM8904, a high-performance
ultra-low-power stereo codec optimized for portable audio applications.

This patch adds the WM8904 device to the appropriate I2C bus, enables
the SAI peripheral, and introduces the sound node to expose the
sound card to the system.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 .../boot/dts/freescale/imx93-var-som.dtsi     | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index 368530f5831f..d94b40d1d804 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
@@ -12,6 +12,34 @@ /{
 	model = "Variscite VAR-SOM-MX93 module";
 	compatible = "variscite,var-som-mx93", "fsl,imx93";
 
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,name = "wm8904-audio";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"IN1L", "Microphone Jack",
+			"IN1R", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+		simple-audio-card,mclk-fs = <256>;
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&wm8904>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+	};
+
 	usdhc3_pwrseq: mmc-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		post-power-on-delay-ms = <100>;
@@ -152,6 +180,36 @@ ldo5: LDO5 {
 			};
 		};
 	};
+
+	wm8904: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&clk IMX93_CLK_SAI1_GATE>;
+		clock-names = "mclk";
+		AVDD-supply = <&buck5>;
+		CPVDD-supply = <&buck5>;
+		DBVDD-supply = <&buck4>;
+		DCVDD-supply = <&buck5>;
+		MICVDD-supply = <&buck5>;
+		wlf,drc-cfg-names = "default", "peaklimiter", "tradition",
+				    "soft", "music";
+		/*
+		 * Config registers per name, respectively:
+		 * KNEE_IP = 0,   KNEE_OP = 0,     HI_COMP = 1,   LO_COMP = 1
+		 * KNEE_IP = -24, KNEE_OP = -6,    HI_COMP = 1/4, LO_COMP = 1
+		 * KNEE_IP = -42, KNEE_OP = -3,    HI_COMP = 0,   LO_COMP = 1
+		 * KNEE_IP = -45, KNEE_OP = -9,    HI_COMP = 1/8, LO_COMP = 1
+		 * KNEE_IP = -30, KNEE_OP = -10.5, HI_COMP = 1/4, LO_COMP = 1
+		 */
+		wlf,drc-cfg-regs = /bits/ 16 <0x01af 0x3248 0x0000 0x0000>,
+				   /bits/ 16 <0x04af 0x324b 0x0010 0x0408>,
+				   /bits/ 16 <0x04af 0x324b 0x0028 0x0704>,
+				   /bits/ 16 <0x04af 0x324b 0x0018 0x078c>,
+				   /bits/ 16 <0x04af 0x324b 0x0010 0x050e>;
+		/* GPIO1 = DMIC_CLK, don't touch others */
+		wlf,gpio-cfg = <0x0018>, <0xffff>, <0xffff>, <0xffff>;
+	};
 };
 
 /* BT module */
@@ -166,6 +224,17 @@ bluetooth {
 	};
 };
 
+&sai1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai1>;
+	pinctrl-1 = <&pinctrl_sai1_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_SAI1>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 /* eMMC */
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
@@ -247,6 +316,30 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B  0x31e
 		>;
 	};
 
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK                 0x31e
+			MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC                0x31e
+			MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00              0x31e
+			MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00              0x31e
+			MX93_PAD_I2C2_SDA__SAI1_RX_BCLK                 0x31e
+			MX93_PAD_I2C2_SCL__SAI1_RX_SYNC                 0x31e
+			MX93_PAD_UART2_RXD__SAI1_MCLK                   0x31e
+		>;
+	};
+
+	pinctrl_sai1_sleep: sai1-sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SAI1_TXC__GPIO1_IO12           0x31e
+			MX93_PAD_SAI1_TXFS__GPIO1_IO11          0x31e
+			MX93_PAD_SAI1_TXD0__GPIO1_IO13          0x31e
+			MX93_PAD_SAI1_RXD0__GPIO1_IO14          0x31e
+			MX93_PAD_UART2_RXD__GPIO1_IO06          0x31e
+			MX93_PAD_I2C2_SDA__GPIO1_IO03           0x31e
+			MX93_PAD_I2C2_SCL__GPIO1_IO02           0x31e
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-- 
2.43.0


