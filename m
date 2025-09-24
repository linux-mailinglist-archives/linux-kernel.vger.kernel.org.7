Return-Path: <linux-kernel+bounces-830321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A59B99658
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399EA1B24070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC02DE6FF;
	Wed, 24 Sep 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dc0aV8+c"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADE2DA749
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709011; cv=none; b=NKC3FQy7HUPBTtHbCvqM0xyamjXCmNKFBvZobijhjBtN1Y1UPlHLUA6fBjBNkD3clg66kJhRoKNrIsuSHud1HIPEEj5MyfyFdu1NLDtclUw0zgNB5b3fFLlWVuyKLPZ6jCriucZnmggSQo11ZW2x4IRFx1pv9o64s6dusk4CGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709011; c=relaxed/simple;
	bh=QdVtGcIHzrV0fUtoLR0+CcnCf0mmDqhn9O0HeNGf39c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqWye7zsqIII9fbC9uttJANHR6eyh0koOTgdS6O67v+UShWRuyf/QF+8kw9lRM4qKYdhFt/GQ/GGf0bNP1XPMSiHJo71MUBTEWTcZjpflNul2/6YVqFOlF6JzeIooBJy1WIEmm3QeXubjOgSICRNFPTA4CpY+EfWG5gjid+0nD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=dc0aV8+c; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2fcfef5600so292755866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758709004; x=1759313804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APo2jYD1PxrHJsECEd/93gcKH2/sr0pgqf5id/Ryl2g=;
        b=dc0aV8+cKmD89SlI7Sj9QMUhtPaXy4CpXfyDeZmpG7xRchxdUDetCw22V6qfZ0o+5a
         EqkeKFq3d3HTHbyITbhNNEZXm1AxUzzMl9Bn6BYRnC2xcfg0P0cZw0FJ52LKbY13vyQl
         u904yjmnZMSFLzGMwVwQMiQbAUp+bHuO3yMvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709004; x=1759313804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APo2jYD1PxrHJsECEd/93gcKH2/sr0pgqf5id/Ryl2g=;
        b=xSlNbQ7hMJTQn3cF2dVWBhu+4Cf+mGHed6orYBur5pPZWKZPiDamJPL4aHcIisGKpt
         LxNGEFVCiEqRC3RQh5ZsIiBW2THIr91l2EARBTFvSJiUZq/+fqC7gtipJrTIvkNKidBE
         +FudiUTZa5JWlCFH5MRAA4uhn2DaLHmoaPrVdpg/pA1gQ5AkvTptRbz2Krhm/aJekRRT
         8LCRHeV3dXFmdEu2X5FjqcttekkjC/FYOG6mr0kgFcUc01qJY+s/CG+O2vlCoNk9qwkD
         RKuQ+gvn+xRaUQxiHvsoV+TSyAEvuIZtQw6hWY1iPPyAjbRkzAfXE9q6tVBbSIJj7O9y
         f5rw==
X-Gm-Message-State: AOJu0YxwGVt36wgbO1XtKNLly6XfBUm0L3VlgCnx0XxiHDUBBKGPR2Rn
	nuoVPEiqosMlJii8oQyR+6BHmYuhwkE6CeonV0aRvrf/uRpkH7qDC7XMnbkIP4xmhDPhAKSg3qm
	lMZuN
X-Gm-Gg: ASbGncvxsCo7uBKBJhgz40aVDWNc4ErgwDiaMSLlhNyaTAT8//rNFjZtsHUSXJHbNNh
	hTleTk0P4B/YulyVrtOQkJW5INFFF85ueJfLXS875+mYI6pYjcKPItH6W/VD0sh6KPWuhlY97Tv
	ZONXsH96kaqhWCuj8nJY3D5GnOnYqrMFw9isGu38tOZ3KeXriPr6p8QwG0ynqNusCumkq2xFe7R
	vpo/1nBTBj4XzYjqz6u002Qk+xbkzSZ/mwk+0YanIxf73jECpM/q0esxbk2KDFgFQocr+cmD+Y0
	vq8P0TpJzgN7uQZa5Jn+R5vdP0GIS/HVSdCHs0B8Tkco7txlfffc8cEBzWrDQZkAZQTszOypLRK
	AG2JQQpyPmFQ1B51lpi237aiKquJ1nRgH3iCFTFYKhKl1hgTXZ3OBcPaDMIfx3LtqP2rUtn+p0+
	JnWxdHe8Fql8aKraVqvOU3iP0tMeP39MsTHksT+ykVE/q0JN5c9dxuZQZapLU=
X-Google-Smtp-Source: AGHT+IFpgDJanqCTLTKh+/RXRTMpj1SXZmnA3vhBPvdRPeNe6cdiq1+fp18qRHYn/FojREkTohVOcg==
X-Received: by 2002:a17:907:d8c:b0:b2f:faf6:dfc3 with SMTP id a640c23a62f3a-b30260c9c01mr624226666b.3.1758709004422;
        Wed, 24 Sep 2025 03:16:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b28d206bd13sm949712766b.31.2025.09.24.03.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:16:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ARM: dts: imx28-amarula-rmm: add I2S audio
Date: Wed, 24 Sep 2025 12:16:26 +0200
Message-ID: <20250924101640.2942635-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924101640.2942635-1-dario.binacchi@amarulasolutions.com>
References: <20250924101640.2942635-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for I2S audio on Amarula rmm board. Audio codec
TLV320AIC3X is connected as slave to SAIF0, which provides
bitclock, frame and MCLK.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../boot/dts/nxp/mxs/imx28-amarula-rmm.dts    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts b/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
index af59211842fb..0c5b52f67178 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
@@ -112,6 +112,29 @@ reg_usb1_vbus: regulator-usb1-vbus {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx28-mrmmi-tlv320aic3x-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&cpu_dai>;
+		simple-audio-card,frame-master = <&cpu_dai>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPROUT",
+			"Headphone Jack", "HPRCOM";
+		simple-audio-card,mclk-fs = <512>;
+
+		cpu_dai: simple-audio-card,cpu {
+			sound-dai = <&saif0>;
+			clocks = <&saif0>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3x>;
+		};
+	};
 };
 
 &auart0 {
@@ -154,6 +177,20 @@ &i2c0 {
 	pinctrl-0 = <&i2c0_pins_a>;
 	status = "okay";
 
+	tlv320aic3x: tlv320aic3x@18 {
+		compatible = "ti,tlv320aic3x";
+		pinctrl-names = "default";
+		pinctrl-0 = <&tlv320aic3x_pins>;
+		reg = <0x18>;
+		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+
+		DVDD-supply = <&reg_1v8>;
+		IOVDD-supply = <&reg_3v3>;
+		AVDD-supply = <&reg_3v3>;
+		DRVDD-supply = <&reg_3v3>;
+	};
+
 	touchscreen: touchscreen@38 {
 		compatible = "edt,edt-ft5306";
 		reg = <0x38>;
@@ -246,6 +283,14 @@ MX28_PAD_PWM1__GPIO_3_17
 		fsl,voltage = <MXS_VOLTAGE_HIGH>;
 	};
 
+	tlv320aic3x_pins: tlv320aic3x-pins@0 {
+		reg = <0>;
+		fsl,pinmux-ids = <MX28_PAD_SSP0_DATA4__GPIO_2_4>;
+		fsl,drive-strength = <MXS_DRIVE_4mA>;
+		fsl,pull-up = <MXS_PULL_ENABLE>;
+		fsl,voltage = <MXS_VOLTAGE_HIGH>;
+	};
+
 	usb0_vbus_enable_pin: usb0-vbus-enable@0 {
 		reg = <0>;
 		fsl,pinmux-ids = <MX28_PAD_SSP0_DATA5__GPIO_2_5>;
@@ -269,6 +314,12 @@ &pwm {
 	status = "okay";
 };
 
+&saif0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&saif0_pins_a>;
+	status = "okay";
+};
+
 /* microSD */
 &ssp0 {
 	compatible = "fsl,imx28-mmc";
-- 
2.43.0

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
branch: microgea-rmm-audio

