Return-Path: <linux-kernel+bounces-756869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66630B1BA96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66AC18A056E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3829ACCE;
	Tue,  5 Aug 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYkhmdjL"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A2C295DBE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420733; cv=none; b=tmZI+vhHYiHeaXyE5IBt3hwxze32Qu1wPZ6XT5yDDvB+lkG1C9ZMDZLDYemPTfs4lrRRFn5mo3ZVLYIe48TKR+oOa3zyWavua/7WlO/BZHAZoCBpGBL4h82ragUWQPEEUEgzKV3lZBrQrb7lchLsCvfmrUw/Pb2cqLmyal3QOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420733; c=relaxed/simple;
	bh=egmX3I+xWiBArhvmUxzBeMAeu0B5Tb33ykONyOMBO3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YssufpmUMLIcA/uY7JXb7JbemP29AyQzhsQV5GpQu71KC0ixxEASfOb5ALuKNZd3T2tzleng1BmR7n43SFvlUwg9B/7BkttRgR2dsXoiCJXOn28M6pz/F7BMbiJOIKUP85H6hFSDZrtkPF3pA/5MQBZ/sz44WFk9iotUrR2Ou+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYkhmdjL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bb326ad0bso5299939b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420731; x=1755025531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=A1yA3Tox8y0Vt47rQoMx2qI7LaxORtPHP2V794GePOY=;
        b=MYkhmdjLxjMs1C4gvRLAzni4Um74dQt4qSC0sSl6pfvdK/JtXB4SF9ThcuO8h05rp/
         9EV2ZdOHNPsJjEgw0nmStFuLt9wjWGHyDxZrdje3wE/IAI6lUwmwN2SuaG6Ei8brhzra
         YAUn8tsNVUQDdN39Mihuxk1goBLkTtRvd0ihXmewmEgd6vGl2Rkl5uxKJukJOkO95WUP
         sma1sXwJBU6JmG7Aps+cw7h3trLP2NXBRddUk3hT5nLOSaHMNGq+uzh6o+c7+4cfUvSL
         kJsvYC4VzDsnuf8TvhLswudpZP55r9uxA4ijicT2v1Gjvc4J+WAnKFLnb0yEjq6aXpgf
         YE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420731; x=1755025531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A1yA3Tox8y0Vt47rQoMx2qI7LaxORtPHP2V794GePOY=;
        b=TF+NmSgNFyqXuyaNqfXgy+d/8RqyeFFKvuoY23wDHrJFNHAJLL+IC5Eq9DzEqV/99+
         hC1T/ew+QpkKXk1p9CbVMyMxHOfIhLoWL7Ml81nqrm7NjyefJKxsonQnrSV1LikeZqiQ
         BOELkE0RhbdTPm9AsI2C1efkuQqHk3RwnXcpEhk7fRDi02hXhJdrCThezNin6dDIlkr8
         P4MhJlsbIrF8Vxqw/zryCKhdGfdavy9CGW3vknPjewJ6IfaR5Dkh4J2VPQYM81e27wkL
         pBvTms1tsfSlYoDi10PCyOZePXJDww+agUUCzCQjAwPg6mPXHIFvcYXcDOrX/pzWzcMU
         YR8g==
X-Forwarded-Encrypted: i=1; AJvYcCX7qikNfjfT8BEpUg0NFAUSZz+Z3krV7PebBfDdyuC69fo/2xQx2umkoSqssERcoeVQaVsMSPTMyZQMYac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWy1LJlZ/sM4M1kI1ATFc3GIsPYG8WMkHzefkdXqZPrV17yoT/
	2EiaEaHf5o6KrSJ0CALIMWHvIo5mH4dBXbV3YNP0c7R94dniC8zUWOYcLF9ud0S5v3Ak2KYLgPt
	tjRr41A==
X-Google-Smtp-Source: AGHT+IHadUAEVDdXXxm0Sgn+N9jgrencXx34zcy0U/IA8j77dHu13CAUEGcxSCQj8cplRDe4BHgnu5bo6FM=
X-Received: from pgct18.prod.google.com ([2002:a05:6a02:5292:b0:b42:f1d:a69b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2444:b0:240:168b:31b
 with SMTP id adf61e73a8af0-240313ba206mr270310637.16.1754420730960; Tue, 05
 Aug 2025 12:05:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:09 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-2-seanjc@google.com>
Subject: [PATCH 01/18] KVM: SVM: Skip fastpath emulation on VM-Exit if next
 RIP isn't valid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Skip the WRMSR and HLT fastpaths in SVM's VM-Exit handler if the next RIP
isn't valid, e.g. because KVM is running with nrips=false.  SVM must
decode and emulate to skip the instruction if the CPU doesn't provide the
next RIP, and getting the instruction bytes to decode requires reading
guest memory.  Reading guest memory through the emulator can fault, i.e.
can sleep, which is disallowed since the fastpath handlers run with IRQs
disabled.

 BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:106
 in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 32611, name: qemu
 preempt_count: 1, expected: 0
 INFO: lockdep is turned off.
 irq event stamp: 30580
 hardirqs last  enabled at (30579): [<ffffffffc08b2527>] vcpu_run+0x1787/0x1db0 [kvm]
 hardirqs last disabled at (30580): [<ffffffffb4f62e32>] __schedule+0x1e2/0xed0
 softirqs last  enabled at (30570): [<ffffffffb4247a64>] fpu_swap_kvm_fpstate+0x44/0x210
 softirqs last disabled at (30568): [<ffffffffb4247a64>] fpu_swap_kvm_fpstate+0x44/0x210
 CPU: 298 UID: 0 PID: 32611 Comm: qemu Tainted: G     U              6.16.0-smp--e6c618b51cfe-sleep #782 NONE
 Tainted: [U]=USER
 Hardware name: Google Astoria-Turin/astoria, BIOS 0.20241223.2-0 01/17/2025
 Call Trace:
  <TASK>
  dump_stack_lvl+0x7d/0xb0
  __might_resched+0x271/0x290
  __might_fault+0x28/0x80
  kvm_vcpu_read_guest_page+0x8d/0xc0 [kvm]
  kvm_fetch_guest_virt+0x92/0xc0 [kvm]
  __do_insn_fetch_bytes+0xf3/0x1e0 [kvm]
  x86_decode_insn+0xd1/0x1010 [kvm]
  x86_emulate_instruction+0x105/0x810 [kvm]
  __svm_skip_emulated_instruction+0xc4/0x140 [kvm_amd]
  handle_fastpath_invd+0xc4/0x1a0 [kvm]
  vcpu_run+0x11a1/0x1db0 [kvm]
  kvm_arch_vcpu_ioctl_run+0x5cc/0x730 [kvm]
  kvm_vcpu_ioctl+0x578/0x6a0 [kvm]
  __se_sys_ioctl+0x6d/0xb0
  do_syscall_64+0x8a/0x2c0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f479d57a94b
  </TASK>

Note, this is essentially a reapply of commit 5c30e8101e8d ("KVM: SVM:
Skip WRMSR fastpath on VM-Exit if next RIP isn't valid"), but with
different justification (KVM now grabs SRCU when skipping the instruction
for other reasons).

Fixes: b439eb8ab578 ("Revert "KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't valid"")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d9931c6c4bc6..829d9d46718d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4181,13 +4181,21 @@ static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+
+	/*
+	 * Next RIP must be provided as IRQs are disabled, and accessing guest
+	 * memory to decode the instruction might fault, i.e. might sleep.
+	 */
+	if (!nrips || !control->next_rip)
+		return EXIT_FASTPATH_NONE;
 
 	if (is_guest_mode(vcpu))
 		return EXIT_FASTPATH_NONE;
 
-	switch (svm->vmcb->control.exit_code) {
+	switch (control->exit_code) {
 	case SVM_EXIT_MSR:
-		if (!svm->vmcb->control.exit_info_1)
+		if (!control->exit_info_1)
 			break;
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case SVM_EXIT_HLT:
-- 
2.50.1.565.gc32cd1483b-goog


