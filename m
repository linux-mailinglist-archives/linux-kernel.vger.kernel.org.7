Return-Path: <linux-kernel+bounces-705306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B49AEA808
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 22:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC9C1C45855
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDDC302CC6;
	Thu, 26 Jun 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xi+Dn9KF"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FF42F19A6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968378; cv=none; b=H0DNQvEseABS2PMgJrS08lnQQKCyVaPsWBbVKEfggky1ec7ZTlrw/HMwhhzlEOp9PKp707yg804uPNNXtOBaZ1Pq8qDUYvARQnL0avt4upNs7EyvuM3BbGXnGW76peyAGKCF+5RuRdZVt/h8IH00qLqksnBdAlIMFziI1HabcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968378; c=relaxed/simple;
	bh=Ur9B1M7+gVwDPw0f+x/fdeLOw95hKGc1bWeTEwS7dE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnA9FSSFiG5wPoUIbNU1+MYRh3z1q3WPykid9diUa342P7EY75FfSDyRtC8nJrjVJRngIxendVQQYfbHRqb4ZAVQ7otfqFr24W24psRgk+h43EFTsWM54nPhReqlnRiaQJhJnRiubm8b4ucb4U6oQSxQJ8nbT83SdYGmpICxgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xi+Dn9KF; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3ddc0a6d4bdso17350785ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750968373; x=1751573173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHvOqMg130dyJ4sC7dKVjeSNT/BBBCVrJwL/iamcsPo=;
        b=Xi+Dn9KFWLjD+O4rPp6pFMaNvpEiGq1iZo+F3eOKnnkKIrw5Y9y9UViBXXj62zzI9r
         5MrE/dwSFIk2G++iWxE4RyQWEV/HHTOJQh5SpA/hJwfxfRj6ZEqaEloieQNFHO0HM9IS
         OLSF1QWwmqQHfBn+mvZO9dCNVk/Nx7YoWq047qfIm9ZaazHVUIKa0DgmjkcU4sHd38U6
         acc53HoMcEs+uiyQ+TmYRk4STBh1r8oRrKqDgExSNGcmkQPoZnwndbFvbicjyS3R6otX
         Xa+okcUsljRR/YClHHeRLhFSkkcvYOF0KxsOE5MoUBAneE5TyGvDOzsVeVnMDKC1q/u6
         oFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968373; x=1751573173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHvOqMg130dyJ4sC7dKVjeSNT/BBBCVrJwL/iamcsPo=;
        b=uOZVG9KZEPiAsEGT9kpRcB2sfEjva5G0aVfxbYZS2Iiz5K8txhoLTd1sNaBGRuGhQw
         0IcafHanNww4vr4t6kYjQSs12g/6zQM7TFZsuSWxo9pQu4nAU+4jJyUw0dGvRx0NjRDl
         Be8wtdjfM7Zsgk73VWQgi8DJzC9nAU2NL2rzF+YwfPIImT3c7z3x1lwNIh4A8p0+rEP+
         JyLedujSb+ivZlh1z8Z8/xPxZlTYXukcjNrh9wG6uyzauQ0wRVc0341Em8X0kmVUokGB
         njI6QRQLA8L6DEwneEe8DmplzoitpU4xS1E6tni9X1mE2UKHgdCTYTSY7e1ehDuqMMk0
         Wbrg==
X-Forwarded-Encrypted: i=1; AJvYcCVrY5qHLYCmer1ZJG56ujH57+YFoiIsA3S5lRuKPZB03x+3IFvGrDlBzhHl+WIl764rkizL4iGB7VZLD4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzKb9JISkI1S/pq50qWckWaQCB6keLrS2SKoe8Z8wUL2tz31D
	e/uta6g9idA9F+TjovYNsr9doj9FEJ5BcFs5j/Tc1x+wy6jhR+BB13gFo4niF/xGcg9lFsTAeSn
	jWovB0l0zh0v9Crf5bXDwewCltA==
X-Google-Smtp-Source: AGHT+IFCTmpcPKfhbRYfbWmSV70zC3G54uswHvEuJzrqC5pwlW7LzTFUxkgmMX60c/miGwoG/j77iicLZrxALiS37Q==
X-Received: from ilbec6.prod.google.com ([2002:a05:6e02:4706:b0:3df:16fc:af6f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1c23:b0:3dd:dd39:324c with SMTP id e9e14a558f8ab-3df4ab6d058mr11317385ab.9.1750968373400;
 Thu, 26 Jun 2025 13:06:13 -0700 (PDT)
Date: Thu, 26 Jun 2025 20:04:57 +0000
In-Reply-To: <20250626200459.1153955-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250626200459.1153955-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250626200459.1153955-22-coltonlewis@google.com>
Subject: [PATCH v3 21/22] KVM: arm64: Add ioctl to partition the PMU when supported
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add KVM_ARM_PMU_PARTITION to enable the partitioned PMU for a given
vCPU. Add a corresponding KVM_CAP_ARM_PMU_PARTITION to check for this
ability. This capability is allowed on an initialized vCPU where PMUv3
and VHE are supported.

However, because the underlying ability relies on the driver being
passed some command line arguments to configure the hardware partition
at boot, enabling the partitioned PMU will not be allowed without the
underlying driver configuration even though the capability exists.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 Documentation/virt/kvm/api.rst    | 21 +++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/arm.c              | 20 ++++++++++++++++++++
 arch/arm64/kvm/pmu-part.c         |  3 ++-
 include/uapi/linux/kvm.h          |  4 ++++
 5 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 4ef3d8482000..7e76f7c87598 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6478,6 +6478,27 @@ the capability to be present.
 
 `flags` must currently be zero.
 
+4.144 KVM_ARM_PARTITION_PMU
+---------------------------
+
+:Capability: KVM_CAP_ARM_PARTITION_PMU
+:Architectures: arm64
+:Type: vcpu ioctl
+:Parameters: arg[0] is a boolean to enable the partitioned PMU
+
+This API controls the PMU implementation used for VMs. The capability
+is only available if the host PMUv3 driver was configured for
+partitioning via the module parameters `arm-pmuv3.partition_pmu=y` and
+`arm-pmuv3.reserved_guest_counters=[0-$NR_COUNTERS]`. When enabled,
+VMs are configured to have direct hardware access to the most
+frequently used registers for the counters configured by the
+aforementioned module parameters, bypassing the KVM traps in the
+standard emulated PMU implementation and reducing overhead of any
+guest software that uses PMU capabilities such as `perf`.
+
+If the host driver was configured for partitioning but the partitioned
+PMU is disabled through this interface, the VM will use the legacy PMU
+that shares the host partition.
 
 .. _kvm_run:
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2df76689381a..3f835b28c855 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -369,6 +369,9 @@ struct kvm_arch {
 	/* Maximum number of counters for the guest */
 	u8 nr_pmu_counters;
 
+	/* Whether this guest uses the partitioned PMU */
+	bool partitioned_pmu_enable;
+
 	/* Iterator for idreg debugfs */
 	u8	idreg_debugfs_iter;
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7c007ee44ecb..cb4380f39d98 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -21,6 +21,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/psci.h>
+#include <linux/perf/arm_pmu.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -38,6 +39,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_pmu.h>
 #include <asm/kvm_pkvm.h>
 #include <asm/kvm_pmu.h>
 #include <asm/kvm_ptrauth.h>
@@ -383,6 +385,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_PMU_V3:
 		r = kvm_supports_guest_pmuv3();
 		break;
+	case KVM_CAP_ARM_PARTITION_PMU:
+		r = kvm_pmu_partition_supported();
+		break;
 	case KVM_CAP_ARM_INJECT_SERROR_ESR:
 		r = cpus_have_final_cap(ARM64_HAS_RAS_EXTN);
 		break;
@@ -1810,6 +1815,21 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 
 		return kvm_arm_vcpu_finalize(vcpu, what);
 	}
+	case KVM_ARM_PARTITION_PMU: {
+		bool enable;
+
+		if (unlikely(!kvm_vcpu_initialized(vcpu)))
+			return -ENOEXEC;
+
+		if (!kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu))
+			return -EPERM;
+
+		if (copy_from_user(&enable, argp, sizeof(enable)))
+			return -EFAULT;
+
+		vcpu->kvm->arch.partitioned_pmu_enable = enable;
+		return 0;
+	}
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/arm64/kvm/pmu-part.c b/arch/arm64/kvm/pmu-part.c
index 165d1eae2634..7b5c5fcc6623 100644
--- a/arch/arm64/kvm/pmu-part.c
+++ b/arch/arm64/kvm/pmu-part.c
@@ -53,7 +53,8 @@ bool kvm_pmu_is_partitioned(struct arm_pmu *pmu)
  */
 bool kvm_vcpu_pmu_is_partitioned(struct kvm_vcpu *vcpu)
 {
-	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu);
+	return kvm_pmu_is_partitioned(vcpu->kvm->arch.arm_pmu)
+		&& vcpu->kvm->arch.partitioned_pmu_enable;
 }
 
 /**
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c74cf8f73337..2f8a8d4cfe3c 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -935,6 +935,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_GMEM_SHARED_MEM 243
+#define KVM_CAP_ARM_PARTITION_PMU 244
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1413,6 +1414,9 @@ struct kvm_enc_region {
 #define KVM_GET_SREGS2             _IOR(KVMIO,  0xcc, struct kvm_sregs2)
 #define KVM_SET_SREGS2             _IOW(KVMIO,  0xcd, struct kvm_sregs2)
 
+/* Available with KVM_CAP_ARM_PARTITION_PMU */
+#define KVM_ARM_PARTITION_PMU	_IOWR(KVMIO, 0xce, bool)
+
 #define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE    (1 << 0)
 #define KVM_DIRTY_LOG_INITIALLY_SET            (1 << 1)
 
-- 
2.50.0.727.gbf7dc18ff4-goog


