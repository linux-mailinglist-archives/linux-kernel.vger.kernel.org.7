Return-Path: <linux-kernel+bounces-699881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA24AE6091
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C01E19258D7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F627AC31;
	Tue, 24 Jun 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csIE7w58"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090127AC3D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756590; cv=none; b=QKetLJY9/hl7OMkL8e44a1pjI+cWNXA2QOY5tGSILw6nFax+Tr7/pWQqLViYJX4xHvCGH4m/sPVdq/zTpTJCpMETO0keKM57yu923zk6MV7M7SdcVOyLarVXFjsLNce7F+RxC6TX+V5jT/AfO4DdhIvcaQwubRCK+Id/cCdNgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756590; c=relaxed/simple;
	bh=wnAmQMdDCXoqlmWsgdw5/6clJy1HmczPLjoP8hR9Hf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+bX/3uT6U4I/mKwZCeUUIs/jabOi4+yXcTXHBArxNTAgsNpLIwBja01M3E76BdjApvqvhUSviR9mHDZLZpn9mJ3jp462s+zZavodmQNSZkzEuqHxKc4PSKPYWUUthDew3eCaH2Z17KldKi78kywXE19uJVaqsrPMJNcqUkZ7ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=csIE7w58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750756588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dRDMIDIXgLRACs+YNeHt5iGxZKlB+iTc2PU5xCf1s4A=;
	b=csIE7w58V3HmmytDCHIlsBGsKk3RiTiRFKSv2e62LK29/yiizojUdXbEEkw1rEdQvU49oB
	cWRw09Z+yqa/WX3eRLFwAe2xyGTx5t+qC4w0UAJkfXKvBrhMNAyaOLnYTNgW2wkWFRUWOS
	/JH+XWoQ9fCJjc9I24cqgKgUxLTYvLg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-K3Rms64wMO6CGw5KoDtXaw-1; Tue,
 24 Jun 2025 05:16:22 -0400
X-MC-Unique: K3Rms64wMO6CGw5KoDtXaw-1
X-Mimecast-MFC-AGG-ID: K3Rms64wMO6CGw5KoDtXaw_1750756580
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04FC71800368;
	Tue, 24 Jun 2025 09:16:20 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.224.209])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 679E218002B8;
	Tue, 24 Jun 2025 09:16:14 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
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
Subject: [PATCH v11 11/11] drm/i915/psr: Add intel_psr2_panic_force_full_update
Date: Tue, 24 Jun 2025 11:01:20 +0200
Message-ID: <20250624091501.257661-12-jfalempe@redhat.com>
In-Reply-To: <20250624091501.257661-1-jfalempe@redhat.com>
References: <20250624091501.257661-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When the panic handler is called, configure the psr to send the full
framebuffer to the monitor, otherwise the panic screen is only
partially visible.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v8:
 * Added in v8

 drivers/gpu/drm/i915/display/intel_plane.c |  7 +++++++
 drivers/gpu/drm/i915/display/intel_psr.c   | 20 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_psr.h   |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index f6b6704f77a1..cea27de26fca 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -58,6 +58,7 @@
 #include "intel_fb_pin.h"
 #include "intel_fbdev.h"
 #include "intel_plane.h"
+#include "intel_psr.h"
 #include "skl_scaler.h"
 #include "skl_universal_plane.h"
 #include "skl_watermark.h"
@@ -1320,6 +1321,7 @@ static unsigned int intel_4tile_get_offset(unsigned int width, unsigned int x, u
 static void intel_panic_flush(struct drm_plane *plane)
 {
 	struct intel_plane_state *plane_state = to_intel_plane_state(plane->state);
+	struct intel_crtc_state *crtc_state = to_intel_crtc_state(plane->state->crtc->state);
 	struct intel_plane *iplane = to_intel_plane(plane);
 	struct intel_display *display = to_intel_display(iplane);
 	struct drm_framebuffer *fb = plane_state->hw.fb;
@@ -1327,6 +1329,11 @@ static void intel_panic_flush(struct drm_plane *plane)
 
 	intel_bo_panic_finish(intel_fb);
 
+	if (crtc_state->enable_psr2_sel_fetch) {
+		/* Force a full update for psr2 */
+		intel_psr2_panic_force_full_update(display, crtc_state);
+	}
+
 	/* Flush the cache and don't disable tiling if it's the fbdev framebuffer.*/
 	if (intel_fb == intel_fbdev_framebuffer(display->fbdev.fbdev)) {
 		struct iosys_map map;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 8bee2f592ae7..73bdc54d7831 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2889,6 +2889,26 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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


