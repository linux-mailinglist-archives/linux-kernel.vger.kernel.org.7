Return-Path: <linux-kernel+bounces-880941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEDC26F29
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F331E404CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDA2EC541;
	Fri, 31 Oct 2025 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPnixWrP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6C23AB8A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943541; cv=none; b=is1fQiUZIWKkKn2rOxoz/aqWiyT9+cW0s9Wv+HPerpfTC0glZm5/In/nNlXr2sXK+P/n8MpA1VlJGkrdn1Pr5hbkzct0bG4Gh35ccwf7ky+H4cthp07+Qo8Oau+Cuj5/IzSqy62Xa2xMmWGRpDmjp7xJ7MbHH8IeZP8YrC8rA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943541; c=relaxed/simple;
	bh=5YHJAk87/NOAzWLFPnKkI/liMGi3OyfkYzkVymNHNAQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CsQAwdv5ybADI0JsMmjmHaNAu+0jwh5ClZ2tli0VktpFoWr/TePubp4S+jVeUtbeJDOSLbKw7yRakEXJvmMj1lwe0banoPO441lRKSCUzA0cj+9U7DGAcEd5yHWj93wjKzlUTIdBofR506PQRr1Q/X8zECr5NX8+Ps8VeG6lkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sashamcintosh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPnixWrP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sashamcintosh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7864a6e392fso16814347b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761943539; x=1762548339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dAFZN1qzmVhhaKz6NVC3iiBzUvV2f7Uo61GpVfWUGSI=;
        b=CPnixWrPL21BHmfDiAjR9SQu7Gt26wifh/xgHZFpc3mIZiDma5zxoqGOPdQSdxIowx
         lO5CMeHUWQpOccZFw313rWFNlycQY28ylF06/ijLz9kRMZUmHR8P/psK10ab8DDHu6Mp
         STiBFjko7hj0Lb1sJLTkkIVpJuI+KolmxU0QQb0os9SpLdQi8IC4j2cQJNs9vwdpFEog
         7NbUCtDDBUHzrNulWksNyICex5lslU4wLSk+7qphS+TT+fUz5w3waaSYcXDEIwC0CFxu
         rvEI8t0enmn5KytJ40f5MOQm11UQuro33UEw7oGS3da61Ox+DDZ8x9MTmo+mobIZCW3m
         PIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761943539; x=1762548339;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAFZN1qzmVhhaKz6NVC3iiBzUvV2f7Uo61GpVfWUGSI=;
        b=j6OKN6uqFKdHh98/zu0jnPZ4sa4UezYCt578nyV4z3n73nBtchq/saN5JU1KKZW1Rz
         tbz2u9i/hmgjIZrkegB/L3/LEUPDnr1GpWEy4fYkPbeKPfuvcWkyXpEPX7x5I51ctOXl
         w1mFzrkPFL8X2VV6d0+/IYzIGVw3GpU51iTneft81gZXyrGru8nexvvKXMMViMyL/lTI
         lvuggoLxjuT/H9c/NCNGt45w7GwRisQxWlp0IMF6gJ/ZJK3c4G13ElXKg+wFx33vkId+
         eNc2Z4R5OMNtWvtzNNJPp1iIUUlCQPpaG6Y1iwfIHn+JHohonxaNJypM2VGiseSSFn1i
         ZonQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhEhrncT8t+Ou/lpMbHijJSpa80aBBvTAK81ol/OInp+G6X2sYREvd0Q7IFALePJ4LHt++h9L1CfRNz+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCFkeFt7kyX6FiOdNRwt5DfcXCfU3Emzspay+j0nhkuApG2Lw
	qoEmgLW3u91atnwQm3pGVJpZg5jHCnfApZd49AaWKslTCvpjYebyeUy/dIbdp+NCbYN3y0hbUJR
	uSnFYuSGCEFIjq+JH0fP1nYa13T9rQC1Pag==
X-Google-Smtp-Source: AGHT+IEkRglqY0knltuXPsTfhSVZFHRqw+oV9Ee7qClLBpsRzP1xsh0CriK/LzSnTmZ08nYFjF7zFGwiuiYXmqafGmJt
X-Received: from yxtc1.prod.google.com ([2002:a53:ab01:0:b0:63f:2d9a:652d])
 (user=sashamcintosh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:c4b:b0:63f:99b1:3a83 with SMTP id 956f58d0204a3-63f99b13cb8mr2553010d50.61.1761943538406;
 Fri, 31 Oct 2025 13:45:38 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:45:34 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031204534.659180-1-sashamcintosh@google.com>
Subject: [PATCH] drm: Add "min bpc" connector property
From: Sasha McIntosh <sashamcintosh@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, trivial@kernel.org, 
	Sasha McIntosh <sashamcintosh@google.com>
Content-Type: text/plain; charset="UTF-8"

[Why]
When playing HDR or WCG content, bandwidth constraints may force the
driver to downgrade to 6bpc, resulting in visual artifacts like banding.

Userspace should be able to configure a minimum allowed bpc.

[How]
Introduce the "min bpc" connector property so the user can limit the
minimum bpc. Mirror the "mac bpc" implementation.

Signed-off-by: Sasha McIntosh <sashamcintosh@google.com>
---
 drivers/gpu/drm/drm_atomic.c        | 12 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++
 drivers/gpu/drm/drm_atomic_uapi.c   |  4 +++
 drivers/gpu/drm/drm_connector.c     | 41 +++++++++++++++++++++++++++++
 include/drm/drm_connector.h         | 20 ++++++++++++++
 5 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index be2cb6e43cb0..f85ad9c55e69 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -468,6 +468,17 @@ static int drm_atomic_connector_check(struct drm_connector *connector,
 	state->max_bpc = info->bpc ? info->bpc : 8;
 	if (connector->max_bpc_property)
 		state->max_bpc = min(state->max_bpc, state->max_requested_bpc);
+	if (connector->min_bpc_property)
+		state->min_bpc = state->min_requested_bpc;
+	if (connector->max_bpc_property && connector->min_bpc_property &&
+	    state->max_requested_bpc < state->min_requested_bpc) {
+		drm_dbg_atomic(connector->dev,
+			       "[CONNECTOR:%d:%s] max bpc %d < min bpc %d\n",
+			       connector->base.id, connector->name,
+			       state->max_requested_bpc,
+			       state->min_requested_bpc);
+		return -EINVAL;
+	}
 
 	if ((connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) || !writeback_job)
 		return 0;
@@ -1195,6 +1206,7 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
 	drm_printf(p, "\tinterlace_allowed=%d\n", connector->interlace_allowed);
 	drm_printf(p, "\tycbcr_420_allowed=%d\n", connector->ycbcr_420_allowed);
 	drm_printf(p, "\tmax_requested_bpc=%d\n", state->max_requested_bpc);
+	drm_printf(p, "\tmin_requested_bpc=%d\n", state->min_requested_bpc);
 	drm_printf(p, "\tcolorspace=%s\n", drm_get_colorspace_name(state->colorspace));
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 5a473a274ff0..75659d46c6fe 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -736,6 +736,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 			if (old_connector_state->max_requested_bpc !=
 			    new_connector_state->max_requested_bpc)
 				new_crtc_state->connectors_changed = true;
+
+			if (old_connector_state->min_requested_bpc !=
+			    new_connector_state->min_requested_bpc)
+				new_crtc_state->connectors_changed = true;
 		}
 
 		if (funcs->atomic_check)
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 85dbdaa4a2e2..f99649f9c51f 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -776,6 +776,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 						   fence_ptr);
 	} else if (property == connector->max_bpc_property) {
 		state->max_requested_bpc = val;
+	} else if (property == connector->min_bpc_property) {
+		state->min_requested_bpc = val;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		state->privacy_screen_sw_state = val;
 	} else if (property == connector->broadcast_rgb_property) {
@@ -861,6 +863,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = 0;
 	} else if (property == connector->max_bpc_property) {
 		*val = state->max_requested_bpc;
+	} else if (property == connector->min_bpc_property) {
+		*val = state->min_requested_bpc;
 	} else if (property == connector->privacy_screen_sw_state_property) {
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..2d9cfd4f5118 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1699,6 +1699,13 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  *	drm_connector_attach_max_bpc_property() to create and attach the
  *	property to the connector during initialization.
  *
+ * min bpc:
+ *	This range property is used by userspace to set a lower bound for the bit
+ *	depth. When used the driver would set the bpc in accordance with the
+ *	valid range supported by the hardware and sink. Drivers to use the function
+ *	drm_connector_attach_min_bpc_property() to create and attach the
+ *	property to the connector during initialization.
+ *
  * Connectors also have one standardized atomic property:
  *
  * CRTC_ID:
@@ -2845,6 +2852,40 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
 
+/**
+ * drm_connector_attach_min_bpc_property - attach "min bpc" property
+ * @connector: connector to attach min bpc property on.
+ * @min: The minimum bit depth supported by the connector.
+ * @max: The maximum bit depth supported by the connector.
+ *
+ * This is used to add support for limiting the bit depth on a connector.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
+ */
+int drm_connector_attach_min_bpc_property(struct drm_connector *connector,
+					  int min, int max)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+
+	prop = connector->min_bpc_property;
+	if (!prop) {
+		prop = drm_property_create_range(dev, 0, "min bpc", min, max);
+		if (!prop)
+			return -ENOMEM;
+
+		connector->min_bpc_property = prop;
+	}
+
+	drm_object_attach_property(&connector->base, prop, min);
+	connector->state->min_requested_bpc = min;
+	connector->state->min_bpc = min;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_attach_min_bpc_property);
+
 /**
  * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADA" property
  * @connector: connector to attach the property on.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d..7581f965b015 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1126,12 +1126,24 @@ struct drm_connector_state {
 	 */
 	u8 max_requested_bpc;
 
+	/**
+	 * @min_requested_bpc: Connector property to limit the minimum bit
+	 * depth of the pixels.
+	 */
+	u8 min_requested_bpc;
+
 	/**
 	 * @max_bpc: Connector max_bpc based on the requested max_bpc property
 	 * and the connector bpc limitations obtained from edid.
 	 */
 	u8 max_bpc;
 
+	/**
+	 * @min_bpc: Connector min_bpc based on the requested min_bpc property
+	 * and the connector bpc limitations obtained from edid.
+	 */
+	u8 min_bpc;
+
 	/**
 	 * @privacy_screen_sw_state: See :ref:`Standard Connector
 	 * Properties<standard_connector_properties>`
@@ -2079,6 +2091,12 @@ struct drm_connector {
 	 */
 	struct drm_property *max_bpc_property;
 
+	/**
+	 * @min_bpc_property: Default connector property for the min bpc to be
+	 * driven out of the connector.
+	 */
+	struct drm_property *min_bpc_property;
+
 	/** @privacy_screen: drm_privacy_screen for this connector, or NULL. */
 	struct drm_privacy_screen *privacy_screen;
 
@@ -2482,6 +2500,8 @@ int drm_connector_set_orientation_from_panel(
 	struct drm_panel *panel);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
+int drm_connector_attach_min_bpc_property(struct drm_connector *connector,
+					  int min, int max);
 void drm_connector_create_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_provider(

base-commit: 098456f3141bf9e0c0d8973695ca38a03465ccd6
-- 
2.51.1.851.g4ebd6896fd-goog


