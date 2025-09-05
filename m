Return-Path: <linux-kernel+bounces-803653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0CB4635F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C4B1891EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8E280339;
	Fri,  5 Sep 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+b5lstp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3427E04F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099706; cv=none; b=pNc3pIiZHbeXBkhVfXRsVGwg1MYBH7ZVchWP9+/d4RoShtMkFySqDJ+ATxStSNZ9C+vMFGH3U5t8Zoy5FbQKQ2Ar+aVgeI1JD16Y+vXeCiWONc4a+epJkOWhZMviCS1gB1TFKT7sMZQekBGc+aKbsoFtnQ4RysMEbsn2kLMovGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099706; c=relaxed/simple;
	bh=PZ9CZUY+9q7aVuxipydq1ZkprFWX7sdmxkMlB6wqez0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUQdUlObFNWeXBlG9K4gYdYsum6Kt1d4u6iE/FV+xvZD8ZAmWiwUMnKUBkkuL19sQgAhFncnI/Z6ltYAItsDmLTIpYFCWa7cM+EccVm9dBxavrQeZpSeZz28y7v3yaNUkqXbCRswhlGInzcJk4forYocrBI9ecAfFVHT8qQyGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+b5lstp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77269d19280so2232901b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757099704; x=1757704504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qeydI8/HJylw/79KhdbsUGz3ARLAznWN2FgVE73ocLM=;
        b=T+b5lstprwX+yvtQYRgCh58VXp6A8AEP/2+oyvn8mPqBPkFyQN4tix5fWtwXhiBiUr
         1fnmEBPDLdZbXCfKIHYYGLJ5eA5Xi9r4FI/1t542eXQ1RptotYDe+CLy7wz0XvfUM+gx
         W3jJA7qN/sDFeZzH672aKg4XWIAPg4KjKP9g/bWZdkgLXWdz2GApxfpUaR94BG6HH0r9
         8Kt0qyVhqpHAo4qXE9Dn4lK0yFOE6ClaAdtAzPLCVnVN1MaCANZHl0QbkZj9jikBZNpK
         bADv3rCZ4aoQkY7TrNKaKUZHzXTGZZg62tcfUIzm2d3T9xgdt9gO82+ti2LIIOSJtS0S
         kfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099704; x=1757704504;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeydI8/HJylw/79KhdbsUGz3ARLAznWN2FgVE73ocLM=;
        b=LT7K0aTL7ACzIvWu8WqY2knJEjwbhe7m/J0OP5l26CBe7aRGlaOF0hWWLL7mxTQKvw
         weDJkyVipF1EZMDoqq5mlnaiV21dn9o6rXXTWtIrrZ1h0ZB6FrfQcJf5y4vsjoWZga9T
         7jAAMXTLVhf43PIERRs9kEXbfR4PdjRtFTU2gadiLEXVoHuUjI6jUmSXGzc3UFAoI1Im
         /xkPvysKIgMCzjt3wkX0dEjxz673wfDx40cTG0lFvMm5epw9xvubkJ5tL+Z6xFIDG1of
         lFlfnx9V2KGRs605qVj4UQ+Bux2WpLk6v5MSWRE+8dpervHDxcvW+a8aaLCSPTWFH+cr
         +sSA==
X-Forwarded-Encrypted: i=1; AJvYcCUds+MuNEkTwQ6HOONIWgXpc4WtghB0v4BdJEPQVmEFMhjOkSj8QOqfTukEYsUwPrybL3dWwFUWV+kNSN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4uYBydGpt3v+3z/L1WNG+WiZfGwMJJwi8APUGPRngOYQ8Y7N
	M4FQtY+5CXq5BtCxajTmGwC1Z1Ut6OTooLsfvL1YLrrN2pXZLzR7yTdj
X-Gm-Gg: ASbGncuAw1XWmu1ZDT2CPh7G6ubV9LZABIrAzZxptwptlYkDcFK2qJ7FvNjsX/xqS+9
	z5R5DcHUCH2ZoCmS7gLTG9VIRRDPL0geAbOUOKFUw0BGVx7HYVF74Pr3Kf86lGwqqR9hMGZu5p3
	QSqcmOyAymkNe0R7kq6d949DJlDKx/1huafUKnwk4aOneITgUy+IAOEgoYHzFbdIeD9J4Xj9DQB
	9PXcSW/FgSo2kbrNZ5D6kJjxmKq++3LEK8S2uUMfPlSUvVZT/CcREGFyVMPTurxBQgV6DUB0epA
	7H5F3hO5whmz3hs9ZkYcAmRNBzMDe1ZMlHjQbp5HxPxHayqoGGwLsnUCnX1CQ5U9s9bV+gOTcRS
	3kyEB1av8ssGxfaOHj9y/edeBcIQP6aGEy9ywDSaAJnYCLuB2135k2J2lFA==
X-Google-Smtp-Source: AGHT+IHWPtwM9o9BiVGBGT6c2v5RdaBjzKiZLU1Y6x4jyh1hpXCSNboWEG37cyccl+n7P+1hlaOKmA==
X-Received: by 2002:a05:6a00:2e24:b0:771:ec42:1c1e with SMTP id d2e1a72fcca58-7723e342f91mr28182850b3a.16.1757099704147;
        Fri, 05 Sep 2025 12:15:04 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77256a0f916sm15871442b3a.63.2025.09.05.12.14.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Sep 2025 12:15:03 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a helper
Date: Sat,  6 Sep 2025 03:13:52 +0800
Message-ID: <20250905191357.78298-11-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905191357.78298-1-ryncsn@gmail.com>
References: <20250905191357.78298-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
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

Introduce a common helper for this. In later commits, they can be easily
switched to use the swap table by updating this helper.

The newly added helper also makes the swap cache API better defined, and
debugging is easier.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/huge_memory.c |  5 ++---
 mm/migrate.c     | 11 +++--------
 mm/shmem.c       | 10 ++--------
 mm/swap.h        |  3 +++
 mm/swap_state.c  | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26cedfcd7418..a4d192c8d794 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3798,9 +3798,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			 * NOTE: shmem in swap cache is not supported yet.
 			 */
 			if (swap_cache) {
-				__xa_store(&swap_cache->i_pages,
-					   swap_cache_index(new_folio->swap),
-					   new_folio, 0);
+				__swap_cache_replace_folio(swap_cache, new_folio->swap,
+							   folio, new_folio);
 				continue;
 			}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 8e435a078fc3..7e1d01aa8c85 100644
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
+		__swap_cache_replace_folio(mapping, folio->swap, folio, newfolio);
+	else
 		xas_store(&xas, newfolio);
-		xas_next(&xas);
-	}
 
 	/*
 	 * Drop cache reference from old folio by unfreezing
diff --git a/mm/shmem.c b/mm/shmem.c
index cc6a0007c7a6..823ceae9dff8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2123,10 +2123,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
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
@@ -2155,12 +2153,8 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	/* Swap cache still stores N entries instead of a high-order entry */
 	xa_lock_irq(&swap_mapping->i_pages);
-	for (i = 0; i < nr_pages; i++) {
-		WARN_ON_ONCE(xas_store(&xas, new));
-		xas_next(&xas);
-	}
+	__swap_cache_replace_folio(swap_mapping, entry, old, new);
 	xa_unlock_irq(&swap_mapping->i_pages);
 
 	mem_cgroup_replace_folio(old, new);
diff --git a/mm/swap.h b/mm/swap.h
index 8b38577a4e04..a139c9131244 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -182,6 +182,9 @@ int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 void swap_cache_del_folio(struct folio *folio);
 void __swap_cache_del_folio(struct folio *folio,
 			    swp_entry_t entry, void *shadow);
+void __swap_cache_replace_folio(struct address_space *address_space,
+				swp_entry_t entry,
+				struct folio *old, struct folio *new);
 void swap_cache_clear_shadow(int type, unsigned long begin,
 			     unsigned long end);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f3a32a06a950..38f5f4cf565d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -234,6 +234,38 @@ void swap_cache_del_folio(struct folio *folio)
 	folio_ref_sub(folio, folio_nr_pages(folio));
 }
 
+/**
+ * __swap_cache_replace_folio - Replace a folio in the swap cache.
+ * @mapping: Swap mapping address space.
+ * @entry: The first swap entry that the new folio corresponds to.
+ * @old: The old folio to be replaced.
+ * @new: The new folio.
+ *
+ * Replace a existing folio in the swap cache with a new folio.
+ *
+ * Context: Caller must ensure both folios are locked, and lock the
+ * swap address_space that holds the entries to be replaced.
+ */
+void __swap_cache_replace_folio(struct address_space *mapping,
+				swp_entry_t entry,
+				struct folio *old, struct folio *new)
+{
+	unsigned long nr_pages = folio_nr_pages(new);
+	unsigned long offset = swap_cache_index(entry);
+	unsigned long end = offset + nr_pages;
+	XA_STATE(xas, &mapping->i_pages, offset);
+
+	VM_WARN_ON_ONCE(entry.val != new->swap.val);
+	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
+	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
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


