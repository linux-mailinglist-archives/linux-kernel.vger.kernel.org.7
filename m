Return-Path: <linux-kernel+bounces-730217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38CB04173
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711443AFE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336602580D2;
	Mon, 14 Jul 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="AsfsmvpI"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2125F781;
	Mon, 14 Jul 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502846; cv=none; b=BkYTwq1pP6yNBUJhOTSZ+zRS82DCQBOFVR0hhCjfpHm95GfFEA51Cj/tKIA1e/ThZxgX56xkreuvOfkBWfDIoayPhhjEMuumf9zC/PNlkeeATyuYKabGB38ueByfwJQgRrEHaHC/4cYHfij7+3OeemAYdqXs8uFJ5CB/9qY9XJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502846; c=relaxed/simple;
	bh=QcOTgdqFbWIVlAzniKM64lk1QgcWvoUMOayy7LHY3Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVJthXTg2A01vGArqazmsK+gwU6KhBFJkvvH/YqSz1Q4q7zxDN4aWoq8sGMuK/4KFa23r7ao1/cHKRQOYx9aVW7dLGqZufXAcRJzqm56Kkg/JvPOmj+JzLpviu3VN6uAlZQpVCXRvJwJahYAtFHVyuWxP3eRubRcRIrYZdsueZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=AsfsmvpI; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1715C753B;
	Mon, 14 Jul 2025 16:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1752502843; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Fi0fGJ9AJQqZATBmEm6EZuwX+ZDWl2PPzFs07T+Av88=;
	b=AsfsmvpIIOqgImVGjgJI0NgNvlL/oa7g76yvKKQdGtCE/L2OVcrH2goiBeBxJjjLUe3tQb
	/OrJsnAZY9EEXxJfXBXvsc4P7M5hxIh0SkiWDL/pUv2faZzeKMfhbHufXUVK8CSlLnQGgs
	cDFxDEYDcenqYK5fud2eU0tgAyFs2zzzbaoTTEvhVGsk/NzEounwCB59TVoUassvMGIsNE
	fp41RAEjOWie2qus3O/8QUlkTBbisBcSKmhei/pOYhpy4uam3gNsTbcR9FigPRY6aeBWAT
	WQlarfL6oFobReaXmfzWTCi+9xhL3KLLK9Jzt1vnXFJox7BEJLE/v7TAky1w8w==
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
Subject: [PATCH 12/12] arm64: dts: imx93-kontron: Fix USB port assignment
Date: Mon, 14 Jul 2025 16:17:38 +0200
Message-ID: <20250714141852.116455-13-frieder@fris.de>
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


