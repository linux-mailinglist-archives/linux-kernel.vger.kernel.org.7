Return-Path: <linux-kernel+bounces-758249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 599DDB1CCE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B97166567
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB102D63FA;
	Wed,  6 Aug 2025 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i7queIt9"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE02D3EDF
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510286; cv=none; b=nTX2QRz+vKga+nvdjD906bLDwAjKwH0mp1ylnYFUdhpDRwLjcDO2OO9+pniJ3ukprTomfAwwQ76xFbjE8duTOTuBkWyF49iR/Rv6tTHiO9LcQhwuATGFSxashJJYktyI2HsgbjiBOeEE9svO6dNfZmzPPP5+XTvkyVhMTwwDkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510286; c=relaxed/simple;
	bh=PBnkLLFYZ4s5Yu2szvXDrhvmuZxi6mGoAiraC4ZgJBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UFDFiv5p4NBegxd+XJ3BoAEYM+7RC0Tc4kmwoc3QzGdw+eJazcXKPfcQwAbuV1O3MqB13yygFimCl7cYo+Rb6d65fqzmEa9HkrQfv9oWF8ZWu0qxO8qIUhIUnY0i+2KOlEoHt3RN2P6IQncBFSMnREykgCEYfABhzNbocq/sJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i7queIt9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3215b3229c7so289717a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510282; x=1755115082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+6JQFfV5PUy/GrVBLvUiN2dICAbUeOItkyPrKIFKW8s=;
        b=i7queIt9V50ibqXGMFXWSTONrwyZMUxKjj8xt7+Re0R1BKVqAOlmnb2rNJFkecz/R4
         8xgPGZtgK8xHwWWgDMV/SfnI9gkxDXLYeB4TQl7XmQ8lX6ihE46Fbq08V9ehfkbg21vC
         oSgaWInhXoIo4d2Ue/tV5Pf2x4EZWrmazm022wujtd5w+u5y8CUwetYo9Wifm9MRLRcv
         GXqqekyOntW7NJ2IKyct5cU7/3nYyUr3LhehOCmmu2nnLpEP6CnIWcLcTNLWmYBHkfXh
         QEjRUO1KCd65/WTWgBe3LUgdUpaXwiY8YNa+lPTU44ggEn3+5YYBSkkV4/1VRky5uVOx
         FoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510282; x=1755115082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6JQFfV5PUy/GrVBLvUiN2dICAbUeOItkyPrKIFKW8s=;
        b=kUs7ph1l9nYMKPfBlwEKBCZSkrRl89TgD1GBc7YiT0jdNb8u2EmzW3hSHXlHufdJZN
         crrldOLxcXQQzcdtCM1b8EeBlN1G8d6/+mVuo3H3nsZIsnfACG9+IJNo8uijgRD0QZ+8
         bt3IubpCvj6GO+0mVsXHrsC3KejKN2sZssviUGo8SnvzPLy9P1QQBWoJ3pp3F176EzPT
         +0vRERm8IzbKhDv97boNexa4H+vyjsNy9T9jQy81XLvZeGQNQcL2pobxzubDi8pUgJ3j
         Z5yq074h8w3FE/fuW4as3Nfl/cy7XnFI+gqzQulCiEp+UiNslV5BDHN0IFqXdIJ0wKBL
         wyMg==
X-Forwarded-Encrypted: i=1; AJvYcCU8YwESRuvSOdSKf46JXHH8+RbFa+DyKc4M3y2RPDNhZOFBnTGxNsmXRiAcU0//BL5+H7SAvTkRJ2rs8tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbacEQKLQuwZNP5Cq/6QgIPFeqJ7NYdbzcqg4CUzRznvQNLwZ1
	GSWsm7qZnARjsjkX8RdT/FHECC7POaTiV/+kxnUZ2g5z2K5LMJLkzz/noGKixJvKg5HkGiaJQJD
	iCoXPeA==
X-Google-Smtp-Source: AGHT+IGZ7oKb0jL8lhNyyp9dHD+Kz4ijKlmhkeksSN6TGP0ouV8c6R8BFKEuTTGgS97308bG3SsY+cafJuk=
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:311:c5d3:c7d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1812:b0:318:f0cb:5a50
 with SMTP id 98e67ed59e1d1-32166cc88e8mr4877815a91.26.1754510281698; Wed, 06
 Aug 2025 12:58:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:40 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-19-seanjc@google.com>
Subject: [PATCH v5 18/44] KVM: x86/pmu: Start stubbing in mediated PMU support
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Introduce enable_mediated_pmu as a global variable, with the intent of
exposing it to userspace a vendor module parameter, to control and reflect
mediated vPMU support.  Wire up the perf plumbing to create+release a
mediated PMU, but defer exposing the parameter to userspace until KVM
support for a mediated PMUs is fully landed.

To (a) minimize compatibility issues, (b) to give userspace a chance to
opt out of the restrictive side-effects of perf_create_mediated_pmu(),
and (c) to avoid adding new dependencies between enabling an in-kernel
irqchip and a mediated vPMU, defer "creating" a mediated PMU in perf
until the first vCPU is created.

Regarding userspace compatibility, an alternative solution would be to
make the mediated PMU fully opt-in, e.g. to avoid unexpected failure due
to perf_create_mediated_pmu() failing.  Ironically, that approach creates
an even bigger compatibility issue, as turning on enable_mediated_pmu
would silently break VMMs that don't utilize KVM_CAP_PMU_CAPABILITY (well,
silently until the guest tried to access PMU assets).

Regarding an in-kernel irqchip, create a mediated PMU if and only if the
VM has an in-kernel local APIC, as the mediated PMU will take a hard
dependency on forwarding PMIs to the guest without bouncing through host
userspace.  Silently "drop" the PMU instead of rejecting KVM_CREATE_VCPU,
as KVM's existing vPMU support doesn't function correctly if the local
APIC is emulated by userspace, e.g. PMIs will never be delivered.  I.e.
it's far, far more likely that rejecting KVM_CREATE_VCPU would cause
problems, e.g. for tests or userspace daemons that just want to probe
basic KVM functionality.

Note!  Deliberately make mediated PMU creation "sticky", i.e. don't unwind
it on failure to create a vCPU.  Practically speaking, there's no harm to
having a VM with a mediated PMU and no vCPUs.  To avoid an "impossible" VM
setup, reject KVM_CAP_PMU_CAPABILITY if a mediated PMU has been created,
i.e. don't let userspace disable PMU support after failed vCPU creation
(with PMU support enabled).

Defer vendor specific requirements and constraints to the future.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Co-developed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.c              |  4 ++++
 arch/x86/kvm/pmu.h              |  7 +++++++
 arch/x86/kvm/x86.c              | 37 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/x86.h              |  1 +
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7680612ba1e..ff0d753e2b07 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1471,6 +1471,7 @@ struct kvm_arch {
 
 	bool bus_lock_detection_enabled;
 	bool enable_pmu;
+	bool created_mediated_pmu;
 
 	u32 notify_window;
 	u32 notify_vmexit_flags;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0f3e011824ed..4d4bb9b17412 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -133,6 +133,10 @@ void kvm_init_pmu_capability(const struct kvm_pmu_ops *pmu_ops)
 			enable_pmu = false;
 	}
 
+	if (!enable_pmu || !enable_mediated_pmu || !kvm_host_pmu.mediated ||
+	    !pmu_ops->is_mediated_pmu_supported(&kvm_host_pmu))
+		enable_mediated_pmu = false;
+
 	if (!enable_pmu) {
 		memset(&kvm_pmu_cap, 0, sizeof(kvm_pmu_cap));
 		return;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 08ae644db00e..f5b6181b772c 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -37,6 +37,8 @@ struct kvm_pmu_ops {
 	void (*deliver_pmi)(struct kvm_vcpu *vcpu);
 	void (*cleanup)(struct kvm_vcpu *vcpu);
 
+	bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
+
 	const u64 EVENTSEL_EVENT;
 	const int MAX_NR_GP_COUNTERS;
 	const int MIN_NR_GP_COUNTERS;
@@ -58,6 +60,11 @@ static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
 	return pmu->version > 1;
 }
 
+static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
+{
+	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
+}
+
 /*
  * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
  * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d80bbd5e0859..396d1aa81732 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -187,6 +187,10 @@ bool __read_mostly enable_pmu = true;
 EXPORT_SYMBOL_GPL(enable_pmu);
 module_param(enable_pmu, bool, 0444);
 
+/* Enable/disabled mediated PMU virtualization. */
+bool __read_mostly enable_mediated_pmu;
+EXPORT_SYMBOL_GPL(enable_mediated_pmu);
+
 bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
@@ -6542,7 +6546,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 
 		mutex_lock(&kvm->lock);
-		if (!kvm->created_vcpus) {
+		if (!kvm->created_vcpus && !kvm->arch.created_mediated_pmu) {
 			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
 			r = 0;
 		}
@@ -12174,8 +12178,13 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+#define PERF_MEDIATED_PMU_MSG \
+	"Failed to enable mediated vPMU, try disabling system wide perf events and nmi_watchdog.\n"
+
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
+	int r;
+
 	if (kvm_check_tsc_unstable() && kvm->created_vcpus)
 		pr_warn_once("SMP vm created on host with unstable TSC; "
 			     "guest TSC will not be reliable\n");
@@ -12186,7 +12195,29 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	if (id >= kvm->arch.max_vcpu_ids)
 		return -EINVAL;
 
-	return kvm_x86_call(vcpu_precreate)(kvm);
+	/*
+	 * Note, any actions done by .vcpu_create() must be idempotent with
+	 * respect to creating multiple vCPUs, and therefore are not undone if
+	 * creating a vCPU fails (including failure during pre-create).
+	 */
+	r = kvm_x86_call(vcpu_precreate)(kvm);
+	if (r)
+		return r;
+
+	if (enable_mediated_pmu && kvm->arch.enable_pmu &&
+	    !kvm->arch.created_mediated_pmu) {
+		if (irqchip_in_kernel(kvm)) {
+			r = perf_create_mediated_pmu();
+			if (r) {
+				pr_warn_ratelimited(PERF_MEDIATED_PMU_MSG);
+				return r;
+			}
+			kvm->arch.created_mediated_pmu = true;
+		} else {
+			kvm->arch.enable_pmu = false;
+		}
+	}
+	return 0;
 }
 
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
@@ -12818,6 +12849,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		__x86_set_memory_region(kvm, TSS_PRIVATE_MEMSLOT, 0, 0);
 		mutex_unlock(&kvm->slots_lock);
 	}
+	if (kvm->arch.created_mediated_pmu)
+		perf_release_mediated_pmu();
 	kvm_destroy_vcpus(kvm);
 	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
 #ifdef CONFIG_KVM_IOAPIC
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 46220b04cdf2..bd1149768acc 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -445,6 +445,7 @@ extern struct kvm_caps kvm_caps;
 extern struct kvm_host_values kvm_host;
 
 extern bool enable_pmu;
+extern bool enable_mediated_pmu;
 
 /*
  * Get a filtered version of KVM's supported XCR0 that strips out dynamic
-- 
2.50.1.565.gc32cd1483b-goog


