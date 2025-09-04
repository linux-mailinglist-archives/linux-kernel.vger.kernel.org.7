Return-Path: <linux-kernel+bounces-801418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F04C1B444CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0FE74E6055
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFCB32A815;
	Thu,  4 Sep 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="GNVGV9g/"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE59322529
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008246; cv=none; b=V71FzPSUMLpBQUFA/6sV3JEn2ZcfWocDAkHKP2yYlSVboHLIF8Qog+ZsWrwp8gbJh4cfSZ73CvkR+fa6ulKI08h/MvDn03E6v3pzJbIITS1NpCQqEYH8so/LjgUG3yE5TS48s1W21XvLPlFDofLq+q07tG5VxBYHl9qbR+eBeVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008246; c=relaxed/simple;
	bh=eC8+hvLOJB3yqIfQE/tFDUG2G79c2TfXU2Kee66kdlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNbM0vR0OJN0Ylm1VRy88Ik9+yliIXX+ykiGW1dSm/Z+sAxBvbIVdPSexxRE0VFKgW9fNc3hhhg1PylBgRNyVke1UTA4ni9+q/oo5NCHC3fAPQM4oXIP8wY3Z+jW6EsYtvI6xo4hAu0EhPrr7/D6HUjL+dwU0hwMncwYBdU3fiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=GNVGV9g/; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 5FC62C83C3;
	Thu,  4 Sep 2025 20:50:43 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 00EFFC83D4;
	Thu,  4 Sep 2025 20:50:43 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A31311FD14D;
	Thu,  4 Sep 2025 20:50:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008242;
	bh=OfnR+WHwEoXTr+6OSdeoYm2XPL1+cyV+dJHo0zlMnD0=; h=From:To:Subject;
	b=GNVGV9g/ure7gnjB+Pdg4LCeqMSTxrxE6Vc/CN37JB668lNKsG8SPWcD81KYQOnaK
	 N52qfq2mG8dmbCfgUuyfez4B+hRX7GBfM4Cz6V5Lm9hDWx8ViO7jmfoSvIpJ4ZkyOC
	 P6ncbjUZomFY2uZxKbYThTk0sOi8e5eI+m1qY3qpTv9P0ZnvK8JTRv40o9nF4/Z90b
	 pbZjKBXugElnr6xkgOG9tB5t60d5kpcA6urM9xK+DjcAvx+pBDFhHCPFFHh4c712gU
	 Qb5D9gBIN6d3FEMFU5KxKZ/y+ncGdyPRJEOMccISux9AMJarKvqsoILtEefmHMO6fc
	 dUWgesB/ALzQA==
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
Subject: [PATCH v1 08/10] drm: panel-orientation-quirks: Add GPD Win Max
 (2021)
Date: Thu,  4 Sep 2025 19:50:23 +0200
Message-ID: <20250904175025.3249650-9-lkml@antheas.dev>
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
 <175700824267.2009457.17215964093686136802@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Right side up, DSI-1, 800x1280 screen.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index e7a2c5b59d28..75a8c4532434 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -327,6 +327,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1619-01"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* GPD Win Max (2021) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1619-03"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/*
 		 * GPD Pocket, note that the DMI data is less generic then
 		 * it seems, devices with a board-vendor of "AMI Corporation"
-- 
2.51.0



