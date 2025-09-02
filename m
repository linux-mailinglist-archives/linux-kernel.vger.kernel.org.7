Return-Path: <linux-kernel+bounces-795844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27027B3F8A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0E73B2016
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265CF2EA737;
	Tue,  2 Sep 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBf7VqFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93F2EA727
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802014; cv=none; b=jEfpQ+FjArDGYh1neHzVHFf4HIsWVG5kUD7EfxJcGauIik0vTmIO0fUuCALPQxwiz0Gp7+JfnsXPMcciKHqv+JeAeZZGvSZZp0fI2vZ77tY4rVbn4Usa49BJNhU4kQLR1u/c2bIjz2tNElW6rWehlMt1rIhzoGuH3k1TZB1EKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802014; c=relaxed/simple;
	bh=tYWbhWVz7/WzG6D4UTlvcHo5uy6UD1fyI7Smwm5aU8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRBpMTJrxfpMt+e2cFv9ue7oQXidjKqGrwcFmU52FyLnQa8Woi4jqbpGUC8YRP31jlgrF5XsX1sIujE+2RwfjNMoUUgXGYVGufd8PLp68qf1L+hlD/4Kqng2HovMtQmFK9DVDQAaRit3PWFDfN4O7ufEKBtEZy5hEJLa86Ybvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBf7VqFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB198C4CEF5;
	Tue,  2 Sep 2025 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802014;
	bh=tYWbhWVz7/WzG6D4UTlvcHo5uy6UD1fyI7Smwm5aU8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RBf7VqFjkbBejKpgk+Q2+khPlQSWfhSitMYebCUh3qOFRDn+pIdlqBLKtYTc3DeqX
	 3PiWTDDioLHNGZ7XwGuF28p1EUGIM1IF0I5gSMaavdA08IZqHnjZppWm5OZP+MS7/Y
	 IuSi0aPDfP9G6yQ+fJiIwH/Ckox4KxRHFzX9teA9jwFDihfDwuM9FesJlbjeZsyGlR
	 9GWaWOMwGOqylV04i1wLmgV7T0AVZ92R3CYkm5dOyYn7oM7e8JzK7f6CQvpIne0oSK
	 R0goo72AilXhwLylUqhElTudPj2eGLuPQyrdJ8tvRew81LtZ6ds1mh0+RsFh2ZwsOM
	 GQSFcPFT3tfHA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:37 +0200
Subject: [PATCH 09/29] drm/modeset: Create atomic_reset hook
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-9-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tYWbhWVz7/WzG6D4UTlvcHo5uy6UD1fyI7Smwm5aU8k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVu8oULx40VtLxN/qj1Rva+Osx1/svhY1rfOQdazIk
 53RfFesYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEqZSxVmCDr5/x5uBgo9dy
 v07dzr3qzVynUPhf6dXjCfvvX+wyU02/UChg7bm4W9ZiinFk+glGxjqDhBL2dQZnOi9PYO7u35P
 /MPzPgZqUaYa5y43Df7PcsEx8feb3kS3PBG98zF18N+rv2iAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Since we're about to integrate some infrastructure to implement hardware
state readout, we need a way to differentiate between drivers wanting to
start from a pristine state, with the classic reset sequence, and
drivers that want to pickup their initial state from reading out the
hardware state.

To do so we can create an optional reset hook in
drm_mode_config_helper_funcs that will default to the classic reset
implementation, and can be setup to a helper we will provide in a later
patch to read the hardware state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_mode_config.c        | 32 +++++++++++++++++++++++---------
 include/drm/drm_modeset_helper_vtables.h | 13 +++++++++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 25f376869b3a41d47bbe72b0df3e35cad142f3e6..82180760032d3490d63fe83136465d2c26551d08 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -27,10 +27,11 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <linux/dma-resv.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -179,19 +180,11 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	drm_connector_list_iter_end(&conn_iter);
 
 	return ret;
 }
 
-/**
- * drm_mode_config_reset - call ->reset callbacks
- * @dev: drm device
- *
- * This functions calls all the crtc's, encoder's and connector's ->reset
- * callback. Drivers can use this in e.g. their driver load or resume code to
- * reset hardware and software state.
- */
-void drm_mode_config_reset(struct drm_device *dev)
+static void drm_mode_config_reset_pristine(struct drm_device *dev)
 {
 	struct drm_crtc *crtc;
 	struct drm_plane *plane;
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
@@ -213,10 +206,31 @@ void drm_mode_config_reset(struct drm_device *dev)
 	drm_for_each_connector_iter(connector, &conn_iter)
 		if (connector->funcs->reset)
 			connector->funcs->reset(connector);
 	drm_connector_list_iter_end(&conn_iter);
 }
+
+/**
+ * drm_mode_config_reset - call ->reset callbacks
+ * @dev: drm device
+ *
+ * This functions calls all the crtc's, encoder's and connector's ->reset
+ * callback. Drivers can use this in e.g. their driver load or resume code to
+ * reset hardware and software state.
+ */
+void drm_mode_config_reset(struct drm_device *dev)
+{
+	if (drm_core_check_feature(dev, DRIVER_ATOMIC)) {
+		const struct drm_mode_config_helper_funcs *funcs =
+			dev->mode_config.helper_private;
+
+		if (funcs && funcs->atomic_reset)
+			return funcs->atomic_reset(dev);
+	}
+
+	return drm_mode_config_reset_pristine(dev);
+}
 EXPORT_SYMBOL(drm_mode_config_reset);
 
 /*
  * Global properties
  */
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index ce7c7aeac887bb8438d73710f16071c97a851839..6d22a7676d6bf49fb78af4d0706bd91005cef186 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1561,8 +1561,21 @@ struct drm_mode_config_helper_funcs {
 	 * how one should implement this.
 	 *
 	 * This hook is optional.
 	 */
 	int (*atomic_commit_setup)(struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_reset:
+	 *
+	 * This hook is used to create the initial @drm_atomic_state.
+	 * It's used by drm_mode_config_reset().
+	 *
+	 * The default implementation will create an empty one, but
+	 * drivers can provide an alternative implementation to, for
+	 * example, read the initial state from hardware to implement
+	 * flicker-free and / or faster boot.
+	 */
+	void (*atomic_reset)(struct drm_device *dev);
 };
 
 #endif

-- 
2.50.1


