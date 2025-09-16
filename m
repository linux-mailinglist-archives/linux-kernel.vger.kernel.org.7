Return-Path: <linux-kernel+bounces-819614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB818B5A3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0FB3254C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECE323F46;
	Tue, 16 Sep 2025 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj8CimeS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571C30648F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056924; cv=none; b=bKXDTvF0kgOwPioCCT8+CBlmZnHXOB6/gA1EP1PAKkgbCoS8CRpC2Y3wrUYNM9tLgSfGmWQXtka8muGbvwz+w3GO4J4qYWECIGNHAkV+1RujzjpqE1mpGfQ40BEE05EgqS0GlWNnwK3Yr65xHxByNZ+E3w6h6zeBntenr9f4214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056924; c=relaxed/simple;
	bh=qY7msXy/MP9JfKkgO6BWwtHtUS96caUQxQ1g+mMIzak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIWMRSPi0tPTBuFcXTWw3CAut9eMiOrSl4h1SxaLmZq4zuKK/wlw5TZv4jQmrxRw10KfUIAcZY8GQblJafzCsmKCllTM1cKQcMn5FHKrZyf5uco53jPZLFGboiZf4buj+NxpDPNxqrKY7CZaPVEgRk5tEQUgOEGEKsF0ElbWgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj8CimeS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so4781978b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056922; x=1758661722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mKuDRdJJO0qDbnGjgA4rHMGy6EHP4eBLakbjsfvnkc=;
        b=Lj8CimeSFRfF1UChiy++u1Mi61Z6LHZNLmcisrs6UZWVKDPofR6vGCoTzmVk3xK5KR
         RDUyCpC44oK4tojPnSbob8jmo0KPsW1aUK1uckMCwEtVEHPxnS6fc17pHX350rP3J87b
         C7atIJiHAs0JhXiSyeagOzO8tx9cFFX8YRzSQGI9zXdcsdJi94Wb6o630pSyhga8+zHb
         tm1KebR0uZOKD0nNDW4JJbURnsHXj7i8Ba0A5IQX0JG2/zPXPyWuSQLsVYBvw+HfNxNv
         +qThq4GqwYTnZahFnegFQhfYaaF3Aci2iIwmQcypuomuCRhAFnFdxQbuYyZywPtJv+ML
         rGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056922; x=1758661722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mKuDRdJJO0qDbnGjgA4rHMGy6EHP4eBLakbjsfvnkc=;
        b=p/KGhNeQ8ffLrOteUgC5akDf30Ag4ijVcW7l7xgvdp/JvYpav3v2jcKu9Ts93r2vvr
         QIoJMMC5YKCb+WgB9wxPYWPUhdO1EL0A6CV2pGKZ7IBvAP9MCnPt2lZXrxisL5uJ1Oa3
         IUqo2/vtaQdy+yumYAyhxAjMpx57Ki00lfrQFO+isSZnxTA6NO+sLso9tW7OUPDZ2e+9
         c8BAFUbZf1y9JiVyaxVP3XgdMODwZiPlGhYTBZ/iy5cLtQola5jWUbATi9aVyuxH05Z9
         9aMFgQKFaKzJUbZJj6Ze8wzK/KxIjQRSypPbHrRqd1fMZM078Uu0re8dDdwk/EMdMCqD
         5LDg==
X-Forwarded-Encrypted: i=1; AJvYcCUN/K0OtzCj7njfCnLKLnhfv5EAHX4/MrNopG9wZGqp6vjGjdGlU7WfhGZ4anvhorkfiYQg7HBZ6vNTjkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGYcK4etluVQQjQyn3aN7xr17179Buk3bzLWMRmth7WTQuzmH
	4/UxWbFnimcI7JPD9BXRTg+93s8Y2xmSKr9YLGERLtQbfdBRi5toPMSl
X-Gm-Gg: ASbGnctgTVT87sOb5UBJ1DrwR9XKuj924l+GOPaJ9FqKPvAVElqogB5Dgke3Nkv3tPp
	WccmeW+NbQ1PvBqed4Qcq58iZtb4E1NT8D3F4yLoXi8OzdSGuDLIvwzUSHWTCu83otv4ggEgYis
	af3AkuIAJkjk9esofFdjb/gy6ymS9fmp2whAj+y5A9pPoSQc7G721HJwbjjpZKNaqf0sXGL+AIK
	Hz5IyeUgCTIk7jycKSwLVu16vJqoIKpnrMGm+0R9GWoE72jb4V/V1xxCAKvAYGeHIQZv3YEVJZZ
	MFImk+0BC2nOwTpAvB/hqSpN1vhOqhIXS3xnkKreY2UsGDJvgLJjyFuY4k/5R3aXz2gNwvh7Kqh
	X20GYdmRjroDqotFoJVV6/EL30vondPE0bHJMSzj8hlHMsLi3jzI58g1X5z7izqk2XLNrwe7FqI
	hMSbcQgudQ7LjikMnKiG+i
X-Google-Smtp-Source: AGHT+IEDixYIXoVhgvzO78eXbNMXUTFn5Eh7QdDPXuCG2AzTfJIo/tAuDVPaJEutqDntn6kKaRGWXA==
X-Received: by 2002:a05:6a20:728e:b0:243:f5ba:aa9c with SMTP id adf61e73a8af0-2602b084850mr22828169637.25.1758056921753;
        Tue, 16 Sep 2025 14:08:41 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607a48c19sm17032735b3a.36.2025.09.16.14.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:08:41 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] drm/panthor: simplify mmu_hw_flush_caches
Date: Tue, 16 Sep 2025 14:08:23 -0700
Message-ID: <20250916210823.4033529-11-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916210823.4033529-1-olvaffe@gmail.com>
References: <20250916210823.4033529-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify flush op to a bool to control whether LSC is
flushed/invalidated. Remove mmu_hw_do_operation helper.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 42 ++++++---------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 743e9342eece7..5418f079444ce 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -613,33 +613,20 @@ static void mmu_hw_cmd_unlock(struct panthor_device *ptdev, u32 as_nr)
  * @as_nr: AS to issue command to.
  * @iova: Start of the region.
  * @size: Size of the region.
- * @op: AS_COMMAND_FLUSH_*
+ * @flush_lsc: True if LSC should be flushed/invalidated.
  *
  * Issue LOCK/GPU_FLUSH_CACHES/UNLOCK commands in order to flush and
  * invalidate L2/MMU/LSC caches for a region.
  *
  * Return: 0 on success, a negative error code otherwise.
  */
-static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova, u64 size, u32 op)
+static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova, u64 size,
+			       bool flush_lsc)
 {
 	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
-	u32 lsc_flush_op;
+	const u32 lsc_flush_op = flush_lsc ? l2_flush_op : 0;
 	int ret;
 
-	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
-
-	switch (op) {
-	case AS_COMMAND_FLUSH_MEM:
-		lsc_flush_op = CACHE_CLEAN | CACHE_INV;
-		break;
-	case AS_COMMAND_FLUSH_PT:
-		lsc_flush_op = 0;
-		break;
-	default:
-		drm_WARN(&ptdev->base, 1, "Unexpected AS_COMMAND: %d", op);
-		return -EINVAL;
-	}
-
 	if (as_nr < 0 || !size)
 		return 0;
 
@@ -671,25 +658,12 @@ static int mmu_hw_flush_caches(struct panthor_device *ptdev, int as_nr, u64 iova
 	return ret;
 }
 
-static int mmu_hw_do_operation(struct panthor_vm *vm,
-			       u64 iova, u64 size, u32 op)
-{
-	struct panthor_device *ptdev = vm->ptdev;
-	int ret;
-
-	mutex_lock(&ptdev->mmu->as.slots_lock);
-	ret = mmu_hw_flush_caches(ptdev, vm->as.id, iova, size, op);
-	mutex_unlock(&ptdev->mmu->as.slots_lock);
-
-	return ret;
-}
-
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
 {
 	int ret;
 
-	ret = mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
+	ret = mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, true);
 	if (ret)
 		return ret;
 
@@ -706,7 +680,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 {
 	int ret;
 
-	ret = mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, AS_COMMAND_FLUSH_MEM);
+	ret = mmu_hw_flush_caches(ptdev, as_nr, 0, ~0ULL, true);
 	if (ret)
 		return ret;
 
@@ -962,7 +936,9 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
 	if (!drm_dev_enter(&ptdev->base, &cookie))
 		return 0;
 
-	ret = mmu_hw_do_operation(vm, iova, size, AS_COMMAND_FLUSH_PT);
+	mutex_lock(&ptdev->mmu->as.slots_lock);
+	ret = mmu_hw_flush_caches(ptdev, vm->as.id, iova, size, false);
+	mutex_unlock(&ptdev->mmu->as.slots_lock);
 
 	drm_dev_exit(cookie);
 	return ret;
-- 
2.51.0.384.g4c02a37b29-goog


