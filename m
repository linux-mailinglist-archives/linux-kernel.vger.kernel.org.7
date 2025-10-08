Return-Path: <linux-kernel+bounces-844990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D11BC33A6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 559EB34C223
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC72BD00C;
	Wed,  8 Oct 2025 03:29:16 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712429E109
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759894156; cv=none; b=cMTG0if/EZJ798OCvXmvwVhBsXv2BJQFBMUxB1CiEwVUuUC20u0XaIA86yvnfuDgnFiPoEo9Ctr1Kr+AxC2JazXg8TWxWG6InjzuIBJhUDwDySkyQrg8UoSI+JG0aI+2+PnA4JFXJ/OyuzcTyr/vExXZjFFs8UGxFqfduSIODTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759894156; c=relaxed/simple;
	bh=MibfgT6y8XlCuYOJ/nOCtSg0uG9o9l2BOrCuUBn65S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Er0+jl9ZCjPMCuNZlZ7hmcTMfkdYvoWvzlgsHDKrUoDFFx7aTPoKdKaSsyy7bNFla9w1Uf0h0gNJSLrsuenboXTdsXW5k+FKnXNA37CwkNSFvlPi6ZEP/OW0S/40TKD3ZerdHlRH0mUQdbGfQCFvGZ2hZwycA6619/Gp/tt5hWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-421851bca51so4507440f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759894153; x=1760498953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4qILVJfm7DfhssJ0ueEnYCl55Tf6EovTh892sb6XGE=;
        b=q64/DMIEGegh3oYhY1dzDTwRukDaGgSzoKPF/vd7blP6aMdT1g1qIunzchNYzkguYI
         nnmNvJPSSXLr3KORp5iJ3TN9/Q6eBxxWvditiNghzPKM3EGM1e8CQLwL3OK8RP96FcNZ
         PEsxQweNrEToaKLu3eQfsp4SxuCzW9+8HhWLiZL9Bdn26CBQSGbxXLcRQ+d4fv0z53ZA
         6TE66Dwx+RXFRMxHFT7U6LgAVnTXFzQYpfgRWcmW99P4jCGRXJYZnnBvnpUVux5M34CZ
         QNDAAWkgWb5KGd0Qwxvst1V5L9GnXcX7jQBEpIWDtcNJY9UhF2ZQtXifpbNItA16j364
         UKMA==
X-Forwarded-Encrypted: i=1; AJvYcCWMvCcSGLxnERDVO3hGTjhvCZkZ1U7yjU4sjilUd0eyNcXubgpuqVknUP9wqCQ/upxGW6NUpCDAfR5015E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHQm2tFmWCl+cv67OCqWlAtS1uj61UQJaSW/KlARsazvyrWiK
	0YOkYSbp8QfkYi4jejM5EoaUiT1jpDIgHUwBogAYhVBxW43YtVnSgbnS
X-Gm-Gg: ASbGncv0R4LsWq08+roCdgOAKEwF6E7h+PBigz8RNBTemxvJPxT54xoCQdFr6FiNUmb
	16dVH57kywf6JVzqE5s+6YGP0u8XBU5Oh8Y3dMaI7doPodL1SKSVQ1J3SBMXIR4G436CHEU3K2s
	iid6XIK1ohOuRfVxFhqgBZDoLT27qQvsi9LyYUkxW59MpGMDAw+hOgJ81OfUU94WyAR+6WvmXaF
	lcZnwLI5Yohhr2Jgl15LO6Na+tZmsimctQ54/mkU1qJvcyDTzpkCVEM5q4+Xuiujgimi/vqV1dj
	uvLc/95C3BQ1LFo5+cQywYKxMoY4CU08VjJe/SyUa+4ynq/CZEkWseXa8FEmuUcEhihsBDMOwHf
	fUFszlb6ilTX/yusmNjcBMt47Dhc+KJ0VAuVF/hk=
X-Google-Smtp-Source: AGHT+IEqyPpRTF2bZhw/gcKv2q3t9mfW/SB+36ieW0hvddjq7ne03GNKUlJjLVfRv6Vn4FOWpuwBsQ==
X-Received: by 2002:a05:6000:2305:b0:3ec:dd26:6405 with SMTP id ffacd0b85a97d-42666ac73a0mr986043f8f.26.1759894152435;
        Tue, 07 Oct 2025 20:29:12 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe90sm27644519f8f.23.2025.10.07.20.29.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 20:29:12 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dev.jain@arm.com,
	hughd@google.com,
	ioworker0@gmail.com,
	kirill@shutemov.name,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mpenttil@redhat.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	richard.weiyang@gmail.com,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on non-swap entries
Date: Wed,  8 Oct 2025 11:26:57 +0800
Message-ID: <20251008032657.72406-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Currently, special non-swap entries (like PTE markers) are not caught
early in hpage_collapse_scan_pmd(), leading to failures deep in the
swap-in logic.

A function that is called __collapse_huge_page_swapin() and documented
to "Bring missing pages in from swap" will handle other types as well.

As analyzed by David[1], we could have ended up with the following
entry types right before do_swap_page():

  (1) Migration entries. We would have waited.
      -> Maybe worth it to wait, maybe not. We suspect we don't stumble
         into that frequently such that we don't care. We could always
         unlock this separately later.

  (2) Device-exclusive entries. We would have converted to non-exclusive.
      -> See make_device_exclusive(), we cannot tolerate PMD entries and
         have to split them through FOLL_SPLIT_PMD. As popped up during
         a recent discussion, collapsing here is actually
         counter-productive, because the next conversion will PTE-map
         it again.
      -> Ok to not collapse.

  (3) Device-private entries. We would have migrated to RAM.
      -> Device-private still does not support THPs, so collapsing right
         now just means that the next device access would split the
         folio again.
      -> Ok to not collapse.

  (4) HWPoison entries
      -> Cannot collapse

  (5) Markers
      -> Cannot collapse

First, this patch adds an early check for these non-swap entries. If
any one is found, the scan is aborted immediately with the
SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
work. While at it, convert pte_swp_uffd_wp_any() to pte_swp_uffd_wp()
since we are in the swap pte branch.

Second, as Wei pointed out[3], we may have a chance to get a non-swap
entry, since we will drop and re-acquire the mmap lock before
__collapse_huge_page_swapin(). To handle this, we also add a
non_swap_entry() check there.

Note that we can unlock later what we really need, and not account it
towards max_swap_ptes.

[1] https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com
[2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
[3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@master

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
 - Collect Acked-by from David - thanks!
 - Collect Reviewed-by from Wei and Dev - thanks!
 - Add a non_swap_entry() check in __collapse_huge_page_swapin() (per Wei
   and David) - thanks!
 - Rework the changelog to incorporate David's detailed analysis of
   non-swap entry types - thanks!!!
 - https://lore.kernel.org/linux-mm/20251001032251.85888-1-lance.yang@linux.dev/

v1 -> v2:
 - Skip all non-present entries except swap entries (per David) thanks!
 - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/

 mm/khugepaged.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index abe54f0043c7..bec3e268dc76 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1020,6 +1020,11 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		if (!is_swap_pte(vmf.orig_pte))
 			continue;
 
+		if (non_swap_entry(pte_to_swp_entry(vmf.orig_pte))) {
+			result = SCAN_PTE_NON_PRESENT;
+			goto out;
+		}
+
 		vmf.pte = pte;
 		vmf.ptl = ptl;
 		ret = do_swap_page(&vmf);
@@ -1281,7 +1286,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (is_swap_pte(pteval)) {
+		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+			++none_or_zero;
+			if (!userfaultfd_armed(vma) &&
+			    (!cc->is_khugepaged ||
+			     none_or_zero <= khugepaged_max_ptes_none)) {
+				continue;
+			} else {
+				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+				goto out_unmap;
+			}
+		} else if (!pte_present(pteval)) {
+			if (non_swap_entry(pte_to_swp_entry(pteval))) {
+				result = SCAN_PTE_NON_PRESENT;
+				goto out_unmap;
+			}
+
 			++unmapped;
 			if (!cc->is_khugepaged ||
 			    unmapped <= khugepaged_max_ptes_swap) {
@@ -1290,7 +1311,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				 * enabled swap entries.  Please see
 				 * comment below for pte_uffd_wp().
 				 */
-				if (pte_swp_uffd_wp_any(pteval)) {
+				if (pte_swp_uffd_wp(pteval)) {
 					result = SCAN_PTE_UFFD_WP;
 					goto out_unmap;
 				}
@@ -1301,18 +1322,6 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
-			++none_or_zero;
-			if (!userfaultfd_armed(vma) &&
-			    (!cc->is_khugepaged ||
-			     none_or_zero <= khugepaged_max_ptes_none)) {
-				continue;
-			} else {
-				result = SCAN_EXCEED_NONE_PTE;
-				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-				goto out_unmap;
-			}
-		}
 		if (pte_uffd_wp(pteval)) {
 			/*
 			 * Don't collapse the page if any of the small
-- 
2.49.0


