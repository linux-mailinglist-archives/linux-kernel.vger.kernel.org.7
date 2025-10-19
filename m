Return-Path: <linux-kernel+bounces-859513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D420BEDDFC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC6C14E18DF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 03:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E58218FDDB;
	Sun, 19 Oct 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="APZ4rTfj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4D2746A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 03:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760844114; cv=pass; b=NldXAQ0pCXm38JL47RLtPbD2XjHrAFBmPZ1xaqSk8djN38RX7kuJdVkUmZn+o0aThJj1EXGqIpTXmqJ/3tBjKaRYt+O4CPQEuKE4RvNGLvzr5hYo9MkZsdmlB6BOYpkvsdduE2pOq3uDYe/t9l0PxmxUsOXsxGR9Ua6lity/JFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760844114; c=relaxed/simple;
	bh=0AkUllaGXQW4e9eNENj8XjPMhkSfiKfmXg8WFJ2M9yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xty0mI7HLxsYGQZESQvD1wxMM/2YmVKPMPe737596dQtVseS0dWCFGOzj9MLygtlEg3qkRXbteCjFsR4aT9+70RHmbMki5U8JYPA/J0hK90nHpr5MULL3U1fLZmlOd7Vw85VUwbGRvmtN8oLL5YZJ2yVn0y0g4orDNADonSMp4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=APZ4rTfj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760844087; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fH80gG061avHGiyTa618ah/UfxB6retbLtFkF7tY5araEKOojK8d1Q2TPD0T53v8YcXtIWMw+lMamPkbhTDeQhvsMEBXEw/oMvYqTYO3zmTvB2BHWGVEPBWzETRrqYAZLU8fZxK5xgWLpY1mT+R2SvunJjnpWEy8JHmbPI/ZhCI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760844087; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8UcSv47mpQFVhZhBI1Nn1HoYOfQBzRy+jFgw/PUy79Y=; 
	b=L+b7XzJNgAhPK6M6JfwT8PM0mfa1kYX1Umo9IRadWM0SEA5DvKyYKVyPI0GLO/gxccvyjph9WUR+RCvv+RCd3Y3U7G7lUWAGM/6fofD+dAoz2rGs995x/w25hD+Y69tG7KSiBuKpbLImG2C+8bHsEtOjLaxPO3ruE20PqEwHBQg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760844087;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8UcSv47mpQFVhZhBI1Nn1HoYOfQBzRy+jFgw/PUy79Y=;
	b=APZ4rTfjpAcZUDmsMMbPzTUEmVfy1wddr3xBR5urRgMdR2b4HQj9g86+UitQjw9q
	uUQKllTExTHfI2HSpoSakvpTPQaGMs4aUdiS3KXF4j/r3iuuomRh144ku1WzU7N4Vy7
	FqEsapDpCiWof5RkAjiNeY41FQJqGSMqZ8GBSTSo=
Received: by mx.zohomail.com with SMTPS id 1760844085033866.671906076843;
	Sat, 18 Oct 2025 20:21:25 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/panthor: Support partial unmaps of huge pages
Date: Sun, 19 Oct 2025 04:19:42 +0100
Message-ID: <20251019032108.3498086-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
behavior") did away with the treatment of partial unmaps of huge IOPTEs.

In the case of Panthor, that means an attempt to run a VM_BIND unmap
operation on a memory region whose start address and size aren't 2MiB
aligned, in the event it intersects with a huge page, would lead to ARM
IOMMU management code to fail and a warning being raised.

Presently, and for lack of a better alternative, it's best to have
Panthor handle partial unmaps at the driver level, by unmapping entire
huge pages and remapping the difference between them and the requested
unmap region.

This could change in the future when the VM_BIND uAPI is expanded to
enforce huge page alignment and map/unmap operational constraints that
render this code unnecessary.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 129 +++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 2d041a2e75e9..f9d200e57c04 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2093,6 +2093,98 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 	return 0;
 }
 
+static bool
+is_huge_page_partial_unmap(const struct panthor_vma *unmap_vma,
+			   const struct drm_gpuva_op_map *op,
+			   u64 unmap_start, u64 unmap_range,
+			   u64 sz2m_prev, u64 sz2m_next)
+{
+	size_t pgcount, pgsize;
+	const struct page *pg;
+	pgoff_t bo_offset;
+
+	if (op->va.addr < unmap_vma->base.va.addr) {
+		bo_offset = unmap_start - unmap_vma->base.va.addr + unmap_vma->base.gem.offset;
+		sz2m_prev = ALIGN_DOWN(unmap_start, SZ_2M);
+		sz2m_next = ALIGN(unmap_start + 1, SZ_2M);
+		pgsize = get_pgsize(unmap_start, unmap_range, &pgcount);
+
+	} else {
+		bo_offset = ((unmap_start + unmap_range - 1) - unmap_vma->base.va.addr)
+			+ unmap_vma->base.gem.offset;
+		sz2m_prev = ALIGN_DOWN(unmap_start + unmap_range - 1, SZ_2M);
+		sz2m_next = ALIGN(unmap_start + unmap_range, SZ_2M);
+		pgsize = get_pgsize(sz2m_prev, unmap_start + unmap_range - sz2m_prev, &pgcount);
+	}
+
+	pg = to_panthor_bo(unmap_vma->base.gem.obj)->base.pages[bo_offset >> PAGE_SHIFT];
+
+	if (pgsize == SZ_4K && folio_order(page_folio(pg)) == PMD_ORDER &&
+	    unmap_vma->base.va.addr <= sz2m_prev && unmap_vma->base.va.addr +
+	    unmap_vma->base.va.range >= sz2m_next)
+		return true;
+
+	return false;
+}
+
+struct remap_params {
+	u64 prev_unmap_start, prev_unmap_range;
+	u64 prev_remap_start, prev_remap_range;
+	u64 next_unmap_start, next_unmap_range;
+	u64 next_remap_start, next_remap_range;
+	u64 unmap_start, unmap_range;
+};
+
+static struct remap_params
+get_map_unmap_intervals(const struct drm_gpuva_op_remap *op,
+			const struct panthor_vma *unmap_vma)
+{
+	u64 unmap_start, unmap_range, sz2m_prev, sz2m_next;
+	struct remap_params params = {0};
+
+	drm_gpuva_op_remap_to_unmap_range(op, &unmap_start, &unmap_range);
+
+	if (op->prev) {
+		sz2m_prev = ALIGN_DOWN(unmap_start, SZ_2M);
+		sz2m_next = ALIGN(unmap_start + 1, SZ_2M);
+
+		if (is_huge_page_partial_unmap(unmap_vma, op->prev, unmap_start,
+					       unmap_range, sz2m_prev, sz2m_next)) {
+			params.prev_unmap_start = sz2m_prev;
+			params.prev_unmap_range = SZ_2M;
+			params.prev_remap_start = sz2m_prev;
+			params.prev_remap_range = unmap_start & (SZ_2M - 1);
+
+			u64 diff = min(sz2m_next - unmap_start, unmap_range);
+
+			unmap_range -= diff;
+			unmap_start += diff;
+		}
+	}
+
+	if (op->next) {
+		sz2m_prev = ALIGN_DOWN(unmap_start + unmap_range - 1, SZ_2M);
+		sz2m_next = ALIGN(unmap_start + unmap_range, SZ_2M);
+
+		if (is_huge_page_partial_unmap(unmap_vma, op->next, unmap_start,
+					       unmap_range, sz2m_prev, sz2m_next)) {
+			if (unmap_range) {
+				params.next_unmap_start = sz2m_prev;
+				params.next_unmap_range = SZ_2M;
+				unmap_range -= op->next->va.addr & (SZ_2M - 1);
+			}
+
+			params.next_remap_start = op->next->va.addr;
+			params.next_remap_range = SZ_2M - (op->next->va.addr & (SZ_2M - 1));
+		}
+	}
+
+	params.unmap_start = unmap_start;
+	params.unmap_range = unmap_range;
+
+	return params;
+}
+
 static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 				       void *priv)
 {
@@ -2100,20 +2192,51 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	struct panthor_vm *vm = priv;
 	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
 	struct panthor_vma *prev_vma = NULL, *next_vma = NULL;
-	u64 unmap_start, unmap_range;
+	struct remap_params params;
 	int ret;
 
-	drm_gpuva_op_remap_to_unmap_range(&op->remap, &unmap_start, &unmap_range);
-	ret = panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
+	/*
+	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
+	 * so when a partial unmap is requested, we must first unmap the entire huge
+	 * page and then remap the difference between the huge page minus the requested
+	 * unmap region. Calculating the right offsets and ranges for the different unmap
+	 * and map operations is the responsibility of the following function.
+	 */
+	params = get_map_unmap_intervals(&op->remap, unmap_vma);
+
+	ret = panthor_vm_unmap_pages(vm, params.unmap_start, params.unmap_range);
 	if (ret)
 		return ret;
 
 	if (op->remap.prev) {
+		ret = panthor_vm_unmap_pages(vm, params.prev_unmap_start,
+					     params.prev_unmap_range);
+		if (ret)
+			return ret;
+		ret = panthor_vm_map_pages(vm, params.prev_remap_start,
+					   flags_to_prot(unmap_vma->flags),
+					   to_drm_gem_shmem_obj(op->remap.prev->gem.obj)->sgt,
+					   op->remap.prev->gem.offset, params.prev_remap_range);
+		if (ret)
+			return ret;
+
 		prev_vma = panthor_vm_op_ctx_get_vma(op_ctx);
 		panthor_vma_init(prev_vma, unmap_vma->flags);
 	}
 
 	if (op->remap.next) {
+		ret = panthor_vm_unmap_pages(vm, params.next_unmap_start,
+					     params.next_unmap_range);
+		if (ret)
+			return ret;
+
+		ret = panthor_vm_map_pages(vm, params.next_remap_start,
+					   flags_to_prot(unmap_vma->flags),
+					   to_drm_gem_shmem_obj(op->remap.next->gem.obj)->sgt,
+					   op->remap.next->gem.offset, params.next_remap_range);
+		if (ret)
+			return ret;
+
 		next_vma = panthor_vm_op_ctx_get_vma(op_ctx);
 		panthor_vma_init(next_vma, unmap_vma->flags);
 	}

base-commit: 7fb19ea1ec6aa85c75905b1fd732d50801e7fb28
prerequisite-patch-id: 3b0f61bfc22a616a205ff7c15d546d2049fd53de
-- 
2.51.0


