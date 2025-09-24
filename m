Return-Path: <linux-kernel+bounces-830559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706EB99FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881863BB9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888A303CB0;
	Wed, 24 Sep 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="k4jBBEwP"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C7302156
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719277; cv=none; b=Z/cSPAwNfDsBVZiicgQTAv5kmsdwgdJ5K31/8gzGrZLLVkR2KGmJRhr1bawrvNYvQ7C4FoeGzsdDTqJE4LCQFsS9KNDUx9xOv+fYXOZTDqj3oeITvkByvsoKJpszi9ig3kwGipP9lrDd6oumgvtOba7hpNgHMOW1jWYH17YayJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719277; c=relaxed/simple;
	bh=QdVtGcIHzrV0fUtoLR0+CcnCf0mmDqhn9O0HeNGf39c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6KuV2qOCiDbs+/HbrQKM80wBZaYItEoJC0idg+M+SdWd9cxCpv27E8CePjFk++VMVXyoltXkySnPv1Dx2VRxk9nhaQbbjDfl7lWUSQALSQQpLnuVHwqG9HLyJ4dU0VPbCyh9ynOMYeI6ECMzC1qVOwtJpuu6oCPG0qdIfc7UHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=k4jBBEwP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07883a5feeso1326406066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758719274; x=1759324074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APo2jYD1PxrHJsECEd/93gcKH2/sr0pgqf5id/Ryl2g=;
        b=k4jBBEwPKBAGNkEj/4toGW5EWNlhweFXitN/V5E/hBZqPJ8JAACcom1AzUm9oBL57y
         eNa1xy/5JpK2ZuQqyxO/LNE9AoA91yKzBuFeRkDoAuraA6ikXppClZC0tsHzCqesQF5s
         ur1gEM7DzyjRXNVbuu46Wn3YG5zymnkiprx0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719274; x=1759324074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APo2jYD1PxrHJsECEd/93gcKH2/sr0pgqf5id/Ryl2g=;
        b=Cpw1OQAPThIyqKyc0qt4QdP0DTayp4+EZ2er+1hZccDZIRUtNbQnxGeIBDIeaWk8AD
         wtRiV248EfsXemn96clOrXavk9j9qX+3irARpxmalSjELSqQ/tQrp7EuEHTmA5BQGryT
         lz/5mg3n1sGqENe+E6GKLKI9L01rHg2qQbAUPXV9pJbUUPrBIg3KDSEMsJCG6PXtkbc0
         u9FqCd+eKXPJ8eJ+kR2R9aVcFx3OdOEUYgTe3UPV7ACnHDEC09GLmN1h7RxtXvc25TLO
         /s10nBh/M9rWtZlFtl5mrPdsMORLabRY9lSCYO+4xD9FwBq15DKh/NCGkEKjFqWxkO2/
         S19g==
X-Gm-Message-State: AOJu0YxshWxNtXFAhfxSOASpWC+o5LEdJYM16PRAprj0FFEkfTXDN7vT
	xNVpJisFUGkH87fAyJQGKyD0eQxh0aHmgxAR0J8CeRPA+x3/9iF1XlUNE4LvIOiG7fLcK+JGvqY
	5RHjB200=
X-Gm-Gg: ASbGncvlbeLBVKBmH/56FjX3rkag2tEkT+X5UQOPJ0pERPMgQAYWRobZXsl8fyOHfuE
	HSdhZy6K7aHTPelI4pCpcXQzuXDk23TmDvQ2UuIQ8b/5szaFJqaX26CaYQ6NPCTawpHbH3hok48
	xFOlWuFSU6gpt/x4Y0Z8LtMkoBM251Ib/es//WB0/uqM6i3Sk3kgNO6UPd05qXieqorRw/9vsoT
	CQvge5UkFUkvztwGung6BMV0QjZJNUCrIh3WeLhHYhWgkFk84ucFZCYu0nKS609emnNhl1dYYVJ
	Efp58elBCNdswxUNlxABvbZ5WXLIx+4PzNLGRBK3vMpJu/nK7mB9EKQt1YOdhkx08/2G5IAoTHx
	Bbt8xbqnziNHJgWjdvwdr6pYPzchNGRU255CbVTXHptUITgNtUc4gdIPqrzMlC76OjU9rS4Kp7A
	tZcjzjy0G+FgNvOVWC2ci6bV7foxofO2HvbvZA7xXvZPplO184G8D/AMSIHXY=
X-Google-Smtp-Source: AGHT+IF67mD/mI0gnp/TuaWCgcn+3WEoNIAZH9oCfonzva0RaGE9yWAfNCRhfJo9YzLJalRUTsq/KQ==
X-Received: by 2002:a17:907:6e90:b0:b04:25e6:2dbe with SMTP id a640c23a62f3a-b302c1fff60mr622859266b.63.1758719273947;
        Wed, 24 Sep 2025 06:07:53 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f382b0sm1574379866b.2.2025.09.24.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:07:53 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
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
Subject: [RESEND PATCH 2/3] ARM: dts: imx28-amarula-rmm: add I2S audio
Date: Wed, 24 Sep 2025 15:07:45 +0200
Message-ID: <20250924130749.3012071-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
References: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
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

