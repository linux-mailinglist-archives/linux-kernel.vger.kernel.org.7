Return-Path: <linux-kernel+bounces-783516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB3EB32E84
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FDB16804B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D0B25E80B;
	Sun, 24 Aug 2025 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="W2GlU1RH"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336C25C706
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025657; cv=none; b=H2ceAYBIPXJa877BIRqjIJ+wWfdM7w4n68qCh+gKJyZpRgsfEu2vdZaTfHmEuGGcj/zH4Qb/8LiIn9CjFXpsSI8cYtOEyaC9dP2+rl7XcegfGRHhW+OZwaAbrnqkqiaTk5HrXPq4r1Y7YkKDnA0e/dBU8ymQbag52h6PJ1TkEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025657; c=relaxed/simple;
	bh=loEqW1VDKb1UtZv/X94SbLQYATY2rlKcl1YgiGinMSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnTdxp5uVEqfTy2oSc8g63CLlOFVk+m+XCTlxRN7lwokiW1sOslSTG+dn2iKf+OdQLQZuapalbUY4Z4bd/M/ODd+iSt+3EJi1G4/O0a6HANEeBJpnFNZJUjjzcTeSQT2L/nKS2W4REYmXy5sGIOcjvCpB7EpsqT6fzq0FqcQEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=W2GlU1RH; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id C1ECCC32D6;
	Sun, 24 Aug 2025 11:54:04 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id DB5E7C32DD;
	Sun, 24 Aug 2025 11:54:03 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id EEA801FF5A2;
	Sun, 24 Aug 2025 11:54:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1756025643;
	bh=8cpURkRk8yYSfSPzQ4KDs1/FJn+BEsm4qZ0fH58uy+0=; h=From:To:Subject;
	b=W2GlU1RHA73/SFA15wFoHxXxbZ/e4LyRMQtzAyv6rSwe49pjRdCz2EqwLlCODpyMW
	 NmvURsFF0Bz8+sQCvInY3YJdpL6CwZVSF+vukqFlGw4/YYfp04k9UE4YZ3XnY0tQgU
	 ZJekGpzI4ebyK1b8xYkENDVvUrJJiUofB/mWdMCe3yoEdcxtiaohYfZmiY//Sj9KPZ
	 Ze4syuJTqfdVBeFhW6kZsRwAr37EBVjlEN3xqzeujIta/j3XEzQL6QUdUTddJiwcrO
	 CvknZ9XiHgCPgG+5kXwZQ3gMO+o2rJm4A5/VxNJQ4XbBwHNXAFgH9CewRvdSRtHj1n
	 tZHIjmhAcRObA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:7200:c86a:8976:4786) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Peyton Lee <peytolee@amd.com>,
	Lang Yu <lang.yu@amd.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 2/2] drm/amd/display: Adjust AUX brightness to be a
 granularity of 100
Date: Sun, 24 Aug 2025 10:53:51 +0200
Message-ID: <20250824085351.454619-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824085351.454619-1-lkml@antheas.dev>
References: <20250824085351.454619-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175602564355.2904469.15343362986595313099@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Certain OLED devices malfunction on specific brightness levels.
Specifically, when DP_SOURCE_BACKLIGHT_LEVEL is written to with
the minor byte being 0x00 and sometimes 0x01, the panel forcibly
turns off until the device sleeps again. This is an issue on
multiple handhelds, including OneXPlayer F1 Pro and Ayaneo 3
(the panel is suspected to be the same-1080p 7in OLED).

Below are some examples. This was found by iterating over brighness
ranges while printing DP_SOURCE_BACKLIGHT_LEVEL. It was found that
the screen would malfunction on specific values, and some of them
were collected.

Broken:
 86016:  10101000000000000
 86272:  10101000100000000
 87808:  10101011100000000
251648: 111101011100000000
251649: 111101011100000001

Working:
 86144:  10101000010000000
 87809:  10101011100000001
251650: 111101011100000010

The reason for this is that the range manipulation is too granular.
AUX is currently written to with a granularity of 1. Forcing 100,
which on the Ayaneo 3 OLED yields 400*10=4000 values, is plenty of
granularity and fixes this issue. Iterating over the values through
Python shows that the final byte is never 0x00, and testing over the
entire range with a cadence of 0.2s/it and 73 increments (to saturate
the range) shows no issues. Windows likewise shows no issues.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3803
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd0e2976e268..bb16adcafb88 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4739,7 +4739,8 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 }
 
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
-				unsigned int *min, unsigned int *max)
+				unsigned int *min, unsigned int *max,
+				unsigned int *multiple)
 {
 	if (!caps)
 		return 0;
@@ -4748,10 +4749,12 @@ static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 		// Firmware limits are in nits, DC API wants millinits.
 		*max = 1000 * caps->aux_max_input_signal;
 		*min = 1000 * caps->aux_min_input_signal;
+		*multiple = 100;
 	} else {
 		// Firmware limits are 8-bit, PWM control is 16-bit.
 		*max = 0x101 * caps->max_input_signal;
 		*min = 0x101 * caps->min_input_signal;
+		*multiple = 1;
 	}
 	return 1;
 }
@@ -4813,23 +4816,25 @@ static void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *cap
 static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 					uint32_t brightness)
 {
-	unsigned int min, max;
+	unsigned int min, max, multiple;
 
-	if (!get_brightness_range(caps, &min, &max))
+	if (!get_brightness_range(caps, &min, &max, &multiple))
 		return brightness;
 
 	convert_custom_brightness(caps, min, max, &brightness);
 
-	// Rescale 0..max to min..max
-	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
+	// Rescale 0..max to min..max rounding to nearest multiple
+	return rounddown(
+		min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max),
+		multiple);
 }
 
 static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 				      uint32_t brightness)
 {
-	unsigned int min, max;
+	unsigned int min, max, multiple;
 
-	if (!get_brightness_range(caps, &min, &max))
+	if (!get_brightness_range(caps, &min, &max, &multiple))
 		return brightness;
 
 	if (brightness < min)
@@ -4970,7 +4975,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	struct backlight_properties props = { 0 };
 	struct amdgpu_dm_backlight_caps *caps;
 	char bl_name[16];
-	int min, max;
+	int min, max, multiple;
 
 	if (aconnector->bl_idx == -1)
 		return;
@@ -4983,15 +4988,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	}
 
 	caps = &dm->backlight_caps[aconnector->bl_idx];
-	if (get_brightness_range(caps, &min, &max)) {
+	if (get_brightness_range(caps, &min, &max, &multiple)) {
 		if (power_supply_is_system_supplied() > 0)
 			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
 		else
 			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
 		props.max_brightness = max - min;
-		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-			caps->ac_level, caps->dc_level);
+		drm_dbg(drm,
+			"Backlight caps: min: %d, max: %d, ac %d, dc %d, multiple: %d\n",
+			min, max, caps->ac_level, caps->dc_level, multiple);
 	} else
 		props.brightness = props.max_brightness = MAX_BACKLIGHT_LEVEL;
 
-- 
2.50.1



