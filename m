Return-Path: <linux-kernel+bounces-762515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFEDB207DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B6BC4E2FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD22D63E2;
	Mon, 11 Aug 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5N9idMK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478BB2D63E3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911628; cv=none; b=ez5wodYLYbi4jlVO9FOc0nnImov3flhxeIGct4/8vzrrFtyZOuSeXrLCVepj+YmsYdA74+LVV8cJyhiN15/65YjFVQhszwOl1O6Ht4+HqfvKIwksWTORQtCfXX/fcIl7SyyfrxioWbuduPNkBLgTaBBTiUx2UWYoPg7LsOwnJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911628; c=relaxed/simple;
	bh=ptzrAkFiP9RDxAnEnKmm24jZIPTxvho/2UMQ4E5LsPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2Q57Wwcs9JXR4ONJGXxy8+SgXreQGcs7WRvPJfcy6nBheLxoq+HpN7PCYUOvkfVZgcAbik4r8tNMjdsmo4i939HW590IellyUIQfdhSQsSCZ0iGQG81pmg1J65DkUPuTxspL09UGqRCYp+kNizOgdturwIN9actnNV42Wa+nLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5N9idMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dH19/uKoiHEMTv0r8rJb8O7lP73Me8TJFFXM58SZ7zM=;
	b=X5N9idMKk8CTPdMHp7Ko8gkCU/6Jr6zK0L2RxAoncmQpmsvSl+VPqD5ZEXrYMHmPdD8I36
	fTjtrsqTJlu1s+iARlVSICPs5HKpFMQ5WIIonZynpIHe1a3v92RCBOFpQ9RrZV1JneOdeZ
	cOQ3POUC4deEN0qZPc2nndRaX3CUBRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-mQJwAIuGMNSrd9ztnvigZA-1; Mon, 11 Aug 2025 07:27:04 -0400
X-MC-Unique: mQJwAIuGMNSrd9ztnvigZA-1
X-Mimecast-MFC-AGG-ID: mQJwAIuGMNSrd9ztnvigZA_1754911623
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459db47f138so16575525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911623; x=1755516423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH19/uKoiHEMTv0r8rJb8O7lP73Me8TJFFXM58SZ7zM=;
        b=jcQYYxx9ln8WdLG9R/yoSNRH4eDlqvEc5DBlV53Z5J1SSc9Nr46VlBCXuUI8Ctlkhb
         3mNlzxSlqPLwAxdxhhFP2rEKiLB8ZXtQQpI+hz7bHiyFVdagR9c6snzBdU23wXbhpkM+
         o+aFkPSc+XqkUh49GEYUVB7JH6/Izoqk5RJwqjyMbcXjY2cn3zyul3iRUhHa/aS+Mo/K
         rHIfiPA+AUBMtNUKjt7b0BV3odBwzD9Wnw0+HmzVQypywMx+8/ItE2nf7w+n6901c0Cj
         SBMYOW30EsS9+9ut3p1w3L+xIwgltixFhZtyt/dSBrKjvFkzFYmKC0PyOGu9kCz0v+Fm
         Kc/g==
X-Gm-Message-State: AOJu0YwQOSJHxBnpwumCcbkU9wXJKHGAERWHedQ/r/zddtW+ZrrvdDij
	qcwy2PfvqWpehQeDvo0rWxIAgS1ZwKnHBna+7P+i2Zcy/JmBfmrU+PkuPrQw+zkg3saWgm0SM5F
	8PliYr9xEnQaQsAtIfU/C6lB3Bsk1GVIUHEQsi+/XxrLbFUsLjNcJVRisbG83JmxD6jagN20u6v
	BSEWt7K0/X1Npc/1hQRK5sUa96j+PzLMFaPWIuj9JWOGBPvQ==
X-Gm-Gg: ASbGncul+si59Tggy9znmPGY0PaHDaeJODgBKMeII9EeHSTG/ulvLOhuJcq5TSLx54E
	8xUGuUFopUz6/zhczShiCsyw5sxKzALIScNenCiS8lXD4v1QLK55xJA3XUBBIgjrMQ+y029odSk
	8d8XZJS+2NGUVNNNjmHWlA8z2PG5ceQFVg4D/kYhINNDpbsD2jMBRLt9ObxCqeyobp0JYHWtZZ2
	8ri/nnrodOqgTdtst1NfL3V7jc/2lCWY4+xFB53R47IYeNur0lk93X3RFo+ncJmtKPmZEHAL6xz
	BgX9fVQDTy+vgSaxKkCq5n5ho16eCb6VsyCo7GG4CrOqRtwfte9UkfWW4/yuQibrWFWlCH5f8m3
	C2sIiNaBUFgw0AfDQHVX0bRLi
X-Received: by 2002:a5d:5d0a:0:b0:3a5:2653:7308 with SMTP id ffacd0b85a97d-3b900b5742bmr9602319f8f.57.1754911622885;
        Mon, 11 Aug 2025 04:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGXEgHnsOD9ZoHC3rozcCl2T1/SKhNFUvb83wEfWy/U4w8SmZE0De8ROcIUkzkJT6XleOZhA==
X-Received: by 2002:a5d:5d0a:0:b0:3a5:2653:7308 with SMTP id ffacd0b85a97d-3b900b5742bmr9602254f8f.57.1754911622182;
        Mon, 11 Aug 2025 04:27:02 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5862be7sm264659195e9.15.2025.08.11.04.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:27:01 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	David Vrabel <david.vrabel@citrix.com>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 11/11] mm: rename vm_ops->find_special_page() to vm_ops->find_normal_page()
Date: Mon, 11 Aug 2025 13:26:31 +0200
Message-ID: <20250811112631.759341-12-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811112631.759341-1-david@redhat.com>
References: <20250811112631.759341-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... and hide it behind a kconfig option. There is really no need for
any !xen code to perform this check.

The naming is a bit off: we want to find the "normal" page when a PTE
was marked "special". So it's really not "finding a special" page.

Improve the documentation, and add a comment in the code where XEN ends
up performing the pte_mkspecial() through a hypercall. More details can
be found in commit 923b2919e2c3 ("xen/gntdev: mark userspace PTEs as
special on x86 PV guests").

Cc: David Vrabel <david.vrabel@citrix.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/xen/Kconfig              |  1 +
 drivers/xen/gntdev.c             |  5 +++--
 include/linux/mm.h               | 18 +++++++++++++-----
 mm/Kconfig                       |  2 ++
 mm/memory.c                      | 12 ++++++++++--
 tools/testing/vma/vma_internal.h | 18 +++++++++++++-----
 6 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 24f485827e039..f9a35ed266ecf 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -138,6 +138,7 @@ config XEN_GNTDEV
 	depends on XEN
 	default m
 	select MMU_NOTIFIER
+	select FIND_NORMAL_PAGE
 	help
 	  Allows userspace processes to use grants.
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 1f21607656182..26f13b37c78e6 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -321,6 +321,7 @@ static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
 	BUG_ON(pgnr >= map->count);
 	pte_maddr = arbitrary_virt_to_machine(pte).maddr;
 
+	/* Note: this will perform a pte_mkspecial() through the hypercall. */
 	gnttab_set_map_op(&map->map_ops[pgnr], pte_maddr, flags,
 			  map->grants[pgnr].ref,
 			  map->grants[pgnr].domid);
@@ -528,7 +529,7 @@ static void gntdev_vma_close(struct vm_area_struct *vma)
 	gntdev_put_map(priv, map);
 }
 
-static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
+static struct page *gntdev_vma_find_normal_page(struct vm_area_struct *vma,
 						 unsigned long addr)
 {
 	struct gntdev_grant_map *map = vma->vm_private_data;
@@ -539,7 +540,7 @@ static struct page *gntdev_vma_find_special_page(struct vm_area_struct *vma,
 static const struct vm_operations_struct gntdev_vmops = {
 	.open = gntdev_vma_open,
 	.close = gntdev_vma_close,
-	.find_special_page = gntdev_vma_find_special_page,
+	.find_normal_page = gntdev_vma_find_normal_page,
 };
 
 /* ------------------------------------------------------------------ */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ca7d2fa71343..3868ca1a25f9c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -657,13 +657,21 @@ struct vm_operations_struct {
 	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
 					unsigned long addr, pgoff_t *ilx);
 #endif
+#ifdef CONFIG_FIND_NORMAL_PAGE
 	/*
-	 * Called by vm_normal_page() for special PTEs to find the
-	 * page for @addr.  This is useful if the default behavior
-	 * (using pte_page()) would not find the correct page.
+	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
+	 * allows for returning a "normal" page from vm_normal_page() even
+	 * though the PTE indicates that the "struct page" either does not exist
+	 * or should not be touched: "special".
+	 *
+	 * Do not add new users: this really only works when a "normal" page
+	 * was mapped, but then the PTE got changed to something weird (+
+	 * marked special) that would not make pte_pfn() identify the originally
+	 * inserted page.
 	 */
-	struct page *(*find_special_page)(struct vm_area_struct *vma,
-					  unsigned long addr);
+	struct page *(*find_normal_page)(struct vm_area_struct *vma,
+					 unsigned long addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf2..59a04d0b2e272 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1381,6 +1381,8 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config FIND_NORMAL_PAGE
+	def_bool n
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/memory.c b/mm/memory.c
index 6f806bf3cc994..002c28795d8b7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -639,6 +639,12 @@ static void print_bad_page_map(struct vm_area_struct *vma,
  * trivial. Secondly, an architecture may not have a spare page table
  * entry bit, which requires a more complicated scheme, described below.
  *
+ * With CONFIG_FIND_NORMAL_PAGE, we might have the "special" bit set on
+ * page table entries that actually map "normal" pages: however, that page
+ * cannot be looked up through the PFN stored in the page table entry, but
+ * instead will be looked up through vm_ops->find_normal_page(). So far, this
+ * only applies to PTEs.
+ *
  * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
  * special mapping (even if there are underlying and valid "struct pages").
  * COWed pages of a VM_PFNMAP are always normal.
@@ -679,8 +685,10 @@ static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
 {
 	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
 		if (unlikely(special)) {
-			if (vma->vm_ops && vma->vm_ops->find_special_page)
-				return vma->vm_ops->find_special_page(vma, addr);
+#ifdef CONFIG_FIND_NORMAL_PAGE
+			if (vma->vm_ops && vma->vm_ops->find_normal_page)
+				return vma->vm_ops->find_normal_page(vma, addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
 			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 				return NULL;
 			if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3639aa8dd2b06..cb1c2a8afe265 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -467,13 +467,21 @@ struct vm_operations_struct {
 	struct mempolicy *(*get_policy)(struct vm_area_struct *vma,
 					unsigned long addr, pgoff_t *ilx);
 #endif
+#ifdef CONFIG_FIND_NORMAL_PAGE
 	/*
-	 * Called by vm_normal_page() for special PTEs to find the
-	 * page for @addr.  This is useful if the default behavior
-	 * (using pte_page()) would not find the correct page.
+	 * Called by vm_normal_page() for special PTEs in @vma at @addr. This
+	 * allows for returning a "normal" page from vm_normal_page() even
+	 * though the PTE indicates that the "struct page" either does not exist
+	 * or should not be touched: "special".
+	 *
+	 * Do not add new users: this really only works when a "normal" page
+	 * was mapped, but then the PTE got changed to something weird (+
+	 * marked special) that would not make pte_pfn() identify the originally
+	 * inserted page.
 	 */
-	struct page *(*find_special_page)(struct vm_area_struct *vma,
-					  unsigned long addr);
+	struct page *(*find_normal_page)(struct vm_area_struct *vma,
+					 unsigned long addr);
+#endif /* CONFIG_FIND_NORMAL_PAGE */
 };
 
 struct vm_unmapped_area_info {
-- 
2.50.1


