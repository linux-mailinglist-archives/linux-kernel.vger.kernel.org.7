Return-Path: <linux-kernel+bounces-856172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8BBE34C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A55405BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C93254A6;
	Thu, 16 Oct 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="12ilpBKe"
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F12D9795
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616994; cv=none; b=FaFKttgHb4olhNLZbA+375vwHNc5Ot5R3c1r1B3/GRADbtTGqwoiXaND8fDgYJr5coLquSzjCsjfw950TjMcjDmJfixjJ44xbKqoPynUIno5FYfQI6btBZFUA8+qg7Oi6CqsLHR6CT2wXlnCt4tMqDiJu7zk7C6aJa/S43wQCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616994; c=relaxed/simple;
	bh=Wx9WR00TtypXH1uv2uZVYa8TvrtHV1QkQVTsJbIO9Jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3mbyjS/MuDYMJbhYcnyQQ6XI9QTqRQ7VqLGSVV4YItx5Bx+RGFPbmFGckjF6L7sXYkEpCYWxVaQgKxUWG2j6MKViWJ3F741ySC7iJXCRIkYjjc+B21uLQzP1OjRb/HBP5W0Cmfx2pSpdIlWHVt6CgDh8IUKZ0grUPplPI20LCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=12ilpBKe; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RoXSHzCj4YzllEn0ikbMVGveVmreJ/pgkk4Ih3+wHXg=;
	b=12ilpBKex3IF2LR1HkKpcHAmpRngXHOQ0Jt15KWNFwmO5p7kJDjPuPy4wHUx+eXuQB0QjG3oW
	AmsZBdDdXTqSucaBcY+IEZVRoBCPRgE+pYZq3wehtU2UjkD/U2jvoceWRpKwGy1jzRxEwwBcmPc
	x6rD9JJSHxOgAQ+L0tZDe1M=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cnRjw0QT4zpSth;
	Thu, 16 Oct 2025 20:15:32 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 84D73140257;
	Thu, 16 Oct 2025 20:16:28 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 20:16:27 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <rmk+kernel@armlinux.org.uk>, <linux@armlinux.org.uk>, <rppt@kernel.org>,
	<vbabka@suse.cz>, <pfalcato@suse.de>, <brauner@kernel.org>,
	<lorenzo.stoakes@oracle.com>, <kuninori.morimoto.gx@renesas.com>,
	<tony@atomide.com>, <arnd@arndb.de>, <bigeasy@linutronix.de>,
	<akpm@linux-foundation.org>, <punitagrawal@gmail.com>, <rjw@rjwysocki.net>,
	<marc.zyngier@arm.com>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [PATCH v2 RESEND 2/2] ARM: mm: Optimize page_fault to reduce the impact of spectre-v2 bugfix
Date: Thu, 16 Oct 2025 20:16:22 +0800
Message-ID: <20251016121622.8957-2-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016121622.8957-1-xieyuanbin1@huawei.com>
References: <20251016121622.8957-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Submitting this optimized performance commit is because of
last spectre-v2 bugfix, which adds a branch to the hot code path
and may cause performance degradation.

It mainly does the following things:
1. Extract the judgment of user_mode and reduce some redundant branch.
For example, for user mode, interrupts must be enabled, and
`(faulthandler_disabled() || !mm)` is impossible. I think some other
branches can also be optimized, such as `(fsr & FSR_LNX_PF)` and
`ttbr0_usermode_access_allowed()`, but I'm not sure. Among them,
`ttbr0_usermode_access_allowed()` is after `perf_sw_event()`, I think
these two are not dependent. If `ttbr0_usermode_access_allowed()` can be
placed front, it can also be optimized into the kernel mode branch.

2. Add some like/unlikely.

3. `__do_user_fault` is cold code path, inlining may lead to negative
optimization, so add noinline.
I also want to do this for `__do_kernel_fault`, but it seems that
`fixup_exception()` in `__do_kernel_fault` is not cold code, which may be
triggered by `copy_from_user_nofault`.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 arch/arm/mm/fault.c | 54 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e4dc7c2cfe75..09dde89a88ed 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -147,21 +147,21 @@ static void die_kernel_fault(const char *msg, struct mm_struct *mm,
  * Oops.  The kernel tried to access some page that wasn't present.
  */
 static void
 __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		  struct pt_regs *regs)
 {
 	const char *msg;
 	/*
 	 * Are we prepared to handle this kernel fault?
 	 */
-	if (fixup_exception(regs))
+	if (likely(fixup_exception(regs)))
 		return;
 
 	/*
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
 	if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
 	} else {
 		if (is_translation_fault(fsr) &&
 		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
@@ -170,21 +170,21 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 		msg = "paging request";
 	}
 
 	die_kernel_fault(msg, mm, addr, fsr, regs);
 }
 
 /*
  * Something tried to access memory that isn't in our memory map..
  * User mode accesses just cause a SIGSEGV
  */
-static void
+static noinline void
 __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 		int code, struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
 
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
@@ -265,135 +265,137 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	vm_flags_t vm_flags = VM_ACCESS_FLAGS;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
 
-#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
-	if (unlikely(addr > TASK_SIZE) && user_mode(regs)) {
-		fault = 0;
-		code = SEGV_MAPERR;
-		goto bad_area;
-	}
-#endif
+	if (user_mode(regs)) {
+		if (IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR) && unlikely(addr > TASK_SIZE)) {
+			fault = 0;
+			code = SEGV_MAPERR;
+			goto bad_area;
+		}
 
-	/* Enable interrupts if they were enabled in the parent context. */
-	if (interrupts_enabled(regs))
+		/* Enable interrupts if they were enabled in the parent context. */
 		local_irq_enable();
 
-	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
-	 */
-	if (faulthandler_disabled() || !mm)
-		goto no_context;
-
-	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
+	} else {
+		/* Enable interrupts if they were enabled in the parent context. */
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
+		/*
+		 * If we're in an interrupt or have no user
+		 * context, we must not take the fault..
+		 */
+		if (faulthandler_disabled() || unlikely(!mm))
+			goto no_context;
+	}
 
 	if (is_write_fault(fsr)) {
 		flags |= FAULT_FLAG_WRITE;
 		vm_flags = VM_WRITE;
 	}
 
 	if (fsr & FSR_LNX_PF) {
 		vm_flags = VM_EXEC;
 
-		if (is_permission_fault(fsr) && !user_mode(regs))
+		if (unlikely(is_permission_fault(fsr)) && !user_mode(regs))
 			die_kernel_fault("execution of memory",
 					 mm, addr, fsr, regs);
 	}
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	/*
 	 * Privileged access aborts with CONFIG_CPU_TTBR0_PAN enabled are
 	 * routed via the translation fault mechanism. Check whether uaccess
 	 * is disabled while in kernel mode.
 	 */
-	if (!ttbr0_usermode_access_allowed(regs))
+	if (unlikely(!ttbr0_usermode_access_allowed(regs)))
 		goto no_context;
 
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
 	vma = lock_vma_under_rcu(mm, addr);
 	if (!vma)
 		goto lock_mmap;
 
-	if (!(vma->vm_flags & vm_flags)) {
+	if (unlikely(!(vma->vm_flags & vm_flags))) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		fault = 0;
 		code = SEGV_ACCERR;
 		goto bad_area;
 	}
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
 	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
 		vma_end_read(vma);
 
 	if (!(fault & VM_FAULT_RETRY)) {
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
 	if (fault & VM_FAULT_MAJOR)
 		flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
-	if (fault_signal_pending(fault, regs)) {
+	if (unlikely(fault_signal_pending(fault, regs))) {
 		if (!user_mode(regs))
 			goto no_context;
 		return 0;
 	}
 lock_mmap:
 
 retry:
 	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
 		fault = 0;
 		code = SEGV_MAPERR;
 		goto bad_area;
 	}
 
 	/*
 	 * ok, we have a good vm_area for this memory access, check the
 	 * permissions on the VMA allow for the fault which occurred.
 	 */
-	if (!(vma->vm_flags & vm_flags)) {
+	if (unlikely(!(vma->vm_flags & vm_flags))) {
 		mmap_read_unlock(mm);
 		fault = 0;
 		code = SEGV_ACCERR;
 		goto bad_area;
 	}
 
 	fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
 	 * it would already be released in __lock_page_or_retry in
 	 * mm/filemap.c. */
-	if (fault_signal_pending(fault, regs)) {
+	if (unlikely(fault_signal_pending(fault, regs))) {
 		if (!user_mode(regs))
 			goto no_context;
 		return 0;
 	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
 		return 0;
 
-	if (!(fault & VM_FAULT_ERROR)) {
+	if (likely(!(fault & VM_FAULT_ERROR))) {
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 			goto retry;
 		}
 	}
 
 	mmap_read_unlock(mm);
 done:
 
 	/* Handle the "normal" case first */
-- 
2.48.1


