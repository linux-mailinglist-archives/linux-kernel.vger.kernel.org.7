Return-Path: <linux-kernel+bounces-793300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E75B3D1A9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417561893BF2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAC258CF8;
	Sun, 31 Aug 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="F31n74PQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C9255F24
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633185; cv=none; b=GcJlzG3DjaNFDYMzEVY5cM93XMFE1fE4SCWCK8wCbStSF+jThkcQiMqwisHlHf327OpAyaNWI6zjDBTc4xkqocq1tUatXy0on2rnh9JNXIPMCnB8ft2m71KvFruzFUWOZmHz2QFqO1fcuzJ4DaoWjogIo8JpU9aCZrAjf0nuB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633185; c=relaxed/simple;
	bh=Ff+sA8PUhDW+RJGEBz/hBfOU7ZH7xBSwtwdktQWV9Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHqQoPx8IAocx61AvPgzU3kxaNp6oOE2Yuv52f81HsWaY1n5VAyEulmlJNsWjcd2tndmD5L03TDChmoUYhHRrI3oJ9VWOYsadVhPxVJXUxUD0ckrx0qKF5uOw5+4encyzOHucw5aSjWCNHmms9hhCJhvTNsGptzUVngKn1LOUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=F31n74PQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afede1b3d05so593921566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633181; x=1757237981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA7/Z0h4l3VUXRftUOxDU1DV2lHah2+SGvyysIvLq/0=;
        b=F31n74PQI/72TcnaSMJuG3C6qXRU59erQG7qCsHSfaWsAbmE7nh5YUBZKeUPWDlLzM
         X9QGh6Yd0dX2/mMI5+21f1LG4nK5F57aDArF80mFl5ONbDa1VIsVZxSWCydNDkIrpEKE
         NiEW/fC3ovj9yUoRzHoqQoodZYv/i+mm+usBpmL0S1PiydlYz1KyIHbYN9wcew8Menyn
         74KkyFY9L0alQBM4iX2RqhACrgu94aZRPczWN5hobdwWwNO1e5i+KK38weVD6O6GNZBO
         eMy3X0L+AxZ30pNqX9tWNmmkrgtEozPlfOjL5tIOF2XqcdK8dvSWHhQpcXQwdZBTFpR1
         nCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633181; x=1757237981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CA7/Z0h4l3VUXRftUOxDU1DV2lHah2+SGvyysIvLq/0=;
        b=TDSMjEwYfy+HxgH/SEjKqRuoN3t5jCiRr0HhY4qIWvQyAShmT4oiXeRcroiEp9M1x9
         TU3yEg9r04GcvMM21LMi5dXTA7PU9GBfEFsMgur8T4E3uUXrqu9xb9OWfMOlAQQo/dFP
         jOMcdwbDGFuHEkDTjPupT1rjpjsE92oDmP7TYWsQOwI8Ch/ZxIRp9DmC70UlM1Anehcr
         WhJXq1Tv1XwmvZo11ZBIyQ3cthUl+i6fupWpNDnJ9ws5qL/L5gsu9YBW00lb+3GJiCL8
         38oL24/D7GV859CdxWhou39hpfVhXl0fagokkyXMlrWM9c/5DTyJoTTtFDphNmLRZy4r
         IwQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/jybL0FSOFI2rAKS7MHryqlo06k87BHSyrU0Q6c8uNPJ59SvKvf7kZdikbcQi2kZI3Fy6VEyha3gbPDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkSnk7P5EPI+FBV8EWSluSdlNC5ge+e6Lv0swD93908pfoSuI
	4bKl8Dlr/mPeZeL3UlRUb2crzu/9kNhPfBCvq4Y6lJVIDgW9nv9uMHUma34ZkuIJdqM=
X-Gm-Gg: ASbGncunyuFoAiNdqdG4UYet0rzxN/r7Fih9n3iOwocm4dNArrEPKOiqjDFByaWSXMp
	FosuujoyH+2+dqdD6KAyRK56wW7byHZ2L57e52PNLR6fLxU7iCn7bhnGoQ3x30cf0Mo+2Q+LAQI
	DVCJJL8mXFE3M7ovOtyhAr9IpJNt+wzOQJKWADGjtbtSTrn41SDA8EJOEnli1hxMcrzzowsyZHx
	REn1NO9LAwORts1QzgjuBvAIsyjdsxsxumM4nRo+iy6jRz4tMWJu0KiF5HlsgRyYdlYKR4fh6yk
	Gh62Ry8cBjTU2ykIfO7iEI0jwKcnGCxtbfoy89K3Aeof6b2XmQ4nSVT88LSHWHGdE51dFNO3auX
	ewSwgyFxG+6WMc/1j989Fl+0U7h4f4WhYmBfAYNO9Y87XK3BtLkwd5ZMnybEl+Rlcbp1HOH0Tpf
	zQ8yPzPypWu9Ogx1eyM1Q+MA==
X-Google-Smtp-Source: AGHT+IF97ktlnWZNvlYV47UHXkNu5gmgjhCz45wCbFG7Qfw8zaP0gxXJmVUcuyEw2604qQrSFAsTAQ==
X-Received: by 2002:a17:907:7f1c:b0:afe:87df:b94 with SMTP id a640c23a62f3a-b01d8a266cemr430994766b.6.1756633181339;
        Sun, 31 Aug 2025 02:39:41 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:41 -0700 (PDT)
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
Subject: [PATCH v2 06/12] mm/util: add `const` to several pointer parameters
Date: Sun, 31 Aug 2025 11:39:12 +0200
Message-ID: <20250831093918.2815332-7-max.kellermann@ionos.com>
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
index 1c18b89c2d28..d12550ae9814 100644
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
index d1244e7dcf0e..37a05de82140 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -549,7 +549,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
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


