Return-Path: <linux-kernel+bounces-661652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30028AC2E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 11:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0533A14F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6F818787A;
	Sat, 24 May 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JScucoHv"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB68F6E;
	Sat, 24 May 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748078166; cv=none; b=AXH/kevmw2pH3V6STcJO84Q/nYE/4UFuevMoM1gJbFQsJsQqvhz3RRghcv0J/7RyXq9xj5rc1D7Rnehv9F6guCv7thIWUGDuA3NcLhf51j5Yr0qCwlN+F1hLyl57O53/MfRrVX+C4fr8UcAK1IozE15Wv37297ZdGKUppmFAOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748078166; c=relaxed/simple;
	bh=U5w7z1f+zwJd3WnPOJTamPbzkncIzBdmoD+MNuTBh4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K23/vM+0rxo/t5ki1Sem28kLK6VyoUZxeoh5UifLhANU9z+8qr0VhGTIggFzOYw3XUctaEY++XWeXd++MaE9TE4T/zb+nJYaxv5/evfWLJkpa3F7vnK85qESaMNFEGO5X4I+ozh7cmgJKjwHnIu6TLjQWJdem8CjO0MrFbl/gOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JScucoHv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fy
	7w/fOito6n1NlzBReuG43gvvfQ9OWKnvPxAA/UOtk=; b=JScucoHvnZtRgy0xv+
	O/K7g87oEEFMwTXNkrOhJ3KBI829BeF3k9gq4kt+8Kdglfz2u67IdAzDX1jaet4o
	LQy8GLqgTQ0dCxsT/wZkH29WAckYlBIfCrX8jPYfG1BUMvkVt58rFa3pQWYmM5r7
	/me8X+pkw6ZCG1sU/WSC/K96M=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnb_EljjFopvfQDg--.27292S4;
	Sat, 24 May 2025 17:15:19 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm: Fix potential null pointer dereference issues in drm_managed.c
Date: Sat, 24 May 2025 17:15:15 +0800
Message-Id: <20250524091515.3594232-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb_EljjFopvfQDg--.27292S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKrW5ur18KFWUWF1fCrg_yoWDtrX_C3
	W8Xrn3Wr4kCF98GF4qyw13ZryIka1DCFsYvF47tasayrW5Jr1vq34UZr45JryDWF1xuF9r
	u3WDAryfZrnrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqB9XbmgxhNn3egAAsH

Add check for the return value of kstrdup_const() in drm_managed.c
to prevent potential null pointer dereference.

Fixes: c6603c740e0e ("drm: add managed resources tied to drm_device")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/drm_managed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_managed.c b/drivers/gpu/drm/drm_managed.c
index cc4c463daae7..0ff8335a337b 100644
--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -151,6 +151,11 @@ int __drmm_add_action(struct drm_device *dev,
 	}
 
 	dr->node.name = kstrdup_const(name, GFP_KERNEL);
+	if (!dr->node.name) {
+		kfree(dr);
+		return -ENOMEM;
+	}
+
 	if (data) {
 		void_ptr = (void **)&dr->data;
 		*void_ptr = data;
@@ -236,6 +241,10 @@ void *drmm_kmalloc(struct drm_device *dev, size_t size, gfp_t gfp)
 		return NULL;
 	}
 	dr->node.name = kstrdup_const("kmalloc", gfp);
+	if (!dr->node.name) {
+		kfree(dr);
+		return NULL;
+	}
 
 	add_dr(dev, dr);
 
-- 
2.25.1


