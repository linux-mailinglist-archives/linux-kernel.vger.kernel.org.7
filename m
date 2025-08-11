Return-Path: <linux-kernel+bounces-762511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1DB207D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20732A399E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5252D59E3;
	Mon, 11 Aug 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBQDmczx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E22D542A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911622; cv=none; b=Gcuvj9p3PYTvrhNrMEDoGYdTMidz47tn+NzAYBT+BqtCzchgY/m9fblIU/6nDJmLqtKcViA+Zgd5so02HXHFbw+h7lxOc4StFNdVJD9F/VhM6mkByeW5e/MEIFPPebrugvheag6aoMmPAEaZYvDEp69AfNRLMQ94FqfipIFyPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911622; c=relaxed/simple;
	bh=E/K9RmODY2kxNwCdLkZC/2ViB9N/kTfr/CS7UDXcwrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sboB9lQk+zNxMmN8btDdkcSzfaM9dws9DzSMRXzNRwBm+6GOnVc6FU0uNqQTFEi+x2wGt5dfHvCPH+7E03KKzeycxB792Q/BJh0cssQ4pvmkSqh6kZSKIFYQUEImV7xn0xvV4N4XvM+8Z+bY5UXiSMVqKORVHnWP0kXmTPmDJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBQDmczx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754911619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAxz8wtEYwnzSbLFT0UZ22FzefKNNzcleMeX5Ma3lWM=;
	b=NBQDmczxFlUCe8q4B92iFKp8YlKNAYW6GqFnNyH1nkR5c0XtcDAtRr7AG0UlQ6L2Iau5nP
	Y+/L2kCd5YNxajtBDvUi4HA64/I+PA4+8pCMpgPzG/1IqykQNidKz94DPrwzpruL27RuqC
	MpRCuHcCGv0wD70W2gBuTXNNd057PLs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-iUKSoTivPKabESnlZcBslw-1; Mon, 11 Aug 2025 07:26:56 -0400
X-MC-Unique: iUKSoTivPKabESnlZcBslw-1
X-Mimecast-MFC-AGG-ID: iUKSoTivPKabESnlZcBslw_1754911615
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459edc72b65so37079565e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754911615; x=1755516415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAxz8wtEYwnzSbLFT0UZ22FzefKNNzcleMeX5Ma3lWM=;
        b=aDjTG425dt8vDaVM1hnJi0g6BkvjdA82Wx+cYlMW1DMPaN0U8yP5aAUDtyw7W0xtXZ
         A5C4H/wdPnRgMdwwvCI+4apGBLfNwgP/f0AZUkGxwLC/wSmsc+qAWYPhxRvklmgPJ++9
         Ns5flto8+xs8kdqPyyQSJyoq5FCL72H+0LEZd9P1GCXDcvawHkxxfIYKl1xeJmcuR0pr
         PqcMR0dyW0+TQQ671M30fNoj++0bfLe6dviCmSBe+jchf32muccsTHrlqkhvDDnQbR6b
         u8HGe2QoC235uobDN7nREoeEhDMBYrD8hrMLJvmK2Rqgki3cMETXHHuJI5PhMFaQGZtO
         vD8g==
X-Gm-Message-State: AOJu0Yw3W86gqKbYFTt4nKcj3z3v8H7Nm/YD9Rj9mUn34MlAYmpqjVkj
	jhqS9hRSclizwYHHpkB3b4LVSe+wAHkGm5LN9kxPga59mB+/47wH++RC66OT7YMxsw2fnktlLvr
	evTkJoNLjs0d27pjNk82HV8yJ/hAw0+sr3d/jSfM/E+A6Lnxr5nPVnF5BZTtsxmW4lehgou+cdn
	uBimOW781ImwP4Hr7MjyKjjLvBgm4rV58DTcU68JDAsixUHw==
X-Gm-Gg: ASbGncuG34Z7ZpItqcd4sNBwaWJaVzP8FH0UlgL+okvEBxuBzqUnCPfDdXgMKSVbZH4
	uj7hF6rTZKe/a7BVQS/x2Ybh+zOvesXHBQsONAqCJB7uNcFwO/kpXU7AM15orCV/Ed6KA5QBDt9
	wzcwD9EfqLpwW4salbhSnu4YhSdxvlE19XJwDrYXY2FQum5eIHROyACWhA6zKyGO+UP50sdTneY
	6Em38LqzE22PxsxsDLP0DD0AMrYakbDTxvVgrROYqDpcRYp1Zv5v/+V9/DF0IWwRxrV+eItHy6Y
	yhgv4Y2dJMx4mbf1Qt7FQv8o+C8xjz6d6NJM/wsC3RU/iFJZD0R3oIbG2NtB8eKoOwQSqEfXR+k
	6Y7NvnbtT5FmHZNBY+UVkS539
X-Received: by 2002:a05:600c:350f:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-459f4f3dde5mr124071095e9.3.1754911615236;
        Mon, 11 Aug 2025 04:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKs8kYesKmGWPRfo05vS75I0Yn/yE7Pq2L/J4XRbC28zXbi7Rocgkv1+OCyQd3aXR+1J2h1Q==
X-Received: by 2002:a05:600c:350f:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-459f4f3dde5mr124070425e9.3.1754911614678;
        Mon, 11 Aug 2025 04:26:54 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c4530b3sm41080102f8f.34.2025.08.11.04.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:26:54 -0700 (PDT)
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
Subject: [PATCH v3 08/11] mm/memory: convert print_bad_pte() to print_bad_page_map()
Date: Mon, 11 Aug 2025 13:26:28 +0200
Message-ID: <20250811112631.759341-9-david@redhat.com>
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

print_bad_pte() looks like something that should actually be a WARN
or similar, but historically it apparently has proven to be useful to
detect corruption of page tables even on production systems -- report
the issue and keep the system running to make it easier to actually detect
what is going wrong (e.g., multiple such messages might shed a light).

As we want to unify vm_normal_page_*() handling for PTE/PMD/PUD, we'll have
to take care of print_bad_pte() as well.

Let's prepare for using print_bad_pte() also for non-PTEs by adjusting the
implementation and renaming the function to print_bad_page_map().
Provide print_bad_pte() as a simple wrapper.

Document the implicit locking requirements for the page table re-walk.

To make the function a bit more readable, factor out the ratelimit check
into is_bad_page_map_ratelimited() and place the printing of page
table content into __print_bad_page_map_pgtable(). We'll now dump
information from each level in a single line, and just stop the table
walk once we hit something that is not a present page table.

The report will now look something like (dumping pgd to pmd values):

[   77.943408] BUG: Bad page map in process XXX  pte:80000001233f5867
[   77.944077] addr:00007fd84bb1c000 vm_flags:08100071 anon_vma: ...
[   77.945186] pgd:10a89f067 p4d:10a89f067 pud:10e5a2067 pmd:105327067

Not using pgdp_get(), because that does not work properly on some arm
configs where pgd_t is an array. Note that we are dumping all levels
even when levels are folded for simplicity.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/pgtable.h |  19 ++++++++
 mm/memory.c             | 104 ++++++++++++++++++++++++++++++++--------
 2 files changed, 103 insertions(+), 20 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index bff5c4241bf2e..33c84b38b7ec6 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1966,6 +1966,25 @@ enum pgtable_level {
 	PGTABLE_LEVEL_PGD,
 };
 
+static inline const char *pgtable_level_to_str(enum pgtable_level level)
+{
+	switch (level) {
+	case PGTABLE_LEVEL_PTE:
+		return "pte";
+	case PGTABLE_LEVEL_PMD:
+		return "pmd";
+	case PGTABLE_LEVEL_PUD:
+		return "pud";
+	case PGTABLE_LEVEL_P4D:
+		return "p4d";
+	case PGTABLE_LEVEL_PGD:
+		return "pgd";
+	default:
+		VM_WARN_ON_ONCE(1);
+		return "unknown";
+	}
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
diff --git a/mm/memory.c b/mm/memory.c
index 626caedce35e0..dc0107354d37b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -491,22 +491,8 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
 			add_mm_counter(mm, i, rss[i]);
 }
 
-/*
- * This function is called to print an error when a bad pte
- * is found. For example, we might have a PFN-mapped pte in
- * a region that doesn't allow it.
- *
- * The calling function must still handle the error.
- */
-static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
-			  pte_t pte, struct page *page)
+static bool is_bad_page_map_ratelimited(void)
 {
-	pgd_t *pgd = pgd_offset(vma->vm_mm, addr);
-	p4d_t *p4d = p4d_offset(pgd, addr);
-	pud_t *pud = pud_offset(p4d, addr);
-	pmd_t *pmd = pmd_offset(pud, addr);
-	struct address_space *mapping;
-	pgoff_t index;
 	static unsigned long resume;
 	static unsigned long nr_shown;
 	static unsigned long nr_unshown;
@@ -518,7 +504,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	if (nr_shown == 60) {
 		if (time_before(jiffies, resume)) {
 			nr_unshown++;
-			return;
+			return true;
 		}
 		if (nr_unshown) {
 			pr_alert("BUG: Bad page map: %lu messages suppressed\n",
@@ -529,15 +515,91 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	}
 	if (nr_shown++ == 0)
 		resume = jiffies + 60 * HZ;
+	return false;
+}
+
+static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long addr)
+{
+	unsigned long long pgdv, p4dv, pudv, pmdv;
+	p4d_t p4d, *p4dp;
+	pud_t pud, *pudp;
+	pmd_t pmd, *pmdp;
+	pgd_t *pgdp;
+
+	/*
+	 * Although this looks like a fully lockless pgtable walk, it is not:
+	 * see locking requirements for print_bad_page_map().
+	 */
+	pgdp = pgd_offset(mm, addr);
+	pgdv = pgd_val(*pgdp);
+
+	if (!pgd_present(*pgdp) || pgd_leaf(*pgdp)) {
+		pr_alert("pgd:%08llx\n", pgdv);
+		return;
+	}
+
+	p4dp = p4d_offset(pgdp, addr);
+	p4d = p4dp_get(p4dp);
+	p4dv = p4d_val(p4d);
+
+	if (!p4d_present(p4d) || p4d_leaf(p4d)) {
+		pr_alert("pgd:%08llx p4d:%08llx\n", pgdv, p4dv);
+		return;
+	}
+
+	pudp = pud_offset(p4dp, addr);
+	pud = pudp_get(pudp);
+	pudv = pud_val(pud);
+
+	if (!pud_present(pud) || pud_leaf(pud)) {
+		pr_alert("pgd:%08llx p4d:%08llx pud:%08llx\n", pgdv, p4dv, pudv);
+		return;
+	}
+
+	pmdp = pmd_offset(pudp, addr);
+	pmd = pmdp_get(pmdp);
+	pmdv = pmd_val(pmd);
+
+	/*
+	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
+	 * because the table should already be mapped by the caller and
+	 * doing another map would be bad. print_bad_page_map() should
+	 * already take care of printing the PTE.
+	 */
+	pr_alert("pgd:%08llx p4d:%08llx pud:%08llx pmd:%08llx\n", pgdv,
+		 p4dv, pudv, pmdv);
+}
+
+/*
+ * This function is called to print an error when a bad page table entry (e.g.,
+ * corrupted page table entry) is found. For example, we might have a
+ * PFN-mapped pte in a region that doesn't allow it.
+ *
+ * The calling function must still handle the error.
+ *
+ * This function must be called during a proper page table walk, as it will
+ * re-walk the page table to dump information: the caller MUST prevent page
+ * table teardown (by holding mmap, vma or rmap lock) and MUST hold the leaf
+ * page table lock.
+ */
+static void print_bad_page_map(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long long entry, struct page *page,
+		enum pgtable_level level)
+{
+	struct address_space *mapping;
+	pgoff_t index;
+
+	if (is_bad_page_map_ratelimited())
+		return;
 
 	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
 	index = linear_page_index(vma, addr);
 
-	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
-		 current->comm,
-		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
+	pr_alert("BUG: Bad page map in process %s  %s:%08llx", current->comm,
+		 pgtable_level_to_str(level), entry);
+	__print_bad_page_map_pgtable(vma->vm_mm, addr);
 	if (page)
-		dump_page(page, "bad pte");
+		dump_page(page, "bad page map");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
 	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
@@ -549,6 +611,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
+#define print_bad_pte(vma, addr, pte, page) \
+	print_bad_page_map(vma, addr, pte_val(pte), page, PGTABLE_LEVEL_PTE)
 
 /*
  * vm_normal_page -- This function gets the "struct page" associated with a pte.
-- 
2.50.1


