Return-Path: <linux-kernel+bounces-720406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D481AFBB29
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B17189805A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E77265CDF;
	Mon,  7 Jul 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9OzfS1L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BC263F32
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914273; cv=none; b=WhDFr9RG9sm+YfHqzj+NVOtrb3v8GOftofg8FYya9BQ0bliDpVwCDkeiz3j4PC4XkTlv7WAgbDsPB9uIgIDB8XHoIOoZMnt5vRUTbT8ktbvR/jfrYleg/0KccRQKQMHmFHE+kBmlaCBi7ksX+a1KG2oaGsAPvlAZeRAFGFYdESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914273; c=relaxed/simple;
	bh=e7Ob1j5nNs4Mjt6CAllzqdsEtj1C5YLoOgEZzuKt9ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oopCGGBC2tI6aiOSvw4US6XfdXjyVWwkTuvN/lXqVP2fLCk3jSWbtF2hfv/9pFaZBG3pDMo4t7Y0phWLCvwDznxw/QF+Ay7nbc0jEDQzG8J+X8guhmMgjYubpkc5sd4K8VEGyA/Jv6GxZGt9UIHoGpV9VTWJ7WC89Nbk5VRlqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9OzfS1L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751914270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBV6EKgPVG18COxzAU7Q5x6IQNu6IJXp+IEOudQo7nI=;
	b=V9OzfS1LFDZzQAE2dpOFs0/PelsKpr1ajKdzA3uqJ/0Glc+AbtCctZiSm6gZtm/9RGEoSS
	qgpW9ttNQJTeXkCmYkcUxjIne/nBC2alb7//CzuBjBmQExbRI1h8kFZs/73pKFBhSy3x+N
	zsLP9hZ1x89ekVpp+pywb/3m6vDh2XQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-0Y-PJ3nsNjKuMpUol191nw-1; Mon,
 07 Jul 2025 14:51:07 -0400
X-MC-Unique: 0Y-PJ3nsNjKuMpUol191nw-1
X-Mimecast-MFC-AGG-ID: 0Y-PJ3nsNjKuMpUol191nw_1751914266
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D27419560AE;
	Mon,  7 Jul 2025 18:51:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3B3219560B2;
	Mon,  7 Jul 2025 18:51:04 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org
Subject: [PATCH v2 2/4] mm/util: introduce snapshot_page()
Date: Mon,  7 Jul 2025 14:50:44 -0400
Message-ID: <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
In-Reply-To: <cover.1751914235.git.luizcap@redhat.com>
References: <cover.1751914235.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This commit refactors __dump_page() into snapshot_page().

snapshot_page() tries to take a faithful snapshot of a page and its
folio representation. The snapshot is returned in the struct
page_snapshot parameter along with additional flags that are best
retrieved at snapshot creation time to reduce race windows.

This function is intended to be used by callers that need a stable
representation of a struct page and struct folio so that pointers
or page information doesn't change while working on a page.

The idea and original implementation of snapshot_page() comes from
Matthew Wilcox with suggestions for improvements from David Hildenbrand.
All bugs and misconceptions are mine.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/mm.h | 19 ++++++++++++
 mm/debug.c         | 42 +++----------------------
 mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 38 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..090968c6eebb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
 }
 #endif
 
+#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
+#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)
+#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
+
+struct page_snapshot {
+	struct folio folio_snapshot;
+	struct page page_snapshot;
+	unsigned long pfn;
+	unsigned long idx;
+	unsigned long flags;
+};
+
+static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
+{
+	return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
+}
+
+void snapshot_page(struct page_snapshot *ps, const struct page *page);
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/debug.c b/mm/debug.c
index 907382257062..7349330ea506 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
 
 static void __dump_page(const struct page *page)
 {
-	struct folio *foliop, folio;
-	struct page precise;
-	unsigned long head;
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long idx, nr_pages = 1;
-	int loops = 5;
-
-again:
-	memcpy(&precise, page, sizeof(*page));
-	head = precise.compound_head;
-	if ((head & 1) == 0) {
-		foliop = (struct folio *)&precise;
-		idx = 0;
-		if (!folio_test_large(foliop))
-			goto dump;
-		foliop = (struct folio *)page;
-	} else {
-		foliop = (struct folio *)(head - 1);
-		idx = folio_page_idx(foliop, page);
-	}
+	struct page_snapshot ps;
 
-	if (idx < MAX_FOLIO_NR_PAGES) {
-		memcpy(&folio, foliop, 2 * sizeof(struct page));
-		nr_pages = folio_nr_pages(&folio);
-		if (nr_pages > 1)
-			memcpy(&folio.__page_2, &foliop->__page_2,
-			       sizeof(struct page));
-		foliop = &folio;
-	}
-
-	if (idx > nr_pages) {
-		if (loops-- > 0)
-			goto again;
+	snapshot_page(&ps, page);
+	if (!snapshot_page_is_faithful(&ps))
 		pr_warn("page does not match folio\n");
-		precise.compound_head &= ~1UL;
-		foliop = (struct folio *)&precise;
-		idx = 0;
-	}
 
-dump:
-	__dump_folio(foliop, &precise, pfn, idx);
+	__dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
 }
 
 void dump_page(const struct page *page, const char *reason)
diff --git a/mm/util.c b/mm/util.c
index 0b270c43d7d1..c38d213be83f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/compat.h>
 #include <linux/fsnotify.h>
+#include <linux/page_idle.h>
 
 #include <linux/uaccess.h>
 
@@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 EXPORT_SYMBOL(compat_vma_mmap_prepare);
+
+static void set_flags(struct page_snapshot *ps, const struct folio *folio,
+		      const struct page *page)
+{
+	/*
+	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
+	 * on the head page.
+	 */
+	if (PageBuddy(page))
+		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
+	else if (page_count(page) == 0 && is_free_buddy_page(page))
+		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
+
+	if (folio_test_idle(folio))
+		ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
+}
+
+/*
+ * Create a snapshot of a page and store its struct page and struct folio
+ * representations in a struct page_snapshot.
+ *
+ * @ps: struct page_snapshot to store the page snapshot
+ * @page: the page we want to snapshot
+ *
+ * Note that creating a faithful snapshot of a page may fail if the page
+ * compound keeps changing (eg. due to folio split). In this case we set
+ * ps->faithful to false and the snapshot will assume that @page refers
+ * to a single page.
+ */
+void snapshot_page(struct page_snapshot *ps, const struct page *page)
+{
+	unsigned long head, nr_pages = 1;
+	struct folio *foliop, folio;
+	int loops = 5;
+
+	ps->pfn = page_to_pfn(page);
+	ps->flags = PAGE_SNAPSHOT_FAITHFUL;
+
+again:
+	memcpy(&ps->page_snapshot, page, sizeof(*page));
+	head = ps->page_snapshot.compound_head;
+	if ((head & 1) == 0) {
+		foliop = (struct folio *)&ps->page_snapshot;
+		ps->idx = 0;
+		if (!folio_test_large(foliop)) {
+			set_flags(ps, page_folio(page), page);
+			goto out;
+		}
+		foliop = (struct folio *)page;
+	} else {
+		foliop = (struct folio *)(page->compound_head - 1);
+		ps->idx = folio_page_idx(foliop, page);
+	}
+
+	if (ps->idx < MAX_FOLIO_NR_PAGES) {
+		memcpy(&folio, foliop, 2 * sizeof(struct page));
+		nr_pages = folio_nr_pages(&folio);
+		if (nr_pages > 1)
+			memcpy(&folio.__page_2, &foliop->__page_2,
+			       sizeof(struct page));
+		set_flags(ps, foliop, page);
+		foliop = &folio;
+	}
+
+	if (ps->idx > nr_pages) {
+		if (loops-- > 0)
+			goto again;
+		ps->page_snapshot.compound_head &= ~1UL;
+		foliop = (struct folio *)&ps->page_snapshot;
+		ps->flags = 0;
+		ps->idx = 0;
+	}
+
+out:
+	memcpy(&ps->folio_snapshot, foliop, sizeof(struct folio));
+}
-- 
2.50.0


