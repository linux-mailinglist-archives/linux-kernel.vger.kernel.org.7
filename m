Return-Path: <linux-kernel+bounces-835518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40305BA75B7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F6F3B9055
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B81253954;
	Sun, 28 Sep 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SORaCu2E"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273351DE3CB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759081696; cv=none; b=nUCBzVRYUZdLSOeGhexFBexOz+wLYSpcL2ONbiDlbykNcj+dsCaG3JVbYfk0JJUqqP0KTFdqtxrFP7e7dvvseIKJ6fY9temwnIWuAl9ERoPFO6HT3Y2AzA/chk+7nKS/gsBYNMqASaQE9vNIJXHMbgSVp4bN02o9bwmVX/L5EW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759081696; c=relaxed/simple;
	bh=4qNTlbFEjuH9bnCDI/3xbsjA3TN4w2pHJC6MjFBFSXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+uPXRiLT6uZtXh7QONCtIIyf9B6fTmWgsorNvwHLixGL5ci1v2PqIg5ZgHNZ2lTxsWqsna4EPivJZ00yRgeJVq8FOUb37C+VkPj1opM7Ygo2Wn52bbjAFB77/KdWcFLxbfQaWFMR2afsGduT3GgXWvMft1IK4bgy3zhFjgD5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SORaCu2E; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1759081666;
	bh=0od+6JBZeJ5IviLF7qLj8sUhTWwVv7Ij6LAzPVrXKRA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SORaCu2E9wyMThwRMBvXkvQ6KlU4LBLXyGv23PeD8z26hrvccgqdw0HFEC0Cs9Bto
	 0MT7cSVrn98JQi/z/RKeIHOLBLY49mi0YpM0sXYO35vj9gU1SPPEIXqikt/ua63jys
	 vsvlrWZ3w1AqEsk1WfglXfVWk+YGYwUxToJScerk=
X-QQ-mid: zesmtpgz9t1759081631t021883b7
X-QQ-Originating-IP: ifKfQK1/7p2OuYkam46LsyMMByw8Bz++5YdlIWb80RA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Sep 2025 01:47:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10726783025379362395
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v2] LoongArch: mm: try VMA lock-based page fault handling first
Date: Mon, 29 Sep 2025 01:43:41 +0800
Message-Id: <20250928174341.307295-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: N7fjnhHz1C62yd+e3T1r55oIq1HB/wiSpZZFoE4qis+Hb08RQPlo67cz
	sxrx0FsU9o98Vzx0MODUYgnIhFrp1ckO36XyFNjH2sbfHSWtQXR28Maq7pNfS0ir7iWkxmR
	xW8md5Bjo5rizcY8if+dUDlWRRviIpcrSiwgU48++bLYNsFY57KCTj6aB/htJDev2ArRdSy
	tK5F0GQTXPgzNqyjFhvgIZEtvXZtpt2O8kBVQmKkOQnTx5+h9yVmNWvnhxEESMDYrntO/Ur
	6XlyNFgu5pJF9YQQxRcIyRix7mJzMBo48PD3uoU0f3MCaTIZB21hyvqyXPmcQpgb2RXOl+z
	0QlJKp7VNDehnqm20zMDzS1Tk/2vULWQhnUWRjBrQyiPCoUDvXgUyEyd7U5tctrzBPMnixg
	GJ6D+Dv/jBirfXkU/gPrc719wJnk9NbDm2erbm33ovklH7R11AneayeVt7q9oPTeNLt34sz
	6KNPU0H0TM05+wJ38NesbENzwG30/nVdqG339SBIz7M8DOquBUaPErItJYjN1ZQyGgEBIIv
	KXcbusjD9ikVMUN7gw7+NQlQYI//drjM7aE6KaS8BVyzZ1edfqU39z4Yfr+H0sleKiXvVzE
	2HQfaaR7yemo9/Q+gloT5Qj9DNO1+rAibQ5QhxFSZGFO0Tl+F2500Mw3iMsTvL2/gBLmQBd
	UHa/Hvxg8D6T7dDBP4eDDtny4GM04cQl+E2VkMw4aqBrN7rrNvdqY2jIgVkJ9jBOi+FQkWy
	O5AR+zPpqTjHV8Gbvw/c48nLJJQ5NIm4hFA1T1jWtJC4en2NVE3l4Cs3Mfu/3NBAksQtyci
	pCtvn4t80azA6mF4N6UFdMJzfqzeWWblRx8letPpz9BsGkTEaqp/izTrhh64x2o/2cOtoLc
	+GN1uQmlZ21Hnvu/Lzp0j7qGfO1yHhmOeBFMl3Fms2ItP+U2G0SXMdcKtD6bfcQXv5efC+o
	7r6Yi1bC3pbpWBDYaOjP9i2YoH2l3RCtCCkb9k0ABN8C9MdS9Fi1TmqpGU4LFZ72L9jPa26
	gpCQVuAy9rCsUlvF83rfff2VOTq/eua54QcltsUKG28JuQEjSs
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

The "ebizzy -mTRp" on 3A6000 shows that PER_VMA_LOCK can
improve the benchmark by about 17.9%(97837.7 to 115430.8).

This is the loongarch variant of "x86/mm: try VMA lock-based page fault
handling first".

Let us discuss the four fault cases after handle_mm_fault
1.fault_signal_pending(fault, regs):
handle before goto done.
2.fault & VM_FAULT_COMPLETED:
fallthrough to return.
3.fault & VM_FAULT_RETRY:
handle before goto done.
4.fault & VM_FAULT_ERROR:
reuse the origin way to handle.

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
v2 changelog:
1. fix bug when VM_FAULT_ERROR and miss some count_vm_vma_lock_event
2. update test result.
ebizzy-0.3(can download by phoronix-test-suite):
before patch:
97800 records/s
real 10.00 s user  0.25 s sys  13.54 s
97835 records/s
real 10.00 s user  0.27 s sys  13.51 s
97929 records/s
real 10.00 s user  0.26 s sys  13.53 s
97736 records/s
real 10.00 s user  0.31 s sys  13.48 s
97914 records/s
real 10.00 s user  0.30 s sys  13.50 s
97916 records/s
real 10.00 s user  0.31 s sys  13.48 s
97857 records/s
real 10.00 s user  0.28 s sys  13.51 s
97927 records/s
real 10.00 s user  0.24 s sys  13.55 s
97962 records/s
real 10.00 s user  0.41 s sys  13.39 s
97501 records/s
real 10.00 s user  0.20 s sys  13.53 s
after patch:
117938 records/s
real 10.00 s user  0.40 s sys  23.48 s
116762 records/s
real 10.00 s user  0.39 s sys  23.20 s
116412 records/s
real 10.00 s user  0.37 s sys  23.22 s
116047 records/s
real 10.00 s user  0.45 s sys  23.04 s
116324 records/s
real 10.00 s user  0.45 s sys  23.08 s
115854 records/s
real 10.00 s user  0.33 s sys  23.17 s
116350 records/s
real 10.00 s user  0.38 s sys  23.15 s
116040 records/s
real 10.00 s user  0.34 s sys  23.16 s
116021 records/s
real 10.00 s user  0.36 s sys  23.10 s
116560 records/s
real 10.00 s user  0.37 s sys  23.23 s
---

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/Kconfig    |  1 +
 arch/loongarch/mm/fault.c | 55 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0631a6b11281b..1c517954157c0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -69,6 +69,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index deefd9617d008..425b20f3b6b83 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -215,6 +215,56 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		flags |= FAULT_FLAG_USER;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, address);
+	if (!vma)
+		goto lock_mmap;
+
+	if (write) {
+		flags |= FAULT_FLAG_WRITE;
+		if (!(vma->vm_flags & VM_WRITE)) {
+			vma_end_read(vma);
+			si_code = SEGV_ACCERR;
+			count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+			goto bad_area_nosemaphore;
+		}
+	} else {
+		if (!(vma->vm_flags & VM_EXEC) && address == exception_era(regs)){
+			vma_end_read(vma);
+			si_code = SEGV_ACCERR;
+			count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+			goto bad_area_nosemaphore;
+		}
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address != exception_era(regs)){
+			vma_end_read(vma);
+			si_code = SEGV_ACCERR;
+			count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+			goto bad_area_nosemaphore;
+		}
+	}
+
+	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, write, address);
+		return;
+	}
+lock_mmap:
+
 retry:
 	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma))
@@ -276,8 +326,9 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		 */
 		goto retry;
 	}
+	mmap_read_unlock(mm);
+done:
 	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mmap_read_unlock(mm);
 		if (fault & VM_FAULT_OOM) {
 			do_out_of_memory(regs, write, address);
 			return;
@@ -290,8 +341,6 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		}
 		BUG();
 	}
-
-	mmap_read_unlock(mm);
 }
 
 asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
-- 
2.20.1


