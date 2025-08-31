Return-Path: <linux-kernel+bounces-793305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB835B3D1AD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293CB189E95C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3EA2609EE;
	Sun, 31 Aug 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iFoekoCM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FF25A321
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633189; cv=none; b=qfJDHWyih3hf/WJpyamq7yjYA4tCIOfQ3M64X/dOTSEPoiCMaXP//7rY+hX6p8PHWFrQXjJG+wQ2eAYpHEj3tdHb73QoyxdUTqwbzKC65slorvshBIBz0BfDj5anOSFlVP2aqJAQVTFNtXykAtSUUcyG8TXykVdjJ2t3vV6lFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633189; c=relaxed/simple;
	bh=M+EH3GcVc7BmaAbF2qOjzWbOIQgl5J4uB6cXp0x+q5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2VRdVYycRgMfHnDmfT/y2IPtKInZV6iAK0IWWxja0CJL8tU/dlSUYTO2qyAG8r9/Pom2LBvDUi7mipHfNF6w69A0i386GUY2IHyFEeXhSSvJ+c4wiuBJOEAFuD1h6b9iipyrPh8fjZrzUmR44yN+W4fvmwY83mY28Hiza1eohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iFoekoCM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b04163fe08dso80361266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633186; x=1757237986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzEgZJLUIP42C+8Yle96H0gi+Ol4omF0icbAf6DUhQg=;
        b=iFoekoCMcyGIdwJ3cDZkItKFLElrDDPkh5fqw07F5WdIkLU92LNnCTl7+8xThxyGbE
         fpyk+7L4n7smLFIvp0reupw0p48WHoGpuYmzgeyPnLSFKFBNVjWO8/q5ld8GEjJICKOU
         QDo12Zs3RLnus2PeTwu8lTdJAVAUa8elZgqtgcBYLgGiH/PEhp/FUY+yjBMthoSzVniv
         HLv9kCL3gsVjlqURXB8wZD3oeZvv1eqfd+0s9j8MZG8BduesUDy17J32nOhTR1URbNFH
         jOK5z0HVKkYWGaTIaml3Lx72qZkA2KxB3vtKPByohR43zDnZMqWGCxnShyGfSp8b5hLL
         bvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633186; x=1757237986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzEgZJLUIP42C+8Yle96H0gi+Ol4omF0icbAf6DUhQg=;
        b=xUjbpasfnbTWCi2G4i3r4ErZ7RcJVMWlLeaNDdbCfiZ7mT4cxPbtis3hR4eh0Vspxu
         Npb4dt3uw65bEGAS4Ov3bTA5F0hq9MJoGlj224mwUXqkNiS6AvR3ybvoVWZXnFx8J6oV
         el16RUB7Opn047qIgC0XvIj3dbM7eiPtTzlegfMS7IlCch99iI5LILK25rNj5aMB2L8N
         zUmJMNBSTDpt8eP9nzhEyE8Pfy4N/eknffT/ZrWm4K2o5H/5a2fVlhoZuGMk4UlBnhki
         on627PMWlOlvvghhlG2+5/+ot82N1vSCfG15Mp1UVEdyvuBLV72UbHJdBCBvQcKDe7E8
         HJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3p6UQOP/327ZrUZYPeV+nh2qqyhPWLcLCXd09ArEEQoypJ5K96oWBYm23PA6ZWrI6FzJxEcx8xfvLPP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5J4LK3DfcgESuyHp1GBjVUFbqqB16kZ+MldMhjNQWKyeXIey+
	OuuMVUirORv1Te8l0vDCRngusXZAvfZ5GAja/30W/sixJeMbzSoNlZJKrV+h6dbpF/whkqrwDFX
	AnF6H
X-Gm-Gg: ASbGncutbUbhle0+0wkwwl45zPqP2X43d+uxz9nBI+ll8kujUd0hkJzYnS7glULoa4q
	5TTpwPLX/CfW8AWiTkFzwUBHH2rr+ywXkECdx5CXGTxFkE02N1I+lF6+yfsZuGIevRP0J0RLcFj
	IWLUNl/h8LG/gClshLmkTs8IEneADtTx9TJnT8ZSAEg7I4vOFsYq+iOywYSKevJyg9uuIjY13B8
	B5ntAp67jIs0yv7Wtdr47sfI5hQotktAuwQBKZWVSagPO4NKdEN8Xrt0YkIbeSeXm9CGqo9yK0j
	YAxFv2IWgT2i4gkMU6c+KQwIQDiY39CRGDAkJYq068cYFS0jpFCAXDwSEavJSlmdq6fzLmXS//B
	vmINPozhQDVruMIjYoLL4cnWElcBSxT/KVHdLJacgx/gc6qzcaFTgtNqiMVsXjS9p2ty7FWfnW7
	FK8eoVh3dZ6aH9GjqwFAb9tA==
X-Google-Smtp-Source: AGHT+IEuD6oVNFdoCcKagugA75LHNebXvR8cOgEl3UMPjRhdvNPJVp574cFB+Bbnvq6T7+AbQgvIlg==
X-Received: by 2002:a17:907:970a:b0:afe:d3b2:8b1e with SMTP id a640c23a62f3a-b01d9743cffmr421146366b.38.1756633186146;
        Sun, 31 Aug 2025 02:39:46 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:45 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 11/12] include/mm.h: add `const` to lots of pointer parameters
Date: Sun, 31 Aug 2025 11:39:17 +0200
Message-ID: <20250831093918.2815332-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d12550ae9814..7c8b7f6a14fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -703,7 +703,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 		mmap_read_unlock(vmf->vma->vm_mm);
 }
 
-static inline void assert_fault_locked(struct vm_fault *vmf)
+static inline void assert_fault_locked(struct vm_fault *const vmf)
 {
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
 		vma_assert_locked(vmf->vma);
@@ -716,7 +716,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 	mmap_read_unlock(vmf->vma->vm_mm);
 }
 
-static inline void assert_fault_locked(struct vm_fault *vmf)
+static inline void assert_fault_locked(const struct vm_fault *vmf)
 {
 	mmap_assert_locked(vmf->vma->vm_mm);
 }
@@ -859,7 +859,7 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
 		vma->vm_end >= vma->vm_mm->start_stack;
 }
 
-static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
+static inline bool vma_is_temporary_stack(const struct vm_area_struct *const vma)
 {
 	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
 
@@ -873,7 +873,7 @@ static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_foreign(struct vm_area_struct *vma)
+static inline bool vma_is_foreign(const struct vm_area_struct *const vma)
 {
 	if (!current->mm)
 		return true;
@@ -884,7 +884,7 @@ static inline bool vma_is_foreign(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_accessible(struct vm_area_struct *vma)
+static inline bool vma_is_accessible(const struct vm_area_struct *const vma)
 {
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
@@ -895,7 +895,7 @@ static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 		(VM_SHARED | VM_MAYWRITE);
 }
 
-static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+static inline bool vma_is_shared_maywrite(const struct vm_area_struct *const vma)
 {
 	return is_shared_maywrite(vma->vm_flags);
 }
@@ -3488,7 +3488,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
-static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+static inline unsigned long stack_guard_start_gap(const struct vm_area_struct *const vma)
 {
 	if (vma->vm_flags & VM_GROWSDOWN)
 		return stack_guard_gap;
@@ -3500,7 +3500,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 	return 0;
 }
 
-static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_start_gap(const struct vm_area_struct *const vma)
 {
 	unsigned long gap = stack_guard_start_gap(vma);
 	unsigned long vm_start = vma->vm_start;
@@ -3511,7 +3511,7 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 	return vm_start;
 }
 
-static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_end_gap(const struct vm_area_struct *const vma)
 {
 	unsigned long vm_end = vma->vm_end;
 
@@ -3523,7 +3523,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	return vm_end;
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
+static inline unsigned long vma_pages(const struct vm_area_struct *const vma)
 {
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
@@ -3540,7 +3540,7 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 	return vma;
 }
 
-static inline bool range_in_vma(struct vm_area_struct *vma,
+static inline bool range_in_vma(const struct vm_area_struct *const vma,
 				unsigned long start, unsigned long end)
 {
 	return (vma && vma->vm_start <= start && end <= vma->vm_end);
@@ -3656,7 +3656,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+static inline bool gup_can_follow_protnone(const struct vm_area_struct *const vma,
 					   unsigned int flags)
 {
 	/*
@@ -3786,7 +3786,7 @@ static inline bool debug_guardpage_enabled(void)
 	return static_branch_unlikely(&_debug_guardpage_enabled);
 }
 
-static inline bool page_is_guard(struct page *page)
+static inline bool page_is_guard(const struct page *const page)
 {
 	if (!debug_guardpage_enabled())
 		return false;
@@ -3817,7 +3817,7 @@ static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
 static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
 static inline unsigned int debug_guardpage_minorder(void) { return 0; }
 static inline bool debug_guardpage_enabled(void) { return false; }
-static inline bool page_is_guard(struct page *page) { return false; }
+static inline bool page_is_guard(const struct page *const page) { return false; }
 static inline bool set_page_guard(struct zone *zone, struct page *page,
 			unsigned int order) { return false; }
 static inline void clear_page_guard(struct zone *zone, struct page *page,
@@ -3899,7 +3899,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
 {
 	/* number of pfns from base where pfn_to_page() is valid */
 	if (altmap)
@@ -3913,7 +3913,7 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 	altmap->alloc -= nr_pfns;
 }
 #else
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
 {
 	return 0;
 }
-- 
2.47.2


