Return-Path: <linux-kernel+bounces-730215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD774B0416E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E0D7AA7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51700257AC8;
	Mon, 14 Jul 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="la5P6Ds1"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFB25DCF6;
	Mon, 14 Jul 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502840; cv=none; b=FGSfh9A17u+PEqWmnAP9QgqgR6ib4jg/BZ343MfrUZYTUkAlgm70i2c2tVLi0JkUbtitWGvhDGMeE7Wy69N7aT3T08JrHLcCkEzGXfub3VjsqqSkPoraQBciw5MZ0mW8HazkkQkkRhwV3qZ1yBX+ydeIdypcK+Tm+CYNdk7vQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502840; c=relaxed/simple;
	bh=QpLSkhNlbNp4AANxfXnY2gqnk6G2rh5PFc0ZxZ1Dsgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfoQ+2OPw4jGgxWs704E1Kg9qCQGe6evP1j/pGlndldIS8NyJiLYSYK1eRTHiW64Ke7I9IpgsihBdJ5my1LnTxZySCW/TJoLtoZPI+PgA0+Ew4x+VGOI+sh7q0sbnEqAUTgfQRrRSl0tG3EQhi3wBm4SDzJoyMjfYOcDIBoGHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=la5P6Ds1; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F934C753B;
	Mon, 14 Jul 2025 16:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502837; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2L71jw77VC8loJmQAT8DPywfUlO2NWcswTW0Ue92rdk=;
	b=la5P6Ds1FJ43gszmyuZX8M8JY0fLf+me5+WTHRnIQCWNyGbK/ARmYkjFHxtcB1mKk7oxnE
	VuRBY78r+FJ/NXY0PCke3sQlQBIiZ19XK7pWf5znUr9tHzipyt3X0mGEARBXAeIPR4PNCM
	tjjnpEGVp/FDWW6XiB9WtJ0Fzsx6AUQNRlnEAXdwqyG14jK0YzMzxJAwy7N0fcjQSgnQ/E
	fCjVUDEpL8mNpqxyk3vhq7/44IbeKuxaRXB37p/HJDFt4ru9lGKxB+ImHfdZAYLamFqUr7
	rt++oMSyEvO+Wrww2oDS41fMTtyHMKFSLUFcM6Stzbd0jzPIh44qXlSJzNGYqg==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 10/12] arm64: dts: imx93-kontron: Add RTC interrupt signal
Date: Mon, 14 Jul 2025 16:17:36 +0200
Message-ID: <20250714141852.116455-11-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714141852.116455-1-frieder@fris.de>
References: <20250714141852.116455-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RTC EVI ouptut is connected to a GPIO. Add the interrupt
so it can be used by the RTC driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
index 119a162070596..c79b1df339db1 100644
--- a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
@@ -205,6 +205,9 @@ eeprom@50 {
 	rv3028: rtc@52 {
 		compatible = "microcrystal,rv3028";
 		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupts-extended = <&gpio3 19 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
@@ -468,6 +471,12 @@ MX93_PAD_CCM_CLKO4__GPIO4_IO29			0x31e /* CARRIER_PWR_EN */
 		>;
 	};
 
+	pinctrl_rtc: rtcgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_VSELECT__GPIO3_IO19		0x31e
+		>;
+	};
+
 	pinctrl_sai3: sai3grp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e /* I2S_A_DATA_IN */
-- 
2.50.1


