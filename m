Return-Path: <linux-kernel+bounces-878163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224FC1FED8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5481892E18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D70351FA7;
	Thu, 30 Oct 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISl4J1m6"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD331D375
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825771; cv=none; b=S6Aon8GZaoa36xH0WRcDYtwtww+e4PLZHT2H4PAV85WKJKJCmyMlabMbREgfZ5ih4FsgX8dU1MFs8ga0kY3ytO/wOq/6L2HS6wocJhyx8ivK7g7GQDCfFNWV9As/SyExIbw34YUoTnoRBLJxMPY4eGnK8yxizfaDOfImACY5k1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825771; c=relaxed/simple;
	bh=YANsc/aUJY7yFzRK813J7R8e4uexbNeXv+bcwl/+HbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCn7vRW9LjSxZF4ktnEXO3pyyKO8M8nNfMt1wkdAw7tTebYKF2EaIbi+0erP29e8Tog/UzWjEah8DU05V84hxMhNSP7F3r3MKSO9JqZrhKGfEaAei4+BZe+6Ug5CytPOWdzIzDRjY9GSWyQa6RH2HRZXDCA9jUPAp2Ulk8vRtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISl4J1m6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-427091cd4fdso561857f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825767; x=1762430567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0mFQTcGqmSkiKPfup/qBvNwcKsotJhGPnyj9Bdv5bM=;
        b=ISl4J1m6eX0iSLV4Bbf/3E1OliJMcW20C4vu6elxZSs0yEFzyQbAmFOr4SOJ5rVvFK
         14ZV9PQH/tMRaqaWh45PgO6dirX8SHFbOlootrNW2TicFuPpHZLBk2HJkJ0R5MJQCzNV
         aTESfIRQXkMeVLS1ywMZqsLIPR4mmUUafNbAFAwmL0i2OR/ZPbxz2CuabZMYff6xxDHJ
         7wG2kgTQLdUiuaUhAzWP0QdaaX/17+xZZ9deMmvln7bcabpHol43C+PxIo/7zlkowvtP
         Xfu7g5OPlIditcCXQh7hzymDhGiUFClJeMdXzo36lL6UEO8QZSW6EPnKyZaXcmEwXGqx
         v1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825767; x=1762430567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0mFQTcGqmSkiKPfup/qBvNwcKsotJhGPnyj9Bdv5bM=;
        b=IoLU5vWVcorw/1deHE3kxdB7y99XXGHV6AfCFV+iGFQZZ3Ty2Mp/DG+MIc+Me8COkw
         0o7KOArei8O8iqJQtcTWvaZVrv9N4/GP/V+SRIHF4mowKcxLvhh2acIqOzWZfgMxTukx
         EViK1FKxQQTHbvzG5A0gfAqEucn6IRCUvtgiHgzEXRK7tOnVSdBs05iUbRjTQcb0nlEw
         SUqnTXrJwWQCTK4MK36IzzDwlxF15g7q1FkvKHhTjhTog+ijoxuPkxT+0i1HTSPjupTG
         htqV9W1Buuyn/uJMfIlLcM3EBnWcmcDv/PIaHdXk7dZHaYSkFuM8vt/yX0SNNRaO3XVr
         NgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvEl8pxQvTaPV1JHKsohhtREALWUFcKdr0pKMXTclPS86XidSMY/Bv5+rTgMpzuf0SmaoLIg9q/tViRcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHsBGU2PR5uci4BkMdGQE3zY3DtpUOVpeLFlkWKt79sQVIRPi3
	yr+Hc+BW4Z4tYcxmnHyn3JkuPpuoAuKF2Y31VMvmhp4CfhDvAYto2M4l
X-Gm-Gg: ASbGnctky124ykWylNNDhXZytIQi2596LEuZOu+TwkqKvdsP7hjsN4v9kkc3woqqQ9y
	TDcmebA6hn3E9cTyHkoPtqMYsh6cNxMVXeCRS92mu+lwU/Pz/mA2+jIg6WFCN2szlIZuBmWPuTE
	t0SR9OdU2n9CUYRd+oX9rOP6/YnzAR8fHqnTCEw0okSYqKfLV8zbdtvT92ThEom1mCFwr8debIY
	vHJnyT240fL9lmIdCumcm28nn1TQIYHExXZBDMZ9l1/iIGrh1NL7tPFMVO+iz6rKwK7AUn0KMii
	4bbwp7w83RuyYTnFQ8+hAnlriwrmmwJCnWVek3v1j2d5cU6rMeEZJ9y7o1vGUJwy1KONxhaCg08
	WDiujN61Vyb/Oo0iq28jbGffoack+xDvXtO8fpQvPJP1E7b4NriwhSNz6wCs2WI/pUtNiDIzuBo
	naz+FYI+O7Up4XpD5Py78LY7APf2OEG8AsLZhQbHXbWA9DTft3OAsPdGBq5sKMN/VVlJXLXKc2
X-Google-Smtp-Source: AGHT+IE+1Y1iMggZfF62Rfc9eTffUBllTx25tgqnlq9EBnWiqaF5y6rvo9W+qkPwMxETU1MJsDHwbw==
X-Received: by 2002:a05:6000:240f:b0:3ec:db87:e8fa with SMTP id ffacd0b85a97d-429aef830bbmr5741010f8f.26.1761825766901;
        Thu, 30 Oct 2025 05:02:46 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429b9b436efsm2399848f8f.23.2025.10.30.05.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:02:46 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: dts: freescale: imx93-var-som: Add PMIC support
Date: Thu, 30 Oct 2025 13:01:22 +0100
Message-ID: <20251030120127.509933-3-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030120127.509933-1-stefano.radaelli21@gmail.com>
References: <20251030120127.509933-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VAR-SOM-MX93 features Dual Freescale/NXP PCA9541 chip as a Power
Management Integrated circuit (PMIC).
The PMIC is programmable via the I2C interface and its associated
register map, and this patch adds its support.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
v2:
 - Fix pinctrl alignment

 .../boot/dts/freescale/imx93-var-som.dtsi     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index 37f7837fb5ac..85fd9c9c9372 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
@@ -70,6 +70,90 @@ led@1 {
 	};
 };
 
+&lpi2c3 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	pinctrl-2 = <&pinctrl_lpi2c3_gpio>;
+	scl-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
 /* BT module */
 &lpuart5 {
 	pinctrl-names = "default";
@@ -140,6 +224,20 @@ MX93_PAD_UART2_TXD__GPIO1_IO07			0x51e
 		>;
 	};
 
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA		0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3_gpio: lpi2c3-gpiogrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__GPIO2_IO28		0x40000b9e
+			MX93_PAD_GPIO_IO29__GPIO2_IO29		0x40000b9e
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
-- 
2.43.0


