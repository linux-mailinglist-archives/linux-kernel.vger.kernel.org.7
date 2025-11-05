Return-Path: <linux-kernel+bounces-887059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC9C37228
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0937950154F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2633A32ED39;
	Wed,  5 Nov 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfpoHwsq"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6E31577E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363834; cv=none; b=WvSWSWCZ9cqXW2L4Ry+ZrBk8V7dp7feaKkzmDQ/f0pHTHOt2w1HKv9zHr5+sp+ThjawIs9MSo6sRnNUOoDW7x/QsOqbXSf8psq2vXAJEpU+KPdbh4dRm3OLYOiROavDdCb+EkYBAI89t2fp+kOHgHItMqTXy2UIxQ+iyVnGiiOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363834; c=relaxed/simple;
	bh=qO/NLuJPuUMS5aquCLYqrzoe93p2xYxMPVgKO2WNdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9hwnH/Nh5HKP1gn0HrMaSjC/dT8j2laMCzUz7iKo+jm7zJ5M0HHRJxmD3MzRqlaRCuZtGuUGhJhzcpqxINdLtDZui5U6wBv/Mnij+XE4VCWM0NQq6r+EPjPfDMSubez+eNGt2+h42eSK3ph2v9nOMcVrDVOHf51BRRY0lNcx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfpoHwsq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6d13986f8so87235a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762363832; x=1762968632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T7mC5XsBejwVN/MD7TteppoeD76dolBCKVexUhUEGA=;
        b=XfpoHwsqfXQTs12oUAE3ACqx8oHXSU7v4HeZsu2bDVP9JmzTG9z+vYYpapDYbgwBR3
         fHYmaP3Hffvo2Lt/F+vdWH8PG3iWsCNUarNw/HgzifrcQvvfRxp8KwXpH9k5gsak1Mnk
         iyp9pdmkync6ystxbSX66hMVm1nnTAI35lgHPgc+J/iuDYCOjYAaN+Wddf1jtrZw4i6e
         OJIxVbeEMtKfBJ3ucqfMgIf91S9Ev9duLbHW9rcLWn0M3NBrZjq4c3eUVO67NKTvDBKv
         H5xeeV1hejS/ryg7omlb149m98eOiTVsTV88tfEj+VH4do426Wz9N0rJ/INpfHLQ4Uso
         lGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762363832; x=1762968632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9T7mC5XsBejwVN/MD7TteppoeD76dolBCKVexUhUEGA=;
        b=T+4dYBWwMvtdPmM8Cj9nZnDn98BpuzkeSsggTLnrEqgSlezKiyfGKCGxHC7kTn6M/4
         VsohhWV9ETdxVBbCgmdJAgmhk24p5oLepIZpDJmff8A8r4RIHUFqwP+Ez6tDJKBu1V6M
         amtt2cF28oAwKlK0RDyNvvmtl2I83GOjfEmWsIIJjWnF/AE9+yo+2QDiUZk9+d7pwpGD
         v4kfqj9eUzJUzO/EN/KF8js7fa0ktgDzAje5R7Qiu8dU1F5yDGt+j/ecq88I8MAQWwz/
         O/tqewbqHcyKZ8kHX5QchDASQfyRwvUPyB9R4ej+wxYiYrIf6pNpEGvw8y2hNY+Z2Qgc
         kUcA==
X-Forwarded-Encrypted: i=1; AJvYcCWAXtRFucL8Pf7fQx3Fw1/0cBRKeS3rP/wq96Sxy7viaI1C2B9Wd5ve28HQSHzgq9l6huLlVA8qOZsiXdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEO7u71BbcMpVcf0+fmB7cBApetrdqvz3qpl173oGzhKfn/l5X
	FHsO/7XklXTxHuYkjkyaMWo4rlX3GxaAU3k+qOklNYB4MtgfTpc2kEdR
X-Gm-Gg: ASbGncuuCXpR07Fqq6p4UcFfo3WclYSD0RQ7OfVulHxY7w6NLvuN51vI5rlUVasfJWL
	zjdaOInEyQXJx6QYApLudZImxx1qRWfi4/rieBqF39rqxAxVLx1QyTIVXlTFZQV+xcnJTFND52u
	FbZ+g7V6fj8vj47OW0H+fR4bCsTRSFQyZr1PlCxE9z2dB67LQRS6Qx93TWCr2nzzrYOvjnWoix/
	PlrvBLWh8W/+IbgCgLOr/d6c12eJIizp+UTv4aOGLI1LAoUBXraqHHt9zLfJbyA9HwBHdpGxe4a
	W8hWU3KmtZjmKCxDaPz2jlyeF303hUr6eRXIL1nPl0l2aryCZyyAi8HT+fBxLtzy3hM39pMF4f8
	SmzGWpaFINhLbihZhX5TC6P05yoCXq8VQVvZx4del0WP6mR2xRDdP1RradFKp4tevPIfD8rUN0h
	QPWd5Tvdem0iPOsyFNku9SLMDiv5uNuSSs2B/tYx16xZpMIGFpPMaXtBqB
X-Google-Smtp-Source: AGHT+IEBiljDpXhOdYTX7ZvPWxKHLbWSS4eTdnsshXb5F5CF5p8DGEANRiLmMLmNxqqbwLiDoOJOfw==
X-Received: by 2002:a05:6830:2a86:b0:7c5:3b4e:3020 with SMTP id 46e09a7af769-7c6e1404c5emr168244a34.12.1762363831770;
        Wed, 05 Nov 2025 09:30:31 -0800 (PST)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6c25108b3sm2248313a34.30.2025.11.05.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:30:31 -0800 (PST)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH v3 2/3] ksm: perform a range-walk in break_ksm
Date: Wed,  5 Nov 2025 14:27:55 -0300
Message-ID: <20251105172756.167009-3-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105172756.167009-1-pedrodemargomes@gmail.com>
References: <20251105172756.167009-1-pedrodemargomes@gmail.com>
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
 mm/ksm.c | 83 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index de10ebcf3509..5fe3d9c2cd20 100644
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
+		found = (folio && folio_test_ksm(folio)) || (pte_present(pte)
+			&& is_ksm_zero_pte(pte));
+		if (found) {
+			*found_addr = addr;
+			goto out_unlock;
+		}
 	}
-	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
-	found = (folio && folio_test_ksm(folio)) || (pte_present(ptent)
-		&& is_ksm_zero_pte(ptent));
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


