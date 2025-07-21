Return-Path: <linux-kernel+bounces-739043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752AB0C0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F19318C1CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335CF2900BA;
	Mon, 21 Jul 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="BbXKXmjW"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DF291C11;
	Mon, 21 Jul 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092544; cv=none; b=LIxvKE3eTUZ1j2gbmNAa0eD1urqsIApSTvRJ37DuAZW6JEDA0QZSKghm2LpKzRxfBjK6G75NQ+8clTTUK6Z7PveJYCx/FvfRLgGjFP93q78FAaWqcUIckiIKhjI1iS+n9py+3DDjsBn99dAiYbfbDKglxOoGwCQsH/hR2xqFd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092544; c=relaxed/simple;
	bh=QcOTgdqFbWIVlAzniKM64lk1QgcWvoUMOayy7LHY3Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZQosSM91rIWClCYLD9Yp5D7yX1XoA85ao6gJ3yd0zIk6heEHis7ajVnlC1tXCEUn9KSBX8V7yLxTQLX8amPcJx57XKNQkAPq43noTB2VFyYVRpRzObBjCXuSdOKJQiX81CYNZcbz/OpYKERaJ7YWqrjrnwJ93R0WYA7rH1l7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=BbXKXmjW; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D421C75F6;
	Mon, 21 Jul 2025 12:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1753092540; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fi0fGJ9AJQqZATBmEm6EZuwX+ZDWl2PPzFs07T+Av88=;
	b=BbXKXmjWwD7TB2flQXuc32pjwrX0tyzpybW8EiUto+FvMGUad1rlb7Q68hRwlrTjEwrnsl
	Y7S6w237oZ9ytjRe49tmcQikhonH2XoB/rnm8uHKJ/Cz0xb12nqrsH4yStpvQFURjOZUwt
	FhlCgYxpnC+hhem6ATxvw93G73r6T4wZBXY7CjuIFJ+nSslqDY9xWtF95mKm8+8YoZQteM
	G6K+l+Gtmk06BWiccCf3ELKct3w55/rLiJAEM3WgJAixSKEGF3Mr2zKOOJvQDSxykOk+IW
	UakIcCoNjv9BKvOaCdKvndzToTXS9YPnoNnyH6Tg0kHcCYfAp9bPWhoVuaGL3A==
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
Subject: [PATCH v2 12/12] arm64: dts: imx93-kontron: Fix USB port assignment
Date: Mon, 21 Jul 2025 12:05:46 +0200
Message-ID: <20250721100701.115548-13-frieder@fris.de>
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

The assignment of the USB ports is wrong and needs to be swapped.
The OTG (USB-C) port is on the first port and the host port with
the onboard hub is on the second port.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Fixes: 2b52fd6035b7 ("arm64: dts: Add support for Kontron i.MX93 OSM-S SoM and BL carrier board")
---
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
index 9a9e5d0daf3ba..c3d2ddd887fdf 100644
--- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
@@ -137,6 +137,16 @@ &tpm6 {
 };
 
 &usbotg1 {
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+};
+
+&usbotg2 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	disable-over-current;
@@ -149,16 +159,6 @@ usb1@1 {
 	};
 };
 
-&usbotg2 {
-	adp-disable;
-	hnp-disable;
-	srp-disable;
-	disable-over-current;
-	dr_mode = "otg";
-	usb-role-switch;
-	status = "okay";
-};
-
 &usdhc2 {
 	vmmc-supply = <&reg_vdd_3v3>;
 	status = "okay";
-- 
2.50.1


