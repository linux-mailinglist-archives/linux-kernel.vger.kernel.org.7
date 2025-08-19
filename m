Return-Path: <linux-kernel+bounces-776357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFEB2CC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5CA1BC0144
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9050F322C6E;
	Tue, 19 Aug 2025 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jU6oEP/w"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C831194C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629215; cv=none; b=hcHwgY5RW2SMwu/5J8NwBZ4EzV3WWT+gvWBONLFeaVKaOkVCDXmaHq7iO7IbtjQHFEJFtrlY9TbN8Le1vmLrptFFwU9WXMFDQQRFZKSDXHuqQl76i/GFPrSjlmpgRpIZMyJWWZIejDUu6X+GYUKF1NdpZUP/i+pd1sSwGxp4Xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629215; c=relaxed/simple;
	bh=QhyJczObaejla3nbbnyc03F1aj08irtzVDq7oEDtXYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXkRehxgPwOxrhIR3nLZmyuVDVOvmNcjZ5rp5GLLStQhjcwqQ4dE9HAf4ovutZvPRFa9QEp6n0HrbnVnElyNQWu8OWVMG3FanLeBkPwf21tsZT6hcDMI1ACzgtOKK0I1BYn1bEeLVfkp/T6vaIybgPfIbBUU5U90W1od0ovPjN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jU6oEP/w; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 91819402837B;
	Tue, 19 Aug 2025 18:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 91819402837B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755629207;
	bh=hMndCnBPEkldaJ0RX8/Zz8eRCVkdzIYmV+68H1w9mS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jU6oEP/waAX+y+Jr/i3BD7LUay0wtlUB/wENTfdf6sj4htLNYNxBIxY5AWI7+JUdh
	 lmLlNJ2MdPquRUQH3DJoEAVj9nGw2NWh0Uqi1QslddVRgHwUAsEOpEzBu0LksX9BZm
	 HyZIDA4OvONLSN02UFgFtZmzbHrSFjfOLS5ydj7o=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 1/2] drm/modes: export drm_mode_remove() helper
Date: Tue, 19 Aug 2025 21:46:34 +0300
Message-ID: <20250819184636.232641-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819184636.232641-1-pchelkin@ispras.ru>
References: <20250819184636.232641-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This functionality may be helpful in drivers so export it for reusability.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/gpu/drm/drm_connector.c |  8 +-------
 drivers/gpu/drm/drm_modes.c     | 15 +++++++++++++++
 include/drm/drm_modes.h         |  1 +
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..0a3933b6ceec 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -27,6 +27,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_privacy_screen_consumer.h>
@@ -696,13 +697,6 @@ bool drm_connector_has_possible_encoder(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_connector_has_possible_encoder);
 
-static void drm_mode_remove(struct drm_connector *connector,
-			    struct drm_display_mode *mode)
-{
-	list_del(&mode->head);
-	drm_mode_destroy(connector->dev, mode);
-}
-
 /**
  * drm_connector_cec_phys_addr_invalidate - invalidate CEC physical address
  * @connector: connector undergoing CEC operation
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index e72f855fc495..6e021328f9c2 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -117,6 +117,21 @@ void drm_mode_probed_add(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_mode_probed_add);
 
+/**
+ * drm_mode_remove - remove a mode from the associated list and destroy it
+ * @connector: connector of the mode
+ * @mode: mode data
+ *
+ * Remove @mode from the associated list, then free @mode object itself.
+ */
+void drm_mode_remove(struct drm_connector *connector,
+		     struct drm_display_mode *mode)
+{
+	list_del(&mode->head);
+	drm_mode_destroy(connector->dev, mode);
+}
+EXPORT_SYMBOL(drm_mode_remove);
+
 enum drm_mode_analog {
 	DRM_MODE_ANALOG_NTSC, /* 525 lines, 60Hz */
 	DRM_MODE_ANALOG_PAL, /* 625 lines, 50Hz */
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index b9bb92e4b029..d7b66321f60d 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -460,6 +460,7 @@ int drm_mode_convert_umode(struct drm_device *dev,
 			   struct drm_display_mode *out,
 			   const struct drm_mode_modeinfo *in);
 void drm_mode_probed_add(struct drm_connector *connector, struct drm_display_mode *mode);
+void drm_mode_remove(struct drm_connector *connector, struct drm_display_mode *mode);
 void drm_mode_debug_printmodeline(const struct drm_display_mode *mode);
 bool drm_mode_is_420_only(const struct drm_display_info *display,
 			  const struct drm_display_mode *mode);
-- 
2.50.1


