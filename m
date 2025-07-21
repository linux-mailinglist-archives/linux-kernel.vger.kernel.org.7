Return-Path: <linux-kernel+bounces-739040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B162EB0C0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77A64E1C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5728FFF6;
	Mon, 21 Jul 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="dH5yDUGZ"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FC5290080;
	Mon, 21 Jul 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092534; cv=none; b=vB6EDqIc3U0v9YR7eZPLJrcB9FDy86w3QPfdQyNCqFW7LOAmJQL/0ZTpNngvzMWFEW8Gnz5rRXppOKQZgrjK65JJM1ZuiuPrMCJ1tkEo8nMt1vvtNvQogIIEg84aN6snGcUMn0GL+tUI3IdBvQv38CVKxlP6gk4Hr9R01FcO7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092534; c=relaxed/simple;
	bh=5lpfy50ypOdLjZqJqz7b6y8gBLPJ9c+suqWuPFmT6N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWTKaqqp6+9jtey3fY3xbpWq6oZH0kjRRFMF1U/m1VkWV4JoMyHannn8fNVBwg4CJBbX6SNc9RitDEuhtnQKPIPjqE36kgwfIWo+XZz/6xIoTYMSGsj2WUfMGWslyirJXNjqDaUA5zJBipZP12z3yL2ZNUV9/4qfh0/oYlrQNpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=dH5yDUGZ; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05B05C75F6;
	Mon, 21 Jul 2025 12:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092530; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BdeLUXBHRqGOhfUv9g/nbTTXLKN+sllf5U2xZtp5pO0=;
	b=dH5yDUGZboBssEQxCie4tlhWvPbVRc0gCxwaQ4Bgprniqaxe+LoKnOflBAc7ctogYj1LK/
	GzL1MgUoJBXri16PSy5c/1QkxuB+4rz34/tnhwdFb6W180t04WLdONTAqvfT+POfXdmQn8
	5GTxu66CT63Y2srpIJklK5oQ1jaSZBWGzOzHavN8F4B6rDPcMG4aRJiKDPmubMREi4Ze7B
	zGqfaaPltWKY3g8aWvMcHQhmM4yNk8pucg7ErIGuAcJFnSTu4s5P7CjgKu8aNN/H3TK/Kv
	pQ/qw4oqsW0WW7h0tfeDlxvKrVd2ehv4JGm78kBEy9NKlE9GMfWGie4WWW9Acw==
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
Subject: [PATCH v2 09/12] arm64: dts: imx8mp-kontron: Fix USB hub reset
Date: Mon, 21 Jul 2025 12:05:43 +0200
Message-ID: <20250721100701.115548-10-frieder@fris.de>
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


