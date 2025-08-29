Return-Path: <linux-kernel+bounces-791955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76FB3BEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30BFF1C84D61
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194F322A3D;
	Fri, 29 Aug 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DQXq2/uj"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F6321F22
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479480; cv=none; b=iQP3rtjHVN/9R1rXYBISgMYTkPU1V15gfbdk6qHK0g3DyPsXznskG9gxVtiSnc28GBCMg7s+VlLzHdsdhL24YTGTXZLENDoJjooKVpMXUexppSyPIFAlzY7lRXI2rkDS4Iiuok9TTO7nQUBrK/VtGSB9ZJFurmaHjGA/Vz6ujgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479480; c=relaxed/simple;
	bh=GbBOsFjp0mNCay0apH+0veiToC7EJSVTmjWdFUs4a1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6wUeIP1c/KuV9UiIcav890ZU+lheBAA4x5zY4V8MkOh9dFExq770nDE7oLamg1q738yrmD2vinbMt80tx33Bg1PmM6YOQJGcUq5i5uWG4IFBX2sqVIYIFVXuRoDLfei7ShBCRj9/wRJJmBvsn1FbdVi89YX7qpp59kLR8LP1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DQXq2/uj; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id B5F29BDE9C;
	Fri, 29 Aug 2025 17:57:51 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 1B8C4BCF58;
	Fri, 29 Aug 2025 17:57:51 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3F50F2067F3;
	Fri, 29 Aug 2025 17:57:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756479470;
	bh=6RKE2eX0bGesXYi+c9kmIa8eVlQw2K/rKlycX1Jf8cs=; h=From:To:Subject;
	b=DQXq2/ujGqWBGmQ+W0N46qaT72q3pW1kP53ZseX35g040qmLvhs2bws0nSDsRjk8x
	 yRkiC4wnBY2javTB/TY2h2hbVXN45GtP6CNir7D6p+ZxcO/6OVKTh5eqLcxXF4IoZy
	 WnR9Xz2eJ/HvhtE/54xRRrxcDngu6eFEXPWu1BBnbAT2uuaQ8a58ezuA/uu3Lk1jPd
	 DhxVq20BMimvnjh6uAEHnNlE/OIt0NsxnIrEIdVxYLUAdizr5FeJ/Gf9nuGO1Ob8+O
	 rhXq9v/+rGcezWxAhxurEsuC9UQqfPIgGh0rQDcgDm2m9CKyXu+gSYpMzCca6XWu1e
	 ga8XlqzJIJzNg==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.85) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 6/6] drm: panel-backlight-quirks: Log applied panel
 brightness quirks
Date: Fri, 29 Aug 2025 16:55:41 +0200
Message-ID: <20250829145541.512671-7-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829145541.512671-1-lkml@antheas.dev>
References: <20250829145541.512671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175647947078.278157.16049391296817176052@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, when a panel brightness quirk is applied, there is no log
indicating that a quirk was applied. Unwrap the drm device on its own
and use drm_info() to log when a quirk is applied.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 263f15f6fdea..2a3e17d83d6e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3617,13 +3617,15 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	struct drm_connector *conn_base;
 	struct amdgpu_device *adev;
 	struct drm_luminance_range_info *luminance_range;
+	struct drm_device *drm;
 
 	if (aconnector->bl_idx == -1 ||
 	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
 		return;
 
 	conn_base = &aconnector->base;
-	adev = drm_to_adev(conn_base->dev);
+	drm = conn_base->dev;
+	adev = drm_to_adev(drm);
 
 	caps = &adev->dm.backlight_caps[aconnector->bl_idx];
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
@@ -3659,12 +3661,20 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	panel_backlight_quirk =
 		drm_get_panel_backlight_quirk(aconnector->drm_edid);
 	if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
-		if (panel_backlight_quirk->min_brightness)
+		if (panel_backlight_quirk->min_brightness) {
+			drm_info(drm,
+				 "Applying panel backlight quirk, min_brightness: %d\n",
+				 panel_backlight_quirk->min_brightness);
 			caps->min_input_signal =
 				panel_backlight_quirk->min_brightness - 1;
-		if (panel_backlight_quirk->brightness_mask)
+		}
+		if (panel_backlight_quirk->brightness_mask) {
+			drm_info(drm,
+				 "Applying panel backlight quirk, brightness_mask: 0x%X\n",
+				 panel_backlight_quirk->brightness_mask);
 			caps->brightness_mask =
 				panel_backlight_quirk->brightness_mask;
+		}
 	}
 }
 
-- 
2.51.0



