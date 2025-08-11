Return-Path: <linux-kernel+bounces-762513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C7B207D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECBC188D19B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC782D5C9B;
	Mon, 11 Aug 2025 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgOYPiwC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D252D59E8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911625; cv=none; b=i66XPxZVNhio6UpCanvpfsJtQKShKHzowNnqZGegXlJaR01nn9bZoBjYTek1IVtYjaUiA7HQNudLlqJoDEV3+HsNknbOeh0p1XMJdQGqo2QSZgGXJFokpBwUU5R6h3QBcjBj1esVMyha7iu+Sz3/LwqZFQZzfxaQSUgBKCe1NS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911625; c=relaxed/simple;
	bh=NTySCngo3UWUnMxAnrpDZ1TAAIskqhgdVbp26lbNG38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxnyhTsu5Myiuql9DsaHIaTPIhGwT90oUuLGtGhkE7L12NxdK6NKS1CCWQug3lv3/TiUoBbE+nVVQotQtvynvZB8cYQCQExuOTyLaJB6hsJwMY4J61N0fQ4S5qGCSDsd34ZKfoJaWZzQF66VOj5tCZaLjXbUPuR4rwihSVyEhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgOYPiwC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfX1fQMnvUejv+2+JWwebv5CirI4aCq8/b8BncrLfY4=;
	b=PgOYPiwCTEVhMtU+wGKsxtLBOYUCNIaeZdo/dfMtbvNurwODhz0nvt2azgs7BJGKhvvS7f
	XTOapxi8rOMk8agdnWGFmFiohjo/+b1uIJ3TkFEX5+q0PaC2Fa/+EzmE+vn0vfU1uWwtHX
	Il7DophvlLnAsbOGfXIl5RDIdd/G1P8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-rz7Nn2EPNBSP19--lwamvQ-1; Mon, 11 Aug 2025 07:27:01 -0400
X-MC-Unique: rz7Nn2EPNBSP19--lwamvQ-1
X-Mimecast-MFC-AGG-ID: rz7Nn2EPNBSP19--lwamvQ_1754911620
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e30eeea3so28456535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911620; x=1755516420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfX1fQMnvUejv+2+JWwebv5CirI4aCq8/b8BncrLfY4=;
        b=D4X1gGXKgAUEvNTFZ8qhvIeiXA4Ph2WF/+krEAjVe89iRK7YTJPOZfsGl2zfmadBDM
         +foPO++uUHTbawX7JecSDaUqj9OH7sHnRaiaBq3K29tFyKdSwnGs06AYQLur6mBNY7T4
         we1qfbVIbtNiZib2F4fjYRmJXlhEPtf+Ve3Er2v4sjCwx/TXafkzZ1KQpRVjt7yyoGg7
         4MpmiwWIinkz5J/PZQgncHqQln8RzV8IYSl6znkCln2/0OA9c7BBjVFzIm8YzDsMoNk6
         gM3VXQ/phN4nOTMQE0G6ICjx4JeR4yLMqctXU4S2lJS8IpMfITPOCgpA9eLrQBe/6mEc
         XBiA==
X-Gm-Message-State: AOJu0YzW/f/He2SFlawUm76UulGHlQvNUag1a+//7ShRshhKHKfhw2tG
	KrVydnOP2owASfSHmbTVMnqXu/quOYFXLroPZAr/e8GujyOyGDUBJZZssFl99BMb0C7niDbahAr
	RScxU/E/rzE3C8FUsw1D/VDrWEWWXodqLFH/XfWPT99GjV3bRS68WYRlWSXc9HdZhTkKtikgj0q
	wg7qIs2I67IVyJks9pe9Mp/WPuQ6QwFOrN8tgNRtG+yHS9Qg==
X-Gm-Gg: ASbGncsxz7O54D+QyzJYB5XNBGtZqlm7QWJJ05xLhQlH8BNGg1lXRP1w1KbRsq0rgFo
	8ZeymU8dsKrCxRe8fMJeH4zkKF+HGF2nbD9tc9dVwhgk8ZrARC0fVPwOgtsI/Uo7EzWi7V7rpI3
	avVQ9eFtGZP7WCa283cRXyAr5stzp9jGHrFQTUhkD0fU+BVNcnghUKEhQy1EP4AJhvqqzcyWSk+
	Dp8uqm2lX+v1Aq2+HQYme4ET1oDfPJ2PAa2xVN5pOYZ6V2zowNOpEPFTvmJEFVN3tJpmK6Wkerp
	wZFYCAJaRlNDWdD5c7S5QJUBG9otonL38Ue3Lrw6uQ/D0DoAb4AUHx1lWFTj9NK9AtNKIZFyIEP
	/cnNIyjVp6ESNPSDnuHchitC8
X-Received: by 2002:a05:600c:c493:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-459faf4758bmr80581595e9.11.1754911620408;
        Mon, 11 Aug 2025 04:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBm+6FX9Xdf6wc1nTSJlLqt7RXq7PC8peG73SnR2aY3/2U0Fhn5nWzADDyt5hVIbhoPtrtZw==
X-Received: by 2002:a05:600c:c493:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-459faf4758bmr80581015e9.11.1754911619781;
        Mon, 11 Aug 2025 04:26:59 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458be70c5f7sm376335155e9.26.2025.08.11.04.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:59 -0700 (PDT)
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
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v3 10/11] mm: introduce and use vm_normal_page_pud()
Date: Mon, 11 Aug 2025 13:26:30 +0200
Message-ID: <20250811112631.759341-11-david@redhat.com>
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

Let's introduce vm_normal_page_pud(), which ends up being fairly simple
because of our new common helpers and there not being a PUD-sized zero
folio.

Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
structuring the code like the other (pmd/pte) cases. Defer
introducing vm_normal_folio_pud() until really used.

Note that we can so far get PUDs with hugetlb, daxfs and PFNMAP entries.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 19 +++++++++++++++++++
 mm/pagewalk.c      | 20 ++++++++++----------
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b626d1bacef52..8ca7d2fa71343 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2360,6 +2360,8 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+		pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/memory.c b/mm/memory.c
index 78af3f243cee7..6f806bf3cc994 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -809,6 +809,25 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 		return page_folio(page);
 	return NULL;
 }
+
+/**
+ * vm_normal_page_pud() - Get the "struct page" associated with a PUD
+ * @vma: The VMA mapping the @pud.
+ * @addr: The address where the @pud is mapped.
+ * @pud: The PUD.
+ *
+ * Get the "struct page" associated with a PUD. See __vm_normal_page()
+ * for details on "normal" and "special" mappings.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
+struct page *vm_normal_page_pud(struct vm_area_struct *vma,
+		unsigned long addr, pud_t pud)
+{
+	return __vm_normal_page(vma, addr, pud_pfn(pud), pud_special(pud),
+				pud_val(pud), PGTABLE_LEVEL_PUD);
+}
 #endif
 
 /**
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d2..c6753d370ff4e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -902,23 +902,23 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pudp = pudp;
 		fw->pud = pud;
 
-		/*
-		 * TODO: FW_MIGRATION support for PUD migration entries
-		 * once there are relevant users.
-		 */
-		if (!pud_present(pud) || pud_special(pud)) {
+		if (pud_none(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
-		} else if (!pud_leaf(pud)) {
+		} else if (pud_present(pud) && !pud_leaf(pud)) {
 			spin_unlock(ptl);
 			goto pmd_table;
+		} else if (pud_present(pud)) {
+			page = vm_normal_page_pud(vma, addr, pud);
+			if (page)
+				goto found;
 		}
 		/*
-		 * TODO: vm_normal_page_pud() will be handy once we want to
-		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
+		 * TODO: FW_MIGRATION support for PUD migration entries
+		 * once there are relevant users.
 		 */
-		page = pud_page(pud);
-		goto found;
+		spin_unlock(ptl);
+		goto not_found;
 	}
 
 pmd_table:
-- 
2.50.1


