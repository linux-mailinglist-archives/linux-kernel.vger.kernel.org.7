Return-Path: <linux-kernel+bounces-819212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A11B59CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BB33B75D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329EC37C11C;
	Tue, 16 Sep 2025 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0muYJ5n"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B928369D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038542; cv=none; b=YAxvC7x7vaw37ZaLQjtV6b6D/tonZB+O+jIFn/ir7QRIc41t0Y8xJ76AvuaRHSdQ0gOROoZ8uxHTn5liU+BgskO1CU6YoO3mK6SWaUBb95igLny6vBK+qkDwJ4opq09rq+7nlvphwQcJZoFhYTvNvg7zNFL5fMRJRJR0+rHIuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038542; c=relaxed/simple;
	bh=k3YgayRnsZ7BORANgawEAl3B+3jkLemnEZKM6VYWFgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGtnZSy9rfuhhkkdF0Q+r71lRlEThPLoR0dPrPYJV2lR/fh/3NC4NuNFq9+FjG/P383e5ywPpdJHqk+otly4TIuAXAJQinNSnsvpBQx9dMOLJFNBr/3RaJY0ow/uA9JxZcj3V6cZD/ZOGIFoVCtPi7amo8PQ/Btv0kxfc4muvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0muYJ5n; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61bd4a3f39cso1419065eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038539; x=1758643339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdHPoxeBxMdMqxDIR/SvXJLUUbVQxnjhjl+U1+Q8Oxs=;
        b=a0muYJ5nnGd1OQPM2iE05GQIs2xn8ZHNbwW+boLEW2hzrlx7qH9F5sNXfzEZDvYKGQ
         PBV3cob3gIQkk9nVPTBzgwJQ3GkYB3iCEhZmxiPM2K0Ml9+QlDceCkywkvdoZsnDIn7r
         0nQ/9QRlqfFPS6mHO0qW2YVecnJJXwPKHNgNlP7uv/NWEwjjbn3yfcy34d+M9pIoXidP
         9hMWxXXieJPq5XkGMXH155STYwONIxZ43cLlUgLc1Q0GLi2TPo3JJ2zriaScDTSaRqN6
         A6lx+4HLdg+EBx7Bipe8ixKkajO8IFBaUcvXP3r6b/NIfxSETAXsJpijDPxOuY8oiLWH
         /xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038539; x=1758643339;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdHPoxeBxMdMqxDIR/SvXJLUUbVQxnjhjl+U1+Q8Oxs=;
        b=pU/6EnLWS27nFXmTbEv2YAN9cMa9z6ZXYsrAAPdToMokqtljCgYkubssYw122fX9ad
         3nIhujXmT5FzHTUtQvcr7VTejpr85vHkmrF1N1oYqvG6/akvvc9NhBGuJWGOwah6BEIR
         pMqC3tFfSWwYAUBJ6MtsjwwPRKGRQ1ZccRzvlcWDvtSkT6fN3q0gVHWBECKVXktsBWh6
         SwEVKOr7aYfCi9zfQ3IuwhBs/lRoB1XuCXTs7VwJBdcEtcUJaQfRcslKpPJarRtwR282
         VDLWpEMtSInXQJEELoeHLYgMPcVGAj4z5KY0X1fiYsJgRWHrn1fdSaTiaMT4uToF9dIN
         FLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaphrxQQjY9fAIWlYnOMO0hTkOXyG5CHq5pMQEnRlzUWxiGn4GtUNFVIrUO9UJuPrOfZ+zFXXi1ZGCne4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/UYKiPSwb0IxHkM1j4QGhPhr50bAzsvqA0eviFvqBVkQyGsm
	vds6Mdzay2AqtuLnCTPO3PQ1r4nwDATWMFK7enPElGWbGe4RwIEND9/w
X-Gm-Gg: ASbGncvheb8wFeYXpw0IYgy//DO6nxk6FCddINv9dFnTXN/UCsNX67QNuX2pLdSsFB8
	E9bDJlG2firuPnlwtwZFD3gJOneTAlkgsB0xd78ZxPTKjmsyzMqCTUWs0rlmTGOoQZZsT+e+tqz
	Wsjo3rdHCz7nBWP32sFc5k6c1+8oFlMdrrG3D0QRPdGMN+QPNIlmWDNo8LeGOWbN9mS9pSEj5tp
	41s+oIslMBle3AwUF4rjhQ3WMHd3E6aQNFRTQ9HcdnnHZ4rbU1GsCDpm2WnFgiQ4jFjF3z6W8Gw
	Wtfvn90bfzVKrXgrMu07Kz2B9L3DIi5csOY7wPFU0LFLkQLzb4q5qsA4hhw+iWA5xdlktp2lXl/
	IoX3ccPsSpnX3yhSXxfK5WTW9X1HiusOmxt/TzR2chklfFew=
X-Google-Smtp-Source: AGHT+IGHbYZsTFdHhkmVtFce8cMHp88HQXSjVc3SOFLAhgMSHQs6ZKwPtqA2adX5VFTn7SKvgD08Jg==
X-Received: by 2002:a05:6808:8801:b0:43d:1f40:754a with SMTP id 5614622812f47-43d1f408e97mr4480015b6e.10.1758038537425;
        Tue, 16 Sep 2025 09:02:17 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cd703f54sm969765485a.37.2025.09.16.09.02.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 09:02:16 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Kairui Song <ryncsn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v4 10/15] mm, swap: wrap swap cache replacement with a helper
Date: Wed, 17 Sep 2025 00:00:55 +0800
Message-ID: <20250916160100.31545-11-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916160100.31545-1-ryncsn@gmail.com>
References: <20250916160100.31545-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

There are currently three swap cache users that are trying to replace an
existing folio with a new one: huge memory splitting, migration, and
shmem replacement. What they are doing is quite similar.

Introduce a common helper for this. In later commits, this can be easily
switched to use the swap table by updating this helper.

The newly added helper also makes the swap cache API better defined, and
make debugging easier by adding a few more debug checks.

Migration and shmem replace are meant to clone the folio, including
content, swap entry value, and flags. And splitting will adjust each
sub folio's swap entry according to order, which could be non-uniform in
the future. So document it clearly that it's the caller's responsibility
to set up the new folio's swap entries and flags before calling the helper.
The helper will just follow the new folio's entry value.

This also prepares for replacing high-order folios in the swap cache.
Currently, only splitting to order 0 is allowed for swap cache folios.
Using the new helper, we can handle high-order folio splitting better.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/huge_memory.c |  4 +---
 mm/migrate.c     | 11 +++--------
 mm/shmem.c       | 11 ++---------
 mm/swap.h        |  5 +++++
 mm/swap_state.c  | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26cedfcd7418..4c66e358685b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3798,9 +3798,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 * NOTE: shmem in swap cache is not supported yet.
 			 */
 			if (swap_cache) {
-				__xa_store(&swap_cache->i_pages,
-					   swap_cache_index(new_folio->swap),
-					   new_folio, 0);
+				__swap_cache_replace_folio(folio, new_folio);
 				continue;
 			}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8e435a078fc3..c69cc13db692 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -566,7 +566,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	struct zone *oldzone, *newzone;
 	int dirty;
 	long nr = folio_nr_pages(folio);
-	long entries, i;
 
 	if (!mapping) {
 		/* Take off deferred split queue while frozen and memcg set */
@@ -615,9 +614,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_swapcache(folio)) {
 		folio_set_swapcache(newfolio);
 		newfolio->private = folio_get_private(folio);
-		entries = nr;
-	} else {
-		entries = 1;
 	}
 
 	/* Move dirty while folio refs frozen and newfolio not yet exposed */
@@ -627,11 +623,10 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		folio_set_dirty(newfolio);
 	}
 
-	/* Swap cache still stores N entries instead of a high-order entry */
-	for (i = 0; i < entries; i++) {
+	if (folio_test_swapcache(folio))
+		__swap_cache_replace_folio(folio, newfolio);
+	else
 		xas_store(&xas, newfolio);
-		xas_next(&xas);
-	}
 
 	/*
 	 * Drop cache reference from old folio by unfreezing
diff --git a/mm/shmem.c b/mm/shmem.c
index dc17717e5631..bbfbbc1bc4d6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2086,10 +2086,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	struct folio *new, *old = *foliop;
 	swp_entry_t entry = old->swap;
 	struct address_space *swap_mapping = swap_address_space(entry);
-	pgoff_t swap_index = swap_cache_index(entry);
-	XA_STATE(xas, &swap_mapping->i_pages, swap_index);
 	int nr_pages = folio_nr_pages(old);
-	int error = 0, i;
+	int error = 0;
 
 	/*
 	 * We have arrived here because our zones are constrained, so don't
@@ -2118,13 +2116,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	/* Swap cache still stores N entries instead of a high-order entry */
 	xa_lock_irq(&swap_mapping->i_pages);
-	for (i = 0; i < nr_pages; i++) {
-		WARN_ON_ONCE(xas_store(&xas, new) != old);
-		xas_next(&xas);
-	}
-
+	__swap_cache_replace_folio(old, new);
 	mem_cgroup_replace_folio(old, new);
 	shmem_update_stats(new, nr_pages);
 	shmem_update_stats(old, -nr_pages);
diff --git a/mm/swap.h b/mm/swap.h
index 6c4acb549bec..fe579c81c6c4 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -185,6 +185,7 @@ int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 void swap_cache_del_folio(struct folio *folio);
 void __swap_cache_del_folio(struct folio *folio,
 			    swp_entry_t entry, void *shadow);
+void __swap_cache_replace_folio(struct folio *old, struct folio *new);
 void swap_cache_clear_shadow(int type, unsigned long begin,
 			     unsigned long end);
 
@@ -336,6 +337,10 @@ static inline void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry
 {
 }
 
+static inline void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+{
+}
+
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f3a32a06a950..d1f5b8fa52fc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -234,6 +234,39 @@ void swap_cache_del_folio(struct folio *folio)
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
+/**
+ * __swap_cache_replace_folio - Replace a folio in the swap cache.
+ * @old: The old folio to be replaced.
+ * @new: The new folio.
+ *
+ * Replace an existing folio in the swap cache with a new folio. The
+ * caller is responsible for setting up the new folio's flag and swap
+ * entries. Replacement will take the new folio's swap entry value as
+ * the starting offset to override all slots covered by the new folio.
+ *
+ * Context: Caller must ensure both folios are locked, also lock the
+ * swap address_space that holds the old folio to avoid races.
+ */
+void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+{
+	swp_entry_t entry = new->swap;
+	unsigned long nr_pages = folio_nr_pages(new);
+	unsigned long offset = swap_cache_index(entry);
+	unsigned long end = offset + nr_pages;
+
+	XA_STATE(xas, &swap_address_space(entry)->i_pages, offset);
+
+	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
+	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
+	VM_WARN_ON_ONCE(!entry.val);
+
+	/* Swap cache still stores N entries instead of a high-order entry */
+	do {
+		WARN_ON_ONCE(xas_store(&xas, new) != old);
+		xas_next(&xas);
+	} while (++offset < end);
+}
+
 /**
  * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
  * @type: Indicates the swap device.
-- 
2.51.0


