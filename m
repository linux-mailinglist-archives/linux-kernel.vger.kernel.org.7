Return-Path: <linux-kernel+bounces-876633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A37C1C635
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95003808234
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B2E350D74;
	Wed, 29 Oct 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWxEKnxn"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511D34573C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753631; cv=none; b=DEGqfHVUQvE5XJRVx1J1Oc44iVM6nyXhspQYDFC06WbH+OenTYjaFdtiwunBjiPyn9dmY1P+iSgZgGnzDjLaet6hXD17XdkuBrL6OFdDXK4i72xpFfCvnJldZ7gvtCaXbKFoRv9v5YL1b4CBifbNnfUKBeg/sYLT59ZX7lp+uAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753631; c=relaxed/simple;
	bh=NNUzmcFz13cOwZMRpnn/w26LlE1s3FpeVoPd0yZr2kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfPrttt/lvFV8Hn3qFMfDfLNcELlOul3ROQNdGXEPu/C/91PRQZjz4Ca2ZRs9CV2N3pS1dt0v2PjsuerIR+NaCClkpErTsMANu87HW2umb03MAumJLLWC89bBEdCtSb6icsPSJaduNbTH2fnfderPR3PfdNVF4ton5pcijFYVGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWxEKnxn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33bc2178d6aso80894a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753629; x=1762358429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K65D0qkLQ24GtBqbjWxaMhnSplvMfrH+SnXenMqBLGE=;
        b=UWxEKnxnGX1mhWg2CPdDd1/8daM1UeZRunQatpdKC24zwCSZLxGgRn15IgQS+cEHG4
         TljIvbkQaiCBvlyeZfLa8TkC2pJIkZD3djd/9mtg+KbJFwrzJ/M9Z3+TSR3nwnHMR5eT
         IRv4VnSDLvw2cCKxMza4Vf8i5Ui2tSFv3+hWyHkKDiVuQ23pi1enwlRlB3+1aWMJo8JU
         xuCdQQEZzSCEg2FZqc51Iv6oUVSKmYnmcYZq980v6gUo08rdTMeQRD9cR50P867MmmZ0
         U65KM4uGq7uQ2+Rep18hHLOuSOH42V6t4OWRHLQB9czPORHC/2Wda5w7xEqfhp3tOfVX
         CuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753629; x=1762358429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K65D0qkLQ24GtBqbjWxaMhnSplvMfrH+SnXenMqBLGE=;
        b=ZuKTBCS97AyjStdmvVo3DruIaZqGd+uz1yS6EstBupkWXnb94B0dodYmGYD/cSWGXx
         RA/pJpm3hiYthXnRvPJtmwIn6kqyu2Oor41B2x4pQTfE+t45jWzHTVgIgsaxuQytw9PG
         ymvne4vyqtpNyxydDENB0foc3alpZJ7hq6uArGK3uj3kdZdlwuLDWOIZ1HSN8zeot3e1
         lSfPe57zz00NVZ/5EdXAQWMLLB0x9bmYMWQ4I+8KgFXgDdSwBYXBcYZVk4EUheDSrMtJ
         kfqXDmQC9+OCSgA7XQR5Jlz7eKjrd85h8g2w4Tu7BYT1lcb8HBj9XTC1pqabmnwl+qqh
         NhMg==
X-Forwarded-Encrypted: i=1; AJvYcCVF9Lyb8rJPdxVOmD9tV85QGw9wmmK2VV2o5OoPBAXNy+4ykQBXMO+egUqGId+Xdqhxby+PNUE3i+1giBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxti1ztfAATDGHPCM2hnRk9948bwS/CrYznbfo01YsEEtpf1Xv6
	Fn2dmWXkCBWVx/opxE505LDtIOIantoECASipYgF+MNbKe9wgLgJBfzJ
X-Gm-Gg: ASbGnctFF3f4hpPrBdVPqkLwEfhBaM0Q6FdBTS0Nw7ptQc75B48HbsCj7WgMnS9xh1Q
	B6XNlKXKGg+CmrTzdZpZyezJa+gJnnvY1aW0/cFmZJQsxAxA2sWTeWMMa6PDJZESGmp8V2OyLEk
	3iaLmor5rGkcda7Y4B5urbApz+t0SWDkMdwXz7tLcyKyLLNFVqZOKtc+6r6darWuKQ7s5Y+3Mon
	9sNfsidwcZ1WfbE6ycbuLig2EHScZjfZ0kXDdz80qEq8E2s3DChQ4O1rP0F/1UpXVU/aM5yqDXU
	7lOfSgmxYrzsyCmonNWtDA63jdkX2aJy8E8q2mPdfI8ZpMb/K/Fr21+NdiIxkdqet0c2fCNevDy
	RltCGsLOCElYZOUlew5yyQt7oPQxndhBPl0fzjGrzawyT92flLpPCa9EUpgcVng4ro6cAh/c8ny
	f1RZG9IPLNs8974oWHoFFh
X-Google-Smtp-Source: AGHT+IFfb91fHwDShHt72AqOZe3jp0hMtnf0fflVA79t3VxX8NtzmyOvdGrSfHzPbZg1N+wH4X3uXw==
X-Received: by 2002:a17:90b:48c4:b0:340:299e:dca with SMTP id 98e67ed59e1d1-3403a15c412mr3897842a91.16.1761753629363;
        Wed, 29 Oct 2025 09:00:29 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.09.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:00:28 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:45 +0800
Subject: [PATCH 19/19] mm, swap: remove no longer needed _swap_info_get
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-19-3d43f3b6ec32@tencent.com>
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

There are now only two users of _swap_info_get after consolidating
these callers, folio_try_reclaim_swap and swp_swapcount.

folio_free_swap already holds the folio lock, and the folio
is in swap cache, _swap_info_get is redundant.

For swp_swapcount, it can just use get_swap_device instead. It only
wants to check the swap count, both are fine except get_swap_device
increases the device ref count, which is actually a bit safer. The
only current use is smap walking, and the performance change here
is tiny.

And after these changes, _swap_info_get is no longer used, so we can
safely remove it.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 49916fdb8b70..150916f4640c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1577,35 +1577,6 @@ void folio_put_swap(struct folio *folio, struct page *subpage)
 	swap_put_entries_cluster(si, swp_offset(entry), nr_pages, false);
 }
 
-static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
-{
-	struct swap_info_struct *si;
-	unsigned long offset;
-
-	if (!entry.val)
-		goto out;
-	si = swap_entry_to_info(entry);
-	if (!si)
-		goto bad_nofile;
-	if (data_race(!(si->flags & SWP_USED)))
-		goto bad_device;
-	offset = swp_offset(entry);
-	if (offset >= si->max)
-		goto bad_offset;
-	return si;
-
-bad_offset:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
-	goto out;
-bad_device:
-	pr_err("%s: %s%08lx\n", __func__, Unused_file, entry.val);
-	goto out;
-bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
-out:
-	return NULL;
-}
-
 static void swap_put_entry_locked(struct swap_info_struct *si,
 				  struct swap_cluster_info *ci,
 				  unsigned long offset)
@@ -1764,7 +1735,7 @@ int swp_swapcount(swp_entry_t entry)
 	pgoff_t offset;
 	unsigned char *map;
 
-	si = _swap_info_get(entry);
+	si = get_swap_device(entry);
 	if (!si)
 		return 0;
 
@@ -1794,6 +1765,7 @@ int swp_swapcount(swp_entry_t entry)
 	} while (tmp_count & COUNT_CONTINUED);
 out:
 	swap_cluster_unlock(ci);
+	put_swap_device(si);
 	return count;
 }
 
@@ -1828,11 +1800,12 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 static bool folio_swapped(struct folio *folio)
 {
 	swp_entry_t entry = folio->swap;
-	struct swap_info_struct *si = _swap_info_get(entry);
+	struct swap_info_struct *si;
 
-	if (!si)
-		return false;
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 
+	si = __swap_entry_to_info(entry);
 	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
 		return swap_entry_swapped(si, swp_offset(entry));
 

-- 
2.51.1


