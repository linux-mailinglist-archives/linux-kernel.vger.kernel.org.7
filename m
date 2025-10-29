Return-Path: <linux-kernel+bounces-877026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16022C1D01E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D23A4E135D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6DA359FA0;
	Wed, 29 Oct 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwZZ1vOq"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337A3590BE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766153; cv=none; b=uW7RHL2vmUiYHaQzHVzDOxoxj+E81Ohqh7qW37Tlg0wdfQF87YAFiDNvlS8GrzP3S5+XPmnDZEJcNLSpNk+L0q5gNtntahSJwqJqSrsWl14T0QgIMFHxNQb1mOIde+3hNsLB0toWoIkIk3PI0EY0oNEodudi73xHpFbGm8HBoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766153; c=relaxed/simple;
	bh=whFzpc1JabPaAo10HjUjIy4z4qlcYRtwGhxtqr+pOMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUv1dddvUQrmJoxbHkmsTTWRZhe2+fie2Kjr/ZTVkWhV0j64dk/VACeqggbnsbKuKSmiFUx0HkvCXDgMucxLHTynSW4gkFknOm5seVf7XNajMhXP76RJZy8Y1UXKFvRu69e9UJOL+/UwZJcSkpQ6WtyIznhH7IBdGl7uLcm6wfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwZZ1vOq; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso69814766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761766150; x=1762370950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAZL73WPFIHN2VTWaQ6XP1b9wcDV8dTDSuc2UCDs70I=;
        b=YwZZ1vOqApT6b8sfoLllElLcA1f7DEq02lmgevYe5HYXa54rzAkP9MsIuhR4CkuSEh
         QsPNy8gzGCkEhus7xyCCtoDyyFTq9/1blogbOCzOtzIbf1QR0GZ2/JYt2wPT+hYrwFg1
         Kf8qZekVjC12yKt9osbfoOzr627uf2gzWlf8709xU2Kwr7Uh3EgGjCKmpTzGIDM945a0
         mdhL8wT53h9WYq0urq1jhIROTKKY07bD7TCcRBZRe4xyx+csUMfqBR5N+RsB2MRFkQXY
         Ew4HpYvzuGW+OJUrEhMvuc5Dm2byWF/Ll5Pfti26eVh9R0gFqOUGBb+WRsQ5CO8BCDfe
         p38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766150; x=1762370950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAZL73WPFIHN2VTWaQ6XP1b9wcDV8dTDSuc2UCDs70I=;
        b=HrUX2tuF8gwYuuoWm6mZQz9R4FkBZT0+2HtC2f9tlosQ6bU+SJBiAYtQdo0w7Y1pHX
         k24b/kImzdFGw4113LdF0YQ2U/lvfjo4ywFlUIUqCqsMhv5Odp2v2qimmxl03NqiyK0Z
         3OaeyHgEvp9x3FLg0enUWmm0gD2VP++qkby14wuujzXEkU/CPM4iPX1E/epKoN5y8bVn
         iQED4IB6WJS9LUNYAY9eQdNL0PD4XXJVBN6u0hOVIAM50uqxkxKAhm4u6zUEwOB1wQXF
         Br5ZCy0D6CFQLjRhRQe1bjbs3zMIZF67MFJ8nFcB8hltDSys8yJIc/hquvDrtFK7Fh2N
         hG9w==
X-Forwarded-Encrypted: i=1; AJvYcCW+JzNJzL3Hecsm+inotecZT+kRw63xQMnIsZjaE1j0ycLeTLiMZTpA5EXAQosgU8Yg3twLADkpGoG4IQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1F0gP0jY3RmT1gmC1wbU27n7MJDASvQxyPByqAl/yEQeYZAr
	xaLWCT4CIN8WoamNwzGKbjxZJJckVQpsDaIEEQs4DcClUHocQiJoo1M2k2h7REzW
X-Gm-Gg: ASbGnctqrymrbniF9p9irE3mdnpo1W7ATh3QviSylRqMfiI1k952NjOGz/5yPsEzGhw
	ow0ZNNModBS2/4sY3ulSd19h8BQL6gj6g9cx133NRvPwqb77es1rrxZRboQG6Otnlot9yiaMkDF
	GiXnBi87S7QGqIS16YHVRqZ8yitZDC3cZwZtVQJx37uu6TOVpGeMRi/ByJuVO9u1MOXkR1XiEYe
	B+R4O/k6S0yBDsXE4G5eI1wMQlVuHaCtassZbWPNd4yfG64KEmGJ2d7yD25n1F8qNFweqPwEoXW
	CYXe76dNx/OhyUmLCAgPCNNvaT7WHTcDUWu9w85MGe/IfSjeSvFMPFQCdZiDRaBE8/+3Uob4RCi
	QmSn72zj6Kzl9jAEZynomfHeIqLxVhgJ87OdWLbNGP2gKB4J4YCRX1nnOXFd196WArskpdZuCOa
	FKoo8nhHFXaUrM+DS5AYKFVj4cyjiYvHgcmttMChTuz/XjSY8AqeGq1MVV4Yfcdg==
X-Google-Smtp-Source: AGHT+IFoA8vHjH7L7A7O5BYxTWm3kdq9AbZkEIotO1WtkkfV9Jwy/FnFo8J2wfIiFOBVGEd666tsSA==
X-Received: by 2002:a17:906:7947:b0:b6d:545e:44f6 with SMTP id a640c23a62f3a-b7051f630abmr98050966b.12.1761766149655;
        Wed, 29 Oct 2025 12:29:09 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm1496673266b.75.2025.10.29.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:29:09 -0700 (PDT)
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
Subject: [PATCH v1 1/4] arm64: dts: freescale: imx93-var-som: Add WiFi and Bluetooth support
Date: Wed, 29 Oct 2025 20:28:46 +0100
Message-ID: <20251029192852.656806-2-stefano.radaelli21@gmail.com>
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

Add device tree nodes for the WiFi and Bluetooth module mounted on the
VAR-SOM-MX93. The module can be based on either the NXP IW612 or IW611
chipset, depending on the configuration chosen by the customer.

Regardless of the chipset used, WiFi communicates over SDIO and Bluetooth
over UART.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 .../boot/dts/freescale/imx93-var-som.dtsi     | 94 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index a5f09487d803..97198007b545 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
@@ -12,7 +12,7 @@ /{
 	model = "Variscite VAR-SOM-MX93 module";
 	compatible = "variscite,var-som-mx93", "fsl,imx93";
 
-	mmc_pwrseq: mmc-pwrseq {
+	usdhc3_pwrseq: mmc-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		post-power-on-delay-ms = <100>;
 		power-off-delay-us = <10000>;
@@ -70,6 +70,18 @@ led@1 {
 	};
 };
 
+/* BT module */
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart5>, <&pinctrl_bluetooth>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+	};
+};
+
 /* eMMC */
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
@@ -81,7 +93,27 @@ &usdhc1 {
 	status = "okay";
 };
 
+/* WiFi */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>, <&pinctrl_usdhc3_wlan>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>, <&pinctrl_usdhc3_wlan>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>, <&pinctrl_usdhc3_wlan>;
+	pinctrl-3 = <&pinctrl_usdhc3_sleep>, <&pinctrl_usdhc3_wlan>;
+	bus-width = <4>;
+	mmc-pwrseq = <&usdhc3_pwrseq>;
+	non-removable;
+	wakeup-source;
+	status = "okay";
+};
+
 &iomuxc {
+	pinctrl_bluetooth: bluetoothgrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDIO__GPIO4_IO15                         0x51e
+		>;
+	};
+
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x57e
@@ -108,6 +140,15 @@ MX93_PAD_UART2_TXD__GPIO1_IO07			0x51e
 		>;
 	};
 
+	pinctrl_lpuart5: lpuart5grp {
+		fsl,pins = <
+			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
+			MX93_PAD_DAP_TDI__LPUART5_RX            0x31e
+			MX93_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B   0x31e
+			MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B  0x31e
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
@@ -123,4 +164,55 @@ MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
 			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
 		>;
 	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK                    0x1582 /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD                    0x40001382 /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0                0x40001382 /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1                0x40001382 /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2                0x40001382 /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3                0x40001382 /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK                    0x158e /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD                    0x4000138e /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0                0x4000138e /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1                0x4000138e /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2                0x4000138e /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3                0x4000138e /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK                    0x15fe /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD                    0x400013fe /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0                0x400013fe /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1                0x400013fe /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2                0x400013fe /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3                0x400013fe /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3-sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__GPIO3_IO20            0x400
+			MX93_PAD_SD3_CMD__GPIO3_IO21            0x400
+			MX93_PAD_SD3_DATA0__GPIO3_IO22          0x400
+			MX93_PAD_SD3_DATA1__GPIO3_IO23          0x400
+			MX93_PAD_SD3_DATA2__GPIO3_IO24          0x400
+			MX93_PAD_SD3_DATA3__GPIO3_IO25          0x400
+		>;
+	};
+
+	pinctrl_usdhc3_wlan: usdhc3-wlangrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__GPIO4_IO14                  0x51e /* WIFI_REG_ON     */
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07                0x51e /* WIFI_PWR_EN     */
+		>;
+	};
 };
-- 
2.43.0


