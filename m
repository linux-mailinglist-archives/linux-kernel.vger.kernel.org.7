Return-Path: <linux-kernel+bounces-731911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B5B05C16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBB8566F50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B72E3AE9;
	Tue, 15 Jul 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dexsxioy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C152E339E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585858; cv=none; b=ULKuDOXsdTZy8J1Q2ExtqUP/WmTfMObkO5kr/ynb6JlsqyAo4W3MyNcE3iAwi0x8IvFwNE776MpoO91b8FW2nQdgM1P0fzODYzsf+wB2QLOrXbCSgfxlh9vyoFmDjlXkQ+d+kP2GqK+jhmBrtGYz9Q5/iLyg/QtJdcA6zuxcv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585858; c=relaxed/simple;
	bh=TBptezEvoZbA/+QIqs5Pl7513sIN/gOoRGF1IIIkC9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uda31eY3clkQUJzSRfa8RKza3ZZ1D/i5NpC9HlmFqM89Mk5+E1eTxBiqQ5AeEdfbn3gQEvAR50E2Tq7JOUuKOuXa6X5ToWrFgNQ6IyBIRyYsZ4sANUzsIy8TE+RZQYt6fYiprUZdcH2b8rvQpyoZq0Q6OYHTgOLO+9KGzQyExKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dexsxioy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752585854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipu1K94ir7ZDGEwTFYIjfG52vTt/Yk6xgTkmlb9d9g0=;
	b=dexsxioyWxZedP609GJjULozSbcGVGrjPHHHCfyzx7X/7TWpVeOCkfX5+8vMTFPy8pGeK6
	njSpIuFXKquYcEGZXXWttF9oRqzsUigwCzbhNFKYQu4dae+bg5bCkvkNt3CcVuBIu3AYVl
	BkCZIs0mbOxa7L2Iy5UDWmfkB8l53Sk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-kgc3QRTFNHeYW5pFXC9xyA-1; Tue, 15 Jul 2025 09:24:13 -0400
X-MC-Unique: kgc3QRTFNHeYW5pFXC9xyA-1
X-Mimecast-MFC-AGG-ID: kgc3QRTFNHeYW5pFXC9xyA_1752585852
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45359bfe631so32890535e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585852; x=1753190652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipu1K94ir7ZDGEwTFYIjfG52vTt/Yk6xgTkmlb9d9g0=;
        b=o7dJfopiOECe2nY4ZtK8R+HmlAwRtGbzZNUEDM/K6Yy/kgwp2yOWHimBx+jTfZu6RX
         exisTxJdnBKwu49uWAaZztf9B+lh/ryj3lrai6SfCXofIuos3GbUoVU5GuXoo+AlkLe7
         NYcZMM1zBOq8pllLev/xzQQ/XgaQR8GMAtGxL0qcz5fATLTXWx+vA/FyzIadOLLZSMar
         VNkw5vO5lGwJKdlqCWOidizcd7826M5mlnSCdN6BQBs3DjsMqCHhbLzPW+kWmST3ZmYm
         t9LLdQwLq7iX/mE7VCMdV03e9rDcryPjHsDkaBe1zWJNLuPeO5EVXB+NaPNDqBdy10Gr
         wAIQ==
X-Gm-Message-State: AOJu0YzgqNJVl3K4PmXW8X7TbPVN7X4zj4Cu0skqs/bA0qVPZmtbfjb9
	QFQYDA+y/WziMi40lpqpNYukLfdSPY1nHGu0WBoPqHMQnV3pWXbGNEaQbw3lbEJst0CgtqlvYwb
	kzB7IPfYqV/Oxuw2X65B5eUli1bDrAygnP8+Ad7NcdY4z+zBq16Uc/opY8ePvA4WgGi65VlsHwU
	gK5njzGpaFE8gmnSTwGg/H1IFv5H8ZpxWn1xt2tx34CDkJDlaQ
X-Gm-Gg: ASbGncvDVd4srleXTmwL1VMJC88jLsY+cSeI+GyrS5IiNUOz6r7FdXkLsGU9pWfRIXa
	+iMgnMjujRGM9HN3TO7tZab6ZPGPbbUJ4MSp+5mWM7Zr9KqLUD4FYM6PWjfoB0hoY/cjHPfjWHe
	xWyiMIL3kbVmx+wCvSnfV27Qz6a2kBSpTJR6IlKAkWgX4vEOuD0MdBlr56+O7k0tK/qKgcGiMFf
	Bmdz64p4et65iwGT2FU8GW2vtE6ArMKx64MqDbUdt85Gsj/aJ9VjdEprBRJFx04gJgwM4L6xFrv
	2fH2s2kE9tvVMA+itPXj8a5+SQZMyVA+uYwQnN1Sy8rk+ltYMdLMU3emCOAvl5fUmP1U8jGcfcc
	fJqFaxiUEUhaom0B9PEmiRDNQ
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-454f427c7a3mr171862555e9.8.1752585851940;
        Tue, 15 Jul 2025 06:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaYqvO7Z17qzgP+gQiOIR1ioSQdxI9NA77sZCIReClJxyu/a9rC4GbIDSj1kdPYM9bqwFuHQ==
X-Received: by 2002:a05:600c:8b21:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-454f427c7a3mr171861965e9.8.1752585851440;
        Tue, 15 Jul 2025 06:24:11 -0700 (PDT)
Received: from localhost (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454dd537c6fsm163863975e9.21.2025.07.15.06.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:24:10 -0700 (PDT)
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
Subject: [PATCH v1 8/9] mm: introduce and use vm_normal_page_pud()
Date: Tue, 15 Jul 2025 15:23:49 +0200
Message-ID: <20250715132350.2448901-9-david@redhat.com>
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

Let's introduce vm_normal_page_pud(), which ends up being fairly simple
because of our new common helpers and there not being a PUD-sized zero
folio.

Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
structuring the code like the other (pmd/pte) cases. Defer
introducing vm_normal_folio_pud() until really used.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 27 +++++++++++++++++++++++++++
 mm/pagewalk.c      | 20 ++++++++++----------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 611f337cc36c9..6877c894fe526 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2347,6 +2347,8 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+		pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/memory.c b/mm/memory.c
index d5f80419989b9..f1834a19a2f1e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -802,6 +802,33 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
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
+ * Get the "struct page" associated with a PUD. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
+struct page *vm_normal_page_pud(struct vm_area_struct *vma,
+		unsigned long addr, pud_t pud)
+{
+	unsigned long pfn = pud_pfn(pud);
+
+	if (unlikely(pud_special(pud))) {
+		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+			return NULL;
+
+		print_bad_page_map(vma, addr, pud_val(pud), NULL);
+		return NULL;
+	}
+	return vm_normal_page_pfn(vma, addr, pfn, pud_val(pud));
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


