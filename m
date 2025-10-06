Return-Path: <linux-kernel+bounces-842545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D38BBCF93
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7B93B2230
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3BF1A76B1;
	Mon,  6 Oct 2025 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qq6F2KCp"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441E8F6F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759715673; cv=none; b=KcqZNmXZGbIR+DDaImp7R8q7qHnzCg7P3gLCkDpKCC2mHKb34GfHfaZfXkwxuhCgIdt8kWqmn6M4tqNYsBaLr847Lzu8Ja+ZFsGABfBtBvc6+N9/9K91qLb0RX+HskExzQrYqPl2gYRVy5Cgy7w9PA48uG2JIy7oZTYFbCS4Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759715673; c=relaxed/simple;
	bh=k1/zhNC7Ha84iaLpbdzi3xu1FQy6GGDI/Tr3ER63lNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skNDjFoiqvkqMN5OZyl88oE0jWNyXm8f/0gTssJVRXmup1QaKdb6pVBMyjmtVtG6RuxXEa8SQfRSwUNMoPaln+xFZd9CIsRU5mjvUfNb17Ybh/Eo+ACPBlnM6iL94RgPfJY2DzAClKYIcA/sqbPxAzxgOWZEizuzZMcWavmQAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qq6F2KCp; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759715668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rIzE1DNf7pyKHPK9V7hAuDP65Ms8fhGAUyjyUKo/y3A=;
	b=qq6F2KCpVRwuzCljJJPJzXdZB9Y4q4G6zEhhvpBZH3ZZKWYBsOX7YUwGZOvJVYvPT3tkoz
	xObaXXAj8mSHKEijoyaXsVll/B/uYZPTKFt0DNie+ELpvV6C4V/rsYr/J6eX7+8ZNS0X8f
	1IeisbtIyaCUmqG1a/ASMNNumdQNOpg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org
Subject: [PATCH v2] mm: readahead: make thp readahead conditional to mmap_miss logic
Date: Sun,  5 Oct 2025 18:54:09 -0700
Message-ID: <20251006015409.342697-1-roman.gushchin@linux.dev>
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
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org

--

v2: fixed VM_SEQ_READ handling (by Dev Jain)
---
 mm/filemap.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a52dd38d2b4a..446e591d57e5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3235,37 +3235,23 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
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
 
-	if (vm_flags & VM_SEQ_READ) {
+	if ((vm_flags & VM_SEQ_READ) && !force_thp_readahead) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		page_cache_sync_ra(&ractl, ra->ra_pages);
 		return fpin;
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


