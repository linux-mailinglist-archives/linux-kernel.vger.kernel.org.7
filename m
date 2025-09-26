Return-Path: <linux-kernel+bounces-833825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8BEBA3290
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BA71C029CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E929B229;
	Fri, 26 Sep 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVVReo2k"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3F29E114
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879246; cv=none; b=k5gM6nCJ7wjUt8TFsbW+HWunCLqjUXsT4hbiINChrs0eLt2IjpdVBOyzNilD3ORtLJFU4Efjw3iq8m7wKKuCW8+RTLX2YW9qh8UXN/7VUR+IT/gcw+9Y086Jw0siXmsloYJH2A6kwSQwPi+vuLxn1w7PKH1s3dJ+nwplKxwDln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879246; c=relaxed/simple;
	bh=bUp3BGp396G2CdfrOAvmGzPXg4IvkjijZlzOnD82C9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHfEjslxDbWZSc3+xiCzx1XKb//qD/T5xfqcutXTNYT+e6DDblR9JvkFPbTJu8FqhADXziqKgKuFDX1IFklFnWdtKEIIqk68hCjgZIHl1WVjOopyGAwivLqrVC4KTqRvb4FVKwzSPhwxDkwnSsUijWerz3mhNoJkE2JlN6vn6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVVReo2k; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b550a522a49so1751336a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879244; x=1759484044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1iT+4a+LxjpmMHe8jWDV6d5sbyjeFATI6sWgnnJ+Ko=;
        b=jVVReo2kJ04DABHVns5YR1DnUxryy7N9tkMrjqFsHqW4z/cVriDD0jgkTYSvbdMOGK
         VE/C9CiEpB3tcpT96NO2HxqtunRQZTdApLQYRTWDVQSo2tT1x7K+Rd2Gfl11fWwPoB6R
         hBv3PCB/CEkc5mnLxtLu45XjKsa7Ut0vacbenxdNdCeU7hBRxJVKXYBgOh4ezxid5h0S
         lmlgGRztrHU6sy9JhTzKCcA4AVEe4+HtqbmsSyr57JbfUMVfNSlyNoeSXMqJ5FWItuPp
         bR/PSpUr0NSkiFEjP+n5TId3A6ITqlv6Fg2DrNOp6JsY9WbDhMjXfu9AVpSpk11CWpzs
         HsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879244; x=1759484044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1iT+4a+LxjpmMHe8jWDV6d5sbyjeFATI6sWgnnJ+Ko=;
        b=f9b/xnhUZugqjEWWhyvqHsEgGIPBV8EP+l8xyCzfo50duDqfFLVrNPa2ZQJUXOUzuG
         igjD5ITrxpjJaup07sWsEIxHSjjpDcv0/HEOhTHvxhhidAyZusEnbMO6jwjNOpfoDp3H
         ll6hmvFf7y6YHKL/zIX99GoPkNnNSX0FgT9U/jwFHSwF3JxV1zSItAN0MJGC98B4yMtZ
         XORG9wbVfwfvheaqzVZm9QK5X8lT1mVZ8ZcX1n5vfmPuqCJT36GU6bVNgCiPoapJGKsJ
         Qy/fyZnj7Y1TiqXg9sFRs3cE2JtdU+2r9SEm3b7WuTIGUtTzd8Z3m3BmX/FN8kLJtir3
         V5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUhkmHPMiFJhTz5yW3UmbczW4IvUCI5/iJ5S1bMb5B75IVVhaWgBSmUtOcRUlEKOaKjTfMsdL3ayMPxYRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3mNvtW45atSk0um280n4JOSH+OX3czs9fkcfkQ/mWEKmU6x2
	b1gBi0zXH4j9ZQrK9SSTudikdaZZsagmWDvbfonz9/lF32l8QYQ/8ATi
X-Gm-Gg: ASbGnct1+G3TPG1aJLwQS7ZlIH4D6OTmQKExnM75Ow2Y97n/TYhvlm7JkSHEkXSyfXd
	RfF4cc1v3e+q3KfB+boWHZDZ189XjFek3DZQDpd+lZnfUG19xfIvOXtUO6dLjOaHSWE0gHkNEUC
	5kqbRm2TlanBWxYYfJVJCduYes54ag/7zammoMJ16+rkzS9b+FPcEfGBiwDDerqfeOpKwzocVH3
	XbYiD8DDXEim+AqmwjL1hg9IIp2dI5jusrhcE4yGbdZb5pBHFocEU2oXgM/rD5FjKNCiZ3NlNp4
	ABDIUZm21Ko0IXPQ62z2JGscLyPR7NCOOXQybwqi5y50YvyRrTsIDsII8aZN1DUCzsJ5RPUqe/p
	AKrDGDGY1X2j/ZtBuMwbkPVL7K0OuyCRBTrsbOfLufAReORaRMnkrkh4XFdmZ2+RN5lxnSnZE77
	Rg0xLaWx/aEsAlV6KTQv6f0uk=
X-Google-Smtp-Source: AGHT+IFMcSGbIwf6P8Uo4nGwswfBIEGRuV2pBMbvxCc6qLaUcucPNfwqmzfPb0tJNWSduz7DlEJanQ==
X-Received: by 2002:a17:902:8208:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-27ed4a670f1mr55436305ad.57.1758879243564;
        Fri, 26 Sep 2025 02:34:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1c21:566:e1d1:c082:790c:7be6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cda43sm49247475ad.25.2025.09.26.02.33.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Sep 2025 02:34:03 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net,
	21cnbao@gmail.com,
	shakeel.butt@linux.dev,
	tj@kernel.org,
	lance.yang@linux.dev
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 mm-new 01/12] mm: thp: remove disabled task from khugepaged_mm_slot
Date: Fri, 26 Sep 2025 17:33:32 +0800
Message-Id: <20250926093343.1000-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250926093343.1000-1-laoar.shao@gmail.com>
References: <20250926093343.1000-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it from
the khugepaged_mm_slot to stop khugepaged from processing it.

After this change, the following semantic relationship always holds:

  MMF_VM_HUGEPAGE is set     == task is in khugepaged mm_slot
  MMF_VM_HUGEPAGE is not set == task is not in khugepaged mm_slot

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/khugepaged.h |  4 ++++
 kernel/sys.c               |  7 ++++--
 mm/khugepaged.c            | 49 ++++++++++++++++++++------------------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index eb1946a70cff..f14680cd9854 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,7 @@ extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma(struct vm_area_struct *vma,
 				 vm_flags_t vm_flags);
+extern void khugepaged_enter_mm(struct mm_struct *mm);
 extern void khugepaged_min_free_kbytes_update(void);
 extern bool current_is_khugepaged(void);
 extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
@@ -42,6 +43,9 @@ static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
 }
+static inline void khugepaged_enter_mm(struct mm_struct *mm)
+{
+}
 static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
 					  unsigned long addr, bool install_pmd)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index a46d9b75880b..2c445bf44ce3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
+#include <linux/khugepaged.h>
 #include <linux/utsname.h>
 #include <linux/mman.h>
 #include <linux/reboot.h>
@@ -2479,7 +2480,7 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
 	/* Flags are only allowed when disabling. */
 	if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
 		return -EINVAL;
-	if (mmap_write_lock_killable(current->mm))
+	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 	if (thp_disable) {
 		if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
@@ -2493,7 +2494,9 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
 		mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
 		mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
 	}
-	mmap_write_unlock(current->mm);
+
+	khugepaged_enter_mm(mm);
+	mmap_write_unlock(mm);
 	return 0;
 }
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7ab2d1a42df3..f47ac8c19447 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -396,15 +396,10 @@ void __init khugepaged_destroy(void)
 	kmem_cache_destroy(mm_slot_cache);
 }
 
-static inline int hpage_collapse_test_exit(struct mm_struct *mm)
-{
-	return atomic_read(&mm->mm_users) == 0;
-}
-
 static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 {
-	return hpage_collapse_test_exit(mm) ||
-		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
+	return !atomic_read(&mm->mm_users) ||			/* exit */
+		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);  /* disable */
 }
 
 static bool hugepage_pmd_enabled(void)
@@ -437,7 +432,7 @@ void __khugepaged_enter(struct mm_struct *mm)
 	int wakeup;
 
 	/* __khugepaged_exit() must not run from under us */
-	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
+	VM_WARN_ON_ONCE(hpage_collapse_test_exit_or_disable(mm));
 	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
 		return;
 
@@ -460,14 +455,25 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
+void khugepaged_enter_mm(struct mm_struct *mm)
+{
+	if (mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm))
+		return;
+	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
+		return;
+	if (!hugepage_pmd_enabled())
+		return;
+
+	__khugepaged_enter(mm);
+}
+
 void khugepaged_enter_vma(struct vm_area_struct *vma,
 			  vm_flags_t vm_flags)
 {
-	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
-	    hugepage_pmd_enabled()) {
-		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
-			__khugepaged_enter(vma->vm_mm);
-	}
+	if (!thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
+		return;
+
+	khugepaged_enter_mm(vma->vm_mm);
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
@@ -491,7 +497,7 @@ void __khugepaged_exit(struct mm_struct *mm)
 	} else if (slot) {
 		/*
 		 * This is required to serialize against
-		 * hpage_collapse_test_exit() (which is guaranteed to run
+		 * hpage_collapse_test_exit_or_disable() (which is guaranteed to run
 		 * under mmap sem read mode). Stop here (after we return all
 		 * pagetables will be destroyed) until khugepaged has finished
 		 * working on the pagetables under the mmap_lock.
@@ -1429,16 +1435,13 @@ static void collect_mm_slot(struct mm_slot *slot)
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
-	if (hpage_collapse_test_exit(mm)) {
+	if (hpage_collapse_test_exit_or_disable(mm)) {
 		/* free mm_slot */
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
 
-		/*
-		 * Not strictly needed because the mm exited already.
-		 *
-		 * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
-		 */
+		/* If the mm is disabled, this flag must be cleared. */
+		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
 
 		/* khugepaged_mm_lock actually not necessary for the below */
 		mm_slot_free(mm_slot_cache, slot);
@@ -1749,7 +1752,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
 			continue;
 
-		if (hpage_collapse_test_exit(mm))
+		if (hpage_collapse_test_exit_or_disable(mm))
 			continue;
 		/*
 		 * When a vma is registered with uffd-wp, we cannot recycle
@@ -2500,9 +2503,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	VM_BUG_ON(khugepaged_scan.mm_slot != slot);
 	/*
 	 * Release the current mm_slot if this mm is about to die, or
-	 * if we scanned all vmas of this mm.
+	 * if we scanned all vmas of this mm, or if this mm is disabled.
 	 */
-	if (hpage_collapse_test_exit(mm) || !vma) {
+	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find
-- 
2.47.3


