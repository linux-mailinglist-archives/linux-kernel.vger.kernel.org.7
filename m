Return-Path: <linux-kernel+bounces-869191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8FAC07412
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 462AC564FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C953375A6;
	Fri, 24 Oct 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="167ZcGQ2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6E27510B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322537; cv=none; b=GnOVKwCl1RAs0Ezt1bkq1UFiIm0Ze31U/rUZpo/YyQaVdS2DIbNzg7lQ6X9hZ9WrpTWJjbbtfW4Vv+D+LSZZI1TnDWQ754TeEJxxnyel4bADyXfhnT7dax/nsIW20orqzCMVc8X2w/t3eohV9jp1JpzW9QDZeDA4lmRoIcxcTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322537; c=relaxed/simple;
	bh=+WE2yaCBvv0vhU6XUeTaDLKoasG+BrjfNW7CpxBLw0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BrA76oVFuaVFMLqK4XqPqWEZ2tvZwHLJ2hSbfWhmxnpF/sapqlHQxN1Iz86tyY9cymn/hYdm5eIfOiUhuQLcW+bEXNgiqIHY/l7JHVVsISw9P1MP8XS7ahbTDaVY3DlraoEhKFmwwcbkeMSYaHL13hGciRjYsHg5PbkEuyLAXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=167ZcGQ2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761322536; x=1792858536;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+WE2yaCBvv0vhU6XUeTaDLKoasG+BrjfNW7CpxBLw0o=;
  b=167ZcGQ2CJxH8Uf858J1tsbcnpd+IAig3D8mpY0F/DDONIczYi7bpkG9
   QDjgzwKy5HQON3sk2LxuZzu/0C0LquXN7XSzYGcFYdi3EZfrOHm75zGEI
   dRQiUk6yGS6XAjZDbWMacSLHTX6bJoPORuVb+Fx60QA1PCjoR0zgJA9Ww
   JzSskCpARJDubz3XuBv+grUfvCzh8Z0KTIvA9TqWboh4P++G2MaN67vK9
   nEmlmmC4ZMkFRYkHVyooLeCzZ102PiHjM7BLZBFeC6xDPmrZOBx+7jdwQ
   +Uiukktfx2vMti1YidDA88ivRmPEXbxIe19s5v5vfboqXDJuhv+9sOrmI
   A==;
X-CSE-ConnectionGUID: 1/m7iX3mTEmbXSXQqSy26w==
X-CSE-MsgGUID: gFqR2CZcRIqCIPV5T+TIbQ==
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="279593471"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:15:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Fri, 24 Oct 2025 09:15:10 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 09:15:08 -0700
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Date: Fri, 24 Oct 2025 18:14:53 +0200
Subject: [PATCH 2/2] drm/atmel-hlcdc: fix use-after-free of drm_crtc_commit
 after release
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251024-lcd_fixes_mainlining-v1-2-79b615130dc3@microchip.com>
References: <20251024-lcd_fixes_mainlining-v1-0-79b615130dc3@microchip.com>
In-Reply-To: <20251024-lcd_fixes_mainlining-v1-0-79b615130dc3@microchip.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ludovic Desroches
	<ludovic.desroches@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2668;
 i=ludovic.desroches@microchip.com; h=from:subject:message-id;
 bh=+WE2yaCBvv0vhU6XUeTaDLKoasG+BrjfNW7CpxBLw0o=;
 b=owEBbQKS/ZANAwAKAT455hP3e2QtAcsmYgBo+6YFBLfw7N1TTb/DO1B9/4lSii4N6ky1uuH8r
 Hs6qa2nBeuJAjMEAAEKAB0WIQQAMEvJiWmsW41tNU0+OeYT93tkLQUCaPumBQAKCRA+OeYT93tk
 Le9cD/0eacpdfmN8iVYqUf+wNb8zjrsZIWzGqiT2ltRIFNCrBbn+Ki4fmP6EDc801970iuUtL+/
 XSaYWIuDOQ1cHUR92mSZ3MwcjZExj+m+5ZGdcgBcfFAoGNL/tjGYbc6aQAmGyQRaBzULrail+5Z
 qjO1a98e/PXbY6Tv0zX25galcMcrrmWe//dvfMLw03ZAzNgrlmPgdBeqqyGa5vTr6XXiu67X2Pd
 rfIsZNDCMY9ws9DdJHEKHYyU/SM0z77bO2BSQDSn4sMF2gvbKUOrRzC2/+a+DaDtWJYnZuCS27A
 +A0aFcxhwKHTD/138z23LiwKt0zA8wC+VKrrlRXr3+UzRONu+oY+TJ3B+72kILhpeNUjE4YAEZy
 /NEVDBXiEM1PmoufWhEZfJAfTcBz964p6BtQUhI6vWGXJWMGRlsNFmd20k6XAlRoBgXligyeeVI
 4YkU2Tw8bvOhMh3717mNhPL3dyLEjvud0JSDqdiKXssTfhIQMunQD/XYmxJpepVxAJa0I8BDsVe
 K9tEj0GnHvdrM/NlQebRr02yYrHV77/P7R/tVpRewar/XMrrQ93FyTDOgn0teXsUAV5zhXR6/zO
 DSP2L24ruR0T9DlxftdCT94vR76W4UtnqsfnY5lAm7jszPwzqOnMBtSzqw98jFB19ppno3VN8ti
 O9exvuRtqEigfSw==
X-Developer-Key: i=ludovic.desroches@microchip.com; a=openpgp;
 fpr=665BAA7297BE089A28B77696E332995F09DCC11A

The atmel_hlcdc_plane_atomic_duplicate_state() callback was copying
the atmel_hlcdc_plane state structure without properly duplicating the
drm_plane_state. In particular, state->commit remained set to the old
state commit, which can lead to a use-after-free in the next
drm_atomic_commit() call.

Fix this by calling
__drm_atomic_helper_duplicate_plane_state(), which correctly clones
the base drm_plane_state (including the ->commit pointer).

It has been seen when closing and re-opening the device node while
another DRM client (e.g. fbdev) is still attached:

=============================================================================
BUG kmalloc-64 (Not tainted): Poison overwritten
-----------------------------------------------------------------------------

0xc611b344-0xc611b344 @offset=836. First byte 0x6a instead of 0x6b
FIX kmalloc-64: Restoring Poison 0xc611b344-0xc611b344=0x6b
Allocated in drm_atomic_helper_setup_commit+0x1e8/0x7bc age=178 cpu=0
pid=29
 drm_atomic_helper_setup_commit+0x1e8/0x7bc
 drm_atomic_helper_commit+0x3c/0x15c
 drm_atomic_commit+0xc0/0xf4
 drm_framebuffer_remove+0x4cc/0x5a8
 drm_mode_rmfb_work_fn+0x6c/0x80
 process_one_work+0x12c/0x2cc
 worker_thread+0x2a8/0x400
 kthread+0xc0/0xdc
 ret_from_fork+0x14/0x28
Freed in drm_atomic_helper_commit_hw_done+0x100/0x150 age=8 cpu=0
pid=169
 drm_atomic_helper_commit_hw_done+0x100/0x150
 drm_atomic_helper_commit_tail+0x64/0x8c
 commit_tail+0x168/0x18c
 drm_atomic_helper_commit+0x138/0x15c
 drm_atomic_commit+0xc0/0xf4
 drm_atomic_helper_set_config+0x84/0xb8
 drm_mode_setcrtc+0x32c/0x810
 drm_ioctl+0x20c/0x488
 sys_ioctl+0x14c/0xc20
 ret_fast_syscall+0x0/0x54
Slab 0xef8bc360 objects=21 used=16 fp=0xc611b7c0
flags=0x200(workingset|zone=0)
Object 0xc611b340 @offset=832 fp=0xc611b7c0

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 0e38587b868d5b5375fcaa5c0508e8e5690d8ff8..91df1273eac71512109a822000448d7641171dca 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1196,8 +1196,7 @@ atmel_hlcdc_plane_atomic_duplicate_state(struct drm_plane *p)
 		return NULL;
 	}
 
-	if (copy->base.fb)
-		drm_framebuffer_get(copy->base.fb);
+	__drm_atomic_helper_plane_duplicate_state(p, &copy->base);
 
 	return &copy->base;
 }

-- 
2.51.0


