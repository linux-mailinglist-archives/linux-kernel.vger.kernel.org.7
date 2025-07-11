Return-Path: <linux-kernel+bounces-727942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB9B021A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F34547004
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E32EF2BC;
	Fri, 11 Jul 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b="SxL6YVZV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17182EF2B2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251078; cv=none; b=rQf0JQ6gr0Wad2yrgXORDIh6awMfUdVMj075nzL2buG4aQWGFszMrXE3sk5N7JOBwtVzhlQImQjmxnucePSL9a69VP61e5w6mfLYrPyxqvBZV9I0dHeePIQ24lxnVXPVFaq4ffBtsYw9eN5UfGgjxs+c41r3OxFxQon1qu+DRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251078; c=relaxed/simple;
	bh=7QQTaD4RTXmPFB/5DuqaUm+V9mjhhB9g7+BbMhqjxGU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RvlQPsiVPYhCCm34C7atvqgf9GmDF+2NePKQxf035gNVe81tXmMzQVJdws7iTtvVGNFfPTVYcxbCYU2fpb9WULeLlzJZJaibIkNH9TG1lP6aYrpv1BXq1ZXQDEg4MaabJWm//qSEQ131gGwKCQE+xm1Iha3brUIVNCrlmqjHkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech; spf=pass smtp.mailfrom=neon.tech; dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b=SxL6YVZV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neon.tech
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455fddfa2c3so434645e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neon.tech; s=google; t=1752251075; x=1752855875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VmqWzINlR7ueURt8ykpnYBNe7vdszeCG5zNyAg94yWQ=;
        b=SxL6YVZVYF/aHaSzQKB51ZPUknQfB3I6oMhWKgF/JR/A2Kwr8QU5pS15pUu9rbYI1G
         mGnCait0peB2yWNTDn2Rmik5K6xN4peOrvluvM64lXGRId96zh14uiHfkODg/SxLbHZp
         ux8+nJC4AVSPv8CZ8mci6MKGWmlyr9+39x+yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251075; x=1752855875;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmqWzINlR7ueURt8ykpnYBNe7vdszeCG5zNyAg94yWQ=;
        b=C70cIXZtdd/26pV+u07bHbLoObMtxj5DV6P/D5pi7SN/2XLRPNVEseL9gWZEZDu1bN
         xv4Es/J0IC3vzuPpey2mxz3o9HvR8lQYSOyXD21afRZbdBDMHe6/WzSqYsIGIWanDMuY
         4h1rRFN8mJlTn3X/gdnSjUWgo9Q57yJ9yQWo6/DAXoH/Qfs3bN0NIyz1c4a4evg52UIe
         0iMglaGQGf3uMeCKvGkgPJZqSmvVosdCjar4kAYdoCuD63B0MS/Yk04oC4dku60ZCnMr
         pO5soGFsJTPD1fH+B5gd6StZt7nMIcDZWRerwL8w19+b2FTmM4Iscf+RXnBX80ICV64a
         ELfg==
X-Gm-Message-State: AOJu0YzpkAt53VtY/sVxygRMoDsQMj71PNCJD9nZIhavd+wxA/6h+4+c
	HIWdqZ3gIcwmMB5+7b6WAX/5nBG9q/9hxFVuC8acdvJ/1yXlSnlx+55xucgZu4EWb9zP/5wGrX/
	EPx03zn0=
X-Gm-Gg: ASbGnctHBDXdqsqupCcGvAwweRTOqrkiESrX2tgJccXkN1KTK01skswv7F0F3sgzkt8
	ZZhRwZHx/P3LO/4ErNKUajXRkrecxonQGN4e1b+S0kDdmNKpBe1IZ4tivZPPs/X/pZIhPR7XKoB
	rc9y8OibHe9ECZ03kZ3ary5XRNt8eFarCu//FTUQ56HCgqQSq8n1N/xpxpeeeBcdWNjIR0LDCDO
	Sx8z1PmF0V532zzuscbMAwgvunh2AsOveLxr88NN1rVsQgSGvRMEevPgCprVYjZtatD5HJHw1vW
	6L+4JPQ4H5xbx79jx/xBMNeAWk7OHWyhN9yT9HKBQlvD+2Qn6DbKjdV3mLgEGLIeZqwKkBTQQku
	QoMoPAcfxUXW7/7Q4oAZ9U7TkHPH81/4Xq9Y=
X-Google-Smtp-Source: AGHT+IHU9h0oitDhYyJ5Jd3VSokKs4uRGWzwtm/i43M875ekjrtkNtDt0ymoLk+jcdr65MBB1vNhbw==
X-Received: by 2002:a05:600c:3b03:b0:454:b97b:cabb with SMTP id 5b1f17b1804b1-454ec283b2cmr34823395e9.28.1752251074495;
        Fri, 11 Jul 2025 09:24:34 -0700 (PDT)
Received: from [192.168.86.142] ([90.253.47.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm4964637f8f.39.2025.07.11.09.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:24:34 -0700 (PDT)
Message-ID: <05d016e1-2530-4cab-b5b2-41e8aa547a4b@neon.tech>
Date: Fri, 11 Jul 2025 17:24:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 1/4] x86/mm: Update mapped addresses in
 phys_{pmd,pud}_init()
From: Em Sharnoff <sharnoff@neon.tech>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 Oleg Vasilev <oleg@neon.tech>, Arthur Petukhovsky <arthur@neon.tech>,
 Stefan Radig <stefan@neon.tech>, Misha Sakhnov <misha@neon.tech>
References: <4fe0984f-74dc-45fe-b2b6-bdd81ec15bac@neon.tech>
Content-Language: en-US
In-Reply-To: <4fe0984f-74dc-45fe-b2b6-bdd81ec15bac@neon.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently kernel_physical_mapping_init() and its dependents return the
last physical address mapped ('paddr_last'). This makes it harder to
cleanly handle allocation errors in those functions.

'paddr_last' is used to update 'pfn_mapped'/'max_pfn_mapped', so:

1. Introduce add_paddr_range_mapped() to do the update, translating from
   physical addresses to pfns
2. Call add_paddr_range_mapped() in phys_pud_init() where 'paddr_last'
   would otherwise be updated due to 1Gi pages.
   - Note: this includes places where we set 'paddr_last = paddr_next',
     as was added in 20167d3421a0 ("x86-64: Fix accounting in
     kernel_physical_mapping_init()")

add_paddr_range_mapped() is probably too expensive to be called every
time a page is updated, so instead, phys_pte_init() continues to return
'paddr_last', and phys_pmd_init() calls add_paddr_range_mapped() only at
the end of the loop (should mean it's called every 1Gi).

Signed-off-by: Em Sharnoff <sharnoff@neon.tech>
---
Changelog:
- v4: Add this patch
---
 arch/x86/include/asm/pgtable.h |  3 +-
 arch/x86/mm/init.c             | 23 +++++----
 arch/x86/mm/init_32.c          |  6 ++-
 arch/x86/mm/init_64.c          | 88 +++++++++++++++++-----------------
 arch/x86/mm/mm_internal.h      | 13 +++--
 5 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 97954c936c54..5d71cb192c57 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1224,8 +1224,7 @@ extern int direct_gbpages;
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 void __init poking_init(void);
-unsigned long init_memory_mapping(unsigned long start,
-				  unsigned long end, pgprot_t prot);
+void init_memory_mapping(unsigned long start, unsigned long end, pgprot_t prot);
 
 #ifdef CONFIG_X86_64
 extern pgd_t trampoline_pgd_entry;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..e87466489c66 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -526,16 +526,24 @@ bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn)
 	return false;
 }
 
+/*
+ * Update max_pfn_mapped and range_pfn_mapped with the range of physical
+ * addresses mapped. The range may overlap with previous calls to this function.
+ */
+void add_paddr_range_mapped(unsigned long start_paddr, unsigned long end_paddr)
+{
+	add_pfn_range_mapped(start_paddr >> PAGE_SHIFT, end_paddr >> PAGE_SHIFT);
+}
+
 /*
  * Setup the direct mapping of the physical memory at PAGE_OFFSET.
  * This runs before bootmem is initialized and gets pages directly from
  * the physical memory. To access them they are temporarily mapped.
  */
-unsigned long __ref init_memory_mapping(unsigned long start,
-					unsigned long end, pgprot_t prot)
+void __ref init_memory_mapping(unsigned long start,
+			       unsigned long end, pgprot_t prot)
 {
 	struct map_range mr[NR_RANGE_MR];
-	unsigned long ret = 0;
 	int nr_range, i;
 
 	pr_debug("init_memory_mapping: [mem %#010lx-%#010lx]\n",
@@ -545,13 +553,10 @@ unsigned long __ref init_memory_mapping(unsigned long start,
 	nr_range = split_mem_range(mr, 0, start, end);
 
 	for (i = 0; i < nr_range; i++)
-		ret = kernel_physical_mapping_init(mr[i].start, mr[i].end,
-						   mr[i].page_size_mask,
-						   prot);
+		kernel_physical_mapping_init(mr[i].start, mr[i].end,
+					     mr[i].page_size_mask, prot);
 
-	add_pfn_range_mapped(start >> PAGE_SHIFT, ret >> PAGE_SHIFT);
-
-	return ret >> PAGE_SHIFT;
+	return;
 }
 
 /*
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 607d6a2e66e2..a9a16d3d0eb2 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -246,7 +246,7 @@ static inline int is_x86_32_kernel_text(unsigned long addr)
  * of max_low_pfn pages, by creating page tables starting from address
  * PAGE_OFFSET:
  */
-unsigned long __init
+void __init
 kernel_physical_mapping_init(unsigned long start,
 			     unsigned long end,
 			     unsigned long page_size_mask,
@@ -383,7 +383,9 @@ kernel_physical_mapping_init(unsigned long start,
 		mapping_iter = 2;
 		goto repeat;
 	}
-	return last_map_addr;
+
+	add_paddr_range_mapped(start, last_map_addr);
+	return;
 }
 
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ee66fae9ebcc..f0dc4a0e8cde 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -503,13 +503,13 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
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
+	unsigned long paddr_first = paddr;
 	unsigned long paddr_last = paddr_end;
 
 	int i = pmd_index(paddr);
@@ -580,21 +580,25 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	update_page_count(PG_LEVEL_2M, pages);
-	return paddr_last;
+	/*
+	 * In case of recovery from previous state, add_paddr_range_mapped() may
+	 * be called with an overlapping range from previous operations.
+	 * It is idempotent, so this is ok.
+	 */
+	add_paddr_range_mapped(paddr_first, paddr_last);
+	return;
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
 
@@ -620,10 +624,8 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
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
@@ -641,7 +643,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 			if (page_size_mask & (1 << PG_LEVEL_1G)) {
 				if (!after_bootmem)
 					pages++;
-				paddr_last = paddr_next;
+				add_paddr_range_mapped(paddr, paddr_next);
 				continue;
 			}
 			prot = pte_pgprot(pte_clrhuge(*(pte_t *)pud));
@@ -654,13 +656,13 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 				     pfn_pud(paddr >> PAGE_SHIFT, prot_sethuge(prot)),
 				     init);
 			spin_unlock(&init_mm.page_table_lock);
-			paddr_last = paddr_next;
+			add_paddr_range_mapped(paddr, paddr_next);
 			continue;
 		}
 
 		pmd = alloc_low_page();
-		paddr_last = phys_pmd_init(pmd, paddr, paddr_end,
-					   page_size_mask, prot, init);
+		phys_pmd_init(pmd, paddr, paddr_end,
+			      page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		pud_populate_init(&init_mm, pud, pmd, init);
@@ -669,22 +671,23 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 
 	update_page_count(PG_LEVEL_1G, pages);
 
-	return paddr_last;
+	return;
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
@@ -706,33 +709,32 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 
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
 
-	return paddr_last;
+	return;
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
@@ -745,16 +747,14 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
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
@@ -770,7 +770,7 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 	if (pgd_changed)
 		sync_global_pgds(vaddr_start, vaddr_end - 1);
 
-	return paddr_last;
+	return;
 }
 
 
@@ -778,15 +778,15 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
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
@@ -795,14 +795,14 @@ kernel_physical_mapping_init(unsigned long paddr_start,
  * when updating the mapping. The caller is responsible to flush the TLBs after
  * the function returns.
  */
-unsigned long __meminit
+void __meminit
 kernel_physical_mapping_change(unsigned long paddr_start,
 			       unsigned long paddr_end,
 			       unsigned long page_size_mask)
 {
-	return __kernel_physical_mapping_init(paddr_start, paddr_end,
-					      page_size_mask, PAGE_KERNEL,
-					      false);
+	__kernel_physical_mapping_init(paddr_start, paddr_end,
+				       page_size_mask, PAGE_KERNEL,
+				       false);
 }
 
 #ifndef CONFIG_NUMA
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 097aadc250f7..5b873191c3c9 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -10,13 +10,12 @@ static inline void *alloc_low_page(void)
 
 void early_ioremap_page_table_range_init(void);
 
-unsigned long kernel_physical_mapping_init(unsigned long start,
-					     unsigned long end,
-					     unsigned long page_size_mask,
-					     pgprot_t prot);
-unsigned long kernel_physical_mapping_change(unsigned long start,
-					     unsigned long end,
-					     unsigned long page_size_mask);
+void add_paddr_range_mapped(unsigned long start_paddr, unsigned long end_paddr);
+
+void kernel_physical_mapping_init(unsigned long start, unsigned long end,
+								  unsigned long page_size_mask, pgprot_t prot);
+void kernel_physical_mapping_change(unsigned long start, unsigned long end,
+								    unsigned long page_size_mask);
 void zone_sizes_init(void);
 
 extern int after_bootmem;
-- 
2.39.5


