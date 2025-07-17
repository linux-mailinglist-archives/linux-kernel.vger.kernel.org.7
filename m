Return-Path: <linux-kernel+bounces-735202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E34B08C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F7E179BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F12BDC0C;
	Thu, 17 Jul 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2VC8NmP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E02BCF7F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753153; cv=none; b=u573cDyRbzD8DTR/C+lEIqkLuKHpgmavgpOTGytP/T4VoUWni66/4eoSVCXXHEiTzWgUM1OKKatieX/d+CyQaEyez0rFLwY6p87WM5ORazb9LRqTabEYQkIS/7mwlDUmY8yAQtAmPQB5Bam38JmFhYfnNGQBgECLZrZq1ZbsMLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753153; c=relaxed/simple;
	bh=op/fn/eil8uW4Lqi0nNtrKr+hAEgKQCdVXv87J2C3Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6LYJIh1dD9jJq7a8++/25XvE+P5Yr+72X9J1Z7T0npKs3vjlYgXGJ2B9f9fRK+EmikQWwPs8ZjMTBfh9M4FJzoV9paWhzRu90pNphHcCNogIJoQnD+/YaW9+f8Cp6eUtQ64c4lK6TxLc0x9MpL19WNil76WNvqT0RgqpdFOBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2VC8NmP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXxbBdWkSFir8qoOw7q+QMZqWjLZWA9TcFjO3xeUJH4=;
	b=C2VC8NmPcGN+tcIaUyEMq8PP+GICpQ/gZAImDODAuAxA2BYSVh0ZmWRPxBOm4eQYG8x1EJ
	40EAN/U9PDA74yr07plfDS8x3DQbKF5YlDdh4Hn4dQqH0ajfRIl8oMRnbgO/Md7Q0ErPs1
	2NdrvIu/TdM3hM0UsktowKdX7Zf+SS4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-5v7VCFnvNDGzpgQtssnBWw-1; Thu, 17 Jul 2025 07:52:29 -0400
X-MC-Unique: 5v7VCFnvNDGzpgQtssnBWw-1
X-Mimecast-MFC-AGG-ID: 5v7VCFnvNDGzpgQtssnBWw_1752753148
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a5058f9ef4so374344f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753148; x=1753357948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXxbBdWkSFir8qoOw7q+QMZqWjLZWA9TcFjO3xeUJH4=;
        b=c9kkU2dIhUnSHenSzgmOisOfXePNpcUpi7PQc/USEb77QrgCrh73eKkpoBd9tSrOly
         ROqvbxmc6qGPN24gZPab/8jx+UfY7gbAfogrslOq/x7peKkZhcekiaWSXVHS+qpHZsE8
         llWrcaMCBYpRkfxHYsUbLkIYS9sa69iTF+rHo8+TE/J90B5weGOufc2WuevEvsp0iIWU
         BlCz3GGZob4kUUbLeGrx2HZIXUnfjLbRX0ROpvoZsBwECXjGOpPSygSensnsbKhaHa/1
         A2YGqGMAe2LHxMF0Y2pHZ/N7G4ZMtJZ9RfT8TQiDZYy2vH/pViHNuUSiTt2Fa6fBFW3+
         LioQ==
X-Gm-Message-State: AOJu0YyIUigR4ZoU4QvGczuqVoL6HiZO7eqk27tbh5GpZ/09CP9bVGXl
	RzB/noyCkaEW5FwPITfdK7d7uV7N8r/VVxc+Prto5KMT/RWtYSXKiryOLyebSMfI5v27txJGfmT
	Q18SfuHvVzntc3GGDdaoyAjjGNmDTVD9zbYCPj0j1KVC5BdlNRR8Je3m85hSMYGT7VxzlxayJex
	Q7VhpWZONMkXNLmS063k8QJ96PoI9B154Y8SG2zsTd7ByPdtR6
X-Gm-Gg: ASbGncsQXGgHKJquMpR1+zn0JAStE0YIVObiHqxk76nIn7esNfa3ptQhjR98JKojSHq
	byVTnIEDEoNpU2ibyWWJ8Ov3TC+mI3l125VkTr47QAvZXBemM7TOq8B86gIQwDGfz50f8XxQDvv
	SVn2gz795dcAbB5zLnO6KPzIkGHBh86Zm1iD6XQBZri25uP6QyySuJGtKJQ6iEf92RodCkto16h
	abcB+REhHce3tY52qFHCsfSWDPwJPvRNt3Hx4uEcEuTQ/2Ni4T83pxr+QlvCZkG09BU/U2J+e1J
	KTVlOEj0xAQIfSFg/8t6gyddFK1Il2OJ4TV9FhJsL35wgQfge4cofjN73OQV1AnCVAFLMBYB5i+
	Frne3Pgk4ICAHeUWK15LosBs=
X-Received: by 2002:a05:6000:4b05:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3b60dd72378mr5333973f8f.23.1752753147682;
        Thu, 17 Jul 2025 04:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVug96IdPAxHxRCwLhhCK8Tw1f2oOZhwD0absH2YXaDMF3tjDXL2HLEbyWszstU7d4tmbzEQ==
X-Received: by 2002:a05:6000:4b05:b0:3a4:e4ee:4ca9 with SMTP id ffacd0b85a97d-3b60dd72378mr5333908f8f.23.1752753147033;
        Thu, 17 Jul 2025 04:52:27 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e25e75sm20438446f8f.87.2025.07.17.04.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:26 -0700 (PDT)
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
Subject: [PATCH v2 5/9] mm/huge_memory: mark PMD mappings of the huge zero folio special
Date: Thu, 17 Jul 2025 13:52:08 +0200
Message-ID: <20250717115212.1825089-6-david@redhat.com>
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

The huge zero folio is refcounted (+mapcounted -- is that a word?)
differently than "normal" folios, similarly (but different) to the ordinary
shared zeropage.

For this reason, we special-case these pages in
vm_normal_page*/vm_normal_folio*, and only allow selected callers to
still use them (e.g., GUP can still take a reference on them).

vm_normal_page_pmd() already filters out the huge zero folio. However,
so far we are not marking it as special like we do with the ordinary
shared zeropage. Let's mark it as special, so we can further refactor
vm_normal_page_pmd() and vm_normal_page().

While at it, update the doc regarding the shared zero folios.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c |  5 ++++-
 mm/memory.c      | 14 +++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index db08c37b87077..3f9a27812a590 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1320,6 +1320,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 {
 	pmd_t entry;
 	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
+	entry = pmd_mkspecial(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
@@ -1429,7 +1430,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (fop.is_folio) {
 		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
 
-		if (!is_huge_zero_folio(fop.folio)) {
+		if (is_huge_zero_folio(fop.folio)) {
+			entry = pmd_mkspecial(entry);
+		} else {
 			folio_get(fop.folio);
 			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
 			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
diff --git a/mm/memory.c b/mm/memory.c
index 92fd18a5d8d1f..173eb6267e0ac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -537,7 +537,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  *
  * "Special" mappings do not wish to be associated with a "struct page" (either
  * it doesn't exist, or it exists but they don't want to touch it). In this
- * case, NULL is returned here. "Normal" mappings do have a struct page.
+ * case, NULL is returned here. "Normal" mappings do have a struct page and
+ * are ordinarily refcounted.
+ *
+ * Page mappings of the shared zero folios are always considered "special", as
+ * they are not ordinarily refcounted. However, selected page table walkers
+ * (such as GUP) can still identify these mappings and work with the
+ * underlying "struct page".
  *
  * There are 2 broad cases. Firstly, an architecture may define a pte_special()
  * pte bit, in which case this function is trivial. Secondly, an architecture
@@ -567,9 +573,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
  *
  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
  * page" backing, however the difference is that _all_ pages with a struct
- * page (that is, those where pfn_valid is true) are refcounted and considered
- * normal pages by the VM. The only exception are zeropages, which are
- * *never* refcounted.
+ * page (that is, those where pfn_valid is true, except the shared zero
+ * folios) are refcounted and considered normal pages by the VM.
  *
  * The disadvantage is that pages are refcounted (which can be slower and
  * simply not an option for some PFNMAP users). The advantage is that we
@@ -649,7 +654,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	/* Currently it's only used for huge pfnmaps */
 	if (unlikely(pmd_special(pmd)))
 		return NULL;
 
-- 
2.50.1


