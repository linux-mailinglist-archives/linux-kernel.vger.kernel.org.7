Return-Path: <linux-kernel+bounces-801419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E0B444D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38F87B6B58
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC993314AC;
	Thu,  4 Sep 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="nWC3uH1n"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BD322A03
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008247; cv=none; b=uIlKOdVVyLDK/w4kqJkmPx3hRqpF0jF37csdBTXglxqDnySiQWcj/nV6ruJn3cjTQDtPtxQPU13IRsYh3wjXzc9dSsHOOe10zHG1TYSvNOsC0nyZWmz52qvj+ifQfg5vMrDbOXuAj+E1wari4mrXL6oZt3owsX56oRvxY1zt42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008247; c=relaxed/simple;
	bh=4MAu8pPK2JN4SU8tDyiKIWIBz9WVFWAITTaamxLsSAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEuzUeFHU6aOrhYYoAOr0Td0Ymk27PeZHf6/ZEVh7jcYGWAxSxd3nST75+QRZz5JBlJIcAdYtsHS4ghQvgRS/b1KixtS4aqBsXmpZZ5nZ0c07ZQ7OcVP/F95IZ211ivoDSsps5haF2drJyOnkLCw8AiRVOHl8SCQXvexT0OjiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=nWC3uH1n; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id E1A12BDBEB;
	Thu,  4 Sep 2025 20:50:42 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 8C4AABDBE7;
	Thu,  4 Sep 2025 20:50:41 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 171FE1FD140;
	Thu,  4 Sep 2025 20:50:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008241;
	bh=nKshma+41R2VnZjmtFPHpn6vXQUNYkHqiSJJOxkcbb0=; h=From:To:Subject;
	b=nWC3uH1n4xbGfFIoMoHpoIq1mN84NBa37cnOH1hDXbMbP1j8o1kb3SAy9ZLWC2BvG
	 cGX1o2ejAfouz1YKUFqCAL0h6GUTPD1qwO+dU7WSdGVlIb4RW/wxXxQ80mZk8SQxrC
	 E+YE/HeLJiBgfhgixtXGrUumqn5xamV3SiZC6suPdirH/zav7pOLeVEJ3upYpWwQVI
	 0em3V7/3+m4ijdam5lWRmwwjb2jL9Fb6oIon9tq6dZTVg4neS8FcrRdKa0JaOFhOXM
	 2FeB/GfYXK147piR1LrVd2YJOgw6HMSXWyFu0QE5On2TX0pVsKCZ2cD7O0Ze+t4ya6
	 WOBIzZYaD/lgA==
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
Subject: [PATCH v1 07/10] drm: panel-orientation-quirks: Add OneXPlayer G1
 variants
Date: Thu,  4 Sep 2025 19:50:22 +0200
Message-ID: <20250904175025.3249650-8-lkml@antheas.dev>
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
 <175700824119.2009417.11190019530648349422@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add quirks for the new clamshell device OneXPlayer G1 for both AMD
and Intel. The device has a 1600x2560p 144hz LCD panel.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 6f5ce26a84b7..e7a2c5b59d28 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -558,6 +558,18 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1Pro"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* OneXPlayer OneXFly G1 AMD */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER G1 A"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer OneXFly G1 Intel */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER G1 i"),
+		},
+		.driver_data = (void *)&lcd1600x2560_leftside_up,
 	}, {	/* OrangePi Neo */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
-- 
2.51.0



