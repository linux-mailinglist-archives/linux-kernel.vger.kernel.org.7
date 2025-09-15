Return-Path: <linux-kernel+bounces-816256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A3B57198
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784061887412
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C942D2D5C86;
	Mon, 15 Sep 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZO9xkfD/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC82D6629
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921683; cv=none; b=JpgRDLES9DJpF46AhKAcf+gWLzP9/tv5Z72i6iIe76UOLekuVrsBw1Xs8+05pBCpu7GgKFZZx1tPqPkVLYZkYrYwM8VzeHODQfkv3n+5DrFOT329g3KlG1lx2pbyzXjHmSSC3Jm2c5SbTRFs7X7+gdIJMssoMlfUWLmq0RzaLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921683; c=relaxed/simple;
	bh=2HMhB+z9Wmbw+6HNUryCiUx8upi/xjPSlu9nG2BaTWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E3HPEjrNMgOm0h1eztVYwiP05RmTPkuz4OYZYvqekW+P3qW9twNctRwJKvuTHqkycf8D/o1WN6UnWAmUUvlHNpuLhJMQ1uAKvlo7hV4Q7wlGzmR9QFkE9YWEZZPYwWNQBlD46yJFhr7QDFgX1g6AzqztAwHxFJx919f1HI+dLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZO9xkfD/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7761b392d50so2841780b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757921680; x=1758526480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0rUlxu9dxRa7SjOGu2hjs3bhYsbBAOKtMENXiwjFtw=;
        b=ZO9xkfD/TwnT1ONGKuYl18f3n8m1g+VxTipAgvmh0X8dNVuIa36yylVLTPNEMenzdJ
         +5lgzjdY7mG1Yhig56cLiivAcq69VGxR0/Rm2ovpYdKub796v8t0td9v5S98vXV+7R/e
         pQxqWV3qMGrDwfoEYkBS1ByXRYPAQoFVXWNYTJNpu8VVa/aTMKH/KfDB8lh44Tbb1Qfs
         mSZWUY5idAp7xhb+821mbt9t9XzO3rnThbg12HQ+4/ku4SmjNnmGGaroYfdb6rXTplhm
         TJcE2kDURgyTfrO2hNa7QwJTQEpjfJ6i5SNlYGwmfosSdoiEX0wDLcTLNYuJ9SD2AAhf
         wp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921680; x=1758526480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0rUlxu9dxRa7SjOGu2hjs3bhYsbBAOKtMENXiwjFtw=;
        b=LNMoiDN6pzG40ayMjZdaCcqF9gbQs2qBdq2txpO2UkyHzg+ZuMSAV8piCcgciT4yjk
         zT2888YaFV8w70MDcLCJmj7pIqgLfR4lvnJU/ayFGZa9HbfFHE86wmIKvGsXxdM8QPRB
         yf5fFTiwom5YECWsSfXB5dgDJuQCzBwPd0WFneD3m+TqtX2Kw5hdVc5+4g8tbDKMUF8V
         xB3t4MoAkGco5qaI1GSkrLanrRpCxIUEHvd03VmNCirIy1RSKZSvI6ztnymVT4O6Zl8h
         +z3oXeFarnPrDhOHtkxKV7Ug18AGbLI+QrcSsfnembTiqrK86gxELYDgdmIJFdX9dgo2
         x/IA==
X-Forwarded-Encrypted: i=1; AJvYcCUa32YwjIrW3jmkBsOqfi0GG+/j+7tmfZ4jmrjxbODZww3hpMsZFIWDMDN30yWVjsYzWC3jsZs6b/HQOBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYxsJONQO/UJ+ZkzztK7Bk3epi3mI9CPz5j6w5YeHDeKp+gka
	r0qLA5c+J9HTZSW2PyC+H2Rmtcygy3vGHW8CDxUqJyC2PYEwNXrJwIxl/wI4MDvB/fY=
X-Gm-Gg: ASbGncuqWnRlad4+wyAukNJrEIPBuSUXqKLOluwtCWKj4KJbJ4ZyZOOkuHQveyiNfMC
	RYR7vOd0Y7mfi6yJ7cqtrl6xBtBj+JRgW7i31YYNJ8mKJXrqVOToygjALJgIfX2tsuYkHiZHfl8
	DDGtYCNEwX0zCuq79x3HO1Ws/jq5O9i33MvBgksNtej0j1Gg0Cjarn0Gtz2VBJ91bukDNM/tBgQ
	kFbFa5XO5xj2nCmJkHuJS5GzvahKLMxR1xADbEV86LIFt0jmq5GOjFZhqIY/ACYOCOGokmTJMFt
	JGamtaCEt9nyFTEcZgL7jYUpi2k3KYFppFb7zmd4JUf+QuKvfnw4uvWHSJnTTCHBisNR5/5rN/U
	3cR9GH8r5v/60uGXh4wQYug9Flbpbc+upJqseBujP0AOY+NMWIPuoUGWWGNDiDwqSaWrzPdKsrQ
	LcXUIFz7gEyQ==
X-Google-Smtp-Source: AGHT+IGWBBFTvXjPkwhC1q3K/gyU/0rSmSOfhvtAxOVjYW+gf7TUoGsC85i/QUCRghpMZknvfprsuQ==
X-Received: by 2002:a05:6a20:7343:b0:243:aca2:e500 with SMTP id adf61e73a8af0-2602c04a56fmr14074924637.29.1757921679721;
        Mon, 15 Sep 2025 00:34:39 -0700 (PDT)
Received: from N91GQ2C6R9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387cd4bsm11050234a12.35.2025.09.15.00.34.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 00:34:39 -0700 (PDT)
From: sheng.zhao@bytedance.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Sheng Zhao <sheng.zhao@bytedance.com>
Subject: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
Date: Mon, 15 Sep 2025 15:34:29 +0800
Message-Id: <20250915073429.54027-1-sheng.zhao@bytedance.com>
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
kind of memory waste will be more significant on arm64 with 64KB pages.

So, optimize it by using fixed 4KB bounce pages.

Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
 drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
 2 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..768313c80b62 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 					 u64 iova, u64 size, u64 paddr)
 {
-	struct vduse_bounce_map *map;
+	struct vduse_bounce_map *map, *head_map;
+	struct page *tmp_page;
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
 		if (!map->bounce_page) {
-			map->bounce_page = alloc_page(GFP_ATOMIC);
-			if (!map->bounce_page)
-				return -ENOMEM;
+			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
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
+		paddr += BOUNCE_PAGE_SIZE;
+		iova += BOUNCE_PAGE_SIZE;
 	}
 	return 0;
 }
@@ -127,12 +134,17 @@ static void vduse_domain_unmap_bounce_page(struct vduse_iova_domain *domain,
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
 		map->orig_phys = INVALID_PHYS_ADDR;
-		iova += PAGE_SIZE;
+		iova += BOUNCE_PAGE_SIZE;
 	}
 }
 
+static unsigned int offset_in_bounce_page(dma_addr_t addr)
+{
+	return (addr & ~BOUNCE_PAGE_MASK);
+}
+
 static void do_bounce(phys_addr_t orig, void *addr, size_t size,
 		      enum dma_data_direction dir)
 {
@@ -163,7 +175,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 {
 	struct vduse_bounce_map *map;
 	struct page *page;
-	unsigned int offset;
+	unsigned int offset, head_offset;
 	void *addr;
 	size_t sz;
 
@@ -171,9 +183,10 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		return;
 
 	while (size) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
-		offset = offset_in_page(iova);
-		sz = min_t(size_t, PAGE_SIZE - offset, size);
+		map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
+		head_offset = offset_in_page(iova);
+		offset = offset_in_bounce_page(iova);
+		sz = min_t(size_t, BOUNCE_PAGE_SIZE - offset, size);
 
 		if (WARN_ON(!map->bounce_page ||
 			    map->orig_phys == INVALID_PHYS_ADDR))
@@ -183,7 +196,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		       map->user_bounce_page : map->bounce_page;
 
 		addr = kmap_local_page(page);
-		do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
+		do_bounce(map->orig_phys + offset, addr + head_offset, sz, dir);
 		kunmap_local(addr);
 		size -= sz;
 		iova += sz;
@@ -218,7 +231,7 @@ vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 	struct page *page = NULL;
 
 	read_lock(&domain->bounce_lock);
-	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+	map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
 	if (domain->user_bounce_pages || !map->bounce_page)
 		goto out;
 
@@ -236,7 +249,7 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
 
-	bounce_pfns = domain->bounce_size >> PAGE_SHIFT;
+	bounce_pfns = domain->bounce_size >> BOUNCE_PAGE_SHIFT;
 
 	for (pfn = 0; pfn < bounce_pfns; pfn++) {
 		map = &domain->bounce_maps[pfn];
@@ -246,7 +259,8 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 		if (!map->bounce_page)
 			continue;
 
-		__free_page(map->bounce_page);
+		if (!((pfn << BOUNCE_PAGE_SHIFT) & ~PAGE_MASK))
+			__free_page(map->bounce_page);
 		map->bounce_page = NULL;
 	}
 }
@@ -254,8 +268,12 @@ vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 				       struct page **pages, int count)
 {
-	struct vduse_bounce_map *map;
-	int i, ret;
+	struct vduse_bounce_map *map, *head_map;
+	int i, j, ret;
+	int inner_pages = PAGE_SIZE / BOUNCE_PAGE_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_PAGE_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	/* Now we don't support partial mapping */
 	if (count != (domain->bounce_size >> PAGE_SHIFT))
@@ -267,16 +285,23 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
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
@@ -288,8 +313,12 @@ int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
 
 void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 {
-	struct vduse_bounce_map *map;
-	unsigned long i, count;
+	struct vduse_bounce_map *map, *head_map;
+	unsigned long i, j, count;
+	int inner_pages = PAGE_SIZE / BOUNCE_PAGE_SIZE;
+	int bounce_pfns = domain->bounce_size >> BOUNCE_PAGE_SHIFT;
+	struct page *head_page = NULL;
+	bool need_copy;
 
 	write_lock(&domain->bounce_lock);
 	if (!domain->user_bounce_pages)
@@ -297,20 +326,27 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 
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
@@ -581,7 +617,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	unsigned long pfn, bounce_pfns;
 	int ret;
 
-	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
+	bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_PAGE_SHIFT;
 	if (iova_limit <= bounce_size)
 		return NULL;
 
@@ -613,7 +649,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	rwlock_init(&domain->bounce_lock);
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
-			PAGE_SIZE, IOVA_START_PFN);
+			BOUNCE_PAGE_SIZE, IOVA_START_PFN);
 	ret = iova_domain_init_rcaches(&domain->stream_iovad);
 	if (ret)
 		goto err_iovad_stream;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 7f3f0928ec78..23139a2eaf5c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -19,6 +19,11 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+#define BOUNCE_PAGE_SHIFT	12
+#define BOUNCE_PAGE_SIZE	(1 << BOUNCE_PAGE_SHIFT)
+#define BOUNCE_PAGE_MASK	(~(BOUNCE_PAGE_SIZE - 1))
+#define BOUNCE_PAGE_ALIGN(addr)	(((addr) + BOUNCE_PAGE_SIZE - 1) & ~(BOUNCE_PAGE_SIZE - 1))
+
 struct vduse_bounce_map {
 	struct page *bounce_page;
 	struct page *user_bounce_page;
-- 
2.20.1


