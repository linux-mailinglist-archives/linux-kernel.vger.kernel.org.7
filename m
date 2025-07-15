Return-Path: <linux-kernel+bounces-731910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4FB05CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6DE7BAC82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2442E718C;
	Tue, 15 Jul 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Msw2epcR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A92E62C3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585855; cv=none; b=khAxXlEZFj+w6JDAV144EjbWXoUFNpzZ4qg+0g8feyS5fPFyKaQCEqgLOsoA0GOsUzKmZ+tAy+a3AIEGYo6x0nX3FaCgSmSnbp1ZrT54S3GJ0dyiZ/jJ19NVUn2KqGB4xasUSOO3NK8t11J/52w2+6kg/m5aNx/sdVDoFiQk93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585855; c=relaxed/simple;
	bh=a9OBY9leQX0eGtrRKrr8AgQOeHXQGP3xXcTwIxxSZ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSluH8Hn2nMHYuFvAYqgmVxuPZKu6sdU32HfdbXQmH9zJMLv1n16ub7wfvI86ipU8j5nCQcVn7ZFNil3O36rONSE2cDd96z5BsYeyVgRylIThiv3HYZQhzUeE6oe5tr8c2gbuqLFFLRZTSWe2B4SXeQJpvJ3tE9VI2f/HHsede4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Msw2epcR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cI2lHUCMuK2zQhlnl2y4PjQd6rkotpnK5tiH1r4owRs=;
	b=Msw2epcRQaluUI+qDzFfEXDcphCGGoAvlLryIXMnyMnnDTN2+hdVpCdhCy8R+9n5lpuEFF
	/cL8ag4Ehxq4+nELpLmPLkJhWGAEFsP4Ghjhn4Z+4cJutcy0XBpGh1DgbLsIlMR6A7AfYD
	iP4xcLpFJehgcq49mY94aqojQuVp2Uw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-3MUr5TG8M9Kwv-8xLk1Sag-1; Tue, 15 Jul 2025 09:24:11 -0400
X-MC-Unique: 3MUr5TG8M9Kwv-8xLk1Sag-1
X-Mimecast-MFC-AGG-ID: 3MUr5TG8M9Kwv-8xLk1Sag_1752585850
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so13652235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585850; x=1753190650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI2lHUCMuK2zQhlnl2y4PjQd6rkotpnK5tiH1r4owRs=;
        b=fIFiUpG/kY3PJ7VOwTp+O/276HFx3ADWGQstPuhK3Ndvb0ilngHEgW/vZiAhcMAXyo
         9CqWRAZ9qdDOQfOE+vZQZTyiHDYzV5Fn0WZ+SCVfBp1xAfTfsukN4A7VcV/i43LIUFrl
         CIfNbzsVcwHBcAT9Z/fMv5Uic0CsxXzq8n6qnDrLC6fSk8ma6CunBae4iVCT3GsqOrWU
         e6Y9pfTHfroeJJXDzTg30QOjnMMypyIr8ZwE0XgVjIW3Wjoiykza+3N+I8mNaSiZ/qHz
         VitaOorPith6SMm9oWeJuE2b1iC4WkM2NwpcDV+zH/ZHsrjfnr1CjjhUH417tREeigFO
         PqLA==
X-Gm-Message-State: AOJu0Yx4O0KULGWCaycKRGAMllBC5UCKYeetIuchv38iMfiPaf+zyJ3b
	XFIxyd3ObQjwLHREOW+0mIMZpgQtSjBl6QbqOeuaCqUyL9xG7n6/I8JR6qpBADgiedfH5GV8O1H
	wBytAJPcooYSnx8PwgYI1H4nydyEdXIIc5eaO9XgfZjagI7mr/r8wFDPZ4jiMuddbC+jYqNv0ZD
	9JMa+32NqCRxiSDX/sNlydMQ6nr6tfFeuwWQ5NCFUN5b5BaAlg
X-Gm-Gg: ASbGncsuMA0MYwufGkMilF4KQLdEpV9alZjycwsbS9Qq0uwpDmc+uggehI/mq8i89ZY
	hnZTiP6480/VuDhOAW+pSZRIZze0sK2kwxVeY9YHmTQzZ5Oc3/g8oQc4WNGdA1heO+QnpvUc+Kn
	Hig3n9Foe1I/eW13LELPQBNllb/eRwusLqSWCMoNb65dxPv6Uj2FqPzB6DTZeT36JBNMTKLSR23
	TnWSGgMAd8I/PXO6MO7aAJkz6HMK6UbSMBBXilXMUAP5ibmhSljWv6wuOHhcvyAqVcOz5hOG38g
	p3m35yvaV8dnQN2KSSDRsc6o2Nax8/VdbL1UjqTxhXdrllKPU3BLSC7A243zIm3/bCgfdxZXLOP
	cbwzjFo7XyoVCQ2i9BeAzbMll
X-Received: by 2002:a05:600c:3592:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-456173c8b27mr94729165e9.2.1752585849831;
        Tue, 15 Jul 2025 06:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkPjEhwUD11Kc7R628CsdkyUBojyPzeegGbQKL/YV/Ocaib7+IW0nyg3EFT/AEMoIuz4CMUw==
X-Received: by 2002:a05:600c:3592:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-456173c8b27mr94728115e9.2.1752585848983;
        Tue, 15 Jul 2025 06:24:08 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e2710bsm15102268f8f.99.2025.07.15.06.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:08 -0700 (PDT)
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
Subject: [PATCH v1 7/9] mm/memory: factor out common code from vm_normal_page_*()
Date: Tue, 15 Jul 2025 15:23:48 +0200
Message-ID: <20250715132350.2448901-8-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715132350.2448901-1-david@redhat.com>
References: <20250715132350.2448901-1-david@redhat.com>
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 183 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 109 insertions(+), 74 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 00ee0df020503..d5f80419989b9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -596,8 +596,13 @@ static void print_bad_page_map(struct vm_area_struct *vma,
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
@@ -609,10 +614,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
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
@@ -645,15 +650,72 @@ static void print_bad_page_map(struct vm_area_struct *vma,
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
@@ -664,44 +726,21 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
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
@@ -713,6 +752,18 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
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
@@ -727,37 +778,21 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
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


