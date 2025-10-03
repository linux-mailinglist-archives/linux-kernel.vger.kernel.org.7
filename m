Return-Path: <linux-kernel+bounces-841553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5097BB7A22
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6801B2161D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3C2D593A;
	Fri,  3 Oct 2025 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGmuYXNE"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D122D6E4A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510644; cv=none; b=U3zNtJnx2xO2RchquDubsNGmwdrMsNTVbgZKsgQdN6zBUkSojVugcjzxQzCjxb3CXIKYu0mnbo3xBxnUALOloKxgYAGmnrQKCfninoBml/eq+fASRxamYWeEGw1DweQBhOrj4noYIjw9cSFIx6N4f7V8r3ap/upLmKKGeaFQZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510644; c=relaxed/simple;
	bh=y+1zrTsivg6GnIBDQbbZqmrSKlC7S4iYPMgm1ltMUxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WdS/8F7Fcxz+89wX2jZp3xC+xvFgGUlhf4I33HUZig+B+8fjxVg82wc1WaldMOlyX1i5uJEym3kcPRA7ZKgiO82YQ5kxuNuLreWvyd324qfEGFLwIQGon3cUhwrFYN9QRC6uGVJo7yWWhf6vTszjuv5RYYSrpSkgUJq8b7fda7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGmuYXNE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ee1365964cso1908909f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510640; x=1760115440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwOMhDbDs+7mPpjZwfg4jebxZ8mM/zclOmdcUFzS4j4=;
        b=LGmuYXNEGmspjp5MkYnDxn2Uh1ZVPCBDy9n8aBJv0GjnykQslZY/dzkPjhfueZRFeY
         1NVgKkJxdG6U388abrXQtbcPsXJUiccqnAkNvK7dCbiGzNd5SBDf9aqqkbXkOsNLoOhG
         8Ak4WEdhCLX4kMwwJXJsnNA/KLs3Uj10o5TZ7iMATx9fC/jqCWF4V7phaR2k7CDxpqQj
         RCvXw7ZBmw6OsM+1niaZ3yoQ5O4TLwNkr86zsrgM3M1V+f5WEHmts1LGprCNFmpdGDha
         AoITY7EpIV40n+sG4RkhjMwLgqXp19r62IL5JTg148FOm7LYOuKDSyyOaLfX1As4GJqT
         /7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510640; x=1760115440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwOMhDbDs+7mPpjZwfg4jebxZ8mM/zclOmdcUFzS4j4=;
        b=Q+TCDtwJXK0zg2w8rBbTBbSWEX1PzNxITeGZRzpGL6mzSyaPSitArgwky37xiO2xYe
         LykyDM9G9c5E9kRZcznGWemZHwoteHAgS5AByjuf5xAedD37G5CxMjgS1Zk73gP8PzYD
         ev9nTuZMlBzfM76kpg4lNZfmkXa3nUdvePKMkY+GpQQU3MXZOGzS41x++Mjo48fgEBK2
         9UFQwdcfambr5Wyg+yKJ07lc18QaJ6k89JPBFRY8SACkJrDPLLE5MqyzZ7WtkifNJ0H3
         +X4OCojKdl69rA4TDstGnacwQk37zZGpZ/PV8xcn5cWbBHUOHakIO2Sk4aim9K6ZFxvj
         uAyQ==
X-Gm-Message-State: AOJu0Yw9fRRWEjH+byTKq0D5dMCC7f2BP/aWf6kJojyFntzgoeNBhOEA
	6Gc3//16DBb2jteYWBeL9lyRquWBW16YldwaFdxlKW7dFo8FhCwt6Tf4hUzu1CRE3E7O2FWjIsL
	nwbTNucgm/6E80w==
X-Google-Smtp-Source: AGHT+IH7UKLpjdafp8xur3NlgAbfxsu74b4CkcL5T2vPwDaIt6hauq8DeQ1CfFOWMzbbQHUqJBbLFNXLH4VygQ==
X-Received: from wrwe13.prod.google.com ([2002:a5d:65cd:0:b0:403:320a:e6b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2dc9:b0:3ec:dbcc:8104 with SMTP id ffacd0b85a97d-425671aa874mr2814892f8f.36.1759510640506;
 Fri, 03 Oct 2025 09:57:20 -0700 (PDT)
Date: Fri, 03 Oct 2025 16:56:44 +0000
In-Reply-To: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003-x86-init-cleanup-v1-0-f2b7994c2ad6@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20251003-x86-init-cleanup-v1-4-f2b7994c2ad6@google.com>
Subject: [PATCH 4/4] x86/mm: simplify calculation of max_pfn_mapped
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

The phys_*_init()s return the "last physical address mapped". The exact
definition of this is pretty fiddly, but only when there is a mismatch
between the alignment of the requested range and the page sizes allowed
by page_size_mask, or when the range ends in a region that is not mapped
according to e820.

The only user that looks at the ultimate return value of this logic is
init_memory_mapping(), which doesn't fulfill those conditions; it's
calling kernel_physical_mapping_init() for ranges that exist, and
with the page_size_mask set according to the alignment of their edges.

In that case, the return value is just paddr_end. And the caller already
has that value, hence it can be dropped.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init.c        | 11 +++---
 arch/x86/mm/init_32.c     |  5 +--
 arch/x86/mm/init_64.c     | 90 ++++++++++++++++-------------------------------
 arch/x86/mm/mm_internal.h |  6 ++--
 4 files changed, 39 insertions(+), 73 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d97e8407989c536078ee4419bbb94c21bc6abf4c..eb91f35410eec3b8298d04d867094d80a970387c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -544,12 +544,13 @@ void __ref init_memory_mapping(unsigned long start,
 	memset(mr, 0, sizeof(mr));
 	nr_range = split_mem_range(mr, 0, start, end);
 
-	for (i = 0; i < nr_range; i++)
-		paddr_last = kernel_physical_mapping_init(mr[i].start, mr[i].end,
-							  mr[i].page_size_mask,
-							  prot);
+	for (i = 0; i < nr_range; i++) {
+		kernel_physical_mapping_init(mr[i].start, mr[i].end,
+					     mr[i].page_size_mask, prot);
+		paddr_last = mr[i].end;
+	}
 
-	add_pfn_range_mapped(start >> PAGE_SHIFT, paddr_last >> PAGE_SHIFT);
+	add_pfn_range_mapped(start >> PAGE_SHIFT, paddr_last);
 }
 
 /*
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 8a34fff6ab2b19f083f4fdf706de3ca0867416ba..b197736d90892b200002e4665e82f22125fa4bab 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -245,14 +245,13 @@ static inline int is_x86_32_kernel_text(unsigned long addr)
  * of max_low_pfn pages, by creating page tables starting from address
  * PAGE_OFFSET:
  */
-unsigned long __init
+void __init
 kernel_physical_mapping_init(unsigned long start,
 			     unsigned long end,
 			     unsigned long page_size_mask,
 			     pgprot_t prot)
 {
 	int use_pse = page_size_mask == (1<<PG_LEVEL_2M);
-	unsigned long last_map_addr = end;
 	unsigned long start_pfn, end_pfn;
 	pgd_t *pgd_base = swapper_pg_dir;
 	int pgd_idx, pmd_idx, pte_ofs;
@@ -356,7 +355,6 @@ kernel_physical_mapping_init(unsigned long start,
 				pages_4k++;
 				if (mapping_iter == 1) {
 					set_pte(pte, pfn_pte(pfn, init_prot));
-					last_map_addr = (pfn << PAGE_SHIFT) + PAGE_SIZE;
 				} else
 					set_pte(pte, pfn_pte(pfn, prot));
 			}
@@ -382,7 +380,6 @@ kernel_physical_mapping_init(unsigned long start,
 		mapping_iter = 2;
 		goto repeat;
 	}
-	return last_map_addr;
 }
 
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7462f813052ccd45f0199b98bd0ad6499a164f6f..60f1a7493844ea399dd08dca50126f22a50d63d7 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -464,16 +464,12 @@ void __init cleanup_highmap(void)
 	}
 }
 
-/*
- * Create PTE level page table mapping for physical addresses.
- * It returns the last physical address mapped.
- */
-static unsigned long __meminit
+/* Create PTE level page table mapping for physical addresses. */
+static void __meminit
 phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 	      pgprot_t prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
-	unsigned long paddr_last = paddr_end;
 	pte_t *pte;
 	int i;
 
@@ -492,8 +488,6 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			continue;
 		}
 
-		paddr_last = paddr_next;
-
 		/*
 		 * We will re-use the existing mapping.
 		 * Xen for example has some special requirements, like mapping
@@ -511,21 +505,17 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 	}
 
 	update_page_count(PG_LEVEL_4K, pages);
-
-	return paddr_last;
 }
 
 /*
  * Create PMD level page table mapping for physical addresses. The virtual
  * and physical address have to be aligned at this level.
- * It returns the last physical address mapped.
  */
-static unsigned long __meminit
+static void __meminit
 phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, pgprot_t prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
-	unsigned long paddr_last = paddr_end;
 
 	int i = pmd_index(paddr);
 
@@ -549,9 +539,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			if (!pmd_leaf(*pmd)) {
 				spin_lock(&init_mm.page_table_lock);
 				pte = (pte_t *)pmd_page_vaddr(*pmd);
-				paddr_last = phys_pte_init(pte, paddr,
-							   paddr_end, prot,
-							   init);
+				phys_pte_init(pte, paddr, paddr_end, prot, init);
 				spin_unlock(&init_mm.page_table_lock);
 				continue;
 			}
@@ -570,7 +558,6 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 			if (page_size_mask & (1 << PG_LEVEL_2M)) {
 				if (!after_bootmem)
 					pages++;
-				paddr_last = paddr_next;
 				continue;
 			}
 			new_prot = pte_pgprot(pte_clrhuge(*(pte_t *)pmd));
@@ -583,33 +570,29 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 				     pfn_pmd(paddr >> PAGE_SHIFT, prot_sethuge(prot)),
 				     init);
 			spin_unlock(&init_mm.page_table_lock);
-			paddr_last = paddr_next;
 			continue;
 		}
 
 		pte = alloc_low_page();
-		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot, init);
+		phys_pte_init(pte, paddr, paddr_end, new_prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		pmd_populate_kernel_init(&init_mm, pmd, pte, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	update_page_count(PG_LEVEL_2M, pages);
-	return paddr_last;
 }
 
 /*
  * Create PUD level page table mapping for physical addresses. The virtual
  * and physical address do not have to be aligned at this level. KASLR can
  * randomize virtual addresses up to this level.
- * It returns the last physical address mapped.
  */
-static unsigned long __meminit
+static void __meminit
 phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, pgprot_t _prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
-	unsigned long paddr_last = paddr_end;
 	unsigned long vaddr = (unsigned long)__va(paddr);
 	int i = pud_index(vaddr);
 
@@ -635,10 +618,8 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		if (!pud_none(*pud)) {
 			if (!pud_leaf(*pud)) {
 				pmd = pmd_offset(pud, 0);
-				paddr_last = phys_pmd_init(pmd, paddr,
-							   paddr_end,
-							   page_size_mask,
-							   prot, init);
+				phys_pmd_init(pmd, paddr, paddr_end,
+					      page_size_mask, prot, init);
 				continue;
 			}
 			/*
@@ -656,7 +637,6 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			if (page_size_mask & (1 << PG_LEVEL_1G)) {
 				if (!after_bootmem)
 					pages++;
-				paddr_last = paddr_next;
 				continue;
 			}
 			prot = pte_pgprot(pte_clrhuge(*(pte_t *)pud));
@@ -669,13 +649,11 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 				     pfn_pud(paddr >> PAGE_SHIFT, prot_sethuge(prot)),
 				     init);
 			spin_unlock(&init_mm.page_table_lock);
-			paddr_last = paddr_next;
 			continue;
 		}
 
 		pmd = alloc_low_page();
-		paddr_last = phys_pmd_init(pmd, paddr, paddr_end,
-					   page_size_mask, prot, init);
+		phys_pmd_init(pmd, paddr, paddr_end, page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		pud_populate_init(&init_mm, pud, pmd, init);
@@ -683,23 +661,22 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 	}
 
 	update_page_count(PG_LEVEL_1G, pages);
-
-	return paddr_last;
 }
 
-static unsigned long __meminit
+static void __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, pgprot_t prot, bool init)
 {
-	unsigned long vaddr, vaddr_end, vaddr_next, paddr_next, paddr_last;
+	unsigned long vaddr, vaddr_end, vaddr_next, paddr_next;
 
-	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr);
 	vaddr_end = (unsigned long)__va(paddr_end);
 
-	if (!pgtable_l5_enabled())
-		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
-				     page_size_mask, prot, init);
+	if (!pgtable_l5_enabled()) {
+		phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
+			      page_size_mask, prot, init);
+		return;
+	}
 
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
 		p4d_t *p4d = p4d_page + p4d_index(vaddr);
@@ -721,33 +698,30 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 
 		if (!p4d_none(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			paddr_last = phys_pud_init(pud, paddr, __pa(vaddr_end),
-					page_size_mask, prot, init);
+			phys_pud_init(pud, paddr, __pa(vaddr_end),
+				      page_size_mask, prot, init);
 			continue;
 		}
 
 		pud = alloc_low_page();
-		paddr_last = phys_pud_init(pud, paddr, __pa(vaddr_end),
-					   page_size_mask, prot, init);
+		phys_pud_init(pud, paddr, __pa(vaddr_end),
+			      page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		p4d_populate_init(&init_mm, p4d, pud, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
-
-	return paddr_last;
 }
 
-static unsigned long __meminit
+static void __meminit
 __kernel_physical_mapping_init(unsigned long paddr_start,
 			       unsigned long paddr_end,
 			       unsigned long page_size_mask,
 			       pgprot_t prot, bool init)
 {
 	bool pgd_changed = false;
-	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
+	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next;
 
-	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
 	vaddr_end = (unsigned long)__va(paddr_end);
 	vaddr_start = vaddr;
@@ -760,16 +734,14 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
 		if (pgd_val(*pgd)) {
 			p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-			paddr_last = phys_p4d_init(p4d, __pa(vaddr),
-						   __pa(vaddr_end),
-						   page_size_mask,
-						   prot, init);
+			phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
+				      page_size_mask, prot, init);
 			continue;
 		}
 
 		p4d = alloc_low_page();
-		paddr_last = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
-					   page_size_mask, prot, init);
+		phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
+			      page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
@@ -784,8 +756,6 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
 	if (pgd_changed)
 		sync_global_pgds(vaddr_start, vaddr_end - 1);
-
-	return paddr_last;
 }
 
 
@@ -793,15 +763,15 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
  * Create page table mapping for the physical memory for specific physical
  * addresses. Note that it can only be used to populate non-present entries.
  * The virtual and physical addresses have to be aligned on PMD level
- * down. It returns the last physical address mapped.
+ * down.
  */
-unsigned long __meminit
+void __meminit
 kernel_physical_mapping_init(unsigned long paddr_start,
 			     unsigned long paddr_end,
 			     unsigned long page_size_mask, pgprot_t prot)
 {
-	return __kernel_physical_mapping_init(paddr_start, paddr_end,
-					      page_size_mask, prot, true);
+	__kernel_physical_mapping_init(paddr_start, paddr_end,
+				       page_size_mask, prot, true);
 }
 
 /*
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 436396936dfbe5d48b46872628d25de317ae6ced..0fa6bbcb5ad21af6f1e4240eeb486f2f310ed39c 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -10,10 +10,8 @@ static inline void *alloc_low_page(void)
 
 void early_ioremap_page_table_range_init(void);
 
-unsigned long kernel_physical_mapping_init(unsigned long start,
-					     unsigned long end,
-					     unsigned long page_size_mask,
-					     pgprot_t prot);
+void kernel_physical_mapping_init(unsigned long start, unsigned long end,
+				  unsigned long page_size_mask, pgprot_t prot);
 void kernel_physical_mapping_change(unsigned long start, unsigned long end,
 				    unsigned long page_size_mask);
 void zone_sizes_init(void);

-- 
2.50.1


