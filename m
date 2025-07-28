Return-Path: <linux-kernel+bounces-748463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBABB14186
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8491683D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD5C283144;
	Mon, 28 Jul 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZebeFmk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414BF27CB35
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725228; cv=none; b=jQVHQKb/H0lemeIExSG2tHrG/ficqAV0QrkXUYeAwlG+xibjHJllmz4Y6gmbdwDkdQgMTarykamFJceG9QgAPpUlbYEZCshGQowPLHZ0Zfo/DkHSJ9XUY51xf7k2EM7umQiKLdB5ypissyisnn/7D1C9t7XZME8+GkEvZ/hwVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725228; c=relaxed/simple;
	bh=liFB2EO0mTS7ouQXAJr+MbUQE7dxgMTj1glZvyzpGXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4SqqIl8vAvGFJi0JbVk/YlxTmOK1I7giHPSG7Ls10PEnAswPlS4H6oDzEp+5A72M/26fPXQXl/+JKIR1RNJ+kgqORi3lROHP7rmWop9AW8yLpDFu58Do7YnryyTshBfxcW0vmcTcFtBBEKpy5JJlLPGueRwMXed7x/cEZHQggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZebeFmk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4561611dc2aso33517805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725225; x=1754330025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JNqiciGNbDvOVxE+CtY3bj2b4l2gg16t6NtA8moWKCo=;
        b=cZebeFmkCsf6qfmZCMVJZpgPILu+kX1Hxj+nwyyzlBHsDQsnj4RrpdTssbLarH1p5G
         92bCm+Fntf740Azv56oVpvtq5Cx+b4+jXUtCMpiK+tB9/LE3FEwVkHfvPFZFAEA9Tn2l
         ZXfdKEftXLh8j5ahIKBb8Dzg2PvGHRrgCnqPqYDfEPhdTAI1kxjEz32xLFC2ExbDtWkd
         Iv3TPIezLZ2stes8BiNhxp1ZcJI2xUvG14dpOlGX4W5wsHyvZ52SP0NBAizdmTYaFIPK
         Niazmjynqyo0hOFlJhAgeZZBeYmUBviBKoDUenZtHzEuvM4GkRPvq2DoUURpFP43K9W0
         25+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725225; x=1754330025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNqiciGNbDvOVxE+CtY3bj2b4l2gg16t6NtA8moWKCo=;
        b=apjDfD6NtoCCj6Uo9DpkN5bBdr/mu04P1YicCmnUxxHLFqjDYDkpziuguMgL61HdFD
         d1kex+MKGEEWhY/P8JOn0AN1fARXj5nDIlPa7TXHK2UZYoekKP2hyy+nCqOYjvkUSr0V
         yFzosjio8QlAjMqOB3Q8BVRX/w+1eZVE/qofEAfnzBdUIctT/GCzbBkWi+skZe/fsPwI
         fOCvhwVZaufgdZw70mCPywChtEi7MHn6dwFuIU3labyVmuQp/A54ZVxzl4rPYUH5KPRh
         MKqiE6W5+wGeOFM1v+VMPBkXDjQ+4rHq7NoFAyPIsbCCrFLBA0l/VYfO474JgeEwIRRk
         wRHA==
X-Gm-Message-State: AOJu0Ywyvl12BjIF+3Ly4+OhWvQAvtmrgQbfi09KdWPZOHLXQCaufuEG
	7Fpb/KMgRa0e2dYG2XzEfWlkehgKYWs/sBJJRTU90fIghxvLJ8hfufj/q9ZxPtCHCUTDlQpKasp
	tC6ADzc2wtjEAoHzY0MruODQ1g7L7lw+QJzJ+5f3Nqt9iz1BSrjutWWtg6YNLolt3h0o2GAKFwr
	Haw+YM8QRtahaY7yvB1TZC52xfKzzQVh8QKg9h4TriEsuwYrugWDuB7Hc=
X-Google-Smtp-Source: AGHT+IEz09KUv2OxAPyDlzfr699/1qziOwALIawld3qpvPOE7K8k/mL0W2XcO/kW0IXD9mKeU33jEW1uY9lkQw==
X-Received: from wmbei27.prod.google.com ([2002:a05:600c:3f1b:b0:456:1b6f:c878])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6748:b0:456:eab:633e with SMTP id 5b1f17b1804b1-4587dd0db72mr87600635e9.17.1753725224509;
 Mon, 28 Jul 2025 10:53:44 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:01 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-15-smostafa@google.com>
Subject: [PATCH v3 14/29] KVM: arm64: iommu: Introduce IOMMU driver infrastructure
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

To establish DMA isolation, KVM needs an IOMMU driver which provide
certain ops, these ops are defined outside of the iommu_ops,
and has 2 components:
- kvm_iommu_driver (kernel): Implements simple interaction with
  the kernel (init, remove,...)
- kvm_iommu_ops (hypervisor): Implements identity mapping for
  the IOMMU page tables

Only one driver can be used and is registered with
kvm_iommu_register_driver() by passing pointers to both ops.

The flow of the KVM IOMMU drivers works as follows:
- The KVM IOMMU driver in the kernel after being loaded using an
  initcall (before module_init) it would register with KVM both
  the kernel and hypervisor ops.
- KVM will initialise the driver after it initialises and before the
  de-privilege point, which is a suitable point to establish trusted
  interaction between the host and the hypervisor.
  In this call the IOMMU kernel driver typically starts probing
  the IOMMUs, parsing firmware tables and initialising hardware.
- Then the hypervisor init will be called, to take over the IOMMUs
  and initialise its data structures.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h       |  9 +++++
 arch/arm64/kvm/Makefile                 |  3 +-
 arch/arm64/kvm/arm.c                    |  8 +++-
 arch/arm64/kvm/hyp/include/nvhe/iommu.h | 13 +++++++
 arch/arm64/kvm/hyp/nvhe/Makefile        |  3 +-
 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 18 +++++++++
 arch/arm64/kvm/hyp/nvhe/setup.c         |  5 +++
 arch/arm64/kvm/iommu.c                  | 49 +++++++++++++++++++++++++
 8 files changed, 105 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/iommu.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
 create mode 100644 arch/arm64/kvm/iommu.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3e41a880b062..43f5a64bbd1d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1674,5 +1674,14 @@ void compute_fgu(struct kvm *kvm, enum fgt_group_id fgt);
 void get_reg_fixed_bits(struct kvm *kvm, enum vcpu_sysreg reg, u64 *res0, u64 *res1);
 void check_feature_map(void);
 
+struct kvm_iommu_driver {
+	int (*init_driver)(void);
+	void (*remove_driver)(void);
+};
+
+struct kvm_iommu_ops;
+int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops, struct kvm_iommu_ops *hyp_ops);
+int kvm_iommu_init_driver(void);
+void kvm_iommu_remove_driver(void);
 
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 7c329e01c557..5528704bfd72 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,7 +23,8 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
 	 vgic/vgic-mmio.o vgic/vgic-mmio-v2.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
-	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o
+	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
+	 iommu.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 23dd3f3fc3eb..2f494f402c48 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2451,10 +2451,16 @@ static int __init kvm_hyp_init_protection(u32 hyp_va_bits)
 	if (ret)
 		return ret;
 
-	ret = do_pkvm_init(hyp_va_bits);
+	ret = kvm_iommu_init_driver();
 	if (ret)
 		return ret;
 
+	ret = do_pkvm_init(hyp_va_bits);
+	if (ret) {
+		kvm_iommu_remove_driver();
+		return ret;
+	}
+
 	free_hyp_pgds();
 
 	return 0;
diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
new file mode 100644
index 000000000000..1ac70cc28a9e
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_NVHE_IOMMU_H__
+#define __ARM64_KVM_NVHE_IOMMU_H__
+
+#include <asm/kvm_host.h>
+
+struct kvm_iommu_ops {
+	int (*init)(void);
+};
+
+int kvm_iommu_init(void);
+
+#endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index a76522d63c3e..393ff143f0be 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -24,7 +24,8 @@ CFLAGS_switch.nvhe.o += -Wno-override-init
 
 hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
-	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
+	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o \
+	 iommu/iommu.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
new file mode 100644
index 000000000000..a01c036c55be
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU operations for pKVM
+ *
+ * Copyright (C) 2022 Linaro Ltd.
+ */
+#include <nvhe/iommu.h>
+
+/* Only one set of ops supported */
+struct kvm_iommu_ops *kvm_iommu_ops;
+
+int kvm_iommu_init(void)
+{
+	if (!kvm_iommu_ops || !kvm_iommu_ops->init)
+		return -ENODEV;
+
+	return kvm_iommu_ops->init();
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index ee6435473204..bdbc77395e03 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -13,6 +13,7 @@
 #include <nvhe/early_alloc.h>
 #include <nvhe/ffa.h>
 #include <nvhe/gfp.h>
+#include <nvhe/iommu.h>
 #include <nvhe/memory.h>
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
@@ -320,6 +321,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = kvm_iommu_init();
+	if (ret)
+		goto out;
+
 	ret = hyp_ffa_init(ffa_proxy_pages);
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
new file mode 100644
index 000000000000..39465101074a
--- /dev/null
+++ b/arch/arm64/kvm/iommu.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Google LLC
+ * Author: Mostafa Saleh <smostafa@google.com>
+ */
+
+#include <asm/kvm_mmu.h>
+#include <linux/kvm_host.h>
+
+struct kvm_iommu_driver *iommu_driver;
+extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
+
+int kvm_iommu_register_driver(struct kvm_iommu_driver *kern_ops, struct kvm_iommu_ops *el2_ops)
+{
+	int ret;
+
+	if (WARN_ON(!kern_ops || !el2_ops))
+		return -EINVAL;
+
+	/*
+	 * Paired with smp_load_acquire(&iommu_driver)
+	 * Ensure memory stores happening during a driver
+	 * init are observed before executing kvm iommu callbacks.
+	 */
+	ret = cmpxchg_release(&iommu_driver, NULL, kern_ops) ? -EBUSY : 0;
+	if (ret)
+		return ret;
+
+	kvm_nvhe_sym(kvm_iommu_ops) = el2_ops;
+	return 0;
+}
+
+int kvm_iommu_init_driver(void)
+{
+	/* See kvm_iommu_register_driver() */
+	if (WARN_ON(!smp_load_acquire(&iommu_driver))) {
+		kvm_err("pKVM enabled without an IOMMU driver, do not run confidential workload in virtual machines\n");
+		return -ENODEV;
+	}
+
+	return iommu_driver->init_driver();
+}
+
+void kvm_iommu_remove_driver(void)
+{
+	/* See kvm_iommu_register_driver() */
+	if (smp_load_acquire(&iommu_driver))
+		iommu_driver->remove_driver();
+}
-- 
2.50.1.552.g942d659e1b-goog


