Return-Path: <linux-kernel+bounces-756873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33750B1BA9E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D1518A74FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F058F29DB97;
	Tue,  5 Aug 2025 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qj7kBf2O"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0C298242
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420740; cv=none; b=eVtD0W1ntwKhJm3eGao8eQA3qRhRJVmfcb9XP93CTcD4LsuqzTD8JGjWHw19iiX/webgKRiopuUW0+0C81YPw1QOyeDxVrEv7sUSAmjnMbctwHWYyWylYZQfL/EfUTJ3XiJpRS0raYEXQ79R+kOLm5Z1E+0wspQYAQRMVRpNpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420740; c=relaxed/simple;
	bh=xpuAfe6osI2bpYjxTC/iM3WTy5qqB334ATvjgCjikJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qIIAk3PcLIz5fjZUbSsKH/LMP86Rf809BPmyEpDpWiPm5nhyfgtKP3RctH1KhVmte0ESAJCoAH6HrlmoRz2CL6vKUU/VlG3m9Qtpeje2FWyR0vXhgUG2yn65fRXtBr49CPzO0vefyMGvWuXUNRSNVqNYnLBx+9rkHzA3AQO0L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qj7kBf2O; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f71e509d6so8150518a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420738; x=1755025538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k3BpaAX0seqYxAkXBaAjUiDEESfLKvS8cQgIlkV/n2U=;
        b=Qj7kBf2OxWGaiN5qyvI6Oqr93NJy7YT6glTmeg/MGRU8aLbYt8lffZyYeSpZXk5sI3
         0WH0+Iuip0/fnNu8wEeVjGVXFTno5qZt643+UM7WMpMbiHSN84MnZrf5GGConsQC99FX
         DFH87CCeIlz2+WjTW8ckxzHR6ihONTnzAgZdO+lBTHy2e8Idj3bxL1Dem8H3ltabV3Qq
         +pBAIDSe7jLSfiZilgffBce8F+XkFEVfzC8MTo6Nj5qZwlCvqM5UeUvFGtgafA/ABF9U
         0N+xY5Wh2HddoIu/2U0QGSoQZuJUNKcNNZxGdcH2lqsbkNMEfRYy0vBw6KVRPnU4smQB
         AlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420738; x=1755025538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3BpaAX0seqYxAkXBaAjUiDEESfLKvS8cQgIlkV/n2U=;
        b=wNxTzpYNHuxu9U3A6HnBZolMY5aQvklZCJvlpG/2IrDMn7O1u7bJZR+djCkIzI3ivY
         JtWxVINYaM2EU19O8LeLUKoRy7ZmFYpq9sSQWw6mZUmBF5I35S7TSmDEq/YCVf5kfk1q
         Zj6VthgziXiWCo9eCc2Vjf47eZ5rB20OnoW44pEpqwIbsI/25p06cYw6itPxpnzo8778
         wwPipMgUscp1ibZmX3m0jxHgVaqhmNAHo9N0+qXmdx4Nuq/u42AohqRYqou0+qCL98X/
         Nc/hc3OLUWgjDbXIJqlcoeIqgff99oKt/gs1POdSTc/8xxkDbLoTM2677llwjB5x5bTS
         sxnA==
X-Forwarded-Encrypted: i=1; AJvYcCV30cYD+JF5TVjkcTRTfyy8lNmvWx8jrUgLItUCW8tE3DxhQQMpof1RcLNTT3TfJOMPhWNzeh+R6Uqb2mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHfP80Kp5o7IHb28mXEamAeK4d6CcDH2eVZjfDs/ewZt6NR3o
	PuaDNfDF/vGHWuxOPH5/UZqvKWLOq03+lm5OqGB2HUZJKzfndnw5tF2cg0wV4yp69iJhnd4xxGJ
	rwEpjbw==
X-Google-Smtp-Source: AGHT+IE1TxB7aC6rWf+ncWBha/qBhkqCB4f7eWGEN/MljCoe7AxrV10Ivh+oq2kbcx6+avQsLJSNKHHyjOc=
X-Received: from pgci4.prod.google.com ([2002:a63:6d04:0:b0:b31:dbad:8412])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3942:b0:23f:f99d:462b
 with SMTP id adf61e73a8af0-24031455024mr228734637.41.1754420738118; Tue, 05
 Aug 2025 12:05:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:13 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-6-seanjc@google.com>
Subject: [PATCH 05/18] KVM: x86: Unconditionally handle MSR_IA32_TSC_DEADLINE
 in fastpath exits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop the fastpath VM-Exit requirement that KVM can use the hypervisor
timer to emulate the APIC timer in TSC deadline mode.  I.e. unconditionally
handle MSR_IA32_TSC_DEADLINE WRMSRs in the fastpath.  Restricting the
fastpath to *maybe* using the VMX preemption timer is ineffective and
unnecessary.

If the requested deadline can't be programmed into the VMX preemption
timer, KVM will fall back to hrtimers, i.e. the restriction is ineffective
as far as preventing any kind of worst case scenario.

But guarding against a worst case scenario is completely unnecessary as
the "slow" path, start_sw_tscdeadline() => hrtimer_start(), explicitly
disables IRQs.  In fact, the worst case scenario is when KVM thinks it
can use the VMX preemption timer, as KVM will eat the overhead of calling
into vmx_set_hv_timer() and falling back to hrtimers.

Opportunistically limit kvm_can_use_hv_timer() to lapic.c as the fastpath
code was the only external user.

Stating the obvious, this allows handling MSR_IA32_TSC_DEADLINE writes in
the fastpath on AMD CPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 +-
 arch/x86/kvm/lapic.h | 1 -
 arch/x86/kvm/x86.c   | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index bd3232dd7a63..e19545b8cc98 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -130,7 +130,7 @@ static bool kvm_can_post_timer_interrupt(struct kvm_vcpu *vcpu)
 		(kvm_mwait_in_guest(vcpu->kvm) || kvm_hlt_in_guest(vcpu->kvm));
 }
 
-bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu)
+static bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu)
 {
 	return kvm_x86_ops.set_hv_timer
 	       && !(kvm_mwait_in_guest(vcpu->kvm) ||
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 1b2d408816aa..8b00e29741de 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -249,7 +249,6 @@ void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu);
 void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu);
 bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu);
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu);
-bool kvm_can_use_hv_timer(struct kvm_vcpu *vcpu);
 
 static inline enum lapic_mode kvm_apic_mode(u64 apic_base)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ea117c4b20c8..63ca9185d133 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2150,9 +2150,6 @@ static int handle_fastpath_set_x2apic_icr_irqoff(struct kvm_vcpu *vcpu, u64 data
 
 static int handle_fastpath_set_tscdeadline(struct kvm_vcpu *vcpu, u64 data)
 {
-	if (!kvm_can_use_hv_timer(vcpu))
-		return 1;
-
 	kvm_set_lapic_tscdeadline_msr(vcpu, data);
 	return 0;
 }
-- 
2.50.1.565.gc32cd1483b-goog


