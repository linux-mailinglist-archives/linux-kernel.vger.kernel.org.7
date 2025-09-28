Return-Path: <linux-kernel+bounces-835527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C0BA7608
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 19:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBD17A01B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D159F2561AA;
	Sun, 28 Sep 2025 17:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="koZQlMYs"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC1255F24
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759082317; cv=none; b=Axto+5JDQIi5M9TKPY01F/Za+pox4QWUJmlRT2i7FFQCEZtk57WqodcZvPXFa77vBDdnR/FOr5XfCB+0w3HrUxsZqgaYzfQ66hGgvsDvdtrcynpquZikDWvRAPurBgpwrx899+MUeRbOqHA9mvaTTMPzbuKxS4Z0zxc8NxSfIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759082317; c=relaxed/simple;
	bh=zoth4Jd8+ebGp96SODsyzU/qIkA5bSTmUolQ8U3RIFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MebpXdeMCw/MowK7zT8gF6wJg0cIEDUGxL+rPGEhBb51d4uJYFAkNK4SPva0xCZzER5Qb0w82VWfo8mzCiVR+FS9+IehB4dxpOfRrtAuxQpQpcm+ON+lnStCqwZE0fuQHxtkT2Fyb6TQfHZnVbDOioNVvCE+oqyK6IGufu1a+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=koZQlMYs; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1759082279;
	bh=WgGAPDRLizaQ2tgi+7+CIMNXt69uicKpNncJAxaf35I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=koZQlMYsA1Da5x5bEFJHXbtZSx+3iOhg+HT/XqZjAtPZXQoannzgARsjN+QiRZ0MP
	 iHqCkS73j963JszL0+TePMvaL2zsQX9vaidUo+y/3m1I2VY4HBHG4ji4E/w5iHIaet
	 nusKc01igJZl5ha0QnpX4vZQ52yryG0B+Yd1sKR0=
X-QQ-mid: esmtpgz13t1759082244tc33ca4f5
X-QQ-Originating-IP: 1qcKc0aPTgmdkS23CtGBizQEl313ki0DE4YEetKRsV0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Sep 2025 01:57:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17229065183674050420
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: chenhuacai@kernel.org
Cc: kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH v3] LoongArch: mm: try VMA lock-based page fault handling first
Date: Mon, 29 Sep 2025 01:53:55 +0800
Message-Id: <20250928175355.308261-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MfU+/gEHf8gNdeSnhuPFY2CRNjcSuojhbnQ7+liofFH7/h2QZ4BKA45P
	w+kXkj4YgqR79LfF/lPL9XlaJnsuiR/VWHZVYN58nrdu4loEDWseYsdXsU9uotYezCpjHu1
	C38YezPr+fCKcvwbbAcE5NivdQARHMPU6kQXK9BMfma6oOPP7JLff4rwwky6WHR52PYDz0j
	D7FLkBeY6LtpdMylueFEnRxC/3PoNjjJHwpGetSNL31ZQuTGPQD6JKuAFmd2CabCMgMaCij
	f7Tvb+bDhJUV/mrjURvN+sGu3bX296jxzfAVRoFBo3k/0F03lLDYOjE08jkJb6L0ELjSLb3
	3kqi75So4Vl1k7XMZipLErzqJ5MNuiZ6v8/NNBCnVzmH0SGIFM+iQiN0GnZYaI/zVtBzP/Z
	7vfQKA/McQ89ZS3ucoCYKtKzxoMmQVhSo4dOu3tplVu0sD3pzbvU5v3EzX/VgI1uTvnE0yp
	pPOSd9jneu1cICeT7yyDA8en1Eu5NO15oDgF45wQ5NO6JMm3qD1SLVX41Jz+1XeZ2keWvt0
	0Dk6xVBwsuuFj35fzTp7IYzmrLcdDpbOBhB3FCfER8YE8dZBVE8lKU1awK3fn93amGUrsts
	dKEG9bKOzDJxYPUhC6G/DOfyLL0cK98M+4AonXc9ZRHOazDovPvAmAmOObCrtegYuANcPPK
	0uCQYrjA5mXLpO8sufhFDjYwsX5/AT9CP1xkPdfexzZCzzOze4/MpkNSrvAtTe/WEtCpCOt
	fWRDTq6/Epy3NzRrd5JrwasRPgARl2KI+nPEmuQc5Q+BbT7kI0oUe314FsOtozIJtVzkwEJ
	zQgW1H6hoIARxLE0EAmhcgcmJVeC+r6DNzNK3rznv2H+M3mBsV996lAopCvHbHQE+bwBcgb
	FrL85rE6OoDqOQnLssV0dcXIbvy9JzwlLmfCatXiXajjEfFrkEf97ox0kK1CkTPw7wdy2w0
	oTlNgckSKqWnbfwjGAh2KH9WQI64dao+FxCZqQkLQfnIhj4MuS5+5bEzDxtADXL+eLPztDZ
	9ujYvTWVRVrI0jX/IHXKCgi2IKr2krGjSFg6pjFRaKzbge2FnfOAJI8u9dgJzp9dmIgGRrw
	GrljkwbF9B1hwBPFpyqGD9YKLvNaXrnHvnSAlrmUkr3iiaxWhgaNUhUyAUk+fBL2w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
v3 changelog:
fix checkpatch format error.

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
index deefd9617d008..2ba9bba55fbb6 100644
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
+		if (!(vma->vm_flags & VM_EXEC) && address == exception_era(regs)) {
+			vma_end_read(vma);
+			si_code = SEGV_ACCERR;
+			count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+			goto bad_area_nosemaphore;
+		}
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address != exception_era(regs)) {
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


