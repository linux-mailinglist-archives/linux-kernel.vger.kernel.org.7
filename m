Return-Path: <linux-kernel+bounces-730214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B3B0416D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AB1189EA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249AE25DAFC;
	Mon, 14 Jul 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="qsI/zJlu"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715B25D8F7;
	Mon, 14 Jul 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502836; cv=none; b=Mvyu0Vg+1HnpJc6+VDqfSlfXGITjAHpbO3k+HLFjr0WEYUOnAUvC6edTtZExaIAYa+FouzWs+T2XhFIy2H9JwTQZ4K+e2T5R3EXSzauBAUsHXonYqOX45Lt/f0Kpj7gulpeoYmfNhQ6zuSsR3b4/MR1w2DjgSXXbmb67DJyybp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502836; c=relaxed/simple;
	bh=5lpfy50ypOdLjZqJqz7b6y8gBLPJ9c+suqWuPFmT6N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRIC2/kFnw5nccyPATfvYnpf0zUnnE/rjLDx/aAYI6q0GHP5qRah0uqJAWODHzTjak0GghRQpzmNJ3RN6gW3kPDSajCgE7E+sp+nECM1U20HJrwM4sjA+XRaa/YAfprwxhtDJh/9dppYjW2Q5pMJHrvqeOQeg906hx3q3hA5Ubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=qsI/zJlu; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B916C753D;
	Mon, 14 Jul 2025 16:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502832; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BdeLUXBHRqGOhfUv9g/nbTTXLKN+sllf5U2xZtp5pO0=;
	b=qsI/zJluZDysCLCi4bVjlogYxdJ80Fw1JNWEDiu9oAguFgzkNOEd54ri03LS12Agmy+uJi
	b1arHYsj3jhDyl2e9+dn9s6J3GDdzHdc7FMeseKB67Q9LQ5m86Spq42ig1f7Jg3gnSRsPe
	hhN6MtyyzzvfzVZpWqVeMUU2NFf3vlCrUkroH2tZewTOCSHYcb/tC6XYJqcCWxaIy9wppI
	ikwaYOSVAqAzN5mCpvh9HScAoL1ampnsxQSFRyEzpqxjJrYyfof1+ypweGAs6T8zixLzw0
	mfxTXxqUCL29p7X0Lw3URZcPzLMmR61Z0QjWPB5VxnC4q57A4NvoaO2EDLxNGA==
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
	Annette Kobou <annette.kobou@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 09/12] arm64: dts: imx8mp-kontron: Fix USB hub reset
Date: Mon, 14 Jul 2025 16:17:35 +0200
Message-ID: <20250714141852.116455-10-frieder@fris.de>
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

The latest hardware revision uses GPIO_B_2 as reset for
the USB hub. Fix this and remove the pinctrl as we already
have this in the OSM-S devicetree.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts     | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
index bbcd76e9e9913..614b4ce330b1c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
@@ -250,8 +250,6 @@ &usb_dwc3_0 {
 };
 
 &usb_dwc3_1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb_hub>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dr_mode = "host";
@@ -260,7 +258,7 @@ &usb_dwc3_1 {
 	usb-hub@1 {
 		compatible = "usb424,2514";
 		reg = <1>;
-		reset-gpios = <&gpio3 14 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -317,10 +315,4 @@ MX8MP_IOMUXC_ECSPI1_MOSI__GPIO5_IO07		0x46 /* CAN_ADR0 */
 			MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08		0x46 /* CAN_ADR1 */
 		>;
 	};
-
-	pinctrl_usb_hub: usbhubgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14		0x46
-		>;
-	};
 };
-- 
2.50.1


