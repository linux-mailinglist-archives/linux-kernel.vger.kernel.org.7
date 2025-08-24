Return-Path: <linux-kernel+bounces-783789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35900B33277
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE47B44162C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F223BD04;
	Sun, 24 Aug 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YEdH4iSv"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2015719B5A7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756065731; cv=none; b=e1fCXoiWnLHrHA8XpmT5ub0k5WToJGgVXVp/iOWzGJstMx9o7WFFJzmAvKQB/JsBAzkdkWL4w2a9lPwlrmvHrT5yCTgE7FsSHKdmuT4BTmKHLJQLBghSsdt2QvyBtJF9r40H/ec0KIms1yb/JPk2N66Hio8MvWooCD3VIc5I6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756065731; c=relaxed/simple;
	bh=1pSU8fFAMRUXWuonCBa1sIr7P1ZgFjVixztIe7yJLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVyuB2iW/0fNw+cKHLgEl2UCwpBH/V1FOpRigrNo/0unrYV5qvSv7XQP4UpXicoz5XP05uClavgRAUSAAtjqIquUIFpH1lD0D5DMKFKTLqzgzKgwEj6zqhsv7ufoG8C4T9xVxyj/EHVu4O6wc7xh79L8a+pEpGhXfrMNspli4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YEdH4iSv; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 5E582C55A2;
	Sun, 24 Aug 2025 23:02:07 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id B5A0EC54FE;
	Sun, 24 Aug 2025 23:02:06 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id F11F1206827;
	Sun, 24 Aug 2025 23:02:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756065726;
	bh=dqae/2e+OMsIT8IE3vrtZRe5m+RCu/Ifgcl+aQR9ZWY=; h=From:To:Subject;
	b=YEdH4iSvEKOoMRpMPc6DB42/4fjAEzTS/i2w1PqhVeaG0rGRVTtsqRRJfpy5R/Lra
	 uCLDVCF+KhmCPD6D71wTARvb4VSLZ01z8lHfkoeBTkeWNGuBAe0/wcgRERjbSjhQ8E
	 h7A0FAWSS69hQkrif1jOmG30IGsuzUWUYGhE+97jrD3GQxHYy67TbdOyfshVCziO8G
	 +x3gNMw2bYKO2caB4+upLcQyZv5TGZIQc5PdiXZu9k/YgMMWHnBRzYdbPqEqwrr3P+
	 YPFBxGIfSZkz64bOTAA73rlYV4ZISQPVKM2A9t3bPdl2WCNAPpxxiWyujdDvYndU/8
	 Dtp/WsNq3terw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:7200:c86a:8976:4786) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	philm@manjaro.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 2/5] drm: panel-backlight-quirks: Convert brightness quirk
 to generic structure
Date: Sun, 24 Aug 2025 22:01:59 +0200
Message-ID: <20250824200202.1744335-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824200202.1744335-1-lkml@antheas.dev>
References: <20250824200202.1744335-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175606572642.883186.2052347155776376294@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, the brightness quirk is limited to minimum brightness only.
Refactor it to a structure, so that more quirks can be added in the
future. Reserve 0 value for "no quirk", and use u16 to allow minimum
brightness up to 255.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 drivers/gpu/drm/drm_panel_backlight_quirks.c  | 41 ++++++++++---------
 include/drm/drm_utils.h                       |  7 +++-
 4 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd0e2976e268..4ad80ae615a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3612,11 +3612,11 @@ static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
 
 static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 {
+	const struct drm_panel_backlight_quirk *panel_backlight_quirk;
 	struct amdgpu_dm_backlight_caps *caps;
 	struct drm_connector *conn_base;
 	struct amdgpu_device *adev;
 	struct drm_luminance_range_info *luminance_range;
-	int min_input_signal_override;
 
 	if (aconnector->bl_idx == -1 ||
 	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
@@ -3656,9 +3656,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	else
 		caps->aux_min_input_signal = 1;
 
-	min_input_signal_override = drm_get_panel_min_brightness_quirk(aconnector->drm_edid);
-	if (min_input_signal_override >= 0)
-		caps->min_input_signal = min_input_signal_override;
+	panel_backlight_quirk =
+		drm_get_panel_backlight_quirk(aconnector->drm_edid);
+	if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
+		if (panel_backlight_quirk->min_brightness)
+			caps->min_input_signal =
+				panel_backlight_quirk->min_brightness - 1;
+	}
 }
 
 DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e7927b8f5ba3..a1f37267b85e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -201,7 +201,7 @@ bool edp_set_backlight_level_nits(struct dc_link *link,
 			return false;
 	} else if (link->backlight_control_type == BACKLIGHT_CONTROL_AMD_AUX) {
 		struct dpcd_source_backlight_set dpcd_backlight_set;
-		*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits;
+		*(uint32_t *)&dpcd_backlight_set.backlight_level_millinits = backlight_millinits | 3;
 		*(uint16_t *)&dpcd_backlight_set.backlight_transition_time_ms = (uint16_t)transition_time_in_ms;
 
 		uint8_t backlight_control = isHDR ? 1 : 0;
diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index b38b33e26ea5..702726c20ccc 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -8,23 +8,23 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
 
-struct drm_panel_min_backlight_quirk {
+struct drm_get_panel_backlight_quirk {
 	struct {
 		enum dmi_field field;
 		const char * const value;
 	} dmi_match;
 	struct drm_edid_ident ident;
-	u8 min_brightness;
+	struct drm_panel_backlight_quirk quirk;
 };
 
-static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks[] = {
+static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks[] = {
 	/* 13 inch matte panel */
 	{
 		.dmi_match.field = DMI_BOARD_VENDOR,
 		.dmi_match.value = "Framework",
 		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0bca),
 		.ident.name = "NE135FBM-N41",
-		.min_brightness = 0,
+		.quirk = { .min_brightness = 1, },
 	},
 	/* 13 inch glossy panel */
 	{
@@ -32,7 +32,7 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
 		.dmi_match.value = "Framework",
 		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x095f),
 		.ident.name = "NE135FBM-N41",
-		.min_brightness = 0,
+		.quirk = { .min_brightness = 1, },
 	},
 	/* 13 inch 2.8k panel */
 	{
@@ -40,12 +40,13 @@ static const struct drm_panel_min_backlight_quirk drm_panel_min_backlight_quirks
 		.dmi_match.value = "Framework",
 		.ident.panel_id = drm_edid_encode_panel_id('B', 'O', 'E', 0x0cb4),
 		.ident.name = "NE135A1M-NY1",
-		.min_brightness = 0,
+		.quirk = { .min_brightness = 1, },
 	},
 };
 
-static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_backlight_quirk *quirk,
-						  const struct drm_edid *edid)
+static bool drm_panel_min_backlight_quirk_matches(
+	const struct drm_get_panel_backlight_quirk *quirk,
+	const struct drm_edid *edid)
 {
 	if (!dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
 		return false;
@@ -57,39 +58,39 @@ static bool drm_panel_min_backlight_quirk_matches(const struct drm_panel_min_bac
 }
 
 /**
- * drm_get_panel_min_brightness_quirk - Get minimum supported brightness level for a panel.
+ * drm_get_panel_backlight_quirk - Get backlight quirks for a panel
  * @edid: EDID of the panel to check
  *
  * This function checks for platform specific (e.g. DMI based) quirks
  * providing info on the minimum backlight brightness for systems where this
- * cannot be probed correctly from the hard-/firm-ware.
+ * cannot be probed correctly from the hard-/firm-ware and other sources.
  *
  * Returns:
- * A negative error value or
- * an override value in the range [0, 255] representing 0-100% to be scaled to
- * the drivers target range.
+ * a drm_panel_backlight_quirk struct if a quirk was found, otherwise an
+ * error pointer.
  */
-int drm_get_panel_min_brightness_quirk(const struct drm_edid *edid)
+const struct drm_panel_backlight_quirk *
+drm_get_panel_backlight_quirk(const struct drm_edid *edid)
 {
-	const struct drm_panel_min_backlight_quirk *quirk;
+	const struct drm_get_panel_backlight_quirk *quirk;
 	size_t i;
 
 	if (!IS_ENABLED(CONFIG_DMI))
-		return -ENODATA;
+		return ERR_PTR(-ENODATA);
 
 	if (!edid)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	for (i = 0; i < ARRAY_SIZE(drm_panel_min_backlight_quirks); i++) {
 		quirk = &drm_panel_min_backlight_quirks[i];
 
 		if (drm_panel_min_backlight_quirk_matches(quirk, edid))
-			return quirk->min_brightness;
+			return &quirk->quirk;
 	}
 
-	return -ENODATA;
+	return ERR_PTR(-ENODATA);
 }
-EXPORT_SYMBOL(drm_get_panel_min_brightness_quirk);
+EXPORT_SYMBOL(drm_get_panel_backlight_quirk);
 
 MODULE_DESCRIPTION("Quirks for panel backlight overrides");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
index 15fa9b6865f4..82eeee4a58ab 100644
--- a/include/drm/drm_utils.h
+++ b/include/drm/drm_utils.h
@@ -16,7 +16,12 @@ struct drm_edid;
 
 int drm_get_panel_orientation_quirk(int width, int height);
 
-int drm_get_panel_min_brightness_quirk(const struct drm_edid *edid);
+struct drm_panel_backlight_quirk {
+	u16 min_brightness;
+};
+
+const struct drm_panel_backlight_quirk *
+drm_get_panel_backlight_quirk(const struct drm_edid *edid);
 
 signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
 
-- 
2.50.1



