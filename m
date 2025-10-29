Return-Path: <linux-kernel+bounces-876621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3AC1C16B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E85934F2F89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACA3451A6;
	Wed, 29 Oct 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnm0v+KA"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4733F8BE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753568; cv=none; b=cPZZ+xHG6GSpWSdJnfU6LXRER61UD9tx9wJPBlvIoMhYyliNYPiBBbZiSr47YI2Os5MN6PUxqdZQeRfeBinGmBa/XLV7LH8F1lxFgNEXjXA9D8d93sYW1kVOy81iwuvVm6YJ/Uc9AD7D/lLuBi9YAYLEeue4ZcNbnLrV5sAaMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753568; c=relaxed/simple;
	bh=Dt4+BCkV7tFGOuDRH+P9tmZPbjgxHwLtkraqYpKF+PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzxhNBFcZtnCCKTovEGKAFBbCup+s8B7sE39tS8ztemQu5gdTt1LdsS6BDXHR6gkrCUCwy+665Ubu7DbWPmP6vke8SCJqM7c9dHVlxoNR3me0GlTfhVsQ7ej0ORswPFuD1IFZjoVd0AZCRuiusCmhSFNZakKjZLmkeuw/PpA38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cnm0v+KA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33292adb180so68425a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753566; x=1762358366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9Lc3r90zvCZ/SIB1R7dCgmTv8+FwGBKVqNJ6km7fiU=;
        b=Cnm0v+KAvlSLC5ra4SDhZNEtoX96+TeJ4rQoglwFbBot1ZKvt+SPj7OxQRiPt+WWpl
         +/eL0gbIEN+IR5D+G2U8gLXrEX/yqLaTnZV+Sf0QzEyD1yj7FnL4c2Is/EjdKGMhT5un
         KJwKxZwa0q1EACYMCgELp5HT0rAcsDp9RkJT12L/AEXORtED8XNgGV/qJBKcuuIZuHIR
         VlrJygfetUqwjUMj2dlAJ32mzln5yFDfzWs9Zvqm8zE80n0HyL5IWcl2jEVKUzE+eCtK
         6eISe0uLy81Kl6BNhU1mdPQTvtNJaMPEr5kYpEIVMfOkD7ITpqOI5Q5LvCi0v7URHPbp
         6VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753566; x=1762358366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9Lc3r90zvCZ/SIB1R7dCgmTv8+FwGBKVqNJ6km7fiU=;
        b=m93KUHhDMKIrcXDtIXRAgs/aWXeMyBg/NJCISmm+ypoucUvMgfK6iuAGL6FjQuWozC
         siQKJ2ii7NFtiMo9O/ylCBOl6tp0fsnX9HVvd4UKpxEzG3Mp9MEUOvd6+8BDwj+LI1G/
         YGHlR99ATjXb2ZSX96p9QJFzRQL61EIZdvdd/kytkOMmalulTDYuAHYMErCwGJOn4ifD
         Zm7AwjAl+6n49+FwM2b66dwr7idiyfFTESVb7rj1epZaFXXyqdf970XbU4hz5JJ5mo4o
         mBreMKBxo9diS6E9M/KMKI3kznMXPBJweKTcrru2Sj2aVKDsX+79ZURnzXVi1Irs9uTm
         dijg==
X-Forwarded-Encrypted: i=1; AJvYcCXyomVaRYbqQlOp47WFXybconGMgaG0X/C1BKeXKf2frhRTwLeyXhKTYTw0IzQAnTS2tsUDc+BSzVHQRMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPMpOWnkzr9GHfTWdnrh9v0XCNvwxbuod9ZKf27uKJUXRbQFRG
	lNsKs7nL6/BTRIOgszRQZZ7CJwsJTVRe6oLHsamznJ+J+Yr1swEnBgz6
X-Gm-Gg: ASbGncvF/vlpmcO6+9EFam2dSH41n3Xedhoat/dhj9C76e3NSU5wduPXwBWVSTvJDnU
	/3omG0MsIMT0yKxHRHXFb4mm0DuCdQo0p6m7OLGztJU5/cTtjvkbdrVzJuZXLs9B0fmLnuQ8+b6
	olR5YJRDrrslY3TFzV68bZnu4vDgkEBfX2SOSyaGqDLmMX0dZqvLfuGnSabNbxZUowVZhHkRLsc
	CLztJcMXHyM/WsERWPu0rtc0pusxZzsYqF0JHRTuYkAtZ6izvkaH0LcgNX/5CB7JQlGB0dhH/07
	JGW1eQ7M/zKBKG0SyZKLKlOkip+OsxczVzKEm5jRNnPEh+L1vCu1rItMege4YGM/1jK6U2L8u0o
	+vrkSpFvRYYTwSNJ59Hg+tp89rhtXjZSVQ58GH2+b/+VLqPgplQzu2ge6hxrpUZ/HsnnTn4e9T/
	bjIH1w78SnTVV3URIf4GUo
X-Google-Smtp-Source: AGHT+IE3X/h8/q0SwVnk59/fKVbT587Z49epkOdhBeEqGIhXexJoe/eYZfVuMy++nBU8/UnEmEl0uw==
X-Received: by 2002:a17:90b:288a:b0:335:28ee:eeaf with SMTP id 98e67ed59e1d1-3403a291ac5mr3323678a91.29.1761753566161;
        Wed, 29 Oct 2025 08:59:26 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:25 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:32 +0800
Subject: [PATCH 06/19] mm, swap: free the swap cache after folio is mapped
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-6-3d43f3b6ec32@tencent.com>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

To prevent repeated faults of parallel swapin of the same PTE, remove
the folio from the swap cache after the folio is mapped. So any user
faulting from the swap PTE should see the folio in the swap cache and
wait on it.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6c5cd86c4a66..589d6fc3d424 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4362,6 +4362,7 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 static inline bool should_try_to_free_swap(struct swap_info_struct *si,
 					   struct folio *folio,
 					   struct vm_area_struct *vma,
+					   unsigned int extra_refs,
 					   unsigned int fault_flags)
 {
 	if (!folio_test_swapcache(folio))
@@ -4384,7 +4385,7 @@ static inline bool should_try_to_free_swap(struct swap_info_struct *si,
 	 * reference only in case it's likely that we'll be the exclusive user.
 	 */
 	return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio) &&
-		folio_ref_count(folio) == (1 + folio_nr_pages(folio));
+		folio_ref_count(folio) == (extra_refs + folio_nr_pages(folio));
 }
 
 static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
@@ -4935,15 +4936,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	arch_swap_restore(folio_swap(entry, folio), folio);
 
-	/*
-	 * Remove the swap entry and conditionally try to free up the swapcache.
-	 * We're already holding a reference on the page but haven't mapped it
-	 * yet.
-	 */
-	swap_free_nr(entry, nr_pages);
-	if (should_try_to_free_swap(si, folio, vma, vmf->flags))
-		folio_free_swap(folio);
-
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
 	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
 	pte = mk_pte(page, vma->vm_page_prot);
@@ -4997,6 +4989,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	arch_do_swap_page_nr(vma->vm_mm, vma, address,
 			pte, pte, nr_pages);
 
+	/*
+	 * Remove the swap entry and conditionally try to free up the
+	 * swapcache. Do it after mapping so any raced page fault will
+	 * see the folio in swap cache and wait for us.
+	 */
+	swap_free_nr(entry, nr_pages);
+	if (should_try_to_free_swap(si, folio, vma, nr_pages, vmf->flags))
+		folio_free_swap(folio);
+
 	folio_unlock(folio);
 	if (unlikely(folio != swapcache)) {
 		/*

-- 
2.51.1


