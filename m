Return-Path: <linux-kernel+bounces-709469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF02AAEDE36
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D154B7AB518
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88B293B5C;
	Mon, 30 Jun 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrRMlK7J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105F28FFCF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288489; cv=none; b=DDSXC9KVugBFWrGbp2HzUhe0CvwMUr0TvSjsvpR7DgRacOJapQLqBAZgkncEF5LT0T4BdVGwxjT4yTRpyeOawkzYqjP3IhlPt+g06E3EnhcKJZIAWQHAYfm2gmBCrZkTImmP/ElFKm9OCnHaFdbEBMHqrSAxxB4ifIozQzEdBhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288489; c=relaxed/simple;
	bh=D2PbFe0TDfmvy4F7QksDSc2nDP/2ml7oXT564/tmyrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDuhAZjXIbmnB4iOYpEN0estuEUa8r6bWQPqLXuuurZzf3+JGA7SuBamrXUzJEVDgAob8CZj20pa3enPMlYsEa5y2/kxGJ6/fX0/ERC3oum6zArVS0a+64Rn6Ue2Oqrcu4duy2Rc7be4Ohi926mUsRV2nv/lvS5JbVrjcg1gv10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrRMlK7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751288483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CWZGmTCKoL1hvQ/VyDOYb4tfyG8bAvHTQtdKrki7q8=;
	b=VrRMlK7JxTf3tYzuaRKtyawbmFkVC7L9KZAcx5laMie1QrLYLL85ynGh0b+AIY1PCtupXR
	mB2gHbT56txgQGnaPBlqXqa8qJn5EB2gU64B4w0fucYBL/V8ybnE/GV5m8z1067aG/qpLT
	kYqd2YNN+Y88OCpwDBG27y5Bo0EDsTg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-13Wa-D2zN2y25FaMgbw0RA-1; Mon, 30 Jun 2025 09:01:15 -0400
X-MC-Unique: 13Wa-D2zN2y25FaMgbw0RA-1
X-Mimecast-MFC-AGG-ID: 13Wa-D2zN2y25FaMgbw0RA_1751288474
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so723548f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 06:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751288474; x=1751893274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CWZGmTCKoL1hvQ/VyDOYb4tfyG8bAvHTQtdKrki7q8=;
        b=U4tNpNAN419VE0qifpJdiRO/kUOlQFpB2m/CQwMRmF4BBTnbGYMUBA+oNDeSyYQUih
         io6xEleb8gAu3BNGxnCSoxaukzCKJSJ6UFyv0u54ozHkkz85tpiUZcdm1G9mkdDdwPZW
         v/3pceyNJYf8ng1Sqiu285uy20hnR0LRdDv123Lz8iS8cAPvAPGl3c6QcFYi6swu3JTt
         ei8KCyNT28HqLFPVBjJlKf6amTrDW0kXJ7mTqud5J8U5GWAJFteJxzx1ZVg+T50b42Bp
         ZMSNT7q8yHyH5yKZObGRv01ZwD1ohKj5kdhuOKEVrquw1Yv8m0uWo0lNOPi9lK4P8VIR
         4iuA==
X-Gm-Message-State: AOJu0Yz/MW0HD0nYcDu9h7gTAfRFy3i50cw8JiunCSX+C4RRY9Hbne8G
	KUzdVQdqHZ78ZowwKsMHdETerESXDuONadp9Z1dL6/W+0Axg8z/iC6IlVo0XPeceDVm5XeNPX0S
	xfRz8Dw7Kg+JMue50EfeZEh4NbNsNQ1GAbRJrRb+4qT5A/xNaUmw7yBGYKzWuz6u2su0dwFQXNk
	kWuz3HFo56EsAPzP411zsx17rRci4pNP0uIxB+ewJxrB9e7GzY
X-Gm-Gg: ASbGncstY+Q3zoXdJRggj3LBmWmGOKBl4uEb4AhflPrCm+hxhAsONfM6LIL0Hrt2ay+
	EnD3VScAll+4IT7euQU2U7hQeAKT1PMIu9skL1sgLlf1NH8aJw+zfe3/NeGGAMeah94QP2IgIhH
	DkpKTQVcpjDSppjwbiFE3EE03jLvoKHKX2EY6+biE1nmO4KhPWz9O19uZlEQNVEXJUDfEt80JPW
	At/TDawqpf6gX2ba0OjtrR2Hxl5qEnDGJI9NAmN2ZYD7mhNmQveuMo54kZvmhXekptBHc5tdJpi
	DEoMqiJHgzJXV7w0UuhcFcILZQXJ0Wyb778jrRyZQT9l9TZRYUYtkJe1PRRdQ1OOGAdBxVisgZa
	O7kCey4E=
X-Received: by 2002:a05:6000:2389:b0:3a4:e54c:adf2 with SMTP id ffacd0b85a97d-3a8f577fdc6mr12847957f8f.5.1751288473450;
        Mon, 30 Jun 2025 06:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ/9NZM6h/Hx4c51fxjBgSM5e1fSGf05yUg5gzNhGMoVHxQHOqc17Ov8/o/Ak8l4p0X+gKZQ==
X-Received: by 2002:a05:6000:2389:b0:3a4:e54c:adf2 with SMTP id ffacd0b85a97d-3a8f577fdc6mr12847789f8f.5.1751288472235;
        Mon, 30 Jun 2025 06:01:12 -0700 (PDT)
Received: from localhost (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a3fe592sm131954105e9.21.2025.06.30.06.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 06:01:11 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v1 20/29] mm: convert "movable" flag in page->mapping to a page flag
Date: Mon, 30 Jun 2025 15:00:01 +0200
Message-ID: <20250630130011.330477-21-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130011.330477-1-david@redhat.com>
References: <20250630130011.330477-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead, let's use a page flag. As the page flag can result in
false-positives, glue it to the page types for which we
support/implement movable_ops page migration.

The flag reused by PageMovableOps() might be sued by other pages, so
warning in case it is set in page_has_movable_ops() might result in
false-positive warnings.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h |  2 +-
 include/linux/migrate.h            |  8 -----
 include/linux/page-flags.h         | 52 ++++++++++++++++++++++++------
 mm/compaction.c                    |  6 ----
 mm/zpdesc.h                        |  2 +-
 5 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index a8a1706cc56f3..b222b0737c466 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -92,7 +92,7 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page);
+	SetPageMovableOps(page);
 	set_page_private(page, (unsigned long)balloon);
 	list_add(&page->lru, &balloon->pages);
 }
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 6aece3f3c8be8..acadd41e0b5cf 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -103,14 +103,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 #endif /* CONFIG_MIGRATION */
 
-#ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page);
-#else
-static inline void __SetPageMovable(struct page *page)
-{
-}
-#endif
-
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_folio_prepare(struct folio *folio,
 		struct vm_area_struct *vma, int node);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4c27ebb689e3c..016a6e6fa428a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -170,6 +170,11 @@ enum pageflags {
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
 
+#ifdef CONFIG_MIGRATION
+	/* this is a movable_ops page (for selected typed pages only) */
+	PG_movable_ops = PG_uptodate,
+#endif
+
 	/* Only valid for buddy pages. Used to track pages that are reported */
 	PG_reported = PG_uptodate,
 
@@ -698,9 +703,6 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
  * bit; and then folio->mapping points, not to an anon_vma, but to a private
  * structure which KSM associates with that merged page.  See ksm.h.
  *
- * PAGE_MAPPING_KSM without PAGE_MAPPING_ANON is used for non-lru movable
- * page and then folio->mapping points to a struct movable_operations.
- *
  * Please note that, confusingly, "folio_mapping" refers to the inode
  * address_space which maps the folio from disk; whereas "folio_mapped"
  * refers to user virtual address space into which the folio is mapped.
@@ -743,13 +745,6 @@ static __always_inline bool PageAnon(const struct page *page)
 {
 	return folio_test_anon(page_folio(page));
 }
-
-static __always_inline bool page_has_movable_ops(const struct page *page)
-{
-	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
-				PAGE_MAPPING_MOVABLE;
-}
-
 #ifdef CONFIG_KSM
 /*
  * A KSM page is one of those write-protected "shared pages" or "merged pages"
@@ -1133,6 +1128,43 @@ bool is_free_buddy_page(const struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
 
+#ifdef CONFIG_MIGRATION
+/*
+ * This page is migratable through movable_ops (for selected typed pages
+ * only).
+ *
+ * Page migration of such pages might fail, for example, if the page is
+ * already isolated by somebody else, or if the page is about to get freed.
+ *
+ * While a subsystem might set selected typed pages that support page migration
+ * as being movable through movable_ops, it must never clear this flag.
+ *
+ * This flag is only cleared when the page is freed back to the buddy.
+ *
+ * Only selected page types support this flag (see page_movable_ops()) and
+ * the flag might be used in other context for other pages. Always use
+ * page_has_movable_ops() instead.
+ */
+PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+#else
+PAGEFLAG_FALSE(MovableOps, movable_ops);
+#endif
+
+/**
+ * page_has_movable_ops - test for a movable_ops page
+ * @page The page to test.
+ *
+ * Test whether this is a movable_ops page. Such pages will stay that
+ * way until freed.
+ *
+ * Returns true if this is a movable_ops page, otherwise false.
+ */
+static inline bool page_has_movable_ops(const struct page *page)
+{
+	return PageMovableOps(page) &&
+	       (PageOffline(page) || PageZsmalloc(page));
+}
+
 static __always_inline int PageAnonExclusive(const struct page *page)
 {
 	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 348eb754cb227..349f4ea0ec3e5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -114,12 +114,6 @@ static unsigned long release_free_list(struct list_head *freepages)
 }
 
 #ifdef CONFIG_COMPACTION
-void __SetPageMovable(struct page *page)
-{
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	page->mapping = (void *)(PAGE_MAPPING_MOVABLE);
-}
-EXPORT_SYMBOL(__SetPageMovable);
 
 /* Do not skip compaction more than 64 times */
 #define COMPACT_MAX_DEFER_SHIFT 6
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 6855d9e2732d8..25bf5ea0beb83 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -154,7 +154,7 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
 
 static inline void __zpdesc_set_movable(struct zpdesc *zpdesc)
 {
-	__SetPageMovable(zpdesc_page(zpdesc));
+	SetPageMovableOps(zpdesc_page(zpdesc));
 }
 
 static inline void __zpdesc_set_zsmalloc(struct zpdesc *zpdesc)
-- 
2.49.0


