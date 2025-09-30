Return-Path: <linux-kernel+bounces-837141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01EBAB831
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE19D3AC75B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98F272801;
	Tue, 30 Sep 2025 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmySo2y1"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B281AA8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211324; cv=none; b=e0URYUB+XoPlTPw3pWe8C8ixPWqF7Drm33RDRbA1XDfNsNjedtwP6zYW7W4ehxJJ9T08Gmss7gPkggjWmRyTHfSmbrw+CsQAwSgNR46G4DNgCMxdHwO0XjPIJ0x1daDcc3j28uv6AlkYy8EfXyJzUC3JmYBLbZhygOrnbUDv38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211324; c=relaxed/simple;
	bh=SNRYBD4X4fwTVxPq80TRyriRlAZ/CE6idASjkD7FGyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YO1kuXDwMty6Z1m1P8d+f/AqgldA5+SwLeDvHCVucbOH4eFoERvx+tLbUKJwRzzb8UJbgs/LWAbkYKbmCb3or2KNznRm4pQ9RWO8fb7lJ7h2V7eKbf9dZp8+AgQpLdCw/82xqsikSUsqO6fXa1CqOdtR89boBwQOUICI7t1m3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmySo2y1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759211319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nwaNOsPaMPcKzgmglNmEscXlbXRyMv0Han6sLSHWCaw=;
	b=pmySo2y1mTUj+Hr/IcBN2zZF4HXhBVlZfNevClLH2GLrdQbgELHVg/tH2snIP35hUgWF5D
	GtGv3022ovPF1dxHmfPX6ELwctMadEKOPOGRuci7evFLZ3qI8xyt0eE/BinJpQoVaUnE9o
	BsNLPkkhumB/Lx+JR8Lex2DfmeVAJfM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org
Subject: [PATCH] mm: readahead: make thp readahead conditional to mmap_miss logic
Date: Tue, 30 Sep 2025 07:48:15 +0200
Message-ID: <20250930054815.132075-1-roman.gushchin@linux.dev>
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
Cc: linux-mm@kvack.org
---
 mm/filemap.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a52dd38d2b4a..b67d7981fafb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3235,34 +3235,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	vm_flags_t vm_flags = vmf->vma->vm_flags;
+	bool force_thp_readahead = false;
 	unsigned short mmap_miss;
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* Use the readahead code, even if readahead is disabled */
-	if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
-		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
-		ra->size = HPAGE_PMD_NR;
-		/*
-		 * Fetch two PMD folios, so we get the chance to actually
-		 * readahead, unless we've been told not to.
-		 */
-		if (!(vm_flags & VM_RAND_READ))
-			ra->size *= 2;
-		ra->async_size = HPAGE_PMD_NR;
-		ra->order = HPAGE_PMD_ORDER;
-		page_cache_ra_order(&ractl, ra);
-		return fpin;
-	}
-#endif
-
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
+	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
+		force_thp_readahead = true;
 	/*
 	 * If we don't want any read-ahead, don't bother. VM_EXEC case below is
 	 * already intended for random access.
 	 */
 	if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
 		return fpin;
-	if (!ra->ra_pages)
+	if (!ra->ra_pages && !force_thp_readahead)
 		return fpin;
 
 	if (vm_flags & VM_SEQ_READ) {
@@ -3283,6 +3269,22 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	if (mmap_miss > MMAP_LOTSAMISS)
 		return fpin;
 
+	if (force_thp_readahead) {
+		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
+		ra->size = HPAGE_PMD_NR;
+		/*
+		 * Fetch two PMD folios, so we get the chance to actually
+		 * readahead, unless we've been told not to.
+		 */
+		if (!(vm_flags & VM_RAND_READ))
+			ra->size *= 2;
+		ra->async_size = HPAGE_PMD_NR;
+		ra->order = HPAGE_PMD_ORDER;
+		page_cache_ra_order(&ractl, ra);
+		return fpin;
+	}
+
 	if (vm_flags & VM_EXEC) {
 		/*
 		 * Allow arch to request a preferred minimum folio order for
-- 
2.51.0


