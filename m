Return-Path: <linux-kernel+bounces-762507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E352EB207C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06502A37A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE1E2D3EE3;
	Mon, 11 Aug 2025 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPxo9qTA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401EA2D3A8A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911611; cv=none; b=Hx1nD7DfKal4HhSuPlnld9XCjwG2hr3yaO3chEJiZzOEc9NW4HSZAaoTriPprMzGLJygUUp2FphTZcWje1aacxpjKGuTMnALjfzTfk+8jtwiKTcgt2aFshTlaDKkqgATnSevK+dcxxRsrU85CKSXkNa21T6KLN+PlZcQK8EkgEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911611; c=relaxed/simple;
	bh=eXpOz3QD8NbTu+ic8ivqaLXg+1OSU3HgP2CuXfIC8j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7sd3w3V0XpzkEQ/HEvEUM4ingHZPh49HfMMLqxAiBZ5LgCHQErEY00fBChB3p0WRsHtIo7cjQauS5VWnfzTdw5AxLlTg31zZRGx+jlfFfmVCOYiH1JQzwDRwS0zRQBj8HYteoL6lblAaNiInVlVK6XIGeK8GlnNYsyCFqvLaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPxo9qTA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CQ37fr3U8Nz67n3Rs/zLbnQBIPHeKcdveRJNY/DHTc=;
	b=iPxo9qTATYiT6KlCrgNNr467d7GI8CeHtwHJB9cvKz45Jrmin7rtKqkuvjMsycEqh8BbfK
	k3/50cMnfqqKQJ8vFOJzOoivB5lGOOVYSW75/FAdFcOtBgtPpTh1vUCfZ1BQKDsIBupII7
	3DFedeAjqIsTepFhPIB6u7T9pky1RZk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-eI89kdXZNJ2Kxu3zmVtbrg-1; Mon, 11 Aug 2025 07:26:46 -0400
X-MC-Unique: eI89kdXZNJ2Kxu3zmVtbrg-1
X-Mimecast-MFC-AGG-ID: eI89kdXZNJ2Kxu3zmVtbrg_1754911605
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458c0845b34so31384095e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911605; x=1755516405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CQ37fr3U8Nz67n3Rs/zLbnQBIPHeKcdveRJNY/DHTc=;
        b=IV2xX8A3w+3gJHZEj0RIK6z58UCvsci4I/pgYTLa9SVlL5M1SueRfK2+vl+GpHZdjd
         FTWYTXg7YD/jicn/DtXr4Z75nUVun7XuLdNjtEOCa1OgcbcmbpY3uBCofQA4PaZCwTum
         dbJ2FXKw1JVcH9p2YTaa5hCq2Y0jSNIvyjHruJG1LZmdgNlp73S2mgYFWW7Yxf41MYJR
         RXrlrKOdjEYtNsC7qLcIGUXD6do0IA3iaILhl6dV4vtORwDOuid8hg7jYV5MxFFMnh2e
         vHi+u7ecnw+cqpKqWH0Y6/rLvuAIv1ffrU0PQQODiHi9bhTM8DOS9dbCmxyiwiLRQYk3
         /zyg==
X-Gm-Message-State: AOJu0Yx1zLY8ewODZhqwRTZOwORdlx9PHOU7iep9S/3Rdp5TzRjlfjrC
	+okkpIKHfZP9CcbB+fIgwX45ACrbSc0GHAWoiv/3dkv+s+AHyzn5Rp78OcriIr3dYLp2XImX/6e
	VstC2t32WPsXJwQf6snOriYE1WStNvxg//AhNgVwU73NBYLOpN9+wlGUDlkL2GPGM+hNe5URITg
	nf96I8hIG8gXR76hMoveuBarH8o7oHXdYunvmpE7to4z3isQ==
X-Gm-Gg: ASbGncsmj1jlxeG8hLtmTDVuinj0WJIQYRjd525JxWaGfTEBRu1LltdHBqgX22xFlYk
	Y9ykr+KAM1YqBUQOUbcnonPbDceo2OHEM8Fxl0pNyM77mN5kItFeyrECnUPacmC+PuVqieJ8U1j
	AFl8hThbhUPQtULeyuXVPsTDGSNlEsGruQgRvBs4tQ8AwUkWWX5ACEG5OBJL4lLedp+/k5woqDv
	2IjOkPleoddPS1xUSMQvDkFIX/dAhS+UF4Uv1RXlX83vWOJFGzWWefccUyrKtEgLHTQOUtP4hof
	C6h4U4qcXLuUhiOfdCL60VS1wehNtrSBHWwEiODPhGJV7VNCnCRgUVsgcv5DjWclkjRFLwucjBA
	ZUnoKP4xJXK1LKnkxc4Xqt4Ws
X-Received: by 2002:a05:6000:220c:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b900b579abmr8417883f8f.59.1754911605052;
        Mon, 11 Aug 2025 04:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhtoj1JC1TeyGzrT2XifHRNOizQnW6DZ2myFR7vrwjVvSFSoQpoWzRIG0dK3lnMunpNHs17g==
X-Received: by 2002:a05:6000:220c:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b900b579abmr8417828f8f.59.1754911604480;
        Mon, 11 Aug 2025 04:26:44 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4696c8sm39325003f8f.55.2025.08.11.04.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:43 -0700 (PDT)
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
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v3 04/11] fs/dax: use vmf_insert_folio_pmd() to insert the huge zero folio
Date: Mon, 11 Aug 2025 13:26:24 +0200
Message-ID: <20250811112631.759341-5-david@redhat.com>
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

Let's convert to vmf_insert_folio_pmd().

There is a theoretical change in behavior: in the unlikely case there is
already something mapped, we'll now still call trace_dax_pmd_load_hole()
and return VM_FAULT_NOPAGE.

Previously, we would have returned VM_FAULT_FALLBACK, and the caller
would have zapped the PMD to try a PTE fault.

However, that behavior was different to other PTE+PMD faults, when there
would already be something mapped, and it's not even clear if it could
be triggered.

Assuming the huge zero folio is already mapped, all good, no need to
fallback to PTEs.

Assuming there is already a leaf page table ... the behavior would be
just like when trying to insert a PMD mapping a folio through
dax_fault_iter()->vmf_insert_folio_pmd().

Assuming there is already something else mapped as PMD? It sounds like
a BUG, and the behavior would be just like when trying to insert a PMD
mapping a folio through dax_fault_iter()->vmf_insert_folio_pmd().

So, it sounds reasonable to not handle huge zero folios differently
to inserting PMDs mapping folios when there already is something mapped.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/dax.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4229513806bea..ae90706674a3f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1375,51 +1375,24 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		const struct iomap_iter *iter, void **entry)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = mapping->host;
-	pgtable_t pgtable = NULL;
 	struct folio *zero_folio;
-	spinlock_t *ptl;
-	pmd_t pmd_entry;
-	unsigned long pfn;
+	vm_fault_t ret;
 
 	zero_folio = mm_get_huge_zero_folio(vmf->vma->vm_mm);
 
-	if (unlikely(!zero_folio))
-		goto fallback;
-
-	pfn = page_to_pfn(&zero_folio->page);
-	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
-				  DAX_PMD | DAX_ZERO_PAGE);
-
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
-	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
-	if (!pmd_none(*(vmf->pmd))) {
-		spin_unlock(ptl);
-		goto fallback;
+	if (unlikely(!zero_folio)) {
+		trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
+		return VM_FAULT_FALLBACK;
 	}
 
-	if (pgtable) {
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		mm_inc_nr_ptes(vma->vm_mm);
-	}
-	pmd_entry = folio_mk_pmd(zero_folio, vmf->vma->vm_page_prot);
-	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
-	spin_unlock(ptl);
-	trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
-	return VM_FAULT_NOPAGE;
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, folio_pfn(zero_folio),
+				  DAX_PMD | DAX_ZERO_PAGE);
 
-fallback:
-	if (pgtable)
-		pte_free(vma->vm_mm, pgtable);
-	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_folio, *entry);
-	return VM_FAULT_FALLBACK;
+	ret = vmf_insert_folio_pmd(vmf, zero_folio, false);
+	if (ret == VM_FAULT_NOPAGE)
+		trace_dax_pmd_load_hole(inode, vmf, zero_folio, *entry);
+	return ret;
 }
 #else
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-- 
2.50.1


