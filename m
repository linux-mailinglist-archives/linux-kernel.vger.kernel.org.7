Return-Path: <linux-kernel+bounces-772141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A2B28F35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9455C7221
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882C5128819;
	Sat, 16 Aug 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GuGp/UQR"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BA1DFDE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358499; cv=none; b=lTmBTrIbkrjVU/PU0gtfdAwTZM6wGKyR/9aywr/vfIfh3/sNN4HVUODxok90NAoaTqFJ8X5GhX+p05TZqIMSe4PNRAd0s7HT0irR16KlNGvsbhIJvnNWYZX2peLTPUpynr8FvxlamVvILa96DIWzh4nnggIKhDIy/19axOOmVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358499; c=relaxed/simple;
	bh=/BTHMpSsxFGcGqLg97eEU1oQoEm9/K6s0g4iNQIQMS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+sjGg1lJ0yGdKfnr4nIHbY1bttU+hI3KEfJy+1AtjC5MftV4/yn5Ti2sMNbH8jk5x+gAcJjxbWt8k4k52+cfmDyp8lJTjNEcgFXSYPOKbYdevuRUWah21Sa2468SRxUM5ZGGvt5xCtRVOVjmklw9wN7CLovW1MR2xQIpx2LPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GuGp/UQR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D76A725C43;
	Sat, 16 Aug 2025 17:34:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d2qCjzOpWtkC; Sat, 16 Aug 2025 17:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755358487; bh=/BTHMpSsxFGcGqLg97eEU1oQoEm9/K6s0g4iNQIQMS0=;
	h=From:To:Cc:Subject:Date;
	b=GuGp/UQR1O1oOWkBU//Q+QGS4imjpSGNtAgoKNAluGxPBaR5PzlRSA0IQ4shCcRRP
	 ZM8tyG7AF39bjZ5DnAH3vW+OIIyqiy5EKeHIrZxAVHyN3aUIEpsR5kkjLEbbszq2CQ
	 qCM0WP6HDBWCIfqS/0pSoXgiEet1712LBMAF+s2ySpTUROa9wK9+Hd2tzHdf03Ujuk
	 q38x4QgXALj63fVZIzZV3wWIqt5jpPe+LEzWu0BfEKA7Yxxj7wfGXraW0oGKx5cycs
	 JIgZi0X708EizJqJkDYzhvOT6OTRietfdt8XbJySlz40oPwISGDWqUnr6xRpfy5PeS
	 7Q8kJwdP64eDw==
From: Yao Zi <ziyao@disroot.org>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/2] drm/vesadrm: Match framebuffer device by id instead of driver name
Date: Sat, 16 Aug 2025 15:34:29 +0000
Message-ID: <20250816153430.51235-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the driver matches the platform framebuffer device registered
by sysfb through driver name, "vesa-framebuffer", this is a little
confusing since this driver registers a DRM device, instead of a
framebuffer.

Moreover, we have a driver with the same name, enabled by
CONFIG_FB_VESA, that acts as a consumer of vesa-framebuffer as well.
They cannot be both loaded into the kernel.

Making these two drivers coexist is sometimes useful, e.g., a
distribution may want to build fbcon into the kernel image for debugging
purpose, but keep the whole DRM subsystem enabled as module. In such
case vesadrm could serve as a solution for running DRM-specific
userspace programs on platforms with only VESA VBIOS available.

Let's rename the driver as "vesa-display" to avoid possible confusion.
A platform_device_id table is introduced to match "vesa-framebuffer"
devices.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/gpu/drm/sysfb/vesadrm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 90615e9ac86b..16635dc3d5cc 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -3,6 +3,7 @@
 #include <linux/aperture.h>
 #include <linux/ioport.h>
 #include <linux/limits.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
 
@@ -517,10 +518,17 @@ static void vesadrm_remove(struct platform_device *pdev)
 	drm_dev_unplug(dev);
 }
 
+static const struct platform_device_id vesadrm_platform_id[] = {
+	{ "vesa-framebuffer" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, vesadrm_platform_id);
+
 static struct platform_driver vesadrm_platform_driver = {
 	.driver = {
-		.name = "vesa-framebuffer",
+		.name = "vesa-display",
 	},
+	.id_table = vesadrm_platform_id,
 	.probe = vesadrm_probe,
 	.remove = vesadrm_remove,
 };
-- 
2.50.1


