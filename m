Return-Path: <linux-kernel+bounces-879304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A9C22C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 660704EE5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1A6221FB2;
	Fri, 31 Oct 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyN/0dBI"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE321ABB9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761870657; cv=none; b=nr7GRd4jBg+R4m1gDfdhEoA7FVzlAlseTj8tu/QIngWNULfH3zM65H/VBdeYVxwSoXOV2oyvV1X0BtD7cfLfNVTm3kELwhqSmiEo+jpeB+hqnRjW/GFsnBM21fWxSsWs5mRCSxMD9zYCDZdnfhUX6H01mltcpYBYhP6q7eAdUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761870657; c=relaxed/simple;
	bh=CKcaOTjItVz4WLo4iTzMHZzjSrJXPFSfhk1I27YzRz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PSoLSNqZouwgHAICihJbAvgsmNg+PA6MdN6ADI6sp/XwMo41YE2773wf9Ps1rwW5al/l57JvfQcoTNxHFDb4v/RVgTsKGs/oBfz0BT+u0phCMDwRoOW8RGVfnih6hfQ9MtlQutcJ8uQC8F9eN5aheA03NAx8mPRC7HK1fg2KMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyN/0dBI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b62b7af4fddso1204562a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761870655; x=1762475455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=plvc6sr/HSiAC52HAJ4IaJ4vyv8ZKviRrYeEAUlJ9Xc=;
        b=UyN/0dBIOtL71t37zvUkgh4S0/e/HronxyDumSllbzwO6S3qzY8iR7/vWMLFGI7ZE3
         KFp1KcvQQcXL7Iomgx/ip+IjYR/Ep28rjJjbHCgoxk87b+QOsBTafGIwD74XBGStJq4g
         DAnR+JOZ23bksw46fHUT/VKGDuqevGjyJ6lGfxaG3z2mG3wbSJDg3ojPeTBC45ZgfDkt
         u2/0ATBizzVyNGaM1gzLkehQUeJco+pSq2Ur7u2VaSlCgJQsOg7vyTS77REeFb6ntEfa
         cEQxp+aOoI/eVo5GweOg8Uzmy0BHWttot8aiBNdAn/bjOb93vZCp6+5GX/LMdvagf17h
         K7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761870655; x=1762475455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plvc6sr/HSiAC52HAJ4IaJ4vyv8ZKviRrYeEAUlJ9Xc=;
        b=ku15Nrs9/Z/X0jlGv6883GD9PkyuJa/bqyWm4XN5hx+Ky2o+L9cBgKcfJYH7/CSgaI
         /6tWXdOzXjm9fy1LRUGmg/vr4owhwDJCxJCIuAUt72SWbsSnVmEPfDRXZhrJ6U7/lexP
         CY999rUQuuTgoH7jM23D0pce8fIxJ8s0VtBTe7hm/D3xgVUzxlNaltjFaHEFvN4Z8Hhw
         fswJuzbmT7riqSaupkV77AWXEOol5T+kZAc52wkH36Ldt5BWJ7czGJoh7HQnQunlpEw5
         1kHZiWDdqwQ5O3+NdfgfUd0X/V0yUPQCnqKxa1jgndc3odDgq0x4KKxgAyoELj5oZcbA
         E44w==
X-Forwarded-Encrypted: i=1; AJvYcCWb+RieOuL9tjRDAuOOTGG0yfbFj5oyYvNEfqOAWpS0R92JZWPc/0fXZW1/MOhxMc9Y0O87+x979/ItVi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSp63ESuUEAjM2eKeQA2bgH6omOxHABmv7EyjTRwc4PffWj6M
	pG0Tn5krC2D3fiffU+TwVfjb6Lt0gllBF+T1Jec62RGm7IAKwkWJ2o9xXVJF6kZf2B9Cf82DRgn
	RZ6HRHQ==
X-Google-Smtp-Source: AGHT+IFIzJ7ZEinVQ37x8dGUbzHaunbWA0l4ceoWMJoW0i44376UHeVDoVTVqIoOKauus5lpArxJCTtPusU=
X-Received: from pjbcf5.prod.google.com ([2002:a17:90a:ebc5:b0:32d:a4d4:bb17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e212:b0:340:fce2:a152
 with SMTP id adf61e73a8af0-348cca00f0bmr2183966637.55.1761870655555; Thu, 30
 Oct 2025 17:30:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 17:30:37 -0700
In-Reply-To: <20251031003040.3491385-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031003040.3491385-6-seanjc@google.com>
Subject: [PATCH v4 5/8] x86/bugs: KVM: Move VM_CLEAR_CPU_BUFFERS into SVM as SVM_CLEAR_CPU_BUFFERS
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that VMX encodes its own sequency for clearing CPU buffers, move
VM_CLEAR_CPU_BUFFERS into SVM to minimize the chances of KVM botching a
mitigation in the future, e.g. using VM_CLEAR_CPU_BUFFERS instead of
checking multiple mitigation flags.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/nospec-branch.h | 3 ---
 arch/x86/kvm/svm/vmenter.S           | 6 ++++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index b29df45b1edb..88fe40d6949a 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,9 +323,6 @@
 #define CLEAR_CPU_BUFFERS \
 	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF
 
-#define VM_CLEAR_CPU_BUFFERS \
-	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
-
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
 	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 235c4af6b692..da5f481cb17e 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -92,6 +92,8 @@
 	jmp 901b
 .endm
 
+#define SVM_CLEAR_CPU_BUFFERS \
+	ALTERNATIVE "", __CLEAR_CPU_BUFFERS, X86_FEATURE_CLEAR_CPU_BUF_VM
 
 /**
  * __svm_vcpu_run - Run a vCPU via a transition to SVM guest mode
@@ -170,7 +172,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
 	/* Clobbers EFLAGS.ZF */
-	VM_CLEAR_CPU_BUFFERS
+	SVM_CLEAR_CPU_BUFFERS
 
 	/* Enter guest mode */
 3:	vmrun %_ASM_AX
@@ -339,7 +341,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov KVM_VMCB_pa(%rax), %rax
 
 	/* Clobbers EFLAGS.ZF */
-	VM_CLEAR_CPU_BUFFERS
+	SVM_CLEAR_CPU_BUFFERS
 
 	/* Enter guest mode */
 1:	vmrun %rax
-- 
2.51.1.930.gacf6e81ea2-goog


