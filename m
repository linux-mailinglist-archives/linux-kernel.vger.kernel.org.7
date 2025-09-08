Return-Path: <linux-kernel+bounces-806827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F1B49C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD663B4F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1572E8B83;
	Mon,  8 Sep 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OZr/evQk"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6042E7F22
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367178; cv=none; b=L4qgaV7BLNaTaMb0tg/W+1F5xJZuxzDeQjVZYgqkwF+AQMLgR8OqvkJr0sSbtCmvc5J3OpvL8Dd8i9WdI9heLJsfYX2g2oobb+HQFhyJgBV2zC1uiuN/Rx1nW5CZVzUO5fq6ve1yAaubf4ZUl28YTgybVzCtEHSKqBCEw2J+jAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367178; c=relaxed/simple;
	bh=z4OFjUiJ28sLLEJeWVcsIIgK74RwOu5pBvZa59T/zLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk82d/YzrMIFHuErU+OGyHeBmA9sL1FpJnup+ohibxRaJJiwaC1eVxbV060xzec8Rv0RD4Nn/+WpnmYvu3ox8AjHDvGEilrSVHJR5ZmMfNU06Onk0GBDwXchYYHfmfGMlHmW3sR/7+PoZa1CwCtbJHIT0hpHAv1R4Pjn692QGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OZr/evQk; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757367173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGwfNfXsEJt+uuuZOEIftwyyKCix/PrVNO8dS5i6p/8=;
	b=OZr/evQkrPMn26+Eu82p/06rJXNr1j9LyyGeiZYEqKtLkOiPaRfk6DOAHwDSbzqyHll1XT
	WyiuSsWs6Vgp6IV67vr0Psv8x6d/mH3T06524oV4LlVWDcVEnWDfNbsos6hKuOXEh5eQ8q
	5IcS3SL3xSvjV7rdZzSeAvuxOo0fJww=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Replace kzalloc + copy_from_user with memdup_user
Date: Mon,  8 Sep 2025 23:31:56 +0200
Message-ID: <20250908213156.565861-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kzalloc() followed by copy_from_user() with memdup_user() to
improve and simplify kfd_ioctl_set_cu_mask().

Return early if an error occurs and remove the obsolete 'out' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 828a9ceef1e7..5d58a7bf309a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -521,15 +521,10 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 		cu_mask_size = sizeof(uint32_t) * (max_num_cus/32);
 	}
 
-	minfo.cu_mask.ptr = kzalloc(cu_mask_size, GFP_KERNEL);
-	if (!minfo.cu_mask.ptr)
-		return -ENOMEM;
-
-	retval = copy_from_user(minfo.cu_mask.ptr, cu_mask_ptr, cu_mask_size);
-	if (retval) {
+	minfo.cu_mask.ptr = memdup_user(cu_mask_ptr, cu_mask_size);
+	if (IS_ERR(minfo.cu_mask.ptr)) {
 		pr_debug("Could not copy CU mask from userspace");
-		retval = -EFAULT;
-		goto out;
+		return PTR_ERR(minfo.cu_mask.ptr);
 	}
 
 	mutex_lock(&p->mutex);
@@ -538,7 +533,6 @@ static int kfd_ioctl_set_cu_mask(struct file *filp, struct kfd_process *p,
 
 	mutex_unlock(&p->mutex);
 
-out:
 	kfree(minfo.cu_mask.ptr);
 	return retval;
 }
-- 
2.51.0


