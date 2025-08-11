Return-Path: <linux-kernel+bounces-762512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39AB207D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640092A37E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2F2D323F;
	Mon, 11 Aug 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nm5zW5WX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA192D3237
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911623; cv=none; b=StABEKlMAYESIkonxS0Fld1nGfyZZxxGWc1IKyciCV9g6wNCFKF4aScDLcKiGmr4ie1vJgUsE7n4kAqiwMM3o6bqAvEEY3661B7RRsowR4IP9Jh/Aw0CsQequwhRLSf3nHeQVcjJgbgYjA/CN7H7qrAt22YWtCH+CQlTkl8IauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911623; c=relaxed/simple;
	bh=hSU2ad9vxzv7v5RkeXoUXONBx2LpYICFUhMEWROUn5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adNnbvxGU28M8vfxpLigznft2tUxLTWyE2MZako7XDP28J5uhnxX7G6jVjrrHriXopu3yFVb7Oiwwd/DMw3+zK7qhy5bZ4Gkc+JoPW7ai0MXkj0Lr6eohpn1faQ3l/FX8HoaolyI4X7KEUiO6vbbfCi/ElVsUMY9bR0UwZ6ErVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nm5zW5WX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+EOzLE+RTai94Qoe+vHWeyxEes26RRi+ewlRPXeNOJQ=;
	b=Nm5zW5WXUbtVhagW4nL3z3DvlXaSeWbxdoMgzpCodU6jWqtkLU5UGSdDA79+Ipltv5jveJ
	OdRq6PTehfFF3am4/JliDbCJMWw38OzpEfATFf7BVOwHpWG20TfdHnnoADWUioYzMNTIO1
	ZiWKQXgr7lc/BLcm5dqxBv/CT3UY1IA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-G5OU93dvMP-_1OHHZF8lJw-1; Mon, 11 Aug 2025 07:27:00 -0400
X-MC-Unique: G5OU93dvMP-_1OHHZF8lJw-1
X-Mimecast-MFC-AGG-ID: G5OU93dvMP-_1OHHZF8lJw_1754911618
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b788e2581bso2038642f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911618; x=1755516418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EOzLE+RTai94Qoe+vHWeyxEes26RRi+ewlRPXeNOJQ=;
        b=T/9hzapfeE9NIb5tXMjB97BsvDibjTptTldJgT/s1qkArvZY6lPviulZcJxw+83uxj
         FtPlmqYvxl49ShMKv3xXevcbiC5KmG9/KKPncBkulEOycRlAuKGojLTwmCoEWmP7kBA4
         DiPV3kNrAIaptKPOwjjJaWR5nKPXcsn7ie2biEOcxQhFubXnJId1df79tfpHdXVabhu5
         n2R7WfcRsySJtYT5ab7u703b3B6JMBrsRhQHzRF83St6MeQzLKPNQttoN8gDTYLDxFbe
         a6Ix4ng5Ab98Dezr0syOGwC7teJk/NDcDWMZTWlFfQCEj21Kna0iTnAdHGd6ntxLhL3g
         mTTg==
X-Gm-Message-State: AOJu0Yxu4KyUI6M6ZZgk/dLbEUA7zzevDvi6tD3NibBVBEafWji3phj5
	mNllUUMAMw7B2gYVnB/SGLwzasL4/yxJRyx1G8UZQkb6qM1IZNsZocplvNEIr0Mw1EGZxubU2GX
	PfK8FjRz/NC1e2+2mRLT3olay5DoWQ6tuydMDsYg7hsmydWZSTpemiqq2rRQWeEKaXQsH+7Pqjo
	lxDUVXl2LE3NQuIVTE0OEhWmWkrjEBZ6Ao8kwQc1o60JTPgA==
X-Gm-Gg: ASbGncuXrcKPKRsLtf8j+4XXyfHjHjh900jwQSkzlDUMsVWmit+YdZ1K4/+ULDLE+y3
	ifSCrhkJJAtuutP+7vvG3q1qNh3CGgG9o0NCRx+1UolTXkj/eRxSD5ZzBX9q5/9fozeVCbj4cBV
	rrwm9j+0W0ff85XdchhvJWIus34qmzPLqgB/znMceB78PkhD6k/hHNEEJN0khWjX0/cQHJHl0Zo
	12yTLbTSaez06qk3zSz/rzuoPsG/IrFgK6qNTxQZzeEz2wM7UrnxmDXPGbv7GuxDdVEOBNMgtiG
	0XssWFj0Da1afT8f/pWpDdjrJJh2uELwnnmk+PNLLY1eTLIpHiIEfnaZpd/GmtS5XZUn2HSKLAA
	ME/31vJoU1BFHNMSYQC9mAfXA
X-Received: by 2002:a05:6000:40da:b0:3b7:9d87:97c6 with SMTP id ffacd0b85a97d-3b900b552ccmr11182507f8f.44.1754911617717;
        Mon, 11 Aug 2025 04:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgzaZVe/bWq5ilsSm3I+nGmnBoU4tOWHlsDn35ubDMQPCamCfdsJ8Ebz2VnZDz+OwT7Da1fQ==
X-Received: by 2002:a05:6000:40da:b0:3b7:9d87:97c6 with SMTP id ffacd0b85a97d-3b900b552ccmr11182439f8f.44.1754911617130;
        Mon, 11 Aug 2025 04:26:57 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453d6esm40173200f8f.37.2025.08.11.04.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:56 -0700 (PDT)
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
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 09/11] mm/memory: factor out common code from vm_normal_page_*()
Date: Mon, 11 Aug 2025 13:26:29 +0200
Message-ID: <20250811112631.759341-10-david@redhat.com>
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

Let's reduce the code duplication and factor out the non-pte/pmd related
magic into __vm_normal_page().

To keep it simpler, check the pfn against both zero folios, which
shouldn't really make a difference.

It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
scenario in the PMD case in practice: but doesn't really matter, as
it's now all unified in vm_normal_page_pfn().

Add kerneldoc for all involved functions.

Note that, as a side product, we now:
* Support the find_special_page special thingy also for PMD
* Don't check for is_huge_zero_pfn() anymore if we have
  CONFIG_ARCH_HAS_PTE_SPECIAL and the PMD is not special. The
  VM_WARN_ON_ONCE would catch any abuse

No functional change intended.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 186 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 109 insertions(+), 77 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc0107354d37b..78af3f243cee7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -614,8 +614,14 @@ static void print_bad_page_map(struct vm_area_struct *vma,
 #define print_bad_pte(vma, addr, pte, page) \
 	print_bad_page_map(vma, addr, pte_val(pte), page, PGTABLE_LEVEL_PTE)
 
-/*
- * vm_normal_page -- This function gets the "struct page" associated with a pte.
+/**
+ * __vm_normal_page() - Get the "struct page" associated with a page table entry.
+ * @vma: The VMA mapping the page table entry.
+ * @addr: The address where the page table entry is mapped.
+ * @pfn: The PFN stored in the page table entry.
+ * @special: Whether the page table entry is marked "special".
+ * @level: The page table level for error reporting purposes only.
+ * @entry: The page table entry value for error reporting purposes only.
  *
  * "Special" mappings do not wish to be associated with a "struct page" (either
  * it doesn't exist, or it exists but they don't want to touch it). In this
@@ -628,10 +634,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
  * Selected page table walkers (such as GUP) can still identify mappings of the
  * shared zero folios and work with the underlying "struct page".
  *
- * There are 2 broad cases. Firstly, an architecture may define a pte_special()
- * pte bit, in which case this function is trivial. Secondly, an architecture
- * may not have a spare pte bit, which requires a more complicated scheme,
- * described below.
+ * There are 2 broad cases. Firstly, an architecture may define a "special"
+ * page table entry bit, such as pte_special(), in which case this function is
+ * trivial. Secondly, an architecture may not have a spare page table
+ * entry bit, which requires a more complicated scheme, described below.
  *
  * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
  * special mapping (even if there are underlying and valid "struct pages").
@@ -664,63 +670,94 @@ static void print_bad_page_map(struct vm_area_struct *vma,
  * don't have to follow the strict linearity rule of PFNMAP mappings in
  * order to support COWable mappings.
  *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
  */
-struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
-			    pte_t pte)
+static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long pfn, bool special,
+		unsigned long long entry, enum pgtable_level level)
 {
-	unsigned long pfn = pte_pfn(pte);
-
 	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
-		if (likely(!pte_special(pte)))
-			goto check_pfn;
-		if (vma->vm_ops && vma->vm_ops->find_special_page)
-			return vma->vm_ops->find_special_page(vma, addr);
-		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
-			return NULL;
-		if (is_zero_pfn(pfn))
-			return NULL;
-
-		print_bad_pte(vma, addr, pte, NULL);
-		return NULL;
-	}
-
-	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
-
-	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
-		if (vma->vm_flags & VM_MIXEDMAP) {
-			if (!pfn_valid(pfn))
+		if (unlikely(special)) {
+			if (vma->vm_ops && vma->vm_ops->find_special_page)
+				return vma->vm_ops->find_special_page(vma, addr);
+			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 				return NULL;
-			if (is_zero_pfn(pfn))
-				return NULL;
-			goto out;
-		} else {
-			unsigned long off;
-			off = (addr - vma->vm_start) >> PAGE_SHIFT;
-			if (pfn == vma->vm_pgoff + off)
-				return NULL;
-			if (!is_cow_mapping(vma->vm_flags))
+			if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))
 				return NULL;
+
+			print_bad_page_map(vma, addr, entry, NULL, level);
+			return NULL;
 		}
-	}
+		/*
+		 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table
+		 * mappings (incl. shared zero folios) are marked accordingly.
+		 */
+	} else {
+		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
+			if (vma->vm_flags & VM_MIXEDMAP) {
+				/* If it has a "struct page", it's "normal". */
+				if (!pfn_valid(pfn))
+					return NULL;
+			} else {
+				unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
 
-	if (is_zero_pfn(pfn))
-		return NULL;
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
 
-check_pfn:
 	if (unlikely(pfn > highest_memmap_pfn)) {
-		print_bad_pte(vma, addr, pte, NULL);
+		/* Corrupted page table entry. */
+		print_bad_page_map(vma, addr, entry, NULL, level);
 		return NULL;
 	}
-
 	/*
 	 * NOTE! We still have PageReserved() pages in the page tables.
-	 * eg. VDSO mappings can cause them to exist.
+	 * For example, VDSO mappings can cause them to exist.
 	 */
-out:
-	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
+	VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn));
 	return pfn_to_page(pfn);
 }
 
+/**
+ * vm_normal_page() - Get the "struct page" associated with a PTE
+ * @vma: The VMA mapping the @pte.
+ * @addr: The address where the @pte is mapped.
+ * @pte: The PTE.
+ *
+ * Get the "struct page" associated with a PTE. See __vm_normal_page()
+ * for details on "normal" and "special" mappings.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
+struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
+			    pte_t pte)
+{
+	return __vm_normal_page(vma, addr, pte_pfn(pte), pte_special(pte),
+				pte_val(pte), PGTABLE_LEVEL_PTE);
+}
+
+/**
+ * vm_normal_folio() - Get the "struct folio" associated with a PTE
+ * @vma: The VMA mapping the @pte.
+ * @addr: The address where the @pte is mapped.
+ * @pte: The PTE.
+ *
+ * Get the "struct folio" associated with a PTE. See __vm_normal_page()
+ * for details on "normal" and "special" mappings.
+ *
+ * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
 struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 			    pte_t pte)
 {
@@ -732,42 +769,37 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
 }
 
 #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
+/**
+ * vm_normal_page_pmd() - Get the "struct page" associated with a PMD
+ * @vma: The VMA mapping the @pmd.
+ * @addr: The address where the @pmd is mapped.
+ * @pmd: The PMD.
+ *
+ * Get the "struct page" associated with a PTE. See __vm_normal_page()
+ * for details on "normal" and "special" mappings.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd)
 {
-	unsigned long pfn = pmd_pfn(pmd);
-
-	if (unlikely(pmd_special(pmd)))
-		return NULL;
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
-	if (unlikely(pfn > highest_memmap_pfn))
-		return NULL;
-
-	/*
-	 * NOTE! We still have PageReserved() pages in the page tables.
-	 * eg. VDSO mappings can cause them to exist.
-	 */
-out:
-	return pfn_to_page(pfn);
+	return __vm_normal_page(vma, addr, pmd_pfn(pmd), pmd_special(pmd),
+				pmd_val(pmd), PGTABLE_LEVEL_PMD);
 }
 
+/**
+ * vm_normal_folio_pmd() - Get the "struct folio" associated with a PMD
+ * @vma: The VMA mapping the @pmd.
+ * @addr: The address where the @pmd is mapped.
+ * @pmd: The PMD.
+ *
+ * Get the "struct folio" associated with a PTE. See __vm_normal_page()
+ * for details on "normal" and "special" mappings.
+ *
+ * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
 struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd)
 {
-- 
2.50.1


