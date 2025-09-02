Return-Path: <linux-kernel+bounces-795849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3DB3F8A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D03516BCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1582E719B;
	Tue,  2 Sep 2025 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+u3l0zF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D72EAD18
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802027; cv=none; b=p5tGX6bma7XMyPhBz4KEJLlI3D5IkbiZcVsjfkY9UPh5qs8OHo5P6l/zbqyW81K+lyHx1YhNTakTPtKLRLLizrkgAhwaI9LH1ULrkS4rngCzdWHg1dm6WynAuYKxz88gdegRkl+mkyNNbyNKUvT2vfPE2m5JO8vP4oYpcUwg2yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802027; c=relaxed/simple;
	bh=IQtsJhSchjATXRgK9p3uG4wR8tQutxGjvOUIvX+cKZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mbW8RqxEAzbPS11PIXg15JRS/3wrTyxBMrPW+D1Q4iq59swx8bj5WsEX5vl68P4jZDQt7TTTjXfaIdBpcopyUVSD6o8NTZQ+21KhHTueEmnvgvjwkLfcSEnIJSWcuISLZomPNOjPvFVW7O1abh69d22FXywcdGfDZDBrkkneu3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+u3l0zF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA5FC4CEF7;
	Tue,  2 Sep 2025 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802027;
	bh=IQtsJhSchjATXRgK9p3uG4wR8tQutxGjvOUIvX+cKZo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q+u3l0zForMGuRP44Ds32HevJw+ZJ2jk0iCcXRyFR6FbpmcEKDLyTDsLOOV0r8uXW
	 RUBu2d0dkADn1atPP5n4c5GMbtPnkCHl+EPoEJYSUbxgMKKI/ZnSA6NxkAK0q6KBgs
	 dO8JiGeq1mIMzrylKfswggJPAGNySWkKm/Xo398751s2fCl6eaS6Urm+iA6Iv3+I0q
	 dFlNB4oOn4V/QZg9iyV9k2Nz0nHdLeL4Wbs9s09tFLBbzqvy+UPNRZOAcn4LzTeoJp
	 VG7HnWJLp2BAh3PdNL1InvWG6zn9NovUe5Zk2fT537Sz+z4D69kXxC/a3PFxfoh2bh
	 CCQL9pe0SxcFg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:42 +0200
Subject: [PATCH 14/29] drm/atomic_state_helper: Provide comparison macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-14-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10161; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IQtsJhSchjATXRgK9p3uG4wR8tQutxGjvOUIvX+cKZo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu+qvFV4Uj339kn1gOAv7hWBx6+wxm+93zQ9pXzXv
 fdvtGR0O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE7nkxNvy4/yKi9tzrEo0z
 ccxbvh84FBY6ravziOEDz8VBZZwX1nxjXSlzbmmJ+NZtzdO12t1zlzPWmcvOkL+RE/fSz4mnLNX
 stZap76/lHNXRHU7zPmhMmX3wGYPAocPdJ/ktu5TteTR29zcBAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

In order to make the implementation of atomic_compare_state easier and
reduce the boilerplate, this patch implements a bunch of macros to
compare values depending on their type.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  19 +++
 include/drm/drm_atomic_state_helper.h     | 218 ++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index b962c342b16aabf4e3bea52a914e5deb1c2080ce..78556e0c08d2fa84b16d70243ddd21617a322014 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -830,5 +830,24 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
 
 	__drm_atomic_helper_bridge_reset(bridge, bridge_state);
 	return bridge_state;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
+
+void __printf(4, 5)
+drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
+				       const char *name,
+				       const char *field,
+				       const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	drm_printf(p, "%s configuration mismatch in %s %pV\n", name, field, &vaf);
+
+	va_end(args);
+}
+EXPORT_SYMBOL(drm_atomic_helper_print_state_mismatch);
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index b9740edb26586d58f99a5223902bb8e333ac75a2..3c6ffa7122cf895f1eda09ec74c6537594d4aee3 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -22,19 +22,21 @@
  * Authors:
  * Rob Clark <robdclark@gmail.com>
  * Daniel Vetter <daniel.vetter@ffwll.ch>
  */
 
+#include <linux/string_choices.h>
 #include <linux/types.h>
 
 struct drm_atomic_state;
 struct drm_bridge;
 struct drm_bridge_state;
 struct drm_crtc;
 struct drm_crtc_state;
 struct drm_plane;
 struct drm_plane_state;
+struct drm_printer;
 struct drm_connector;
 struct drm_connector_state;
 struct drm_private_obj;
 struct drm_private_state;
 struct drm_modeset_acquire_ctx;
@@ -95,5 +97,221 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
 void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);
+
+void __printf(4, 5)
+drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
+				       const char *name,
+				       const char *field,
+				       const char *format, ...);
+
+#define STATE_CHECK_BOOL(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, bool),			\
+			      __stringify(name) " is not a bool");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %s, got %s", \
+							       str_yes_no(sa->f), \
+							       str_yes_no(sb->f)); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_DISPLAY_MODE(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, struct drm_display_mode), \
+			      __stringify(name) " is not a drm_display_mode structure"); \
+		if (!drm_mode_equal(&sa->f, &sb->f)) {			\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected " DRM_MODE_FMT ", got " DRM_MODE_FMT, \
+							       DRM_MODE_ARG(&sa->f), \
+							       DRM_MODE_ARG(&sb->f)); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_INFOFRAME(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, union hdmi_infoframe), \
+			      __stringify(name) " is not an hdmi_infoframe union"); \
+		if (memcmp(&sa->f, &sb->f, sizeof(union hdmi_infoframe))) { \
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "infoframes don't match"); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_FORMAT_INFO(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, const struct drm_format_info *), \
+			      __stringify(name) " is not a drm_format_info pointer"); \
+		if (sa->f != sb->f) {			\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %p4cc, got %p4cc", \
+							       &sa->f->format, \
+							       &sb->f->format); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_PROPERTY_BLOB(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, struct drm_property_blob *), \
+			      __stringify(name) " is not a drm_property_blob pointer"); \
+		if (sa->f != sb->f &&					\
+		    ((sa->f->length != sb->f->length) ||		\
+		     memcmp(sa->f->data, sb->f->data, sa->f->length))) { \
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "blobs don't match"); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_PTR(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %px, got %px",	\
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_S32(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (s32)0),		\
+			      __stringify(name) " is not an s32");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %u, got %u", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_S32_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (s32)0),		\
+			      __stringify(name) " is not an s32");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %x, got %x", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U16(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u16)0),		\
+			      __stringify(name) " is not a u16");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %u, got %u", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U32(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(name) " is not a u32");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %u, got %u", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U32_16_16(r, p, n, sa, sb, f)			\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(name) " is not a u32");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %d.%06u, got %d.%06u", \
+							       sa->f >> 16, ((sa->f && 0xffff) * 15625) >> 10, \
+							       sb->f >> 16, ((sb->f && 0xffff) * 15625) >> 10); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U32_X(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u32)0),		\
+			      __stringify(name) " is not a u32");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %08x, got %08x", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)
+
+#define STATE_CHECK_U64(r, p, n, sa, sb, f)				\
+	do {								\
+		static_assert(__same_type(sa->f, sb->f),		\
+			      __stringify(f) " field types don't match"); \
+		static_assert(__same_type(sa->f, (u64)0),		\
+			      __stringify(name) " is not a u64");	\
+		if (sa->f != sb->f) {					\
+			drm_atomic_helper_print_state_mismatch(p,	\
+							       n,	\
+							       __stringify(f), \
+							       "expected %llu, got %llu", \
+							       sa->f, sb->f); \
+			r = false;					\
+		}							\
+	} while (0)

-- 
2.50.1


