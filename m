Return-Path: <linux-kernel+bounces-791954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B3B3BEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206111C84252
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848C431B11B;
	Fri, 29 Aug 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ONQMKR8G"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D67321453
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479479; cv=none; b=En0mBoEcA3/24/mvIlZOZAu1kodRhxF3rbhz8ZTldwPsqmIl/0jaBQ/L9qA2Qk5yKiSKYljoCKOOCzSEWAnUeKsRG12iRYBk1IqqamNuIa6/TbvHm/ImK5dfn60lmyBYPl430lKvGoWEQaBl2w5pmTPPM6j18L8Z8NROcNs0dTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479479; c=relaxed/simple;
	bh=0nrxfGfyriairNvZDUn8/Z7E2udqUmp22tu8VMJ4sAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZsPiI/5JjzbT+7I8PKG7kKpNoQhSZLlWHyo194VO2ML3o85KZAhrglxmk+boA7a1wnSKbcjy1c304f2Ci7CveiO2ZB7dozt0/3rZnOtkzxUGw39Kwh/QtB8e6EiB2v862DZcDlfut9kwgDB4/VvGL8XNOE/IRLvWsYwJUvI0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ONQMKR8G; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 99C97BDDEA;
	Fri, 29 Aug 2025 17:57:50 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 67E89BDE02;
	Fri, 29 Aug 2025 17:57:49 +0300 (EEST)
Received: from antheas-z13 (x5996a855.customers.hiper-net.dk [89.150.168.85])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 8DB132018C3;
	Fri, 29 Aug 2025 17:57:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756479469;
	bh=AWOXbXinCzQ2Goffljex4rLLR3iTRPeFRtaMnsJKfCA=; h=From:To:Subject;
	b=ONQMKR8GLNse3Dxcvz2nsjPNyOWEHwqySq3KayZDiqzH0YGXvPjmTq1LRs0PaSqOW
	 MIxUDFZSdqPN9cPpvLyV5uN+bKTbyNTjqdZeoRwRtq5uepjpw+Zz+esn6K8gzNVmvb
	 IQaO7U/pNGEWgXi5m5nZA6MW18llw944UOBO2J6GOJypjSSf+fnnA/vdOvHUa/KDQs
	 nngV/nVjLW8vHoZpqqcKExwop5atm1gFvifk4J6KSJQSugaYYVfLTTm/ZwGtkLpziS
	 47qhxq5T3ovv+Ku8cYHYqJ2R4BaAClgJXsW/rWWasRN3DZLZohCHM+aFucHZn3y10v
	 KTK0PPykJJ4RQ==
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
Subject: [PATCH v3 4/6] drm: panel-backlight-quirks: Add brightness mask quirk
Date: Fri, 29 Aug 2025 16:55:39 +0200
Message-ID: <20250829145541.512671-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829145541.512671-1-lkml@antheas.dev>
References: <20250829145541.512671-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175647946909.278092.16277961246646507136@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Certain OLED devices malfunction on specific brightness levels.
Specifically, when DP_SOURCE_BACKLIGHT_LEVEL is written to with
the first byte being 0x00 and sometimes 0x01, the panel forcibly
turns off until the device sleeps again.

Below are some examples. This was found by iterating over brighness
ranges while printing DP_SOURCE_BACKLIGHT_LEVEL. It was found that
the screen would malfunction on specific values, and some of them
were collected.

Therefore, introduce a quirk where the minor byte of brightness is
OR'd with 0x03 to avoid the range of invalid values.

This quirk was tested by removing the workarounds and iterating
from 0 to 50_000 value ranges with a cadence of 0.2s/it. The
range of the panel is 1000...400_000, so the values were slightly
interpolated during testing. The custom brightness curve added on
6.15 was disabled.

 86016:  10101000000000000
 86272:  10101000100000000
 87808:  10101011100000000
251648: 111101011100000000
251649: 111101011100000001

 86144:  10101000010000000
 87809:  10101011100000001
251650: 111101011100000010

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3803
Tested-by: Philip Müller <philm@manjaro.org>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 +++
 drivers/gpu/drm/drm_panel_backlight_quirks.c  | 36 +++++++++++++++++++
 include/drm/drm_utils.h                       |  1 +
 4 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b967c6952e11..263f15f6fdea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3662,6 +3662,9 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		if (panel_backlight_quirk->min_brightness)
 			caps->min_input_signal =
 				panel_backlight_quirk->min_brightness - 1;
+		if (panel_backlight_quirk->brightness_mask)
+			caps->brightness_mask =
+				panel_backlight_quirk->brightness_mask;
 	}
 }
 
@@ -4862,6 +4865,10 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
+	/* Apply brightness quirk */
+	if (caps->brightness_mask)
+		brightness |= caps->brightness_mask;
+
 	/* Change brightness based on AUX property */
 	mutex_lock(&dm->dc_lock);
 	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b937da0a4e4a..60ce2ceb653a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -200,6 +200,11 @@ struct amdgpu_dm_backlight_caps {
 	 * @aux_support: Describes if the display supports AUX backlight.
 	 */
 	bool aux_support;
+	/**
+	 * @brightness_mask: After deriving brightness, OR it with this mask.
+	 * Workaround for panels with issues with certain brightness values.
+	 */
+	u32 brightness_mask;
 	/**
 	 * @ac_level: the default brightness if booted on AC
 	 */
diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 3d386a96e50e..2bdbd5583d32 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -45,6 +45,42 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.name = "NE135A1M-NY1",
 		.quirk = { .min_brightness = 1, },
 	},
+	/* Have OLED Panels with brightness issue when last byte is 0/1 */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "AYANEO",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "AYANEO 3",
+		.quirk = { .brightness_mask = 3, },
+	},
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ZOTAC",
+		.dmi_match_other.field = DMI_BOARD_NAME,
+		.dmi_match_other.value = "G0A1W",
+		.quirk = { .brightness_mask = 3, },
+	},
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ZOTAC",
+		.dmi_match_other.field = DMI_BOARD_NAME,
+		.dmi_match_other.value = "G1A1W",
+		.quirk = { .brightness_mask = 3, },
+	},
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ONE-NETBOOK",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "ONEXPLAYER F1Pro",
+		.quirk = { .brightness_mask = 3, },
+	},
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ONE-NETBOOK",
+		.dmi_match_other.field = DMI_PRODUCT_NAME,
+		.dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
+		.quirk = { .brightness_mask = 3, },
+	},
 };
 
 static bool drm_panel_min_backlight_quirk_matches(
diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
index 82eeee4a58ab..6a46f755daba 100644
--- a/include/drm/drm_utils.h
+++ b/include/drm/drm_utils.h
@@ -18,6 +18,7 @@ int drm_get_panel_orientation_quirk(int width, int height);
 
 struct drm_panel_backlight_quirk {
 	u16 min_brightness;
+	u32 brightness_mask;
 };
 
 const struct drm_panel_backlight_quirk *
-- 
2.51.0



