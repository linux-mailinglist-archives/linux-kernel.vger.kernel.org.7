Return-Path: <linux-kernel+bounces-741836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56400B0E98B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDF14E8313
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDA20FAB4;
	Wed, 23 Jul 2025 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pNqCtW0M"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB702594
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244309; cv=none; b=TMULdA946UNcA68LqFJSZ5lJzqLC3UGBZEK0jT8G71ZxK1dRi1rVVP15qi3frs+xkqmW+GR160BQwkP1DZf7UFUdRsgW7j2yA/gVVmoc25EuXH2yNjded3iCH29YW+7XsOvsV8YwxKFvczdnY1ETql3SFgnyF6Nzf5bS7XBNGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244309; c=relaxed/simple;
	bh=WJ23vpzdRqE8SEbtzf8pS7/yeG7RDBCvQbMcNICOdvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnkxGgIoNlEPwIg8CtuVTqf26877V6kmH+LgsDbbuGIMnwyg3E+PrBpkp6BIDftbgJ1duPABkLhAl+N6/BFxJmJXG/SeuztqRoA3eZHnS3eeU+HdLrdod9otZyhs3bkhHq7TlEF4niCeVPXA4pIwtOwOcWvf/wO08ER/U8h8YkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pNqCtW0M; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748feca4a61so3430466b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753244306; x=1753849106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TaPjoUJwv9Etp1fT/nKK3BG4ePkhHW+sFnAWEuxVio=;
        b=pNqCtW0MwTNn5TaGzJ0oES9FTNqwu49jcITAQ9PqOVpG8O7dfi4n+8uuQP/bLMs7RH
         zcjLmJY7bsdj/3h4j+djadrA0r3CIx7zqluR9KDjF44aO2Qve0tMM/Btyf/Pb6udpFyZ
         m00nI0hRv6i0uLPq/5V9LnsVBElTpqGzilUpuiSdT2t8VYu7BNBLVhYpu9PYO+PO2mcL
         w2nvqodTk5FIH+qdBr0CKwaoG4jP0xVHqFsh4nWyBV0C8njCq7KNYB2caSGjYUeHioh9
         9gQgPxZkK3wvcIekOi3rgXKkpzNoeC6areCUzbSwzpYWRGVG68segZdfv0tIdVcgcDgq
         6aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753244306; x=1753849106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TaPjoUJwv9Etp1fT/nKK3BG4ePkhHW+sFnAWEuxVio=;
        b=BWjydbYJfDfEAUkIr9zdFLLtnAbofToHyEq5fjYqNzl2ZK5kf63mw6/SXyAIwXFay6
         7sMw2QhwLjGpBJrY+om9DeAGx9LFSQo6kpsQb38x+vZDA4r42vt/dagiTAUStU3ko6cG
         F+A6z4bv9St36asOWva0HbXaJZOB224QBBKSqWneqzcGmngtzkdgBbTuc98RxswiZOzk
         UgEmMevwktDCqSCcPfMMXCE/v2TZfwIDketNtVXFCqE6lCPXcPYemSXzRjsERaGZC0sZ
         P6gSL1G1LqE6624hP4O18QrSVx1k7RZ8XdvtWWkr72+20CZDTbks61CLk5pCCic9Ddqw
         722Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPVEl4p4kQ7P9Xy3F+JoM8Dv3wvS9zHDoMVCVegF0KfC4B60pKNR8jzD3AAThli/82cdlzmMWei5K+mJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmL8U38XAKkQ5Inc5LcBkRMnWsCan7h1hjq6T/nF1gx5adPyR
	42WyfHm3Qx2Gjvz7p+cgyLwW1yHgsxSELT09JVOlXJ+UTPlPu0RtPixBMauUilzm2gs=
X-Gm-Gg: ASbGncvmyxCOhHvE+RwFoCjz8vBjAY59YUk3CS3GsIMdJf2fDjQnnPuN21QygylHqOR
	enC00Kbjgxfwz7L1S+HbKXVkld8BQP5d3mLgGwYUXIt92tElVRLsUtu+d94Audz6J5oK9Ecj5M7
	MkUW3IkKJWnjDo+GvzMbGnO0EE/NFJTQ1pENYOQXmjiAevbgjoiHbzaQbEbt/0zUegojYNK5W18
	lKiLKgLKc+ROERN7QuyTKcmrJHzDKb4USTX5tT2JvyHeaIc/AkGoniAnZ3h3RyxZl/j6pWRr7zi
	ncV42vWN2J1e2Jytv+nea9w0SwYjowzHVNqXpYKvhZg9GYsqQ9OsnLi4izNvt0eqKvW0F6mcQfH
	b9mAJo+rqkcU9BSDB845prurFV+7yo3tX
X-Google-Smtp-Source: AGHT+IFA0YBcJMnJhHP3FPjc3REPEkZAG5QXhqFnyh6OJFA1c0QUKVHohKaPiDE95kjr2eXjEimzkQ==
X-Received: by 2002:a05:6a00:4614:b0:740:a023:5d60 with SMTP id d2e1a72fcca58-760353db72fmr2543842b3a.19.1753244306301;
        Tue, 22 Jul 2025 21:18:26 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2a88sm8770962b3a.23.2025.07.22.21.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:18:25 -0700 (PDT)
Date: Tue, 22 Jul 2025 21:18:23 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>, Nylon Chen <nylon.chen@sifive.com>
Subject: Re: [RFC PATCH 6/6] riscv: ptrace: Add hw breakpoint support
Message-ID: <aIBij4hr3Jna8OjV@debug.ba.rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
 <20250722173829.984082-7-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250722173829.984082-7-jesse@rivosinc.com>

On Tue, Jul 22, 2025 at 10:38:29AM -0700, Jesse Taube wrote:
>Add ability to setup hw breakpoints to ptrace. Call defines a new
>structure of (ulong[3]){bp_addr, bp_len, bp_type} with
>bp_type being one of HW_BREAKPOINT_LEN_X and
>bp_len being one of HW_BREAKPOINT_X with a value of
>zero dissabling the breakpoint.
>
>Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>---
> arch/riscv/include/asm/processor.h   |  4 ++
> arch/riscv/include/uapi/asm/ptrace.h |  3 +-
> arch/riscv/kernel/hw_breakpoint.c    | 14 ++++-
> arch/riscv/kernel/process.c          |  4 ++
> arch/riscv/kernel/ptrace.c           | 93 ++++++++++++++++++++++++++++
> 5 files changed, 116 insertions(+), 2 deletions(-)
>
>diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>index 5f56eb9d114a..488d956a951f 100644
>--- a/arch/riscv/include/asm/processor.h
>+++ b/arch/riscv/include/asm/processor.h
>@@ -12,6 +12,7 @@
>
> #include <vdso/processor.h>
>
>+#include <asm/hw_breakpoint.h>
> #include <asm/ptrace.h>
>
> #define arch_get_mmap_end(addr, len, flags)			\
>@@ -108,6 +109,9 @@ struct thread_struct {
> 	struct __riscv_v_ext_state vstate;
> 	unsigned long align_ctl;
> 	struct __riscv_v_ext_state kernel_vstate;
>+#ifdef CONFIG_HAVE_HW_BREAKPOINT
>+	struct perf_event *ptrace_bps[RV_MAX_TRIGGERS];
>+#endif
> #ifdef CONFIG_SMP
> 	/* Flush the icache on migration */
> 	bool force_icache_flush;
>diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
>index a38268b19c3d..a7998ed41913 100644
>--- a/arch/riscv/include/uapi/asm/ptrace.h
>+++ b/arch/riscv/include/uapi/asm/ptrace.h
>@@ -14,7 +14,8 @@
>
> #define PTRACE_GETFDPIC_EXEC	0
> #define PTRACE_GETFDPIC_INTERP	1
>-
>+#define PTRACE_GETHBPREGS	2
>+#define PTRACE_SETHBPREGS	3

Why not use `PTRACE_GETREGSET` `PTRACE_SETREGSET` ?

> /*
>  * User-mode register state for core dumps, ptrace, sigcontext
>  *
>diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
>index 437fd82b9590..c58145464539 100644
>--- a/arch/riscv/kernel/hw_breakpoint.c
>+++ b/arch/riscv/kernel/hw_breakpoint.c
>@@ -633,7 +633,19 @@ void arch_uninstall_hw_breakpoint(struct perf_event *event)
> 		pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
> }
>
>-void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
>+/*
>+ * Release the user breakpoints used by ptrace
>+ */
>+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>+{
>+	int i;
>+	struct thread_struct *t = &tsk->thread;
>+
>+	for (i = 0; i < dbtr_total_num; i++) {
>+		unregister_hw_breakpoint(t->ptrace_bps[i]);
>+		t->ptrace_bps[i] = NULL;
>+	}
>+}
>
> void hw_breakpoint_pmu_read(struct perf_event *bp) { }
>
>diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>index 15d8f75902f8..9cf07ecfb523 100644
>--- a/arch/riscv/kernel/process.c
>+++ b/arch/riscv/kernel/process.c
>@@ -9,6 +9,7 @@
>
> #include <linux/bitfield.h>
> #include <linux/cpu.h>
>+#include <linux/hw_breakpoint.h>
> #include <linux/kernel.h>
> #include <linux/sched.h>
> #include <linux/sched/debug.h>
>@@ -164,6 +165,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>
> void flush_thread(void)
> {
>+	flush_ptrace_hw_breakpoint(current);
> #ifdef CONFIG_FPU
> 	/*
> 	 * Reset FPU state and context
>@@ -218,6 +220,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
> 		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
>
> 	memset(&p->thread.s, 0, sizeof(p->thread.s));
>+	if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
>+		memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
>
> 	/* p->thread holds context to be restored by __switch_to() */
> 	if (unlikely(args->fn)) {
>diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
>index ea67e9fb7a58..b78cfb0f1c0e 100644
>--- a/arch/riscv/kernel/ptrace.c
>+++ b/arch/riscv/kernel/ptrace.c
>@@ -9,11 +9,13 @@
>
> #include <asm/vector.h>
> #include <asm/ptrace.h>
>+#include <asm/hw_breakpoint.h>
> #include <asm/syscall.h>
> #include <asm/thread_info.h>
> #include <asm/switch_to.h>
> #include <linux/audit.h>
> #include <linux/compat.h>
>+#include <linux/hw_breakpoint.h>
> #include <linux/ptrace.h>
> #include <linux/elf.h>
> #include <linux/regset.h>
>@@ -336,12 +338,103 @@ void ptrace_disable(struct task_struct *child)
> {
> }
>
>+#ifdef CONFIG_HAVE_HW_BREAKPOINT
>+static void ptrace_hbptriggered(struct perf_event *bp,
>+				struct perf_sample_data *data,
>+				struct pt_regs *regs)
>+{
>+	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
>+	int num = 0;
>+
>+	force_sig_ptrace_errno_trap(num, (void __user *)bkpt->address);
>+}
>+
>+/*
>+ * idx selects the breakpoint index.
>+ * Both PTRACE_GETHBPREGS and PTRACE_SETHBPREGS transfer three 32-bit words:
>+ * address (0), length (1), type (2).
>+ * Instruction breakpoint length is one of HW_BREAKPOINT_LEN_X or 0. 0 will
>+ * disable the breakpoint.
>+ * Instruction breakpoint type is one of HW_BREAKPOINT_X.
>+ */
>+
>+static long ptrace_gethbpregs(struct task_struct *child, unsigned long idx,
>+			      unsigned long __user *datap)
>+{
>+	struct perf_event *bp;
>+	unsigned long user_data[3] = {0};
>+
>+	if (idx >= RV_MAX_TRIGGERS)
>+		return -EINVAL;
>+
>+	bp = child->thread.ptrace_bps[idx];
>+
>+	if (!IS_ERR_OR_NULL(bp)) {
>+		user_data[0] = bp->attr.bp_addr;
>+		user_data[1] = bp->attr.disabled ? 0 : bp->attr.bp_len;
>+		user_data[2] = bp->attr.bp_type;
>+	}
>+
>+	if (copy_to_user(datap, user_data, sizeof(user_data)))
>+		return -EFAULT;
>+
>+	return 0;
>+}
>+
>+static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
>+			      unsigned long __user *datap)
>+{
>+	struct perf_event *bp;
>+	struct perf_event_attr attr;
>+	unsigned long user_data[3];
>+
>+	if (idx >= RV_MAX_TRIGGERS)
>+		return -EINVAL;
>+
>+	if (copy_from_user(user_data, datap, sizeof(user_data)))
>+		return -EFAULT;
>+
>+	bp = child->thread.ptrace_bps[idx];
>+	if (IS_ERR_OR_NULL(bp))

Why not only check for NULL?
IS_ERR_VALUE will always expand to be true. right?

>+		attr = bp->attr;
>+	else
>+		ptrace_breakpoint_init(&attr);
>+
>+	attr.bp_addr = user_data[0];
>+	attr.bp_len = user_data[1];
>+	attr.bp_type = user_data[2];
>+	attr.disabled = !attr.bp_len;

Is it okay to not have any sanitization on inputs?

Can these inputs be controlled by user to give kernel address and kernel
breakpoint?

>+
>+	if (IS_ERR_OR_NULL(bp)) {
>+		bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
>+					   child);
>+		if (IS_ERR(bp))
>+			return PTR_ERR(bp);
>+
>+		child->thread.ptrace_bps[idx] = bp;
>+		return 0;
>+	} else {
>+		return modify_user_hw_breakpoint(bp, &attr);
>+	}
>+}
>+#endif
>+
> long arch_ptrace(struct task_struct *child, long request,
> 		 unsigned long addr, unsigned long data)
> {
> 	long ret = -EIO;
>+	unsigned long __user *datap = (unsigned long __user *) data;
>
> 	switch (request) {
>+#ifdef CONFIG_HAVE_HW_BREAKPOINT
>+	case PTRACE_GETHBPREGS:
>+		ret = ptrace_gethbpregs(child, addr, datap);
>+		break;
>+
>+	case PTRACE_SETHBPREGS:
>+		ret = ptrace_sethbpregs(child, addr, datap);
>+		break;
>+#endif
> 	default:
> 		ret = ptrace_request(child, request, addr, data);
> 		break;
>-- 
>2.43.0
>

