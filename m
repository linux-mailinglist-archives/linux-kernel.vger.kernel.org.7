Return-Path: <linux-kernel+bounces-795045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89BCB3EC3C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAAE207F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321EF2D593F;
	Mon,  1 Sep 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cerea.dev header.i=@cerea.dev header.b="AupkGeVK"
Received: from mail.cerea.dev (vps-88effe85.vps.ovh.net [51.89.23.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68332F763
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.89.23.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744453; cv=none; b=GRovYIyOP41TcnuqJDGPX+IelPlEsP0jFQTTJw8ZJXgOO9GI9K7QqdyRIKvMdEIli9nX5CQX9nFTCiqLziWDSRPOZc6AAuE0SGzDETDH5geOc+AR5j8fToCDoUOcfFgSaa30ANvI0KeIlIMgxcM2lxgFQv9nzBosON7DvDRA8d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744453; c=relaxed/simple;
	bh=ayJm6cK14oblj0I0L5LzQ3+TxmbUzbczFC9a+8xWZOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvxkvSli8tsCgsYqwZUBXrPMCMaDyWpeNYZOvC5i6+X/0UWd7RjDDu/48wcntYEf2uHLH7NxxqKGCMtwaui514VKRIZ9QFuBe0GMAVFEemF/wRmmqe2ZcBLMP50PLXPXLgJ7CgU8u/BlPGLvPa8tF85dHo8d58fGXxRVl1aHl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cerea.dev; spf=pass smtp.mailfrom=cerea.dev; dkim=pass (2048-bit key) header.d=cerea.dev header.i=@cerea.dev header.b=AupkGeVK; arc=none smtp.client-ip=51.89.23.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cerea.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cerea.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cerea.dev; s=mail;
	t=1756743971; bh=ayJm6cK14oblj0I0L5LzQ3+TxmbUzbczFC9a+8xWZOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AupkGeVKS9THwTKoXKOceH+SK2C1Uaz30sEJaMNSveOANoz93TgnWfTg5pSVj3MjI
	 E7kYue6g2MopXU19U/+K+11lMgoCF1OX3a5/bW7CtwtYXl+dCaDlT8aCPwXaVI/W0B
	 ezB30bhOHteIFipeyp4A8h+CAyk9PUNx1DeN3c+waNfC//3B4VYSVWS53bCKsaaA6j
	 a1mUXU08PuFHf27FcVfDlUCni4KN6ajDupQt4ZsMLYz1zlTKL8IlNcE1mvUpa5KKZy
	 TjD7nWwESqXCZnjGJPsrKt0BAtlzcBfZ7O042pTOZ/EDTrUf9+WGFtHrje8hiyPAnf
	 8YNkfodENnqpw==
From: Samuele Cerea <samuele@cerea.dev>
To: bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	Samuele Cerea <samuele@cerea.dev>
Subject: [PATCH v2] x86/traps: Handle trap flag when instruction is emulated
Date: Mon,  1 Sep 2025 18:25:28 +0200
Message-ID: <20250901162527.18247-2-samuele@cerea.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822170107.GGaKiiU-HFkxnbymhY@fat_crate.local>
References: <20250822170107.GGaKiiU-HFkxnbymhY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simulate the trap flag (TF) behavior when the kernel emulates UIMP
instructions and iopl instructions.

When an instruction is emulated successfully and the TF is set, send a
SIGTRAP signal to the process, as it would happen for a normally
executed instruction.

Fix a problem with debuggers when signle-stepping instructions where
emulated instruction would get skipped.

Here is an example of the problem:
    NOP
    SLDT %rax
    SLDT %rax
    NOP
The two SLDT instructions will be skipped an the debugger will step
directly to the second NOP instruction.

Signed-off-by: Samuele Cerea <samuele@cerea.dev>
---
I fixed the issues you pointed out, hopefully now everything is correct

 arch/x86/include/asm/traps.h |  2 ++
 arch/x86/kernel/traps.c      | 14 ++++++++++++++
 arch/x86/kernel/umip.c       |  1 +
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 869b88061801..7742a6d05158 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -39,6 +39,8 @@ void math_emulate(struct math_emu_info *);
 
 bool fault_in_kernel_space(unsigned long address);
 
+void emulate_trap_flag(struct pt_regs *regs);
+
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(struct pt_regs *regs,
 				      unsigned long fault_address,
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 36354b470590..bea28473866b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -678,6 +678,19 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+void emulate_trap_flag(struct pt_regs *regs)
+{
+	struct task_struct *tsk = current;
+
+	/* If the instruction was emulated successfully, emulate trap flag */
+	if (regs->flags & X86_EFLAGS_TF) {
+		tsk->thread.cr2 = regs->ip;
+		tsk->thread.trap_nr = X86_TRAP_DB;
+		tsk->thread.error_code = 0;
+		force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)regs->ip);
+	}
+}
+
 static bool fixup_iopl_exception(struct pt_regs *regs)
 {
 	struct thread_struct *t = &current->thread;
@@ -705,6 +718,7 @@ static bool fixup_iopl_exception(struct pt_regs *regs)
 	}
 
 	regs->ip += 1;
+	emulate_trap_flag(regs);
 	return true;
 }
 
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..8a5f33562bb4 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -407,5 +407,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
 
 	/* increase IP to let the program keep going */
 	regs->ip += insn.length;
+	emulate_trap_flag(regs);
 	return true;
 }
-- 
2.51.0


