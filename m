Return-Path: <linux-kernel+bounces-756944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B157B1BB5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F007AE86B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6F29ACF1;
	Tue,  5 Aug 2025 20:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OP4d0SXD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF887299AB5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425356; cv=none; b=MSythQzBe4Mabb5OrzYoeQf6LRbz7yaVG7unSw7VLBVzLkPtaeAWbepgoS/Ky6L5Q7MB9b/3BCG6iS31qvqSr5ZqETWkd7foGpTxAXXdDSKFvoocHY41Yi0KDoRJedFfQyuIPYzPlWlCx7zCZVzXzneEJ6h1Ih7BHKOhvjqh8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425356; c=relaxed/simple;
	bh=e2I9314HPIpBFl9igczsMXWZp8yxi5cthi2XE5Azg8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EDGjwvfz1BBuYlVE0S6hyVy8Oyn0dkptbIoZ3XtSLrCIDBfFKzXoJ1kZd24yUIaPsbVzq4PrlsTuDUBm/mV8Wy6F8+RI8MCfprjaKOJzP4jQHkpsCpe/+wkFzTfhKmcQhiEOLQqzK/739JLO3qhGrFcDh6ZuYO/E8+WwOXzUcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OP4d0SXD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ed2a7d475so4986894a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754425354; x=1755030154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5vwmlR1d0IHiMOo6jObRDAiKTHWGb9+yBzPo613PVvY=;
        b=OP4d0SXD/iDQjndkG5Qe9dAhx1+sDDTXmmM4k6ij+plUiNJZW2fQSJfZCGF5zGfc4e
         WdDqMPqpSy39ThrWP83XUMRgx1r1PsvViYZ/y5tznh1igHXXK8k8M+FYF/R1BOC16IWJ
         MbBLoLtk7y7kcQ/+1V1zffN+EKnEdfgFD4R41S9bjlyc/mrxxj2NH+6330rVyOmeWFWJ
         +Y/Sl9SZKMMOxGfEZYYZIUsA3mAJzgAKFIF2UQTeOaoGOc1YQ/zX2Viiytaoaacc2ItS
         sAVHayEd+yMead0pxzaiXXt6OQMBNzbk4SFME6Tf2ougqmKXOroI1VxAkXnDskLhGmm4
         M88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754425354; x=1755030154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vwmlR1d0IHiMOo6jObRDAiKTHWGb9+yBzPo613PVvY=;
        b=TgDwfFDKthjXiPVAwZh7+uQOLMs0a4ntSRJcJlxJookG58HQI40WXdbmDm3YLnIcme
         dswR5tamgBKM8a+a0H3di96epltObhpj6xkN5vNehlaAc77zFeUNRSlF1Ctq7BGyzxku
         6AS2JugG8pMyYj2AbsJ3V9eKvvZ3N2QRzDimxushY7ockpXbyqPYtjHJgdm1RtEevrVp
         IkMEeFWt/z+8XY2mQoA2J2dywWsMdy91GVFuzbAZ2t1QpKAGSwaIuVE2KwkGKnMRqidk
         qKYTnZseUvwWLCcYnA7P8LfnWOG/Nmd0uPwft1RykrimQlXJYzFcNR+6+cpGOSlhHOGA
         r0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw9w/Eu7aCZVq6XX+iaREJJRn+THqG8FARn+48Z5+2hmpaSBhBwf9AU4Ka4Na1zpjEUG9yo3Ii1GLzcBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/5R6E45IvZjlFqi3GcphGCr6faL0kLRn/jEJx5sYyKfcOYfw
	+RQTCsN/4QeWvwMCiPYqCq3bKt9Tn3WUc7diq4ZeILljM66rseZk3agi61sQTWM7DEKMk46ApR7
	ObPPRjw==
X-Google-Smtp-Source: AGHT+IEo7cJCHqYoYh8KZTKmcUCO2w3FybZUjjoTK5f0mcQiWQs81U9X5kUzl1rtWaMgTlO4PqHhe4rIJ2I=
X-Received: from pjbsz13.prod.google.com ([2002:a17:90b:2d4d:b0:31c:38fb:2958])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c8:b0:321:2160:bf72
 with SMTP id 98e67ed59e1d1-32166dfb0c8mr121888a91.7.1754425354132; Tue, 05
 Aug 2025 13:22:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 13:22:21 -0700
In-Reply-To: <20250805202224.1475590-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805202224.1475590-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805202224.1475590-4-seanjc@google.com>
Subject: [PATCH v3 3/6] KVM: x86: Rename handle_fastpath_set_msr_irqoff() to handle_fastpath_wrmsr()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

From: Xin Li <xin@zytor.com>

Rename the WRMSR fastpath API to drop "irqoff", as that information is
redundant (the fastpath always runs with IRQs disabled), and to prepare
for adding a fastpath for the immediate variant of WRMSRNS.

No functional change intended.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 arch/x86/kvm/x86.c     | 4 ++--
 arch/x86/kvm/x86.h     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f7e1e665a826..ca550c4fa174 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4197,7 +4197,7 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	case SVM_EXIT_MSR:
 		if (!control->exit_info_1)
 			break;
-		return handle_fastpath_set_msr_irqoff(vcpu);
+		return handle_fastpath_wrmsr(vcpu);
 	case SVM_EXIT_HLT:
 		return handle_fastpath_hlt(vcpu);
 	case SVM_EXIT_INVD:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 95765db52992..ae2c8c10e5d2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7170,7 +7170,7 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
 
 	switch (vmx_get_exit_reason(vcpu).basic) {
 	case EXIT_REASON_MSR_WRITE:
-		return handle_fastpath_set_msr_irqoff(vcpu);
+		return handle_fastpath_wrmsr(vcpu);
 	case EXIT_REASON_PREEMPTION_TIMER:
 		return handle_fastpath_preemption_timer(vcpu, force_immediate_exit);
 	case EXIT_REASON_HLT:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d3afb875133e..6470f0ab2060 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2142,7 +2142,7 @@ static inline bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 	       kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending();
 }
 
-fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
+fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu)
 {
 	u64 data = kvm_read_edx_eax(vcpu);
 	u32 msr = kvm_rcx_read(vcpu);
@@ -2167,7 +2167,7 @@ fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu)
 
 	return EXIT_FASTPATH_REENTER_GUEST;
 }
-EXPORT_SYMBOL_GPL(handle_fastpath_set_msr_irqoff);
+EXPORT_SYMBOL_GPL(handle_fastpath_wrmsr);
 
 /*
  * Adapt set_msr() to msr_io()'s calling convention
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 46220b04cdf2..2dab9c9d6199 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -437,7 +437,7 @@ int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 				    void *insn, int insn_len);
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len);
-fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu);
+fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 
-- 
2.50.1.565.gc32cd1483b-goog


