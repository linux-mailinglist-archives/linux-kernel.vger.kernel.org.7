Return-Path: <linux-kernel+bounces-801417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD8B444CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C96F16B150
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA791324B1A;
	Thu,  4 Sep 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="o/+lgSpJ"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F543218D6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008246; cv=none; b=TkCXoQqsZ8Ka5CgTsuJPQVwwFTaaenbdGjICMBZYksFr0sbaoKtKdHVRqFr2bJjV42eUAtnI1Ji67m4VlUJi9xv6WwX3g0/jP1GrtkR3h6Q1FEjOht7rfxlHFciD50ipXgrWJ4ZfrVNHOZrDDHojP6GnjH4ynXXVrBBmABbw1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008246; c=relaxed/simple;
	bh=DHfcaA37d+mb8PRZqazNqZu/cnInIFIfYb8bTnL4Uws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfqA+pJ/CItjoxgHbDWQnoUiQBlH8rtsax69XXw5FBwE2fnUB6QdpMgl7BhkqBXybI6FeCZbg9vRIiupaBLHQj0VT5BBn7pWqMOuiRBte/p8Jxg0gG1G04GD1u/SQBQQlLkImj4mvYrcwCgNA3x2mjhOjUurESGbN2ubgEn7tHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=o/+lgSpJ; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id C1705BDC12;
	Thu,  4 Sep 2025 20:50:36 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 54736BDC0C;
	Thu,  4 Sep 2025 20:50:35 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id F37C81FD14D;
	Thu,  4 Sep 2025 20:50:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008235;
	bh=Zoi/F8a/F7smWEaCVkpYRIZrTHmWkc+ckFYGHGP1M30=; h=From:To:Subject;
	b=o/+lgSpJMPTJTxqFThHOA35W+KwAvWpedhv94sehJO4Jnk99aJzYV/ABUJXyn/KT8
	 1IRLIyFgkOiQUjN66uaaTMmDix6ri+TV2Y56Q0k7OtpK0xWE6O0V7ASxH0lLvIPlba
	 O96CqFrQMYwyvSEdi1F4TPXBu8fgor2dbiw1Zjm+AUex92j+clDplfW6Hk433QYi4B
	 P79s+W0CWlenQ4WyVUrv3LXVGBATHByo1rPndOb9W3IxRwJuEsglt61+ugokfhzwoR
	 f7QFQJ2zPvA/FBoywZd3DjIWOkvoSNrZyzeGc11ADN17q2fboi/sd6P1Y/Dvw53UcB
	 +WIk5Na3aAb+Q==
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
Subject: [PATCH v1 03/10] drm: panel-orientation-quirks: Add Ayaneo 3
Date: Thu,  4 Sep 2025 19:50:18 +0200
Message-ID: <20250904175025.3249650-4-lkml@antheas.dev>
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
 <175700823496.2009223.10935760764510186067@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Ayaneo 3 comes with two panels, an OLED right side up 1080p panel
and an IPS landscape 1080p panel. However, both have the same DMI data.
This quirk adds support for the portrait OLED panel.

As the landscape panel is 1920x1080 and the right side up panel is
1080x1920, the width and height arguments are used to differentiate
the panels.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index d724253407af..0ea06f928f79 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -209,6 +209,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* AYANEO 3 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 3"),
+		},
+		.driver_data = (void *)&lcd1080x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
-- 
2.51.0



