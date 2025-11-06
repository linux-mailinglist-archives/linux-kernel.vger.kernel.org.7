Return-Path: <linux-kernel+bounces-888256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA0BC3A534
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AA43BB371
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEC2D7D2E;
	Thu,  6 Nov 2025 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f31j6KPC"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF812248B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425447; cv=none; b=ofmFnd1uBzQkr4daLHPc6rmtYEZ5wykYHiA7zibDvdZ8GoGluaoK9fqOv1FY1BLd2wNK6kTZm3A62l3yB6R4UmLkxDptrlW5jd/rPFjYsPktmApt8rugX3D/Pg6+vNPPEuXQ7AYanViL+dOGhM80y+aoevKcqyvY9r/bfldZqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425447; c=relaxed/simple;
	bh=lqyjLSx0XWTy8t8UkuUetFU64TthXg1749zqs2c7H98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RXO0fxW1yMyKB20/KhPF1yiBplOyuC/YpAKWxigBTXurWj74c1oKSbGeEH8Lp72DLgY59iKrLjtitQFfsiPaYjkJuqk5xlvBSHwqpZkRepHuincbfjzLzfscLzEFZqcRo2NBZO8dpyKr3xJMd0Zu7Q2XVrRIyztBZ9ZyMvhwCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f31j6KPC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eZ
	cNs7K6rSSxhYT2jEEBLel1lY6HCnSG/fN16y0ql4M=; b=f31j6KPCiXtnVZpW/h
	Yi8+gnoXvNREH8hgMtdXRRqUltXaMb9Zpn504q2sX6gcCuEKEmI1tNu8ZdZZIZxS
	GdOFcNwcvhs+q+9i/SvDd/kujvV4myh0O2auqSEsXgQB9svHU7ITcNKd6V8vWZOS
	nLlH2cyMl/FGvAZRvMIubDz3E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHlFQOegxp3zD6Bw--.55192S2;
	Thu, 06 Nov 2025 18:35:59 +0800 (CST)
From: oushixiong1025@163.com
To: Dave Airlie <airlied@redhat.com>
Cc: Sean Paul <sean@poorly.run>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2 RESEND] drm/udl: Increase GET_URB_TIMEOUT
Date: Thu,  6 Nov 2025 18:35:56 +0800
Message-Id: <20251106103556.111503-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHlFQOegxp3zD6Bw--.55192S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUtrWDtr4rAFW3Gw1xZrb_yoW8ZrWrpF
	srZ3yjyrWrtF4Dta17tFWvya43Aa13GFWkGrZ7Ga93u3Z0yFn8JrykAryYgFyUX3srCF1a
	qrs2vr909FW5Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uv385UUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYw-9D2kMc4KI2QAAsb

From: Shixiong Ou <oushixiong@kylinos.cn>

[WHY]
A situation has occurred where udl_handle_damage() executed successfully
and the kernel log appears normal, but the display fails to show any output.
This is because the call to udl_get_urb() in udl_crtc_helper_atomic_enable()
failed without generating any error message.

[HOW]
1. Increase GET_URB_TIMEOUT.
2. Add error messages when calling udl_get_urb() failed in
udl_crtc_helper_atomic_enable().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/udl/udl_main.c    | 2 +-
 drivers/gpu/drm/udl/udl_modeset.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index bc58991a6f14..dd9576fd4ff0 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -285,7 +285,7 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 	return unode->urb;
 }
 
-#define GET_URB_TIMEOUT	HZ
+#define GET_URB_TIMEOUT	(HZ * 2)
 struct urb *udl_get_urb(struct udl_device *udl)
 {
 	struct urb *urb;
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 231e829bd709..2df5bd291b0a 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -21,6 +21,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
@@ -342,8 +343,10 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
 		return;
 
 	urb = udl_get_urb(udl);
-	if (!urb)
+	if (!urb) {
+		drm_err_ratelimited(dev, "Get urb failed when enabling crtc\n");
 		goto out;
+	}
 
 	buf = (char *)urb->transfer_buffer;
 	buf = udl_vidreg_lock(buf);
-- 
2.25.1


