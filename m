Return-Path: <linux-kernel+bounces-873733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE47C148F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B3D34F6BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ACA32B991;
	Tue, 28 Oct 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="wvljycMA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="OUONIk+t"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398B2E543B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653591; cv=pass; b=fH+owccnwBIxPBURd0nb12DB7Th54qrejtXf3Kxr5A2d1Do40uVuXeYFOb0CalMqRTK3C6vZZNnqAqYUhaMGpf9Tis63XiPcFJHBD8DQLPQLSZb2QK0h7exMy6Fl+fvwEhxunAhq5n66cKoOqN86irvjUTXrsM8+iJjdScTp5P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653591; c=relaxed/simple;
	bh=LPNuOvV5GIfBMgx0l/rLWwK1QWOgIasJTyq4uGGl3as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YMuOHQKRoN4h9TLs/5oYRdMN2ghUAdFmRkjbU8RUE9eWtBEFEy9zEYDha0P4M3yZml/NOJPi4xZ33gpoO18QJxWvaF3YTYkSN0fAs0proAhzOAaP3NUMDdf9efdQAh7ChH3J33TAHxxa6/3UMh3D+YlEFGzmrI3ORTYF0BSMQoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=wvljycMA; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=OUONIk+t; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-dkmb.prod.antispam.mailspamprotection.com; s=arckey; t=1761653589;
	 b=Ke8F6MCN6+sC8f5fsRpDEj3sM/pnb1N3O6vrzxqZVPJhzE1hkP9D8dm4FgEZIh3SrIoW2Z6dlI
	  sD0VrvBOzoEJ6ZCQAPSEb554eedw7X/+W7uIcNQR3wNbh1QrrUE2EGs0reGu8acLhi3qNNvd0T
	  uAKZUov/5qrHazxhNKuh6+s3V5LCsKkd16vYQGHV7Ja09fUBPBRv5lOTmaI7wXgBi8iB9pJzv5
	  t1oYvu//bddCatPsb1HxjrLqDrZbrRbh94mfeXE3hdyhBye57jPw32MD4PoqPRCeMF3FsD2blS
	  uOwYs0xi/LqlTIFvuGQO5vQ+wOkfu0alg0Kk8R6uqrWGZQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-dkmb.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-dkmb.prod.antispam.mailspamprotection.com; s=arckey; t=1761653589;
	bh=LPNuOvV5GIfBMgx0l/rLWwK1QWOgIasJTyq4uGGl3as=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=fyLY8SkGYl+fCpPmkpHNAZ3Zl4IBHV5NlDwEWOVePV1o97dUbFbaaP5nNv40er7/btstgHVRC5
	  Q9IXshEENSNH5VYBpSDPul3bO7TfPlYDfn+IILBUwUJelFCcD82W/fmIpz99pfTMvI1PiejRns
	  Eg/nYlumpWj9HqhsyMXXPPZF+tJSfIHSMLCiSIaFjSGMu/MyjmPonRjyJ6cwW1jNZCPHjkU2VF
	  dbop+gMjGbbD3vUo2VmTUGV0FWtKc2V4Ufz5ox15O7AY/GdOHX2elu9F5AqnEiBL/wAg9hDbaC
	  MFR1VjPPJXC1XFX/Rkxj8mfzJO2HSM0i2a6elREqb47vEw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=VG6cm4G4x6Z3D7MXtTK+Y6amsUkDuaGsyQbRz1bw3mQ=; b=wvljycMA8ylYY0aXO9Ot1KQHpd
	1NEYegTHelwH29q6pe4B1nJX1hDqed4+UEtEDnvZHPh5CC1nT1ppW8c3CRNbJpMc50qDFg1MB8O9e
	tFBcJkGo41JJn3buO3icDLmKtWIqOXuvERAlO4DTly/74DJKXtCgQS0BTQstwVCs2kMw=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-dkmb.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDiZU-00000005h3Z-2wAS
	for linux-kernel@vger.kernel.org;
	Tue, 28 Oct 2025 12:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=VG6cm4G4x6Z3D7MXtTK+Y6amsUkDuaGsyQbRz1bw3mQ=; b=OUONIk+tp/9U4/2UzIK2MKESkb
	EWYaSFEzux4RHxkDR5NqeTnb2PUvtqkXXnElXdiwxfxkU65Mzn8v9RHKWYb6kfEbx/SJSe337hH89
	q/0OjaQ4w05M1W2IB+57kDrym8FZhZpH1g8+hWcOk2swPsJpWtGhUB8+C0nfow8piJ1I=;
Received: from [87.17.42.198] (port=61382 helo=[192.168.178.74])
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDiZ5-000000004BL-1CX4;
	Tue, 28 Oct 2025 12:12:39 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Oct 2025 13:12:29 +0100
Subject: [PATCH] drm/bridge: ldb: add support for an external bridge
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx93_ldb_bridge-v1-1-fca2e7d60e0a@valla.it>
X-B4-Tracking: v=1; b=H4sIACyzAGkC/x2MWQqAIBQAryLvO8EF264SIaWvetCGQgjS3ZM+h
 2EmQ8RAGKFnGQI+FOk6C8iKgdumc0VOvjAooYwUquV0pE7b3c92DuSL105IiU1rau+gZHfAhdK
 /HMb3/QC6aGlvYgAAAA==
X-Change-ID: 20251028-imx93_ldb_bridge-3c011e7856dc
To: Liu Ying <victor.liu@nxp.com>, Marek Vasut <marex@denx.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Fabian Pflug <f.pflug@pengutronix.de>, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272; i=francesco@valla.it;
 h=from:subject:message-id; bh=LPNuOvV5GIfBMgx0l/rLWwK1QWOgIasJTyq4uGGl3as=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDJkMm82SNsa8OHinb6/mTb83ZcsTq5/uXrUuf2vNSo8Wh
 Ql/lJ9ndJSyMIhxMciKKbKErLtxb89c829pGxgfwcxhZQIZwsDFKQATEbzJ8E+JpSBxrptKlEhZ
 9bEZ3lf+316Tq/m1pfuevUraQ7np2wwZGW7z35vssMSS6+rqi4wra9MCO1oeCR5daDn5yP/8tLO
 qN3gB
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 1cbf96610381131d1470fb74c67659b1
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vDiZU-00000005h3Z-2wAS-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-dkmb.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

One option for the LVDS port of the LDB is to be connected to an
additional bridge, such as a LVDS to HDMI converter. Add support for
such case, along with the direct connection to a panel.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
I was trying to add display support for the i.MX93 FRDM on top of the
patch sent some time ago by Fabian Pflug [1], using some of the work
already done by Alexander Stein but not yet merged [2], but then I
noticed that the support for LVDS-HDMI converter bridges was missing
from the LDB driver already present for the i.MX93.

Not a fail of the driver itself, obviously, but I wonder if/how the
existing i.MX8MP setups (e.g.: [3]), which use the same driver, work
correclty. Unfortunately I don't have the i.MX8MP hardware to test them.

Anyhow, a patch for such setup is attached; it was tested on the i.MX93
FRDM using [1] and [2] plus some more devicetree modifications.

[1] https://lore.kernel.org/all/20251022-fpg-nxp-imx93-frdm-v3-1-03ec40a1ccc0@pengutronix.de
[2] https://lore.kernel.org/all/20250304154929.1785200-1-alexander.stein@ew.tq-group.com
[3] https://elixir.bootlin.com/linux/v6.17.5/source/arch/arm64/boot/dts/freescale/imx8mp-evk-lvds0-imx-dlvds-hdmi-channel0.dtso

Regards,
Francesco
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 5c3cf37200bcee1db285c97e2b463c9355ee6acb..fad436f2e0bfac8b42096a6fcd0022da0f35284e 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -294,7 +294,6 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *panel_node;
 	struct device_node *remote1, *remote2;
-	struct drm_panel *panel;
 	struct fsl_ldb *fsl_ldb;
 	int dual_link;
 
@@ -335,15 +334,24 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 		fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
 		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
 
-	panel = of_drm_find_panel(panel_node);
-	of_node_put(panel_node);
-	if (IS_ERR(panel))
-		return PTR_ERR(panel);
-
-	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
-	if (IS_ERR(fsl_ldb->panel_bridge))
-		return PTR_ERR(fsl_ldb->panel_bridge);
+	/* First try to get an additional bridge, if not found go for a panel */
+	fsl_ldb->panel_bridge = of_drm_find_bridge(panel_node);
+	if (fsl_ldb->panel_bridge) {
+		of_node_put(panel_node);
+	} else {
+		struct drm_panel *panel;
 
+		panel = of_drm_find_panel(panel_node);
+		of_node_put(panel_node);
+		if (IS_ERR(panel))
+			return dev_err_probe(dev, PTR_ERR(panel),
+					     "Failed to find panel");
+
+		fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+		if (IS_ERR(fsl_ldb->panel_bridge))
+			return dev_err_probe(dev, PTR_ERR(fsl_ldb->panel_bridge),
+					     "Failed to add panel bridge");
+	}
 
 	if (fsl_ldb_is_dual(fsl_ldb)) {
 		struct device_node *port1, *port2;

---
base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
change-id: 20251028-imx93_ldb_bridge-3c011e7856dc

Best regards,
-- 
Francesco Valla <francesco@valla.it>


