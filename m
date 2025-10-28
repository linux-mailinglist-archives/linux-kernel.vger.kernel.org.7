Return-Path: <linux-kernel+bounces-873819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C7C14CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DD91B26B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D30E30FC16;
	Tue, 28 Oct 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJYlMc3i"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBE6330D35
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657766; cv=none; b=Ryj4FKXot7EG811eui+IipGkgJ7bC98ll1QSCsKEYVj5JM3qwZxncDH4V2MseI9SRx2+48twZBhAT1vfIYIxRzYATwkv4exceBBAgqYg4Py5fG1d1SzZXDkSZr8cYk6dDKpAvzDOfavcOfAK9vxh62BlG9E9E/TH3uoWSguEy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657766; c=relaxed/simple;
	bh=96dzdQrdYu+xfjWYuXyzZ7m4SVB+a2x2dcmqjviBkvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqTNU4oIhtLHPbo3utf8K4kQfu5P9UYwNzMi1iuXS4yNQMY2SRvLoc+Mh//RxDjpGS6sRBgNsdXe2a5tSGPMhqoVD7F/ryDk1a/ZNr2uoBjiZv1Jm1SWA3xweoK7SgxuMG8gqNIJmtELvirGcJL2+IsZ15HYz4ajOahZcCXQZj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJYlMc3i; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso4069158a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761657764; x=1762262564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGSMnG+dfPqB5PeO9+sIbuI2ifAbohOvGlLiOHf29mA=;
        b=VJYlMc3i+a7mkiA6tzCd8CRoMXawn5HfhlT0LUAJcv6Qi3Vt5IRZYlvIvp1JIv2vbL
         kKspaKhOHtlCc1FlEr2aoMtOhVdvgYowyD/Zk2YkrToDqA/ss/vU+EDtfQ2n9QjwwHfL
         QquWetRb1MtQZmr8kznjXE65fC/y2agrnyD4bvVfmxrawXJ/tKbav60REqnZz4oSjIOX
         qF7IWNImYXbUAAv0jsZGU5Tjqf+bQCHDswRRhn4I8JGC7YKo3E93ANt7Y1xOZPaOfp0u
         eXvWtfjxzkRws92VHmTvQ7RgzBXm1RXrC8Gvjqbkte7yxy3q5pDxdWu8Y7sZ7xACe26g
         0pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761657764; x=1762262564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGSMnG+dfPqB5PeO9+sIbuI2ifAbohOvGlLiOHf29mA=;
        b=NWpYPjCaJwd/y9JIwDQdas7RnYA/iwMT/xQ1d25J3RMbGshVqXyPaWyPKHEeYj23Xm
         KTjVl20COD5BSMJbDOkwf2vu1c+o7OOeuGE8Y6MAIL+p5juj4Ei9u1V1jkYf4iMQF7Na
         hsUaQkTVJNY1OXQeTUl6QaR+rCysIT6WDEx2X7v51DWL0d3OzwTRaBaNEyRQxYi6LpNE
         y3hNrSRJ2XIB2cX4zEzaSJVzF+6h/1Jmmu9PITznELdY2QEJ7VZOlbN4RYFVxTXoF7J3
         UqG+08b9h9AWFfckxwZw+iKee1FrAsfIyPhhcWxT8urLtSCNbKNHKocEPU2ybMHxFWAP
         0msw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgkxaY7Ws61Z6Z+Sk60LOeVsQavNpGiqPBG0mPy3X5x7QMUlhFxs+CswhE+8PXWjuMJCzkvMkHX+eltU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZThNqNKQWxsfTpa7YzPxPkQcfydOjx++Uyqm8LPWhVx6iw4u
	Y0E6z2+IESR5AyX2aBxWR09F/yhQK4yXOQCzMWDIDGLhVa38mQSUbcUF
X-Gm-Gg: ASbGncuAR0LeFxV8rWxtOo9jQ/aTf4J/xRrLBKChGHp3/c+YCRWgV2l4YfCtCGytJ5T
	lVGeBYsYJIrqNTf0hTiL13czL1g2iy1jguxB2oo8vR0cxz2XCdtclNzUBJcRoQa/vqhadKWoEU1
	wgyBYoWoaz/Uz6aeVComE0L0wHvsBIJ9YDbgRtjqVurSEMJHIvsW8emHxP1cEP2qz7c8mAdmOEC
	0hMu8URJxNBh0vIf1geQmSVfMarfTPjqHuVLiM17wWaNbBw89Rv4tQLyfpDfZTTzIL9abAb1uTW
	EGxwH1Qs8oOGBarin3DgKRLKO2eEMZcvhux09g8XsnCNDghDjJcC/ctsALb7Sa0r1PlKXanXtGr
	HBv2Z1T+HulsAuOijvt9gt0p014ydyjcl/f4xn/fqOHKSS0RSa5oq5vma+X0tju3txJa7/Oe2v1
	XCtEH0wluC5dGMg8PLLUqt64nF
X-Google-Smtp-Source: AGHT+IERdQtSDdu2ALxwESRZtQdoqizCIyrUk8LFMRRdLzwdff1L8If+YNv1ncII0+3vpd4kLKVlkw==
X-Received: by 2002:a17:902:da91:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-294cb3816e6mr48946635ad.18.1761657764129;
        Tue, 28 Oct 2025 06:22:44 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([177.73.136.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm117446235ad.42.2025.10.28.06.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:22:42 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Subject: [PATCH 2/3] ksm: perform a range-walk in break_ksm
Date: Tue, 28 Oct 2025 10:19:44 -0300
Message-ID: <20251028131945.26445-3-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028131945.26445-1-pedrodemargomes@gmail.com>
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
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
significantly reduces runtime, as confirmed by benchmark test (see
cover letter).

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 mm/ksm.c | 88 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2a9a7fd4c777..1d1ef0554c7c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -607,34 +607,54 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
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
-	struct page *page = NULL;
+	struct page *page;
 	spinlock_t *ptl;
-	pte_t *pte;
-	pte_t ptent;
-	int ret;
+	pte_t *start_ptep = NULL, *ptep, pte;
+	int ret = 0;
+	struct mm_struct *mm = walk->mm;
+	struct break_ksm_arg *private = (struct break_ksm_arg *) walk->private;
 
-	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
-	if (!pte)
+	if (ksm_test_exit(walk->mm))
 		return 0;
-	ptent = ptep_get(pte);
-	if (pte_present(ptent)) {
-		page = vm_normal_page(walk->vma, addr, ptent);
-	} else if (!pte_none(ptent)) {
-		swp_entry_t entry = pte_to_swp_entry(ptent);
 
-		/*
-		 * As KSM pages remain KSM pages until freed, no need to wait
-		 * here for migration to end.
-		 */
-		if (is_migration_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
+	if (!start_ptep)
+		return 0;
+
+	for (ptep = start_ptep; addr < end; ptep++, addr += PAGE_SIZE) {
+		pte = ptep_get(ptep);
+		page = NULL;
+		if (pte_present(pte)) {
+			page = vm_normal_page(walk->vma, addr, pte);
+		} else if (!pte_none(pte)) {
+			swp_entry_t entry = pte_to_swp_entry(pte);
+
+			/*
+			 * As KSM pages remain KSM pages until freed, no need to wait
+			 * here for migration to end.
+			 */
+			if (is_migration_entry(entry))
+				page = pfn_swap_entry_to_page(entry);
+		}
+		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
+		ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(pte);
+		if (ret) {
+			private->addr = addr;
+			goto out_unlock;
+		}
 	}
-	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
-	ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(ptent);
-	pte_unmap_unlock(pte, ptl);
+out_unlock:
+	pte_unmap_unlock(ptep, ptl);
 	return ret;
 }
 
@@ -661,9 +681,11 @@ static const struct mm_walk_ops break_ksm_lock_vma_ops = {
  * of the process that owns 'vma'.  We also do not want to enforce
  * protection keys here anyway.
  */
-static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_vma)
+static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long end, bool lock_vma)
 {
 	vm_fault_t ret = 0;
+	struct break_ksm_arg break_ksm_arg;
 	const struct mm_walk_ops *ops = lock_vma ?
 				&break_ksm_lock_vma_ops : &break_ksm_ops;
 
@@ -671,11 +693,10 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 		int ksm_page;
 
 		cond_resched();
-		ksm_page = walk_page_range_vma(vma, addr, addr + 1, ops, NULL);
-		if (WARN_ON_ONCE(ksm_page < 0))
+		ksm_page = walk_page_range_vma(vma, addr, end, ops, &break_ksm_arg);
+		if (ksm_page <= 0)
 			return ksm_page;
-		if (!ksm_page)
-			return 0;
+		addr = break_ksm_arg.addr;
 		ret = handle_mm_fault(vma, addr,
 				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
 				      NULL);
@@ -761,7 +782,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
 	mmap_read_lock(mm);
 	vma = find_mergeable_vma(mm, addr);
 	if (vma)
-		break_ksm(vma, addr, false);
+		break_ksm(vma, addr, addr + 1, false);
 	mmap_read_unlock(mm);
 }
 
@@ -1072,18 +1093,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
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


