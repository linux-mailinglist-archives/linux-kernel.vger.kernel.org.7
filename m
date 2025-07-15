Return-Path: <linux-kernel+bounces-731903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6329B05C79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D207B8D32
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A32E3B12;
	Tue, 15 Jul 2025 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdN9cWNW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C82E1758
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585842; cv=none; b=OuATr+wuWvD0t7BkRAvqLwu22d/l3hfBXBRhCqWqjJ6Xs3IiKRKL9p2r0qry3cgf+GIADguzjfjc1SX99LrGHvVkFpawnmlZXlFaH7g1Zg4+oxjsY0Zy0Wiz9C+/t+UOrVp94P7vdtIS3wvHj3FSlo0hZZydrVeBBR17kKEAFDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585842; c=relaxed/simple;
	bh=ne3nE0vrAY5S0hOjuSZuCjXi2ceWjqlUEku8gXbVmoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFbSMbRhBSTUc0n+qWxXcHssFmrlAg4bRnZvfZ6zGCv4YctjCF2Nau2zm9N0UPXef0bXfH9ZSvpRxRYYS6WJUUyf7Z2XxHq7Ocs0Iys6vLSCbNHw5bm3zQBTn2w4DTontNmRvLG2RcMWvK0Zps8I4aNQUYB7WxED8IS5DNOkGlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdN9cWNW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oD0dyDm8lg70iaRDQ2YlIByz/7M92Pfar0orAStmNLA=;
	b=SdN9cWNWjTg3Kiby/2dvT/Ylx5O4dB8P7trFz5cZF29whZo3b23NNIGpq0WgH2p59lhSHp
	PxsA+iS7ZwoDqlpRhn6QHM5e8yhGnOI0q6PE8vUA0knXVWyvetJnw09mFkzgpmVTkSpAMn
	bWNiGGv3Kp00NWJuHFhQt7gN24oLV6Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-2-jH-m6DM6WTyJTF4v9Qhg-1; Tue, 15 Jul 2025 09:23:58 -0400
X-MC-Unique: 2-jH-m6DM6WTyJTF4v9Qhg-1
X-Mimecast-MFC-AGG-ID: 2-jH-m6DM6WTyJTF4v9Qhg_1752585838
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso2955521f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585838; x=1753190638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD0dyDm8lg70iaRDQ2YlIByz/7M92Pfar0orAStmNLA=;
        b=skzgrtGsB/xA8NZUSebEZFsfr0yVybaigx4sroq2NHGxzapNXSc8ZcmlT26u9XZ0+0
         Bcu7r4Pkw5SUOyTBM72PRgRBtv5LopR/JqCYXOknChBlIUyZ1xRoAKAMnUiFILTAEHD9
         l2HddB9NDc+7oeqzL3SE7o6PChonPfz/8cSPNudfmzCFCN9vExqrO7eZShfdbqdkrEZH
         1YiFRVBGL/jhqI/HqdZ4+buDg3W8ZcGZIrgWXNBAVJtrx/yMTNBQEWARrLDPGWNeFJCW
         f1Xemp7acLLwwj5V/ulDNPE+ILxAkG9IQB/ihz7FF8cx4Hje8jkQIFu5BHH1DeQsll2+
         gxpQ==
X-Gm-Message-State: AOJu0Yx6qL1j5A6mEAo1/opX8Hzhm66ep111cXSZlNaDDT+x5IAonEMM
	7oDRKwOBbe3IQADe88KXt5IvJZnrMxXavQZIwyY8ziuZZ1pGFVHwB5skPw0TAYgFOBoSXa37a39
	xl7/6gF4g8H0q95o6reDlbjNIG6rY26md/zkk2FMajBiUMRoi1aStpzB+HhT8qFZq6Ig5gWbLCS
	Cc6aw5UptVsTPCAfQt3hprKKwLQ8ZROCnrlSYd+nh7KkZRZA9k
X-Gm-Gg: ASbGncsZaqX1X7GI1rJQVM7qK76WyMRSPXKKhxXryrnavB9OCYmSsu5ylLyYnnNBdCj
	nwz0Euu9PJwafq3xNUWAb30ULjoXqu8ediIqi8vCHCQARjQZ1PP9x60+guPVMVuw5Ch4QtVV60T
	fCv07rUbQWHtgeHEEccIc9Cs1N+61DXlXvZWqMN4IDkwXrYLg93r22BXxYZNzvUagSIac6pT3Fv
	CRpO38dopl6nhwFGRhO4TegQw+inysW31flVmijPq236mk0EtJrwUFOHRzWwn0UaJCZiy1gI/Lz
	wIANGw2WStGhxb85qZ9bsBZkpB8nsoxzzdrsECvieUBTarnl4pz0FjBMvu62FPwDZ9tg2/Rissd
	az0Zn+BuRwLx4PocJdnhmIGKr
X-Received: by 2002:a5d:6f1c:0:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b60a144d0emr2333565f8f.1.1752585837551;
        Tue, 15 Jul 2025 06:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp1q78RzrsyhD1CJX8BXKE4JqnpAS3jXZChO9oe8FS+N0ne3lTOJKZGuzSFKSesdJ2HD0wXw==
X-Received: by 2002:a5d:6f1c:0:b0:3a5:527b:64c6 with SMTP id ffacd0b85a97d-3b60a144d0emr2333512f8f.1.1752585836975;
        Tue, 15 Jul 2025 06:23:56 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454d5037fa0sm200348205e9.7.2025.07.15.06.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:23:56 -0700 (PDT)
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
Subject: [PATCH v1 2/9] mm/huge_memory: move more common code into insert_pud()
Date: Tue, 15 Jul 2025 15:23:43 +0200
Message-ID: <20250715132350.2448901-3-david@redhat.com>
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
 mm/huge_memory.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 154cafec58dcf..1c4a42413042a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1518,25 +1518,30 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 	return pud;
 }
 
-static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
+static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 		pud_t *pud, struct folio_or_pfn fop, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	spinlock_t *ptl;
 	pud_t entry;
 
+	if (addr < vma->vm_start || addr >= vma->vm_end)
+		return VM_FAULT_SIGBUS;
+
+	ptl = pud_lock(mm, pud);
 	if (!pud_none(*pud)) {
 		const unsigned long pfn = fop.is_folio ? folio_pfn(fop.folio) :
 					  fop.pfn;
 
 		if (write) {
 			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn))
-				return;
+				goto out_unlock;
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
 				update_mmu_cache_pud(vma, addr, pud);
 		}
-		return;
+		goto out_unlock;
 	}
 
 	if (fop.is_folio) {
@@ -1555,6 +1560,9 @@ static void insert_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
+out_unlock:
+	spin_unlock(ptl);
+	return VM_FAULT_NOPAGE;
 }
 
 /**
@@ -1576,7 +1584,6 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 	struct folio_or_pfn fop = {
 		.pfn = pfn,
 	};
-	spinlock_t *ptl;
 
 	/*
 	 * If we had pud_special, we could avoid all these restrictions,
@@ -1588,16 +1595,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 						(VM_PFNMAP|VM_MIXEDMAP));
 	BUG_ON((vma->vm_flags & VM_PFNMAP) && is_cow_mapping(vma->vm_flags));
 
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
-
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
-	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
-	spin_unlock(ptl);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pud(vma, addr, vmf->pud, fop, pgprot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_pfn_pud);
 
@@ -1614,25 +1614,15 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address & PUD_MASK;
-	pud_t *pud = vmf->pud;
-	struct mm_struct *mm = vma->vm_mm;
 	struct folio_or_pfn fop = {
 		.folio = folio,
 		.is_folio = true,
 	};
-	spinlock_t *ptl;
-
-	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return VM_FAULT_SIGBUS;
 
 	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
 		return VM_FAULT_SIGBUS;
 
-	ptl = pud_lock(mm, pud);
-	insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
-	spin_unlock(ptl);
-
-	return VM_FAULT_NOPAGE;
+	return insert_pud(vma, addr, vmf->pud, fop, vma->vm_page_prot, write);
 }
 EXPORT_SYMBOL_GPL(vmf_insert_folio_pud);
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
-- 
2.50.1


