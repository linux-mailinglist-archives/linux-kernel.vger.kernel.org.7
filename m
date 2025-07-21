Return-Path: <linux-kernel+bounces-739041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623BB0C0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906767ABEEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF051290D8C;
	Mon, 21 Jul 2025 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="cUvVoj80"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77B290D85;
	Mon, 21 Jul 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092538; cv=none; b=qIJKTuDOiW3nrITlVqHlV8NZMNH1JYAk6WJv8XeqOoAR5Ysq/jlUvSzmgsJPVoGLZROcJszLeoAbGqbFqnxMxBcIzUO/R0roQnv9MajJTWIlLaBq/nFXDpMldYaOtRyBQpcUP04KF4J1drfrOW5jvM5Jdct9+U8fnG6WhwFeY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092538; c=relaxed/simple;
	bh=9T90lDE5NFtD4YWzx631hJd2BXdp+VSCa7VpF019DB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV//lJtqqsReXs27fkgIJDK6wQbQ9mnxKrTuBj+zwid2cmaDG00vdKUotbyWC0BbvBc+INrD8S7YYkpUu2WxmJo3GvbTfa/TtG97PYzvYdcCbWLv0pV8G+L286j6VQSCtERBnDCCHElGiiBnTTPgX7AknMPFamfORIaU6eQfaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=cUvVoj80; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93724C75F6;
	Mon, 21 Jul 2025 12:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092534; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lWX7emWvsoLQvVEGUyiq/66hqtEyres4Se1xfJrpZWU=;
	b=cUvVoj80eV+T+Jb/vSetVLXY5mOU2DluY/o+Sfcugq3DUhaYuAgJuajO8EoPgHlQWf8z9C
	tmN6AC5VZczkx6lXr+BboWOZa49p4Ka/6PFK2fkHhItt9VrRGuibztPhQ44uedAO9m/WVS
	kXH3tGE2oQXD/BtlSoUKICQfOwIEHkUS9jn9+b5VpbOKfKnlaFWFpUCqjEPk6E9OScC2cu
	jIWHhaRgUG/wvpTzDYRISRlgqO4VCRrGJ0YsNxEVcBEH8yfFU9OKuG+BhXOPCvANG4d32v
	82jlg9KOMXswXbk7Gc2qfLGNaGei7v1vz3dHbQYIVAA7yfRh9wAKQSk9HIQpUQ==
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
Subject: [PATCH v2 10/12] arm64: dts: imx93-kontron: Add RTC interrupt signal
Date: Mon, 21 Jul 2025 12:05:44 +0200
Message-ID: <20250721100701.115548-11-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721100701.115548-1-frieder@fris.de>
References: <20250721100701.115548-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The RTC INT ouptut is connected to a GPIO. Add the interrupt
so it can be used by the RTC driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* fix commit message (thanks Primoz!)
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


