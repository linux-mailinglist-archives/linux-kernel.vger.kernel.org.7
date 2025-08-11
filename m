Return-Path: <linux-kernel+bounces-763310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9EB2130B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB36E4E3861
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53B2D47EC;
	Mon, 11 Aug 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMTo4cTC"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B929BDBA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932900; cv=none; b=AADi0+2eZG+G3QOqv9bTMSHP3DvgOtsoY8Ee8hcLsbyBalDr4u/kW7Nh7crca8WPAYyzl+5EYQEOsq38Errku/iih0sJOlUAqiv27ywFUo+cRrWZ3+6XmwszssMDz7SdAYAWzfpIyg2HoiZhC/y2m2e+K8BBXstpUUhePeKbAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932900; c=relaxed/simple;
	bh=SKB8ordcLALRuYf8Mps/USt4ZgL3B5JO5sNef62tirA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5cXVCZUML1P27QzOGIK5njGci7NhxTvccUMA8yiFHfTDam8hFGEb9/Kjs0XPMneq1WzwwCybQzFOtojODGjujhl2eHl9xQRfN8Crq2bNOGEfPz2MpII1LtPxugT1hK8gJzwsf1EDWRyX7uzmLaLoQ2fBMNLK//6jXpOIRNDRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMTo4cTC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24099fade34so33042295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932897; x=1755537697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HeE8CaQ2K5i+oPH7GVC2aPBcfIXmZD81doSr56qB3l4=;
        b=PMTo4cTCXuFfSjhVdJoW62da4frqWNp/iuCH3bT6forIHkK6DxhdxUhJFzWJlyODUn
         zfBFv6QgrgobbKcD+ePPOWSHGgpyuPI40v6LszowOY0raMbb0h2Ij8nSQBU1qar3eav/
         ilWHspbHSwETlwcxOExwioAG/XFKwwcaBENNiGw2jBzf0OrZE7AVeXaCx1CB75JY4hFs
         jMMkCFga8Et7CObiV0vJsAY3J3Z+bqszZS1ngsTdLQeTxZ/itum/dDvsZtcXyPMPBt5A
         IyZd2M7CvhWH5vRK5RlK4jNLVfWKTtxJgB41pGbb6NDdvcrqZ71+FleglG+2t3iJShsF
         3HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932897; x=1755537697;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HeE8CaQ2K5i+oPH7GVC2aPBcfIXmZD81doSr56qB3l4=;
        b=pivq3PEbdXqnqI4bULVujEKPb16nEKdzxgStsH5ISWK1WQ2FHQxk7AWrsU6r4iU1yN
         sPA08oMaLG+tH20CuD+QQxNNZ83cpz6RNKhwhIOILjRIqvzpDpva/lCtGY7kEByk2X25
         EI4XsGFJpGPEvZ0A1HFS0gJfDi0Qh3FO//Lo/gNHIqWJN63BR3hcRKyU4EEoKCQhes8G
         Xax4p7VWH5cOST2/la82cqfOeOYDceGLfFL50WGwmFTc1ewZt+fOe/I+Cexjxybf+TwV
         8wfIfsUwarM9cGGR4+II1e9Rp+PFN35+ZQp9MaBYQUc05Av0DT4GL65zZvcV6hhA8QkT
         N3cw==
X-Forwarded-Encrypted: i=1; AJvYcCV6EaJRzk6VwbzdaMw4OKoWrQBOZqUTs1oIpQgO7icGZGjycOASa/h0CneEnOIQY2BT9IuDg/6UQL8YGLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOs3hHPwdP4oOUmsg5wKNutCKezWgrqfJV/wxjqFcntT2tx4E+
	HSym+X5vN6jA21oZvOThDIDMBjff31BLTndQf/s0FLGhdktNbBQEV4Tp
X-Gm-Gg: ASbGncvwLvtHDkf6nMyD975c7LWu3j0P59ub01BR10kdNpPladvLz1Nq2T9N2u8pTcF
	ICGRuuy7xCOVDvOjjfPlBiXrrteN1pM+/YYY0ACf3P5f682h6HDPW9PTT9Dk20hIXAAaCZvlYDb
	NiP3ERF7/us76pmDw7LwzC4zxaGDgieuNfdtkNbWcoEfM/fgmBUXBmJlWopwOPpQcbuptDWuHrr
	IgB9SnqkOoePITtUmV//3Uu7y+DCCCPC1Bky6BBWWxOipm2vgM7x1wPOtJ6cu1Nfh16x2am/6Fh
	jE7QxAtoHvzC2eDVZpSz09Al/rhf0mU3gDtgO+9TwiDmA307RqJKv/y2r0MBBaLqtPhrhE6gyK3
	dZ17PXRQEWZcqpNbwrA41Zd6TldLWY1fIk2JGpA==
X-Google-Smtp-Source: AGHT+IHTmczJxTiTIxYVNE4NIKjMSM7gIpUc+S8TfKU2hM8+fGSlcbq5rCYS33AqUl07gxT9R6woCA==
X-Received: by 2002:a17:902:dad1:b0:240:9f9:46a0 with SMTP id d9443c01a7336-242fc340439mr4695835ad.38.1754932897189;
        Mon, 11 Aug 2025 10:21:37 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769fasm276685055ad.107.2025.08.11.10.21.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 10:21:36 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/2] mm/mincore: use a helper for checking the swap cache
Date: Tue, 12 Aug 2025 01:20:18 +0800
Message-ID: <20250811172018.48901-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811172018.48901-1-ryncsn@gmail.com>
References: <20250811172018.48901-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Introduce a mincore_swap helper for checking swap entries. Move all
swap related logic and sanity debug check into it, and separate them
from page cache checking.

The performance is better after this commit. mincore_page is never
called on a swap cache space now, so the logic can be simpler.
The sanity check also covers more potential cases now, previously
the WARN_ON only catches potentially corrupted page table, now if
shmem contains a swap entry with !CONFIG_SWAP, a WARN will be triggered.
This changes the mincore value when the WARN is triggered, but this
shouldn't matter. The WARN_ON means the data is already corrupted
or something is very wrong, so it really should not happen.

Before this series:
mincore on a swaped out 16G anon mmap range:
Took 488220 us
mincore on 16G shmem mmap range:
Took 530272 us.

After this commit:
mincore on a swaped out 16G anon mmap range:
Took 446763 us
mincore on 16G shmem mmap range:
Took 460496 us.

About ~10% faster.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/mincore.c | 90 ++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 20fd0967d3cb..2f3e1816a30d 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -47,6 +47,48 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	return 0;
 }
 
+static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
+{
+	struct swap_info_struct *si;
+	struct folio *folio = NULL;
+	unsigned char present = 0;
+
+	if (!IS_ENABLED(CONFIG_SWAP)) {
+		WARN_ON(1);
+		return 0;
+	}
+
+	/*
+	 * Shmem mapping may contain swapin error entries, which are
+	 * absent. Page table may contain migration or hwpoison
+	 * entries which are always uptodate.
+	 */
+	if (non_swap_entry(entry))
+		return !shmem;
+
+	/*
+	 * Shmem mapping lookup is lockless, so we need to grab the swap
+	 * device. mincore page table walk locks the PTL, and the swap
+	 * device is stable, avoid touching the si for better performance.
+	 */
+	if (shmem) {
+		si = get_swap_device(entry);
+		if (!si)
+			return 0;
+	}
+	folio = filemap_get_entry(swap_address_space(entry),
+				  swap_cache_index(entry));
+	if (shmem)
+		put_swap_device(si);
+	/* The swap cache space contains either folio, shadow or NULL */
+	if (folio && !xa_is_value(folio)) {
+		present = folio_test_uptodate(folio);
+		folio_put(folio);
+	}
+
+	return present;
+}
+
 /*
  * Later we can get more picky about what "in core" means precisely.
  * For now, simply check to see if the page is in the page cache,
@@ -64,33 +106,15 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t index)
 	 * any other file mapping (ie. marked !present and faulted in with
 	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
 	 */
-	if (IS_ENABLED(CONFIG_SWAP) && shmem_mapping(mapping)) {
-		folio = filemap_get_entry(mapping, index);
-		/*
-		 * shmem/tmpfs may return swap: account for swapcache
-		 * page too.
-		 */
+	folio = filemap_get_entry(mapping, index);
+	if (folio) {
 		if (xa_is_value(folio)) {
-			struct swap_info_struct *si;
-			swp_entry_t swp = radix_to_swp_entry(folio);
-			/* There might be swapin error entries in shmem mapping. */
-			if (non_swap_entry(swp))
-				return 0;
-			/* Prevent swap device to being swapoff under us */
-			si = get_swap_device(swp);
-			if (si) {
-				folio = filemap_get_folio(swap_address_space(swp),
-							  swap_cache_index(swp));
-				put_swap_device(si);
-			} else {
+			if (shmem_mapping(mapping))
+				return mincore_swap(radix_to_swp_entry(folio),
+						    true);
+			else
 				return 0;
-			}
 		}
-	} else {
-		folio = filemap_get_folio(mapping, index);
-	}
-
-	if (!IS_ERR_OR_NULL(folio)) {
 		present = folio_test_uptodate(folio);
 		folio_put(folio);
 	}
@@ -168,23 +192,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			for (i = 0; i < step; i++)
 				vec[i] = 1;
 		} else { /* pte is a swap entry */
-			swp_entry_t entry = pte_to_swp_entry(pte);
-
-			if (non_swap_entry(entry)) {
-				/*
-				 * migration or hwpoison entries are always
-				 * uptodate
-				 */
-				*vec = 1;
-			} else {
-#ifdef CONFIG_SWAP
-				*vec = mincore_page(swap_address_space(entry),
-						    swap_cache_index(entry));
-#else
-				WARN_ON(1);
-				*vec = 1;
-#endif
-			}
+			*vec = mincore_swap(pte_to_swp_entry(pte), false);
 		}
 		vec += step;
 	}
-- 
2.50.1


