Return-Path: <linux-kernel+bounces-810625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B2AB51D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234E61882706
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B053337699;
	Wed, 10 Sep 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WthYWnwc"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228F337684
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520547; cv=none; b=mmv5Jzk0uWpWX/eJhcgZdpxPUlTZT7KvH2FBOb5LKslqYKovFoVIBcw+rZhyKc5iFsmlzaKRoghOusmD6Y/fs6fLCpiEjErRf0MQA4jq+NCM9WGaH8I77TsicjIcJbrlFFWRuZ4kq9DOHygGPY26IvAGPKJqGkTzATEGO+/Gdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520547; c=relaxed/simple;
	bh=rapjB7hGajfLUCWCoU/6tBi3ZKfcxCBTKav4eRx7lV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0q+G2eVIo+shaJ++bXutw4/uBRtmqMsNIN5uobJbdHHSauxAPIiQMp5vhZJUabH2zjc1zrIQTVELmVGAlfCrbi86qEBdeDbSJOqpqOPH2f4K5ZIJLb0s50MH0xB5n6nMg/YyVwh77T0dXQO4aayYyQr6PuulAMicooEoOEkMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WthYWnwc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7725de6b57dso8158745b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520545; x=1758125345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BxLX4xyttOXeHBJj3J8i0UpcIMZfFqRb74t6SVPVOEc=;
        b=WthYWnwcmWR3DgsQQtq8s2N7hr+gFoZUX+3YcpvQNBSmkwHl81krK3eAh+aIO04Nsl
         iAGU/EdWuxSyGsrqHJZUINqiGTR2Eb3nBAZGAUueGoiXsC435aDk/ZO/MboU4JOR4sSI
         wEn5JKLntUqk64X5KuOCK1sQuBPCtv5ESyXaWehWPyMjapPFoxfVhLcBpDoDTaBWzORh
         3YLAMZC1WxqogN1Q5PZ2B8fkM4ZycAZkzME7tznXMPjRUh3l1+yPcCDOeqQrnljxODtX
         Lrhec9m/MnUgK/zoSUpDqCIRvNiG3+xCDsZtbLxxWkG2PElV+OxJfpwFijHN3Lk4dSQ3
         8/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520545; x=1758125345;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxLX4xyttOXeHBJj3J8i0UpcIMZfFqRb74t6SVPVOEc=;
        b=Z4nAYqNOP8n/8EQrk+7qluyFLiBL8StxPFHX6Ltv5zVl5RHqmtgIRsynnyIsHsx2w8
         e0JYGizr16pPiSsjdzl+1c1FmIUrjghL4o/9jL6iYiS00RulqnC1DFHWt5CcE4yqI28/
         +tyhNR0hqdUrG2KBJj1xbZT2STm6bazX+yT5nHGewPZVNE3oM2oO+0CUG3MRumY0P6ox
         arF+vvqH+CELTfrh4v0TpkHPgQ6Xy/7HAaPpEYTMxngSkht+PPhHpM2+2LF7jJtrJDYL
         1a6G+TKRlBmfi1pp8WF0bS3o/RbtC0H8zUOv4dToqo85Kr3OTXqa8S1mWx4bv7AYh4KD
         tLgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/53Y52ZegQNhfIaOxSbX+VzY0+IBURXBdT05xHqHwKJdIsu/FqEYPCIOmCoGFZvc7k6J4aTv8kDCgU4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pHMuw1uarCBLED4hdtXOfIVCfghKEj9wly1QCKpyIoNi29hY
	yaCXlxYfVZ2iqhIgDhYKB4QjOdTEoxOX2yLkFUAdVbEgkmH6CneN5fXa
X-Gm-Gg: ASbGncsUVNamkjk7RWZdx6Cwi6fnh5fz7Z6ctG49RxRT3iWkxZIqP7JXKyEQywF8SeJ
	N7owXNkvTWPQd8NHeDZKmYFJqFpIqMqtoPcQ25K//xxd5fOkRSo7rlU7+DgzHIrFNnofXCWEjut
	7Ygj1j2uE5XpVDuxK+PD4eVZDDlebHHqO+NmjSnfWGYuA92MwylCmXUjlkQ2GTLDofHN5AVexyX
	rKDELCRGe7qwBz+72ddoFSDCum0fw/cfyrkX0lp4XPcutTQinqCapWvI0x6ghSvBH9dsijTErcX
	ksDmpEcrJAF5R6jOBYSISteS1MRDGInnnlbubOpGrT2hSufEZZ3hy/3ghdG7g5ADWt3Rl7xLwAK
	9L80zl4wP09k9O0YyWWIieUCiXb/s3Kz1QH19HxtaQG2Y3s4vBBl/bn69Dg==
X-Google-Smtp-Source: AGHT+IFGnnTS7ld9IQLIIRQsAt7maX5kJ+os/mQb2BSw6qlHk3VZHZQENlh+ewVjuD1hIx8qBenBkg==
X-Received: by 2002:a05:6a20:1584:b0:24e:9d94:7b17 with SMTP id adf61e73a8af0-2533e8532f4mr19272123637.9.1757520545462;
        Wed, 10 Sep 2025 09:09:05 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54998a1068sm1000142a12.31.2025.09.10.09.09.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Sep 2025 09:09:04 -0700 (PDT)
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
Subject: [PATCH v3 04/15] mm, swap: check page poison flag after locking it
Date: Thu, 11 Sep 2025 00:08:22 +0800
Message-ID: <20250910160833.3464-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
Reply-To: Kairui Song <ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Instead of checking the poison flag only in the fast swap cache lookup
path, always check the poison flags after locking a swap cache folio.

There are two reasons to do so.

The folio is unstable and could be removed from the swap cache anytime,
so it's totally possible that the folio is no longer the backing folio
of a swap entry, and could be an irrelevant poisoned folio. We might
mistakenly kill a faulting process.

And it's totally possible or even common for the slow swap in path
(swapin_readahead) to bring in a cached folio. The cache folio could be
poisoned, too. Only checking the poison flag in the fast path will miss
such folios.

The race window is tiny, so it's very unlikely to happen, though.
While at it, also add a unlikely prefix.

Signed-off-by: Kairui Song <kasong@tencent.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 mm/memory.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 10ef528a5f44..94a5928e8ace 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4661,10 +4661,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	folio = swap_cache_get_folio(entry);
-	if (folio) {
+	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
-		page = folio_file_page(folio, swp_offset(entry));
-	}
 	swapcache = folio;
 
 	if (!folio) {
@@ -4735,20 +4733,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
@@ -4761,6 +4752,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			     page_swap_entry(page).val != entry.val))
 			goto out_page;
 
+		if (unlikely(PageHWPoison(page))) {
+			/*
+			 * hwpoisoned dirty swapcache pages are kept for killing
+			 * owner processes (which may be unknown at hwpoison time)
+			 */
+			ret = VM_FAULT_HWPOISON;
+			goto out_page;
+		}
+
 		/*
 		 * KSM sometimes has to copy on read faults, for example, if
 		 * folio->index of non-ksm folios would be nonlinear inside the
-- 
2.51.0


