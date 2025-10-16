Return-Path: <linux-kernel+bounces-855482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101DCBE15F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089684274C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425A1F461D;
	Thu, 16 Oct 2025 03:37:01 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377443254B8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585820; cv=none; b=G6fntwUs0/CdPBVHVBkI4I5WPzvHWnH2oTbmUlIX7M1/WhoXO5lueoV76pOVkb7+Oom39vpj3qK6KlTOBSxSJ+aq+KG9Q/OXj93U38fh2tsnL9Njr2BOQ6gVhZaWg8eanonLmxQWEQwTDOdo7FqrqSgF6YfMjJQxPeoGZXZ56g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585820; c=relaxed/simple;
	bh=325ujavn9Dr5ZYS+w1GvgjCmuH4qYqTZCulhyzyRwlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI8eb6tRA8pHF3e2YehbGNrCY2+H7GOAXI04/rOhJgzNMnqzxS30tu9cKgYZWBI81WTGaIY1t29FphDGnsU4nNFynbMgiD+8wwdxf5HR7ltwqrR+vfWQCkc5eX92Au//9S6I2Yv6XKgMLgxZCrnu94+m598kFjeSaL5XSGga7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698384978dso1990525ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585818; x=1761190618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5oFZDwaOYLTe1RAiDe6mUSFshh5BB1k1bsgtSytVrM=;
        b=L9ZjXKkkWXEM+NyVbzL7cTFC/2wquxi1yUu+P/N4zW9iCrUSZv1Ld/2PluYrCBE7/q
         zyWi3chW1Lvq0AZLQHMpwI2sTE9HJ9ljVL2p8sAFQg5lLO29zC32ETfwa0xd2bEJV9R6
         LfgRjV48LT1E5ZaU3NdI4YEHuxAaUrwA+w0OQSwhgJcIIjY/v8XM5RQy+wYkcB1a5MP5
         URTPrXlfddyKPIWvKiQ6koY8wOvM1EpvnTZgR9/EQvBK2yAtFqOqhlxUX552Fl14aUvh
         Wcsvdx5wlGvotkcK+ysFXQrm04cOMVDGfnci+pnSTfwHgbyugYjWyFH0A7AVgixdo6FB
         rZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHz1fTscfKI9dhv9wl7vY+LeED8zg0J6jrR8eA45G7/m419v0fTKFhHY6k4mVsz0/rSyBBZU9ey7ggYGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9DVO4ZLwLppo0zeJPPAgfd7agcquCcAUunsQfjmg7cH2Cu6V
	LExf248YwuPu/oxh6Ijm3kNkS6nmGU6lKtChlVKgnNot7TQL6k99fPgR
X-Gm-Gg: ASbGncvZswT3WlS87cU+KnR6TyhAPL29cy+LWxhjAXOZQB3/DyiCpxrGEsEjYDMNx2s
	aGhqDBGHlR/UwbifCsE/mRrK/kT+JcgSV7lFSWfceNlOPXbLuIKKLCH2hLP09E+a1UFMwASjfhq
	y4CMMqg0STcBtxENlz+4jL54VhIJyuFF90+w5dtXcyrItPSpK8aau/NId7HfpMPWE/rNxQluGvS
	xHVN/c4HWcwmzP5r6e19YPqjUmeATNu94DmGF4G22owoENUs25SjkXMKa2TjBWnOJX/LzGjlPMC
	V6pkRKYxCI8zvYS2Oc1JDKesCnejjYEnYQjTBqtzZadI7uuh0kyozcdMNz+xqAOv2vd4bwl+gEX
	m09iIqZTtwcZc5teM7KZ1prniM1W9LLGdotZ/qPVw/bNL0OMNYpNnMlGl9+BY7kTfBOD9Rvtu46
	hD
X-Google-Smtp-Source: AGHT+IFZDX930KR2Gf7fpjticc9tlQwmiyKOIwcZqSUuInC2LLYLPXAKuT3KBNpFznqmqSEybdbRDA==
X-Received: by 2002:a17:903:11d1:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-29027267a99mr413159445ad.26.1760585818466;
        Wed, 15 Oct 2025 20:36:58 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a11:3:200::1086])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930fd3csm12405415ad.12.2025.10.15.20.36.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 20:36:58 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new 1/1] mm/khugepaged: guard is_zero_pfn() calls with pte_present()
Date: Thu, 16 Oct 2025 11:36:43 +0800
Message-ID: <20251016033643.10848-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

A non-present entry, like a swap PTE, contains completely different data
(swap type and offset). pte_pfn() doesn't know this, so if we feed it a
non-present entry, it will spit out a junk PFN.

What if that junk PFN happens to match the zeropage's PFN by sheer
chance? While really unlikely, this would be really bad if it did.

So, let's fix this potential bug by ensuring all calls to is_zero_pfn()
in khugepaged.c are properly guarded by a pte_present() check.

Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 mm/khugepaged.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d635d821f611..0341c3d13e9e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -516,7 +516,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 		pte_t pteval = ptep_get(_pte);
 		unsigned long pfn;
 
-		if (pte_none(pteval))
+		if (!pte_present(pteval))
 			continue;
 		pfn = pte_pfn(pteval);
 		if (is_zero_pfn(pfn))
@@ -690,9 +690,10 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 	     address += nr_ptes * PAGE_SIZE) {
 		nr_ptes = 1;
 		pteval = ptep_get(_pte);
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none(pteval) ||
+		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
-			if (is_zero_pfn(pte_pfn(pteval))) {
+			if (!pte_none(pteval)) {
 				/*
 				 * ptl mostly unnecessary.
 				 */
@@ -794,7 +795,8 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 		unsigned long src_addr = address + i * PAGE_SIZE;
 		struct page *src_page;
 
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none(pteval) ||
+		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
 			clear_user_highpage(page, src_addr);
 			continue;
 		}
@@ -1294,7 +1296,8 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none(pteval) ||
+		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
-- 
2.49.0


