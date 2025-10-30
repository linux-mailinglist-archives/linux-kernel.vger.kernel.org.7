Return-Path: <linux-kernel+bounces-879231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F3CC22968
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84E94E58B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4843134402C;
	Thu, 30 Oct 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4xpH9Pv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE933E371
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864178; cv=none; b=NV8Ozsn9cyTFJ3ru5eVg8H9PfJUCH+hfhjpWHUeqfQ1WWu/RjOGny1RBxM3A977twMl5xU9thQTwTZqN1/eQM7DvfQR54c7k6JeujfhCymL9fdZpSLrwPmM4yCC4L5kdvBCHI8pNaPT+YqVSI3wgBpTi7k84x6gWJL4Cp1xpeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864178; c=relaxed/simple;
	bh=Q3IKaU0lMVaiZZtzfDXHVnugKiDbrXd1PBIzSA/5k2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=idcowSLuixj8EpSXdi4Eha7lhD9jA6HcFFbOn1VQ6ce5ywPFRzAXUhc7IT+4Gw7YUZg5YYRcEvdcKm63/HvWWjsClPLKGXT6fOMI9v3rN3fb8i4VVEkuITIvLohhBwuN/iiKZh2qB5kHFohVY+H45+0jCS4nwTQ3tVocpHbtFgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4xpH9Pv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3408d2c733cso163338a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761864176; x=1762468976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EKedIzwMn7SF7dUWNz3EO5Nos8XGVIVqeHXtZTPKpE4=;
        b=m4xpH9Pvhr5Bq+S60YsTvi3JSYZtqb+2IotLFTAyH74l31jyYPGfbYDyOHGgCW/gw2
         GVLD6jrUcHFaLP97T+41BOIhJTI0np5kpB0Ukx28YYTn+kDOSbS0CEgTppLjlWLxGcn4
         la/12cMMM1I2sTPiQBYdhnV1AfsNMSlFZachWcjdnNHjTMzlDY4XRs1ASa8YSKz4HkhG
         w+/UXiVXFQ6cK4n/MO0+7fwpHXfnVPeQqj3R2kWDAAif4rzMOZEc0iWlx0v6Vdlu5Ntr
         IhizjCPGm3iQp9EIOWzyQ93+oTlQnT9fJGHLtfbHjAFJFa0cvgvfgHnUgwH+HwJClddl
         Mzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761864176; x=1762468976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKedIzwMn7SF7dUWNz3EO5Nos8XGVIVqeHXtZTPKpE4=;
        b=dJwXxtpSVZb7MDqZFWQ+HdsrXKK0eeVYS/pyGCgfev6/7N5i5LAZ1c+CQMz8hN+AW+
         SPHFQakkQSvXvmllajo4e1ZUvuMuJKEmeRKaXItg4aEd4ACTpLdAF5MdZ37y54XYn4jQ
         +NqucvzFopUb0ZJg8cmVvNqq+mHVLEgGvVdA83XmnmyurwBVzXUwwyIUB6UWZyL4rqtZ
         KRuuffefVhsLLyRoR2ZlU6vRZTjxTUt3VNay7yURL9bWkJ+3X9BHYY7GM/7ob2bp3Z4I
         YkZGr5vWZfx6Wm2tFPXtpqUNVIzC1UU98DgINjpo+6Kye7u46904Hzh5dUsuPkH2f38h
         d2qw==
X-Forwarded-Encrypted: i=1; AJvYcCXBb8PmeT8zw6S3pejDYfDMSFiq88azWR8OALPKGtLBJLvT+UNV+ZOh54fvjQTpdvNw18v2aXE0ZVGA34s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/PVQsyxSN9sBD7IA6ONHEcLuhqPyObhho+8cQgmjBqDyh1fd
	e4FUpV30AqIKiGsTBQUwXPDeO4ui83FtNqEA+nkz1KkxbUSnYf4SfvDD/GXpNA5fjtT8fc+pG1Q
	/I7ZO2A==
X-Google-Smtp-Source: AGHT+IG4IgkymewPfuyJcyHNn1i9KmPd0vhF5+MonWf9o3DNjWm26PdP041NcqMLXgTt3a2SPoDdFxsfTZo=
X-Received: from pjm14.prod.google.com ([2002:a17:90b:2fce:b0:340:6b70:821e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f8b:b0:31e:d4e3:4002
 with SMTP id 98e67ed59e1d1-34082fab62emr1907294a91.2.1761864176204; Thu, 30
 Oct 2025 15:42:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 15:42:45 -0700
In-Reply-To: <20251030224246.3456492-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030224246.3456492-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030224246.3456492-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: x86: Load guest/host XCR0 and XSS outside of the
 fastpath run loop
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"

Move KVM's swapping of XFEATURE masks, i.e. XCR0 and XSS, out of the
fastpath loop now that the guts of the #MC handler runs in task context,
i.e. won't invoke schedule() with preemption disabled and clobber state
(or crash the kernel) due to trying to context switch XSTATE with a mix
of host and guest state.

For all intents and purposes, this reverts commit 1811d979c716 ("x86/kvm:
move kvm_load/put_guest_xcr0 into atomic context"), which papered over an
egregious bug/flaw in the #MC handler where it would do schedule() even
though IRQs are disabled.  E.g. the call stack from the commit:

  kvm_load_guest_xcr0
  ...
  kvm_x86_ops->run(vcpu)
    vmx_vcpu_run
      vmx_complete_atomic_exit
        kvm_machine_check
          do_machine_check
            do_memory_failure
              memory_failure
                lock_page

Commit 1811d979c716 "fixed" the immediate issue of XRSTORS exploding, but
completely ignored that scheduling out a vCPU task while IRQs and
preemption is wildly broken.  Thankfully, commit 5567d11c21a1 ("x86/mce:
Send #MC singal from task work") (somewhat incidentally?) fixed that flaw
by pushing the meat of the work to the user-return path, i.e. to task
context.

KVM has also hardened itself against #MC goofs by moving #MC forwarding to
kvm_x86_ops.handle_exit_irqoff(), i.e. out of the fastpath.  While that's
by no means a robust fix, restoring as much state as possible before
handling the #MC will hopefully provide some measure of protection in the
event that #MC handling goes off the rails again.

Note, KVM always intercepts XCR0 writes for vCPUs without protected state,
e.g. there's no risk of consuming a stale XCR0 when determining if a PKRU
update is needed; kvm_load_host_xfeatures() only reads, and never writes,
vcpu->arch.xcr0.

Deferring the XCR0 and XSS loads shaves ~300 cycles off the fastpath for
Intel, and ~500 cycles for AMD.  E.g. using INVD in KVM-Unit-Test's
vmexit.c, which an extra hack to enable CR4.OXSAVE, latency numbers for
AMD Turin go from ~2000 => 1500, and for Intel Emerald Rapids, go from
~1300 => ~1000.

Cc: Jon Kohler <jon@nutanix.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b4b5d2d09634..b5c2879e3330 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1203,13 +1203,12 @@ void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_lmsw);
 
-void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
+static void kvm_load_guest_xfeatures(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.guest_state_protected)
 		return;
 
 	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
-
 		if (vcpu->arch.xcr0 != kvm_host.xcr0)
 			xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);
 
@@ -1217,6 +1216,27 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 		    vcpu->arch.ia32_xss != kvm_host.xss)
 			wrmsrq(MSR_IA32_XSS, vcpu->arch.ia32_xss);
 	}
+}
+
+static void kvm_load_host_xfeatures(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.guest_state_protected)
+		return;
+
+	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
+		if (vcpu->arch.xcr0 != kvm_host.xcr0)
+			xsetbv(XCR_XFEATURE_ENABLED_MASK, kvm_host.xcr0);
+
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVES) &&
+		    vcpu->arch.ia32_xss != kvm_host.xss)
+			wrmsrq(MSR_IA32_XSS, kvm_host.xss);
+	}
+}
+
+void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.guest_state_protected)
+		return;
 
 	if (cpu_feature_enabled(X86_FEATURE_PKU) &&
 	    vcpu->arch.pkru != vcpu->arch.host_pkru &&
@@ -1238,17 +1258,6 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.pkru != vcpu->arch.host_pkru)
 			wrpkru(vcpu->arch.host_pkru);
 	}
-
-	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
-
-		if (vcpu->arch.xcr0 != kvm_host.xcr0)
-			xsetbv(XCR_XFEATURE_ENABLED_MASK, kvm_host.xcr0);
-
-		if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVES) &&
-		    vcpu->arch.ia32_xss != kvm_host.xss)
-			wrmsrq(MSR_IA32_XSS, kvm_host.xss);
-	}
-
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_load_host_xsave_state);
 
@@ -11292,6 +11301,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 
+	kvm_load_guest_xfeatures(vcpu);
+
 	if (unlikely(vcpu->arch.switch_db_regs &&
 		     !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
 		set_debugreg(DR7_FIXED_1, 7);
@@ -11378,6 +11389,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	vcpu->mode = OUTSIDE_GUEST_MODE;
 	smp_wmb();
 
+	kvm_load_host_xfeatures(vcpu);
+
 	/*
 	 * Sync xfd before calling handle_exit_irqoff() which may
 	 * rely on the fact that guest_fpu::xfd is up-to-date (e.g.
-- 
2.51.1.930.gacf6e81ea2-goog


