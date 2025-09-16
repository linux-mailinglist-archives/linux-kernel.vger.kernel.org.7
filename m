Return-Path: <linux-kernel+bounces-818352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F1B5908B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A491BC0794
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17342F0688;
	Tue, 16 Sep 2025 08:25:43 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EC286426
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011143; cv=none; b=lWMz7J5QqB/Fl0YcYMgXVzT5BU7oBXU7iAICkaNkrvwjLTFnVEYGwaQIjXG7o32evX2sBoEtRIfSF/pyIi9DKDFai/isThiLSzHohOnkaCiRHov3pfPr7Rj6zHohWAQPmsuwr/MWmCrLiUcygVTDEmZ4aJ6RK7z1CwZGlOk5Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011143; c=relaxed/simple;
	bh=dUxXk0al+lfo78GpbOVgDBqwFTtJS2Ane+avqsVB+x8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3VTpqZ8lvw5xt8OZFlpZIzFs7Nb2C0hLaRDbu+usIKSUThvt+K3h+bzkSzivAIpIJY261XZuenhs9ruNgcP4uiboEI5JTrGeq5PkMr5VKZ/yRCjBkBeU428VnLauc/y2DupFootp8TNgjthxSo+fywC7NZxYeTlqUtuCG0H//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cQvyZ4lVfz2VRlC;
	Tue, 16 Sep 2025 16:22:14 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 352EC1A0171;
	Tue, 16 Sep 2025 16:25:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 16:25:37 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <charlie@rivosinc.com>,
	<macro@orcam.me.uk>, <deller@gmx.de>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v6 03/10] arm64/ptrace: Refator el0_svc_common()
Date: Tue, 16 Sep 2025 16:26:04 +0800
Message-ID: <20250916082611.2972008-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082611.2972008-1-ruanjinjie@huawei.com>
References: <20250916082611.2972008-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Compared to the generic entry code, arm64 terminate the process
after report_syscall_exit() if the syscall is issued within
a restartable sequence.

In preparation for moving arm64 over to the generic entry code,
refactor el0_svc_common() as below:

- Extract syscall_exit_to_user_mode_prepare() to replace the
  the combination of read_thread_flags() and syscall_trace_exit(),
  also move the syscall exit check logic into it.

- Move rseq_syscall() ahead, so the CONFIG_DEBUG_RSEQ check is
  not needed.

- Move has_syscall_work() helper into asm/syscall.h, which will be
  reused by ptrace.c.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/include/asm/syscall.h |  7 ++++++-
 arch/arm64/kernel/ptrace.c       | 10 +++++++++-
 arch/arm64/kernel/syscall.c      | 26 +++++---------------------
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index d69f590a989b..6225981fbbdb 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -114,7 +114,12 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
+static inline bool has_syscall_work(unsigned long flags)
+{
+	return unlikely(flags & _TIF_SYSCALL_WORK);
+}
+
 int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags);
-void syscall_trace_exit(struct pt_regs *regs, unsigned long flags);
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
 
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index bbb868f6b292..95984bbf53db 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2403,7 +2403,7 @@ int syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long flags)
 	return regs->syscallno;
 }
 
-void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
+static void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 {
 	audit_syscall_exit(regs);
 
@@ -2412,8 +2412,16 @@ void syscall_trace_exit(struct pt_regs *regs, unsigned long flags)
 
 	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
 		report_syscall_exit(regs);
+}
+
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long flags = read_thread_flags();
 
 	rseq_syscall(regs);
+
+	if (has_syscall_work(flags) || flags & _TIF_SINGLESTEP)
+		syscall_trace_exit(regs, flags);
 }
 
 /*
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 064dc114fb9b..a50db885fc34 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -65,11 +65,6 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	choose_random_kstack_offset(get_random_u16());
 }
 
-static inline bool has_syscall_work(unsigned long flags)
-{
-	return unlikely(flags & _TIF_SYSCALL_WORK);
-}
-
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
@@ -125,26 +120,15 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 		if (scno == NO_SYSCALL)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
 		scno = syscall_trace_enter(regs, regs->syscallno, flags);
-		if (scno == NO_SYSCALL)
-			goto trace_exit;
+		if (scno == NO_SYSCALL) {
+			syscall_exit_to_user_mode_prepare(regs);
+			return;
+		}
 	}
 
 	invoke_syscall(regs, scno, sc_nr, syscall_table);
 
-	/*
-	 * The tracing status may have changed under our feet, so we have to
-	 * check again. However, if we were tracing entry, then we always trace
-	 * exit regardless, as the old entry assembly did.
-	 */
-	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
-		flags = read_thread_flags();
-		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
-			return;
-	}
-
-trace_exit:
-	flags = read_thread_flags();
-	syscall_trace_exit(regs, flags);
+	syscall_exit_to_user_mode_prepare(regs);
 }
 
 void do_el0_svc(struct pt_regs *regs)
-- 
2.34.1


