Return-Path: <linux-kernel+bounces-886216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C57EDC3501B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B79014E848F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE21BE871;
	Wed,  5 Nov 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eVffDEvv"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790B1A2392
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336862; cv=none; b=gHco7+X8bOzR+Z74pD+SP3lXe8ZOpjamubdsSvHZfgNExXBfF1L6RuBZjH9mTFRJqRXOGqZIpk+6qAjLGpp6GGxOwFuCMHbnMSHuBQco8oZm5jdpQ9fIYh10uMGbzs2lc+AQj3fgw51Ujl4f0eoStPXpv7S8B+F9IL4qEfkDL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336862; c=relaxed/simple;
	bh=JRcZdufUobS/wLUpkimw9bd/B/icJ/w+TWZhNQNNupc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r88cP1NEiv+/VyoQQT+58ZTgrzaO0yEdH4zgG6dPEG0EQkjwLARJE583yvRdYW2v2u2GABep7CsnYnXHk1/liXa9EdTpoM4fVQMyr4qYjgjwbg6G4yEo8r0IajS46vrN7K9SzW0Ef/fOB6LqqugplKkl08moegBWHupbOBrxg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eVffDEvv; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0o
	qYcgD1EzIirl58iMQvoqnGgi3NMDegKGUvdi6XerM=; b=eVffDEvvmZdfFpglg1
	qKPM8Qm5q/VGK4WqhFzeBgcTS2Hw7cKyq3TQ+HAKZQyJPlV9WhUeeBJntbB1rQSJ
	GvNj5xeSvoMmNl/oHqyrThIA8zdoJK4od1oz6tiOeKXjBTDuDRnBuKLk/HyjyWhH
	L1cmDGc0pbXmW4BCLLt4WUV/4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnqzQNIAtpg78HBw--.45341S2;
	Wed, 05 Nov 2025 17:59:42 +0800 (CST)
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
Subject: [PATCH] drm/udl: Increase GET_URB_TIMEOUT
Date: Wed,  5 Nov 2025 17:59:39 +0800
Message-Id: <20251105095939.293366-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnqzQNIAtpg78HBw--.45341S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUtrWDtr4rAFW3Gw1xZrb_yoW8ZryUpF
	47Z3yjyrWFyF4Dta17tFWvya43Aa13KFWkGrZ7Ca93u3WYyrn8JrykAFyYgFyUX3sxCF1a
	qrs2vr909FW5Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBrWwUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXBP8D2kLFJqbnwABsV

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
index 231e829bd709..647af04f194e 100644
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
+		DRM_ERROR("Udl get urb failed when enabling crtc");
 		goto out;
+	}
 
 	buf = (char *)urb->transfer_buffer;
 	buf = udl_vidreg_lock(buf);
-- 
2.25.1


