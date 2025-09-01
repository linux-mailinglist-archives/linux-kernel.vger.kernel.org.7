Return-Path: <linux-kernel+bounces-795327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A608B3F018
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1290C1A870A0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88D628002B;
	Mon,  1 Sep 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KtJaWD0O"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A627B4F5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759854; cv=none; b=HfDn0g+laT+sjyOEPYXenQzxfPk/8bchf/gtzybMnVW6lG7cVIBptHiTq37id94bmnGF2WYRyYoYUZnW84L1K2KGcLG5SILOSKCQLhwl0oMfZCCYI3iY0UHKUhonRpSV3wR4S7zurVQqUQX6fiszNHdVOVXTCHc03IAIjkqUwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759854; c=relaxed/simple;
	bh=G9fQmLCfKmFA44mJm/ujwf2i5TqVTmSI2avVaselzL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fp0c4LzC7I3UsdYjA/ZjlBJolG42Fq4nLQgOy3WwIJLiowPs7yiXjAxlgA7uYkLClp6KZVGFcgD2KTGawsxY/t4N7ZicmKLgIXIe8uwArC0G1yStzYKehjl5K2cVicXq7Y/s78E1YVqjsSprkz58CyN/+i0QpMd1vH4zkyNVHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KtJaWD0O; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3962aso160519566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759851; x=1757364651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3uoyKSyOaO3f7nxjstRVXs4aNsGaCK5BZpTMsYSqag=;
        b=KtJaWD0OBN1VVuuda+jgLk8NC0/k1xZZ3SKPBX/0KMoGr5GtEMhmcmKpwqLMVOW/MN
         vaDuMg/Wk7xrizVBHFI0Ek/Nj11ivZ62pvECahho/Fvb2Bk/uE0euUcD1A98ufdHe6VS
         0tpinaSW1SpRX15c2xZeACGeo40LFGp65K0t2xm8lnSSTvgFLsG9uDNzXJwVoY0/82uJ
         LcXtCjWeMMr+oZ0ZJwEL9zpvhSqyXeHkCnoSH52I1GX4CYUKEQecrdO2N4kd2VwnAg4Q
         Y8Gi0GHpWkq8OwIjfaFXsY5YDo0LvwvyWYKa0p+4a2LNZtiAgoxkuoGMCyeLIG5q81XG
         GUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759851; x=1757364651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3uoyKSyOaO3f7nxjstRVXs4aNsGaCK5BZpTMsYSqag=;
        b=Lj5BL4rQ7OznGB2FOXRuD1YxhcKbspYfBIo4QVT6pjSj4a/lnjlyHszfJVNpTAODCE
         M+V8gSfteCnghjzZUJH4NWOoXUlsCe7IgocPUb7rTGNwMbbPFX5k8/PLJI9Zx7soOS2U
         2OkvLB8W69FI17fEKS4+f+FAmdIou4ojEnmBJLP9C9ZDzb//T5KiPmSwa9CPcvnBGQUZ
         qJkj8od8EBfQ9KvtCjs4yrLTCOH6lbWNaWxsOfhJFJmrCTLCS5nTjiBcs6QZ6HYmq/uv
         Z/lo5shHY94R/F3NbsYINN+92hf1h2aSKVyMt8I9MZhWp7diEY2Setf3nf1fpvO9GM4g
         YEqg==
X-Forwarded-Encrypted: i=1; AJvYcCWDfCZIzmTq7h6L6KXt9patP+5xVh8AmLPm/RySd0U2m0bDUyc3TxnlXF3hbF1FUkCtXmcCIeyqbqFLmc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQf5/HXbNKW9lxgc2dxw6c3ujDkxLgDhs/Gy1rOrCAANYymjds
	oTjqK7st5aL6djuhT+LPjsEkWD30ApEjQs4WUko/ivui9F0EGwITolLpWV4JE8Jc4B4=
X-Gm-Gg: ASbGncs3LKrGyoLk3l9lqZnubq61odQD/QsvaEl9T9cfzoqB10xQGQ72c5uPIpu3SsB
	b0DoZQoAlOuhmrp0Jq0YcIvhA2g7TSO67iwFB7xC/E0uYpMnc6iP3fuXuAE1QPeHobepuTBGs/Z
	Ii/SXPPROrOzhlrzrOu2PMjRbmKWT5uw6tTodlNXSBfNAyELzrxn/g6gxcluaWLoYMUZJF/ZE6j
	EqtWZnw9dtGpe3bo0pCf8XtYHUqQA+nj3ssQVrccdIstIwwWLYER7ZzO6Oc/Udz+WZzVQywOvj7
	0hzK4ST0TKOlGiclXRgdHjEUAcQk71oepOw2yHhOD1idMbWZQGVw3kK61ZlNJSccc08pgQIds/3
	szSYZzqA/Lp4cy4hC36viVT8gjA+XP+ttHUOeXEtms0ATiH76sySlacRtSM5EXVuuAFiEu+FzJK
	g3QwbUEnd8p8wW+mArceNqNZWs60F7Tg8s
X-Google-Smtp-Source: AGHT+IHpQqCA9H+O3+CE5gTkKZKcF7k6oI5kQsi6mdSUrMDC8NBoCachyUvtoP/lhYVN+0jVOidhhg==
X-Received: by 2002:a17:907:9611:b0:afe:74a3:f78b with SMTP id a640c23a62f3a-b01d98b4c39mr886692466b.59.1756759850966;
        Mon, 01 Sep 2025 13:50:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 12/12] mm: constify highmem related functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:21 +0200
Message-ID: <20250901205021.3573313-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots of functions in mm/highmem.c do not write to the given pointers
and do not call functions that take non-const pointers and can
therefore be constified.

This includes functions like kunmap() which might be implemented in a
way that writes to the pointer (e.g. to update reference counters or
mapping fields), but currently are not.

kmap() on the other hand cannot be made const because it calls
set_page_address() which is non-const in some
architectures/configurations.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm/include/asm/highmem.h    |  6 +++---
 arch/xtensa/include/asm/highmem.h |  2 +-
 include/linux/highmem-internal.h  | 36 +++++++++++++++----------------
 include/linux/highmem.h           |  8 +++----
 mm/highmem.c                      | 10 ++++-----
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index b4b66220952d..bdb209e002a4 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -46,9 +46,9 @@ extern pte_t *pkmap_page_table;
 #endif
 
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
-extern void *kmap_high_get(struct page *page);
+extern void *kmap_high_get(const struct page *page);
 
-static inline void *arch_kmap_local_high_get(struct page *page)
+static inline void *arch_kmap_local_high_get(const struct page *page)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
 		return NULL;
@@ -57,7 +57,7 @@ static inline void *arch_kmap_local_high_get(struct page *page)
 #define arch_kmap_local_high_get arch_kmap_local_high_get
 
 #else /* ARCH_NEEDS_KMAP_HIGH_GET */
-static inline void *kmap_high_get(struct page *page)
+static inline void *kmap_high_get(const struct page *page)
 {
 	return NULL;
 }
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 34b8b620e7f1..b55235f4adac 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -29,7 +29,7 @@
 
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 #define get_pkmap_color get_pkmap_color
-static inline int get_pkmap_color(struct page *page)
+static inline int get_pkmap_color(const struct page *page)
 {
 	return DCACHE_ALIAS(page_to_phys(page));
 }
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 36053c3d6d64..0574c21ca45d 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -7,7 +7,7 @@
  */
 #ifdef CONFIG_KMAP_LOCAL
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void *__kmap_local_page_prot(const struct page *page, pgprot_t prot);
 void kunmap_local_indexed(const void *vaddr);
 void kmap_local_fork(struct task_struct *tsk);
 void __kmap_local_sched_out(void);
@@ -33,7 +33,7 @@ static inline void kmap_flush_tlb(unsigned long addr) { }
 #endif
 
 void *kmap_high(struct page *page);
-void kunmap_high(struct page *page);
+void kunmap_high(const struct page *page);
 void __kmap_flush_unused(void);
 struct page *__kmap_to_page(void *addr);
 
@@ -50,7 +50,7 @@ static inline void *kmap(struct page *page)
 	return addr;
 }
 
-static inline void kunmap(struct page *page)
+static inline void kunmap(const struct page *page)
 {
 	might_sleep();
 	if (!PageHighMem(page))
@@ -68,12 +68,12 @@ static inline void kmap_flush_unused(void)
 	__kmap_flush_unused();
 }
 
-static inline void *kmap_local_page(struct page *page)
+static inline void *kmap_local_page(const struct page *page)
 {
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
-static inline void *kmap_local_page_try_from_panic(struct page *page)
+static inline void *kmap_local_page_try_from_panic(const struct page *page)
 {
 	if (!PageHighMem(page))
 		return page_address(page);
@@ -81,13 +81,13 @@ static inline void *kmap_local_page_try_from_panic(struct page *page)
 	return NULL;
 }
 
-static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+static inline void *kmap_local_folio(const struct folio *folio, size_t offset)
 {
-	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
 	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
 }
 
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
 	return __kmap_local_page_prot(page, prot);
 }
@@ -102,7 +102,7 @@ static inline void __kunmap_local(const void *vaddr)
 	kunmap_local_indexed(vaddr);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic_prot(const struct page *page, pgprot_t prot)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
@@ -113,7 +113,7 @@ static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 	return __kmap_local_page_prot(page, prot);
 }
 
-static inline void *kmap_atomic(struct page *page)
+static inline void *kmap_atomic(const struct page *page)
 {
 	return kmap_atomic_prot(page, kmap_prot);
 }
@@ -173,32 +173,32 @@ static inline void *kmap(struct page *page)
 	return page_address(page);
 }
 
-static inline void kunmap_high(struct page *page) { }
+static inline void kunmap_high(const struct page *page) { }
 static inline void kmap_flush_unused(void) { }
 
-static inline void kunmap(struct page *page)
+static inline void kunmap(const struct page *page)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(page_address(page));
 #endif
 }
 
-static inline void *kmap_local_page(struct page *page)
+static inline void *kmap_local_page(const struct page *page)
 {
 	return page_address(page);
 }
 
-static inline void *kmap_local_page_try_from_panic(struct page *page)
+static inline void *kmap_local_page_try_from_panic(const struct page *page)
 {
 	return page_address(page);
 }
 
-static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+static inline void *kmap_local_folio(const struct folio *folio, size_t offset)
 {
 	return folio_address(folio) + offset;
 }
 
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
 	return kmap_local_page(page);
 }
@@ -215,7 +215,7 @@ static inline void __kunmap_local(const void *addr)
 #endif
 }
 
-static inline void *kmap_atomic(struct page *page)
+static inline void *kmap_atomic(const struct page *page)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
@@ -225,7 +225,7 @@ static inline void *kmap_atomic(struct page *page)
 	return page_address(page);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic_prot(const struct page *page, pgprot_t prot)
 {
 	return kmap_atomic(page);
 }
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6234f316468c..105cc4c00cc3 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -43,7 +43,7 @@ static inline void *kmap(struct page *page);
  * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
  * pages in the low memory area.
  */
-static inline void kunmap(struct page *page);
+static inline void kunmap(const struct page *page);
 
 /**
  * kmap_to_page - Get the page for a kmap'ed address
@@ -93,7 +93,7 @@ static inline void kmap_flush_unused(void);
  * disabling migration in order to keep the virtual address stable across
  * preemption. No caller of kmap_local_page() can rely on this side effect.
  */
-static inline void *kmap_local_page(struct page *page);
+static inline void *kmap_local_page(const struct page *page);
 
 /**
  * kmap_local_folio - Map a page in this folio for temporary usage
@@ -129,7 +129,7 @@ static inline void *kmap_local_page(struct page *page);
  * Context: Can be invoked from any context.
  * Return: The virtual address of @offset.
  */
-static inline void *kmap_local_folio(struct folio *folio, size_t offset);
+static inline void *kmap_local_folio(const struct folio *folio, size_t offset);
 
 /**
  * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
@@ -176,7 +176,7 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
  * kunmap_atomic(vaddr2);
  * kunmap_atomic(vaddr1);
  */
-static inline void *kmap_atomic(struct page *page);
+static inline void *kmap_atomic(const struct page *page);
 
 /* Highmem related interfaces for management code */
 static inline unsigned long nr_free_highpages(void);
diff --git a/mm/highmem.c b/mm/highmem.c
index ef3189b36cad..b5c8e4c2d5d4 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -61,7 +61,7 @@ static inline int kmap_local_calc_idx(int idx)
 /*
  * Determine color of virtual address where the page should be mapped.
  */
-static inline unsigned int get_pkmap_color(struct page *page)
+static inline unsigned int get_pkmap_color(const struct page *page)
 {
 	return 0;
 }
@@ -334,7 +334,7 @@ EXPORT_SYMBOL(kmap_high);
  *
  * This can be called from any context.
  */
-void *kmap_high_get(struct page *page)
+void *kmap_high_get(const struct page *page)
 {
 	unsigned long vaddr, flags;
 
@@ -356,7 +356,7 @@ void *kmap_high_get(struct page *page)
  * If ARCH_NEEDS_KMAP_HIGH_GET is not defined then this may be called
  * only from user context.
  */
-void kunmap_high(struct page *page)
+void kunmap_high(const struct page *page)
 {
 	unsigned long vaddr;
 	unsigned long nr;
@@ -508,7 +508,7 @@ static inline void kmap_local_idx_pop(void)
 #endif
 
 #ifndef arch_kmap_local_high_get
-static inline void *arch_kmap_local_high_get(struct page *page)
+static inline void *arch_kmap_local_high_get(const struct page *page)
 {
 	return NULL;
 }
@@ -572,7 +572,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 }
 EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
 
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
+void *__kmap_local_page_prot(const struct page *page, pgprot_t prot)
 {
 	void *kmap;
 
-- 
2.47.2


