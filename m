Return-Path: <linux-kernel+bounces-793880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52647B3D999
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1799317A0A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDF125A328;
	Mon,  1 Sep 2025 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XLNWMq+M"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE04254AFF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707161; cv=none; b=Q7P1GGjMzqkEEFpFdzIY75AFYrYSoSy0LuEzj6snW32LI/W3hpYaVqiV+DsejbaN9O6521rvR+q2evO0xyJ4lvzBlm6PqC26KAYehxh4nUg9kfCvcjbgI8JYIJ0sGOrfRF9V6JP8jFOgyKkqAhLQtvdfmT5Lr64ijsMrX/8WU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707161; c=relaxed/simple;
	bh=CVm4a2o2RnlyF4eyyPiBTpxYupvKVcs/qoqsHQXVYjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTzLsCfBGeugDW+JfLrYl8ZJC7g2Mw3f0wUrcuKryuBGEzITtA8tNsUZ42exZMoboyprjNoMjZOT1adB6URlRST4C1gK7SXYJull2nOLzy1ZBhKt9VHZFInz9J7JNYasMMqVbGHXmhrmWoVFCAZR9qiAnq1adjVt/izeFxQSzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XLNWMq+M; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cb9e039d9so7775661a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707158; x=1757311958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR4oy7Zb2IbSctYsSrVgfFfpaXt7ypSRTmIBa0GxRUo=;
        b=XLNWMq+MsCseOsnlENRVeXaU950/NsegPYwEut5dgwcbqI56cMprGrIcI4ATOSlezp
         1paD69CMo2FFXCCd7U+LuxoKaBSqrCR5Rk5dQOlCkY3dJkvGMi8BOSyUg/9O1prv26YH
         XO5j/iV8VebOutCvfTjASjcSBU1fFDDrz8Ulg0zx2V8VR3hEkx9I7pJZHCETXms0fplC
         6QWjjhnmUeVMefUgH7G/8cUH+IOGix4AnM9jL17htH46X8tuJHPvStgKZLPaX9mqQDWp
         7sCkKUM/pe5fHi9DTMbTBqQCIvQASHttZiAMXGZcxFVbutSFfb9WHYpqIhiJXkXBXyeq
         WWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707158; x=1757311958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rR4oy7Zb2IbSctYsSrVgfFfpaXt7ypSRTmIBa0GxRUo=;
        b=Ls0oJMNOJnuZO7JbfIZgHUae3KUW1zeNii+CaVZcqB4XRgBD+wpCdIWn4ZEUW/ECAG
         QakdqZ32T1tOVhV5irpXBy5ENtTU3J5+XeIqA28ZUll8nXYx4VkzLpiwFwSHd6RmPEtS
         yPMSo4LYgs9HC5isEjNo5zoPcgDZpF3Wew8pyoLpngAr0tHW9bM4qo+BPxdlvg2wEPAf
         nNsXOFaI8iKZ+hFDy7trOrVAUsr5MIp0d78euFHdHk7ZruH+TlIVMlFJtNPlNS7P81b1
         KKuQrF3T3sC8hbILPHLsISdUSwws8uGFxq1YsAGDeljQaMrg/MgQ1ATlu1Zlq/SN1qql
         fAWA==
X-Forwarded-Encrypted: i=1; AJvYcCVrr4c1xqfR9LJUnRDNPXwZRcuGhm+TucCpWWLqpWbnPjbO8NnmsyMfdtyfRRG0dxYKAlP6b93WbvUGZOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWRm5veZt6Wn4A1pvzZenmmEGwBYB1jIFNj/bGbnIbu/7WF5wf
	C+rRKnl4EP3iENblSPRwZUZh6jb6PTtFiQgzvj0HkYHOBW2AtOJCcGCIh463jR3PNQ0=
X-Gm-Gg: ASbGnctx0MLUzwcv4mIIXnOsWSwIly/6Db63zBDAW/03E9EzkVwDX7If3agt6BHQXeM
	aDpPDMNGQbfQqoA3J6MMimuFlQp4w1ToqHzk2QCQm/Q4POg1HJM+yBDq97hOuQkT72pUZNm650i
	Pe2WKjl96Ko2NUCt1YkhQ6Sa6I79y55CCvntki3lE7UcB5fEwQuIc+8oQkqwFbnmrzMtRfiOIC+
	X+3A5NltwCtnWjeFfJdRzm9Z5Dz7SbBhz2zh5iUIe9mq6kOPpbEO8EbdWWFsUCRpvErB2Zjo6+f
	civompHqfciWaTeKjwkXl2F4I2skg4Me5+f5ogcboX1vlasht6PaBqrL51yp+JpKbQqCuhoN2Mw
	uwtgsbQkG3ObuaI/V7RcQeD3SfB/qoie2V1FGEJpJVR1RDq/5eaLoLBrG4Xw07VZ1WIdoGZc06a
	RXfMdIsBVYDWOG8+74RIb7vg==
X-Google-Smtp-Source: AGHT+IE0vif5vuTCMER8ckouleyP96Gy21extBt5jOZsdMhAFo++wMW7N7bZ+f0Dm6MWmYncMh0vqw==
X-Received: by 2002:a05:6402:5c8:b0:61d:3d89:7826 with SMTP id 4fb4d7f45d1cf-61d3d897bc9mr4041138a12.28.1756707158085;
        Sun, 31 Aug 2025 23:12:38 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:37 -0700 (PDT)
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
Subject: [PATCH v3 06/12] mm/util, s390: add `const` to several pointer parameters
Date: Mon,  1 Sep 2025 08:12:17 +0200
Message-ID: <20250901061223.2939097-7-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
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


