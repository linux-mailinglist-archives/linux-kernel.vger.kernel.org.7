Return-Path: <linux-kernel+bounces-878978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C391C21E57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996A818864F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2008E1F8908;
	Thu, 30 Oct 2025 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QvOi3wiS"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B432135B9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851738; cv=none; b=kUf0VotzGtvFPGuR0HZzDu9bbQKwmXh2cWeZA0bg1KKKmYqVmfiV36dr3Y9PD+he2eSK/xNd3Ka4MvgXm7gNX9WhYLum5kOpT3YJ4kdHyLbwzhp567mVo0m1GzXlmVyuDdCW1453MFio9dbV0KxyehTy73EgMxP62VhOK8IsNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851738; c=relaxed/simple;
	bh=s/j8oAqk1LO8lywmGIHCOU69Wyo7ZAJOhkz5KhrFPe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecAVd2pjHhu6wP18IHBbkuC4zhwYuTUl22E+XVnjRZ842acK1exLk2yPbT0eCae99/ctGZF15mgEUgieoP0sC4j+1Ie0sxdwUxgK4pazjxZ8Ud8hdefFUSz6hJ/H3uIzTj7wz+JFzkWm/mK9YlhQoFMRAQ6Uk1eYPLHe56qz22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QvOi3wiS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290992f9693so19866275ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761851736; x=1762456536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RIfvvqyC4pkF2mzEqWw3TYRNyqKqrDE0HW5h0ZeeWLw=;
        b=QvOi3wiSyX2oZDUQQtajyIpmScwDOYHzW09zf6MIXwWH60ueOiP9naeWrpICmdH5wn
         WJqqb7/r9+hkEpmRUCGkURLCvh9NPfk8uQFIabk3i5IBmP4LHfkp+Az3bZWtSFu7wEwv
         XNLbJcQ7zw2kuTrThRHV1R6cXkUdmZ/bO+LpUClA5hX4mDZx48tFjSX/I6YhNthuKYaV
         O0SZJKPuPUrSOkXtQyxbb76zpq4Z20adGFMiQBi+TpQCV7Es0oCxIJBWszE3XC0oBAzl
         OA880YzLf8uf3IJ8QKoOCz2er7nEwze4HrVDuurY7++s9nMx4qsa7etNHAJOSxgmSiL9
         kl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851736; x=1762456536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIfvvqyC4pkF2mzEqWw3TYRNyqKqrDE0HW5h0ZeeWLw=;
        b=IeEgm9M9X5W4KNX8CTwuCQwQsQXWDA2VEjQ+CfEyXFdnPS1zfIMxXEErfeNaO9KIux
         5R+/QfeEkOXKX2sh48EI5cpqp+dPuRG8QTzeNg61hFm1O6F6/s6udIsQMNTpX6jK23j3
         b0RsYbWlKOpYONg8/LEqfPpCG+qu9mdqDjlgVw6wZ3/oVVMh570cbBB2OYM2B1QqS36Q
         Y2vixGCF/D1fMKFxfMVK3dqIG61OxxKffrFukh3MwREsxoK5AKE1XDWf7Xn+BVqYfyfv
         N1QtJwlx4+99/v2G3vDMiie/5hJnq+LeP6zFKtsmbEUop37IywwTisy+hE19+PA6eWJP
         ZbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hPH+UexjZSrCgn7udMALjezLK92R3mjKaXRKSHJg/v46JrxXrFgbwn0ZIzX8WIaYYE/0kNh+3Q1knko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/u9GmoJGqulOnqQ1LJsdk1ewrsT4CU3EolYXQZyzvVvZMO9ow
	16QHxZbM80zA9dY9OgdYkTTUX474OkyV3VQ6CZhhlJVtU1YPcbt1Sryp1PGXi9DWEF4hhCB+41S
	X36e6LQ==
X-Google-Smtp-Source: AGHT+IH+436+sxPArkYZcKYPQII9ttXJyIOB3pB5LOkXSlNMmSPGsaxPPxQ7B5IoTdJPom2cUmt179+6PuE=
X-Received: from plbjy16.prod.google.com ([2002:a17:903:42d0:b0:290:28e2:ce5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d505:b0:290:b10f:9aec
 with SMTP id d9443c01a7336-294ed2c61c2mr47900205ad.26.1761851736057; Thu, 30
 Oct 2025 12:15:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 12:15:26 -0700
In-Reply-To: <20251030191528.3380553-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030191528.3380553-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030191528.3380553-3-seanjc@google.com>
Subject: [PATCH v5 2/4] KVM: x86: WARN if user-return MSR notifier is
 registered on exit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

When freeing the per-CPU user-return MSRs structures, WARN if any CPU has
a registered notifier to help detect and/or debug potential use-after-free
issues.  The lifecycle of the notifiers is rather convoluted, and has
several non-obvious paths where notifiers are unregistered, i.e. isn't
exactly the most robust code possible.

The notifiers they are registered on-demand in KVM, on the first WRMSR to
a tracked register.  _Usually_ the notifier is unregistered whenever the
CPU returns to userspace.  But because any given CPU isn't guaranteed to
return to userspace, e.g. the CPU could be offlined before doing so, KVM
also "drops", a.k.a. unregisters, the notifiers when virtualization is
disabled on the CPU.

Further complicating the unregister path is the fact that the calls to
disable virtualization come from common KVM, and the per-CPU calls are
guarded by a per-CPU flag (to harden _that_ code against bugs, e.g. due to
mishandling reboot).  Reboot/shutdown in particular is problematic, as KVM
disables virtualization via IPI function call, i.e. from IRQ context,
instead of using the cpuhp framework, which runs in task context.  I.e. on
reboot/shutdown, drop_user_return_notifiers() is called asynchronously.

Forced reboot/shutdown is the most problematic scenario, as userspace tasks
are not frozen before kvm_shutdown() is invoked, i.e. KVM could be actively
manipulating the user-return MSR lists and/or notifiers when the IPI
arrives.  To a certain extent, all bets are off when userspace forces a
reboot/shutdown, but KVM should at least avoid a use-after-free, e.g. to
avoid crashing the kernel when trying to reboot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 639589af7cbe..bb7a7515f280 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -575,6 +575,27 @@ static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)
 		vcpu->arch.apf.gfns[i] = ~0;
 }
 
+static int kvm_init_user_return_msrs(void)
+{
+	user_return_msrs = alloc_percpu(struct kvm_user_return_msrs);
+	if (!user_return_msrs) {
+		pr_err("failed to allocate percpu user_return_msrs\n");
+		return -ENOMEM;
+	}
+	kvm_nr_uret_msrs = 0;
+	return 0;
+}
+
+static void kvm_free_user_return_msrs(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(per_cpu_ptr(user_return_msrs, cpu)->registered);
+
+	free_percpu(user_return_msrs);
+}
+
 static void kvm_on_user_return(struct user_return_notifier *urn)
 {
 	unsigned slot;
@@ -10023,13 +10044,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		return -ENOMEM;
 	}
 
-	user_return_msrs = alloc_percpu(struct kvm_user_return_msrs);
-	if (!user_return_msrs) {
-		pr_err("failed to allocate percpu kvm_user_return_msrs\n");
-		r = -ENOMEM;
+	r = kvm_init_user_return_msrs();
+	if (r)
 		goto out_free_x86_emulator_cache;
-	}
-	kvm_nr_uret_msrs = 0;
 
 	r = kvm_mmu_vendor_module_init();
 	if (r)
@@ -10132,7 +10149,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 out_mmu_exit:
 	kvm_mmu_vendor_module_exit();
 out_free_percpu:
-	free_percpu(user_return_msrs);
+	kvm_free_user_return_msrs();
 out_free_x86_emulator_cache:
 	kmem_cache_destroy(x86_emulator_cache);
 	return r;
@@ -10161,7 +10178,7 @@ void kvm_x86_vendor_exit(void)
 #endif
 	kvm_x86_call(hardware_unsetup)();
 	kvm_mmu_vendor_module_exit();
-	free_percpu(user_return_msrs);
+	kvm_free_user_return_msrs();
 	kmem_cache_destroy(x86_emulator_cache);
 #ifdef CONFIG_KVM_XEN
 	static_key_deferred_flush(&kvm_xen_enabled);
-- 
2.51.1.930.gacf6e81ea2-goog


