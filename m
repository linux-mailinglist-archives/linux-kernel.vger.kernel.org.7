Return-Path: <linux-kernel+bounces-803206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA4B45C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACE47C2498
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21831B80D;
	Fri,  5 Sep 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fXV2PKDT"
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC331B81C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085130; cv=none; b=gkVtfz9Q8F768k0GGQNoTNfudlOAuxM2Fl34tC6jRWa1CJlAg51DmTcSDfVRnbG8ONCm0h5DMuMhj4DX69A9K+hypo0JlYQwPYaepWIVQIgIIOKGkVxBchKW1j6f2YT6/qg874lQgYX3j67BadccemZPOxy/lkZM3fALUaLXxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085130; c=relaxed/simple;
	bh=ttrRBcRJHUGJsmpiYHMPJaoIp0vAv8EnpbZbJ4yyr/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kv8/J/7D5u/EjiqKFNUYgzrQD77JLoqAiCiF2L94qoFnLkabBsb2ggsv6HOsrMn7XlhcN4giRPXOhZ11/QgwQ+EtycwAwKL3Ti6kUgVk2X/32HAWKrG0rcpy9cnVvRHhwCQ3MrwFAOEI6QFc3xziv3IcyjXCOOBwNuK0xp4dUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fXV2PKDT; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21d9533d1;
	Fri, 5 Sep 2025 23:11:59 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] drm: Use kvmemdup/kvfree for EDID data
Date: Fri,  5 Sep 2025 15:11:56 +0000
Message-Id: <20250905151156.844758-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a991a6f34b303a1kunm694de830289b38
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQxlDVk0dTEhNSkJJGklOGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=fXV2PKDTt7nk7QveGxHQ/I8dtVQPfO0B2eT4t57TeRbc/m0jZlYpkdxswpkD3dZgORr/WVNBJy/Pe7Abx/SrWi8LB4ZW63mQyT/UqiCav/jqk/UhjKhjIgQvvAlf6w+9pIotIvVgXS8adZDCTFJkNkUampzFE4NuSYfnJyGBnb8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Rjrnbhz/j596PH/1yB3FKm4uksPxzdVSFHyF0AXryOg=;
	h=date:mime-version:subject:message-id:from;

The drm_edid_alloc() function uses kmemdup() to copy raw EDID data,
which can be loaded from firmware. A problem exists because the firmware
subsystem uses vfree() to release its data buffer. This implies the
buffer may be allocated with vmalloc() and can thus be larger than
kmalloc() typically supports. Since kmemdup() uses kmalloc() internally,
attempting to duplicate a large, vmalloc'd EDID buffer can lead to an
allocation failure.

To fix this mismatch and robustly handle EDID data of any size, this
patch replaces kmemdup() with kvmemdup(). The kvmemdup() function is
designed for this scenario, as it can safely handle a vmalloc'd source
and choose an appropriate allocator for the destination. The corresponding
free calls are therefore updated to kvfree().

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/gpu/drm/drm_edid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2e85345aa9a..97142bfc45ad 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2530,13 +2530,13 @@ const struct drm_edid *drm_edid_alloc(const void *edid, size_t size)
 	if (!edid || !size || size < EDID_LENGTH)
 		return NULL;
 
-	edid = kmemdup(edid, size, GFP_KERNEL);
+	edid = kvmemdup(edid, size, GFP_KERNEL);
 	if (!edid)
 		return NULL;
 
 	drm_edid = _drm_edid_alloc(edid, size);
 	if (!drm_edid)
-		kfree(edid);
+		kvfree(edid);
 
 	return drm_edid;
 }
@@ -2568,7 +2568,7 @@ void drm_edid_free(const struct drm_edid *drm_edid)
 	if (!drm_edid)
 		return;
 
-	kfree(drm_edid->edid);
+	kvfree(drm_edid->edid);
 	kfree(drm_edid);
 }
 EXPORT_SYMBOL(drm_edid_free);
-- 
2.34.1


