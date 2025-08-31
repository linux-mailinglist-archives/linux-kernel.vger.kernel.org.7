Return-Path: <linux-kernel+bounces-793306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6426B3D1B0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607B6174E57
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32082262FCD;
	Sun, 31 Aug 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="X2/5PzJw"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06A125A328
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633191; cv=none; b=AQ35siyb37WpufCZ+RKhU0UClp/AVfXz0CbZNe/UV9Y0zaiV6t7C424CgX5ZkDJ/wW0CL3pvHXr/kmaMiVXXxqrBKZeJnkG5qzHtDc/WG/xxJxSVB1GM7O5NoE4ITv3UQUNwW6kVElIyJuMhjsKGXNcBTiozCY9FLwnulPbL1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633191; c=relaxed/simple;
	bh=CBcT9NVxAck5kwy48ZHHybF8PPGjkQNkdwo1+D4N+d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1NXGVd8eNaVMmsg+TwqfrAamg5MjKpu9o/jdtOW53DL1YuAdKB09V4pvBjb/OoT9a063mL8MwExHOP2hvQgTX5W3Ga/m4kRDPLjQxMuJ31WQK6KwX6+ynArIhCw7oJPvtAI2LcDbmlHk/OD9krh6u6h+bcCKoQ9PAEueDQmRxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=X2/5PzJw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0411b83aafso96915066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633187; x=1757237987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmXy5ybFdCA4kdt6JbWaWujSYRHDeDjbcsjL0sLonTs=;
        b=X2/5PzJwBG/udZ3orJzTvK/fhwqFmbvCWv4VxBpunkKxD8szq32XfM/uOVPxya9QMV
         3IQZMcK3PN2hre3k3tY7rvRquL/pI1r54K8R69DaAtH4P5KQmXp2ZLIgqsE30Twi9S1y
         FTrCYUpMoxGTBU94hessbCh8UqVfh21saiThqrGKL1rFHp4rHGr8TkSY4qRHGB+gvNcg
         xaeSqEUjQ/WWZnJXQAPxOk3vTzd5N5Rk9mGYqrQ6/A0WNELzSWr1FJZz+2cdP+oKEqP2
         tQf0COl0MURAea5A3w4nHOb2WvH7A6Q8auTkyg4AjOFdstO1UmU95kmkSn6TCiYE6rMn
         CgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633187; x=1757237987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmXy5ybFdCA4kdt6JbWaWujSYRHDeDjbcsjL0sLonTs=;
        b=ElpL8jQNcPokZ2vMvxAevBu0F1J/H9xuxQXnp7sGcey7VHgpBHOxDzo7DJAKodby/x
         vnI9egMbbyHXi55WR7VwuxHKz1TqSCR7SGM3QLku/tirIaR7VmsffjID9bgVzVWwl7B9
         Sz6rVZYff+C/rudyGYDm6vkwfscASmdL6tMhykOoYSpspj/EOkhD6ySDB1F5qKkd9GC4
         zzZqJjXZ3JlHfdMnN6/FaUxz6bliIdNLKs9Pa8neMWiqR8kObCAYTlf+63TJH0WnyDrs
         X+MnAXDOF5EwkzM5pGpexv3iGeoCjjQ0029ASy7naA3941BfVpZ4bfcDwSUmd8zwBTDI
         ohPg==
X-Forwarded-Encrypted: i=1; AJvYcCXA4Zw63FyMsk4by8Jm2FceF65U5SRTxVWHN6FDt9oVMukhzyZqnac0qAAuX9XlLvihbATLNN2umyVtf8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKF/auOyJPaRnUzl8iSWPtwETpMdzZGwVCQLuRe3nmhqMdQL5
	/hc2UE14cQfIoFNjhno5FTzRSqCg1yEp0Z63yThIVTQMM9YZ0IGxg2uZdlvb4cOgQOQXbXr9N/2
	LOnOu
X-Gm-Gg: ASbGnctMl5Fh8CkctLPVv2cPLUwYyLb2OXPkfQEtX9PqosH+d/LZ9yc7maMLbwHr2DJ
	qvfHJzCNF2VQUTM1DchE0o4SC3pUGoseyBZ0GS2anF7cO+2cudRWseDfF5GNnUWG0kp7/CfISiR
	0iks++ErClQk8DfMyA86CtZSoZxYVYmEu9TWUPz37XCwPrOj5v5r5IObKi6D3KjHpF/7vet6OPF
	uvcWFccLa42rFfGzXFx1Df8F+onUT299FK+yLJVrdmp+bCpE4faggjuQr72L6PL/7QTjahW4hmo
	+Ydxwegru4CM12ktZzApJ6xFMdW94l2oMP32XHh4muLiQkeTkjwbErHNDkaY1+qlpceAQSdBCN1
	HYjjfmLaoA4yaCdIf/QuDLblqXM0WA9PCa7dUOR/0EL2OM3nG8DjmNlM1FsbzcucMIir7PpLafo
	/ZZMviJYyTZAOGYGG8wq9OkAc6LiF0IlND
X-Google-Smtp-Source: AGHT+IERIAMXcuEhmV/TwmDymKQpTMyBeNphJ2qsS8K+XRC4iMgWIUN47HEu4qF13cHkWJRM5Gm9Lw==
X-Received: by 2002:a17:906:d155:b0:b04:b2d:cabf with SMTP id a640c23a62f3a-b040b2dcd9fmr282124466b.39.1756633187141;
        Sun, 31 Aug 2025 02:39:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:46 -0700 (PDT)
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
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 12/12] mm/highmem: add `const` to lots of pointer parameters
Date: Sun, 31 Aug 2025 11:39:18 +0200
Message-ID: <20250831093918.2815332-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm/include/asm/highmem.h    |  6 ++---
 arch/xtensa/include/asm/highmem.h |  2 +-
 include/linux/highmem-internal.h  | 38 +++++++++++++++++--------------
 include/linux/highmem.h           |  8 +++----
 mm/highmem.c                      | 10 ++++----
 5 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index b4b66220952d..023be74298f3 100644
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
+static inline void *kmap_high_get(const struct page *const page)
 {
 	return NULL;
 }
diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
index 34b8b620e7f1..473b622b863b 100644
--- a/arch/xtensa/include/asm/highmem.h
+++ b/arch/xtensa/include/asm/highmem.h
@@ -29,7 +29,7 @@
 
 #if DCACHE_WAY_SIZE > PAGE_SIZE
 #define get_pkmap_color get_pkmap_color
-static inline int get_pkmap_color(struct page *page)
+static inline int get_pkmap_color(const struct page *const page)
 {
 	return DCACHE_ALIAS(page_to_phys(page));
 }
diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 36053c3d6d64..ca2ba47c14e0 100644
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
+static inline void kunmap(const struct page *const page)
 {
 	might_sleep();
 	if (!PageHighMem(page))
@@ -68,12 +68,12 @@ static inline void kmap_flush_unused(void)
 	__kmap_flush_unused();
 }
 
-static inline void *kmap_local_page(struct page *page)
+static inline void *kmap_local_page(const struct page *const page)
 {
 	return __kmap_local_page_prot(page, kmap_prot);
 }
 
-static inline void *kmap_local_page_try_from_panic(struct page *page)
+static inline void *kmap_local_page_try_from_panic(const struct page *const page)
 {
 	if (!PageHighMem(page))
 		return page_address(page);
@@ -81,13 +81,15 @@ static inline void *kmap_local_page_try_from_panic(struct page *page)
 	return NULL;
 }
 
-static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+static inline void *kmap_local_folio(const struct folio *const folio,
+				     const size_t offset)
 {
-	struct page *page = folio_page(folio, offset / PAGE_SIZE);
+	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
 	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
 }
 
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_local_page_prot(const struct page *const page,
+					 const pgprot_t prot)
 {
 	return __kmap_local_page_prot(page, prot);
 }
@@ -102,7 +104,7 @@ static inline void __kunmap_local(const void *vaddr)
 	kunmap_local_indexed(vaddr);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic_prot(const struct page *const page, const pgprot_t prot)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
@@ -113,7 +115,7 @@ static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 	return __kmap_local_page_prot(page, prot);
 }
 
-static inline void *kmap_atomic(struct page *page)
+static inline void *kmap_atomic(const struct page *const page)
 {
 	return kmap_atomic_prot(page, kmap_prot);
 }
@@ -173,17 +175,17 @@ static inline void *kmap(struct page *page)
 	return page_address(page);
 }
 
-static inline void kunmap_high(struct page *page) { }
+static inline void kunmap_high(const struct page *const page) { }
 static inline void kmap_flush_unused(void) { }
 
-static inline void kunmap(struct page *page)
+static inline void kunmap(const struct page *const page)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(page_address(page));
 #endif
 }
 
-static inline void *kmap_local_page(struct page *page)
+static inline void *kmap_local_page(const struct page *const page)
 {
 	return page_address(page);
 }
@@ -193,12 +195,14 @@ static inline void *kmap_local_page_try_from_panic(struct page *page)
 	return page_address(page);
 }
 
-static inline void *kmap_local_folio(struct folio *folio, size_t offset)
+static inline void *kmap_local_folio(const struct folio *const folio,
+				     const size_t offset)
 {
 	return folio_address(folio) + offset;
 }
 
-static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_local_page_prot(const struct page *const page,
+					 const pgprot_t prot)
 {
 	return kmap_local_page(page);
 }
@@ -215,7 +219,7 @@ static inline void __kunmap_local(const void *addr)
 #endif
 }
 
-static inline void *kmap_atomic(struct page *page)
+static inline void *kmap_atomic(const struct page *const page)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		migrate_disable();
@@ -225,7 +229,7 @@ static inline void *kmap_atomic(struct page *page)
 	return page_address(page);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic_prot(const struct page *const page, const pgprot_t prot)
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
index ef3189b36cad..93fa505fcb98 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -61,7 +61,7 @@ static inline int kmap_local_calc_idx(int idx)
 /*
  * Determine color of virtual address where the page should be mapped.
  */
-static inline unsigned int get_pkmap_color(struct page *page)
+static inline unsigned int get_pkmap_color(const struct page *const page)
 {
 	return 0;
 }
@@ -334,7 +334,7 @@ EXPORT_SYMBOL(kmap_high);
  *
  * This can be called from any context.
  */
-void *kmap_high_get(struct page *page)
+void *kmap_high_get(const struct page *const page)
 {
 	unsigned long vaddr, flags;
 
@@ -356,7 +356,7 @@ void *kmap_high_get(struct page *page)
  * If ARCH_NEEDS_KMAP_HIGH_GET is not defined then this may be called
  * only from user context.
  */
-void kunmap_high(struct page *page)
+void kunmap_high(const struct page *const page)
 {
 	unsigned long vaddr;
 	unsigned long nr;
@@ -508,7 +508,7 @@ static inline void kmap_local_idx_pop(void)
 #endif
 
 #ifndef arch_kmap_local_high_get
-static inline void *arch_kmap_local_high_get(struct page *page)
+static inline void *arch_kmap_local_high_get(const struct page *const page)
 {
 	return NULL;
 }
@@ -572,7 +572,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 }
 EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
 
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
+void *__kmap_local_page_prot(const struct page *const page, const pgprot_t prot)
 {
 	void *kmap;
 
-- 
2.47.2


