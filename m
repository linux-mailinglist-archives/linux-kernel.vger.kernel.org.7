Return-Path: <linux-kernel+bounces-727943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFEBB021A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C734516F4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3742EF2B8;
	Fri, 11 Jul 2025 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b="HayCoSSR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760711CDFD5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251114; cv=none; b=iZhqXHIYxDG5k5+DWF8S004G/5IaP1s0dLdPkSvwTfMLotEdu88hAwjYGgbgbbuN1ISUNXsdogLmDyNKvBejNTanKxuVzGzDI/QU81J/fsCcXqdfc26MwLab86HGcO9nFvO/XQmpjzOy6KxEdCO5BeK5Uo6v6NiszihnnL8BE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251114; c=relaxed/simple;
	bh=WgwVpF3siYc15ORe7X4O+uaOQ/wdq4nu6q7AaNNsnN8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VLLDD9BD9W4xGp0TRJ6EsRJMuXwdPP94YHdmeurIwbVOw+FbdSX8scAEFsxayyMifKdXddfZ1NegHvezW3dHbOd76jjSFPVsEKqlYZDcep0/A8u3K+IDWTfg+159q9p2ynu/iV/t7enSmjVRByo9pquBTtNlRnmAaxbzMl2pzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech; spf=pass smtp.mailfrom=neon.tech; dkim=pass (1024-bit key) header.d=neon.tech header.i=@neon.tech header.b=HayCoSSR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neon.tech
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso16500405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neon.tech; s=google; t=1752251109; x=1752855909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vPw6Gd9zta7oYi5tyBx5JJzhglTf7Q/TnhfpcbeN++E=;
        b=HayCoSSRrK9v5ire6SY2nDpeMxiexIPrlI5KWxj3BqZPWiO+6RkoujB4TipIyNQvQe
         xoLGEhJNzJR9S8gXNYdpt1uGQ5hzYc2QNWR6yJmS83uFtWYcUvoHEChMIAVkZFca/bEs
         HkXkD+gX6MF0qrlPwuKxUpQxjA6Ndf4uvAG7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251109; x=1752855909;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPw6Gd9zta7oYi5tyBx5JJzhglTf7Q/TnhfpcbeN++E=;
        b=jR/br9Ba6shcoJ8TZpeH4oLqBovCaQCo+O6EZAHtNNq0YNKhGUUgIcQmUC/l0iUFa9
         fYFphmeRmUMKIW5O1ebfVYGX7YzZOuzFekVJLWh3TO1lWaSx+U/kwJwTyo35NbSJYDAi
         pjeTEf/JzNxJ2VCf34JYAYphLXJ6N7DIKFwyXEa3goQj+L7/9/L5gSwGlhlLYUEj02Sa
         rm/CzunpJiRnMzm22SsP3F+Dk2YuRIML0pYdt0HZXFL/yG+6v9bgDJMsawvwJYy+gQSZ
         wdfDMUXsqmv+gSCfpGwSoimPtJsdiHgI9Nju5aLvcI/oz0EmCasATOMJh10DXiLG3X1V
         ZorQ==
X-Gm-Message-State: AOJu0YyhAzhxZNrlWSbRkkUHxfg/tU60ekvD+WO7p8Ha2d2v2+xVLUHB
	vFQQyWci1a4NBl5qIF5dHjhv29btBnqBlX86I1DW5kap8Bc0b9r8e8V60JX1e+xfgep2UfYcJVp
	BXg3zebQ=
X-Gm-Gg: ASbGnctroOoGjXQzeXx9AlX1vVTyKs45fbsgSLbFntseisbxjqnYGD4Ei1QoIn2X/y2
	KOsuF4QpxqaXNfyrV+zZwQippTvcVaGdF2pDHR3V3DNaQR2ghc5EVQRs/XSaFWikle++rw6QvuM
	IMw0QO+49FiZWlHho2eF6VJed16IzbvUd8mCB8n6muXtkEJP4s1+JT1D6s2k2X4yvY4Dqz+vw24
	ywOJw13TArNLfxcZHS0xERNQsz2/y0F0q7Uba6W3yndsSaDObnL9xn3OtiMpMTBV+lfEsVLOjiF
	k3Hb69WEp206oiGouNCiFdOPEyKh/DT4NDG3b3NHBslSqVBrOUa7dsxCGHrf+ps2RdRsBxcoNMN
	Jh7J3KA6wd5rGR6GgwLpW83NH
X-Google-Smtp-Source: AGHT+IEezts35ERD2mOnoR4eSve5zUvt8FCWsGXblWEc/120s3CiCcl600/E1qrGsHQay4GIBfA5gQ==
X-Received: by 2002:a05:600c:1c1f:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-454ec16a5b1mr43392855e9.10.1752251109203;
        Fri, 11 Jul 2025 09:25:09 -0700 (PDT)
Received: from [192.168.86.142] ([90.253.47.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm4966000f8f.39.2025.07.11.09.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 09:25:08 -0700 (PDT)
Message-ID: <42995ddc-01f6-4ff4-92e4-b4d1e9c3ea42@neon.tech>
Date: Fri, 11 Jul 2025 17:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/4] x86/mm: Allow error returns from phys_*_init()
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

Preparation for returning errors when alloc_low_page() fails.

phys_pte_init() is excluded because it can't fail, and it's useful for
it to return 'paddr_last' instead.

This patch depends on the previous patch ("x86/mm: Update mapped
addresses in phys_{pmd,pud}_init()").

Signed-off-by: Em Sharnoff <sharnoff@neon.tech>
---
Changleog:
- v2: Switch from special-casing zero value to using ERR_PTR()
- v3: Fix -Wint-conversion errors
- v4: Switch return type to int, split alloc handling into separate patch.
---
 arch/x86/include/asm/pgtable.h |   2 +-
 arch/x86/mm/init.c             |  14 +++--
 arch/x86/mm/init_32.c          |   4 +-
 arch/x86/mm/init_64.c          | 100 ++++++++++++++++++++++-----------
 arch/x86/mm/mem_encrypt_amd.c  |   8 ++-
 arch/x86/mm/mm_internal.h      |   8 +--
 6 files changed, 87 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5d71cb192c57..f964f52327de 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1224,7 +1224,7 @@ extern int direct_gbpages;
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 void __init poking_init(void);
-void init_memory_mapping(unsigned long start, unsigned long end, pgprot_t prot);
+int init_memory_mapping(unsigned long start, unsigned long end, pgprot_t prot);
 
 #ifdef CONFIG_X86_64
 extern pgd_t trampoline_pgd_entry;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index e87466489c66..474a7294016c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -540,11 +540,12 @@ void add_paddr_range_mapped(unsigned long start_paddr, unsigned long end_paddr)
  * This runs before bootmem is initialized and gets pages directly from
  * the physical memory. To access them they are temporarily mapped.
  */
-void __ref init_memory_mapping(unsigned long start,
+int __ref init_memory_mapping(unsigned long start,
 			       unsigned long end, pgprot_t prot)
 {
 	struct map_range mr[NR_RANGE_MR];
 	int nr_range, i;
+	int ret;
 
 	pr_debug("init_memory_mapping: [mem %#010lx-%#010lx]\n",
 	       start, end - 1);
@@ -552,11 +553,14 @@ void __ref init_memory_mapping(unsigned long start,
 	memset(mr, 0, sizeof(mr));
 	nr_range = split_mem_range(mr, 0, start, end);
 
-	for (i = 0; i < nr_range; i++)
-		kernel_physical_mapping_init(mr[i].start, mr[i].end,
-					     mr[i].page_size_mask, prot);
+	for (i = 0; i < nr_range; i++) {
+		ret = kernel_physical_mapping_init(mr[i].start, mr[i].end,
+						   mr[i].page_size_mask, prot);
+		if (ret)
+			return ret;
+	}
 
-	return;
+	return 0;
 }
 
 /*
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index a9a16d3d0eb2..6e13685d7ced 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -246,7 +246,7 @@ static inline int is_x86_32_kernel_text(unsigned long addr)
  * of max_low_pfn pages, by creating page tables starting from address
  * PAGE_OFFSET:
  */
-void __init
+int __init
 kernel_physical_mapping_init(unsigned long start,
 			     unsigned long end,
 			     unsigned long page_size_mask,
@@ -385,7 +385,7 @@ kernel_physical_mapping_init(unsigned long start,
 	}
 
 	add_paddr_range_mapped(start, last_map_addr);
-	return;
+	return 0;
 }
 
 #ifdef CONFIG_HIGHMEM
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index f0dc4a0e8cde..ca71eaec1db5 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -504,7 +504,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
  * Create PMD level page table mapping for physical addresses. The virtual
  * and physical address have to be aligned at this level.
  */
-static void __meminit
+static int __meminit
 phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, pgprot_t prot, bool init)
 {
@@ -586,7 +586,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 	 * It is idempotent, so this is ok.
 	 */
 	add_paddr_range_mapped(paddr_first, paddr_last);
-	return;
+	return 0;
 }
 
 /*
@@ -594,12 +594,14 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
  * and physical address do not have to be aligned at this level. KASLR can
  * randomize virtual addresses up to this level.
  */
-static void __meminit
+static int __meminit
 phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, pgprot_t _prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long vaddr = (unsigned long)__va(paddr);
+	int ret;
+
 	int i = pud_index(vaddr);
 
 	for (; i < PTRS_PER_PUD; i++, paddr = paddr_next) {
@@ -624,8 +626,10 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		if (!pud_none(*pud)) {
 			if (!pud_leaf(*pud)) {
 				pmd = pmd_offset(pud, 0);
-				phys_pmd_init(pmd, paddr, paddr_end,
-					      page_size_mask, prot, init);
+				ret = phys_pmd_init(pmd, paddr, paddr_end,
+						    page_size_mask, prot, init);
+				if (ret)
+					return ret;
 				continue;
 			}
 			/*
@@ -661,33 +665,39 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		}
 
 		pmd = alloc_low_page();
-		phys_pmd_init(pmd, paddr, paddr_end,
-			      page_size_mask, prot, init);
+		ret = phys_pmd_init(pmd, paddr, paddr_end,
+				    page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		pud_populate_init(&init_mm, pud, pmd, init);
 		spin_unlock(&init_mm.page_table_lock);
+
+		/*
+		 * Bail only after updating pud to keep progress from pmd across
+		 * retries.
+		 */
+		if (ret)
+			return ret;
 	}
 
 	update_page_count(PG_LEVEL_1G, pages);
 
-	return;
+	return 0;
 }
 
-static void __meminit
+static int __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, pgprot_t prot, bool init)
 {
 	unsigned long vaddr, vaddr_end, vaddr_next, paddr_next;
+	int ret;
 
 	vaddr = (unsigned long)__va(paddr);
 	vaddr_end = (unsigned long)__va(paddr_end);
 
-	if (!pgtable_l5_enabled()) {
-		phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
-			      page_size_mask, prot, init);
-		return;
-	}
+	if (!pgtable_l5_enabled())
+		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
+				     page_size_mask, prot, init);
 
 	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
 		p4d_t *p4d = p4d_page + p4d_index(vaddr);
@@ -709,24 +719,33 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 
 		if (!p4d_none(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			phys_pud_init(pud, paddr, __pa(vaddr_end),
-				      page_size_mask, prot, init);
+			ret = phys_pud_init(pud, paddr, __pa(vaddr_end),
+					    page_size_mask, prot, init);
+			if (ret)
+				return ret;
 			continue;
 		}
 
 		pud = alloc_low_page();
-		phys_pud_init(pud, paddr, __pa(vaddr_end),
-			      page_size_mask, prot, init);
+		ret = phys_pud_init(pud, paddr, __pa(vaddr_end),
+				    page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		p4d_populate_init(&init_mm, p4d, pud, init);
 		spin_unlock(&init_mm.page_table_lock);
+
+		/*
+		 * Bail only after updating p4d to keep progress from pud across
+		 * retries.
+		 */
+		if (ret)
+			return ret;
 	}
 
-	return;
+	return 0;
 }
 
-static void __meminit
+static int __meminit
 __kernel_physical_mapping_init(unsigned long paddr_start,
 			       unsigned long paddr_end,
 			       unsigned long page_size_mask,
@@ -734,6 +753,7 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 {
 	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next;
+	int ret;
 
 	vaddr = (unsigned long)__va(paddr_start);
 	vaddr_end = (unsigned long)__va(paddr_end);
@@ -747,14 +767,16 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
 		if (pgd_val(*pgd)) {
 			p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-			phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
-				      page_size_mask, prot, init);
+			ret = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
+					    page_size_mask, prot, init);
+			if (ret)
+				return ret;
 			continue;
 		}
 
 		p4d = alloc_low_page();
-		phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
-			      page_size_mask, prot, init);
+		ret = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
+				    page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
@@ -762,15 +784,22 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 		else
 			p4d_populate_init(&init_mm, p4d_offset(pgd, vaddr),
 					  (pud_t *) p4d, init);
-
 		spin_unlock(&init_mm.page_table_lock);
+
+		/*
+		 * Bail only after updating pgd/p4d to keep progress from p4d
+		 * across retries.
+		 */
+		if (ret)
+			return ret;
+
 		pgd_changed = true;
 	}
 
 	if (pgd_changed)
 		sync_global_pgds(vaddr_start, vaddr_end - 1);
 
-	return;
+	return 0;
 }
 
 
@@ -780,13 +809,13 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
  * The virtual and physical addresses have to be aligned on PMD level
  * down.
  */
-void __meminit
+int __meminit
 kernel_physical_mapping_init(unsigned long paddr_start,
 			     unsigned long paddr_end,
 			     unsigned long page_size_mask, pgprot_t prot)
 {
-	__kernel_physical_mapping_init(paddr_start, paddr_end,
-				       page_size_mask, prot, true);
+	return __kernel_physical_mapping_init(paddr_start, paddr_end,
+					      page_size_mask, prot, true);
 }
 
 /*
@@ -795,14 +824,14 @@ kernel_physical_mapping_init(unsigned long paddr_start,
  * when updating the mapping. The caller is responsible to flush the TLBs after
  * the function returns.
  */
-void __meminit
+int __meminit
 kernel_physical_mapping_change(unsigned long paddr_start,
 			       unsigned long paddr_end,
 			       unsigned long page_size_mask)
 {
-	__kernel_physical_mapping_init(paddr_start, paddr_end,
-				       page_size_mask, PAGE_KERNEL,
-				       false);
+	return __kernel_physical_mapping_init(paddr_start, paddr_end,
+					      page_size_mask, PAGE_KERNEL,
+					      false);
 }
 
 #ifndef CONFIG_NUMA
@@ -984,8 +1013,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int ret;
 
-	init_memory_mapping(start, start + size, params->pgprot);
+	ret = init_memory_mapping(start, start + size, params->pgprot);
+	if (ret)
+		return ret;
 
 	return add_pages(nid, start_pfn, nr_pages, params);
 }
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index faf3a13fb6ba..15174940d218 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -446,9 +446,11 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 		 * kernel_physical_mapping_change() does not flush the TLBs, so
 		 * a TLB flush is required after we exit from the for loop.
 		 */
-		kernel_physical_mapping_change(__pa(vaddr & pmask),
-					       __pa((vaddr_end & pmask) + psize),
-					       split_page_size_mask);
+		ret = kernel_physical_mapping_change(__pa(vaddr & pmask),
+						     __pa((vaddr_end & pmask) + psize),
+						     split_page_size_mask);
+		if (ret)
+			return ret;
 	}
 
 	ret = 0;
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 5b873191c3c9..7f948d5377f0 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -12,10 +12,10 @@ void early_ioremap_page_table_range_init(void);
 
 void add_paddr_range_mapped(unsigned long start_paddr, unsigned long end_paddr);
 
-void kernel_physical_mapping_init(unsigned long start, unsigned long end,
-								  unsigned long page_size_mask, pgprot_t prot);
-void kernel_physical_mapping_change(unsigned long start, unsigned long end,
-								    unsigned long page_size_mask);
+int kernel_physical_mapping_init(unsigned long start, unsigned long end,
+								 unsigned long page_size_mask, pgprot_t prot);
+int kernel_physical_mapping_change(unsigned long start, unsigned long end,
+								   unsigned long page_size_mask);
 void zone_sizes_init(void);
 
 extern int after_bootmem;
-- 
2.39.5


