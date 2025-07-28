Return-Path: <linux-kernel+bounces-747623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7BEB13600
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849853B7F23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E1322539D;
	Mon, 28 Jul 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kepHxj6K"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA10223DE9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689855; cv=none; b=q4xCUeW8GS1wBE5YMBRtdWcNXqLtdq/JBbgq9xz4tw5shiG0aztzbYXVAYFLb1uFJQMdqZfb9hGu4csHKACQsheFEoSma8F+HbKH4RMymvhFeXK1S61VHqqkEHC2xvSJNIEDOg0S1BTd+ZJ4xXapyqza7KXDS+6nIFXyV9Gy4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689855; c=relaxed/simple;
	bh=kpUv0DUXwxdXmL7Qqpmu2Pj3VF4c3OdoDqZ5lfZkulM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LcALP2Z4VB4N/ISs3BK9PAml+xwHsUJeOT6yDv4HXVEOYwO4BKDOm+lG/YgTciBhAU+Hh7ft7tAbDQ9NdrTd1459ABCurUKdWs5ATqBfngK6MfZbWi1yOOJVwnblUY4V5dDlKGXw3+4zBjYQLh5iTwpx5QvgKr3fy9HCVQ5f/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kepHxj6K; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753689843; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=R5JhzFAe2+pi/8yqRFPN+PrUVu7txCrojFI/LNAgGtk=;
	b=kepHxj6K2WQ5b1O0Lk+ZXTbEgcjH7EbyQxYr62pv2TqS5uCU/qmJteoI0u3H0JOF/d6UzIcMP4XGTy6z4VvpeFC60qK8DqgpoVH3w0iJff0o67gPiyLAAFgweZ64trQ0XGtMFIGalkAmUbDK6hSKr87xy/oDyQRRETJ4kgRrtL4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WkFS0FZ_1753689841 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 16:04:01 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: patryk@kowalczyk.ws,
	ville.syrjala@linux.intel.com,
	david@redhat.com,
	willy@infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	christian.koenig@amd.com,
	ray.huang@amd.com,
	matthew.auld@intel.com,
	matthew.brost@intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: shmem: fix the shmem large folio allocation for the i915 driver
Date: Mon, 28 Jul 2025 16:03:53 +0800
Message-ID: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
we extend the 'huge=' option to allow any sized large folios for tmpfs,
which means tmpfs will allow getting a highest order hint based on the size
of write() and fallocate() paths, and then will try each allowable large order.

However, when the i915 driver allocates shmem memory, it doesn't provide hint
information about the size of the large folio to be allocated, resulting in
the inability to allocate PMD-sized shmem, which in turn affects GPU performance.

To fix this issue, add the 'end' information for shmem_read_folio_gfp()  to help
allocate PMD-sized large folios. Additionally, use the maximum allocation chunk
(via mapping_max_folio_size()) to determine the size of the large folios to
allocate in the i915 driver.

Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpu/drm/drm_gem.c                 | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 7 ++++++-
 drivers/gpu/drm/ttm/ttm_backup.c          | 2 +-
 include/linux/shmem_fs.h                  | 4 ++--
 mm/shmem.c                                | 7 ++++---
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 4bf0a76bb35e..5ed34a9211a4 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -627,7 +627,7 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj)
 	i = 0;
 	while (i < npages) {
 		long nr;
-		folio = shmem_read_folio_gfp(mapping, i,
+		folio = shmem_read_folio_gfp(mapping, i, 0,
 				mapping_gfp_mask(mapping));
 		if (IS_ERR(folio))
 			goto fail;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index f263615f6ece..778290f49853 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -69,6 +69,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	struct scatterlist *sg;
 	unsigned long next_pfn = 0;	/* suppress gcc warning */
 	gfp_t noreclaim;
+	size_t chunk;
 	int ret;
 
 	if (overflows_type(size / PAGE_SIZE, page_count))
@@ -94,6 +95,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	mapping_set_unevictable(mapping);
 	noreclaim = mapping_gfp_constraint(mapping, ~__GFP_RECLAIM);
 	noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
+	chunk = mapping_max_folio_size(mapping);
 
 	sg = st->sgl;
 	st->nents = 0;
@@ -105,10 +107,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			0,
 		}, *s = shrink;
 		gfp_t gfp = noreclaim;
+		loff_t bytes = (page_count - i) << PAGE_SHIFT;
+		loff_t pos = i << PAGE_SHIFT;
 
+		bytes = min_t(loff_t, chunk, bytes);
 		do {
 			cond_resched();
-			folio = shmem_read_folio_gfp(mapping, i, gfp);
+			folio = shmem_read_folio_gfp(mapping, i, pos + bytes, gfp);
 			if (!IS_ERR(folio))
 				break;
 
diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 6f2e58be4f3e..0c90ae338afb 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -100,7 +100,7 @@ ttm_backup_backup_page(struct file *backup, struct page *page,
 	struct folio *to_folio;
 	int ret;
 
-	to_folio = shmem_read_folio_gfp(mapping, idx, alloc_gfp);
+	to_folio = shmem_read_folio_gfp(mapping, idx, 0, alloc_gfp);
 	if (IS_ERR(to_folio))
 		return PTR_ERR(to_folio);
 
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..203eebad6b38 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -156,12 +156,12 @@ enum sgp_type {
 int shmem_get_folio(struct inode *inode, pgoff_t index, loff_t write_end,
 		struct folio **foliop, enum sgp_type sgp);
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
-		pgoff_t index, gfp_t gfp);
+		pgoff_t index, loff_t end, gfp_t gfp);
 
 static inline struct folio *shmem_read_folio(struct address_space *mapping,
 		pgoff_t index)
 {
-	return shmem_read_folio_gfp(mapping, index, mapping_gfp_mask(mapping));
+	return shmem_read_folio_gfp(mapping, index, 0, mapping_gfp_mask(mapping));
 }
 
 static inline struct page *shmem_read_mapping_page(
diff --git a/mm/shmem.c b/mm/shmem.c
index e6cdfda08aed..c79f5760cfc9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5960,6 +5960,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  * shmem_read_folio_gfp - read into page cache, using specified page allocation flags.
  * @mapping:	the folio's address_space
  * @index:	the folio index
+ * @end:	end of a read if allocating a new folio
  * @gfp:	the page allocator flags to use if allocating
  *
  * This behaves as a tmpfs "read_cache_page_gfp(mapping, index, gfp)",
@@ -5972,14 +5973,14 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  * with the mapping_gfp_mask(), to avoid OOMing the machine unnecessarily.
  */
 struct folio *shmem_read_folio_gfp(struct address_space *mapping,
-		pgoff_t index, gfp_t gfp)
+		pgoff_t index, loff_t end, gfp_t gfp)
 {
 #ifdef CONFIG_SHMEM
 	struct inode *inode = mapping->host;
 	struct folio *folio;
 	int error;
 
-	error = shmem_get_folio_gfp(inode, index, 0, &folio, SGP_CACHE,
+	error = shmem_get_folio_gfp(inode, index, end, &folio, SGP_CACHE,
 				    gfp, NULL, NULL);
 	if (error)
 		return ERR_PTR(error);
@@ -5998,7 +5999,7 @@ EXPORT_SYMBOL_GPL(shmem_read_folio_gfp);
 struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 					 pgoff_t index, gfp_t gfp)
 {
-	struct folio *folio = shmem_read_folio_gfp(mapping, index, gfp);
+	struct folio *folio = shmem_read_folio_gfp(mapping, index, 0, gfp);
 	struct page *page;
 
 	if (IS_ERR(folio))
-- 
2.43.5


