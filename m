Return-Path: <linux-kernel+bounces-843293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93633BBEDA6
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427713BFE45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BC9246BB4;
	Mon,  6 Oct 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAg+ao8U"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15D199237
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773086; cv=none; b=GW5IdaSJNHa63ZslF9fkRe0M09lHIM8KjGYky4bZlO2Zt9e5Ek918ddnGv9AY1H+gReHHKMRoHsXJbWC+9pHERaIfUWvJLlEgNmgktJfGElGKWICl0UAv2KWO2VKBZqqubFAsoEnzxr9NwW9mB+cKIyOQVTdx9yImS8zoJchQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773086; c=relaxed/simple;
	bh=eDUXs7ScxA5xbX00G5qcGbvHjCgTcMBubaO0lWT/R5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKmSj5PESv5/rIqJHbW/ZU45s8B1wUVU2Q6UpQIYGAVxHz5lHN5hBoOI2+93BFPA3gZGG8oH/YBd58CBAWz3DZaAu19s1A9C2nJ3fonwILDW73AphwfUvGIsDyPF85IAcCPt0Ft4PtuN5ZpVu6v0Mjf14VzXlTqGbffx6ZTNVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAg+ao8U; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759773081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qleRauGEj+bb9sgaaA3graHFC3gh/W99qbG2F0J96jE=;
	b=NAg+ao8U/6KBCPsnfzZcwwdqcMtsZXjQyFTJxdE789iThOvflZWEQU3w522WKFskq38XKO
	J0Hi/whc6xsJ9GIbFJUnywtlB+zqXnGhEQU5665RzuZZSAw6U85NOhf/OGZwPmc0uO4Rb2
	pjXTZj8TdAkUNpQgPF4cotBJHjDl41A=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org
Subject: [PATCH v3] mm: readahead: make thp readahead conditional to mmap_miss logic
Date: Mon,  6 Oct 2025 10:51:06 -0700
Message-ID: <20251006175106.377411-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
introduced a special handling for VM_HUGEPAGE mappings: even if the
readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
allocated.

This change causes a significant regression for containers with a
tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
commit, mmap_miss logic would eventually lead to the readahead
disablement, effectively reducing the memory pressure in the
cgroup. With this change the kernel is trying to allocate 1-2 huge
pages for each fault, no matter if these pages are used or not
before being evicted, increasing the memory pressure multi-fold.

To fix the regression, let's make the new VM_HUGEPAGE conditional
to the mmap_miss check, but keep independent from the ra->ra_pages.
This way the main intention of commit 4687fdbb805a ("mm/filemap:
Support VM_HUGEPAGE for file mappings") stays intact, but the
regression is resolved.

The logic behind this changes is simple: even if a user explicitly
requests using huge pages to back the file mapping (using VM_HUGEPAGE
flag), under a very strong memory pressure it's better to fall back
to ordinary pages.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org

--

v3: fixed VM_SEQ_READ handling for the THP case (by Jan Kara)
v2: fixed VM_SEQ_READ handling (by Dev Jain)
---
 mm/filemap.c | 68 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a52dd38d2b4a..ec731ac05551 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3235,11 +3235,47 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	vm_flags_t vm_flags = vmf->vma->vm_flags;
+	bool force_thp_readahead = false;
 	unsigned short mmap_miss;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
-	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
+		force_thp_readahead = true;
+
+	if (!force_thp_readahead) {
+		/*
+		 * If we don't want any read-ahead, don't bother.
+		 * VM_EXEC case below is already intended for random access.
+		 */
+		if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
+			return fpin;
+
+		if (!ra->ra_pages)
+			return fpin;
+
+		if (vm_flags & VM_SEQ_READ) {
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+			page_cache_sync_ra(&ractl, ra->ra_pages);
+			return fpin;
+		}
+	}
+
+	if (!(vm_flags & VM_SEQ_READ)) {
+		/* Avoid banging the cache line if not needed */
+		mmap_miss = READ_ONCE(ra->mmap_miss);
+		if (mmap_miss < MMAP_LOTSAMISS * 10)
+			WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
+
+		/*
+		 * Do we miss much more than hit in this file? If so,
+		 * stop bothering with read-ahead. It will only hurt.
+		 */
+		if (mmap_miss > MMAP_LOTSAMISS)
+			return fpin;
+	}
+
+	if (force_thp_readahead) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
 		ra->size = HPAGE_PMD_NR;
@@ -3254,34 +3290,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		page_cache_ra_order(&ractl, ra);
 		return fpin;
 	}
-#endif
-
-	/*
-	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
-	 * already intended for random access.
-	 */
-	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
-		return fpin;
-	if (!ra->ra_pages)
-		return fpin;
-
-	if (vm_flags & VM_SEQ_READ) {
-		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_sync_ra(&ractl, ra->ra_pages);
-		return fpin;
-	}
-
-	/* Avoid banging the cache line if not needed */
-	mmap_miss = READ_ONCE(ra->mmap_miss);
-	if (mmap_miss < MMAP_LOTSAMISS * 10)
-		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
-
-	/*
-	 * Do we miss much more than hit in this file? If so,
-	 * stop bothering with read-ahead. It will only hurt.
-	 */
-	if (mmap_miss > MMAP_LOTSAMISS)
-		return fpin;
 
 	if (vm_flags & VM_EXEC) {
 		/*
-- 
2.51.0


