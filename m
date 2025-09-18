Return-Path: <linux-kernel+bounces-800204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888BB4347F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9265E210F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF529BD81;
	Thu,  4 Sep 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsBe3946"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD426E70C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972066; cv=none; b=Wf6eH8oXHotOplTIXOIN6bUUD2XeihS36J6gBfND+TvmhQ6cAth2hWQBFFQHQb4p7TBS7TLgmFdjpor6FXXrxR5qvUR90EhPn7uGDuEXkLQq3smB0WkWDZB/vQjhZsoVzacpwjdz6j4Krcy91hPT+IxCzC8NRGbhpeSqfjz9FoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972066; c=relaxed/simple;
	bh=vcKLPy4ahgXVhnlhVqICnsWj+WOjKEDQzk3uUkpP5ho=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bl3s+6sBP5EixBkxKfIQxkmYaau41bvM0HouWDmsgweUZizNR07HfSvz+m7VQz8z/mdbQuOockCYl2iY2pUw0m9mUQ9P5mHKAI201YSaFc35pQWgApUG1bJKFc1lrPU8UTVaSqQNunVonhPhzNEbCU+ubJlWaRDqbM6W+n6Kb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsBe3946; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77269d19280so685751b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756972064; x=1757576864; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q88hKfU8Hy8EIQha6HXQ97z19Xx4zKmGDo4bPrKg7sY=;
        b=EsBe3946hXwfYaV8VdV3as5QvAxM7EYNcu30d+ErPE8HICAMFfTIPkqTYDT2PlA+06
         175SaYPlgJxN3lVchJCnB1sFVNMvhGXST2RR30Pr+krYKoz1kMr5aKgUG0u5WLVET/bg
         RdTdU+itmqOnkQMa8VWJmbsiQewMDCo1BOqt6sBXwPm2VfqX6Pv1MmzhsA20WD9lA2++
         bKtEWFeZmmMTuRrJ4SzIr12R0ZcokufSxa8IOqx2YTr3tstYHPVHbYRnoqyn5rLFWLQU
         LroaIEWdZyoHoXcs70IqeIf+t4xpkcm7QYGJYQ0Ocs8S0dYX9bxegpE4DSiUTyADoI0z
         IoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756972064; x=1757576864;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q88hKfU8Hy8EIQha6HXQ97z19Xx4zKmGDo4bPrKg7sY=;
        b=tQsikhxcTh3YYZDkb1FG4vNrm7spc2tv0z2LxgwPWmqfd2KLz4mDFrgkZzeOzS157h
         wg7xrigQEIU2PGg0U2ZpgCiqLBxG1zSrnuMFBx+HmGm1/5DvazIv6itsGD7Ex+WCn5vL
         67/h+i5wqvKosryQO3sZ5fSSPfDiJOL89981xPlO/kUHLz38zZ/uRQT+oAGeDj6Hz8Wl
         BwMrR8e/K9xASlxKeKn/qyLCkCWPFDrx1cmeQpR0bqHR+9bf4KPZg39zZKOGZiEJXCjU
         IpHSEtmJjskeOFaenV0aKAJ1cNL14NVyNoBEKWHSu95LsCuMIdJHvw9mvp1k8F6xzu/Y
         R6vg==
X-Forwarded-Encrypted: i=1; AJvYcCU4erYU/qWihzf4Vy/gvgCbAvN0QMFamx6tywaWbJD5978EJrTHO5wqe9jKWXkETGpkFNypNFJ3O4pAEr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfAKnCVPoy++0WTqvP5O47zUks7D9CiWsFQInzGDuSaspY3o7
	VxWHzsqZpWnvOuGw2MizKIYGvPyXAPu1iJMzj6n/KQ3Pxg3DT8UFTHup
X-Gm-Gg: ASbGnctX0DdHHkfyfAPndpL7148N50K9QbiVB1KWVAYCQKyGYa4T6/fF+3NZzNyX+cm
	99zbrP7bxOdZgk8btFbQ4qtS0YE6hEFHSq+QKrRltmPOwb0xD2wGHPgfeGcTSL5WxPp3g07ZEgy
	5rsFnpIVtOe8FkeBk8++l1WsYgJCD4R2yoK8+20eEJjKtzEmX8L5QlxtIoy/cfRuzFvhDtXr3g/
	o5xw+YdIi1stmKr2SoV/7MQbi+vsc+mqAVcQwPZVH1lFxoa7eerAqetxN3YWerHvxUll8iMe0x9
	Z88TPxpRO7w/3XB/nHRuLUO0uBrceeSvohbZi/s6M+swOTNWUb7En8Q4lfoltIHPbOWw29JP9S8
	r/YMUQi/xJkBKEaZZqwxVDJwIm2rwdxtC+QI60aEweFHoL8jkVyKW
X-Google-Smtp-Source: AGHT+IFOMFzYlxH6hEamwoRKC2c4mONqfkPJG3ZH/sTJm3Oh4YrKkFfiMYAINhoGKkCZ2ACat3AIlw==
X-Received: by 2002:a05:6a20:9144:b0:243:a9b6:dea2 with SMTP id adf61e73a8af0-243d6f02e4emr27118768637.29.1756972064183;
        Thu, 04 Sep 2025 00:47:44 -0700 (PDT)
Received: from localhost ([106.118.103.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd073f476sm16119124a12.20.2025.09.04.00.47.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Sep 2025 00:47:43 -0700 (PDT)
From: Mengchen Li <mengchenli64@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mengchen Li <mengchenli64@gmail.com>
Subject: [PATCH] arm64: kgdb: Ensure atomic single-step execution
Date: Thu,  4 Sep 2025 15:47:23 +0800
Message-Id: <1756972043-12854-1-git-send-email-mengchenli64@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The existing KGDB single-step handling on ARM64 is susceptible to
interference from external interrupts. If an interrupt arrives in the
narrow time window between the execution of the instruction under test
and the generation of the step exception, the CPU will vector to the
interrupt handler (e.g., el1_interrupt -> __el1_irq) instead of
triggering the debug exception immediately.

When the step exception is finally taken, the context is no longer that
of the original instruction. This causes the debugger to appear "stuck",
as it repeatedly tries to single-step through the interrupt handler's
code (e.g., irq_enter_rcu()) instead of the target code.

The fix is to make the single-step operation atomic by masking interrupts
for its duration:
1. Upon receiving a step ('s') request from GDB, save the current
   PSTATE and then mask IRQs by setting the PSTATE.I bit.
2. After the single-step exception is taken, in kgdb_single_step_handler(),
   disable the kernel's single-step mechanism and meticulously restore
   the original interrupt mask state from the saved PSTATE.

This guarantees the instruction is executed without interruption and the
debug exception is taken in the correct context.

As a result of this new approach, the following cleanups are also made:
- The global `kgdb_single_step` flag is removed, as state is now precisely
  managed by `kgdb_cpu_doing_single_step` and the interrupt mask.
- The logic to disable single-step and manage the flag in the 'c'ontinue
  case is removed, as it is rendered redundant.
- The call to `kernel_rewind_single_step()` is unnecessary and is removed.

Tested on OrangePi 3B (RK3566) via serial console (kgdboc);
allows reliable single-stepping with GDB where it previously failed.

Signed-off-by: Mengchen Li <mengchenli64@gmail.com>
---
 arch/arm64/kernel/kgdb.c | 49 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 968324a..ee8a7e3 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -101,6 +101,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
 	{ "fpcr", 4, -1 },
 };
 
+static DEFINE_PER_CPU(unsigned int, kgdb_pstate);
+
 char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
 {
 	if (regno >= DBG_MAX_REG_NUM || regno < 0)
@@ -128,25 +130,15 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 void
 sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 {
-	struct cpu_context *cpu_context = &task->thread.cpu_context;
+	struct pt_regs *thread_regs;
 
 	/* Initialize to zero */
 	memset((char *)gdb_regs, 0, NUMREGBYTES);
 
-	gdb_regs[19] = cpu_context->x19;
-	gdb_regs[20] = cpu_context->x20;
-	gdb_regs[21] = cpu_context->x21;
-	gdb_regs[22] = cpu_context->x22;
-	gdb_regs[23] = cpu_context->x23;
-	gdb_regs[24] = cpu_context->x24;
-	gdb_regs[25] = cpu_context->x25;
-	gdb_regs[26] = cpu_context->x26;
-	gdb_regs[27] = cpu_context->x27;
-	gdb_regs[28] = cpu_context->x28;
-	gdb_regs[29] = cpu_context->fp;
-
-	gdb_regs[31] = cpu_context->sp;
-	gdb_regs[32] = cpu_context->pc;
+	thread_regs = task_pt_regs(task);
+	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
+	/* Special case for PSTATE */
+	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
 }
 
 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
@@ -195,18 +187,12 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 * over and over again.
 		 */
 		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
-		atomic_set(&kgdb_cpu_doing_single_step, -1);
-		kgdb_single_step =  0;
-
-		/*
-		 * Received continue command, disable single step
-		 */
-		if (kernel_active_single_step())
-			kernel_disable_single_step();
-
 		err = 0;
 		break;
 	case 's':
+		/* mask interrupts while single stepping */
+		__this_cpu_write(kgdb_pstate, linux_regs->pstate);
+		linux_regs->pstate |= (1 << 7);
 		/*
 		 * Update step address value with address passed
 		 * with step packet.
@@ -217,15 +203,12 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		kgdb_arch_update_addr(linux_regs, remcom_in_buffer);
 		atomic_set(&kgdb_cpu_doing_single_step, raw_smp_processor_id());
-		kgdb_single_step =  1;
 
 		/*
 		 * Enable single step handling
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
-		else
-			kernel_rewind_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
@@ -252,9 +235,17 @@ NOKPROBE_SYMBOL(kgdb_compiled_brk_handler);
 
 int kgdb_single_step_handler(struct pt_regs *regs, unsigned long esr)
 {
-	if (!kgdb_single_step)
-		return DBG_HOOK_ERROR;
+	unsigned int pstate;
+
+	kernel_disable_single_step();
+	atomic_set(&kgdb_cpu_doing_single_step, -1);
 
+	/* restore interrupt mask status */
+	pstate = __this_cpu_read(kgdb_pstate);
+	if (pstate & (1 << 7))
+		regs->pstate |= (1 << 7);
+	else
+		regs->pstate &= ~(1 << 7);
 	kgdb_handle_exception(0, SIGTRAP, 0, regs);
 	return DBG_HOOK_HANDLED;
 }
-- 
2.7.4


