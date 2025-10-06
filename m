Return-Path: <linux-kernel+bounces-843418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E46BBF248
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623343C3E5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D702DE71B;
	Mon,  6 Oct 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8gkG1q5"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7CA2DCBEB
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780999; cv=none; b=YEz9JFJFgfbyo2/wNXfDjDDHhT9gNdMCHWLAEPGbeX2XVbfXVfBTtvdy620NoLt/2KqGh9w3nqNvB51yxwRvg8xFKFVSOuSyQ91wnn9tLsC/OLE3K6rYEcoi8X6oJsohwFNlslkhKjw0RMsaFmHlkND2ltkMgQI4vHWgyb4QWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780999; c=relaxed/simple;
	bh=BI23GMC9t6RGb9fZd+kNiyuir60KlSVll6HSYgnUNwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LAju84tQx0uq/6s7/xNWblLtVpyzv8M2smvkrD9y+fmQhmdx4reDoVgUxYT9iOqNvBSRKnT6VA4WY/bl9wyye3/aOJS1kncpSJDlgEabRfyZrRn+WIUnzHp9C0IKBtzXh8VZcuZEBUS9e6cmIzCF7YyN6FN+BShbR/U7qfqXso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8gkG1q5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so4313442a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780997; x=1760385797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOUsOsGJd3wfEZwhNSB4DJHpM3wcqaShHziJPPLEM9s=;
        b=b8gkG1q5DsWlmQXXFpdAyTAIZZtLD19F8HXSLdhKwESRRuzmB166EwUP7/GaeOVTXA
         sJphax2vgn68vkQlg/qGglFRpAKVGjXkODaxDnZbUm10KJXLCFwEEbLslO8NV8uehwZb
         M4fQdLi5MzcXCt4MZpXHS9NLAo/P0KLDYUBewIzTMzXmAhtw6GVgpCYadtTJeWQtCCYI
         nGsepIOJ0oF3b3pnTPTW5TLjaQ1pqLkfcofXh5yqKFw0RaUsCFHOiYRYxSP3HZjiXW9L
         tVFW9Niw3KQWDYd/chAoNYfcSVCQs+dtDfrd3cDhADIJgCSlfLmBzssCQYyPtWWElhJ4
         L2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780997; x=1760385797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOUsOsGJd3wfEZwhNSB4DJHpM3wcqaShHziJPPLEM9s=;
        b=ji5E20MeohHWSaCcCsTMusur1d/WHBSQCuAG7s31FScIBJjjbCX5P2iNFchyHPQyp4
         csC5C1Ya6LAXAIgJLa9HHQ0XBJ1yz732FUfM3R274rRb8co3E2GO869b1oFjQhjSjZOb
         sG3h/XHeLdVnGG6xoCpCUaH6sMag367/WijTilAnSEgtDer3ukCR8+/4EjCLCmS097eK
         pTAM+m9o8c9MIUAItRwxxu8z92AN3AZxtsUfw0gfNgXgHvxTM4n+vwrvcvP6erzJTRpF
         qwu3EbEpCyV3MGKtHyvqKL5mGqgR0SSnA4rTsMv4AJrGvuPJDPoqTVJr5csWjdr55Tr6
         /WKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLic0YYMjY5j8Dryc7yhTMWovCXxgRwJZBxS6c2l2KCRLL3xkk0u5T6fXxjYkg9PkRltSKhl6n/2CmwIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkmIBzO1h7sjxEmwipegUu+g89TVjRknxMvN+dosgGXlVwFhO
	RSBhIkDarZPYtqzSdN1Vr8jDrbVW5iqDt/bUqXe2HMhUHQERGfUXoigf
X-Gm-Gg: ASbGncv4qmiDI/uxiJ2S+zw9WGz+l2RfXOnzfmPkgQWRP9ZJFUpeAZ1ObQJDQ7ayv9Q
	PjHJoIS1eWKzhJ9RHZiDAiBqgsY3C3I+Ugj/fNfnXuk5iVJuGCOjBZfTNOKubyZD6k6aoUHI0aa
	J0ZcpAW9CildelNtNSmznWgf5f7q8OIUAeZb3N3BIdFFYwyrSJUzBMycj/asEiM9dBw5M8Fd6CB
	bWbey8H9c2oBDmC66up+1E0LnUB5VzMamBHb87+pMLQJGgggcIuSCWnalVsMs2FoQHGB4zJ4snf
	TJ0gIKcpnF/97ZIXDncbw3G25PcOtS4nwc8ieWNe/3JgT21LSUjxWq9BC8O6dDDM96KPEXNfS7f
	rIwnByFuoRmEF6KH1PyHltp+0LRpc9HHij2FPLws1ZgJRM6BzyT5Ko7VX9xEm9O4=
X-Google-Smtp-Source: AGHT+IGtlcgIQ18cOW4NX8p8Ae8A6QlZc0kl78+mT+F6McwCAq86Egqg4BpOisoBrQ9R2ia0C29Faw==
X-Received: by 2002:a17:90b:1d10:b0:332:793e:c2d1 with SMTP id 98e67ed59e1d1-339c27d7865mr16524955a91.36.1759780996556;
        Mon, 06 Oct 2025 13:03:16 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee0ba20asm163148a91.4.2025.10.06.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:03:16 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 07 Oct 2025 04:02:35 +0800
Subject: [PATCH 3/4] mm, swap: cleanup swap entry allocation parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Kairui Song <ryncsn@gmail.com>, 
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

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h | 4 ++--
 mm/shmem.c           | 2 +-
 mm/swapfile.c        | 2 +-
 mm/vmscan.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

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
index 45f51745ad88..63092cc0b141 100644
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
index 732e07c70ce9..534b21aeef5a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1425,7 +1425,7 @@ static bool swap_sync_discard(void)
  * Context: Caller needs to hold the folio lock.
  * Return: Whether the folio was added to the swap cache.
  */
-int folio_alloc_swap(struct folio *folio, gfp_t gfp)
+int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index aadbee50a851..c99f7d6d5dd9 100644
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


