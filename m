Return-Path: <linux-kernel+bounces-730037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897EDB03F74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D216E9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3A81F7098;
	Mon, 14 Jul 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCPw2gXe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C62325393C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499044; cv=none; b=QuuOxjY9ZtotuUSQAWvOYSjM0Mrp/oU73d3CTS4+R3AFisMe7it3wPOdlYWOF1sMIx35XQtjigtEy3bqSTcD8Oa6bub+YJ0h55xEhC+vKpr72GQY5Kv0dUEb7HMBm1dTfx/13JECk4gCZ4LrKDBFADlC43TDevsiK5CckCc+v94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499044; c=relaxed/simple;
	bh=HI+ls1uhcjl2xzKioEZcsu9yaVQyGvMvx+q4n/3XbI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6s9I38tChO/aV0BKpsR5PpKKDjyquKLWFADYFfeiLJhk+QCLGJhgu2zL7rU+DxAXDMxvrB51h8rxsgWVZHKBvxWSJBZUUr+VajeU5PGTIZXc4mBLGIhqIZkSu2DYsdVNIS7pcDrOcXWH2cSAdCTPc0L1kZkQg37ObOgVedQcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FCPw2gXe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPBx35LRg/lHdTXAHcUxuRahtl/Vjvqe5PsZWwJTjtI=;
	b=FCPw2gXe75uA9Njqdkh8vcgWUNjRMBM1J1JOsV3OaDHarDrGblcfDUnqg6ogxgMNVVx/FT
	YLApLemTRVYsTALon0jjLcR9ABLu6DDZAJYwM3LXjkS81Eq03UrTm6aKAy3t/yPtv+IBVC
	BoxQdQ+mOcodjqboLzgcI9pq/ra+qAs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-wxL77xLTOK6D7_5OwZo9DA-1; Mon,
 14 Jul 2025 09:17:17 -0400
X-MC-Unique: wxL77xLTOK6D7_5OwZo9DA-1
X-Mimecast-MFC-AGG-ID: wxL77xLTOK6D7_5OwZo9DA_1752499036
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0595180028A;
	Mon, 14 Jul 2025 13:17:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D21F1803AF2;
	Mon, 14 Jul 2025 13:17:14 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org,
	harry.yoo@oracle.com
Subject: [PATCH v3 4/4] fs: stable_page_flags(): use snapshot_page()
Date: Mon, 14 Jul 2025 09:16:54 -0400
Message-ID: <52c16c0f00995a812a55980c2f26848a999a34ab.1752499009.git.luizcap@redhat.com>
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

A race condition is possible in stable_page_flags() where user-space is
reading /proc/kpageflags concurrently to a folio split. This may lead to
oopses or BUG_ON()s being triggered.

To fix this, this commit uses snapshot_page() in stable_page_flags() so
that stable_page_flags() works with a stable page and folio snapshots
instead.

Note that stable_page_flags() makes use of some functions that require
the original page or folio pointer to work properly (eg.
is_free_budy_page() and folio_test_idle()). Since those functions can't
be used on the page snapshot, we replace their usage with flags that
were set by snapshot_page() for this purpose.

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 fs/proc/page.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 936f8bbe5a6f..52e4f49c0638 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -147,6 +147,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 u64 stable_page_flags(const struct page *page)
 {
 	const struct folio *folio;
+	struct page_snapshot ps;
 	unsigned long k;
 	unsigned long mapping;
 	bool is_anon;
@@ -158,7 +159,9 @@ u64 stable_page_flags(const struct page *page)
 	 */
 	if (!page)
 		return 1 << KPF_NOPAGE;
-	folio = page_folio(page);
+
+	snapshot_page(&ps, page);
+	folio = &ps.folio_snapshot;
 
 	k = folio->flags;
 	mapping = (unsigned long)folio->mapping;
@@ -167,7 +170,7 @@ u64 stable_page_flags(const struct page *page)
 	/*
 	 * pseudo flags for the well known (anonymous) memory mapped pages
 	 */
-	if (page_mapped(page))
+	if (folio_mapped(folio))
 		u |= 1 << KPF_MMAP;
 	if (is_anon) {
 		u |= 1 << KPF_ANON;
@@ -179,7 +182,7 @@ u64 stable_page_flags(const struct page *page)
 	 * compound pages: export both head/tail info
 	 * they together define a compound page's start/end pos and order
 	 */
-	if (page == &folio->page)
+	if (ps.idx == 0)
 		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
 	else
 		u |= 1 << KPF_COMPOUND_TAIL;
@@ -189,25 +192,19 @@ u64 stable_page_flags(const struct page *page)
 	         folio_test_large_rmappable(folio)) {
 		/* Note: we indicate any THPs here, not just PMD-sized ones */
 		u |= 1 << KPF_THP;
-	} else if (is_huge_zero_folio(folio)) {
+	} else if (is_huge_zero_pfn(ps.pfn)) {
 		u |= 1 << KPF_ZERO_PAGE;
 		u |= 1 << KPF_THP;
-	} else if (is_zero_folio(folio)) {
+	} else if (is_zero_pfn(ps.pfn)) {
 		u |= 1 << KPF_ZERO_PAGE;
 	}
 
-	/*
-	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
-	 * on the head page.
-	 */
-	if (PageBuddy(page))
-		u |= 1 << KPF_BUDDY;
-	else if (page_count(page) == 0 && is_free_buddy_page(page))
+	if (ps.flags & PAGE_SNAPSHOT_PG_BUDDY)
 		u |= 1 << KPF_BUDDY;
 
-	if (PageOffline(page))
+	if (folio_test_offline(folio))
 		u |= 1 << KPF_OFFLINE;
-	if (PageTable(page))
+	if (folio_test_pgtable(folio))
 		u |= 1 << KPF_PGTABLE;
 	if (folio_test_slab(folio))
 		u |= 1 << KPF_SLAB;
@@ -215,7 +212,7 @@ u64 stable_page_flags(const struct page *page)
 #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
 	u |= kpf_copy_bit(k, KPF_IDLE,          PG_idle);
 #else
-	if (folio_test_idle(folio))
+	if (ps.flags & PAGE_SNAPSHOT_PG_IDLE)
 		u |= 1 << KPF_IDLE;
 #endif
 
@@ -241,7 +238,7 @@ u64 stable_page_flags(const struct page *page)
 	if (u & (1 << KPF_HUGE))
 		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
 	else
-		u |= kpf_copy_bit(page->flags, KPF_HWPOISON,	PG_hwpoison);
+		u |= kpf_copy_bit(ps.page_snapshot.flags, KPF_HWPOISON, PG_hwpoison);
 #endif
 
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
-- 
2.50.0


