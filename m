Return-Path: <linux-kernel+bounces-731902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5C7B05C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6F74620D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B812E3B0F;
	Tue, 15 Jul 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn3sx3Xe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7C2E3AF6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585842; cv=none; b=Q+B0OC3QYDuitOTNWCcVLx9Ehd5ASgnZA4gSoyTcLBCj6CFw54nEXeRKlUzCFWJrHu1RH1JkN865TIeVll4K7hySltxiBiiUROkFp2bnv+FG/0dbQ0Oc39xiWgwfY4xT4LFyV/gtbw78ZqnVg0vdBs8xC92abnjOVhF8Znzs2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585842; c=relaxed/simple;
	bh=pbPnEp6aaXv016kkLIdATYY5utELjl0Lfjdju0xIO5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN7lFvGQ98qkyV7ASBQ+LFyQRV43qpzuGvibQqfuhOjZgZe5z3lwPm1BhXKDHwfAHKDPUzoE6CducqmAdhpFl3J8IUvN/SP4LW+jraMC0SxjuM0Qp9HI9R+9qIV1NykO78SEOblRpUUA9cwnX9Bh4022CYbMQ65VfERJ2JljXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn3sx3Xe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykT8pgWXFgvGFNKHweTL3CrCV9vUidi0sNJ9Np/Hvr0=;
	b=cn3sx3XeRt+kvYnao9E9M5MDH0abZTAApx6GfpEJvTnZodbGvcrjs8gHIZ5fiIU2XbHnUZ
	sCXK7X3m3eBGkJtXtif7sA1qux6hW3uOWZEtoctrkTJwLfZH0T1YGI7nVeUL3x7U3QduzE
	TuiWIBRckyti5aQHtad2+92Pw8XcyGI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-eOtzKcwiNFiuhL1oG3I54A-1; Tue, 15 Jul 2025 09:23:57 -0400
X-MC-Unique: eOtzKcwiNFiuhL1oG3I54A-1
X-Mimecast-MFC-AGG-ID: eOtzKcwiNFiuhL1oG3I54A_1752585836
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626532e27so6299755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585836; x=1753190636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykT8pgWXFgvGFNKHweTL3CrCV9vUidi0sNJ9Np/Hvr0=;
        b=aTYeHMX32AbzjMK9e80QLrW0lpHBf6ZlBlVzxMpA78OIxmoAuqDuH0fpniWRJcUXla
         OxizFp2CURqd5klDPqOUnj6FuQr/OYLP383RJZJYpX3g1T9y02yYZz3YMJnJLCmbwMp9
         qw/TYOCtkXWuZvXQJpPmiVsLYy2A9hFCwAe+Er94SbLOCtNRtCVbPMeGQp+xHmdZ3aXc
         VM875Sjv/0JhmVp7ioKk/n9HuizckWS+ApnNL5omTZDV5/z4u9SaqBV25HXOdnK7b5ye
         Hycl9KfSsNsj1pzsydH7WFojIQggNUGyHqClb2Ld6qXGYV7Hbv5sR1PJtuyXGzdbGC4N
         93Vw==
X-Gm-Message-State: AOJu0YxOsF/P+AYI31yIC4NXWowVt0sTYG0d9rvCLPS+mlr6FEO02vgX
	Y3XaIx9EOgNtx/prXK2QbHlOip0Ve+/ngk1xFUqb2SeIx52qXmPQj3Akdbica6XdTZ0hf4AVbQZ
	Ay+oMgdH7rJ6uriTkvF/t1JoxlERkSQ+Tp2nFvd47hDsmAmQNhX+MTLHjz90fBqiWZoJZlBLTvx
	8lOEChp8DklVSI6i2hi3K7+4Rtl2CZ0XTeNymfXD7aZB8F6JTO
X-Gm-Gg: ASbGncvEr//wNTqEW1X2Lw6QrHO45iRRe+m3ABoW4ORbtyjtXP1twwRSDZoe2d7lDk/
	YE6EjayumWeertInwMJUZyl2ivKpMacD5LsZuDrfMhyGQwwCPmCE648kWLQmUjS695AhSWGfjIz
	vRMuvs8YYUDze3LYWRGoQUyrDn0xKyvDNFBIbGkuO2kY2+la/CAh6emSSe+7AigZ9ttfQXs/unR
	ZZeKawh4wpxeQvMKsudF9cUXuXdWe7VwOrjnvY3vddFXaZBl0UbYvT7PWh6VtVoayRDu9Dh1frd
	+slnzi5nOqMx+ijT5WmW2EnvRrIvk3xHGuh7rq33jH+RaP/eBmSnDR4R26OfF89Y1aDszw2XW/E
	IJaQkCJDTWg0AKa9wzidvcEWZ
X-Received: by 2002:a05:6000:144e:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3b5f3593547mr14507467f8f.51.1752585835768;
        Tue, 15 Jul 2025 06:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKDFYln2JrtTRhld2NwLX7CnQQsSirIV2K0GbAl0c8l2mNgbUwK9i9nFjMxSZj5YkY6MStUw==
X-Received: by 2002:a05:6000:144e:b0:3a4:cbc6:9db0 with SMTP id ffacd0b85a97d-3b5f3593547mr14507363f8f.51.1752585834604;
        Tue, 15 Jul 2025 06:23:54 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8dc23cfsm15410702f8f.37.2025.07.15.06.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:23:53 -0700 (PDT)
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
	Lance Yang <lance.yang@linux.dev>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v1 1/9] mm/huge_memory: move more common code into insert_pmd()
Date: Tue, 15 Jul 2025 15:23:42 +0200
Message-ID: <20250715132350.2448901-2-david@redhat.com>
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

Let's clean it all further up.

No functional change intended.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31b5c4e61a574..154cafec58dcf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1390,15 +1390,25 @@ struct folio_or_pfn {
 	bool is_folio;
 };
 
-static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
+static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pmd_t *pmd, struct folio_or_pfn fop, pgprot_t prot,
-		bool write, pgtable_t pgtable)
+		bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	pgtable_t pgtable = NULL;
+	spinlock_t *ptl;
 	pmd_t entry;
 
-	lockdep_assert_held(pmd_lockptr(mm, pmd));
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
 
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	ptl = pmd_lock(mm, pmd);
 	if (!pmd_none(*pmd)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
@@ -1406,15 +1416,14 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 		if (write) {
 			if (pmd_pfn(*pmd) != pfn) {
 				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
-				return -EEXIST;
+				goto out_unlock;
 			}
 			entry = pmd_mkyoung(*pmd);
 			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
 				update_mmu_cache_pmd(vma, addr, pmd);
 		}
-
-		return -EEXIST;
+		goto out_unlock;
 	}
 
 	if (fop.is_folio) {
@@ -1435,11 +1444,17 @@ static int insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (pgtable) {
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 		mm_inc_nr_ptes(mm);
+		pgtable = NULL;
 	}
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
-	return 0;
+
+out_unlock:
+	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
+	return VM_FAULT_NOPAGE;
 }
 
 /**
@@ -1461,9 +1476,6 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 	struct folio_or_pfn fop = {
 		.pfn = pfn,
 	};
-	pgtable_t pgtable = NULL;
-	spinlock_t *ptl;
-	int error;
 
 	/*
 	 * If we had pmd_special, we could avoid all these restrictions,
@@ -1475,25 +1487,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
 
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
-	error = insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write,
-			   pgtable);
-	spin_unlock(ptl);
-	if (error && pgtable)
-		pte_free(vma->vm_mm, pgtable);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pmd(vma, addr, vmf->pmd, fop, pgprot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pmd);
 
@@ -1502,35 +1498,15 @@ vm_fault_t vmf_insert_folio_pmd(struct vm_fault *vmf, struct folio *folio,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PMD_MASK;
-	struct mm_struct *mm = vma->vm_mm;
 	struct folio_or_pfn fop = {
 		.folio = folio,
 		.is_folio = true,
 	};
-	spinlock_t *ptl;
-	pgtable_t pgtable = NULL;
-	int error;
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
 
 	if (WARN_ON_ONCE(folio_order(folio) != PMD_ORDER))
 		return VM_FAULT_SIGBUS;
 
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
-	ptl = pmd_lock(mm, vmf->pmd);
-	error = insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot,
-			   write, pgtable);
-	spin_unlock(ptl);
-	if (error && pgtable)
-		pte_free(mm, pgtable);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pmd(vma, addr, vmf->pmd, fop, vma->vm_page_prot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
 
-- 
2.50.1


