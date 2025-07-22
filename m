Return-Path: <linux-kernel+bounces-741316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD51B0E2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93744189A886
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F02820CB;
	Tue, 22 Jul 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bh5i/xhT"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8F280CD3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205922; cv=none; b=Q0UySZXxRLiZguyCf64Q2BSSL6qgvtYVXZRb4KkTwZkb51sMk0GwKxUziRGBfdjzhF425INR1QeDQ0Lcbxu18sveC9XSWnaSaoMDfF9FdMLQn0LZa/u67IAY3nX250ZrDAEwcbLjxPpz3dLVK92l79/M6wIZai3yKb2qEIjSA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205922; c=relaxed/simple;
	bh=sMLCGSmu8KncOlTxjhANnVEeXKxV6ZmjtWlYdkXHxgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlSZ27toup+vwysg6K4cBTXMrrRGjlWAiYl8s0t9do+5iIyRvJx0+HZsOp/6ygigAR1BOAimzeTTq9jRXgNGYSaCMFBOIe6cw2XqkDK0gT9rmuYPuXeNtw7NlaA9692PpkAKGuvMocq9FHHavXavG8uVmqgiJfHP2tvuhfJNHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bh5i/xhT; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso57402166d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753205919; x=1753810719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pehe5qahEzM3t46HZmGT5lx1CIRt9G4s5EVYhqPzIU=;
        b=bh5i/xhTRRFP0VGklOZt1tCxF5agQ2N7q8F9RqcdNFTx226mwNjwd+Gtmj020baMxH
         Cw2kPdBAjHAvdD89MEvo+mxcLndPOplODgh0XsePuSx3sjhGon2/xhCgNzjKGpU3WZ4H
         JzsjZWJGOpeP2f6xP18aIm04dNGdmjxpRwegGKk1nOBwUqylJ9KGXf8TRG5g9761SfiN
         lJcGYVbDx2eY+AIMy8gOGTKXiIE9EWboLidIB+4Sn/T4F4uOsXVuD+doPUpB/JPlxWhA
         Kh62jxBDYgDl8DQYHbWR/OxUSR9PXtamdMltcZnk3mZhqavjAtqY2vBH4fSGNjxQ80wy
         bMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205919; x=1753810719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pehe5qahEzM3t46HZmGT5lx1CIRt9G4s5EVYhqPzIU=;
        b=PR8F1u+xf+6dg4UeORcip2enn2ckDmqGXVNQjfnQL0eDUwuTxbaQE5qJo8310ebQtQ
         +pwjJfoxHRLsW4rRZmN5EcsWd8joB1o1EGo1jHqlzdemDYEmQ6PUfPJ5UhIRQzGbz9DM
         LBQpaOg18C9rV6Ql6IUfZQ3Alap9zaDOkUYhoQClLCJo5dzueIUmYWcOsqvUzg30tGjk
         OtLBWIzA0Y2NQV/mo4t0WG4Dg4ehH/v/Blql0e7JJfet0USfl+/0Imw4oPVe1Rs6yYLI
         Wn7HppcRXZhrD0Xyica6YDbykPX06PklM7TdVTSVkvrgOedVL2zShxvxKvXLCMqmYaXg
         2yWw==
X-Forwarded-Encrypted: i=1; AJvYcCWtpBXXDJF3Ke0owvL+bwiKF86DE8narISujbdw+zHIlSwpZbmnBQk5ttxCSQfw37SrlqnvjfpGNor6ZIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CHOffiWCwsrBiJf2//wlosmbQpoddT0+0K2LG92c0+KnoGWB
	tyTtye8EtS8Zn++sVTnqwjjCxW11T/wxUgkkEvI6fHZmn/94Q9zOtYN93rJDeUVwl58=
X-Gm-Gg: ASbGncsq+IKC8jI9eY5wMkmBdjVj/D5gyQnzQuJg2ru4IiEBWMhgji59UFLhm5wd3li
	7Q0XGCTEsfeohYsD2laRdxcefk0RgcSMcqo9ajYjThmmLFSHWjC2KWV1BZyPFYRiVxtnWEm54yZ
	+E6J73QrzST5vsCdjByTSAfcKK3Ykc0jqjBTpTJ8XvD2I3U0xAnWM6wSyBfWOHqjx9Xz4qNCmto
	0XGBUHpPCRiUscx4E3pQyfXxFOGbPeZOWoCVvTksR7QqgRBj7VfIhvOe1FPpBEVbBSmdgihLu+6
	uhZBVnW18vjhr5yvPaZMqcB8UK+Wn730QoXnVtnanSR1kc49RxffeHp6p7xB5R8QT67JLRi2BIa
	EsWS/vYA/kAganYg6pWGu1DTWhBJnPONuOXAewOZohbDC02uk547v5nZHc/07wZ+cAy7Wl39yRz
	2XpnF9fr0MVgU=
X-Google-Smtp-Source: AGHT+IHNmIeff1tiB4Sc65YqOosgC6ntLXzFGJQ4ydDztiuS5x6ubxGzTt6eEnVnsJPxfjwF05Z/jw==
X-Received: by 2002:a05:6214:e86:b0:704:a91e:2874 with SMTP id 6a1803df08f44-707005646e7mr176096d6.19.1753205919317;
        Tue, 22 Jul 2025 10:38:39 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm54184536d6.73.2025.07.22.10.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:38:39 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [RFC PATCH 6/6] riscv: ptrace: Add hw breakpoint support
Date: Tue, 22 Jul 2025 10:38:29 -0700
Message-ID: <20250722173829.984082-7-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722173829.984082-1-jesse@rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to setup hw breakpoints to ptrace. Call defines a new
structure of (ulong[3]){bp_addr, bp_len, bp_type} with
bp_type being one of HW_BREAKPOINT_LEN_X and
bp_len being one of HW_BREAKPOINT_X with a value of
zero dissabling the breakpoint.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  4 ++
 arch/riscv/include/uapi/asm/ptrace.h |  3 +-
 arch/riscv/kernel/hw_breakpoint.c    | 14 ++++-
 arch/riscv/kernel/process.c          |  4 ++
 arch/riscv/kernel/ptrace.c           | 93 ++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..488d956a951f 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,6 +12,7 @@
 
 #include <vdso/processor.h>
 
+#include <asm/hw_breakpoint.h>
 #include <asm/ptrace.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
@@ -108,6 +109,9 @@ struct thread_struct {
 	struct __riscv_v_ext_state vstate;
 	unsigned long align_ctl;
 	struct __riscv_v_ext_state kernel_vstate;
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	struct perf_event *ptrace_bps[RV_MAX_TRIGGERS];
+#endif
 #ifdef CONFIG_SMP
 	/* Flush the icache on migration */
 	bool force_icache_flush;
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..a7998ed41913 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -14,7 +14,8 @@
 
 #define PTRACE_GETFDPIC_EXEC	0
 #define PTRACE_GETFDPIC_INTERP	1
-
+#define PTRACE_GETHBPREGS	2
+#define PTRACE_SETHBPREGS	3
 /*
  * User-mode register state for core dumps, ptrace, sigcontext
  *
diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
index 437fd82b9590..c58145464539 100644
--- a/arch/riscv/kernel/hw_breakpoint.c
+++ b/arch/riscv/kernel/hw_breakpoint.c
@@ -633,7 +633,19 @@ void arch_uninstall_hw_breakpoint(struct perf_event *event)
 		pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
 }
 
-void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
+/*
+ * Release the user breakpoints used by ptrace
+ */
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < dbtr_total_num; i++) {
+		unregister_hw_breakpoint(t->ptrace_bps[i]);
+		t->ptrace_bps[i] = NULL;
+	}
+}
 
 void hw_breakpoint_pmu_read(struct perf_event *bp) { }
 
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 15d8f75902f8..9cf07ecfb523 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -9,6 +9,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cpu.h>
+#include <linux/hw_breakpoint.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
@@ -164,6 +165,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 
 void flush_thread(void)
 {
+	flush_ptrace_hw_breakpoint(current);
 #ifdef CONFIG_FPU
 	/*
 	 * Reset FPU state and context
@@ -218,6 +220,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
 
 	memset(&p->thread.s, 0, sizeof(p->thread.s));
+	if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
+		memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 	/* p->thread holds context to be restored by __switch_to() */
 	if (unlikely(args->fn)) {
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index ea67e9fb7a58..b78cfb0f1c0e 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -9,11 +9,13 @@
 
 #include <asm/vector.h>
 #include <asm/ptrace.h>
+#include <asm/hw_breakpoint.h>
 #include <asm/syscall.h>
 #include <asm/thread_info.h>
 #include <asm/switch_to.h>
 #include <linux/audit.h>
 #include <linux/compat.h>
+#include <linux/hw_breakpoint.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
 #include <linux/regset.h>
@@ -336,12 +338,103 @@ void ptrace_disable(struct task_struct *child)
 {
 }
 
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+static void ptrace_hbptriggered(struct perf_event *bp,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	int num = 0;
+
+	force_sig_ptrace_errno_trap(num, (void __user *)bkpt->address);
+}
+
+/*
+ * idx selects the breakpoint index.
+ * Both PTRACE_GETHBPREGS and PTRACE_SETHBPREGS transfer three 32-bit words:
+ * address (0), length (1), type (2).
+ * Instruction breakpoint length is one of HW_BREAKPOINT_LEN_X or 0. 0 will
+ * disable the breakpoint.
+ * Instruction breakpoint type is one of HW_BREAKPOINT_X.
+ */
+
+static long ptrace_gethbpregs(struct task_struct *child, unsigned long idx,
+			      unsigned long __user *datap)
+{
+	struct perf_event *bp;
+	unsigned long user_data[3] = {0};
+
+	if (idx >= RV_MAX_TRIGGERS)
+		return -EINVAL;
+
+	bp = child->thread.ptrace_bps[idx];
+
+	if (!IS_ERR_OR_NULL(bp)) {
+		user_data[0] = bp->attr.bp_addr;
+		user_data[1] = bp->attr.disabled ? 0 : bp->attr.bp_len;
+		user_data[2] = bp->attr.bp_type;
+	}
+
+	if (copy_to_user(datap, user_data, sizeof(user_data)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
+			      unsigned long __user *datap)
+{
+	struct perf_event *bp;
+	struct perf_event_attr attr;
+	unsigned long user_data[3];
+
+	if (idx >= RV_MAX_TRIGGERS)
+		return -EINVAL;
+
+	if (copy_from_user(user_data, datap, sizeof(user_data)))
+		return -EFAULT;
+
+	bp = child->thread.ptrace_bps[idx];
+	if (IS_ERR_OR_NULL(bp))
+		attr = bp->attr;
+	else
+		ptrace_breakpoint_init(&attr);
+
+	attr.bp_addr = user_data[0];
+	attr.bp_len = user_data[1];
+	attr.bp_type = user_data[2];
+	attr.disabled = !attr.bp_len;
+
+	if (IS_ERR_OR_NULL(bp)) {
+		bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
+					   child);
+		if (IS_ERR(bp))
+			return PTR_ERR(bp);
+
+		child->thread.ptrace_bps[idx] = bp;
+		return 0;
+	} else {
+		return modify_user_hw_breakpoint(bp, &attr);
+	}
+}
+#endif
+
 long arch_ptrace(struct task_struct *child, long request,
 		 unsigned long addr, unsigned long data)
 {
 	long ret = -EIO;
+	unsigned long __user *datap = (unsigned long __user *) data;
 
 	switch (request) {
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	case PTRACE_GETHBPREGS:
+		ret = ptrace_gethbpregs(child, addr, datap);
+		break;
+
+	case PTRACE_SETHBPREGS:
+		ret = ptrace_sethbpregs(child, addr, datap);
+		break;
+#endif
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
-- 
2.43.0


