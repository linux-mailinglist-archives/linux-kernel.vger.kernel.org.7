Return-Path: <linux-kernel+bounces-887149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2EAC37632
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EE6F4E6208
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9F315D57;
	Wed,  5 Nov 2025 18:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVL6Sfc1"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCA3346A6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368714; cv=none; b=VP7hzNtGuiyo4kv8eqpZl0LL9ANLHKkv9Yf/BoK1jdWxYbBgXzTr7oReAQ8epgHh4dDUZgIgFV8MKp3LFC8lGDTbC4aYUCkWRVIn7dzva8QD8NAAokEy5yEWXPzeNRu0zH8n8eyUkt49Hhl6jXVspY1YygQ4bdLWYuTqxWRM9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368714; c=relaxed/simple;
	bh=iXRXSc72+ck9biCOnsDQfDxVH6sbHMPGL3oEaKrwgYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ1S3e6BrU7SnguBnfaFOx3ljTxhT8zfHwgDYRHCcPcj4VYBmuF0z553rQauCE7tTq7mWhVieV5ZOPJbDYrKzS/tF54QEQcizfIuKr1ysx0PKYXq3hZWQzxQp/udJnmWbmOruXXgPeg8IobkmAAavVqm7r6EB+Ylps2GQJeGm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVL6Sfc1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso215640b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762368712; x=1762973512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUaQOSDeSY3xlmWNT6LRyPB2LIv5pFA+AQBxwZjm9KA=;
        b=MVL6Sfc12fnrNm4FAZ9HLD5sJceLMT6TBFiQi/rUDVBlfVgUA1hDMwaidrPmBAYSsm
         U8QdB1Bzng5vVEn0hrKCTiOusuG/zM2b4Yp1K39obU2EdvmUpumtTPvtfuMZ2pXvoZUm
         suBncw7F+p/QRSmByP6q04Wz+kiPWAkqsM5wbtriByDYRfDcVcHrrHNTff20rOd3iC9a
         //aI0UfY2ZVqtaB2cOr6Pn935OHa/eVq4yIpN4QoJCedqu5wCyW4ugjXdzRXbXL51+Ua
         mahz5mW+9mGn/QcmoBr4sefTmna0F9pRO5gfBsZfzp/BuuSBK9lHLTh6ZQj3XI/9f3eg
         Vizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762368712; x=1762973512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUaQOSDeSY3xlmWNT6LRyPB2LIv5pFA+AQBxwZjm9KA=;
        b=vvaRl7mCtSGGiysqR1n+eA0tjX94e6f9YmsNj4sS28NnYGww8Dqbin2vn2VWeifC8+
         VSCiSnus6MoPY/Fm6CZalQWno/3yOAXinyI2Oum1TnoDxszRuYmxQ5kMDM1y/OtaKqmJ
         +GzZ91KpIeGRcd5hVmPPSFiti3/EMWoQHtreLr/LQRH58s06LuMa96WLx2Y+3lrx6IGs
         EHHdkk4gPOfzxbHa2os4jCzPZ1sNyO7NwkLZnD/TNueKrhQbWyAfTwiBU2IDV9fJxOkn
         Zk9u4qxBbumvKeRnovLSLhWloh521BZQGsOcopm/9gPrCfwsz6aJNA68/nPAicDzA1+l
         Tfcw==
X-Forwarded-Encrypted: i=1; AJvYcCXVPw77ychfqn0XiLrg9IvBgOkYxe2MJid4GgIsIQUGPhixG+UjoqhKLtZznu4ccQWNgxaUId5ofgwQRkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVBg0AMD4QwcZycZZk3fcHEDxJHQUOHYAL1q4i76HV2odiN0C
	sm5Uy++alIAaWCj4h+7l9fi8Mr5zQNvz4CXDPzzjaHTQ/kcixkdmn4rj
X-Gm-Gg: ASbGncuL01sCDluoyuaAoy8iM0ML6ZJLWsM/IbAlhhkEoOjWDnUuWRihDUZs8u0bz/j
	zzVnMN3sr7+Dk5OTewWMMo2HPppg3DOvNfOIl1HTjbxmQ1ejROzvL5PpDiEvPxQzgMvj4I+JnLY
	GWxrgzN74LzyPrw7Bt2Rmf0fezsJ0FSJhTX8VYFMl5BBMmJd76ikyVhp68TCNcB2HyS+FrGd7IT
	GxZDy8dDgeX0BFLfwBNoz+Q0Q0Zg+Lv9F45qhD95w6821vHyCXNrbBW2inQ/2pRchAAUDWcogvI
	WsmgF8MmMRqPlespqdXxx7SG4hrEVEoTeUQxRw38utqJ9dQKkEnGbuDqAdsKX5el74nVH6oN8IG
	91IwVn/0kR7k8n874csPWvkRI1LkTOebK+BqoNuaFFK9+lOfaGf8NiKcZ63LVJj8mXqWobYYu9R
	s/9fwmNAq2FjsSSisHMzqks0GUFSxxWQpquLhc9IHoh5BsS73B7+4veoSqLhOX86rBUBc=
X-Google-Smtp-Source: AGHT+IHxASxsK8vTXLXO/0PsN4EEUlCT4YiPJmJu56rmIQqT4YnWndf+GkwmJcPBmnTEv82AgRzXbw==
X-Received: by 2002:aa7:8891:0:b0:781:be:277e with SMTP id d2e1a72fcca58-7ae1cb61439mr4730826b3a.4.1762368711955;
        Wed, 05 Nov 2025 10:51:51 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af827effebsm118409b3a.57.2025.11.05.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:51:51 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: [PATCH v4 2/3] ksm: perform a range-walk in break_ksm
Date: Wed,  5 Nov 2025 15:49:11 -0300
Message-ID: <20251105184912.186329-3-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105184912.186329-1-pedrodemargomes@gmail.com>
References: <20251105184912.186329-1-pedrodemargomes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make break_ksm() receive an address range and change
break_ksm_pmd_entry() to perform a range-walk and return the address of
the first ksm page found.

This change allows break_ksm() to skip unmapped regions instead of
iterating every page address. When unmerging large sparse VMAs, this
significantly reduces runtime.

In a benchmark unmerging a 32 TiB sparse virtual address space where
only one page was populated, the runtime dropped from 9 minutes to less
then 5 seconds.

Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 83 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 9f74baf01e46..43be57a6a3fd 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -607,35 +607,50 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
-static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			struct mm_walk *walk)
 {
-	struct folio *folio = NULL;
+	unsigned long *found_addr = (unsigned long *) walk->private;
+	struct mm_struct *mm = walk->mm;
+	pte_t *start_ptep, *ptep;
 	spinlock_t *ptl;
-	pte_t *pte;
-	pte_t ptent;
-	int found;
+	int found = 0;
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte)
+	if (ksm_test_exit(walk->mm))
 		return 0;
-	ptent = ptep_get(pte);
-	if (pte_present(ptent)) {
-		folio = vm_normal_folio(walk->vma, addr, ptent);
-	} else if (!pte_none(ptent)) {
-		swp_entry_t entry = pte_to_swp_entry(ptent);
+	if (signal_pending(current))
+		return -ERESTARTSYS;
 
-		/*
-		 * As KSM pages remain KSM pages until freed, no need to wait
-		 * here for migration to end.
-		 */
-		if (is_migration_entry(entry))
-			folio = pfn_swap_entry_folio(entry);
+	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!start_ptep)
+		return 0;
+
+	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
+		pte_t pte = ptep_get(ptep);
+		struct folio *folio = NULL;
+
+		if (pte_present(pte)) {
+			folio = vm_normal_folio(walk->vma, addr, pte);
+		} else if (!pte_none(pte)) {
+			swp_entry_t entry = pte_to_swp_entry(pte);
+
+			/*
+			 * As KSM pages remain KSM pages until freed, no need to wait
+			 * here for migration to end.
+			 */
+			if (is_migration_entry(entry))
+				folio = pfn_swap_entry_folio(entry);
+		}
+		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
+		found = (folio && folio_test_ksm(folio)) ||
+			(pte_present(pte) && is_ksm_zero_pte(pte));
+		if (found) {
+			*found_addr = addr;
+			goto out_unlock;
+		}
 	}
-	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
-	found = (folio && folio_test_ksm(folio)) ||
-		(pte_present(ptent) && is_ksm_zero_pte(ptent));
-	pte_unmap_unlock(pte, ptl);
+out_unlock:
+	pte_unmap_unlock(ptep, ptl);
 	return found;
 }
 
@@ -662,7 +677,8 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long end, bool lock_vma)
 {
 	vm_fault_t ret = 0;
 	const struct mm_walk_ops *ops = lock_vma ?
@@ -672,11 +688,9 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 		int ksm_page;
 
 		cond_resched();
-		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
-		if (WARN_ON_ONCE(ksm_page < 0))
+		ksm_page = walk_page_range_vma(vma, addr, end, ops, &addr);
+		if (ksm_page <= 0)
 			return ksm_page;
-		if (!ksm_page)
-			return 0;
 		ret = handle_mm_fault(vma, addr,
 				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
 				      NULL);
@@ -762,7 +776,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr, false);
+		break_ksm(vma, addr, addr + PAGE_SIZE, false);
 	mmap_read_unlock(mm);
 }
 
@@ -1073,18 +1087,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
 static int unmerge_ksm_pages(struct vm_area_struct *vma,
 			     unsigned long start, unsigned long end, bool lock_vma)
 {
-	unsigned long addr;
-	int err = 0;
-
-	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
-		if (ksm_test_exit(vma->vm_mm))
-			break;
-		if (signal_pending(current))
-			err = -ERESTARTSYS;
-		else
-			err = break_ksm(vma, addr, lock_vma);
-	}
-	return err;
+	return break_ksm(vma, start, end, lock_vma);
 }
 
 static inline
-- 
2.43.0


