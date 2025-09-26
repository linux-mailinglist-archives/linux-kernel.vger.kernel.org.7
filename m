Return-Path: <linux-kernel+bounces-834655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70ABA5316
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E651F1BC65FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A260130CB52;
	Fri, 26 Sep 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6VeSjWz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DE299A90
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921427; cv=none; b=YTGY+xP+TwKdGPfFXy79bTl3B5EO6pwx8x0yPMSjxKU9szirTNKHABpwWsancJyDRqNxxdMie/5jUFzIOI8abjxVEY0bkQmUaMloBjlLIs4r7u198kuEBbxXsw/HFAD32/FnB/+Xvv8FdyW6LZ6BnbcNkKAFJmiDmHloJg/y6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921427; c=relaxed/simple;
	bh=gjo5O+4xbJwBl0erUhmhkNVZXRLKRiUIJdMMPeCETvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJTnpvjmdD+hClDTgSGWv1X2bDSCOexASA9xwpskK5HtR5PaePNxc/a0OaKKw6ioMIOsumpbXioYhwish5j/DoI8ABsrYsgmoHmaJyQ8FC/0HiAKm8Ve30Mlo4b8xxNUiyuLYSiIgG7mDSo3OeQdjV1CRdd1Ct+W95SCo/EQxs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6VeSjWz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758921424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hVqOG3Eh1Yx9eqpcK28/avvzNcMaSdpE9ANunBKEMM=;
	b=E6VeSjWz4NPOdCUqAt0Im3bBOb5cEEHIYr2pwrx0MoZFpZEyjEZiRVJegSw2bI2i/LxGl5
	C+OT6H6sotTPp6/KAfvPvatVIbO9VMRAXy4ljy/YluDsvo9VFNGhxWEmtqBwqaREerGu04
	EQbTZVDHs9H5MwJ5NkbdXPlD04DdWNg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ImLrR4wrObKxC6XmC6N9cQ-1; Fri, 26 Sep 2025 17:17:03 -0400
X-MC-Unique: ImLrR4wrObKxC6XmC6N9cQ-1
X-Mimecast-MFC-AGG-ID: ImLrR4wrObKxC6XmC6N9cQ_1758921423
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85dd8633b1bso469035585a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758921423; x=1759526223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hVqOG3Eh1Yx9eqpcK28/avvzNcMaSdpE9ANunBKEMM=;
        b=dL4Jv5coBYtk7iabapa5fQVKU24c2Auou4KyZnfWbFDhKqKFLC4tLaZ1cFxDzzOadS
         TSwzehuoLNMVzanHHK1K/TjD5VXGqmDz5yg0Xooz7Oi9xoZyFx41WdPap9qI6eg6SRdE
         QvWIvj0NdlHPmZVkHA9O4HoJMq84Zl59rQZkEM/zsXrYwtlxJIYwOqJqVpvsR+eYCoi0
         gVNAT/OGQGmdtbqw4k42dekUCCJWWu7zgWCboEuezQ33wkMLuIgkz6b+rDOqp+ouUqi/
         ywrdAIQVE31TnyW4TuNX4+r6Iw4HlOC1Gw4LzLkbzz1CyWPTa1+MLRlIl39aB5eNuSv4
         JrjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Del+SiuBTC5ZyVSBtzikdEjjjUBLqIm13H5Re9kRqap/8r2wjUV2ltZ6NoA5OiMMUVw/17mTRs3OAG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVIGvzVzdttuTsK8Qfl89i2ZTWSiwMoTPtCq9MMtx/RlVcxOP
	W6VeICZdtdurJCEBzpsGaIQSbZIzK0qolbE6Hj5Ru/c/22u5dbmmbJ1+I9wB5CDp2oDMgCE8Jha
	nFXchzw6afmoDbgihbFuBYEjpHK0Jr1NNrkIzZto1kApsHypJUBPUc+hdQv+Vdj5IkQ==
X-Gm-Gg: ASbGnctXoHigS9XBNdAdIVAgr6P0jON3ClXPqnXDgXkeY3+S4dcec4wGsw+dp1woXxX
	IO0gxgVDY0xWSc6r69G5DCtLV8uVr3GzLFRzfM1U11H2CAsNUJxKGUz03IfiqlSI5qGNPQSmRaS
	MrNFWh3iAkFIXI2essjCs/syu/neI0KCsFtxRBuQqYLsh+COC54jRM3pbiWVQ92lVp8GM90xwvN
	heKPqT/9sU0zuEkYmXgqmRWgiKFW61vEVIQwbGQPDhGJL+S+pvZCnA70k+gY27rtBdDgFMtazaA
	fwrv4kpbMa9iFKQh2gdZ8TIiPY20/A==
X-Received: by 2002:a05:620a:458b:b0:850:78b7:f878 with SMTP id af79cd13be357-864545bb641mr128786485a.0.1758921422707;
        Fri, 26 Sep 2025 14:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYPzTHVPardWHZo24HN+Lu0mmZZ7m+h0eutm0YjD7rOSGFq9rS1SwsPF9Di4dBBVvxySTv0Q==
X-Received: by 2002:a05:620a:458b:b0:850:78b7:f878 with SMTP id af79cd13be357-864545bb641mr128781185a.0.1758921422125;
        Fri, 26 Sep 2025 14:17:02 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-86042e32249sm210604785a.44.2025.09.26.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:17:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 4/4] mm: Apply vm_uffd_ops API to core mm
Date: Fri, 26 Sep 2025 17:16:50 -0400
Message-ID: <20250926211650.525109-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926211650.525109-1-peterx@redhat.com>
References: <20250926211650.525109-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move userfaultfd core to use new vm_uffd_ops API. After this change file
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
 include/linux/userfaultfd_k.h |  46 +++++----------
 mm/userfaultfd.c              | 102 ++++++++++++++++++++++++++--------
 2 files changed, 91 insertions(+), 57 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index b1949d8611238..e3704e27376ad 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -134,9 +134,14 @@ struct vm_uffd_ops {
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
@@ -245,41 +250,16 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
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
index af61b95c89e4e..0a863ac123d84 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -20,6 +20,43 @@
 #include "internal.h"
 #include "swap.h"
 
+bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
+		       bool wp_async)
+{
+	unsigned long supported;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		return false;
+
+	vm_flags &= __VM_UFFD_FLAGS;
+
+#ifndef CONFIG_PTE_MARKER_UFFD_WP
+	/*
+	 * If user requested uffd-wp but not enabled pte markers for
+	 * uffd-wp, then any file system (like shmem or hugetlbfs) are not
+	 * supported but only anonymous.
+	 */
+	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
+		return false;
+#endif
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
+		supported = vma_get_uffd_ops(vma)->uffd_features;
+	else
+		return false;
+
+	return !(vm_flags & (~supported));
+}
+
 static __always_inline
 bool validate_dst_vma(struct vm_area_struct *dst_vma, unsigned long dst_end)
 {
@@ -382,13 +419,17 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
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
+	if (WARN_ON_ONCE(!uffd_ops || !uffd_ops->uffd_get_folio))
+		return -EINVAL;
+
+	ret = uffd_ops->uffd_get_folio(inode, pgoff, &folio);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
 	if (ret == -ENOENT)
 		ret = -EFAULT;
@@ -504,18 +545,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
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
@@ -694,6 +723,41 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
 	return err;
 }
 
+static inline bool
+vma_uffd_ops_supported(struct vm_area_struct *vma, uffd_flags_t flags)
+{
+	enum mfill_atomic_mode mode = uffd_flags_get_mode(flags);
+	const struct vm_uffd_ops *uffd_ops;
+	unsigned long uffd_ioctls;
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
+	uffd_ioctls = uffd_ops->uffd_ioctls;
+	switch (mode) {
+	case MFILL_ATOMIC_COPY:
+		return uffd_ioctls & BIT(_UFFDIO_COPY);
+	case MFILL_ATOMIC_ZEROPAGE:
+		return uffd_ioctls & BIT(_UFFDIO_ZEROPAGE);
+	case MFILL_ATOMIC_CONTINUE:
+		if (!(vma->vm_flags & VM_SHARED))
+			return false;
+		return uffd_ioctls & BIT(_UFFDIO_CONTINUE);
+	case MFILL_ATOMIC_POISON:
+		return uffd_ioctls & BIT(_UFFDIO_POISON);
+	default:
+		return false;
+	}
+}
+
 static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 					    unsigned long dst_start,
 					    unsigned long src_start,
@@ -752,11 +816,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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
@@ -766,12 +826,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
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


