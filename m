Return-Path: <linux-kernel+bounces-742974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8193B0F8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD60D568628
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA221771C;
	Wed, 23 Jul 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iJkGwW5D"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1C1FE44A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291392; cv=none; b=jPbJrIJA8lQRUXz03yFEB6YUwSzHc7oXMw/Np+bbllfC0YH93esLw3X00x2GjbSFmBk+Qb1ZqYxoJpHWXdvT1757uuILwiPs+uM1zR4979NH1NPkmAArp9o5gCGdav7RoLKOZG18lTaeOkyhmlWmxBQzJKNCVo24mQQod1jPTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291392; c=relaxed/simple;
	bh=89c0NehnKSjdDxtvQ523M84fmQt7jm/P3dvuVsjE8i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guAMh/24bKMFyI4uW4XQgzPrZlTiAYEh7IH2biI5pxqtPQxHKDMVdKfbzNCc4Nk5O/DjGGOHOOrqCX9NazqIfwuNEK8aIolf8oeQYsNgwGoclvu+/vz40lZWTTb+pE/M8oIeCwTMr3KZp5mItg3k3/Ttk4jMizw9O2T/ZG5MAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iJkGwW5D; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748e378ba4fso261594b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753291390; x=1753896190; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gZzLZVb3xyIld6X5p/usujO/Mtg8MXgowsKQnou8Wu8=;
        b=iJkGwW5D/IJd7Q4CLlG/woadhPd9in9teSc5J5+/CY8/M3kQrLZOldBx0k5586U0R+
         C/ZZlEgtbFMlNRM4SanlvShgFPR9I+8vYIjT7pBdbzWyv8qDt8WMe5IILsLvBMVN8tOL
         ANSQLjIfM5RDtpOR+AHgyMMIW6Kz9zw9Xw1YpjtAB/MVPszV0535+21uj8hVyqFeAUyI
         UI5dSyOQkUguLe4XpPRs1M4tOuxeArZyWcEHBBfk3gOj4eepEai9wWaLBIIJF7L9NHG3
         iLaBvf+PVUqevAGt3TkxecUofa55tucpUhGLtEecZ8mGyL7+MSZGu8Q1BH8GZlr5mlYd
         W3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291390; x=1753896190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZzLZVb3xyIld6X5p/usujO/Mtg8MXgowsKQnou8Wu8=;
        b=CdgVOGgRxpjlEzYTLoD6XHPLGl70K1481vGKCviM9gqSL8YroodczL5R+P0NP0tOmD
         pM/zWRKo1qb7jurWxh8bJJeFYkkqNTcInm2o/8BHwftKVkBd2cYJJX7aFRg5+08zbz0e
         sRF3ckhsl/ckwN7i6EGxukADmto86GYkhiT2MtOz3ZY6jE03utzTfxoEpBKJqXiIQU8d
         6wwHHbxv/udejr9HmhzoZpjovQH4GpXAGq3SF0gAIwot13qrLgQ0dPxq4SqeX7OHcNrO
         sDULMAJP0B9PtC0a2Vk6X7yfs0lWUNUdezS0Q7CSou5+SO/KEJbbF0ydpJAUNSz7X8tO
         Uxmg==
X-Forwarded-Encrypted: i=1; AJvYcCWBMQ5wiwjcNW41tCgYgHJ3VLYAYCNpUmI+TspgzleFTsJsq8nFOZpfqDFhb6//kY0On/VPweE1pmrTw58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo99YXMbIlUhIHcmX015LvheNDMspdxHZtIOehkrQJf21TzoVV
	aBqRxCwjwYMuqcD/MMe4fZ3o/mLCoQo/Wh1xsbK6T7WkWUR6I7OkMj+CDeZfhHfyDU0=
X-Gm-Gg: ASbGncuDj9D1iCnUTze7a9YRnr8MDtSUZ0hTmD9oOJyu3FC5yD+W/Sd0gAhkVjUlrav
	oVWnvqyJnfZIt88vuDA9heNidCBTmd7L0M82h7g9raUz8CzdY1238xUrwAfqMle6GX69kbi45l5
	2jPhrGNdcLQkVreusc0dTKNiqJDQA9hrAxiod96yZGTN9BN6WER8qCIT9bfb59LKFIDBnz8rLDT
	I8vZ21ubWecslotIExk+7zjw+6k+TbV5qzS0mFCBHv7oGrxREQ4VXJMWjOiJrOHSN52h7QxoNpa
	VoBdh+8GdCTtLJWEEAwC1EvC9NBbBHbQdETSc8OEQWHwbrYdr0m2iMijyOuRuQu5h8QFj/2CuDd
	8d5QJ0TEV9qr8nUE7T+Oe0HFdNWQXQxd8
X-Google-Smtp-Source: AGHT+IHzUtPKawIqkFt5Igo1MBp83lf/CM3Egcfzh15ZfVazcE1EcIjKr1I00hNV1fElvqn0wBjMmA==
X-Received: by 2002:a05:6a00:1823:b0:751:6ff5:df35 with SMTP id d2e1a72fcca58-76034c9066dmr6582847b3a.8.1753291389805;
        Wed, 23 Jul 2025 10:23:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68ba1sm10197019b3a.146.2025.07.23.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:23:09 -0700 (PDT)
Date: Wed, 23 Jul 2025 10:23:06 -0700
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
Message-ID: <aIEaeo-tNehdTeci@debug.ba.rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
 <20250722173829.984082-7-jesse@rivosinc.com>
 <aIBij4hr3Jna8OjV@debug.ba.rivosinc.com>
 <CALSpo=Y+hLsVC+w942Bhg628HuDqG=MU9+f87R5X616rhG11Mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSpo=Y+hLsVC+w942Bhg628HuDqG=MU9+f87R5X616rhG11Mw@mail.gmail.com>

On Wed, Jul 23, 2025 at 09:55:25AM -0700, Jesse Taube wrote:
>On Tue, Jul 22, 2025 at 9:18 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Tue, Jul 22, 2025 at 10:38:29AM -0700, Jesse Taube wrote:
>> >Add ability to setup hw breakpoints to ptrace. Call defines a new
>> >structure of (ulong[3]){bp_addr, bp_len, bp_type} with
>> >bp_type being one of HW_BREAKPOINT_LEN_X and
>> >bp_len being one of HW_BREAKPOINT_X with a value of
>> >zero dissabling the breakpoint.
>> >
>> >Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>> >---
>> > arch/riscv/include/asm/processor.h   |  4 ++
>> > arch/riscv/include/uapi/asm/ptrace.h |  3 +-
>> > arch/riscv/kernel/hw_breakpoint.c    | 14 ++++-
>> > arch/riscv/kernel/process.c          |  4 ++
>> > arch/riscv/kernel/ptrace.c           | 93 ++++++++++++++++++++++++++++
>> > 5 files changed, 116 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>> >index 5f56eb9d114a..488d956a951f 100644
>> >--- a/arch/riscv/include/asm/processor.h
>> >+++ b/arch/riscv/include/asm/processor.h
>> >@@ -12,6 +12,7 @@
>> >
>> > #include <vdso/processor.h>
>> >
>> >+#include <asm/hw_breakpoint.h>
>> > #include <asm/ptrace.h>
>> >
>> > #define arch_get_mmap_end(addr, len, flags)                   \
>> >@@ -108,6 +109,9 @@ struct thread_struct {
>> >       struct __riscv_v_ext_state vstate;
>> >       unsigned long align_ctl;
>> >       struct __riscv_v_ext_state kernel_vstate;
>> >+#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> >+      struct perf_event *ptrace_bps[RV_MAX_TRIGGERS];
>> >+#endif
>> > #ifdef CONFIG_SMP
>> >       /* Flush the icache on migration */
>> >       bool force_icache_flush;
>> >diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
>> >index a38268b19c3d..a7998ed41913 100644
>> >--- a/arch/riscv/include/uapi/asm/ptrace.h
>> >+++ b/arch/riscv/include/uapi/asm/ptrace.h
>> >@@ -14,7 +14,8 @@
>> >
>> > #define PTRACE_GETFDPIC_EXEC  0
>> > #define PTRACE_GETFDPIC_INTERP        1
>> >-
>> >+#define PTRACE_GETHBPREGS     2
>> >+#define PTRACE_SETHBPREGS     3
>>
>> Why not use `PTRACE_GETREGSET` `PTRACE_SETREGSET` ?
>
>Because it was easier to implement this first, and REGSET will be
>another commit ontop of this one.
>Unless there is a reason to not have this version.
>

Yeah I don't have strong feelings on this. Whatever is best for the tools
(gdb, etc) who will consume this interface, lets do that.

>>
>> > /*
>> >  * User-mode register state for core dumps, ptrace, sigcontext
>> >  *
>> >diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
>> >index 437fd82b9590..c58145464539 100644
>> >--- a/arch/riscv/kernel/hw_breakpoint.c
>> >+++ b/arch/riscv/kernel/hw_breakpoint.c
>> >@@ -633,7 +633,19 @@ void arch_uninstall_hw_breakpoint(struct perf_event *event)
>> >               pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
>> > }
>> >
>> >-void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
>> >+/*
>> >+ * Release the user breakpoints used by ptrace
>> >+ */
>> >+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>> >+{
>> >+      int i;
>> >+      struct thread_struct *t = &tsk->thread;
>> >+
>> >+      for (i = 0; i < dbtr_total_num; i++) {
>> >+              unregister_hw_breakpoint(t->ptrace_bps[i]);
>> >+              t->ptrace_bps[i] = NULL;
>> >+      }
>> >+}
>> >
>> > void hw_breakpoint_pmu_read(struct perf_event *bp) { }
>> >
>> >diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> >index 15d8f75902f8..9cf07ecfb523 100644
>> >--- a/arch/riscv/kernel/process.c
>> >+++ b/arch/riscv/kernel/process.c
>> >@@ -9,6 +9,7 @@
>> >
>> > #include <linux/bitfield.h>
>> > #include <linux/cpu.h>
>> >+#include <linux/hw_breakpoint.h>
>> > #include <linux/kernel.h>
>> > #include <linux/sched.h>
>> > #include <linux/sched/debug.h>
>> >@@ -164,6 +165,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
>> >
>> > void flush_thread(void)
>> > {
>> >+      flush_ptrace_hw_breakpoint(current);
>> > #ifdef CONFIG_FPU
>> >       /*
>> >        * Reset FPU state and context
>> >@@ -218,6 +220,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>> >               set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
>> >
>> >       memset(&p->thread.s, 0, sizeof(p->thread.s));
>> >+      if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
>> >+              memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
>> >
>> >       /* p->thread holds context to be restored by __switch_to() */
>> >       if (unlikely(args->fn)) {
>> >diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
>> >index ea67e9fb7a58..b78cfb0f1c0e 100644
>> >--- a/arch/riscv/kernel/ptrace.c
>> >+++ b/arch/riscv/kernel/ptrace.c
>> >@@ -9,11 +9,13 @@
>> >
>> > #include <asm/vector.h>
>> > #include <asm/ptrace.h>
>> >+#include <asm/hw_breakpoint.h>
>> > #include <asm/syscall.h>
>> > #include <asm/thread_info.h>
>> > #include <asm/switch_to.h>
>> > #include <linux/audit.h>
>> > #include <linux/compat.h>
>> >+#include <linux/hw_breakpoint.h>
>> > #include <linux/ptrace.h>
>> > #include <linux/elf.h>
>> > #include <linux/regset.h>
>> >@@ -336,12 +338,103 @@ void ptrace_disable(struct task_struct *child)
>> > {
>> > }
>> >
>> >+#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> >+static void ptrace_hbptriggered(struct perf_event *bp,
>> >+                              struct perf_sample_data *data,
>> >+                              struct pt_regs *regs)
>> >+{
>> >+      struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
>> >+      int num = 0;
>> >+
>> >+      force_sig_ptrace_errno_trap(num, (void __user *)bkpt->address);
>> >+}
>> >+
>> >+/*
>> >+ * idx selects the breakpoint index.
>> >+ * Both PTRACE_GETHBPREGS and PTRACE_SETHBPREGS transfer three 32-bit words:
>> >+ * address (0), length (1), type (2).
>> >+ * Instruction breakpoint length is one of HW_BREAKPOINT_LEN_X or 0. 0 will
>> >+ * disable the breakpoint.
>> >+ * Instruction breakpoint type is one of HW_BREAKPOINT_X.
>> >+ */
>> >+
>> >+static long ptrace_gethbpregs(struct task_struct *child, unsigned long idx,
>> >+                            unsigned long __user *datap)
>> >+{
>> >+      struct perf_event *bp;
>> >+      unsigned long user_data[3] = {0};
>> >+
>> >+      if (idx >= RV_MAX_TRIGGERS)
>> >+              return -EINVAL;
>> >+
>> >+      bp = child->thread.ptrace_bps[idx];
>> >+
>> >+      if (!IS_ERR_OR_NULL(bp)) {
>> >+              user_data[0] = bp->attr.bp_addr;
>> >+              user_data[1] = bp->attr.disabled ? 0 : bp->attr.bp_len;
>> >+              user_data[2] = bp->attr.bp_type;
>> >+      }
>> >+
>> >+      if (copy_to_user(datap, user_data, sizeof(user_data)))
>> >+              return -EFAULT;
>> >+
>> >+      return 0;
>> >+}
>> >+
>> >+static long ptrace_sethbpregs(struct task_struct *child, unsigned long idx,
>> >+                            unsigned long __user *datap)
>> >+{
>> >+      struct perf_event *bp;
>> >+      struct perf_event_attr attr;
>> >+      unsigned long user_data[3];
>> >+
>> >+      if (idx >= RV_MAX_TRIGGERS)
>> >+              return -EINVAL;
>> >+
>> >+      if (copy_from_user(user_data, datap, sizeof(user_data)))
>> >+              return -EFAULT;
>> >+
>> >+      bp = child->thread.ptrace_bps[idx];
>> >+      if (IS_ERR_OR_NULL(bp))
>>
>> Why not only check for NULL?
>> IS_ERR_VALUE will always expand to be true. right?
>
>Because im dumb and thought i was setting bp to an error code, but i'm not.
>Yes if (!bp) is right.
>
>>
>> >+              attr = bp->attr;
>> >+      else
>> >+              ptrace_breakpoint_init(&attr);
>> >+
>> >+      attr.bp_addr = user_data[0];
>> >+      attr.bp_len = user_data[1];
>> >+      attr.bp_type = user_data[2];
>> >+      attr.disabled = !attr.bp_len;
>>
>> Is it okay to not have any sanitization on inputs?
>>
>> Can these inputs be controlled by user to give kernel address and kernel
>> breakpoint?
>
>modify_user_hw_breakpoint calls modify_user_hw_breakpoint_check, which
>eventually checks if we have CAP_SYS_ADMIN.
>Same for register. type and len are also checked by the
>_user_hw_breakpoint_check functions and again in the riscv code.
>
>it would be nice if this could be double checked, but it does seem
>other architectures don't check addr aswell.

I see. That's interesting.

>
>Thanks,
>Jesse Taube
>
>>
>> >+
>> >+      if (IS_ERR_OR_NULL(bp)) {
>> >+              bp = register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NULL,
>> >+                                         child);
>> >+              if (IS_ERR(bp))
>> >+                      return PTR_ERR(bp);
>> >+
>> >+              child->thread.ptrace_bps[idx] = bp;
>> >+              return 0;
>> >+      } else {
>> >+              return modify_user_hw_breakpoint(bp, &attr);
>> >+      }
>> >+}
>> >+#endif
>> >+
>> > long arch_ptrace(struct task_struct *child, long request,
>> >                unsigned long addr, unsigned long data)
>> > {
>> >       long ret = -EIO;
>> >+      unsigned long __user *datap = (unsigned long __user *) data;
>> >
>> >       switch (request) {
>> >+#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> >+      case PTRACE_GETHBPREGS:
>> >+              ret = ptrace_gethbpregs(child, addr, datap);
>> >+              break;
>> >+
>> >+      case PTRACE_SETHBPREGS:
>> >+              ret = ptrace_sethbpregs(child, addr, datap);
>> >+              break;
>> >+#endif
>> >       default:
>> >               ret = ptrace_request(child, request, addr, data);
>> >               break;
>> >--
>> >2.43.0
>> >

