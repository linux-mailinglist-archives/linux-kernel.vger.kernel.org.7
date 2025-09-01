Return-Path: <linux-kernel+bounces-794765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047FDB3E6F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF26D444E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9883E341AD1;
	Mon,  1 Sep 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="nUPkkfdx";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="CMs9C6Mz"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A12340D8A;
	Mon,  1 Sep 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736578; cv=none; b=Q8AMMzfN4kKY5E+B3HHo4JMlnUs3bknpZbOA+ktcFOxVclKlFyrCQCEGl+7WFC34b8c3fJpuZaUYsYIjHfo176O4cOM7OvxaKHENRj0TTRmZiASpmKijhXGW/2KFHiw16eqYBdUtMcUeMF+ZGRjTlNU/aLGTXM5riodJDNgSV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736578; c=relaxed/simple;
	bh=k4MLOcFOhWHC/jwwxifpb5LwfdkCPYQ3GUc4Izfhqus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTOFncAFU4zEBLnjwouOiT7SyqOlFciUfLfF8txrFQwNfUnyJioal/tBFbfMkuXYmX0Sbd4wMpPHM7KcOlQYgnQ7oq8yJdpRUCRkKY2V+rycraJEtWjMdnD78endlb0WMKpkyYg80QaBiUpWCFqf42ZmB/JlXram7HPmPYtSyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=nUPkkfdx; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=CMs9C6Mz; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1756736568; bh=k4MLOcFOhWHC/jwwxifpb5LwfdkCPYQ3GUc4Izfhqus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nUPkkfdxOLR70g/lPMwFvKrXQq6khvw/5VsgM3CWRhntUnpVOY8Eq+d/UqMG8JERy
	 +Q7mZQ7wBkv0D/vVWxKesrHzn1yCpE7K2Qa+b+gsJOnZyO6xHreEDz7tHpNKD1sJKV
	 HTFZtmKW37F0xJUuJnHOi+eQ1O2zsqq7M4f0lIy9MyQl58p9VWfc0NsAwAFXJB8jYf
	 ysaEDUiUrPBv2exh0GQnqvbHL8ie9BvG8938ZitdFm4t7hB+ErLGvbWPb/76m+YacY
	 1ei/7eN80wXNK/lq5J62zGSIuMqADKLKyq25HUOXL1lxnytG63L4pMsqugLRj1CdRr
	 VthmYYmbC2j3g==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id A7C5EFB05;
	Mon,  1 Sep 2025 16:22:48 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeMZP9g2j7ej; Mon,  1 Sep 2025 16:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1756736562; bh=k4MLOcFOhWHC/jwwxifpb5LwfdkCPYQ3GUc4Izfhqus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CMs9C6Mz9R0W3SJCmdmtHeIHXT/EjwNE8dSAOzOc5Fl4ygKHsxNd1WmkKK0Eguqc6
	 fz/wdHn75gIZmAfT+sLZDJivBLb+B3/IscvyYdYrv/CO0e/MQ2jWGfmhxb+9NoUo8V
	 ljwMEhRwOyQZYX21/XtNRDt5kmuja9MvohyVdr3p4ryxkV3v/Jlma6yKxd3AsBSEvc
	 CeMOadlbdQ2moQWcYyK2hOQWRsbi9C5YsQjaHXNpSRwzG0FAbnbRzM4adJU0T2TiUi
	 XTqZ0+OqS84wGO4dh9U0kx/ryKPL6ynMVLTDVzInZ6eXwTBK4+CmPobvTgWZ8+4WvC
	 onJrJ1AoicK+A==
From: =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Date: Mon, 01 Sep 2025 16:22:08 +0200
Subject: [PATCH 3/3] drm/panel: visionox-rm69299: Add backlight support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250901-shift6mq-panel-v1-3-444b4abbfaea@sigxcpu.org>
References: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
In-Reply-To: <20250901-shift6mq-panel-v1-0-444b4abbfaea@sigxcpu.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3633; i=agx@sigxcpu.org;
 h=from:subject:message-id; bh=k4MLOcFOhWHC/jwwxifpb5LwfdkCPYQ3GUc4Izfhqus=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FJQVNXL2hsSksvT
 UhqQWNzbVlnQm90YXdySE9jS2hQUmc0RHhDT2lLUndaZ2dDZi9RCndpWWNwUGhzYW9RK1hDZEJ5
 TktKQWpNRUFBRUlBQjBXSVFSajlzemZsaUtkQ1NocktzTWx2NFpTU3Z6QjR3VUMKYUxXc0t3QUt
 DUkFsdjRaU1N2ekI0eUI5RC8wYlltYnFEcGdwU2hza0g5YURPNlpZaXVrZXJ2RnVERGpnVFNkYw
 o1dWZtOVdWN2pUeEFkbGJDYVUwWXNBSlZWWUlIODk2NThvQzIxcHNvOTJIYXJNVGhlZHdGZ21yO
 GhxSjQ1TklkCnluTXJHbW1qOVp5MzgwOEZXcE9CU3BJQnBRYlZwRC9iTVVpWUR2QStKSXkxbHdZ
 VWtoODJJVklmRm1SSFlkSW0KQUcwbDlxdFRNRzdSTEUybyt2WEVndXBYQVQ3VHg3Z0Juci9EeXE
 5Q0lZWk8xaEJNdGF1M2Q4UTlqMEFMNTczUQpkSkNxMmFKSkYwTnVQNzA5NWxXcFZSMjUwcjQ1R0
 pCbzFYTE9MUnlYUjRCVGd2Y2dES0FQYlN3ZU43U3I4L3dhCkR6dnh3NmYrRWRrdVN5RTVzMG01U
 kJKKzdFVHJLTUp1ZGRyeCtWakNOMEVyK3hjWkhCU0JOVXgrNkRSRzhscDUKWEhJL3EvNWg1WS9i
 WWhrbCtab21tTWdsSElPaGtRZWp2b0ZuUUdsekpNWFZxOGpueFpQbWZHZVZpaVRpYWVVZAphSTR
 XaE1PaW5yZGJtejRlNTVGSk9rT2x5ZDZrQnVZNkJvaW41eWZMYWZiZlV2dTZoK0FCaFQvYU9UZl
 lrOWhPCnVxazYrZjFqMFp1TzhSK080TVBUSWVkTTZYNzZZN1Vndng1Mk55ZUNRcU13ZWlwNnU4O
 EpwRmJHRVZTQzdLYUkKWU1rZG10VWlrcmYvemZhclQxRjNYNjZxcFFxZ1ZGV3A5dlFSMnNEOWNE
 RXpHNUJTWXduQVREeXBPWU83QVlWcApIbDBPNkdEc1FpbVdWdHNCVjBDdVZDU1RacTFkODFYZzZ
 oWlZOcXh6eGFsdFluMHI3Z0t5N0ZvMk53MDlNOUVsCmsreC9Bdz09Cj1NcDE1Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=agx@sigxcpu.org; a=openpgp;
 fpr=0DB3932762F78E592F6522AFBB5A2C77584122D3

The shift6mq's variant supports controlling the backlight via DSI
commands. Use that if a max_brightness is set in the device specific
data.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 2216d38366ea37368d15480f9d8a8ccbfe77ba3b..5e5ff6056c80e67a5bf8fe4911cdbc588db5d03b 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/backlight.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/property.h>
@@ -20,6 +21,8 @@ struct visionox_rm69299_panel_desc {
 	const struct drm_display_mode *mode;
 	const u8 *init_seq;
 	unsigned int init_seq_len;
+	int max_brightness;
+	int initial_brightness;
 };
 
 struct visionox_rm69299 {
@@ -285,6 +288,63 @@ static const struct drm_panel_funcs visionox_rm69299_drm_funcs = {
 	.get_modes = visionox_rm69299_get_modes,
 };
 
+static int visionox_rm69299_bl_get_brightness(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return brightness;
+}
+
+static int visionox_rm69299_bl_update_status(struct backlight_device *bl)
+{
+	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	u16 brightness = backlight_get_brightness(bl);
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct backlight_ops visionox_rm69299_bl_ops = {
+	.update_status = visionox_rm69299_bl_update_status,
+	.get_brightness = visionox_rm69299_bl_get_brightness,
+};
+
+static struct backlight_device *
+visionox_rm69299_create_backlight(struct visionox_rm69299 *ctx)
+{
+	struct device *dev = &ctx->dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = ctx->desc->initial_brightness,
+		.max_brightness = ctx->desc->max_brightness,
+	};
+
+	if (!ctx->desc->max_brightness)
+		return 0;
+
+	return devm_backlight_device_register(dev, dev_name(dev), dev, ctx->dsi,
+					      &visionox_rm69299_bl_ops,
+					      &props);
+}
+
 static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -316,6 +376,11 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
+	ctx->panel.backlight = visionox_rm69299_create_backlight(ctx);
+	if (IS_ERR(ctx->panel.backlight))
+		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
+				     "Failed to create backlight\n");
+
 	drm_panel_add(&ctx->panel);
 
 	dsi->lanes = 4;
@@ -353,6 +418,8 @@ const struct visionox_rm69299_panel_desc visionox_rm69299_shift_desc = {
 	.mode = &visionox_rm69299_1080x2160_60hz,
 	.init_seq = (const u8 *)visionox_rm69299_1080x2160_60hz_init_seq,
 	.init_seq_len = ARRAY_SIZE(visionox_rm69299_1080x2160_60hz_init_seq),
+	.max_brightness = 255,
+	.initial_brightness = 50,
 };
 
 static const struct of_device_id visionox_rm69299_of_match[] = {

-- 
2.51.0


