Return-Path: <linux-kernel+bounces-771954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95442B28D2D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D58B06994
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E283A29E117;
	Sat, 16 Aug 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="ATX9vHOw"
Received: from sonic315-8.consmr.mail.gq1.yahoo.com (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062E29E10A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341757; cv=none; b=YmS28D5vjPvQwuL9ORebMT2OoT9JDtpzeuy/GrXcpG0HKwV5s9ijdh6/ErynyVZ0m8R7hGLaQrKmSsUWEGe8aE3rIqNk0fgWf0Tomb4M2JDUIx71B1S7IrchM6hwc3GnQzh34lEFoCro0TlH0+k6Gkplux/FMO0AQDjIVpMeysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341757; c=relaxed/simple;
	bh=n4f2NsMiZduDFjjevaKDh0cbo1ADEZnAKhEn4mmNxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=kd3O7XtHcCC5k77tEtj/CT/sGGxr8LyrsLvwmdJYBqsVEZIrjW10xBAfPVikz21E7QEOcQjUqHoUHaNEVIZRS/kJozEGifJhjIyQdxsKJo2vgKW4nlo2dfGwpZ/63YZ54Wg6+gXXlCkLMDe3e0JrhJwKKgCSotBuhQQ7XRkNaaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=ATX9vHOw; arc=none smtp.client-ip=98.137.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1755341755; bh=7gxqdcxN0AzBeM7cAfWgrj5SzV0WMyhoCaO7bxfgfIg=; h=From:To:Cc:Subject:Date:References:Resent-From:Resent-To:Resent-Cc:Resent-Date:From:Subject:Reply-To; b=ATX9vHOwpp+RJUc+I8fYZz5MBvyo4pQBM6/OJdjU7SAGhU+48wASHSBWG8/s1lO3aoeQ0Ui+yWBtvrvV6xxSkj61Cb3qjyFiQy6H8E9R4+X7ElC7ZrTSYueKUmi0IjNZNPUKKk0lz/kF018VMCfsXpgKpx3FcZPFgadhdVO+F64dIi/L4TMa9BE027JDJE7z49xhKV0yWIDQ3DaWYfYWE9TKJwM/zpnjSbKZps2ID7rZbKqPM7pYh+HYAuRhg14EhLHmZXvUz/VHBGtujBI8zNP86b04MJOlEbb3w+IbYTw3t7ehQXBR2nJlH6OfS/unJB3dVX3SYFDLJhdI9pF57A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755341755; bh=VCieZ1v/ixP2HPBUjUIYNPeSMVjelcgmAfQdC4CX5c1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YNs7y13d03Y3YNM07Tf8lVLW3DvFg7Uafm+aS8Pj4DNbO2ls/o239k0jX2PeXn1Qdjua31Uxr6nN+XaI6OWWJhxHWx8ipmzFLo2v+XkRAvIsbHZaEMOw0xbz/s+7z6YbSfLkOoV2kI7DT+42PmD93x/pskmeCXNCJF987abX5Blvo6Pkh9QD7njK5ZVnJ24p6N2CYokLRma4fr6bCxSPuL6k8V0s1Q4ta2KEkDgb2bPNzfmg2/6h1z62jos9uUCXQMycWWbmN37rIO/oFUu08Eh3W1kHqKp0o3WBakTARRbTFqqGdfxcxpBjcpP6LF10yubRiGO67sOzV/kwsfUCUg==
X-YMail-OSG: HEKtLc0VM1lJJzOo38XC05ISyBYnPpNlb_M.Cxt0IwtW_qv2x4Wz_Eur6pmUQTf
 F1Z500a7zDIETLqbwa4ZL2MK4OF5Ue7UgPms5piySgF.A9ctbCgVFfOf_ZsDLdnTH7gpd_5as9sH
 Rh_ZgSwSvG2jsoSwC8gsKrYMWDnis9hnvx4PXnPzBqDsLEp5TH.bmwULMrmRLv5Fu6YWXyHDpxzV
 q7PHThzmXNhZLt_.dlIznr8NFkd3n7KqlF74nyY4Ok.nSF8RwbXnTkwbIicty_aprUmx5u3nKq_P
 917lUKGydu4rwIm_evwIty2nH5oE8Zo2_o7jYFhqTjwd49Jrg1rIaj3XqA9hWVMj2x8lxlHBBRx9
 tHkuu0ZV6_rdNydIEzs1hbdmxk1S_FGnRe3n4f2FD__7DVctVFgtbxGRvb.edPfSG0QjsVqKt30l
 ivTsFfIm1fnOVycVLNCbF_kfEwKOkPftNPXYNTnCJ1IinCvNm27MEkhOs9_69z4M7J2mdDfmUO_s
 4.jMArNovvnSa.OhanGwg0uuUtBF5HAx52tTbUBn_VPuS8vhoe8hBHIO.YviAKIYBTIzh_kEqzfT
 3PelA03o42wm.qf9BUS.chKxW8v4uuUJ.iQlmhjk00jGktic4PUepRscGQEGciBJh0OodL0WXkdI
 hrpi7kiQy8Lbq9EtmsN68qy9xwISDuz1DgxjFLrvj9dFRPhqAHorubLmXHoXZm.MEyQFg841g1Kt
 yLpMKO3lT3IZrP.t4J1IBcTXLdTeMFV6mSpg8Gy.ey6d9zjNCfi.vOQ1diuxm4lPRV5JnNXqFyI3
 qUuHLUGSv5czmx_zGdRMVhzLSW6toGFHPLcQ08n8ql9AYtgVZNCC194FSrYfHuNYuuQUy.9EiZDk
 k6mKvDE4n7UA.1nb0_ZauKFb9A0qCL2njQsSaRPkqZYyVFI_Xw8awR_UFLqQ5Qo.KlFZAly.c18N
 iqjCcZm9PTBzQQaw8YwNKfqUKT3PadbDw9tLNNQeGexasJ_X0WPomNvh6Lh3SlWjC7c78V02eAaU
 VTu2.7YQOT08nXKYPdpAaeHSYK5x3c8VSl3TWgeKuiiwaDMDszy.ZyW0mYghK3zxUk7NGyDKF7XD
 FHFHgjChBUIHItBlcoVmr38Jxt9y6gjSYh22.weEW9_7EmflmbrUOcP1kuZWVGo3vV6bkilyingu
 HegLdfBcuvGKjvDjWv8pnT4M_wY1k2ExJSsf_NlIZHEPb1sohROazOBq1mrRsWMyoi0q4.9T3MfO
 HjT.LB4rqgvMAC0ez9fHEALj3geKuUjQ11M986WdoLHZDNH4yq4B3KH0p82ZIeIzP8Lp42EoJzH.
 drCJ.3.Be9F8BQu2ydTpqS91itzktJbBEtMQB2dRxfAxktQsicnx9DC_oE5.5xSgLS0yCdI12Uzs
 kA16o1hmMXFgwKD0EbBsHtr6Cnvg4OPzqsDptu_KUyqbffv_FoES8U_Yk_TsaBkrgNFDaybDIWqn
 wqVgUiqfK.OBYDUY1ep8SuzLoYesAUS4ijRMa0J1niiZHrFa5F6RfAhPcFlv3.Kg4loLH814N9x8
 wLRlGiHSFbYgBEYlMsS9QcWCeYqUQloE1WfsvvKnNrqquERotmpNkxBHWSI2IlA0nvF_VR1Bk0f_
 vaSMKTnf6_HSwBILDqsBAuqZq.mNRAHpBHQF_dGcfAut7W4EwVGnA5v0deyRURc0MOBGCCdmzCYp
 26iWrQjPi723hR3CO59Jq5UFA8wj.djjYenpzTUU9F650Tv4WOBDQDWGiP5zeC1NA55AoGMdKFe.
 GuQ8XOE.xIdH0Q1ZXzQf9RtCo_6AgXhZNhpdwn3K7bW7wlStZ53WYK7ECwnZlnlcm4bMNQPWOE11
 EzlqzJeK40bwkL1ec8X_x3Rv5DYXDn8pFUP9LLV6pOjkkpE2HlfcRgdQ95wB.W4E4AcpE9GH0XHS
 r7RseYPP4hfzP68sMqpfagS0XuX2ACcvUMv0vKXuiu3hlTIshnznahU22ppM6dVbWquA5UbNu2.y
 89oiKqjkoQtFYEX.2HyR8S8QnNGjU0wPXhDpiNRJ1ngUu5rm6tpWhPp6_437zBrTM2Sbz1oIb25y
 72waL3VXebRWJF8XtSvoSnklyEQ0jbc1nOKROjxJh02c.wh0PTgCyH4ZdsOCLZMNVQ9nNikXOq3j
 ftzv_77WnKPk49YQHpuPlmWG5kYVAxbFF7VzPWTyZqv39Hwaoykr_d2MLAi78qJBkCLIxOxsEhO1
 U1K9XzOPjgN2WjZOIynl5HruMvVQkzzBJaS8J8zcX8yXZsqodvlHKk38cf1Ptn3so.AQ-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 2f73373c-b06a-4340-b0bb-43fa8ce72c36
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Aug 2025 10:55:55 +0000
Received: by hermes--production-ir2-858bd4ff7b-kl7wg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 79b16d52b6854dae1b9dc575fd6b628c;
          Sat, 16 Aug 2025 10:15:22 +0000 (UTC)
Received: by hermes--production-ir2-858bd4ff7b-xdmpn (Yahoo Inc. Hermes
 SMTP Server) with ESMTPA ID 515232b4dc819035ee721930d93da332;          Sat,
 16 Aug 2025 10:02:34 +0000 (UTC)
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
Subject: [PATCH v2] drm/gud: Replace simple display pipe with DRM atomic
 helpers
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
Resent-From: Ruben Wauters <rubenru09@aol.com>
Resent-To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime
 Ripard	 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie	 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ingo
 Molnar	 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jani
 Nikula	 <jani.nikula@intel.com>, Jocelyn Falempe <jfalempe@redhat.com>
Resent-Cc: Ruben Wauters <rubenru09@aol.com>,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Resent-Date: Sat, 16 Aug 2025 11:15:20 +0100
Resent-Message-Id: <20250816105558.E283A29E117@smtp.subspace.kernel.org>

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


