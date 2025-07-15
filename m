Return-Path: <linux-kernel+bounces-731906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E53B05C25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB69C3B5F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968A2E54D3;
	Tue, 15 Jul 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNNWAFdz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29C2E54B1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585850; cv=none; b=is9JfKhju+WafPknNCie6TM3whQCRy/bnYZFKxLx8ybX4Ic05yJ77ZCVzgZMVhr3rOLqu6e3SxvvmD2xbM5qgw97lm/LPT6h3xpa/JSO2FKdVdXL9WUrQok39MaOJFomTSVKzJLfKANCpMWhQrJYk/14+A1ejTW+hKEmOCCO5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585850; c=relaxed/simple;
	bh=OIxBntJu8g9nWJfOzokERv1JQQlXXcbD5TxB2GYJTwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAz9CA3iXwZBt6GY7oWYIyqj6ZXLzuRcVmEln9YXdKYPv9oZrd70AToWTd20J3nZ6YzFSLaEYVCRznnpc/JKC1CDrmiconqVb3yA3tgvhoF/1vWFPm9ikDAmqPWfmD4nJYrm2/uC8FoUddwNkgwhbIODrHPZe3I0JPP8jRaZTrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNNWAFdz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qf0T+96rABqxKpEz5mD8vzC45xOAiNOzYXCwXWS86uE=;
	b=bNNWAFdzww8V0d1wDvb7lLLdex72koyjk/fzQ31u6Hs4Qc8+apFmSUqTGq24TPmO73bS8k
	horV7kYN6kJDKzfMnXEMHQY81OpHffFJlGZEC3gTNQLiCLPIkLoXUA3gsEpZUrCIC3OTom
	66hyZb6B4YNKXp+f4lGOX1yFxqPRONc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-hlzBXdvVN_O_2JytzsI8Tw-1; Tue, 15 Jul 2025 09:24:06 -0400
X-MC-Unique: hlzBXdvVN_O_2JytzsI8Tw-1
X-Mimecast-MFC-AGG-ID: hlzBXdvVN_O_2JytzsI8Tw_1752585845
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4561bc2f477so13651775e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585845; x=1753190645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qf0T+96rABqxKpEz5mD8vzC45xOAiNOzYXCwXWS86uE=;
        b=IP/cpDAgMvfcNOwGzMo7U1oM/tWe9iQBPJyjI2nRf/zpMoGkK49dYpO3mPSyToxlgw
         0EFQc2Z5OlsABKzadSt+8ut88kA+rm90xz737xhGHS27Jk5HTrqGX3OClkEefvPjv5bZ
         J3ZavSgUo0bsVVoWo2ozIktrzGmO9SzmtEMOHpHQoNebVBBEIvSQNbV2BjmjEks5dPZD
         y/PQwK5RwLmjKYKHp/EMh9HU2pCFZIoy96+9AeefacUr54GzqPZlJmiBt+SQqQI4NOxt
         zuOov+WWBclxceLYUmg32FnkLkYLZc2YE8/+njS4IneU6qM29gU0N7Hcj4BjnTiU/nc3
         BpFA==
X-Gm-Message-State: AOJu0YwDnwipmWz4W/w/b5cqaIqzeWkcRO6F3BIWnHi4ujtPzSMq+Bds
	w+uV6ebEL1ndZTWvvz7lCBezO50sfYLhAmQ2qPsiguVL3YgcK1YTIc4vaN2Not+/m4emgfEteKZ
	oqOtkrykn61RRqKJ0VXzSuBAyGGalrVNmnA+tSbDvGha6VjG/1AKhLLuUSv3hjR661a+963g+PM
	sV8lMjIj9ITMae/DTOh0FYmsHD4ykviynBI0RkaBz1LdWk2jmC
X-Gm-Gg: ASbGnctZyEX87djQ+xxLXLhqlVa8r6PmfTWhM3b9H4nd/AXr9VuikhvteIcbskSKVEg
	2CGxwkcFPmwScho3QLJKEhfu9Z53HKwZezaEmAZ7SyE4JEYgSZt16qw2YgIdMTt+wbamE++FT9e
	yC73z1oAc0smzTlVi+cF2gys/I1KiQ31Qxdg7MIUF2KiIfNvIv14XCGQpzq0kypI5DWOuAsb3Pz
	eetNzKzWlQaHcq9r9rPw2P4qxxIYl9+IcF16sH9M/FS1nt1fPJAVebIR5OSFj8A+B62ptbXYWvu
	GZlknXAesGvk//h/U8OmbuqGuzJI4shKd9uPxaqdjOUtRh0oGXvlW2I9N4oJQkZklkw2LS/9TVL
	2SOXzvg292jJDtKg2e3quFMyB
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-4561e5a903dmr64876495e9.9.1752585845038;
        Tue, 15 Jul 2025 06:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNkvm/o7SOv8gvxBFeHAl5ZSVtKwdA8aiblR66hArUogUqCn7BZUev9VVrmUri129a2+K3wA==
X-Received: by 2002:a05:600c:1c10:b0:456:1e5a:8879 with SMTP id 5b1f17b1804b1-4561e5a903dmr64875585e9.9.1752585844257;
        Tue, 15 Jul 2025 06:24:04 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45611a518c2sm80433825e9.31.2025.07.15.06.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:03 -0700 (PDT)
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
Subject: [PATCH v1 5/9] mm/huge_memory: mark PMD mappings of the huge zero folio special
Date: Tue, 15 Jul 2025 15:23:46 +0200
Message-ID: <20250715132350.2448901-6-david@redhat.com>
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
index 9ec7f48efde09..24aff14d22a1e 100644
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
index 3dd6c57e6511e..a4f62923b961c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -543,7 +543,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
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
@@ -573,9 +579,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
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
@@ -655,7 +660,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 {
 	unsigned long pfn = pmd_pfn(pmd);
 
-	/* Currently it's only used for huge pfnmaps */
 	if (unlikely(pmd_special(pmd)))
 		return NULL;
 
-- 
2.50.1


