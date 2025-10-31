Return-Path: <linux-kernel+bounces-880759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5FC26791
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F0351C96
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9433217705;
	Fri, 31 Oct 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiZsNcKt"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AC2D2381
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932931; cv=none; b=Lcm/1+8VwECxJKoWnBs/6I7VEfnx4soXKIFYaZhaEilT1VN33HBkMztmSNpW+pGemHf9/A2eNINMfwcR0y7h/zHsihFxzSmMkwL8qwSflJmEZLiV1sV+EP+myxCaQADnYu44AWDXTEWuBTaifOgSp6QlzyMjCR2kIcGvuECml2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932931; c=relaxed/simple;
	bh=fMTeQUScwfPBnCERwqet3M8fXXrksvZoCfqleFsEHLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rup0GU48xxRXbbxa9B1o+SuJBLtROf+T+8j2tKUzbRzTyJ0XDtFbgCFeioDF7ggFKoD2u1Nf77KzFYtqyx7wX7qhtgfKVGEGO3F1ivA6Mcczb2Wld3279L3nTxQvbM68RYB2I3ep93TuM7pMreczhhMg/AQDvnfU1p0CzFL6qZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiZsNcKt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-294cc96d187so33547985ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932928; x=1762537728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suj6Dur0K6qgOtTWDhgGJ8k45c2o5OzoxZ5K0IrFENE=;
        b=JiZsNcKt8NPp/RrufRSvLxDl2LmE91ckCojUGz2co4udPxUEnVR8NIa38kQ954+6GE
         azgj71pma1uloqjz3WMUvU2HeoDQnfHjTi5s2Vm+V2xrvxVLX209dIlT1KpM15RKQ2Hv
         8Jy0q+ejFmNZjGP9KnlCkQLuSlSp0T7gQxq1brYQdjGV+sN/LDZfWP8619rudFcelk17
         KzKqcfpgnC2lOLehD1YlVR+5sFA5IuMRRx4W3uwGm4HuBge5dFIOS8XCxs3BpXsGR9Dn
         6DdumfdhSSlV3rss0U9gmssnHT+6oYqhC1HaNRn8NUB8C9VJM5UKeCgdY3kIRKr7SDLN
         Huww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932928; x=1762537728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=suj6Dur0K6qgOtTWDhgGJ8k45c2o5OzoxZ5K0IrFENE=;
        b=AXP8ZXVvjBBv25VxkB21NT20PwZ0wPucoLtfZGBchESZnPYLgoLxj8CHrDw0xnygZe
         dD01co9GXxJJF7EdI+s2DYUeTrXxsIAgskXzrYtg8V05W863SkfRo+V8vIREUsDzAnpo
         7R4/sCa2oY0SMYwCtYOwBbGdNP8MCws12J8dlzF8Jf7stVSCvson1ZgQcLKE6umawpVG
         sFjQSPRsTnPjJGhxin4fOMQIcQT19AZhpAX4/FAUFZf2mGyydtuyfodLbo1/8ii4maXh
         tdSMCkGsput6z74lbkWITpXvRGvZyLUiZID3ePNZghrNZuMTkzt4By05Pui77Mu/B/9L
         XhCw==
X-Forwarded-Encrypted: i=1; AJvYcCUHeP0CUoDu7FqziyvmWQtG2diGOimKXKtNi9Rg6YW6qvrJ9/FI5YeN8DdEBRyWidSdBu8TMq9lgorJ/2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27N4Gb00WokQL5r78x6wY7vwlfyMxmkbXoANB+DHJU9jdTpqt
	2kKICPYnKfB81kX3YJYM+s2+kbE0I56J+AuBJy2WISK5tGT0UooATtjf
X-Gm-Gg: ASbGncsUpesD7rXdm7LkNSrim61Ik+qM/1j/Ay34Nwd6NsI8ghbsLrFxeGF3qJMUUQ7
	9BpRs5toc1jV/b5vlHjzISKf5oZ2zD1Fa9lt5oK+0wumlAbN1+wd5fiHpBeY5SgvbSX9WG8qJYY
	KG39FhLaEc7Li1kV91SiJAbVYlRCEzJ2+UDU+Rht4WOhROEXXA8TE+1KZ3wfWewc/OGxNZKwPwc
	p5DIzhp7o+F54jNdmCVISIBE2m2P3rKDSXuJKDB/lFu5LR+ROYGfJR2U19pLzO26v3UCiXfc9A0
	f7IkNwDuRI6deg7TZWZHSKIqMhFdP7HCGvPN8P12HaD9pCg0Ek0w0W+wPvmO+dxNTybpK26YFvn
	WlquwRZadakGHVIPW/O+RtLlQaxKuOHGUbrgmmZIr6BeWSb3oz5u2W2Yai2mCFHH1clhcr5793k
	nczGcJ/K8pu7yKpg/RfhjV/x7C
X-Google-Smtp-Source: AGHT+IEJ5Souq5YXwjodyLW6kaFFMxjoA2rgMiNGNGLghFOxvhist2DSCElTCEeTgxQTMrfnKIBxkg==
X-Received: by 2002:a17:903:32cd:b0:295:30d4:23c2 with SMTP id d9443c01a7336-29530d4476amr27224805ad.50.1761932928285;
        Fri, 31 Oct 2025 10:48:48 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871693sm30113185ad.20.2025.10.31.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:48:48 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v2 2/3] ksm: perform a range-walk in break_ksm
Date: Fri, 31 Oct 2025 14:46:24 -0300
Message-ID: <20251031174625.127417-3-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174625.127417-1-pedrodemargomes@gmail.com>
References: <20251031174625.127417-1-pedrodemargomes@gmail.com>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 88 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 922d2936e206..64d66699133d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -607,35 +607,55 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
-static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+struct break_ksm_arg {
+	unsigned long addr;
+};
+
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
-	int ret;
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
 
-		/*
-		 * As KSM pages remain KSM pages until freed, no need to wait
-		 * here for migration to end.
-		 */
-		if (is_migration_entry(entry))
-			folio = pfn_swap_entry_folio(entry);
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
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
+		found = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(pte);
+		if (found) {
+			*found_addr = addr;
+			goto out_unlock;
+		}
 	}
-	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
-	ret = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(ptent);
-	pte_unmap_unlock(pte, ptl);
-	return ret;
+out_unlock:
+	pte_unmap_unlock(ptep, ptl);
+	return found;
 }
 
 static const struct mm_walk_ops break_ksm_ops = {
@@ -661,7 +681,8 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long end, bool lock_vma)
 {
 	vm_fault_t ret = 0;
 	const struct mm_walk_ops *ops = lock_vma ?
@@ -671,11 +692,9 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
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
@@ -761,7 +780,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr, false);
+		break_ksm(vma, addr, addr + PAGE_SIZE, false);
 	mmap_read_unlock(mm);
 }
 
@@ -1072,18 +1091,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
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


