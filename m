Return-Path: <linux-kernel+bounces-782614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14E7B322BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35EA7ADCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21252D0C7F;
	Fri, 22 Aug 2025 19:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtjUHe6v"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13C2D12E1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890459; cv=none; b=Jmc1lnBCB8Aq+sTsBVDHUZVlhnllAtDtIg2DZwIe1aQLccd+9qKFVArJZ+kmV3cVC2XgRNesQushVVjSxKnFW3yYBMyQRs+B0d9Bwd9MlM4W9cQwVT9TOo2Mds/p2qi+8icjTNwAxBv+HVIf+tkmzcTDvd98EoWJ3MJ0Gw5Eg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890459; c=relaxed/simple;
	bh=T9VmDnYh+CIb9LXa5EKqKPNpt982UPvE2KuXzL8sQGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEOeFIMyUgRgizkmU2g4Uvn3pZ4e8cfJ0WfR5Av8huREmgKlPTx9WPWLtD6PYmCnU6apz4UTGuLAaKyGSHX9oH++yCSLVOvdV76lurI+JQhCaArzVMCDXLDDPIy40XDXbc9XdjRrGpsMepiSjr4hu9wXTsXDfSFnBQoCTL7IvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtjUHe6v; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ba7aa131fso29602836d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755890456; x=1756495256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TPC8fKY9lYOENGHM8BlxnczCD4bDvatV7ABAMC7FrMc=;
        b=KtjUHe6v9dYUMMrcwU7tDoZL2ENXoCcChSklO4B6k9wQoUBajcj0TP08AKPBhj6Uzi
         DjvZy5A5EJ7BVJruX73xReQitNa7kIG+ZbNv3rBHna3kfC6TySC6dh4a9olvhpJ6PN0o
         /jIaoyDnnxSaBvubecw7F2W0XhkN2esn1vKucBMOMTdvUKCwEb1142gp52TujirNbusu
         85Mi3NpM3YQnyWrx79kM2Y14/07Kj5/PK7reh7tuJYZSd4V53QVBKBiBWvRitGik/3CG
         DPMx3MfpFQv/XI1Uba/LTQ+AvP0C+Vl/IHtUoJMmEZVhbEx/57Ru7af2ynPEplKXDw3p
         I2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755890456; x=1756495256;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPC8fKY9lYOENGHM8BlxnczCD4bDvatV7ABAMC7FrMc=;
        b=Elc5u0GpTiioiQkw4BqSHnrjF50GQXUpugopvUU/jWOWzbV5KRJsZyFXPAiNDocLr5
         q4mKTbq2pkMt0J6PpBoFciW14RBBtQp1xQLScExq46c6pf4WdU9d4Z1rUPtMaKdjwzUQ
         0Qn01MQ8nMHBT1+lWDVV8L9W5MiEGwF5MQqqqpyE06b9gAoRgRL7uidFKCCN7xiq87Bh
         TXoUX8awYAQnn6ycp+ckzexSvjm2hdjC745yF85O/Z6XJ2GozN7HM2VoeKtYrxinqyVO
         MbjlVLOFHWR5+Z4tWKV1B3SURi6g4FNR3PpcRKarBjp9wfkTODz9cowG7NzIVnCdiWGr
         VwhA==
X-Forwarded-Encrypted: i=1; AJvYcCXGLtzWfixYq7ubExLrfvgfib2sAVSaooCiGztJ5mBRJhmkp0szx7sA/aqMffW5wF+Q+jUm/7MKHdH7UN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSYjjBJwZTgyQtfGWiccipcYRz/3fucTIjGVKQe8Mom/C1E8Y
	2+wzyW2opAirvw+23heX9m9moy1eKWIYFImWQAIT4AdsXd/Hpm1RTkiK
X-Gm-Gg: ASbGncu7zPzthW3D1ZMrTn1rGJ7uDBIowFUIDa5rt+8aPW0RDN/npzN1bJ0rBO+s9d0
	oYnOTE6KJqudNT+wN8CL549r/SqDle9mK3WTG5AGmNTAUiKwgyVJLdCsm84Cm1wKr3CXxtgGHnV
	xoL0keL5UVIa7PgnS44cjLYVsG1ZYXF2GYOgtrCNTnBeyA3VtIF9HKtQuFEoqJIuqpIRCkSEo5s
	E7tw0hylRYiXaSws20jaBLTKiWVNNYc8c+0TrPY0Zb5WHeJEdY5+5pn+e3w/k0wfGlF9o1S0Iox
	4ZKcxea5HNGZ3Rl841BYIlQJWdIIz29m8yNphqCcYI9Yl3jasKF+08Fk+Kbi5KPX+Bdzj8n8W21
	C3sCCWzbjNnJjaPht1btf810N4x7NFqv8Y6FwaTrWu9ihV+Kp8Ku/ew==
X-Google-Smtp-Source: AGHT+IFercWRtfaBvKSiuBTbOi61gw/vYK89k9RSquXFYUj53lRFJ7gU9v1uG67cTWNGlGYoKenNsg==
X-Received: by 2002:a05:6214:3f83:b0:70d:a2f9:393f with SMTP id 6a1803df08f44-70da2f93ba0mr26749896d6.36.1755890456017;
        Fri, 22 Aug 2025 12:20:56 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b04a6sm3843656d6.52.2025.08.22.12.20.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Aug 2025 12:20:55 -0700 (PDT)
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
Subject: [PATCH 2/9] mm, swap: always lock and check the swap cache folio before use
Date: Sat, 23 Aug 2025 03:20:16 +0800
Message-ID: <20250822192023.13477-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822192023.13477-1-ryncsn@gmail.com>
References: <20250822192023.13477-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swap cache lookup is lockless, it only increases the reference count
of the returned folio. That's not enough to ensure a folio is stable in
the swap cache, so the folio could be removed from the swap cache at any
time. The caller always has to lock and check the folio before use.

Document this as a comment, and introduce a helper for swap cache folio
verification with proper sanity checks.

Also, sanitize all current users to use this convention, and use the new
helper when possible for easier debugging. Some existing callers won't
cause any major problem right now, only trivial issues like incorrect
readahead statistic (swapin) or wasted loop (swapoff). It's better to
always follow this convention to make things robust.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 28 +++++++++++++---------------
 mm/shmem.c      |  4 ++--
 mm/swap.h       | 28 ++++++++++++++++++++++++++++
 mm/swap_state.c | 13 +++++++++----
 mm/swapfile.c   | 10 ++++++++--
 5 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 10ef528a5f44..9ca8e1873c6e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4661,12 +4661,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	folio = swap_cache_get_folio(entry);
-	if (folio) {
-		swap_update_readahead(folio, vma, vmf->address);
-		page = folio_file_page(folio, swp_offset(entry));
-	}
 	swapcache = folio;
-
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
@@ -4735,20 +4730,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
-		page = folio_file_page(folio, swp_offset(entry));
-	} else if (PageHWPoison(page)) {
-		/*
-		 * hwpoisoned dirty swapcache pages are kept for killing
-		 * owner processes (which may be unknown at hwpoison time)
-		 */
-		ret = VM_FAULT_HWPOISON;
-		goto out_release;
 	}
 
 	ret |= folio_lock_or_retry(folio, vmf);
 	if (ret & VM_FAULT_RETRY)
 		goto out_release;
 
+	page = folio_file_page(folio, swp_offset(entry));
 	if (swapcache) {
 		/*
 		 * Make sure folio_free_swap() or swapoff did not release the
@@ -4757,10 +4745,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * swapcache, we need to check that the page's swap has not
 		 * changed.
 		 */
-		if (unlikely(!folio_test_swapcache(folio) ||
-			     page_swap_entry(page).val != entry.val))
+		if (!folio_contains_swap(folio, entry))
 			goto out_page;
 
+		if (PageHWPoison(page)) {
+			/*
+			 * hwpoisoned dirty swapcache pages are kept for killing
+			 * owner processes (which may be unknown at hwpoison time)
+			 */
+			ret = VM_FAULT_HWPOISON;
+			goto out_page;
+		}
+
+		swap_update_readahead(folio, vma, vmf->address);
+
 		/*
 		 * KSM sometimes has to copy on read faults, for example, if
 		 * folio->index of non-ksm folios would be nonlinear inside the
diff --git a/mm/shmem.c b/mm/shmem.c
index e9d0d2784cd5..b4d39f2a1e0a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
-	} else {
-		swap_update_readahead(folio, NULL, 0);
 	}
 
 	if (order > folio_order(folio)) {
@@ -2431,6 +2429,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		error = -EIO;
 		goto failed;
 	}
+	if (!skip_swapcache)
+		swap_update_readahead(folio, NULL, 0);
 	folio_wait_writeback(folio);
 	nr_pages = folio_nr_pages(folio);
 
diff --git a/mm/swap.h b/mm/swap.h
index efb6d7ff9f30..bb2adbfd64a9 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -52,6 +52,29 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
 	return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
 }
 
+/**
+ * folio_contains_swap - Does this folio contain this swap entry?
+ * @folio: The folio.
+ * @entry: The swap entry to check against.
+ *
+ * Swap version of folio_contains()
+ *
+ * Context: The caller should have the folio locked to ensure
+ * nothing will move it out of the swap cache.
+ * Return: true or false.
+ */
+static inline bool folio_contains_swap(struct folio *folio, swp_entry_t entry)
+{
+	pgoff_t offset = swp_offset(entry);
+
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+	if (unlikely(!folio_test_swapcache(folio)))
+		return false;
+	if (unlikely(swp_type(entry) != swp_type(folio->swap)))
+		return false;
+	return offset - swp_offset(folio->swap) < folio_nr_pages(folio);
+}
+
 void show_swap_cache_info(void);
 void *get_shadow_from_swap_cache(swp_entry_t entry);
 int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
@@ -144,6 +167,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t entry)
 	return 0;
 }
 
+static inline bool folio_contains_swap(struct folio *folio, swp_entry_t entry)
+{
+	return false;
+}
+
 static inline void show_swap_cache_info(void)
 {
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ff9eb761a103..be0d96494dc1 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -70,10 +70,12 @@ void show_swap_cache_info(void)
 }
 
 /*
- * Lookup a swap entry in the swap cache. A found folio will be returned
- * unlocked and with its refcount incremented.
+ * swap_cache_get_folio - Lookup a swap entry in the swap cache.
  *
- * Caller must lock the swap device or hold a reference to keep it valid.
+ * A found folio will be returned unlocked and with its refcount increased.
+ *
+ * Context: Caller must ensure @entry is valid and pin the swap device, also
+ * check the returned folio after locking it (e.g. folio_swap_contains).
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
@@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	for (;;) {
 		int err;
 
-		/* Check the swap cache in case the folio is already there */
+		/*
+		 * Check the swap cache first, if a cached folio is found,
+		 * return it unlocked. The caller will lock and check it.
+		 */
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			goto got_folio;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4b8ab2cb49ca..12f2580ebe8d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	 * Offset could point to the middle of a large folio, or folio
 	 * may no longer point to the expected offset before it's locked.
 	 */
-	entry = folio->swap;
-	if (offset < swp_offset(entry) || offset >= swp_offset(entry) + nr_pages) {
+	if (!folio_contains_swap(folio, entry)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto again;
 	}
+	entry = folio->swap;
 	offset = swp_offset(entry);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
@@ -2150,6 +2150,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 
 		folio_lock(folio);
+		if (!folio_contains_swap(folio, entry)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			continue;
+		}
+
 		folio_wait_writeback(folio);
 		ret = unuse_pte(vma, pmd, addr, entry, folio);
 		if (ret < 0) {
-- 
2.51.0


