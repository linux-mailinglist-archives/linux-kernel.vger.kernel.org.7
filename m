Return-Path: <linux-kernel+bounces-715668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0D4AF7C6B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 17:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E39564D55
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C91E4928;
	Thu,  3 Jul 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WnLdgC7Y"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2F1714C6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556689; cv=none; b=ZmSb9zTP3usPsZrAPH4DDsvtOm25+q5XVpbuMotOrNcRrWGw5PRP8Y1bnRYPNkVCqo04Y8nnFvdZyJ1ik7W/XYR3vmO/EgawoMrcs9Yq5LnqTqdIWhK1GPHZRh4JCuRv26kdFbkDt2SK1/SwnCTfqMD42vWeCRRLFhK/v5m0kW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556689; c=relaxed/simple;
	bh=awNKlH71K5ThSNA2Cmxa2R4NeYIYuE0Ijy7qTv36sOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUwJv+n8VTi2M3c6swxpRCFMX+ad7ocboRwNXVCZ7yLf8arksQJqJBZm8NIPw96/ku6pHyLbxja+b1JKSAH3ZaFH2d8ANnYJjGcV3+tC8JdUS/3OwrGD3j5QT+KTORhQz7sIhcXYWttKZG7LsSBfmoki8PoCuZwVBgIAevW+K/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WnLdgC7Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751556686;
	bh=awNKlH71K5ThSNA2Cmxa2R4NeYIYuE0Ijy7qTv36sOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnLdgC7Yo5+x0c55E+zY8ijTdhtaiTLAzCmzGGoI/aouaHvY67AmAY1Qg88+/TS1H
	 pbrD0COuH3+nEn/hsjbE13MelRWFUeMzCkQLv5oHa3t0gpFk3qWG6mkIxDYsBUiRzo
	 Y1bKqUdYE+FjyYx+9mZrQgkbUd1a4BXt4krvz4As6ZnllHbuLxw0eHaroVCt9oxEaP
	 bcfufYzN+BOrIaD2YSA8GbwWNYkS4sqJRx7Gzi77ndktnnhf3yAcovGaWo1cg1DuuC
	 9qONbG0sl1es00pfn9TiqXBbXO2FN1m7saJp7+NQHzu/JZLR/M+aJB+a+jVKPGf0+1
	 m4r++23pW8O6g==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [90.168.160.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nanokatze)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4857C17E080D;
	Thu,  3 Jul 2025 17:31:25 +0200 (CEST)
From: Caterina Shablia <caterina.shablia@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	Caterina Shablia <caterina.shablia@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] drm/panthor: Add support for atomic page table updates
Date: Thu,  3 Jul 2025 15:28:54 +0000
Message-ID: <20250703152908.16702-3-caterina.shablia@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250703152908.16702-2-caterina.shablia@collabora.com>
References: <20250703152908.16702-2-caterina.shablia@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

Move the lock/flush_mem operations around the gpuvm_sm_map() calls so
we can implement true atomic page updates, where any access in the
locked range done by the GPU has to wait for the page table updates
to land before proceeding.

This is needed for vkQueueBindSparse(), so we can replace the dummy
page mapped over the entire object by actual BO backed pages in an atomic
way.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 65 +++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b39ea6acc6a9..1e58948587a9 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -387,6 +387,15 @@ struct panthor_vm {
 	 * flagged as faulty as a result.
 	 */
 	bool unhandled_fault;
+
+	/** @locked_region: Information about the currently locked region currently. */
+	struct {
+		/** @locked_region.start: Start of the locked region. */
+		u64 start;
+
+		/** @locked_region.size: Size of the locked region. */
+		u64 size;
+	} locked_region;
 };
 
 /**
@@ -775,6 +784,10 @@ int panthor_vm_active(struct panthor_vm *vm)
 	}
 
 	ret = panthor_mmu_as_enable(vm->ptdev, vm->as.id, transtab, transcfg, vm->memattr);
+	if (!ret && vm->locked_region.size) {
+		lock_region(ptdev, vm->as.id, vm->locked_region.start, vm->locked_region.size);
+		ret = wait_ready(ptdev, vm->as.id);
+	}
 
 out_make_active:
 	if (!ret) {
@@ -902,6 +915,9 @@ static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 	struct io_pgtable_ops *ops = vm->pgtbl_ops;
 	u64 offset = 0;
 
+	drm_WARN_ON(&ptdev->base,
+		    (iova < vm->locked_region.start) ||
+		    (iova + size > vm->locked_region.start + vm->locked_region.size));
 	drm_dbg(&ptdev->base, "unmap: as=%d, iova=%llx, len=%llx", vm->as.id, iova, size);
 
 	while (offset < size) {
@@ -915,13 +931,12 @@ static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 				iova + offset + unmapped_sz,
 				iova + offset + pgsize * pgcount,
 				iova, iova + size);
-			panthor_vm_flush_range(vm, iova, offset + unmapped_sz);
 			return  -EINVAL;
 		}
 		offset += unmapped_sz;
 	}
 
-	return panthor_vm_flush_range(vm, iova, size);
+	return 0;
 }
 
 static int
@@ -938,6 +953,10 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 	if (!size)
 		return 0;
 
+	drm_WARN_ON(&ptdev->base,
+		    (iova < vm->locked_region.start) ||
+		    (iova + size > vm->locked_region.start + vm->locked_region.size));
+
 	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		dma_addr_t paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
@@ -985,7 +1004,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 		offset = 0;
 	}
 
-	return panthor_vm_flush_range(vm, start_iova, iova - start_iova);
+	return 0;
 }
 
 static int flags_to_prot(u32 flags)
@@ -1654,6 +1673,38 @@ static const char *access_type_name(struct panthor_device *ptdev,
 	}
 }
 
+static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
+{
+	struct panthor_device *ptdev = vm->ptdev;
+	int ret;
+
+	mutex_lock(&ptdev->mmu->as.slots_lock);
+	drm_WARN_ON(&ptdev->base, vm->locked_region.start || vm->locked_region.size);
+	vm->locked_region.start = start;
+	vm->locked_region.size = size;
+	if (vm->as.id >= 0) {
+		lock_region(ptdev, vm->as.id, start, size);
+		ret = wait_ready(ptdev, vm->as.id);
+	}
+	mutex_unlock(&ptdev->mmu->as.slots_lock);
+
+	return ret;
+}
+
+static void panthor_vm_unlock_region(struct panthor_vm *vm)
+{
+	struct panthor_device *ptdev = vm->ptdev;
+
+	mutex_lock(&ptdev->mmu->as.slots_lock);
+	if (vm->as.id >= 0) {
+		write_cmd(ptdev, vm->as.id, AS_COMMAND_FLUSH_MEM);
+		drm_WARN_ON(&ptdev->base, wait_ready(ptdev, vm->as.id));
+	}
+	vm->locked_region.start = 0;
+	vm->locked_region.size = 0;
+	mutex_unlock(&ptdev->mmu->as.slots_lock);
+}
+
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
 	bool has_unhandled_faults = false;
@@ -2179,6 +2230,11 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 
 	mutex_lock(&vm->op_lock);
 	vm->op_ctx = op;
+
+	ret = panthor_vm_lock_region(vm, op->va.addr, op->va.range);
+	if (ret)
+		goto out;
+
 	switch (op_type) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (vm->unusable) {
@@ -2199,6 +2255,9 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 		break;
 	}
 
+	panthor_vm_unlock_region(vm);
+
+out:
 	if (ret && flag_vm_unusable_on_failure)
 		vm->unusable = true;
 
-- 
2.47.2


