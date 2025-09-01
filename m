Return-Path: <linux-kernel+bounces-794551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3CB3E328
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9B3AA6D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5934A302;
	Mon,  1 Sep 2025 12:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Y6Z2WKL+"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715A3451C6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729849; cv=none; b=o4Cjv5QprjfSFghX9GjOlEPUiYvgkbI3Q9oEz97VFAxBSGr8xXo/7i5dNJAXB+QUDO6yraKl/x3aifMUU28uBDWLWfrphb03fIIu46RnRPRtbXljd1+4gHskPozQNg/qxRANRXd1Vb/Gri2ZpQcfoERZhRp1gkWZ4NSfNkoETpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729849; c=relaxed/simple;
	bh=QRQYJFWqU0e0biGrVss+FBU/g4YEAqNxhEPzepfpQBo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6KsQVoveOvpKM6Lziw/FQAQ9XZgMLqaMrFhnroz60pTGOyDMBeme4A+4eZLmZ35eQuPwlPJ3H+QU+3Mu7V+zX/X8XujjWx8JNa/QMUL7739tlG4aPSnAERib47H5+Wo3943A2Pf/wELECb7BWM0eUedZMxfmoZXc9Ud7Jdt5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Y6Z2WKL+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61e8fdfd9b4so2130106a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729844; x=1757334644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKgBVUzyj+6dcxmt1PFXvQk/IZiLcynXJnKCzF2l15M=;
        b=Y6Z2WKL+yPIQ0xFKdrX+5jY+J3aSuFfMpSYQ4tLzUezvNZkFjrfVrLt5PduYUN+uTh
         DdNZLDlSIIs08oAhAi5E72e2JDxq5lXlp7sA2EZT0V3GlUB3me83xYSyQGRZzqGfGtD3
         1YxnTgXie5K0b+e490skFkYHD4RNfeAiu1eODPE9zGF8OKwCYtWG0L/WZGFj8lk3BDCp
         1f+rXiJm3Y+ZLXChtnkNWXqQ12RbMe9rVMg5giZ7BxUBMm5VNrFmbXZHylj6ccBt3lzH
         HvTNdFqZZjtyoj6E/5SKR2c2TBGcrPVTX64xcgaTQQDJPsF9yjGOKkD0M9auTHOJsdJL
         oxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729844; x=1757334644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKgBVUzyj+6dcxmt1PFXvQk/IZiLcynXJnKCzF2l15M=;
        b=Hv58nmjM8xHDp6oKNv78SB+ZhSYXjB/e+FNg8+TLSSRpPZE8XD+fiGQ64rKObmHtQk
         gg7mf8aISIfymns6Xl+7T48ixx3/J/4f7JyOIGw/FeWPutn+JhLMVxCDJFNvuV7Rv59X
         InV4V4X+mlnjINvu7prcVE9/TCBDeAsm2Gsd6D121KMQFxMNrpZlH3BwggFxpn5hc5iC
         Krt4rMoZIzkwFSveIwdv4Dftj41fZ7KtmdmJcBOq8kEqC3SqPAk2tow3iHLrSSkOU7hZ
         o/LfLlpAW3GBTkInOgjwieDHRtLFMytc8uJZaCiEg3Wrc5Zfgv5xzdH9p9WKlkjqBC2v
         iiBA==
X-Forwarded-Encrypted: i=1; AJvYcCWRRVncrp+SefGDMesc2gxktp3H67Tzwo2NBtW+ThQRmK36RM+N63IEg2RN2eKI9JVmtvX0tQc6S6nc47Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHBzkN+S2+GwrWj8arKa8XmQ/JcAEi85Jse0iUB+OSKlNqujA
	xtNKPc09F9TLRhPvo7BqGfMLPRZ6bhZK4hVvSnahVcJ2MJGFhrK0zr5NOAML95Qp0CY=
X-Gm-Gg: ASbGncvhV9wMidYfml2y3iRKcCKfniL617wMf5R5zK86jwVuq4b5DPOgrKds3XofW3w
	OTkbKOEm+mgeuFgC237p9AhIhhQ+4PUE0YBBdatCc7v+PwxK/cWIzKAl/w3WrLeqYc6y3mw5LYG
	0ZF2z0u6M/mkmqgy76vAbhezzbsn8TLsyWlE/NKibc+BTA2APreMxd5Vw3qv2YDoc7d5zLvF0nX
	+Gp1cH14P05jIdD9/AMkZm1MqP2Q+1Dg6EJsO+QLXWAC/0WtIJJcIJQQm79Z6w9XcSTGFgcxzv9
	Thhtyi+Nx+i3dUzYB0aX72Cu7KINyXhaeOK5lO5OJD7LB7TIaW28AjNKtR23Edx2Zsf40R5ppoz
	hOjm2VVkmLLIM0jy2nxdryzMvpi2adIAmsbZHjCk4r8c/KVBgEuvf9qDJOXTC8jD3S8rnp3YDVf
	75KeTAMpordjG7JLAAsP8+GmzEldPnKsqz
X-Google-Smtp-Source: AGHT+IEpijDtb0z/0WWEMHXl7q4Rmv4pw1RD0/gKYGC8MsYS/XMq2PnLTln3mfCOBW3uU4B+hzFViw==
X-Received: by 2002:a05:6402:325a:b0:61c:1d41:41bb with SMTP id 4fb4d7f45d1cf-61d22f522e8mr7331559a12.16.1756729844370;
        Mon, 01 Sep 2025 05:30:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:44 -0700 (PDT)
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
Subject: [PATCH v5 06/12] mm, s390: constify mapping related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:22 +0200
Message-ID: <20250901123028.3383461-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

(Even though seemingly unrelated, this also constifies the pointer
parameter of mmap_is_legacy() in arch/s390/mm/mmap.c because a copy of
the function exists in mm/util.c.)

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


