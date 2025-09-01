Return-Path: <linux-kernel+bounces-794185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32FB3DE0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1333F189DCB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8C30F7F8;
	Mon,  1 Sep 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V1oS9kVW"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833230E822
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718380; cv=none; b=rXHwYcNoUDal9TjG+y7BUP4TKV+8FrxrnxWfLmwU4phRKp1aHAvI2owgmfoTu31TOkCUBZFelIg5tn1u8QKpPwdGbUN1xJ7IQLl0kneJT3xUK0WCiqvsTkcfV0kv6FQNuabdcrEHhnWGcvstdtaI2v5poFhg70Brw8SAI5nZBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718380; c=relaxed/simple;
	bh=TfvBp8NaXvn+VfxQh9MP9xDTHhgA71LSeNxAeqrwpZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VF3ENDLY59nG9sOCkDx8PPD5n4dYiXY0wkbc3sJRTsbuJrbdQUvHwSdsqyNkTM6NG1CI60iHYTJgqy0RoXmO4CWrHWbzShWYfKmCHBwq8yBPJLOib+nfGhXNJHaB40ccWYLc3uMyGda6UYUrJT7tDoFZUtdzF+yfjfkdTfOmiV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V1oS9kVW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b0418f6fc27so147083066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718375; x=1757323175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbwvQejYab/rePViSXLSZNeM/TCyXeV95uglwFlMcys=;
        b=V1oS9kVWlNMM+fTF+KaNHdoniy/e+376JDtPezoLf/v1KAARaqFE+SdEnImBVPA+Uj
         yDxGhqDHQP+I/S7gy+CdtDnJHCtbmNziBiarkIbs74DVg3CEpmYGWZk+MjcVXHxMqKrC
         ZtuQZ4XbUkQ/56rt+lYLeXibI6gPJ1DlsZgoEQA091PQkOUXBgYHmmMofi5fubkZYlRl
         YWhJwvzUUUB41tgXeUwHHtj53piLFdVpOhbwoe3WSgh+Bgr7M9KhAJKUEMwl3UHTwz0a
         ORVRl1Pvw2NWybh41TCTvvrGmim064+BXjawh3pf8v1bTqImHMyfMQ4W/4Qcrw4vCsbc
         wz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718375; x=1757323175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbwvQejYab/rePViSXLSZNeM/TCyXeV95uglwFlMcys=;
        b=m2qaxQsXAxJPWq9NhW/i6qTjgXb1Wd9UfDGnA0WSym9ncLG9IvwwtkE5Qi35MCSWIW
         Xbzs0+gTdRqQj04iozjAldF73gzylO+ohQyV6wPDivwORlwJRvHyFknjvE0H84p6gqn2
         5CLokVuLLldWw6lt9bS0KMm8Y3BWWj+s7V0/fiDW2aGFVG75ZWLwo2C8VAmLslKY9D9a
         WuyNmAZ2w4aDbKUm3ES6DBkKgg+0LSVeDDI3xgi5jE9GF9LzemUuBggM5GGsOX8CAxte
         GiFkwHP186pAH11vQIRiWbVLo5GkCK8eEd13PmDVxfI4wm3ugJoJCY4x70xUspyTNAzS
         nVCg==
X-Forwarded-Encrypted: i=1; AJvYcCU37WUYlRxwWmAkrRg+BdnZ8mXj6vXcMgIJYJdfDhUlsppyPZFR7Na7D+Fs4ew0RdaU9upH7bgaZwZ4qik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHx2FhkgHiCITgaMPJ4CGGRqRSvR+VuUZw8laaSZFzopLlYD9Z
	lWnb1wCxR3yuK7L277gM5mb+GNGW/zNWJuEjXrfUAGM/B8PmBuheCRB4JY3D7pxyGXQ=
X-Gm-Gg: ASbGncv7Y4vQ/ZVOl61z1i9mAobJUmq48saZ612cdoODLNJ/FTtvkYkI6gkakpLdly6
	FhCMSorp55DUXe1+CKnM4p+jXjFGhk11DLdgtlcT6toVK9zphrvnXRSM/x2L/saCrSmftGyTwVn
	YdmI24uMSm1cAyFsdvI3bnj+vrAuro82IvBxNf7H5W29Jy43eRfIlA6nq93ECwNrboEeb8D8wGP
	/y3KgKPvI3YN+ND9LGTRnNGz8tiHOD7MIXFRiU13KpeviXkENrkgbT6N6LTSC1T3kGxQD1++WTq
	g32D1jNREDwcLB9+ZTD5ZfaA5+mg1iySODx/c6S79cTPs1HMKJUa2IYG3E33y4dJDn5fPHuhnL8
	AnAH7PF7YoUmK7keti+w7TDlM1m7n52n266yqSeTI3fiCHTFxpQIuYuDwKm94qCS4tvJIefzvAn
	vZIPfZ0AAJQFWGy0M6m+6LApbQvd5+/sEo
X-Google-Smtp-Source: AGHT+IFjLUezk0MNPBdl2gvK25UHEhY1rnJIkox6nR/OlA7eUuvIfWjMQ4n5LH61nexh9wBub/G+rQ==
X-Received: by 2002:a17:907:86aa:b0:afe:b5fa:2adc with SMTP id a640c23a62f3a-b01d8c7d928mr753689766b.24.1756718374952;
        Mon, 01 Sep 2025 02:19:34 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:34 -0700 (PDT)
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
Subject: [PATCH v4 06/12] mm/util, s390: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:09 +0200
Message-ID: <20250901091916.3002082-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to rlimit, vm_area_struct, mm_struct,
and folio pointer parameters in mm/util.c and s390 arch code that do not
modify the referenced memory, improving type safety and enabling compiler
optimizations.

Functions improved:
- mmap_is_legacy() (both mm/util.c and s390)
- vma_is_stack_for_current()
- __vm_enough_memory()
- folio_mapping()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c     |  2 +-
 include/linux/mm.h      |  6 +++---
 include/linux/pagemap.h |  2 +-
 mm/util.c               | 11 ++++++-----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 547104ccc22a..c0f619fb9ab3 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
 	return STACK_RND_MASK << PAGE_SHIFT;
 }
 
-static inline int mmap_is_legacy(struct rlimit *rlim_stack)
+static inline int mmap_is_legacy(const struct rlimit *const rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f70c6b4d5f80..23864c3519d6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -986,7 +986,7 @@ static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false
 static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
-int vma_is_stack_for_current(struct vm_area_struct *vma);
+int vma_is_stack_for_current(const struct vm_area_struct *vma);
 
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
@@ -2585,7 +2585,7 @@ void folio_add_pin(struct folio *folio);
 
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim);
+			const struct task_struct *task, bool bypass_rlim);
 
 struct kvec;
 struct page *get_dump_page(unsigned long addr, int *locked);
@@ -3348,7 +3348,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 /* mmap.c */
-extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
+extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1d35f9e1416e..968b58a97236 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -551,7 +551,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 #endif
 }
 
-struct address_space *folio_mapping(struct folio *);
+struct address_space *folio_mapping(const struct folio *folio);
 
 /**
  * folio_flush_mapping - Find the file mapping this folio belongs to.
diff --git a/mm/util.c b/mm/util.c
index d235b74f7aff..f5a35efba7bf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -315,7 +315,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user_nul);
 
 /* Check if the vma is being used as a stack by this task */
-int vma_is_stack_for_current(struct vm_area_struct *vma)
+int vma_is_stack_for_current(const struct vm_area_struct *const vma)
 {
 	struct task_struct * __maybe_unused t = current;
 
@@ -410,7 +410,7 @@ unsigned long arch_mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-static int mmap_is_legacy(struct rlimit *rlim_stack)
+static int mmap_is_legacy(const struct rlimit *const rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim)
+			const struct task_struct *const task, const bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
 	int ret = 0;
@@ -688,7 +688,7 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
  * You can call this for folios which aren't in the swap cache or page
  * cache and it will return NULL.
  */
-struct address_space *folio_mapping(struct folio *folio)
+struct address_space *folio_mapping(const struct folio *const folio)
 {
 	struct address_space *mapping;
 
@@ -926,7 +926,8 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  * Note this is a helper function intended to be used by LSMs which
  * wish to use this logic.
  */
-int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
+int __vm_enough_memory(const struct mm_struct *const mm,
+		       const long pages, const int cap_sys_admin)
 {
 	long allowed;
 	unsigned long bytes_failed;
-- 
2.47.2


