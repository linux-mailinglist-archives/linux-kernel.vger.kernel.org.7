Return-Path: <linux-kernel+bounces-832328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF158B9EEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808E73860AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C6D2FB96C;
	Thu, 25 Sep 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aPttx1vD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12D2FB615
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800140; cv=none; b=Wp+/8KbM5jBdzWsf5BZc9MSlFZzwUgG5tSGa8zL0/SL6uuZZ5eeRPSsHfn4xjsRGE0iHarIw9SUrx3QW2sSbpSt2/PJYssPZ287wwLgcUUxt9yzeczkhmqb1o9i4L3pX/kJgbglMUYqb6z0juNNuwdZbeCMr1dM+DACVgkLDJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800140; c=relaxed/simple;
	bh=VmC4Jxvgj+OF+HuiXN+o66ZmH7lTaAFzcHBdiAtT+3k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dwYmyy0QEY+RYNArLvYruWnl4W+xTTXon4zMu6bXnJrzAj/6qag9auplaxPelnAxPhNQo7H2Dw2Ww43etco0c70FKvevlzpppXD0mlYwweXl8bfZ4QoPuL3T7CZVb39VyWhswoQzDnRDsSYekAOK64fxJo+d1Tv45XQTjIZR5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aPttx1vD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-271067d66fbso9033215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758800138; x=1759404938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erUzbsjS7Pcc5I0u/VOZEOT90HSwlVZDCaCA1mBPIHY=;
        b=aPttx1vDrYHKfZSQsw77f9yxC+DfSgE73KYWphxFOLM7iWd7pxX2PMZywhaW9477re
         3dpRscbjMirL/Z2LeUaWbIxfwvXhFOujr9hAIVBncjypswgIkIKvn/oXD0SSuHpda00b
         DP+nTrjvJsG8fkFruxj7iKJ9ocVwBrBJ4IYGKxWWpqsqY1cn7l8nOpaF3RP993wwrJP/
         +5SSBqxnOik7tkZAX0+ywB9YwuPcPkx3QkNdNSJix1OJORcIA+7+5TSK7V2qfcV5ZFy5
         pY1+XK0esSomWVpDj1H6Rmm5vaAe0BCLzi4OcWIa3ukT5o5y7ZHLeoLhAAPuA08VACjT
         SMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800138; x=1759404938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erUzbsjS7Pcc5I0u/VOZEOT90HSwlVZDCaCA1mBPIHY=;
        b=LFqhXVnWvLffCiE+zWQCCkAQp8kVPZ48TJo0ODSWJ/0yZd8MDafLL9Bp6An9mOZdHB
         K+OZLPx4Mh4URGBYd26GF7yU/YhtrIgO+axD1c58gdLuTFCP0fc/czmA4/PkwnBAUGaO
         hZz8LFABAPFCYcdcbbfvdzA75cijJ2vMYpvzipugl8sQp91RKMdYNPHg9x43OZXV0re/
         btaBuSqGO1dRLY1+H1463HOmnw6Bjz1FZgjzNRxz9lQlR0tcal5NGeTe9Si6YpbnPUZP
         5mqb9n7mhC0zDkD8l+2iAAQ+IXxtnDJN3DqIN1ih2+o7i9IZXIa8d5n1cqs3OhwjHm6W
         eoQA==
X-Forwarded-Encrypted: i=1; AJvYcCVmEEHvk3AmVRt682QhHP9dddyyCU2lJ5hQXQ27kRkkj4eCN+18rztfQMi/N7/U3kWTqf8pqodv0xNVQGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVGIL86qQD2wIo5ySuvKFMCdwui52xoaCUJ7b7b+nWuhCSZYRN
	roBkp2QOiIDwu3RLPv+VoAcURa3m5jxUzgxK15Z0jwHr2YPz4MGy8eloDWdDcFUzaBw=
X-Gm-Gg: ASbGnct/6HM3VaJn6Dcj+yU2ArFWb07F4F5KZJMgNO0kJobmNlw29NwiHmRILsrOlhW
	NefeNOh8c+SOWb6ORJNhWUsMhZ4jsMSslgFkAUhMOpVXapNsct87a5T+U3Ax49jAF3mI5YyXoLx
	sp4OsrtyOD3UrDwiaduaAANXYgcpZKtDr0LeWT//lNp2ZXvaUndPokqGoIP6/hAVvZvLkLDeByS
	7TnW3i/ZtoXk4s7f65upyQVm+jq4PjJUhAR8dRQJYFb2K/qj8tZ+2YA7LVfoxSsuOLOAmm35dDk
	avCLdFCxNWLQLBaEZiGzMtdsIicPJYb6cg6DuWaUs9HhlY1DEeTleucM9OUlxMH2MbSKf5jqY4i
	F43JOofQw6GKiB/nFdKEnijbaU1s3tsWxocA4aja3vFWzuW7AKuEZe69H049wMMe5Vl2xIetIeY
	NDOfPaOlrhfg==
X-Google-Smtp-Source: AGHT+IGDrwphJcBu9glOmSZz197HGaYZSeILmht8xenQ8C3DJiOpCgzoJEGon4xMLPYxAWllFUIfww==
X-Received: by 2002:a17:902:eccb:b0:24c:e6fa:2a38 with SMTP id d9443c01a7336-27ed4a0d705mr38227785ad.25.1758800137766;
        Thu, 25 Sep 2025 04:35:37 -0700 (PDT)
Received: from N91GQ2C6R9.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm22909415ad.49.2025.09.25.04.35.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 04:35:37 -0700 (PDT)
From: sheng.zhao@bytedance.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Sheng Zhao <sheng.zhao@bytedance.com>
Subject: [PATCH v2] vduse: Use fixed 4KB bounce pages for non-4KB page size
Date: Thu, 25 Sep 2025 19:35:16 +0800
Message-Id: <20250925113516.60305-1-sheng.zhao@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Zhao <sheng.zhao@bytedance.com>

The allocation granularity of bounce pages is PAGE_SIZE. This may cause
even small IO requests to occupy an entire bounce page exclusively. The
kind of memory waste will be more significant when PAGE_SIZE is larger
than 4KB (e.g. arm64 with 64KB pages).

So, optimize it by using fixed 4KB bounce maps and iova allocation
granularity. A single IO request occupies at least a 4KB bounce page
instead of the entire memory page of PAGE_SIZE.

Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
---

Changes in v2:
- Tweak the title and improve the commit message.
- Change the macro prefix from BOUNCE_PAGE to BOUNCE_MAP.
- Add code comments.
- Link to v1: https://lore.kernel.org/lkml/20250915073429.54027-1-sheng.zhao@bytedance.com

---
 drivers/vdpa/vdpa_user/iova_domain.c | 132 ++++++++++++++++++---------
 drivers/vdpa/vdpa_user/iova_domain.h |   5 +
 2 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..402e66a0ae39 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -103,19 +103,38 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 					 u64 iova, u64 size, u64 paddr)
 {
-	struct vduse_bounce_map *map;
+	struct vduse_bounce_map *map, *head_map;
+	struct page *tmp_page;
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		/*
+		 * When PAGE_SIZE is larger than 4KB, multiple adjacent bounce_maps will
+		 * point to the same memory page of PAGE_SIZE. Since bounce_maps originate
+		 * from IO requests, we may not be able to guarantee that the orig_phys
+		 * values of all IO requests within the same 64KB memory page are contiguous.
+		 * Therefore, we need to store them separately.
+		 *
+		 * Bounce pages are allocated on demand. As a result, it may occur that
+		 * multiple bounce pages corresponding to the same 64KB memory page attempt
+		 * to allocate memory simultaneously, so we use cmpxchg to handle this
+		 * concurrency.
+		 */
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 		if (!map->bounce_page) {
-			map->bounce_page = alloc_page(GFP_ATOMIC);
-			if (!map->bounce_page)
-				return -ENOMEM;
+			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
+			if (!head_map->bounce_page) {
+				tmp_page = alloc_page(GFP_ATOMIC);
+				if (!tmp_page)
+					return -ENOMEM;
+				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
+					__free_page(tmp_page);
+			}
+			map->bounce_page = head_map->bounce_page;
 		}
 		map->orig_phys = paddr;
-		paddr += PAGE_SIZE;
-		iova += PAGE_SIZE;
+		paddr += BOUNCE_MAP_SIZE;
+		iova += BOUNCE_MAP_SIZE;
 	}
 	return 0;
 }
@@ -127,12 +146,17 @@ static void vduse_domain_unmap_bounce_page(struct vduse_iova_domain *domain,
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 		map->orig_phys = INVALID_PHYS_ADDR;
-		iova += PAGE_SIZE;
+		iova += BOUNCE_MAP_SIZE;
 	}
 }
 
+static unsigned int offset_in_bounce_page(dma_addr_t addr)
+{
+	return (addr & ~BOUNCE_MAP_MASK);
+}
+
 static void do_bounce(phys_addr_t orig, void *addr, size_t size,
 		      enum dma_data_direction dir)
 {
@@ -163,7 +187,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 {
 	struct vduse_bounce_map *map;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, head_offset;
 	void *addr;
 	size_t sz;
 
@@ -171,9 +195,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		return;
 
 	while (size) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
-		offset = offset_in_page(iova);
-		sz = min_t(size_t, PAGE_SIZE - offset, size);
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
+		head_offset = offset_in_page(iova);
+		offset = offset_in_bounce_page(iova);
+		sz = min_t(size_t, BOUNCE_MAP_SIZE - offset, size);
 
 		if (WARN_ON(!map->bounce_page ||
 			    map->orig_phys == INVALID_PHYS_ADDR))
@@ -183,7 +208,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		       map->user_bounce_page : map->bounce_page;
 
 		addr = kmap_local_page(page);
-		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
+		do_bounce(map->orig_phys + offset, addr + head_offset, sz, dir);
 		kunmap_local(addr);
 		size -= sz;
 		iova += sz;
@@ -218,7 +243,7 @@ vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 	struct page *page = NULL;
 
 	read_lock(&domain->bounce_lock);
-	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+	map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 	if (domain->user_bounce_pages || !map->bounce_page)
 		goto out;
 
@@ -236,7 +261,7 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
 
-	bounce_pfns = domain->bounce_size >> PAGE_SHIFT;
+	bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
 
 	for (pfn = 0; pfn < bounce_pfns; pfn++) {
 		map = &domain->bounce_maps[pfn];
@@ -246,7 +271,8 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 		if (!map->bounce_page)
 			continue;
 
-		__free_page(map->bounce_page);
+		if (!((pfn << BOUNCE_MAP_SHIFT) & ~PAGE_MASK))
+			__free_page(map->bounce_page);
 		map->bounce_page = NULL;
 	}
 }
@@ -254,8 +280,12 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				       struct page **pages, int count)
 {
-	struct vduse_bounce_map *map;
-	int i, ret;
+	struct vduse_bounce_map *map, *head_map;
+	int i, j, ret;
+	int inner_pages = PAGE_SIZE / BOUNCE_MAP_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	/* Now we don't support partial mapping */
 	if (count != (domain->bounce_size >> PAGE_SHIFT))
@@ -267,16 +297,23 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 		goto out;
 
 	for (i = 0; i < count; i++) {
-		map = &domain->bounce_maps[i];
-		if (map->bounce_page) {
+		need_copy = false;
+		head_map = &domain->bounce_maps[(i * inner_pages)];
+		head_page = head_map->bounce_page;
+		for (j = 0; j < inner_pages; j++) {
+			if ((i * inner_pages + j) >= bounce_pfns)
+				break;
+			map = &domain->bounce_maps[(i * inner_pages + j)];
 			/* Copy kernel page to user page if it's in use */
-			if (map->orig_phys != INVALID_PHYS_ADDR)
-				memcpy_to_page(pages[i], 0,
-					       page_address(map->bounce_page),
-					       PAGE_SIZE);
+			if ((head_page) && (map->orig_phys != INVALID_PHYS_ADDR))
+				need_copy = true;
+			map->user_bounce_page = pages[i];
 		}
-		map->user_bounce_page = pages[i];
 		get_page(pages[i]);
+		if ((head_page) && (need_copy))
+			memcpy_to_page(pages[i], 0,
+				       page_address(head_page),
+				       PAGE_SIZE);
 	}
 	domain->user_bounce_pages = true;
 	ret = 0;
@@ -288,8 +325,12 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 
 void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 {
-	struct vduse_bounce_map *map;
-	unsigned long i, count;
+	struct vduse_bounce_map *map, *head_map;
+	unsigned long i, j, count;
+	int inner_pages = PAGE_SIZE / BOUNCE_MAP_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	write_lock(&domain->bounce_lock);
 	if (!domain->user_bounce_pages)
@@ -297,20 +338,27 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 
 	count = domain->bounce_size >> PAGE_SHIFT;
 	for (i = 0; i < count; i++) {
-		struct page *page = NULL;
-
-		map = &domain->bounce_maps[i];
-		if (WARN_ON(!map->user_bounce_page))
+		need_copy = false;
+		head_map = &domain->bounce_maps[(i * inner_pages)];
+		if (WARN_ON(!head_map->user_bounce_page))
 			continue;
-
-		/* Copy user page to kernel page if it's in use */
-		if (map->orig_phys != INVALID_PHYS_ADDR) {
-			page = map->bounce_page;
-			memcpy_from_page(page_address(page),
-					 map->user_bounce_page, 0, PAGE_SIZE);
+		head_page = head_map->user_bounce_page;
+
+		for (j = 0; j < inner_pages; j++) {
+			if ((i * inner_pages + j) >= bounce_pfns)
+				break;
+			map = &domain->bounce_maps[(i * inner_pages + j)];
+			if (WARN_ON(!map->user_bounce_page))
+				continue;
+			/* Copy user page to kernel page if it's in use */
+			if ((map->orig_phys != INVALID_PHYS_ADDR) && (head_map->bounce_page))
+				need_copy = true;
+			map->user_bounce_page = NULL;
 		}
-		put_page(map->user_bounce_page);
-		map->user_bounce_page = NULL;
+		if (need_copy)
+			memcpy_from_page(page_address(head_map->bounce_page),
+					 head_page, 0, PAGE_SIZE);
+		put_page(head_page);
 	}
 	domain->user_bounce_pages = false;
 out:
@@ -581,7 +629,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	unsigned long pfn, bounce_pfns;
 	int ret;
 
-	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
+	bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
 	if (iova_limit <= bounce_size)
 		return NULL;
 
@@ -613,7 +661,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	rwlock_init(&domain->bounce_lock);
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
-			PAGE_SIZE, IOVA_START_PFN);
+			BOUNCE_MAP_SIZE, IOVA_START_PFN);
 	ret = iova_domain_init_rcaches(&domain->stream_iovad);
 	if (ret)
 		goto err_iovad_stream;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 7f3f0928ec78..e36d4b7ef5d0 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -19,6 +19,11 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+#define BOUNCE_MAP_SHIFT	12
+#define BOUNCE_MAP_SIZE	(1 << BOUNCE_MAP_SHIFT)
+#define BOUNCE_MAP_MASK	(~(BOUNCE_MAP_SIZE - 1))
+#define BOUNCE_MAP_ALIGN(addr)	(((addr) + BOUNCE_MAP_SIZE - 1) & ~(BOUNCE_MAP_SIZE - 1))
+
 struct vduse_bounce_map {
 	struct page *bounce_page;
 	struct page *user_bounce_page;
-- 
2.20.1


