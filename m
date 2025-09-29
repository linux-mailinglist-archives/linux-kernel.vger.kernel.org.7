Return-Path: <linux-kernel+bounces-836789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03BBAA910
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCB9189F172
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306227816E;
	Mon, 29 Sep 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HkWzCL1V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719072750E3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176296; cv=none; b=Ikn7fTYpsz02deQ2oIcFxr0n47etsONOE8EKFJJPI3ZlUFsz9R+xsvbE1nmeupUH0onOwdhPLe+qZfYTRkSwU+RQjPaZ5Bua9ZitTstN+Q2/waQf4FiJrQ3xsaQx9QhDWJFn12oukZAQRhdQ+IE7n7hAsdSMvleaK7aacAwerCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176296; c=relaxed/simple;
	bh=99oZ1P7VzqkhLJbQUXrJREFvLqy3hC4FKU/uBU4LITk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfi2Sb589O4KJHuMZwJgnr4L8BQJLYcLheiBJDwVcAPMjgiUR8IEJGE/C6SE2Z/qCDa1M2Qg3S6TUCURYMP2EXFkRvOzUcAsOLKhacqqzk+nVDzOXTwZ/5Lt5JpRu0tteY514U7VjbyuQbyb9UIK5KmJFsIlGQ3d4m+EzHGgotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HkWzCL1V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759176292;
	bh=99oZ1P7VzqkhLJbQUXrJREFvLqy3hC4FKU/uBU4LITk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkWzCL1VTgODwNs2olF/EN97qvp+mVWvhDn/cRxOyHvNZ9dxHMYMo093ZkHsW6z2u
	 22bmoYV9rKtr4m9f5UozvRl1b/1iswDL7ddGAk035uAdOAlP+N8JPOJrJuegpIhHvU
	 UJXIA0ATufT54tRGQY0R4NhmSJc+DvzNX+5qDA7KP4RCM9ABxyGEO+c060P8XzMXJj
	 hz/6i138BR0DbfGO48oePQPevtNXwew61jdn2T5uu8d81Nbic6RpZymEFsUZQqCG1o
	 ABzLg51rKa+buvlGZvEwCGail5Z/WoFRBemGi1XoAdRphhyOC0OQwX74OpUHYbf6X6
	 3qgFlPvsfjOvg==
Received: from debian-rockchip-rock5b-rk3588.. (unknown [IPv6:2a01:e0a:5e3:6100:826d:bc07:e98c:84a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: loicmolinari)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EEEE17E13C1;
	Mon, 29 Sep 2025 22:04:52 +0200 (CEST)
From: =?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Lo=C3=AFc=20Molinari?= <loic.molinari@collabora.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Miko=C5=82aj=20Wasiak?= <mikolaj.wasiak@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org,
	kernel@collabora.com
Subject: [PATCH 7/8] drm/panthor: Improve IOMMU map/unmap debugging logs
Date: Mon, 29 Sep 2025 22:03:15 +0200
Message-ID: <20250929200316.18417-8-loic.molinari@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250929200316.18417-1-loic.molinari@collabora.com>
References: <20250929200316.18417-1-loic.molinari@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Log the number of pages and their sizes actually mapped/unmapped by
the IOMMU page table driver. Since a map/unmap op is often split in
several ops depending on the underlying scatter/gather table, add the
start address and the total size to the debugging logs in order to
help understand which batch an op is part of.

Signed-off-by: Loïc Molinari <loic.molinari@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 6dec4354e378..aefbd83d1a75 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -917,10 +917,9 @@ static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 {
 	struct panthor_device *ptdev = vm->ptdev;
 	struct io_pgtable_ops *ops = vm->pgtbl_ops;
+	u64 start_iova = iova;
 	u64 offset = 0;
 
-	drm_dbg(&ptdev->base, "unmap: as=%d, iova=%llx, len=%llx", vm->as.id, iova, size);
-
 	while (offset < size) {
 		size_t unmapped_sz = 0, pgcount;
 		size_t pgsize = get_pgsize(iova + offset, size - offset, &pgcount);
@@ -935,6 +934,12 @@ static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 			panthor_vm_flush_range(vm, iova, offset + unmapped_sz);
 			return  -EINVAL;
 		}
+
+		drm_dbg(&ptdev->base,
+			"unmap: as=%d, iova=0x%llx, sz=%llu, va=0x%llx, pgcnt=%zu, pgsz=%zu",
+			vm->as.id, start_iova, size, iova + offset,
+			unmapped_sz / pgsize, pgsize);
+
 		offset += unmapped_sz;
 	}
 
@@ -950,6 +955,7 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 	struct scatterlist *sgl;
 	struct io_pgtable_ops *ops = vm->pgtbl_ops;
 	u64 start_iova = iova;
+	u64 start_size = size;
 	int ret;
 
 	if (!size)
@@ -969,15 +975,18 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 		len = min_t(size_t, len, size);
 		size -= len;
 
-		drm_dbg(&ptdev->base, "map: as=%d, iova=%llx, paddr=%pad, len=%zx",
-			vm->as.id, iova, &paddr, len);
-
 		while (len) {
 			size_t pgcount, mapped = 0;
 			size_t pgsize = get_pgsize(iova | paddr, len, &pgcount);
 
 			ret = ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot,
 					     GFP_KERNEL, &mapped);
+
+			drm_dbg(&ptdev->base,
+				"map: as=%d, iova=0x%llx, sz=%llu, va=0x%llx, pa=%pad, pgcnt=%zu, pgsz=%zu",
+				vm->as.id, start_iova, start_size, iova, &paddr,
+				mapped / pgsize, pgsize);
+
 			iova += mapped;
 			paddr += mapped;
 			len -= mapped;
-- 
2.47.3


