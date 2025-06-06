Return-Path: <linux-kernel+bounces-675706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75EAD01C1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEDC179FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335DC288511;
	Fri,  6 Jun 2025 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dk1hBAp8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A672874E7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211623; cv=none; b=naNxftE2SDw8OinPE9fZnsvfqGoLbzuWrcUsSSXP+lOkQmG6pnOtl3OFeZSOzwqRTwZZBK2IkCDljC1VpYJGtkS8d1KgeI+A3vI2SNj+rpSkiz3HndlLl/4Y1fytRV0nhZlUEuKLIZjcBRZhGXcmsO+D9Tudfkklp2l5dgHRQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211623; c=relaxed/simple;
	bh=jZhqw3CFkkpAqCC9nzOWg/77t51D878n8OcC+pjLft4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cau/mVHl1oU/waWKkASXvj06SqT201Pdszz6CRr/w2RscxUNkfMddBSFmnSexyBRugPb81FTIlhqqTKFHS/YUL2cVQ53PBWTUbeSJWqSqj9gLaM9Ih9nJwNP/wAylmNG84c41qXFKZpcFQX1PafQ+wy9DtpwUsC9x7ZQ2f2JnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dk1hBAp8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749211619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrjs5eOHCyu5GrbKeIZJ6mBciwCyDUhu9m4iaDSEfRE=;
	b=dk1hBAp8S+hkCP0lZSn7YvdpdWzdX2JugbeHOVNLs/Dn3cK08b9VCsOig0srjLzzkuTi/6
	Oraic979uAjJFGWZjE3pz1HDBnuRAUZI0WmpbvPrHMDrWBB2voFllKd+fRINlhGwAdczLV
	6LZ1DWOxwhL9ycmIThyqaBqzN7mXH9c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-hhQ4K7OCP1Wb_WyZHMZmRw-1; Fri,
 06 Jun 2025 08:06:56 -0400
X-MC-Unique: hhQ4K7OCP1Wb_WyZHMZmRw-1
X-Mimecast-MFC-AGG-ID: hhQ4K7OCP1Wb_WyZHMZmRw_1749211612
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FBF819560B3;
	Fri,  6 Jun 2025 12:06:52 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E186C18003FD;
	Fri,  6 Jun 2025 12:06:44 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v8 9/9] drm/i915/psr: Add intel_psr2_panic_force_full_update
Date: Fri,  6 Jun 2025 13:48:13 +0200
Message-ID: <20250606120519.753928-10-jfalempe@redhat.com>
In-Reply-To: <20250606120519.753928-1-jfalempe@redhat.com>
References: <20250606120519.753928-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When the panic handler is called, configure the psr to send the full
framebuffer to the monitor, otherwise the panic screen is only
partially visible.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v8:
 * Added in v8

 .../gpu/drm/i915/display/intel_atomic_plane.c |  7 +++++++
 drivers/gpu/drm/i915/display/intel_psr.c      | 20 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_psr.h      |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 8c422c6a7186..c9a9f0770205 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -58,6 +58,7 @@
 #include "intel_fb.h"
 #include "intel_fb_pin.h"
 #include "intel_fbdev.h"
+#include "intel_psr.h"
 #include "skl_scaler.h"
 #include "skl_universal_plane.h"
 #include "skl_watermark.h"
@@ -1319,6 +1320,7 @@ static unsigned int intel_4tile_get_offset(unsigned int width, unsigned int x, u
 static void intel_panic_flush(struct drm_plane *plane)
 {
 	struct intel_plane_state *plane_state = to_intel_plane_state(plane->state);
+	struct intel_crtc_state *crtc_state = to_intel_crtc_state(plane->state->crtc->state);
 	struct intel_plane *iplane = to_intel_plane(plane);
 	struct intel_display *display = to_intel_display(iplane);
 	struct drm_framebuffer *fb = plane_state->hw.fb;
@@ -1328,6 +1330,11 @@ static void intel_panic_flush(struct drm_plane *plane)
 
 	intel_bo_panic_finish(obj);
 
+	if (crtc_state->enable_psr2_sel_fetch) {
+		/* Force a full update for psr2 */
+		intel_psr2_panic_force_full_update(display, crtc_state);
+	}
+
 	/* Flush the cache and don't disable tiling if it's the fbdev framebuffer.*/
 	if (to_intel_framebuffer(fb) == intel_fbdev_framebuffer(display->fbdev.fbdev)) {
 		struct iosys_map map;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index db7111374293..283ac2618ea5 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2888,6 +2888,26 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	return 0;
 }
 
+void intel_psr2_panic_force_full_update(struct intel_display *display,
+					struct intel_crtc_state *crtc_state)
+{
+	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
+	u32 val = man_trk_ctl_enable_bit_get(display);
+
+	/* SF partial frame enable has to be set even on full update */
+	val |= man_trk_ctl_partial_frame_bit_get(display);
+	val |= man_trk_ctl_continuos_full_frame(display);
+
+	/* Directly write the register */
+	intel_de_write_fw(display, PSR2_MAN_TRK_CTL(display, cpu_transcoder), val);
+
+	if (!crtc_state->enable_psr2_su_region_et)
+		return;
+
+	intel_de_write_fw(display, PIPE_SRCSZ_ERLY_TPT(crtc->pipe), 0);
+}
+
 void intel_psr_pre_plane_update(struct intel_atomic_state *state,
 				struct intel_crtc *crtc)
 {
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index 0cf53184f13f..9b061a22361f 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -57,6 +57,8 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 				struct intel_crtc *crtc);
 void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
 					  const struct intel_crtc_state *crtc_state);
+void intel_psr2_panic_force_full_update(struct intel_display *display,
+					struct intel_crtc_state *crtc_state);
 void intel_psr_pause(struct intel_dp *intel_dp);
 void intel_psr_resume(struct intel_dp *intel_dp);
 bool intel_psr_needs_vblank_notification(const struct intel_crtc_state *crtc_state);
-- 
2.49.0


