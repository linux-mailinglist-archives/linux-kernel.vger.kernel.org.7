Return-Path: <linux-kernel+bounces-857748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AFBE7D93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CED0188D9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A692D8370;
	Fri, 17 Oct 2025 09:39:11 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B92BE031
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693950; cv=none; b=gyAvNMM3PFA7QzMpcCz/gpnFaK2DG8w0wMBQDO9BTrS+0jXuN9A0w5YFTemCRn7NI9SDUsmkud2c4dFGo8AqRxwJRyh+9Fr4Kvd/r7D+6Ljas9vvtsFJH0Ax+8A79A3auBgQp40z0cVeP7psEnNJNis91FNX+dljR7MpgO6j8gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693950; c=relaxed/simple;
	bh=ipaazS9FZP7RDQQAAkaFkwYagnj4YhuNK//zOYv5gGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zlf9bapn1lrg0z55narpWjOcmb6WAq00C4/vyU1YGsWxFthscl/eTZc0mX2FmxWbyyt/MBMA+WYKa4Z3KC66dIb4En+VAntSQpUo9r/1u6f4JKT0J34GQaENxXVHKsH+bibYBtNr6rSpqo3ok6ChsFWTeiC3kWfrTUnEWmlMqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47109187c32so8762935e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760693947; x=1761298747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82txt8z3ePeVTeUSUG8VLqTzgVsdlRqOmFYFwTwtnb0=;
        b=tAvWk58WLQTe4UaxJ1hwt0akis7yh0rTrKNhTBbhOb7xD/z58cE6p8uWbxBTfyxfL7
         jFy+zZSE6Cn1eu3bp5GKFpGXw47Brf3UtLpNTvAJWbl0oTweWHCyMQPqB8JhbsOocmDB
         02kHu7tWvs8eHiUW8OScCIUaGWQGf14v/OGq7ju5/9as1B1BHqnyP2HY3ySS9s5zfkjc
         VjGaOWIaZGf4UQXkB5uY4+3jciekR2qMYhEz25MmMF7dXYvYnzDoPNMaBMFK/tgxPTBc
         0o4De5p5dghO4j1Y2nXbJwq8khenmSuD2ewXiWYrFVm//s31ypNASm5ydpYxxXdjW5w9
         bYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTyRcM7Smixu3MG490osGHASaNp71pqCTBtDdpsrrA1vB8Fikm2HEOEw3dX8JPZhVGYl4adRriUguKpmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaHO9tm39V4vU+W3kDeJG8+Pd8aL4bXGLo0YpDhM1dD1DIMFN
	MsYN33TXo+I8+gmoMv/PQYAcWSVCIp2MD4lia8f5EURvVZUGnELREVga
X-Gm-Gg: ASbGncsbX8QOSmA7h9Ru4lgdsY2Ncb8jY5gpQNhg3vQu7+o75idosZfeCegszADJe0g
	R1RORMTTln7/Z9FS0akQywaPBLJxWMPujLoOeInLOyP4it8926A3sqx8fnlck9OldyAncs/rr1U
	2FDvwbrqTrq8cEvLDCoAe4irJJ5EVuoBy8/hKr2139rjMyjYorPhMr/+pf7HGxWcVYSjxkn/D0m
	m8emMbyz3JkoWu1sGaLH3/YaPRx0hemUSENrYP53QEbJ7YMJ5ypR4A8icHG0lyWuNbiVPdv8j3R
	bCTsDdfDd7pI/njmuaoz2Q3q4XKxIbuPf6wRSAW2pMU0rpZfTD0CYLrHbv8cxOzubyoeXtjC70J
	6oYFzEg6mvRZLNKWyUAAHkedcGgIT+PANjWc2aUrqvnKFErfl53jefVIJwMZx22Go1Q==
X-Google-Smtp-Source: AGHT+IG1GbOglWAOwpAnLl2f/RlHayD8BRBUt5O0twnrZaHrEC3ynTgsF+9lhYx/GNx+QUpdNq8J/Q==
X-Received: by 2002:a5d:5888:0:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-42704d51240mr2007293f8f.1.1760693947235;
        Fri, 17 Oct 2025 02:39:07 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm39883572f8f.22.2025.10.17.02.39.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Oct 2025 02:39:06 -0700 (PDT)
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
	Wei Yang <richard.weiyang@gmail.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new v2 1/1] mm/khugepaged: guard is_zero_pfn() calls with pte_present()
Date: Fri, 17 Oct 2025 17:38:47 +0800
Message-ID: <20251017093847.36436-1-lance.yang@linux.dev>
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
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
Applies against commit 0f22abd9096e in mm-new.

v1 -> v2:
 - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
 - Reduce a level of indentation (per Dev)
 - https://lore.kernel.org/linux-mm/20251016033643.10848-1-lance.yang@linux.dev/ 

 mm/khugepaged.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d635d821f611..648d9335de00 100644
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
@@ -690,17 +690,18 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 	     address += nr_ptes * PAGE_SIZE) {
 		nr_ptes = 1;
 		pteval = ptep_get(_pte);
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none(pteval) ||
+		    (pte_present(pteval) && is_zero_pfn(pte_pfn(pteval)))) {
 			add_mm_counter(vma->vm_mm, MM_ANONPAGES, 1);
-			if (is_zero_pfn(pte_pfn(pteval))) {
-				/*
-				 * ptl mostly unnecessary.
-				 */
-				spin_lock(ptl);
-				ptep_clear(vma->vm_mm, address, _pte);
-				spin_unlock(ptl);
-				ksm_might_unmap_zero_page(vma->vm_mm, pteval);
-			}
+			if (pte_none(pteval))
+				continue;
+			/*
+			 * ptl mostly unnecessary.
+			 */
+			spin_lock(ptl);
+			ptep_clear(vma->vm_mm, address, _pte);
+			spin_unlock(ptl);
+			ksm_might_unmap_zero_page(vma->vm_mm, pteval);
 		} else {
 			struct page *src_page = pte_page(pteval);
 
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


