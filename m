Return-Path: <linux-kernel+bounces-739042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C191BB0C0F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB618C1981
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BC828DB7D;
	Mon, 21 Jul 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="OnLSwu8+"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E2628DB71;
	Mon, 21 Jul 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092541; cv=none; b=vGcAakXnkFSiWDuJj5WeVu0eYFlaXOaWF2GIGdiG3a/N2HrsLg5/l2ssMa+BtZ3hiaC9a60/I2zu+Wc7WDngvJbaC/TLRiq/L0qBmLQTLpPh715uCDMw0LvK1VISXdlj6D7bLpLLqGrkNg1dxuN0cQApzstS9ryBurmhVmmISvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092541; c=relaxed/simple;
	bh=ZMK2uV/A2ISn/Ls74ZwGfq0fd0lQyg0andir1a2Z+xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLGNmzgrwPo6x08/jIkzXFtc6fNdmfqvya6+yPoZsJUi5BVlc2ptKpejbLGSsNHMkY+22GZZeo/HJBYCVAMingCOxY48hVBRwKCXleSRM5enkBnUrtj3nrHY/kaIs0u6WqmU0yBRJvSg2HrKvZ43hQ5oT/NkcX5XaX7OYCWfTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=OnLSwu8+; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 868D7C75FC;
	Mon, 21 Jul 2025 12:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092538; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ipyKtg5UVZklGe5U9QDzBiMrFjh0uc+HFQy8UQbyy0w=;
	b=OnLSwu8+QOb/g0GNtyXQuISJy79JE/3frJxR9FKOSrl4fQxttrlJ8wQ61JqZ9gXXhsCo8w
	TxoxBcXp568dD4ZZsu0l1vlNNu7hYy29qs4W/dyBZk0bt/RrbxNT44Sv11mqqKIDxj72Lz
	4iKJgcxbWzEw5dH4iO+njWIMGM/ZN45zDJy/8T4YQBGk4ZxLncC5zq6KN0C4Utps2qH5tA
	d1yFmfJ9FhRWC8IJLZfiXJsbH+7vuo7S4S0u3DA3zba6kKTOxoP05O90kCRdSf6VHkqR6C
	MzCl34dHWjCvJO/Q9mDnb2kUQ+y5aF+efpzubALAtMqV1czBUJNlVWUhuZBJGA==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Annette Kobou <annette.kobou@kontron.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 11/12] arm64: dts: imx93-kontron: Fix GPIO for panel regulator
Date: Mon, 21 Jul 2025 12:05:45 +0200
Message-ID: <20250721100701.115548-12-frieder@fris.de>
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

From: Annette Kobou <annette.kobou@kontron.de>

The regulator uses the wrong GPIO. Fix this.

Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Fixes: 2b52fd6035b7 ("arm64: dts: Add support for Kontron i.MX93 OSM-S SoM and BL carrier board")
---
 .../boot/dts/freescale/imx93-kontron-bl-osm-s.dts    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
index 89e97c604bd3e..9a9e5d0daf3ba 100644
--- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
@@ -33,7 +33,9 @@ pwm-beeper {
 
 	reg_vcc_panel: regulator-vcc-panel {
 		compatible = "regulator-fixed";
-		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vcc_panel>;
+		gpio = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
@@ -161,3 +163,11 @@ &usdhc2 {
 	vmmc-supply = <&reg_vdd_3v3>;
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_reg_vcc_panel: regvccpanelgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO21__GPIO2_IO21		0x31e /* PWM_2 */
+		>;
+	};
+};
-- 
2.50.1


