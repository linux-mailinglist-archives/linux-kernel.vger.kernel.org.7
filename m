Return-Path: <linux-kernel+bounces-861192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04421BF2056
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C726418A8075
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8AEEBA;
	Mon, 20 Oct 2025 15:11:39 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DE237163
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973097; cv=none; b=oUwz77in1zTLGQpzWsOCcJ/Gc3Uq2Ap81le1buCicKKrcOpI1YyEPSe1wm3xwXupz7gz8rJpwVnm90+1R3cv9XoePCCeIQK660scX+K2qpOIKq5p2RRUN1bQ0mh75cAoGkNnaYA6rT8GiBx/YaNzn0sWCjPAtLVWfKH5RaqrXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973097; c=relaxed/simple;
	bh=4YiViUBFTwA2a1lWkwIs3a7IfjWtNdpW+qXuZ+8j+eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twGBFDLvMBnhr2c2ZgLgpS1EQT893fp6d8gWj42yPQ9leh+9hN8FL3x4n1T97K7Nn1B0uPuhyykvPpxQGuso9SyyLPDgDeA8Bef3zoYjVp3wFgJ9jY401DkWL4cOR86FjH7xkzow/FKumXj0iAqM0xBBq+AHcESEBH9wQSXbSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so19698985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973093; x=1761577893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xapFPBcIStZkytv/ETnNi3GDKQo+WlFQKnTNuCtXFIM=;
        b=l3/IlUSVlvPoPHbFeLmI+olxPyJuE2iEG7caOBgQEueQtKl67dWKy/pa6/QgPb0RM3
         LR9OCIUklyGJ5cheROOOsWtKVmqBcURa4SHUDiVTQlkvSU4RdH28ZGcztM4r+tbPHqf1
         pjM9Jz2SxFjiBGt1NYexXQZIXwc+6Mwq1i7T9D8u7E2wiQbEndzaiw+X6lZDA+u5ysoK
         H48AO4aRUMipQI2as7V80sc9xY+tybzO3gg1X5NTIY3y/DtmsxSx6DKyyLzJkUAzq826
         0vcYUBF9IH3s4nIKCt6+6kOb16H2wxnyhnTTvLAzLGjpiBqv+EVnfWhLTnz+xtYM+7b1
         YOvg==
X-Forwarded-Encrypted: i=1; AJvYcCW5chAUkXt4birfVRlD0kQUXq4/1qKi0EGmpTowV8TufhMKToX0eyqGL2cP3ZLpvn9UsIPzPTIBpNCJWjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69m4CXZ8/GD09mAMSsJjQ2znnl8Z8qWZ0zoUYFHQmM4eDigh/
	5GUFFukKuG+tUNCs1rKhHaRmDjAXM9pUDBAt1/vnd5w/7Phl8LPyYGdm
X-Gm-Gg: ASbGnctjzrlJmjxG1p4dtQDfXCrDhFOkNeSb2TgPFkPA27EC/vzhUPM+OLXVg4pxPmA
	jaoGq/RyYlXd/Kdrk1LXlrfZ4v4kk9qoGTkOjDfgMDTOplzBXdzNOHkTeXaLJmJLuuq63eGcyNk
	b3W4wW+PQp4MPSdNuSGHkLT5mTfxXt2WFXkASnbYyOp57YA3/PuD5fI2VqibakYsixga9sU0iuk
	ZfFhWM1XTn+5JI74ljgDcrglu+jzssDaqO1MxFT8oTHcLhznPnW4Cd9Kr0RIwWdebzFv2G2rbJB
	d4KADwXzRt/YI0zflMGVnx6D+74IT0yvrnIdEQO3PUDFurU/Pdm0J1ANl7Lfo/3shv6t3fYWGzE
	KLyumvUqWWB9MV25lHX9SDfrNxCPEZ173XSlhFRiSk8RTT2PHk1V8pUQ6TtDVQihmvPZscFCH8O
	bw52g=
X-Google-Smtp-Source: AGHT+IFZ1aeQR12oUSXeiDRJrR3mCpaEJtTUm8uvDUK2YrM/Ongf5OfImsnLjKHn868bXD/fCM0uQQ==
X-Received: by 2002:a05:600c:548c:b0:468:9e79:bee0 with SMTP id 5b1f17b1804b1-471177bc126mr93837155e9.0.1760973093038;
        Mon, 20 Oct 2025 08:11:33 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442dbaesm236142095e9.8.2025.10.20.08.11.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Oct 2025 08:11:32 -0700 (PDT)
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
Subject: [PATCH mm-new v3 1/1] mm/khugepaged: guard is_zero_pfn() calls with pte_present()
Date: Mon, 20 Oct 2025 23:11:11 +0800
Message-ID: <20251020151111.53561-1-lance.yang@linux.dev>
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
Reviewed-by: Nico Pache <npache@redhat.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
Applies against commit a61ca1246ad3 in mm-new.

v2 -> v3:
 - Collect Reviewed-by from Nico - thanks!
 - Add a VM_WARN_ON_ONCE() for unexpected PTEs (per David)
 - Introduce a pte_is_none_or_zero() helper to reduce duplication
   (per David and Lorenzo)
 - https://lore.kernel.org/linux-mm/20251017093847.36436-1-lance.yang@linux.dev/

v1 -> v2:
 - Collect Reviewed-by from Dev, Wei and Baolin - thanks!
 - Reduce a level of indentation (per Dev)
 - https://lore.kernel.org/linux-mm/20251016033643.10848-1-lance.yang@linux.dev/

 mm/khugepaged.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d635d821f611..6f2ae2238b5b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -337,6 +337,13 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
+static bool pte_none_or_zero(pte_t pte)
+{
+	if (pte_none(pte))
+		return true;
+	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     vm_flags_t *vm_flags, int advice)
 {
@@ -518,6 +525,7 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 
 		if (pte_none(pteval))
 			continue;
+		VM_WARN_ON_ONCE(!pte_present(pteval));
 		pfn = pte_pfn(pteval);
 		if (is_zero_pfn(pfn))
 			continue;
@@ -548,8 +556,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 	for (_pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, addr += PAGE_SIZE) {
 		pte_t pteval = ptep_get(_pte);
-		if (pte_none(pteval) || (pte_present(pteval) &&
-				is_zero_pfn(pte_pfn(pteval)))) {
+		if (pte_none_or_zero(pteval)) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
@@ -690,17 +697,17 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
 	     address += nr_ptes * PAGE_SIZE) {
 		nr_ptes = 1;
 		pteval = ptep_get(_pte);
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none_or_zero(pteval)) {
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
 
@@ -794,7 +801,7 @@ static int __collapse_huge_page_copy(pte_t *pte, struct folio *folio,
 		unsigned long src_addr = address + i * PAGE_SIZE;
 		struct page *src_page;
 
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none_or_zero(pteval)) {
 			clear_user_highpage(page, src_addr);
 			continue;
 		}
@@ -1294,7 +1301,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 				goto out_unmap;
 			}
 		}
-		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
+		if (pte_none_or_zero(pteval)) {
 			++none_or_zero;
 			if (!userfaultfd_armed(vma) &&
 			    (!cc->is_khugepaged ||
-- 
2.49.0


