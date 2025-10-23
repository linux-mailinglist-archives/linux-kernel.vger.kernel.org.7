Return-Path: <linux-kernel+bounces-867527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F2C02D63
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF6D1AA6EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E790334B699;
	Thu, 23 Oct 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrfL+hkY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB534C12E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242519; cv=none; b=DD64IePbaC8SAq6Uc2gcnCsdHqxMkdrkITEnSe1yIOnbe74MtK5iquCFVltObTjF1K1eoNyJz5hApxdXno/K18Nde1ElBYRVxznaJYKYKJ4louze9NGEqwZHTOBKE/skVrpqZOslsi6xD1AIWS/UPm9xBaTB+GzqFaV9eiWzPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242519; c=relaxed/simple;
	bh=3+zQ00TyR8uorYxfXgw9zwEF/fQqIl1mvmnoycNJM6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAFuY3WD4PdinO6MOPAU7G297zU04YCAlUBP6LcOIxV31Mf3dpRHSW1m+HDykOhzQ/DA0RY+KA5S1MUAmyr5ntJIM1Jq1MiFcfPS9okXpsaCoumIGLzcYycaDPY6IlZkfxye7cmw/74UyfimamWOMCsb9XCHqiO4c+XcPFJPYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrfL+hkY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-793021f348fso1091357b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242513; x=1761847313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI+vLZZ7p1Mhi0cj4jqewiN+BVL4Z8G4YkFeSbfUXkI=;
        b=nrfL+hkYrHH2CR/4wjVpzX1lgwMN4aWL1xMouqqOZB9E2F/eENipE6nxKgIuRkPII+
         CfxP2v52fawkWCeVTaT0KR1PpNIEiz9kREwmFHvcaVF0Dcp0cCkPymBfaYmssiHX+kfJ
         rqWC7bAWVUAiuL8tMNA+UjZmjA7ibmdTJCOHvwTKpAhw2Zhv+1Slex5PedqXjIbHgIKh
         jkwFyTMWJaUjoVoeBuSf9gI5X45X4OO2Al3MwjRht7Bg64OI0RifscpYfbRpuMCWoyvI
         XjBy3d67xJZvJ+/jQ5RxWDccEVvz9f84SWhYQRbHyZCgLHFXvqC24/y7I0RVC3C1vTDF
         s6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242513; x=1761847313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI+vLZZ7p1Mhi0cj4jqewiN+BVL4Z8G4YkFeSbfUXkI=;
        b=HQp+xtqzfTPZQhaPe/dMYdXGBUG0jffJClC+yGwo8PBWyv+YnLbIna9xpYySt7OOg5
         twSQh/ANRPwEsLKrb/vO5FuTy/eCpdl3z8bvIeEMxZ2dPPTjUiWAnRT07tpAMYPTYtqF
         IqGF+x/ktFGZUySM/2aYzDaKiMtiS+5wOa9BrHJh9gvIuB3jlHpw6Bo/X8Sv23o7ERmr
         zjbXvNQFao9FIyhAjOWaDtR7hU5q9PTfql/BaUUQuJVuT08nWiSBIwoVMB1NAHyxl1bc
         dNQkt0phwiVyzm3GD3W/wkc/P+Qc5hv3/62M3TIpCpOwmCCLOvG8gkL4ZDtG8cKMK++i
         66Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWQa80DXOsRVUwRby+JdLWMLHmGzl/20qRHMRG/YhW4ZoWZU9mWwbIdCaMfJuemtmQDr6HJXZwmdABggcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl+waKRRZSaqv0jtzHj4I1Y97kCCtcP1qYbnbBUgTnhgZAWts9
	QnsKSZcxcMrQF6zDBMejyUWHhT7Ic8zUJHHd/GL2uz9staOfwR4UE3G8
X-Gm-Gg: ASbGncvmn1Qi40GF9d1zBGRZybeNqZgkAgQslKffbybECBIeZjD4nkQfVbuyAIso+PU
	MQF02ZmvlBAontgmptQxqKzEwGsBlVpDlJ1j+hr4N00b7UBB8ou2gCaEHt/V+0dVzSrQV/uxCCF
	lCIH5dfGoMZ0eN9Z9d82edvy5D3Xh470ITpgSl2vG+reWSdb+CYWFEYTA1FUHTeHhuvfL28GU8X
	VmrGt+xJo+r4OEzXKdXBBfkxHibDabeuS21Wxim5R3XUkogROBiOQ2Hfqd2NkVW/tpWMkmNTGHG
	fqceJMzB6F5HMzwy4U5dIy3cvCyGgVPmm9hapNIVP2L6DW+5HeLZqd2XLwl+C0WHIwqz2P4q0Y2
	D3YeqpFiy7ykrzp49mOzeh0AEMUQDXA8izG53vlhrsOMkVfzQbDv1eLRQpm8LLq/xq2rLefgMAN
	xB3WC+vFS3KrHfqlzI
X-Google-Smtp-Source: AGHT+IGqJoEGKAy5pdzGQ5vfTGlTGC7Sf8azj/HmAmQ3MLhHYPNq0Q7D6d0vzIUbYHy0GQuzOlsiqQ==
X-Received: by 2002:a05:6a20:918f:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-334a856e67amr36168280637.27.1761242513080;
        Thu, 23 Oct 2025 11:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm2734532a12.18.2025.10.23.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:01:52 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 24 Oct 2025 02:00:41 +0800
Subject: [PATCH v2 3/5] mm, swap: cleanup swap entry allocation parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-swap-clean-after-swap-table-p1-v2-3-a709469052e7@tencent.com>
References: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
In-Reply-To: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 YoungJun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

We no longer need this GFP parameter after commit 8578e0c00dcf ("mm, swap:
use the swap table for the swap cache and switch API"). Before that
commit the GFP parameter is already almost identical for all callers, so
nothing changed by that commit. Swap table just moved the GFP to lower
layer and make it more defined and changes depend on atomic or sleep
allocation.

Now this parameter is no longer used, just remove it. No behavior
change.

Acked-by: Chris Li <chrisl@kernel.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h | 4 ++--
 mm/shmem.c           | 2 +-
 mm/swapfile.c        | 3 +--
 mm/vmscan.c          | 4 ++--
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e818fbade1e2..a4b264817735 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -462,7 +462,7 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
-int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
+int folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
@@ -560,7 +560,7 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
-static inline int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
+static inline int folio_alloc_swap(struct folio *folio)
 {
 	return -EINVAL;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 10682328d54c..7559773ebb30 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1617,7 +1617,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		folio_mark_uptodate(folio);
 	}
 
-	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
+	if (!folio_alloc_swap(folio)) {
 		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
 		int error;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 781a70dfcff1..42e2b2759240 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1417,7 +1417,6 @@ static bool swap_sync_discard(void)
 /**
  * folio_alloc_swap - allocate swap space for a folio
  * @folio: folio we want to move to swap
- * @gfp: gfp mask for shadow nodes
  *
  * Allocate swap space for the folio and add the folio to the
  * swap cache.
@@ -1425,7 +1424,7 @@ static bool swap_sync_discard(void)
  * Context: Caller needs to hold the folio lock.
  * Return: Whether the folio was added to the swap cache.
  */
-int folio_alloc_swap(struct folio *folio, gfp_t gfp)
+int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 92f4ca99b73c..c922bad2b8fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1296,7 +1296,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					    split_folio_to_list(folio, folio_list))
 						goto activate_locked;
 				}
-				if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN)) {
+				if (folio_alloc_swap(folio)) {
 					int __maybe_unused order = folio_order(folio);
 
 					if (!folio_test_large(folio))
@@ -1312,7 +1312,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					}
 #endif
 					count_mthp_stat(order, MTHP_STAT_SWPOUT_FALLBACK);
-					if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOWARN))
+					if (folio_alloc_swap(folio))
 						goto activate_locked_split;
 				}
 				/*

-- 
2.51.0


