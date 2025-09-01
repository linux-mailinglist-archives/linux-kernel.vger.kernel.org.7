Return-Path: <linux-kernel+bounces-793885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F33FB3D9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92EB3BB6C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64A2690E7;
	Mon,  1 Sep 2025 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V8XBFtse"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F3261B9D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707167; cv=none; b=mtnsxPIPTfIvAqRDjioCzq+nIexE/lApYe+MKVSJIgPgQ9DVavKSDBInz/C9u8OUi4Obtq10m1ah/zqv8pPp9ng4ERQdQhrsbgwnIGVaBLCMrBuwr17INV3cdLu39g7riE696TENxXZfmy3yAbZyUnA9Lyo4koww6JnIdYT0+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707167; c=relaxed/simple;
	bh=Dfmun9pi6cuyGoUj6GOJeOljxmTWfSLaNUipQGTxNJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjWRPATnZmZUgguOk1wvKGtpbXuf351atvJ7D2DxDucyOnpes2hQK7rFBtdM4dH+aQH4WmyG/Zkaft/KNtybnNhfz0i8XnioVtxxbdafZ95u1u5dDW/1WMISgnzKGIziu8NY224KekK+8XDA2reZ6i/JfNyHwtlQOzIdtBpB1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V8XBFtse; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so5311539a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707163; x=1757311963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlbLlerU4Nv7VRATJ1BdVJRZNI5zbhELrg/7ukvkQX4=;
        b=V8XBFtsehz9gywhn0RkpoaYwh9v4Rtti1u4SbCq11EIXwbOFIXZx+NxYhBTXL1f881
         WoKhWdP3r/Pzz92ZDFX1+IF5QyShHjWxx4I/PAkUdELC/5bXLt2oHjiSqxD8PlUuxayr
         BEC+vVJVJ+JBdJZdy6r9fETYSH+vqPhTTjG8st/ryD/p3pIytGFomnDbEFyBWa0BMTr6
         O1YhqMvp7ojxWE7YzcT8fK4UbWfGLQ6oWDDdJi7be63RQ7KALhkRul0PdA6Ssz/yXIuR
         d3LV6vGSX6cJSVfYxup990+KTTlhrNAK/NSWnENDvULueb5fsMLTkZDPLDrgAgPNarvJ
         7uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707163; x=1757311963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlbLlerU4Nv7VRATJ1BdVJRZNI5zbhELrg/7ukvkQX4=;
        b=JtKy4TA4pv0qClm4DchUiiMNOZiljMsIqyP0z7AeeVuR76QMlqEJzNHrq6WLmS5a2r
         g98pSbomnQJO5x/kPBDz3tI97MSJGayB3X35XOG6WiWkNC2Or7A2ZHMgt9eu3gz0bPxL
         85mUoUku7vaVx1Hp2RQV4+F342nb4VdigT7BK3H2m+ciyvwQWOi0cpONAwfdeKlnQ7Tz
         6sYszi9oJhBb/rA61A7EDdtot/mPNt7W9fpfegKsXZB9c9/NVePybk1m0+/+mMAdYv6U
         6Fo2AKDimsy2rS28KEtq3cUoQN/u2mgGIBdpXpkGuPCnhWt6S8+/OzY+X9geRY2XVc1Z
         ibAA==
X-Forwarded-Encrypted: i=1; AJvYcCXu4UoJnP4snTLXLgGgXUSw2dVM/LPfVYusLn0umhrNs7RtbJCKJ8iHadjSz4X9dhR8U0cnzENE7Re/Ytg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJ4UWIR67qjjempc+sQb6MOjp20+YENFV4cTySZKza4mWu7S2
	7tLERhyEC844rUyslGSzHLOCgzquqOBLmmyEaU6KQ30LZeKrLxXl/twPFx1xXbYbW/niHggNgTP
	65dDV
X-Gm-Gg: ASbGncuMhg4wkPJ41mSLdrc8Dqbztd72T2GMODBbJR75U+l6YVHromc3Rm8/Ry2vvVG
	eJhBA0b+PuiMVGQowfdsNmbuzJOLEMSSDw716lyeQPD1CSYFaRVAno2rI4PhzxU7/czkAYuhMsU
	5sUNd6C+Vls7lfrSGtaOLLA6LrX4bbuvy1lz8N5ZDixRPxdks8Vozvavc7ilbr2FvrSk2p8dEFc
	RamgEp9o3WCdAD+JbepT3SI900m5zM28kGnKZhtNJOSZWdHsoP8cy2f4fawhhRM9MQq5ClLAaVY
	TYrXvkOdihX/SkamyO45MgyN3k8x7zxRvaQ0aGZAASOqnkk63SUoNDXWNru+oo4VsH8Qeom/5fm
	97BPoxrf7jwaqUBDNaat94wnZ04P1XOqgbG/oDMX+7+Ly1THmDdkBibOYPAlV8alshOsRD8uUib
	w6LfL+jcLLNGq5aPYUS3bSsA==
X-Google-Smtp-Source: AGHT+IFuOzWwmxNav3f4LNFAuYGBeVPVJ0k4jaWHV2jGuHJcSK02hDH7szBWJDGdSFOD7Y7CmAbx+g==
X-Received: by 2002:a05:6402:26c6:b0:61c:8c66:d134 with SMTP id 4fb4d7f45d1cf-61d26d78f38mr5814175a12.18.1756707163204;
        Sun, 31 Aug 2025 23:12:43 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:42 -0700 (PDT)
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
Subject: [PATCH v3 11/12] mm: add `const` to lots of pointer parameters
Date: Mon,  1 Sep 2025 08:12:22 +0200
Message-ID: <20250901061223.2939097-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
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
index 23864c3519d6..08ea6e7c0329 100644
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


