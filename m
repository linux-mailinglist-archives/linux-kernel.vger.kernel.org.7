Return-Path: <linux-kernel+bounces-832124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F909B9E675
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5353219C4DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F92EAB63;
	Thu, 25 Sep 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IlUtM1nA"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831682EA72A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792825; cv=none; b=XRbLsCUIm1JLXKzNtU5tF7GnLTOAKmwGJy6L3JGlOJWw4rptXIG4Lij1HVC4jBjYLxya713DplpPe9yanZx9Aagwj904gArJUi1fM6zlFrwRMe+/aKntI6I7A+0qDU857qUcTkd7pzLOrv2IXAKWQYL8D2TJXGw5Gro23HXe06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792825; c=relaxed/simple;
	bh=auYht+0Ii8E8ToqtTSAbmUZiPI/dAKwRVeHbDcj1DPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=im7dtlr3uOrErb3/PZLSOi9G7jKyIGywxWoz6e3al47xn/+bc1DNsTOLIP66gFG1+ptfB670V1/41KljloWxNrNbOh06/PU3p5CLKbTCOB6JxkB5L2IukfUbEmS3FHjcEZ1hHZ8086gf0iUGEh2kFZQAiTP9eW+uZ2QCNDebaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IlUtM1nA; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1758792784;
	bh=PUqKWUWGOy3vCXTCSh8ME4dr34YvDSo7AVqS5AKddLU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IlUtM1nAbKpNC34I0i4n1OCi1MJonAFJ/Ojg450X5HZ9leHKzpyN2vi6I7SN24gF4
	 aYIZctz2pJAv+p5PmPDAkH6NpvaXCN3/I7zx5JooMMy056wnrmChJw0pke5qaqJgEi
	 4LHiEwIMknK24bITl9wKpo/KHhlpB3DvZlkj/I9Q=
X-QQ-mid: zesmtpsz7t1758792750t10d2a62f
X-QQ-Originating-IP: xVRMiDpisEXjZ9YtxmnV1wJtbRo8IJPujb5Zovub53o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Sep 2025 17:32:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4921902207246476678
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH] LoongArch: mm: try VMA lock-based page fault handling first
Date: Thu, 25 Sep 2025 17:29:02 +0800
Message-Id: <20250925092902.1366058-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MQb3KhmQP37MXN3ucjQB8D9eIoxlFKurU8wuF4boBcYAe81MiiTi2gJv
	k4kTZp+UrmsTFmPpl1u7N4lu1XEFrFuA2TD4lBG9JP2jqCpNhd+p5zpJOtWE2C/aCr1PJZy
	5pA4yzwLfaRR/n22yARMzZVt9vo/etsgaTTq/IWpmM6Uuo8hMPae8p0hsc4y6D7HL2/ai/5
	QpCzOS0EgIVOCfyXDGk3IVNgOmfJd9JyvJ9/Kq3NwDmZHg9VvSZIBkxX9zaqYmvW4pVx6Cw
	WkqDT2BFThg+WvBpflJ+t330Yv4eRJYvkpghZoN25PqwQaeyzGbatZYte2Yb6vXpnFbfRug
	1OxH2SwKZ2Biv+Lml0k1Vo4FEicuLCK44Y1bxmomUq5ZCuzWwVu8vyYwnamgxjD6j1DmrBU
	rOG7xaU9EnJ0SWmrB06L+Y61WWqLCRmcs4tjLjcsECPQdQ3HN04xc5bLLxC4dOujmfPsJo2
	Ivk+Hdq28RMBiRnbdaCUHm4whi/f0J/yECOLOaYshGJL77aQ7grC7Y/kBz3GKApnKIMiAJ2
	kAkrX7Re9pxTwhzxI3oUs6P7UJtuo4qvr8oMoUPxIRazPe+oZJCXh3f5pin+f0NB3GYDkNS
	w/maCrnaaMX7ah0nWzUMBCEo07pAiXC1r1YAer+Ke3RraToGmy4r58lmLsnShONVxxTxP4J
	ewAdfHC7Da4k67pCOHFYrtqQa8BZKxPWwCy0OxVzwnHTNYQVok3cQs8YPU0ED2DVg5SeJ62
	aNnWK/vkU1GOsnVDG2iXtta0D40YJzik8BKEuwJLBs6EP8pFihyJ8FIaLV/UVkSsavJbtqV
	mRsc0m5mlZ2tz9nQ/8QCwTIH47Mnj2YzaIhJswPt99latWTq1LiWEWHlMzBoDn4ZP15NL39
	uPtBX7SktYzgQIwfXvCU/DWnV4ccvVnffkBmQl4FvFmIq3WmghEk2G9zTTied8b8Z9mtRcg
	RGO88rJ70Obp9ewsuM5zCI+JmbH8LyowRLcucxKTCvCkMdAKnuUzged4xadtwhD7k9mttn0
	E9nrsZ/n75BluW1le7zNfcoYa3O3mNyHs8kFhDOA1PJ/gKgV3xl4qZTSYKy0U=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails.

The "ebizzy -mTRp" on 3A6000 shows that PER_VMA_LOCK can
improve the benchmark by about 20.7%.

This is the loongarch variant of "x86/mm: try VMA lock-based page fault
handling first".

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
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
117645 records/s
real 10.00 s user  0.31 s sys  23.17 s
118207 records/s
real 10.00 s user  0.37 s sys  23.18 s
118426 records/s
real 10.00 s user  0.32 s sys  23.14 s
118172 records/s
real 10.00 s user  0.44 s sys  23.07 s
118548 records/s
real 10.00 s user  0.45 s sys  23.04 s
118011 records/s
real 10.00 s user  0.32 s sys  23.15 s
118143 records/s
real 10.00 s user  0.41 s sys  23.09 s
118181 records/s
real 10.00 s user  0.42 s sys  23.12 s
117721 records/s
real 10.00 s user  0.34 s sys  23.17 s
118138 records/s
real 10.00 s user  0.42 s sys  23.04 s
---
---
 arch/loongarch/Kconfig    |  1 +
 arch/loongarch/mm/fault.c | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index deefd9617d008..d2dc3e194dd76 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -215,6 +215,53 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
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
+			goto bad_area_nosemaphore;
+		}
+	} else {
+		if (!(vma->vm_flags & VM_EXEC) && address == exception_era(regs)){
+			vma_end_read(vma);
+			si_code = SEGV_ACCERR;
+			goto bad_area_nosemaphore;
+		}
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address != exception_era(regs)){
+			vma_end_read(vma);
+			si_code = SEGV_ACCERR;
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
@@ -292,6 +339,8 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+done:
+	return;	
 }
 
 asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
-- 
2.20.1


