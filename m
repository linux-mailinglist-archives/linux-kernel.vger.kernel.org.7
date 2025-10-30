Return-Path: <linux-kernel+bounces-878162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF9BC1FECF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE2188F77B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1F833F37F;
	Thu, 30 Oct 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYRVBpuh"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1131985C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825769; cv=none; b=RAtByj9Uj8rtAtUzr360jyYY9LQ80tcz+oSNY/G/LiYt38sP6Zujli+7lJ/hDrCR3y8DQJICd4vlUs8VUfxOqrTWgr4K2Tlwi51CyzYvdaziPWjyGpWDoHZyTyHZky6bdknrzh3WzOBuhfuYAdAtuRhGQA3uO207l5buBR6UFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825769; c=relaxed/simple;
	bh=QNI/ZfaPTG0phRPkECwpB5V6JS0vmdEEhkfXIQ5bFTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWHALcFgEFAciwIZ9cRbISpciRP2SZ+4c5VBuZoSQsNn00SalXXpIOQVi01lFFVmqOk8ZSTm7ShbanMV+TK7eMyhk9bh8BUWnge6ra/y29R4oYMZWRvG1/XA6Zi5QuWFFU5IOYjxGnK7v6mCugOVZXSthfB/cWXkNs0NPrYOYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYRVBpuh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710683a644so9918055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825766; x=1762430566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU/IFjxmC5UzobtaqwaIgLh+ViOP+BMDNSNp906n97k=;
        b=JYRVBpuhwCTG3MKDsuXU4oIukE9ZjNzr1/HsXdcorHtZlzGsmezEBSrJeMQWqTcUd6
         gSIrsYBsskYc6aNoTMOMoORoQVLlBA6uSEXtpfa1/S/woLVYNR1XYdHI0zIa0jhDdSPo
         4SDEYvz3xlxl6gZuZtxZgSGgyLQ6EexCx0XCVTsHDrot4XwZuI3RKw5oeuBTHra1vcUk
         zFYokU3ho7lm5vv2DHkui1sVNWF4M48qX/61DjYarwb9ytOZLC+n5UuR9sI1ZGwSFxgG
         ue6syb5Ke5F2d5CvWllwJr5Slw42HVIqKCheT37ppts7IPqrJFR2tLSszfiGxDpXQj+n
         OPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825766; x=1762430566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RU/IFjxmC5UzobtaqwaIgLh+ViOP+BMDNSNp906n97k=;
        b=olbSDp9GzG/tLOHwBPfZyUuM60yw6NCoOs36Tuq3mLaqW7iFHNLWwuijdTojCDel/z
         6UsCWVETu0eNdlX4VkbZLeeAk4XGMnBUnk4meO5ZW/5Q5MkHtu7PjwY3hn875MRF99GJ
         2PSU+2bryDEOToee3IXwkxLXiBtqnUpyOVNgia4AalmGvMjFwV7aOysrQEbiOObLbEd0
         ZW6rV809QnZYHnYpVyn6JJqW6q0DndNSvVYMvwvwgrEhuV9jg57KYT2nIbZk6kBLDSzo
         HGz3jxfuHBkioMvxsRAgxrUV4EMTMbX9FrpVSwI0KbsSBKrU7DrQD5J5CLPfXT3k2xzg
         +KDg==
X-Forwarded-Encrypted: i=1; AJvYcCU56XegjP/1xoM+b2IUA/RaLoxse9HI96kNLCu03YbtEZ0cPGZGBagcRzaZeh8E2VxgU+SYLcldPx9gN78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGeaqYwMdYv1e6OF+Mo5OcYTpayuf4QiaZrLIS8a0B7PniaJO
	oNfj/MVjEi4P2MkdwXHS6n1jBcL1onPUi/L+ZgGk42NYFBiLfoKrz6Xc
X-Gm-Gg: ASbGncvn4LXjntPhFd6JIr79tIt19QkNoc4ASSBVXe4o7GFlu7LcMVhtlAmNEYCGOAX
	XgPagkpGDaGAjG6XJjplNv/KZRqwijPkaD3Kms77OnUuI1pGPeiwH7m1BS80J+t7A9ZYi8IxFaZ
	Fwcivplo6MPB7+v4KY856JmwxgqRbU0QuYwECPCKSMBprY2IOa13WDIL5hbWUs0Ufy0IM7TlYOg
	+SRt6WndDoF6VlqT2yx6BOFL6VqNR0JskY/yyXWyj8wfUF4Gg5/EVGpAV7ZRQKzGXnhgoABFnje
	5rR33zfWhu20aCKLuqv6vin3c47658vivx4ljuvbCgrkwYldNREiO8aphdDcqjJcrBrwVy5lKUb
	4TdVQlxIhlEQ4j2VgeYg29eA1Au/6nTdxi3MQ3iZjsuY2p0q91u5Yn3HgvMmmZjMtrkRSPsckvu
	v8wd8Q8ONCwfH8NjrLWsejkTWIAiGlNiKPrfieJOgj2KdPyw5ZniFcUnpHrp0YEzkpx+5Axqdt
X-Google-Smtp-Source: AGHT+IGF+6bOCrVb3+3E532mSpXBs3rQ5f3sWNWs1oBDAb7QHFohBiPTXpW2jdZsUENdcJwLMcPkBw==
X-Received: by 2002:a05:600d:830f:b0:477:ede:d2b4 with SMTP id 5b1f17b1804b1-47726263362mr19710395e9.9.1761825765597;
        Thu, 30 Oct 2025 05:02:45 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429b9b436efsm2399848f8f.23.2025.10.30.05.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:02:45 -0700 (PDT)
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
Subject: [PATCH v2 1/4] arm64: dts: freescale: imx93-var-som: Add WiFi and Bluetooth support
Date: Thu, 30 Oct 2025 13:01:21 +0100
Message-ID: <20251030120127.509933-2-stefano.radaelli21@gmail.com>
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

Add device tree nodes for the WiFi and Bluetooth module mounted on the
VAR-SOM-MX93. The module can be based on either the NXP IW612 or IW611
chipset, depending on the configuration chosen by the customer.

Regardless of the chipset used, WiFi communicates over SDIO and Bluetooth
over UART.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
v2:
 - Fix pinctrl alignment

 .../boot/dts/freescale/imx93-var-som.dtsi     | 94 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index a5f09487d803..37f7837fb5ac 100644
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
+			MX93_PAD_ENET2_MDIO__GPIO4_IO15		0x51e
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
+			MX93_PAD_SD3_CLK__USDHC3_CLK		0x1582 /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD		0x40001382 /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x40001382 /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1	0x40001382 /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2	0x40001382 /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3	0x40001382 /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK		0x158e /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD		0x4000138e /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x4000138e /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1	0x4000138e /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2	0x4000138e /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3	0x4000138e /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__USDHC3_CLK		0x15fe /* SDIO_B_CLK */
+			MX93_PAD_SD3_CMD__USDHC3_CMD		0x400013fe /* SDIO_B_CMD */
+			MX93_PAD_SD3_DATA0__USDHC3_DATA0	0x400013fe /* SDIO_B_D0 */
+			MX93_PAD_SD3_DATA1__USDHC3_DATA1	0x400013fe /* SDIO_B_D1 */
+			MX93_PAD_SD3_DATA2__USDHC3_DATA2	0x400013fe /* SDIO_B_D2 */
+			MX93_PAD_SD3_DATA3__USDHC3_DATA3	0x400013fe /* SDIO_B_D3 */
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3-sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD3_CLK__GPIO3_IO20		0x400
+			MX93_PAD_SD3_CMD__GPIO3_IO21		0x400
+			MX93_PAD_SD3_DATA0__GPIO3_IO22		0x400
+			MX93_PAD_SD3_DATA1__GPIO3_IO23		0x400
+			MX93_PAD_SD3_DATA2__GPIO3_IO24		0x400
+			MX93_PAD_SD3_DATA3__GPIO3_IO25		0x400
+		>;
+	};
+
+	pinctrl_usdhc3_wlan: usdhc3-wlangrp {
+		fsl,pins = <
+			MX93_PAD_ENET2_MDC__GPIO4_IO14		0x51e /* WIFI_REG_ON     */
+			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x51e /* WIFI_PWR_EN     */
+		>;
+	};
 };
-- 
2.43.0


