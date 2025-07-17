Return-Path: <linux-kernel+bounces-735205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39697B08C20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3CD188CD17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB732BE646;
	Thu, 17 Jul 2025 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBcIf2hF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722952BE034
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753158; cv=none; b=IDW9D4PNAVEIMXipvkdVlsafGUbu3o7mjUIAQvKlzK1b0wot2VKm5Hsx/kouiwYA63ao9MMDy8AQ8v1UeLyxRih47mK0LEUDaeCyKWgsx5VQnSPZGWif3DA9xplSQdIpBpZyKay0b36O3cnE0uNpAp6/y+/gOQFa3072VOFONz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753158; c=relaxed/simple;
	bh=gMrA8DSKuXMfo6Oy1S6H8o432DllXJJ9TU8eUm58p9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or7WivamthNRvj9KJoP5LrgbkNP36eJdXvTlhlEqQHeebU15ZxDXXd6MQuh3+ifbAAJLBMthkaK8j+tJXDY4R190X9yI+DNLV8FSY5MylYkkSuJuHjT0TYYUk1646qZ7OL2yXBHgVS1/cEaZZ7phuBf95SKMwkQ8oRdp4qY1XIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBcIf2hF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6ocb38IkVcnlHaJeHNVb3Jrmzmc76tJoqI7g7ZBmQA=;
	b=cBcIf2hF8wNr2JQQX9wigGg1ntKUYGUI42tnn+CtNDZsajLiatwH/36+tVjsJITlA0Vxqo
	Q0pZYl/xWXlIsQnPaxdYnMni82bR2giePNFqhIH9R6eLsjHLXGWRWCxgWKmIkKaZtbQy0N
	EIX39ZsBMF8ng6dGk4mTx19dddADUNc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-UU2R0TyPPmyfHVMVUBX9eA-1; Thu, 17 Jul 2025 07:52:34 -0400
X-MC-Unique: UU2R0TyPPmyfHVMVUBX9eA-1
X-Mimecast-MFC-AGG-ID: UU2R0TyPPmyfHVMVUBX9eA_1752753153
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso552294f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753153; x=1753357953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6ocb38IkVcnlHaJeHNVb3Jrmzmc76tJoqI7g7ZBmQA=;
        b=lXWKnEqUGlXN7IFqVPCiXA//DRXNPEM8J6hQf3olTslmP/gIgo80DqmmH4XilobbrK
         HsLA+zxTZ8tY/zn1ch2ozaJJetN+U3DROllyuXI8Sd/C4iQMaGxpfgZEf+I0d00dBcmJ
         M2LcZKoZWbyU+ql1+Cxn5r0Rwe36IzPNAE+9PFlGZUK2/Jztf6QVi2DEV+2yRWvBIZTy
         z9zjB6/oBg+SlDWX40ZKR45eHJ/HI9hCcGxiW12Ux1mE6DE837XWY1ZGgyY3bFoRAn1D
         Hi/Tnc3KNcDWsnI7Jb+A50UVI++Z1YRtObTn1KNq2UrYi9qN+sU0bwnIjGzayPdXvVpE
         je7A==
X-Gm-Message-State: AOJu0YxpzMNW2ofyoqnmFjGVfan/eBM5N+OfnUPGlETWzeC7if48692c
	pBhukhyuJRTvjZF/K6fwEUCmmstM9yMSlUKV28sxVNwVoalEAx2Ec3xm/gnSvZDG8/Q5s3OjiKm
	Gi/4srUcSS61kCeQd1Ehyxm7a7TLG64e5JLlhXOW0FxkFcs9bOMuwlwqa6fddnWUVTo6vMSWMJV
	gU0j0woHCLrYvgR88YD1mrMh3AClv/b8oGryTL3K8mrWzM0MRl
X-Gm-Gg: ASbGncsMat9t6yzfhMVwNZABX3YixuBNqMWasjNHi/A2mvqT4QhuX4Z6VR/eSDvySyu
	1bPeQi7cs1egfM6UBzIM4FszZ2+heF9MKl5TswZ7wnW6vLWYDadJq+QWeeAFRedi6dZLickVcDr
	q4E3hPAH4IMGjjneZeVQTu+SeTeyruWcYD1LB/UrKjspWwRjRAWNAbNT6VithwPNfItzX/Bq4RW
	MQxRGtAPxl/wEXYMe4mTeQjArYkaufrLGYXok0rO9eOujnF4ap859I+YS2T9KuOgKnMS3t8lNO+
	QESfKJjx+m6R+n4Gq9zxxWrczBi1+GmFaDxT+JhEniFWljG9cnrSGdwiZSF0/8LGENfy6/eX8i1
	/SZgpS7yMq5TgPCQu9caEPP4=
X-Received: by 2002:a05:6000:43c6:10b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3b60e50fde7mr3995264f8f.39.1752753152727;
        Thu, 17 Jul 2025 04:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLcgp48Noardv8I0f6W2NZTd1NV9HbsxHjW8GgnbNobVHwjA5VMkKS9pv04KvpTaqXa6tubA==
X-Received: by 2002:a05:6000:43c6:10b0:3a4:f744:e01b with SMTP id ffacd0b85a97d-3b60e50fde7mr3995202f8f.39.1752753152069;
        Thu, 17 Jul 2025 04:52:32 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45634ec9162sm20451645e9.0.2025.07.17.04.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:31 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 7/9] mm/memory: factor out common code from vm_normal_page_*()
Date: Thu, 17 Jul 2025 13:52:10 +0200
Message-ID: <20250717115212.1825089-8-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717115212.1825089-1-david@redhat.com>
References: <20250717115212.1825089-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's reduce the code duplication and factor out the non-pte/pmd related
magic into vm_normal_page_pfn().

To keep it simpler, check the pfn against both zero folios. We could
optimize this, but as it's only for the !CONFIG_ARCH_HAS_PTE_SPECIAL
case, it's not a compelling micro-optimization.

With CONFIG_ARCH_HAS_PTE_SPECIAL we don't have to check anything else,
really.

It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
scenario in the PMD case in practice: but doesn't really matter, as
it's now all unified in vm_normal_page_pfn().

Add kerneldoc for all involved functions.

No functional change intended.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 183 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 109 insertions(+), 74 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 08d16ed7b4cc7..c43ae5e4d7644 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -590,8 +590,13 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
-/*
- * vm_normal_page -- This function gets the "struct page" associated with a pte.
+/**
+ * vm_normal_page_pfn() - Get the "struct page" associated with a PFN in a
+ *			  non-special page table entry.
+ * @vma: The VMA mapping the @pfn.
+ * @addr: The address where the @pfn is mapped.
+ * @pfn: The PFN.
+ * @entry: The page table entry value for error reporting purposes.
  *
  * "Special" mappings do not wish to be associated with a "struct page" (either
  * it doesn't exist, or it exists but they don't want to touch it). In this
@@ -603,10 +608,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
  * (such as GUP) can still identify these mappings and work with the
  * underlying "struct page".
  *
- * There are 2 broad cases. Firstly, an architecture may define a pte_special()
- * pte bit, in which case this function is trivial. Secondly, an architecture
- * may not have a spare pte bit, which requires a more complicated scheme,
- * described below.
+ * There are 2 broad cases. Firstly, an architecture may define a "special"
+ * page table entry bit (e.g., pte_special()), in which case this function is
+ * trivial. Secondly, an architecture may not have a spare page table
+ * entry bit, which requires a more complicated scheme, described below.
  *
  * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
  * special mapping (even if there are underlying and valid "struct pages").
@@ -639,15 +644,72 @@ static void print_bad_page_map(struct vm_area_struct *vma,
  * don't have to follow the strict linearity rule of PFNMAP mappings in
  * order to support COWable mappings.
  *
+ * This function is not expected to be called for obviously special mappings:
+ * when the page table entry has the "special" bit set.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
+static inline struct page *vm_normal_page_pfn(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn, unsigned long long entry)
+{
+	/*
+	 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table mappings
+	 * (incl. shared zero folios) are marked accordingly and are handled
+	 * by the caller.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
+		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
+			if (vma->vm_flags & VM_MIXEDMAP) {
+				/* If it has a "struct page", it's "normal". */
+				if (!pfn_valid(pfn))
+					return NULL;
+			} else {
+				unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
+
+				/* Only CoW'ed anon folios are "normal". */
+				if (pfn == vma->vm_pgoff + off)
+					return NULL;
+				if (!is_cow_mapping(vma->vm_flags))
+					return NULL;
+			}
+		}
+
+		if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
+			return NULL;
+	}
+
+	/* Cheap check for corrupted page table entries. */
+	if (pfn > highest_memmap_pfn) {
+		print_bad_page_map(vma, addr, entry, NULL);
+		return NULL;
+	}
+	/*
+	 * NOTE! We still have PageReserved() pages in the page tables.
+	 * For example, VDSO mappings can cause them to exist.
+	 */
+	VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn));
+	return pfn_to_page(pfn);
+}
+
+/**
+ * vm_normal_page() - Get the "struct page" associated with a PTE
+ * @vma: The VMA mapping the @pte.
+ * @addr: The address where the @pte is mapped.
+ * @pte: The PTE.
+ *
+ * Get the "struct page" associated with a PTE. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
  */
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
 {
 	unsigned long pfn = pte_pfn(pte);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
-		if (likely(!pte_special(pte)))
-			goto check_pfn;
+	if (unlikely(pte_special(pte))) {
 		if (vma->vm_ops && vma->vm_ops->find_special_page)
 			return vma->vm_ops->find_special_page(vma, addr);
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
@@ -658,44 +720,21 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		print_bad_page_map(vma, addr, pte_val(pte), NULL);
 		return NULL;
 	}
-
-	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
-
-	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
-		if (vma->vm_flags & VM_MIXEDMAP) {
-			if (!pfn_valid(pfn))
-				return NULL;
-			if (is_zero_pfn(pfn))
-				return NULL;
-			goto out;
-		} else {
-			unsigned long off;
-			off = (addr - vma->vm_start) >> PAGE_SHIFT;
-			if (pfn == vma->vm_pgoff + off)
-				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
-				return NULL;
-		}
-	}
-
-	if (is_zero_pfn(pfn))
-		return NULL;
-
-check_pfn:
-	if (unlikely(pfn > highest_memmap_pfn)) {
-		print_bad_page_map(vma, addr, pte_val(pte), NULL);
-		return NULL;
-	}
-
-	/*
-	 * NOTE! We still have PageReserved() pages in the page tables.
-	 * eg. VDSO mappings can cause them to exist.
-	 */
-out:
-	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
-	return pfn_to_page(pfn);
+	return vm_normal_page_pfn(vma, addr, pfn, pte_val(pte));
 }
 
+/**
+ * vm_normal_folio() - Get the "struct folio" associated with a PTE
+ * @vma: The VMA mapping the @pte.
+ * @addr: The address where the @pte is mapped.
+ * @pte: The PTE.
+ *
+ * Get the "struct folio" associated with a PTE. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
 struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
 {
@@ -707,6 +746,18 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 }
 
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+/**
+ * vm_normal_page_pmd() - Get the "struct page" associated with a PMD
+ * @vma: The VMA mapping the @pmd.
+ * @addr: The address where the @pmd is mapped.
+ * @pmd: The PMD.
+ *
+ * Get the "struct page" associated with a PMD. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd)
 {
@@ -721,37 +772,21 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
 		return NULL;
 	}
-
-	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
-		if (vma->vm_flags & VM_MIXEDMAP) {
-			if (!pfn_valid(pfn))
-				return NULL;
-			goto out;
-		} else {
-			unsigned long off;
-			off = (addr - vma->vm_start) >> PAGE_SHIFT;
-			if (pfn == vma->vm_pgoff + off)
-				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
-				return NULL;
-		}
-	}
-
-	if (is_huge_zero_pfn(pfn))
-		return NULL;
-	if (unlikely(pfn > highest_memmap_pfn)) {
-		print_bad_page_map(vma, addr, pmd_val(pmd), NULL);
-		return NULL;
-	}
-
-	/*
-	 * NOTE! We still have PageReserved() pages in the page tables.
-	 * eg. VDSO mappings can cause them to exist.
-	 */
-out:
-	return pfn_to_page(pfn);
+	return vm_normal_page_pfn(vma, addr, pfn, pmd_val(pmd));
 }
 
+/**
+ * vm_normal_folio_pmd() - Get the "struct folio" associated with a PMD
+ * @vma: The VMA mapping the @pmd.
+ * @addr: The address where the @pmd is mapped.
+ * @pmd: The PMD.
+ *
+ * Get the "struct folio" associated with a PMD. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
 struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd)
 {
-- 
2.50.1


