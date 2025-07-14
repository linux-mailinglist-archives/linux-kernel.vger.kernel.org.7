Return-Path: <linux-kernel+bounces-730036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC35B03F71
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4D81A625B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61A25291B;
	Mon, 14 Jul 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHH17d5x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCB24DD0A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499041; cv=none; b=uKMzjnLLRjZg+fEeNDxDOIeMvUVfK8h9AXd9TFPAQWkcuAKeo7XSZ2+Lq3GKm7eGuyOo5PsfKKkU1oE5Q9dSmKPyJRObpVrlkLY/dqpLsBFH/PtNpbZhkSJ9BjGKVhoH1egdumritmyjaCXZhIkKhejp+aGzVQWV+MkqckDd0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499041; c=relaxed/simple;
	bh=OU3p7ZD7Je4BWV16C8j4MBKjwcozASiSqaaRu4MZpx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orn3D+u6/tmgn4veYkDRxiJqhnFQZWvxUPpfcCDtwH6hzRx176eUhRFpyXk6J9C64pT/SX1LNA833yNFCWn+E+9x+COFlBZIXo15NwGij271lg1BQnCxMaphuvJvaISP1dsY0KGSltUllFBo2ycHg9NnDQpMg1HK6Nl637H2P20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHH17d5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynXGS3UbV4776sA/q7fw/bdeOIQTeuFUbD3iRS8icfM=;
	b=XHH17d5x2FQBG4TSiKRNPHmxkHfMq6o14nrSFoSKlE0wneSkNT47y2k4hVSC0N6Al4G6TK
	3pwTOpDu4IFox7Mmvr2ajbOxVqxMDyzy0qYK6u/wkg+Sy4S1I+pGjpxvdXx/qdDxsZm8tU
	mroFpNMriMxpphrMHm14pp6TCNyWbLY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-V_U7AeCoMcyllFn2sWRvcQ-1; Mon,
 14 Jul 2025 09:17:14 -0400
X-MC-Unique: V_U7AeCoMcyllFn2sWRvcQ-1
X-Mimecast-MFC-AGG-ID: V_U7AeCoMcyllFn2sWRvcQ_1752499032
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ECCE18001D6;
	Mon, 14 Jul 2025 13:17:12 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97035180035E;
	Mon, 14 Jul 2025 13:17:10 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org,
	harry.yoo@oracle.com
Subject: [PATCH v3 2/4] mm/util: introduce snapshot_page()
Date: Mon, 14 Jul 2025 09:16:52 -0400
Message-ID: <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
In-Reply-To: <cover.1752499009.git.luizcap@redhat.com>
References: <cover.1752499009.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 include/linux/mm.h | 19 +++++++++++
 mm/debug.c         | 42 +++---------------------
 mm/util.c          | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 38 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..929e2330af13 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
 }
 #endif
 
+#define PAGE_SNAPSHOT_FAITHFUL (1 << 0)
+#define PAGE_SNAPSHOT_PG_BUDDY (1 << 1)
+#define PAGE_SNAPSHOT_PG_IDLE  (1 << 2)
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
index 0b270c43d7d1..f270bf42465b 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/compat.h>
 #include <linux/fsnotify.h>
+#include <linux/page_idle.h>
 
 #include <linux/uaccess.h>
 
@@ -1171,3 +1172,81 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 EXPORT_SYMBOL(compat_vma_mmap_prepare);
+
+static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
+			 const struct page *page)
+{
+	/*
+	 * Only the first page of a high-order buddy page has PageBuddy() set.
+	 * So we have to check manually whether this page is part of a high-
+	 * order buddy page.
+	 */
+	if (PageBuddy(page))
+		ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
+	else if (page_count(page) == 0 && is_free_buddy_page(page))
+		ps->flags |= PAGE_SNAPSHOT_PG_BUDDY;
+
+	if (folio_test_idle(folio))
+		ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
+}
+
+/**
+ * snapshot_page() - Create a snapshot of a struct page
+ * @ps: Pointer to a struct page_snapshot to store the page snapshot
+ * @page: The page to snapshot
+ *
+ * Create a snapshot of the page and store both its struct page and struct
+ * folio representations in @ps.
+ *
+ * Note that creating a faithful snapshot may fail if the compound
+ * state of the page keeps changing (e.g., due to a folio split). In
+ * this case, ps->faithful is set to false, and the snapshot assumes
+ * that @page refers to a single page.
+ */
+void snapshot_page(struct page_snapshot *ps, const struct page *page)
+{
+	unsigned long head, nr_pages = 1;
+	struct folio *foliop;
+	int loops = 5;
+
+	ps->pfn = page_to_pfn(page);
+	ps->flags = PAGE_SNAPSHOT_FAITHFUL;
+
+again:
+	memset(&ps->folio_snapshot, 0, sizeof(struct folio));
+	memcpy(&ps->page_snapshot, page, sizeof(*page));
+	head = ps->page_snapshot.compound_head;
+	if ((head & 1) == 0) {
+		ps->idx = 0;
+		foliop = (struct folio *)&ps->page_snapshot;
+		if (!folio_test_large(foliop)) {
+			set_ps_flags(ps, page_folio(page), page);
+			memcpy(&ps->folio_snapshot, foliop,
+			       sizeof(struct page));
+			return;
+		}
+		foliop = (struct folio *)page;
+	} else {
+		foliop = (struct folio *)(head - 1);
+		ps->idx = folio_page_idx(foliop, page);
+	}
+
+	if (ps->idx < MAX_FOLIO_NR_PAGES) {
+		memcpy(&ps->folio_snapshot, foliop, 2 * sizeof(struct page));
+		nr_pages = folio_nr_pages(&ps->folio_snapshot);
+		if (nr_pages > 1)
+			memcpy(&ps->folio_snapshot.__page_2, &foliop->__page_2,
+			       sizeof(struct page));
+		set_ps_flags(ps, foliop, page);
+	}
+
+	if (ps->idx > nr_pages) {
+		if (loops-- > 0)
+			goto again;
+		clear_compound_head(&ps->page_snapshot);
+		foliop = (struct folio *)&ps->page_snapshot;
+		memcpy(&ps->folio_snapshot, foliop, sizeof(struct page));
+		ps->flags = 0;
+		ps->idx = 0;
+	}
+}
-- 
2.50.0


