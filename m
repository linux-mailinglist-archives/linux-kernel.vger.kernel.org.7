Return-Path: <linux-kernel+bounces-742945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8519EB0F887
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606A27B7EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81E202C5D;
	Wed, 23 Jul 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PtZLavJA"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A32036FE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289739; cv=none; b=NpRytE7IK0ZSnXmNWz1ZtOeoqm+JV9C0gR54eM6eDBEQxi+rjbY4Hiyj6texP2Jb29mqoJx1cWuaxzm2LwZdXucs7MohJncGjDdKw6JVrFSBxq1GsTDpt1pjUwiVBP+L2lETRbJlD9dBETtOdJ1r16h0IOhxQIbbB7vutShMyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289739; c=relaxed/simple;
	bh=r8ZHN4S7Q2yb6iPsvoU998uUmPm7i9q50LmxbXst6nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw7C5uEwnRBDHwluPTG86nPzGMVyNb5h6oBiZ+YLzf9gG5LHjfGYRA7mnYrxebLFyP9BZ/VrqZlScSNrb4VqnZFqUUMFosR8vDpCLHyRwxkm6IlXdbIGTPPa7VCP68+FBjua41ajahS89MIauO2idNjjnACC1MQnkHgp7tSC0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PtZLavJA; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4f3162155a4so42309137.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753289736; x=1753894536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8H5JVJC6vkEsb6uxBA9nEo16g32BKFcYhqakBztjB4=;
        b=PtZLavJAvJfohCzUT1RRlxjcJA/mtNitevOBelK6RpZl2RYbesHl71YSgQ+/74e/Rm
         H7e7gGrtWkg/0ok2KAAbPKB6/0PCzyvZwlh0aXiVulWh6wdHq/7aLnxIOYZzWV3guFM7
         qol1FHXPY4rFdWgoO3tuVLVdBlZgTjHQtIDe5Ch7OYy5Jdui8v/xjFxJy7/D+VnUASSC
         8xMGbYGaE9CFBDtMfu3/7Sv6wukaTbrW9L1KByLV2BmeJXsRRAWSMeLx6ooUBXuo2d4r
         7/dVG02exGFgF5NSEfHbbX5ZzDwc/EIVX2LkLW6m24fP/m9VZALkYZpaQXYqpBXw9Xem
         Vtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753289736; x=1753894536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8H5JVJC6vkEsb6uxBA9nEo16g32BKFcYhqakBztjB4=;
        b=m5mf6P4if0sr8t6ZRY1YLqZ54OaD+WRtVzlApP3BBLlWEzHb3KWtu8/J+NJ36ZxxsR
         iRyrOR4dQ6R3Ta30kq+GqGRgRV18sTiryuXNZK2XClp3AUEAkX11PVib4TrAXGrtuw3D
         YbGUzbMCRdnBHCI9sZ09jtMA2O2VPLTsbYJ2gW7q25tMYB5p3IxT1oaLu2NVdmLNsC86
         JiwQ51FrgBR3L3rYitNDuGpdxpWIQgHB+3l+00oWNq23PtmjkjQZFirRiDguc9zozwOZ
         psTOYh3UaiWKCmL2UkNAAJKmzQovv2p7G51V7w4j+/O9Dqk02Tdb9w6+SeV4cW0rEI5o
         DPtw==
X-Forwarded-Encrypted: i=1; AJvYcCX+8sh+ICndd6VJK4K8px5ynD8cvhctZ2e6q9BBZok1w8YuTZ4wCPz9XeGSYY/4Ufl0nGcMgimPUGDQv4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluOs96q+kAj7dyPGn+b3Hq9no+5vIOiNPpkxv/cl5MPsgR3bq
	fbWdnzCMV4S6LFMEBD2Ca8dv5UxXuiNoIZj36K0kLlTQ7VZs1CzH20SkaoV1ba3DUZ3kydxqMhS
	sacoTaPWIMl2jjiGjm23BhkePzaMbMzMzdTi76BDB/g==
X-Gm-Gg: ASbGncuJuaj83nDLP5hIOYBNp2Lfkso7TOG+5S3Jp//TDbAEgAd2yah5QFy2aKd93Ja
	G5RyqCJnmqaXL/lWsIpKrqlQpTiE0+NbT1hYvboTsOwRyTFP1/Ca+Ci6p+W8LTqgXXVguobWCcM
	2dMABOmoNio0yfQRc1/nEao3K0paizJhX+gMjfmf28DtbQRiqTu1AxoqX5Ytpeif2GUw3dLoMsV
	RVLhFN6qGSu+/K+yW4=
X-Google-Smtp-Source: AGHT+IEqyp+slle5iBHFbOmxMoEz7bQdP/vBsXZD2Tx1YNfXBChgcOcVkXNgUrUDHuOQV0Za/ZuW5naPRhuARxurFzI=
X-Received: by 2002:a05:6102:4b09:b0:4e7:bf04:412e with SMTP id
 ada2fe7eead31-4fa14d5b3b7mr2297778137.0.1753289736326; Wed, 23 Jul 2025
 09:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722173829.984082-1-jesse@rivosinc.com> <20250722173829.984082-7-jesse@rivosinc.com>
 <aIBij4hr3Jna8OjV@debug.ba.rivosinc.com>
In-Reply-To: <aIBij4hr3Jna8OjV@debug.ba.rivosinc.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Wed, 23 Jul 2025 09:55:25 -0700
X-Gm-Features: Ac12FXw4WfG1R-C7dUJttewn097fGe-oB4_p1sj-LRJJDI_noRxNUvJymjSp2Go
Message-ID: <CALSpo=Y+hLsVC+w942Bhg628HuDqG=MU9+f87R5X616rhG11Mw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] riscv: ptrace: Add hw breakpoint support
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	WangYuli <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Nam Cao <namcao@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Celeste Liu <coelacanthushex@gmail.com>, Evan Green <evan@rivosinc.com>, 
	Nylon Chen <nylon.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:18=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Tue, Jul 22, 2025 at 10:38:29AM -0700, Jesse Taube wrote:
> >Add ability to setup hw breakpoints to ptrace. Call defines a new
> >structure of (ulong[3]){bp_addr, bp_len, bp_type} with
> >bp_type being one of HW_BREAKPOINT_LEN_X and
> >bp_len being one of HW_BREAKPOINT_X with a value of
> >zero dissabling the breakpoint.
> >
> >Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> >---
> > arch/riscv/include/asm/processor.h   |  4 ++
> > arch/riscv/include/uapi/asm/ptrace.h |  3 +-
> > arch/riscv/kernel/hw_breakpoint.c    | 14 ++++-
> > arch/riscv/kernel/process.c          |  4 ++
> > arch/riscv/kernel/ptrace.c           | 93 ++++++++++++++++++++++++++++
> > 5 files changed, 116 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm=
/processor.h
> >index 5f56eb9d114a..488d956a951f 100644
> >--- a/arch/riscv/include/asm/processor.h
> >+++ b/arch/riscv/include/asm/processor.h
> >@@ -12,6 +12,7 @@
> >
> > #include <vdso/processor.h>
> >
> >+#include <asm/hw_breakpoint.h>
> > #include <asm/ptrace.h>
> >
> > #define arch_get_mmap_end(addr, len, flags)                   \
> >@@ -108,6 +109,9 @@ struct thread_struct {
> >       struct __riscv_v_ext_state vstate;
> >       unsigned long align_ctl;
> >       struct __riscv_v_ext_state kernel_vstate;
> >+#ifdef CONFIG_HAVE_HW_BREAKPOINT
> >+      struct perf_event *ptrace_bps[RV_MAX_TRIGGERS];
> >+#endif
> > #ifdef CONFIG_SMP
> >       /* Flush the icache on migration */
> >       bool force_icache_flush;
> >diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/u=
api/asm/ptrace.h
> >index a38268b19c3d..a7998ed41913 100644
> >--- a/arch/riscv/include/uapi/asm/ptrace.h
> >+++ b/arch/riscv/include/uapi/asm/ptrace.h
> >@@ -14,7 +14,8 @@
> >
> > #define PTRACE_GETFDPIC_EXEC  0
> > #define PTRACE_GETFDPIC_INTERP        1
> >-
> >+#define PTRACE_GETHBPREGS     2
> >+#define PTRACE_SETHBPREGS     3
>
> Why not use `PTRACE_GETREGSET` `PTRACE_SETREGSET` ?

Because it was easier to implement this first, and REGSET will be
another commit ontop of this one.
Unless there is a reason to not have this version.

>
> > /*
> >  * User-mode register state for core dumps, ptrace, sigcontext
> >  *
> >diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_br=
eakpoint.c
> >index 437fd82b9590..c58145464539 100644
> >--- a/arch/riscv/kernel/hw_breakpoint.c
> >+++ b/arch/riscv/kernel/hw_breakpoint.c
> >@@ -633,7 +633,19 @@ void arch_uninstall_hw_breakpoint(struct perf_event=
 *event)
> >               pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n=
", __func__, i, ret.error);
> > }
> >
> >-void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }
> >+/*
> >+ * Release the user breakpoints used by ptrace
> >+ */
> >+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> >+{
> >+      int i;
> >+      struct thread_struct *t =3D &tsk->thread;
> >+
> >+      for (i =3D 0; i < dbtr_total_num; i++) {
> >+              unregister_hw_breakpoint(t->ptrace_bps[i]);
> >+              t->ptrace_bps[i] =3D NULL;
> >+      }
> >+}
> >
> > void hw_breakpoint_pmu_read(struct perf_event *bp) { }
> >
> >diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> >index 15d8f75902f8..9cf07ecfb523 100644
> >--- a/arch/riscv/kernel/process.c
> >+++ b/arch/riscv/kernel/process.c
> >@@ -9,6 +9,7 @@
> >
> > #include <linux/bitfield.h>
> > #include <linux/cpu.h>
> >+#include <linux/hw_breakpoint.h>
> > #include <linux/kernel.h>
> > #include <linux/sched.h>
> > #include <linux/sched/debug.h>
> >@@ -164,6 +165,7 @@ void start_thread(struct pt_regs *regs, unsigned lon=
g pc,
> >
> > void flush_thread(void)
> > {
> >+      flush_ptrace_hw_breakpoint(current);
> > #ifdef CONFIG_FPU
> >       /*
> >        * Reset FPU state and context
> >@@ -218,6 +220,8 @@ int copy_thread(struct task_struct *p, const struct =
kernel_clone_args *args)
> >               set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
> >
> >       memset(&p->thread.s, 0, sizeof(p->thread.s));
> >+      if (IS_ENABLED(CONFIG_HAVE_HW_BREAKPOINT))
> >+              memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_b=
ps));
> >
> >       /* p->thread holds context to be restored by __switch_to() */
> >       if (unlikely(args->fn)) {
> >diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> >index ea67e9fb7a58..b78cfb0f1c0e 100644
> >--- a/arch/riscv/kernel/ptrace.c
> >+++ b/arch/riscv/kernel/ptrace.c
> >@@ -9,11 +9,13 @@
> >
> > #include <asm/vector.h>
> > #include <asm/ptrace.h>
> >+#include <asm/hw_breakpoint.h>
> > #include <asm/syscall.h>
> > #include <asm/thread_info.h>
> > #include <asm/switch_to.h>
> > #include <linux/audit.h>
> > #include <linux/compat.h>
> >+#include <linux/hw_breakpoint.h>
> > #include <linux/ptrace.h>
> > #include <linux/elf.h>
> > #include <linux/regset.h>
> >@@ -336,12 +338,103 @@ void ptrace_disable(struct task_struct *child)
> > {
> > }
> >
> >+#ifdef CONFIG_HAVE_HW_BREAKPOINT
> >+static void ptrace_hbptriggered(struct perf_event *bp,
> >+                              struct perf_sample_data *data,
> >+                              struct pt_regs *regs)
> >+{
> >+      struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
> >+      int num =3D 0;
> >+
> >+      force_sig_ptrace_errno_trap(num, (void __user *)bkpt->address);
> >+}
> >+
> >+/*
> >+ * idx selects the breakpoint index.
> >+ * Both PTRACE_GETHBPREGS and PTRACE_SETHBPREGS transfer three 32-bit w=
ords:
> >+ * address (0), length (1), type (2).
> >+ * Instruction breakpoint length is one of HW_BREAKPOINT_LEN_X or 0. 0 =
will
> >+ * disable the breakpoint.
> >+ * Instruction breakpoint type is one of HW_BREAKPOINT_X.
> >+ */
> >+
> >+static long ptrace_gethbpregs(struct task_struct *child, unsigned long =
idx,
> >+                            unsigned long __user *datap)
> >+{
> >+      struct perf_event *bp;
> >+      unsigned long user_data[3] =3D {0};
> >+
> >+      if (idx >=3D RV_MAX_TRIGGERS)
> >+              return -EINVAL;
> >+
> >+      bp =3D child->thread.ptrace_bps[idx];
> >+
> >+      if (!IS_ERR_OR_NULL(bp)) {
> >+              user_data[0] =3D bp->attr.bp_addr;
> >+              user_data[1] =3D bp->attr.disabled ? 0 : bp->attr.bp_len;
> >+              user_data[2] =3D bp->attr.bp_type;
> >+      }
> >+
> >+      if (copy_to_user(datap, user_data, sizeof(user_data)))
> >+              return -EFAULT;
> >+
> >+      return 0;
> >+}
> >+
> >+static long ptrace_sethbpregs(struct task_struct *child, unsigned long =
idx,
> >+                            unsigned long __user *datap)
> >+{
> >+      struct perf_event *bp;
> >+      struct perf_event_attr attr;
> >+      unsigned long user_data[3];
> >+
> >+      if (idx >=3D RV_MAX_TRIGGERS)
> >+              return -EINVAL;
> >+
> >+      if (copy_from_user(user_data, datap, sizeof(user_data)))
> >+              return -EFAULT;
> >+
> >+      bp =3D child->thread.ptrace_bps[idx];
> >+      if (IS_ERR_OR_NULL(bp))
>
> Why not only check for NULL?
> IS_ERR_VALUE will always expand to be true. right?

Because im dumb and thought i was setting bp to an error code, but i'm not.
Yes if (!bp) is right.

>
> >+              attr =3D bp->attr;
> >+      else
> >+              ptrace_breakpoint_init(&attr);
> >+
> >+      attr.bp_addr =3D user_data[0];
> >+      attr.bp_len =3D user_data[1];
> >+      attr.bp_type =3D user_data[2];
> >+      attr.disabled =3D !attr.bp_len;
>
> Is it okay to not have any sanitization on inputs?
>
> Can these inputs be controlled by user to give kernel address and kernel
> breakpoint?

modify_user_hw_breakpoint calls modify_user_hw_breakpoint_check, which
eventually checks if we have CAP_SYS_ADMIN.
Same for register. type and len are also checked by the
_user_hw_breakpoint_check functions and again in the riscv code.

it would be nice if this could be double checked, but it does seem
other architectures don't check addr aswell.

Thanks,
Jesse Taube

>
> >+
> >+      if (IS_ERR_OR_NULL(bp)) {
> >+              bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptrigg=
ered, NULL,
> >+                                         child);
> >+              if (IS_ERR(bp))
> >+                      return PTR_ERR(bp);
> >+
> >+              child->thread.ptrace_bps[idx] =3D bp;
> >+              return 0;
> >+      } else {
> >+              return modify_user_hw_breakpoint(bp, &attr);
> >+      }
> >+}
> >+#endif
> >+
> > long arch_ptrace(struct task_struct *child, long request,
> >                unsigned long addr, unsigned long data)
> > {
> >       long ret =3D -EIO;
> >+      unsigned long __user *datap =3D (unsigned long __user *) data;
> >
> >       switch (request) {
> >+#ifdef CONFIG_HAVE_HW_BREAKPOINT
> >+      case PTRACE_GETHBPREGS:
> >+              ret =3D ptrace_gethbpregs(child, addr, datap);
> >+              break;
> >+
> >+      case PTRACE_SETHBPREGS:
> >+              ret =3D ptrace_sethbpregs(child, addr, datap);
> >+              break;
> >+#endif
> >       default:
> >               ret =3D ptrace_request(child, request, addr, data);
> >               break;
> >--
> >2.43.0
> >

