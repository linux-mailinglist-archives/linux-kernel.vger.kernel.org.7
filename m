Return-Path: <linux-kernel+bounces-853479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0401ABDBC28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5C8C4EDA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16A22E7F0E;
	Tue, 14 Oct 2025 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aiz5vIVF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581632F60C9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483722; cv=none; b=q6SfN3m5+c+tmtDOe/+Epxy+u3ZdA3Y1PweC1lKs+WanAIYlto/lBRvOxSBCcWN4qCB+JyvCd/DbB4pTB349cWvREHOBYfV9hKZVWmd8VD3J2kD0Jl/5WTp/p6PErJI4iJQ6C0NytU1+zCMDXNrxtaRgR32JeG23FHJ7g68FSL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483722; c=relaxed/simple;
	bh=3WN/QPQD02e7LRrxckwYY8z/P5Tmo1bEIF6lZCUwpCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzLz6EbqQuDj94aiHKroNy0z+xVjeipzgmfFafIFwHm67L2UPIckwYtSGH6Drw2Ol4U/DnDZIkFbZQnmosI4QtH0S2DnSoJ8je6IBdQ33Jwt3/9KnAC6GSxFEEKs+oU4m4lOmI5zND3/j9XwRSFZGF0l9tgNFXSfOYR4oPQ8exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aiz5vIVF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760483719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HedfkyMs3B9oqDedHNEV7q9JZcOI7I215Yi2CdixyTc=;
	b=Aiz5vIVFVFkbZ9BgHlCgFXwUTYGBDk4RvJJyfNl1Xi68gptDXHGo3m1NeLaVUCEG43BCRB
	thiqEPEkpvQhI2411wsXtFYacKZQqBR1AfuIrH7BL5xRHWQztbXK9O5DTk440fIxmqi20I
	wwP16F6ASIINDyKuen3WAY5CW+0ISxo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-gJzu964-MdGaBemklxXWbw-1; Tue, 14 Oct 2025 19:15:17 -0400
X-MC-Unique: gJzu964-MdGaBemklxXWbw-1
X-Mimecast-MFC-AGG-ID: gJzu964-MdGaBemklxXWbw_1760483717
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88e35354330so41252985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483717; x=1761088517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HedfkyMs3B9oqDedHNEV7q9JZcOI7I215Yi2CdixyTc=;
        b=nM54EWGaDIjbtbItTMRP2gK0kqLVI5gYNU7J3K/MDeQ3DZVESeR+Ro37LP8wA4wSwd
         6dnzOuTCTjUA4nS+IVvM4r/kTCTTkmRwHIlgiBVTOQketOOr6OuiW91Uw385rrEdT17u
         oj15ANiiwiDqIzNjjqL++b6Rug/VLCNS4QyLkHl5azVOzfe5r817IBDH5+iMCgiuFRju
         jwDbwrA7XJ1JshYjbf2ZKQNSxEePxK46QJD5rLhaf+b2Tn5oUu3hjOdKZK+CMtpYRaTZ
         IeOcjBK9Iit1/ly0EPyVXzKL4/PcxJP9VNT87x7+Qd9t9OkDcTEwGLGH8X0ef1hrOa4N
         Tluw==
X-Gm-Message-State: AOJu0YwEl9HGHqMitx2+haV1wKqGHDGsbXnBytJ/l9/Xl7rOfCtzBkIx
	arlHpk/AsczCQIyqOjmgenSqDSKHa1JJFjPiClDPIQkUHXVgPc3Fl4x1Z7MI9aNfvlJsotY2vNk
	T7PJcXHvrxzkMzm11HDsSwNWgrOGuSjk+SSuIeZRfUJ1B4zN31dY9q5lDx0wSnaL0+WLArQwskJ
	LVwLqahu3Z/bDt7T4OAq6l8tFl0lPmdZ8CdNoX5lBEfE+Lvsg=
X-Gm-Gg: ASbGncuNNmBg2S6gss7dvQ9H4rbJeYRJe9M+mUn4XSycEa0MRq8aRchdvQ/4a4ltGco
	CQPT7Du+QQttbIhr6ePRhFLJeTGlDObvq+ABXe+01ziVqU1vrpocWW0U2rc6rH0WxkraxFaSbNJ
	V5BI1OQf1tSinuI7qabj3XoudnrTiX82O7nI7ziKDuiGBN9N3WI5tjiZG+oAH2EyDFgn6EIyptz
	afTbAYOOXdESL1csF1abiGUVel2SwbmM4QuGtYSYbVyhRAa1Zx7TW2h4n8X1jN1M4JjHqjsBwop
	XOEai8LC44em/dJzLf0ut3usbtJ3gg==
X-Received: by 2002:a05:620a:7012:b0:816:b56d:20ef with SMTP id af79cd13be357-8835326fa38mr3291257885a.86.1760483716852;
        Tue, 14 Oct 2025 16:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8trGwxOWwN9vklPIUb4DUFPDDuGTh9yrsza4jeSL14iOpRJmq9d1JUbiuCxpuX4zt03gfgQ==
X-Received: by 2002:a05:620a:7012:b0:816:b56d:20ef with SMTP id af79cd13be357-8835326fa38mr3291250085a.86.1760483716141;
        Tue, 14 Oct 2025 16:15:16 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm1280258685a.53.2025.10.14.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:15:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v4 4/4] mm: Apply vm_uffd_ops API to core mm
Date: Tue, 14 Oct 2025 19:15:01 -0400
Message-ID: <20251014231501.2301398-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014231501.2301398-1-peterx@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move userfaultfd core to use new vm_uffd_ops API. After this change, file
systems that implement vm_operations_struct can start using new API for
userfaultfd operations.

When at it, moving vma_can_userfault() into mm/userfaultfd.c instead,
because it's getting too big.  It's only used in slow paths so it shouldn't
be an issue.  Move the pte marker check before wp_async, which might be
more intuitive because wp_async depends on pte markers.  That shouldn't
cause any functional change though because only one check would take effect
depending on whether pte marker was selected in config.

This will also remove quite some hard-coded checks for either shmem or
hugetlbfs.  Now all the old checks should still work but with vm_uffd_ops.

Note that anonymous memory will still need to be processed separately
because it doesn't have vm_ops at all.

Reviewed-by: James Houghton <jthoughton@google.com>
Acked-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h |  46 ++++---------
 mm/userfaultfd.c              | 120 +++++++++++++++++++++++++++-------
 2 files changed, 109 insertions(+), 57 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index b5b4f3f174b32..983efaecfdcb0 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -126,9 +126,14 @@ struct vm_uffd_ops {
 #define MFILL_ATOMIC_FLAG(nr) ((__force uffd_flags_t) MFILL_ATOMIC_BIT(nr))
 #define MFILL_ATOMIC_MODE_MASK ((__force uffd_flags_t) (MFILL_ATOMIC_BIT(0) - 1))
 
+static inline enum mfill_atomic_mode uffd_flags_get_mode(uffd_flags_t flags)
+{
+	return (__force enum mfill_atomic_mode)(flags & MFILL_ATOMIC_MODE_MASK);
+}
+
 static inline bool uffd_flags_mode_is(uffd_flags_t flags, enum mfill_atomic_mode expected)
 {
-	return (flags & MFILL_ATOMIC_MODE_MASK) == ((__force uffd_flags_t) expected);
+	return uffd_flags_get_mode(flags) == expected;
 }
 
 static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enum mfill_atomic_mode mode)
@@ -237,41 +242,16 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
-static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     vm_flags_t vm_flags,
-				     bool wp_async)
+static inline const struct vm_uffd_ops *vma_get_uffd_ops(struct vm_area_struct *vma)
 {
-	vm_flags &= __VM_UFFD_FLAGS;
-
-	if (vma->vm_flags & VM_DROPPABLE)
-		return false;
-
-	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
-		return false;
-
-	/*
-	 * If wp async enabled, and WP is the only mode enabled, allow any
-	 * memory type.
-	 */
-	if (wp_async && (vm_flags == VM_UFFD_WP))
-		return true;
-
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
-	/*
-	 * If user requested uffd-wp but not enabled pte markers for
-	 * uffd-wp, then shmem & hugetlbfs are not supported but only
-	 * anonymous.
-	 */
-	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
-		return false;
-#endif
-
-	/* By default, allow any of anon|shmem|hugetlb */
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	    vma_is_shmem(vma);
+	if (vma->vm_ops && vma->vm_ops->userfaultfd_ops)
+		return vma->vm_ops->userfaultfd_ops;
+	return NULL;
 }
 
+bool vma_can_userfault(struct vm_area_struct *vma,
+		       unsigned long vm_flags, bool wp_async);
+
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
 {
 	struct userfaultfd_ctx *uffd_ctx = vma->vm_userfaultfd_ctx.ctx;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 00122f42718cc..b50db51e75d5b 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -20,6 +20,61 @@
 #include "internal.h"
 #include "swap.h"
 
+static unsigned long uffd_get_supported_modes(struct vm_area_struct *vma)
+{
+	const struct vm_uffd_ops *uffd_ops = vma_get_uffd_ops(vma);
+	unsigned long ioctls, supported = 0;
+
+	if (!uffd_ops)
+		return 0;
+
+	ioctls = uffd_ops->supported_ioctls;
+
+	if (ioctls & (BIT(_UFFDIO_COPY) | BIT(_UFFDIO_ZEROPAGE)))
+		supported |= VM_UFFD_MISSING;
+	if (ioctls & BIT(_UFFDIO_CONTINUE))
+		supported |= VM_UFFD_MINOR;
+	if (ioctls & BIT(_UFFDIO_WRITEPROTECT))
+		supported |= VM_UFFD_WP;
+
+	return supported;
+}
+
+bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
+		       bool wp_async)
+{
+	unsigned long supported = 0;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		return false;
+
+	vm_flags &= __VM_UFFD_FLAGS;
+
+	/*
+	 * If user requested uffd-wp but not enabled pte markers for
+	 * uffd-wp, then any file system (like shmem or hugetlbfs) are not
+	 * supported but only anonymous.
+	 */
+	if (!IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) &&
+	    ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma)))
+		return false;
+
+	/*
+	 * If wp async enabled, and WP is the only mode enabled, allow any
+	 * memory type.
+	 */
+	if (wp_async && (vm_flags == VM_UFFD_WP))
+		return true;
+
+	if (vma_is_anonymous(vma))
+		/* Anonymous has no page cache, MINOR not supported */
+		supported = VM_UFFD_MISSING | VM_UFFD_WP;
+	else if (vma_get_uffd_ops(vma))
+		supported = uffd_get_supported_modes(vma);
+
+	return !(vm_flags & ~supported);
+}
+
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
 {
@@ -382,13 +437,17 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
 				     unsigned long dst_addr,
 				     uffd_flags_t flags)
 {
+	const struct vm_uffd_ops *uffd_ops = vma_get_uffd_ops(dst_vma);
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
 	struct folio *folio;
 	struct page *page;
 	int ret;
 
-	ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
+	if (WARN_ON_ONCE(!uffd_ops || !uffd_ops->minor_get_folio))
+		return -EINVAL;
+
+	ret = uffd_ops->minor_get_folio(inode, pgoff, &folio);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret == -ENOENT)
 		ret = -EFAULT;
@@ -504,18 +563,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	u32 hash;
 	struct address_space *mapping;
 
-	/*
-	 * There is no default zero huge page for all huge page sizes as
-	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
-	 * by THP.  Since we can not reliably insert a zero page, this
-	 * feature is not supported.
-	 */
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
-		up_read(&ctx->map_changing_lock);
-		uffd_mfill_unlock(dst_vma);
-		return -EINVAL;
-	}
-
 	src_addr = src_start;
 	dst_addr = dst_start;
 	copied = 0;
@@ -694,6 +741,41 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	return err;
 }
 
+static inline bool
+vma_uffd_ops_supported(struct vm_area_struct *vma, uffd_flags_t flags)
+{
+	enum mfill_atomic_mode mode = uffd_flags_get_mode(flags);
+	const struct vm_uffd_ops *uffd_ops;
+	unsigned long supported_ioctls;
+
+	if ((flags & MFILL_ATOMIC_WP) && !(vma->vm_flags & VM_UFFD_WP))
+		return false;
+
+	/* Anonymous supports everything except CONTINUE */
+	if (vma_is_anonymous(vma))
+		return mode != MFILL_ATOMIC_CONTINUE;
+
+	uffd_ops = vma_get_uffd_ops(vma);
+	if (!uffd_ops)
+		return false;
+
+	supported_ioctls = uffd_ops->supported_ioctls;
+	switch (mode) {
+	case MFILL_ATOMIC_COPY:
+		return supported_ioctls & BIT(_UFFDIO_COPY);
+	case MFILL_ATOMIC_ZEROPAGE:
+		return supported_ioctls & BIT(_UFFDIO_ZEROPAGE);
+	case MFILL_ATOMIC_CONTINUE:
+		if (!(vma->vm_flags & VM_SHARED))
+			return false;
+		return supported_ioctls & BIT(_UFFDIO_CONTINUE);
+	case MFILL_ATOMIC_POISON:
+		return supported_ioctls & BIT(_UFFDIO_POISON);
+	default:
+		return false;
+	}
+}
+
 static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long dst_start,
 					    unsigned long src_start,
@@ -752,11 +834,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    dst_vma->vm_flags & VM_SHARED))
 		goto out_unlock;
 
-	/*
-	 * validate 'mode' now that we know the dst_vma: don't allow
-	 * a wrprotect copy if the userfaultfd didn't register as WP.
-	 */
-	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+	if (!vma_uffd_ops_supported(dst_vma, flags))
 		goto out_unlock;
 
 	/*
@@ -766,12 +844,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
-		goto out_unlock;
-
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
 
-- 
2.50.1


