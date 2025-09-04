Return-Path: <linux-kernel+bounces-801422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD7B444D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2B724E60C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBAE33A037;
	Thu,  4 Sep 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CgLpXwMD"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45E3376AA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008251; cv=none; b=M7G2Mdx2DfVFVRPaKivE05AoONNGJvC4tg2dxs78FF+9ufx7wsq/nUh+huC7YqLPdvm1s+5ANjKpRI1FNGXUN/ogENUDcOI04B0SJ8RlqEg0m8iJhlI9nvlZVkiOCsysgdPJ0JL62HTnbxiW9xxjYStc3w1bw2Hrg1HQFntWzP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008251; c=relaxed/simple;
	bh=utlNNAyHgCTNaukJOxVlNqOMl/nzIp2xNPdfysrUWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEorUJDfyDO66HjSRaNaP5axnlMsBj987pxWPlALHWPhyneQ80lI3yrgix3tOy6xKEQld9NxP6aBlLV46NjarZBF6JARPOe6weYBvn+Klb8/B83YDH7HBkezlmrgwPDyAJRRxGGE5V2ZBpEa8jLkfudYJK5x/5nVTG7S9PGmTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CgLpXwMD; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 1DD8BBDBF5;
	Thu,  4 Sep 2025 20:50:47 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id BA1C8BDC00;
	Thu,  4 Sep 2025 20:50:45 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 850B61FD14D;
	Thu,  4 Sep 2025 20:50:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008245;
	bh=O3swqMH/kdD00KvEkWDNdW/6eIsnVSseUscnjVIVZcY=; h=From:To:Subject;
	b=CgLpXwMDO8ER7/K+YrsE90hbXeS5xoVlB0NKTQB9j0ZiAWeYeSGBziLkVrfCblAFp
	 fHJU6g98/3xYOxIuDe+vnPXoGj9qDyFoc1+p45HcBl11R2o2GAEPJaF/5MQSknLRaQ
	 +fxMSm4B55REoqkANDIEOMyoWFknq24TzhCIGypsTi9KkqfDfReFRanTbnq/jmqugx
	 LyD4lSpISP1BHVQT1440sinTQ9KBdm4aIgpyJWOtUiscnLXzTJbask14WmMAP4unOc
	 W44216RjBxiN6uL/boq6SVpej8ttuOFWWF+WqjLc3hohDj1Fla94ZxMtid5Hysk3IC
	 DixO9kbZyaWbg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 37.96.55.21) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	philm@manjaro.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 10/10] drm: panel-orientation-quirks: Add Zeenix Lite and
 Pro
Date: Thu,  4 Sep 2025 19:50:25 +0200
Message-ID: <20250904175025.3249650-11-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904175025.3249650-1-lkml@antheas.dev>
References: <20250904175025.3249650-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175700824542.2009558.4848189186275854884@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add quirks for two Zeenix handhelds, the Lite and the Pro.
They are identical to the Ayn Loki and the Ayn Loki Pro respectively.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 5f896d6e4090..201e5349f3ac 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -594,6 +594,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
 		},
 		.driver_data = (void *)&lcd1280x1920_rightside_up,
+	}, {    /* Tectoy Zeenix Lite */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Tectoy"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Zeenix Lite"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {    /* Tectoy Zeenix Pro */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Tectoy"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Zeenix Pro"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Valve Steam Deck (Jupiter) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
-- 
2.51.0



