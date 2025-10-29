Return-Path: <linux-kernel+bounces-877027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD8C1D027
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAC014E1D98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4A35A128;
	Wed, 29 Oct 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYWalxJi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201B359708
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766155; cv=none; b=fwjejKek7kDt/sFUfNppvm8SWLIMDDRThRkUG8SxauXNzY0m/NUf1GNfUbqG9+Mka4jgDDVRXIAt+h5hRreUZqeD03oys/W9RZ9VVgYjjnkPZmQ6FqZvlqbpypxt/MYOu9qfQ5CsyggC5da2af0NeMK+9OPw0B3CsC77SUX/Qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766155; c=relaxed/simple;
	bh=E+yxGzCZFcyhRl056ULuyl5WPwp58wUUUI9XLCSFWXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNrWnQzR9SfvC8wXXYBVUQsPtU/3LYVAGa2F/EqKtAP0pqurArQe4IZkf0FYASrfdLagfja9DIgIbnBqt/2leVsLoiLl9vsoEXKQbOblOftQ/aXKJrYFxnRZ323BKYkMn+iZqrFvJ58Di2OEi8ROTyr9igA5jmWUvUNPM7Qxso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYWalxJi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so57254966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761766151; x=1762370951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pWDmbZrTdABcUlBNCeOKZzPd6c0px/j6MB6LEuyup4=;
        b=LYWalxJibNo9Wa03NbmeC0FC+cHs0RBRj/wXs6ueIS6ksddb1Al5fI5v0otUH3ZU9s
         t4y2YdezBIIt6kyQ3oA+cYHDOL9XigVxtorrgqm8E1dwgqRpFRyx7eui+8LEOGS2JyGK
         f6U8cHL/J2lHjLh02ET6x7Z3nqoLnydWBdZpYKqxBBkloDYqWEOpztWbmXNq43Zs6GP4
         OU3FYA8sNoS81SltNz+n9VsJp0bPVBECOaq//3/gZOoU/c7Wbc0VPLG0PQafNvw4i3Ck
         Ucpn6/gkL/inq1GwCKokzESo/uA5+jbnoZeWGiGO8eLGyJhLaj0Y87thTH5GItMP35yz
         YAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766151; x=1762370951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pWDmbZrTdABcUlBNCeOKZzPd6c0px/j6MB6LEuyup4=;
        b=cozvOx95LpHGKIBSrQuwedQ4pm4tFhwHA7/L1GQ59c/DRys8tfbWcKAsix+5E+mDS2
         17IexER0OHCENLqqKpnm0DchYPosrt878NkYbHcdh7AwQSB5W0e8SMilHLj7o/ASz50F
         dhdaYCybEB/PqKIfcbY4E0XhJdqQO9mRY5ELQL6TkPUpwrUw5C0bX/ZFGFzXAUdrA+Wo
         6svMU1yKr5qdcMNlK881c/FWhMQA4qYrgi1moR4xsuCEk3SHZ8L3C2gS9GDotZoKungs
         CgO0hOnxqCA+vnLwusaiinB8ZZV2v3wY1aleQ9cqDMSDxevhzWYUnpvv2uMSehfY3s1n
         Kgkw==
X-Forwarded-Encrypted: i=1; AJvYcCWxLwJHsFopb3Z6vunGr/qJYikG81v3RDJSi/LnHyjUmqxRRt7Rwvn1rXWdQtctrUWc9ZzoaJo50NjD914=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywch0rp+l4UvQYd/lFFGChUTS6hwcqs3JZgrgms/XJGn41K6kGl
	hYG+5qzqQteov/h6FqLZ7jcHtMpMSFvOZZQqprmBWlhal2necCAbEIuU
X-Gm-Gg: ASbGncsmS4BGc/FixKM36kwl/mbD0g+20y09XsBPMtXKzxYaduRkfjBCFmN0gF63a+x
	vIEooXdCIvDQndK8akuX4nbUmrlYNnalT8CeFrxOSvzlVLOxhkJOcdk7JSsPIM4FwMoGLDfkzU/
	Lf7/b4O/abumJuohNxn8Ysdj6ZhOBd7jyG0m3wW5CrcRyA/Xoowl4Xf2QEgX2WGCuiiVuOUPYTK
	KiNrXoSqp0SnYUvbHcgxCKEg888FKUTs9gb5X7Eko7gUrGRe+kzITPzZms999kkgXN24ZlW6zsB
	Q8sN0xsUnXTVZbgsJb1gQly/uhB/LY7g+03o2jPEK93pydlAersPvNQpaj5LcGXIhUJVXG2zev2
	3Qt+WEx+3alayVYhZxzbg/a2qJdkQXxQcPoqYCdlMlQYZJ6jDWiZv9+CfQpd22ax+KlNcee1Asq
	bdF6Eol2NXobVKSZxcSC62D11ijuxdzidjlTnDuUqA8GPrjNhBuGCXbp26z0Whkg==
X-Google-Smtp-Source: AGHT+IHwJhZkEKqRnVEte1O7I0899f550vGZfsEycCCZE4aJZvfMSJzZMXQacN9shYw9JF12C9LbCw==
X-Received: by 2002:a17:907:a03:b0:b04:626e:f43d with SMTP id a640c23a62f3a-b703d533318mr342078366b.47.1761766151112;
        Wed, 29 Oct 2025 12:29:11 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm1496673266b.75.2025.10.29.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:29:10 -0700 (PDT)
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
Subject: [PATCH v1 2/4] arm64: dts: freescale: imx93-var-som: Add PMIC support
Date: Wed, 29 Oct 2025 20:28:47 +0100
Message-ID: <20251029192852.656806-3-stefano.radaelli21@gmail.com>
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

The VAR-SOM-MX93 features Dual Freescale/NXP PCA9541 chip as a Power
Management Integrated circuit (PMIC).
The PMIC is programmable via the I2C interface and its associated
register map, and this patch adds its support.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 .../boot/dts/freescale/imx93-var-som.dtsi     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index 97198007b545..368530f5831f 100644
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
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA                  0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL                  0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3_gpio: lpi2c3-gpiogrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__GPIO2_IO28                  0x40000b9e
+			MX93_PAD_GPIO_IO29__GPIO2_IO29                  0x40000b9e
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
-- 
2.43.0


