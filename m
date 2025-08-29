Return-Path: <linux-kernel+bounces-792305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73EB3C281
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EC41C88478
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A1035334C;
	Fri, 29 Aug 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WsMg+Tvv"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E63350837
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492340; cv=none; b=AkBsE7xH8pMVwKezedGzvrSReUosUrPG/XHin8YKd+hBfOoaLpQLGHr9G19I9nxLzDINIYlHmyyX7kxdPaKrenSeo/1laTsLi7vEjHt7P0WqhkceUOODsURQ00WuVTX2ptKOp05XCzNwXb2eOkVd8RVokI3vuOjBW9tmzi/Xx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492340; c=relaxed/simple;
	bh=KBzoJEnP5RpkSJ7LG7MYcA6u4G/IpPYLal/QclJt7gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWZBmFw4pYO+wcN8AoXVYUkq3yoKMFq0IW12pPGcKHjFmlsBHys5fLeqsRg+s0U86/5xbuwi2iJ/nosZyB8vrM27tlObqhPw7L/3UYHIYvkDkQiJUOMecu5DWoVeYhnakOufW4u0U/8pPvGCtJZHCosshZ9hIHhO7ClUoyjoIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WsMg+Tvv; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78ead12so394248966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492337; x=1757097137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe6DpLq59T2oGBgvmta3nCEJaBGqnD8+qIkEiE/ndtY=;
        b=WsMg+TvvWTq0KOtSy0j3saOaub1YljMOjeC7Z9LyKkKoXTbSleDwv4rLKPyDVAq2jH
         dOuKKP4DT/EI4jIzVAIsTVb/rn/7iV9JX4oaOSYpyb5dB4Di5aqupTXL6v9Xbs2TOiKZ
         bFJfWs/eHOn6l8+zMrDf7ohufYrd8cVRP3S4rwUayKVSWHvaixknUUhb6Q+ErstZf54e
         QcxDKYJ0spr3XkJ/eGWg7+VtCsW+Usx+5c+Xqgi/E7wPxLV79lIZZWaezsVCnrwL4Cc/
         N+O5+F/HrRD1+HWAT1/X/3KvRWcF4faDRBVKIY7y3RTrChdC9b72T8iokv8Dfm5p3dIu
         P8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492337; x=1757097137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe6DpLq59T2oGBgvmta3nCEJaBGqnD8+qIkEiE/ndtY=;
        b=tpHQjz0su6a2SpWuUpDhIBv8QgVM0LUlWVccE1Hvol6YykFQueaKDgwamuxaxN9cm3
         LCW7/tEvqkiy3SZscOn40pb+5Y/+o1sgQyYFs4xjJsZnJcMQB9N2ELzFqCVpIji0W41m
         phqKXCRYMBx48Yz3574pgXamg+UwGJ1YHwV8QfIvwd/xsnZfobq8SKrnoMmEq0QmXvmw
         xWQFgSo0ctOgV7a82O23HJRGlfJP2ZMO0A7TwWdY9/wsB/UTwytveq3p8NnzIBVJ5a/6
         7mJ3HlaNypCLGc4cxZG90ddLBWsQSJIl49Hzs9j5ZDrWlGKRGhnSirh78qiMwj97LJfA
         6VqA==
X-Forwarded-Encrypted: i=1; AJvYcCW7nm1SJkfJENEjdlTJK1yhfqqn8Ne6s2ynBlYAYk0gFtzCx8/UddpA2AWeCl2wKWHfdavQ2t8os2txiac=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMmbHUcTEfcsTvS4DIFFTV/iKcwhbysITTg34Yi9jnERUzUXb
	KHQ2FmZw4QRHBFrwkUKEUqPvoxC4WGtL3PU/9sb9wjc2AT9uEn40tGwmI4ybgoueYVk=
X-Gm-Gg: ASbGncsOieuJnBnPfjpYoomJ0Ff9cLZccocAQeYVY2ciKUFptpm5g09bthjyQNdv1L5
	hLbyp+Y45BlUVhpX19TP7RpIgnNhYURxJyVLP/BIebphmOIY9o2nihcTxrZygLax9186glggVmB
	f0ompNlVemN+t55/FVj/I9EgyWjZwEO2pI2ZeesXW1026puyyy/2NsT4lFZ4vkNcXTxHqlFveNY
	NkT1M9i3gaYgpuezrUIrpZIfX6JRKNW08Dwo1WjPvAnw+WfymmIguTHTk42ySuElYG9mgNaXqgf
	pzUurbGShySGMQaedVJOFnJyVUEcJ0kOpu01S2QaCvuI/TRdk7L8HbuirpQySc/VvxOTP7AJbrt
	mU+VEiiAOH9a21/yIwLn8MFp0SEy0AeCZaTaKC0K4bC9zY2NECvvSWVhsH+Cj8IIk975IjN5T5w
	e6rlDNMgt8zJFqOI6j0D3tRw==
X-Google-Smtp-Source: AGHT+IGUAfjuxVvWgJ0jIxnVUYcEnT26Z3aV7rgprRJcq8RNlAdb2W2lc2qvTd0AHP5zAdyY21KVaw==
X-Received: by 2002:a17:907:9687:b0:afe:d48e:34f5 with SMTP id a640c23a62f3a-afed48e3bd5mr851988966b.12.1756492336971;
        Fri, 29 Aug 2025 11:32:16 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:16 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 11/12] include/mm.h: add `const` to lots of pointer parameters
Date: Fri, 29 Aug 2025 20:31:58 +0200
Message-ID: <20250829183159.2223948-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
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
 include/linux/mm.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 48fe838723ed..953368e578f7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
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
+static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
 {
 	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
 
@@ -873,7 +873,7 @@ static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_foreign(struct vm_area_struct *vma)
+static inline bool vma_is_foreign(const struct vm_area_struct *vma)
 {
 	if (!current->mm)
 		return true;
@@ -884,7 +884,7 @@ static inline bool vma_is_foreign(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_accessible(struct vm_area_struct *vma)
+static inline bool vma_is_accessible(const struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
@@ -895,7 +895,7 @@ static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 		(VM_SHARED | VM_MAYWRITE);
 }
 
-static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
 {
 	return is_shared_maywrite(vma->vm_flags);
 }
@@ -3488,7 +3488,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
-static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+static inline unsigned long stack_guard_start_gap(const struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & VM_GROWSDOWN)
 		return stack_guard_gap;
@@ -3500,7 +3500,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 	return 0;
 }
 
-static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_start_gap(const struct vm_area_struct *vma)
 {
 	unsigned long gap = stack_guard_start_gap(vma);
 	unsigned long vm_start = vma->vm_start;
@@ -3511,7 +3511,7 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 	return vm_start;
 }
 
-static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_end_gap(const struct vm_area_struct *vma)
 {
 	unsigned long vm_end = vma->vm_end;
 
@@ -3523,7 +3523,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	return vm_end;
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
+static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 {
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
@@ -3540,7 +3540,7 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 	return vma;
 }
 
-static inline bool range_in_vma(struct vm_area_struct *vma,
+static inline bool range_in_vma(const struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
 	return (vma && vma->vm_start <= start && end <= vma->vm_end);
@@ -3656,7 +3656,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
 					   unsigned int flags)
 {
 	/*
@@ -3786,7 +3786,7 @@ static inline bool debug_guardpage_enabled(void)
 	return static_branch_unlikely(&_debug_guardpage_enabled);
 }
 
-static inline bool page_is_guard(struct page *page)
+static inline bool page_is_guard(const struct page *page)
 {
 	if (!debug_guardpage_enabled())
 		return false;
@@ -3817,7 +3817,7 @@ static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
 static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
 static inline unsigned int debug_guardpage_minorder(void) { return 0; }
 static inline bool debug_guardpage_enabled(void) { return false; }
-static inline bool page_is_guard(struct page *page) { return false; }
+static inline bool page_is_guard(const struct page *page) { return false; }
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


