Return-Path: <linux-kernel+bounces-771902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BC5B28CB5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3C33BE467
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71638252912;
	Sat, 16 Aug 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="O7kmjH7V"
Received: from sonic308-54.consmr.mail.gq1.yahoo.com (sonic308-54.consmr.mail.gq1.yahoo.com [98.137.68.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53611DEFE7
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755339171; cv=none; b=nkJFE+3Q+jgyLQNmGYS1VarLSTrIubrjvWnSZcO8oxgRWTGHp52iD2uvH7hP76xft67ER09a4HGh6lS4GIv41ZOAfNP3OGqxSouTcWGzi1GLm73xwgyxxtPw77Um3Yg18M2mOH0SW3uGdbFBk0DpZNNiz5ZOu5tFXSPNLm4FBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755339171; c=relaxed/simple;
	bh=n4f2NsMiZduDFjjevaKDh0cbo1ADEZnAKhEn4mmNxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=cXWDs8LOzLcjoWafTb+pbsl1GLZe2hMLLRgrsjVg9ZrehXA/mhqcj3pqbQplIc4GikhWuTbGY+hEyknLl2Z3f0nrqtESfSh/Yrkn/UM6/IEuOWPxjunasD5J2Wm+z0/zQ/kOUazIk3CkzSYX+PmEJGGc3jn6mwQwhw3uZwahwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=O7kmjH7V; arc=none smtp.client-ip=98.137.68.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1755339163; bh=7gxqdcxN0AzBeM7cAfWgrj5SzV0WMyhoCaO7bxfgfIg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=O7kmjH7VA66jcPKPFObi+7f0msscXBIbqLF1CWkXK0zKtxZ/PtH1lpjrDNB7GGQf9WS9sps3difdUb/oVIWjAjwledgTXuxKGzRLaCYl4SpnP56Hrc/86RYGZ8yHiSAKXEcakysfstoMGxtcqYf+djF/IU8g/59E42g5HJU1/OR/Kpy+6jDw7k5SZWOhzw17OK0VnsbgaXioiqYFhW6jSDB52/KgBDZNwLuPLL06x/2OZJh3j4xx2WqvrXahF+PRx8VRDOQccE+R5ZRDTz/VWaGt9KgzyQR6WfaSxDjbA2oHmde/N0hJmZ4X0U9H2z51hJ6qsUkukMMGLk0j4cJgeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755339163; bh=p7mzrofPjJVd29bJ2sf9fzwfYa42ktXesvSQUpjIEwO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=o45vvNiIDUlgCitAFnwiWMLAp7JAqKgPgLDyCXK2U/9/t1kygaqeb1yLBH0bRSMRnNyINHdJP7HawMd/tJYaDt7z1l7F052OZMehl3lEKA2PdPTU6/LoIm73zS0jH51YoX7TUumLcwW8UR90nQ85e7S1AAZVQniyE8tByGgNl8YzYxNdQ1I6U20zSiWn4oar6BmWsO1rCKffLsA9wyWI47YiH9LRvWC45YQnw/FMzDuWkQVdgrzQt6Gq6q7+/QsU16v0aDPDLXMc4WpTMXdHVHsXEw7Bh6FK8KOw8flCVVEFq4wMGfEBPUoz82I2Vyr5WF9TffY18s87YiBSNSTXWA==
X-YMail-OSG: XSMaCfkVM1mcr9BhaWhr91x.1XBMnUWGq4eiZDXPrbv54Tco5gR1KOEtKeBOCxy
 6HtrMSLsFXuux61J3Ay6jI3pfiyh9UXPKVIokT2ylE2nwumQZS_MR59VVyu5xx9U_5V.VTXVswFP
 SQXqao1X.1TiG5YPeKH662ALWduXoDcKmfprv88nTEhN55chg4wmZdg6.4NJcgWlP59JL5nwXFur
 ZKyp2BUKQcirrpr6aosCQybHnS28Q9k_JINNOEBNHZ.WxEqJwbetuiFAUPTTQU57uc74uNtFD2mY
 _8oJe5HUFzb5lMiLiWgDI4e_lL7CUifpsAH.G4qQ0ByBDEpzW.uK3y2jOsLU4RP6TA2.Q4yoYX99
 SmWeqlDnu_4OXKxoLADHbz00F8RSML2EAuEY_8wWVTvWdwjbDilYpHVePSwY.EhUTDwgYKJ.WJMR
 PVISxVlQjjV0pk03ypp9tRrGa.toN3Z6_fKlQ1nZVA8mAutftabkPaNSHhyVe3qR6mDTDCLfRgT5
 jTBg12lTVnpmyOKrTD7C7f5UB.xb94r3uuIwlxkfgaTga6gDvmim1T0oPLwuIf.w0hwCbhx7b_nT
 W1yHscmgM2BOM54_MflhXPxxVKxrM4IuLdmLCrjVq7h4uXchRhlF3kJL1JtqxdmVTZupgkOa1gFR
 syi60N2fxQQ1YOo0pJkrJPndjlefuaWT.2d_A1Gabndr0BhE1SJR6uFKxjQT2hxiJCUpaODis7li
 9A9KqLzqkQLbX3xVfRLRxhnKaR3FCqW5CYmnd5n5vBPyg43q5A8XQyoRDhxEPe6JMmz5XZNuqckT
 O5REt7HAHCvZauWV.r3_.qKtxQFkoAyy5pgQlgejgbqVxsJQ8bHLEkT5fRHvsXv3NqowVEXzBH9O
 WCr7GZ3sJeJCxPmjAGVuY_mLzPZaVZd4r4pCssP0WdnMcdcs8.vRzHEkuJTR4y8cyAGXuwzpxviM
 c3ws.x6Du86UoreYSwlhXCy5b.fbFDI1dFa7BBjW49d5sj0L3P1Gwm5C_i81hlheyltN.n2btWId
 eSkNUoOtrM505Jjg5WyxTsIsWIR3XwbYlPZmT_fcMaZEs41TsKX4g2EpnaICOJhZH2F9brskAivA
 WF4v4GHCZOsJFg9hKrc2e76QvYf8hOnnL3SlqbNhHgoC0pU1RxxZDuRKU8gSWPwZZkHys9iklTmt
 sFhQEclcNQReP.NeTnNnA5EOkG59O86wf.nb1O7jD89bZM9T3bvyi99tQpeXlSZdAeU3YFrYMMQ2
 pNm40W0.9Ftv89ysG0o1TWJJPDQrR.uM6AXtmSx.FmUaF8mHQze4KDZcKHMYiyjJnx_H06Rmd1qg
 y6LkUwVBVq2rNHahFK_H6vzVlZMptx7OiYB5tO1.3VV6ZD1GVuHJ9Qv16CZ6YfuXsWDXtrHnt6L5
 RLyrfF8y2TCO0pHXqHWpz5Ht.owgS8nfBynNMy_MqgESX8sKDHITjfe25fdgoFJLyRW2XaKiKAjo
 vnJ_yRHXbBXvcFttUL98hNowtCW4wpf5GKYQqtqxVmECojj8DW8UjvaHQPxYt9ZxBPYiHI9iVPZU
 hDGGU5Krzohj9wHsqgoKK_UYajrYJEBrG9Qr3LROStHtgr6CMiRu3FaocvKwDocZkqsmRSCVrshi
 woNgMvKHfAvKH.0ZXWPTKSuHeWTb.RQEVmf2Tukjx_kr77NvTPceQ_0NB22_7ZZleM9hiKiji9tx
 YqyLz9oYC6.2wd4y1QPHOOPYEJAtaLpMTGT1E1A57UBU8jinYpip7kNaXQKAr1PkotQVKwd4CuDK
 dv72Sfe8fiGgVeDM2eqNTj2mFppJTfTThj2IgRXXGuAu1GJyzhZyOXa7o62wi0llV_rkdzToDFFU
 ue434QYhNDSfAlBWv7dgGybxm6SaaO_IyPwLULuOY9XIi2NYaBgPWbzJKogq5FmqOEAcSoT7787D
 LmL6ra3e5XF1c2CkHRj_5EUElpnaRBngqQamR4pbUzjaMvqc8ywNwVdIJMWCrud1CAIEbR__76EL
 UnVyJCJ.Nie3XDN75G3YjyyznKGGY5U_8tR.AGg0tZBrGMgLEET6zzfqmFnPNtEEu1oUiCl_xth2
 y7nAURkr.1EuVzbxT2safS5QrMLkMT4VHjLvVb4ys0ZCO.pwppLpIOhlLcqijVWOuLplygcdDBYG
 EwRfZRhAkT6RoiYimX8VCFD8HOHjyqqmiPE8kiKFiCZ_pjA8vzZOxT2VP6aNxaybKz4saw0m2IYv
 d98ewgbeNroSW22hgH3jgh0vKV3n7Y9ldX1Gwoc8RNI.msYmV8YL9JtobEOysNYFyH5Jt_Y5YNg-
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 5269ba22-6304-47b4-b558-25f2da7a7f68
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Aug 2025 10:12:43 +0000
Received: by hermes--production-ir2-858bd4ff7b-xdmpn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 515232b4dc819035ee721930d93da332;
          Sat, 16 Aug 2025 10:02:34 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: Ruben Wauters <rubenru09@aol.com>,
	dri-devel@lists.fredesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/gud: Replace simple display pipe with DRM atomic helpers
Date: Sat, 16 Aug 2025 10:57:05 +0100
Message-ID: <20250816100223.5588-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250816100223.5588-1-rubenru09.ref@aol.com>

The simple display pipe is obsolete and the atomic helpers allow for
more control over the rendering process. As such, this patch replaces
the old simple display pipe system with the newer atomic helpers.

As the code is mainly the same, merely replaced with the new atomic
system, there should be no change in functionality.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
I have been able to test this now, having obtained the hardware, and it
works fine, though some other unrelated issues have popped up, which I
shall try and debug and address in other patches.

v2 changes:
- address review comments by reorganising gud_probe()
---
 drivers/gpu/drm/gud/gud_connector.c | 24 +++++-----
 drivers/gpu/drm/gud/gud_drv.c       | 52 +++++++++++++++++-----
 drivers/gpu/drm/gud/gud_internal.h  | 13 +++---
 drivers/gpu/drm/gud/gud_pipe.c      | 69 ++++++++++++++++++++---------
 4 files changed, 108 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index 0f07d77c5d52..75f404ec08b4 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -607,13 +607,16 @@ int gud_connector_fill_properties(struct drm_connector_state *connector_state,
 	return gconn->num_properties;
 }
 
+static const struct drm_encoder_funcs gud_drm_simple_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int gud_connector_create(struct gud_device *gdrm, unsigned int index,
 				struct gud_connector_descriptor_req *desc)
 {
 	struct drm_device *drm = &gdrm->drm;
 	struct gud_connector *gconn;
 	struct drm_connector *connector;
-	struct drm_encoder *encoder;
 	int ret, connector_type;
 	u32 flags;
 
@@ -681,20 +684,13 @@ static int gud_connector_create(struct gud_device *gdrm, unsigned int index,
 		return ret;
 	}
 
-	/* The first connector is attached to the existing simple pipe encoder */
-	if (!connector->index) {
-		encoder = &gdrm->pipe.encoder;
-	} else {
-		encoder = &gconn->encoder;
-
-		ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_NONE);
-		if (ret)
-			return ret;
-
-		encoder->possible_crtcs = 1;
-	}
+	gdrm->encoder.possible_crtcs = drm_crtc_mask(&gdrm->crtc);
+	ret = drm_encoder_init(drm, &gdrm->encoder, &gud_drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
 
-	return drm_connector_attach_encoder(connector, encoder);
+	return drm_connector_attach_encoder(connector, &gdrm->encoder);
 }
 
 int gud_get_connectors(struct gud_device *gdrm)
diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 5385a2126e45..65c3a83c4037 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -16,6 +16,7 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
@@ -289,7 +290,7 @@ static int gud_get_properties(struct gud_device *gdrm)
 			 * but mask out any additions on future devices.
 			 */
 			val &= GUD_ROTATION_MASK;
-			ret = drm_plane_create_rotation_property(&gdrm->pipe.plane,
+			ret = drm_plane_create_rotation_property(&gdrm->plane,
 								 DRM_MODE_ROTATE_0, val);
 			break;
 		default:
@@ -338,10 +339,30 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 	return 0;
 }
 
-static const struct drm_simple_display_pipe_funcs gud_pipe_funcs = {
-	.check      = gud_pipe_check,
-	.update	    = gud_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS
+static const struct drm_crtc_helper_funcs gud_crtc_helper_funcs = {
+	.atomic_check = drm_crtc_helper_atomic_check
+};
+
+static const struct drm_crtc_funcs gud_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.destroy = drm_crtc_cleanup,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_plane_helper_funcs gud_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = gud_plane_atomic_check,
+	.atomic_update = gud_plane_atomic_update,
+};
+
+static const struct drm_plane_funcs gud_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
 static const struct drm_mode_config_funcs gud_mode_config_funcs = {
@@ -350,7 +371,7 @@ static const struct drm_mode_config_funcs gud_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-static const u64 gud_pipe_modifiers[] = {
+static const u64 gud_plane_modifiers[] = {
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
@@ -567,12 +588,17 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 			return -ENOMEM;
 	}
 
-	ret = drm_simple_display_pipe_init(drm, &gdrm->pipe, &gud_pipe_funcs,
-					   formats, num_formats,
-					   gud_pipe_modifiers, NULL);
+	ret = drm_universal_plane_init(drm, &gdrm->plane, 0,
+				       &gud_plane_funcs,
+				       formats, num_formats,
+				       gud_plane_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
 		return ret;
 
+	drm_plane_helper_add(&gdrm->plane, &gud_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&gdrm->plane);
+
 	devm_kfree(dev, formats);
 	devm_kfree(dev, formats_dev);
 
@@ -582,7 +608,13 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		return ret;
 	}
 
-	drm_plane_enable_fb_damage_clips(&gdrm->pipe.plane);
+	ret = drm_crtc_init_with_planes(drm, &gdrm->crtc, &gdrm->plane, NULL,
+					&gud_crtc_funcs, NULL);
+
+	if (ret)
+		return ret;
+
+	drm_crtc_helper_add(&gdrm->crtc, &gud_crtc_helper_funcs);
 
 	ret = gud_get_connectors(gdrm);
 	if (ret) {
diff --git a/drivers/gpu/drm/gud/gud_internal.h b/drivers/gpu/drm/gud/gud_internal.h
index d6fb25388722..6152a9b5da43 100644
--- a/drivers/gpu/drm/gud/gud_internal.h
+++ b/drivers/gpu/drm/gud/gud_internal.h
@@ -15,7 +15,9 @@
 
 struct gud_device {
 	struct drm_device drm;
-	struct drm_simple_display_pipe pipe;
+	struct drm_plane plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
 	struct work_struct work;
 	u32 flags;
 	const struct drm_format_info *xrgb8888_emulation_format;
@@ -62,11 +64,10 @@ int gud_usb_set_u8(struct gud_device *gdrm, u8 request, u8 val);
 
 void gud_clear_damage(struct gud_device *gdrm);
 void gud_flush_work(struct work_struct *work);
-int gud_pipe_check(struct drm_simple_display_pipe *pipe,
-		   struct drm_plane_state *new_plane_state,
-		   struct drm_crtc_state *new_crtc_state);
-void gud_pipe_update(struct drm_simple_display_pipe *pipe,
-		     struct drm_plane_state *old_state);
+int gud_plane_atomic_check(struct drm_plane *plane,
+			   struct drm_atomic_state *state);
+void gud_plane_atomic_update(struct drm_plane *plane,
+			     struct drm_atomic_state *atomic_state);
 int gud_connector_fill_properties(struct drm_connector_state *connector_state,
 				  struct gud_property_req *properties);
 int gud_get_connectors(struct gud_device *gdrm);
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 8d548d08f127..6a0e6234224a 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -451,14 +451,15 @@ static void gud_fb_handle_damage(struct gud_device *gdrm, struct drm_framebuffer
 	gud_flush_damage(gdrm, fb, src, !fb->obj[0]->import_attach, damage);
 }
 
-int gud_pipe_check(struct drm_simple_display_pipe *pipe,
-		   struct drm_plane_state *new_plane_state,
-		   struct drm_crtc_state *new_crtc_state)
+int gud_plane_atomic_check(struct drm_plane *plane,
+			   struct drm_atomic_state *state)
 {
-	struct gud_device *gdrm = to_gud_device(pipe->crtc.dev);
-	struct drm_plane_state *old_plane_state = pipe->plane.state;
-	const struct drm_display_mode *mode = &new_crtc_state->mode;
-	struct drm_atomic_state *state = new_plane_state->state;
+	struct gud_device *gdrm = to_gud_device(plane->dev);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc = new_plane_state->crtc;
+	struct drm_crtc_state *crtc_state;
+	const struct drm_display_mode *mode;
 	struct drm_framebuffer *old_fb = old_plane_state->fb;
 	struct drm_connector_state *connector_state = NULL;
 	struct drm_framebuffer *fb = new_plane_state->fb;
@@ -472,17 +473,35 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
 	if (WARN_ON_ONCE(!fb))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!crtc))
+		return -EINVAL;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	mode = &crtc_state->mode;
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+
+	if (ret)
+		return ret;
+
+	if (!new_plane_state->visible)
+		return 0;
+
 	if (old_plane_state->rotation != new_plane_state->rotation)
-		new_crtc_state->mode_changed = true;
+		crtc_state->mode_changed = true;
 
 	if (old_fb && old_fb->format != format)
-		new_crtc_state->mode_changed = true;
+		crtc_state->mode_changed = true;
 
-	if (!new_crtc_state->mode_changed && !new_crtc_state->connectors_changed)
+	if (!crtc_state->mode_changed && !crtc_state->connectors_changed)
 		return 0;
 
 	/* Only one connector is supported */
-	if (hweight32(new_crtc_state->connector_mask) != 1)
+	if (hweight32(crtc_state->connector_mask) != 1)
 		return -EINVAL;
 
 	if (format->format == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
@@ -500,7 +519,7 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
 	if (!connector_state) {
 		struct drm_connector_list_iter conn_iter;
 
-		drm_connector_list_iter_begin(pipe->crtc.dev, &conn_iter);
+		drm_connector_list_iter_begin(plane->dev, &conn_iter);
 		drm_for_each_connector_iter(connector, &conn_iter) {
 			if (connector->state->crtc) {
 				connector_state = connector->state;
@@ -567,16 +586,19 @@ int gud_pipe_check(struct drm_simple_display_pipe *pipe,
 	return ret;
 }
 
-void gud_pipe_update(struct drm_simple_display_pipe *pipe,
-		     struct drm_plane_state *old_state)
+void gud_plane_atomic_update(struct drm_plane *plane,
+			     struct drm_atomic_state *atomic_state)
 {
-	struct drm_device *drm = pipe->crtc.dev;
+	struct drm_device *drm = plane->dev;
 	struct gud_device *gdrm = to_gud_device(drm);
-	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
-	struct drm_framebuffer *fb = state->fb;
-	struct drm_crtc *crtc = &pipe->crtc;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(atomic_state, plane);
+	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(atomic_state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
+	struct drm_framebuffer *fb = new_state->fb;
+	struct drm_crtc *crtc = new_state->crtc;
 	struct drm_rect damage;
+	struct drm_rect dst_clip;
+	struct drm_atomic_helper_damage_iter iter;
 	int ret, idx;
 
 	if (crtc->state->mode_changed || !crtc->state->enable) {
@@ -611,8 +633,15 @@ void gud_pipe_update(struct drm_simple_display_pipe *pipe,
 	if (ret)
 		goto ctrl_disable;
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &damage))
+	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		dst_clip = new_state->dst;
+
+		if (!drm_rect_intersect(&dst_clip, &damage))
+			continue;
+
 		gud_fb_handle_damage(gdrm, fb, &shadow_plane_state->data[0], &damage);
+	}
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
-- 
2.49.1


