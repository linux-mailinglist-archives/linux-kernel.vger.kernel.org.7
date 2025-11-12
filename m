Return-Path: <linux-kernel+bounces-897811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE93C53A68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E942348294
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F5345CDE;
	Wed, 12 Nov 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YLA/+EdJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BD345759
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967912; cv=none; b=dTP2OgFen5oJLBsGkI9HUNj7MD5w03tDsLjhEoukUS9YwqD/bgE3j9mQPrppGGlBEI6hPXVITBTQDfw0awfTZiQH3/StDBXZFEgMz+HOIydsHFTzo1PLivhVVszMo90U3LcrjFwc0iZHaQoVN8ad0CUROFIOYdQmMFxvxapYv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967912; c=relaxed/simple;
	bh=ks+sEAj6GQVaXnYu8XaFbXtzxs88Lg0JjUVI5fWnGOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRIjQG0mA49aAGdvaFc+2bjFIwRLd+aTyO8vCtruq/1N23yTYL43HFQCJK5c3QYzdeEadKIhm2GXDcBpRDlts8/sCaHwg2x0dZTyBPQeLfF+yatzDfrRH8spp7lGP6vuiB9nz1w9yYPZvvSSEqQdW5nhbCZmQPA9ydJ60KrzZKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=YLA/+EdJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b713c7096f9so134779266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1762967909; x=1763572709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BwUXFYlbD6N53XtEJgB9mVWjzWl6gDwebbOYaZsPHA=;
        b=YLA/+EdJVvYgrdtPoXSvu0FA7rDh57Q+Nsdr5LGJ0h16BfAivyzZQw2arCnsIEZ15d
         qeEcoG28Zvs69rsGA+yIpG4oP8pZ4Ds2mFW4aG8AZ2mgCYaiL1URDRi6N/RxNCXHfHAL
         o8wvp/MY7D/HfEHF3HKdlhUVT4Sy1hVpjjwEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762967909; x=1763572709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BwUXFYlbD6N53XtEJgB9mVWjzWl6gDwebbOYaZsPHA=;
        b=cgJUYKHAkAMAKX70ICPYEXGSyt6sYfBEG8BGdg7ZRQpIm3Z0KnudRQEAhfQi+B8zyd
         c04G5cF7ooFOdB+x2K+s+FWC6Jvs9Zzq6yPuxcj2Ky6H5DKX2inR12pg4toFXoIZ17V+
         EAPCWK/H+m2pWTGTytYrGslKKdlUQTW8K9D04VDs/opCICyPRqxJP5wNmuoVM68Say1+
         qCBaQhN4sI0TGa7XFj77Lqbr9mgGYmI0tiOYrmNARMMBEYB0wv1IKkMLQAhb52E/d81t
         tuhwJVYxoWcC+SD/TemjJdQJmxBjxV0EbDFH1frh9arOinCRZiNO//LzT52SsajhAGP/
         JSGw==
X-Gm-Message-State: AOJu0Yw7dW3vs9Sx6B/dP7twh90ONsYsWR/zlY6OcS49z0NlVOp3iqrF
	wWqfYrwucV8/HWi8vpMKaehzR35PBqrfVndAPWDPaV6cO8J7fp/resN2OuO+eOpx+QAX4SqKCCK
	5buMg
X-Gm-Gg: ASbGncuXCuAeo3XEQFwYJMzbQjgHDObgz46AR97zagW4XlD/IXoOCh1DZNCXR9aizkR
	G5KP2g3DQlrmy2LdWqpU8RNe5+uG9aiAgcxGcdHcThDVujKqreIhiT+KHjqViOOXaxPP7hk7ltK
	v9nnXgeC8PuI52NLgh/SuB4Fe9c4UW3q1bvWjeZouHPg9IqHy23nAsuVO5ks8tBaGx5HSA/kpeP
	ZITl9BoLjroe6qd8BT+4+aDRDz3qS1c4jhyl6Z4Fi5NQAOFoWPOQdjPbyXjwCJ47jRwAaNOHJ+i
	3gpQ8HFPmk+/9sK9xkBdRf+7nhsUc4QJ+DpbuErIzcwVyAO0FUmii3GTXV6BEzSEYBY2aClSTBp
	bz59l0shBAq/Zm31DxjsOriS3zKPveoDOC64O6pC9/K7GniL1AJ8+A1dSN46BvRnPRwbSrMQ4yC
	Nd9EnDsSOkIWSHPdhcMNAfTxJ5SZ+TRlOonED/Za63pNikM77QpC6fE8uKOIZoNhADJK6WKJZVQ
	/CCZMEws2Eoww7Xr8q/xXB8ANI+0aStdhLM/5f1kmBq
X-Google-Smtp-Source: AGHT+IGY2/902SKJFzIS3Gu24NoIxJSLCSqdXyB/GpWGp3CPdaOhQYc9wwsjQIgb8wLhfnUpqSpx5w==
X-Received: by 2002:a17:907:6d0d:b0:b70:b5b9:1f82 with SMTP id a640c23a62f3a-b7331a6ef31mr445484266b.31.1762967909196;
        Wed, 12 Nov 2025 09:18:29 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-54-71-163.retail.telecomitalia.it. [79.54.71.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73381dd3besm180731866b.43.2025.11.12.09.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:18:28 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 1/2] ARM: dts: imx28-amarula-rmm: add I2S audio
Date: Wed, 12 Nov 2025 18:17:12 +0100
Message-ID: <20251112171820.4046537-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

Changes in v2:
- Rename the codec node to audio-codec@18
- Drop an unnecessary newline

 .../boot/dts/nxp/mxs/imx28-amarula-rmm.dts    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts b/arch/arm/boot/dts/nxp/mxs/imx28-amarula-rmm.dts
index af59211842fb..ddb64f3d0471 100644
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
@@ -154,6 +177,19 @@ &i2c0 {
 	pinctrl-0 = <&i2c0_pins_a>;
 	status = "okay";
 
+	tlv320aic3x: audio-codec@18 {
+		compatible = "ti,tlv320aic3x";
+		pinctrl-names = "default";
+		pinctrl-0 = <&tlv320aic3x_pins>;
+		reg = <0x18>;
+		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		DVDD-supply = <&reg_1v8>;
+		IOVDD-supply = <&reg_3v3>;
+		AVDD-supply = <&reg_3v3>;
+		DRVDD-supply = <&reg_3v3>;
+	};
+
 	touchscreen: touchscreen@38 {
 		compatible = "edt,edt-ft5306";
 		reg = <0x38>;
@@ -246,6 +282,14 @@ MX28_PAD_PWM1__GPIO_3_17
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
@@ -269,6 +313,12 @@ &pwm {
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

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
branch: imx28-amarula-rmm-audio

