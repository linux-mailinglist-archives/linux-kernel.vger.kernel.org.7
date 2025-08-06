Return-Path: <linux-kernel+bounces-758415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B98B1CEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADAA18C60F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22602367B6;
	Wed,  6 Aug 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0aHYCH/"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E6233159
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517106; cv=none; b=tNwfOQar+IhPAAT9O7S2MgZ4lzFSY3S8mywpazO88US4gUaHfmnZ4kH8N2yP9SvPRSgaDMn/MRdR5szFM8mPGBG86U3eXEyUxt4TBNmiV+7l6yk45R049XigGgwe5UQ0cNRJjRi7r/R+PEdi8+4MqVzi3CH2GmMMs8EFhZYoRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517106; c=relaxed/simple;
	bh=yyees47b5Isv/3rZQG/XEbg1ZsYR4Mzo0AQdNn11z8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMxDKXkbhy2PdL0/697zn5yvIxsJZThkYXwKmpCd16yAQFJBP5CvoEhUpifq418YQBpjUy8rwz/01EqEzgYv/Oow6SipEeVSL81ozZ7Q8/iHCfc+CTzbIEzbuXJiNqu2Ftkr9ESihXne7zl+dYwrcYFKaAOGipiM3WgdRDao7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z0aHYCH/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bf30ca667so695156b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517103; x=1755121903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvkhCJnWn8b47NYS3pchpnLLXiQyronVfEBCIKIImdI=;
        b=z0aHYCH/VJbw8xH1r2GTw1an7n4raA/uyiLQdmF9mtj/++xjbHcGHlpNR1Or91GTfI
         e82vrSdJbBLaQNkSAm7A59Pmd9HdTf/ZM/66uUnB9tI2kEbREE2HWuFsIbN6nCx3AVS5
         Y/etbsOrFiJEduy8z7HGXBxwVTK2ge8DnN8eoBDyZYw8m8QdH0tegFhfTT5l8WCEL6/e
         bBajLX7kGAeaJJY3z2ZY7xaG1ialZT/YNb3ERAE3wyfL0yHq9bkZIuB6oOD7UdZHBUNZ
         dWhcysvzpmlQzeb7yyLIbKgalfpQRs1e1UyjpaMv/4mKHHZpRCNvOlQGMaYcvwYIYN2L
         ePCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517103; x=1755121903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvkhCJnWn8b47NYS3pchpnLLXiQyronVfEBCIKIImdI=;
        b=dUaMJl9MdnwhPIzTjeWUERkCecYJ9webBuFzmnw6L57aPI6sDQuo0VJMI13WLRMJzv
         KXJgTv7E8gyART9u1BXjZ9B1RhkWpNSTitiDrbaLpqM1E194OrCPnlLPoGKtpKhLrWmF
         aYBxVV7eYSxv0xTcrAPwogqkVnqcR7n/4ZoDlhk+xpLmjMm4Rx+zFP09GNc5dveLbXJc
         kLeadCOEjcZZa1Ca3bbXXnlD+tR6rKB8+TrZ9iVZ5mYg+GEie3xHmrfBKx07Le7A6m6s
         yyWlfiGz67rCkiyXUr8uOh1VlbLUb28ZeXV0GZkdBFxT45GEBrWlTFbYEpmr+WhtQkl+
         rtqg==
X-Forwarded-Encrypted: i=1; AJvYcCWaVtypDcj/SHCZyobdtwLNJ1B6Xy721tKP+RoR+dAaWVDDZc5OV1SYVDv9KMV0azalB5Alyuxa5u8zA5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWew4KxVKSBOJs572tCHutnWoBH4wBM7ww/q3k64U4qf59HFkt
	t+3YIQqpsTdhjCZJpwmWu+LUQCs3TNgE3EKiOctG76MgSSmmVLb17hSbk7Czw+RSgVrYXW6qHCc
	NkYN8/0cmreYG5Jn1peYmGw==
X-Google-Smtp-Source: AGHT+IH+1wuFbTzc9gZGjIHHoansxh5SQ7db4RG6GuHp4nNzo4lGFKn6q4QjO4vK67XOwtGj7Nbmb9RHQpuSHRVL
X-Received: from pfet7.prod.google.com ([2002:aa7:9387:0:b0:746:21fd:3f7a])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:13aa:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-76c2a514f3cmr5473588b3a.12.1754517102849;
 Wed, 06 Aug 2025 14:51:42 -0700 (PDT)
Date: Wed,  6 Aug 2025 21:51:31 +0000
In-Reply-To: <20250806215133.43475-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806215133.43475-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250806215133.43475-2-jthoughton@google.com>
Subject: [PATCH 1/2] KVM: Add fault injection for some MMU operations
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Provide fault injection hooks for three operations:
1. For all architectures, retries due to invalidation notifiers.
2. For x86, TDP MMU cmpxchg updates for SPTEs.
3. For x86, TDP MMU SPTE iteration rescheduling.

For all of these, fault injection can induce the uncommon cases: (1)
that an invalidation occurred, (2) a cmpxchg failed, and (3) that the
MMU lock is contended.

All of the debugfs directories for each of these injection points will
show up under the KVM debugfs directory (usually /sys/kernel/debug/kvm)
with the following names:
1. fail_kvm_mmu_invalidate_retry
2. fail_tdp_mmu_cmpxchg
3. fail_tdp_mmu_resched

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/kvm/Makefile              |  1 +
 arch/x86/kvm/debugfs.c             |  6 +++++
 arch/x86/kvm/mmu/fault_injection.c | 36 ++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/fault_injection.h | 31 +++++++++++++++++++++++++
 arch/x86/kvm/mmu/mmu.c             |  1 +
 arch/x86/kvm/mmu/tdp_mmu.c         | 10 ++++++---
 include/linux/kvm_host.h           | 19 +++++++++++++---
 lib/Kconfig.debug                  |  8 +++++++
 virt/kvm/kvm_main.c                | 25 +++++++++++++++++++++
 9 files changed, 131 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/kvm/mmu/fault_injection.c
 create mode 100644 arch/x86/kvm/mmu/fault_injection.h

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index c4b8950c7abee..8d2a16fd396b3 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -10,6 +10,7 @@ kvm-y			+= x86.o emulate.o irq.o lapic.o cpuid.o pmu.o mtrr.o \
 
 kvm-$(CONFIG_X86_64) += mmu/tdp_iter.o mmu/tdp_mmu.o
 kvm-$(CONFIG_KVM_IOAPIC) += i8259.o i8254.o ioapic.o
+kvm-$(CONFIG_KVM_FAULT_INJECTION) += mmu/fault_injection.o
 kvm-$(CONFIG_KVM_HYPERV) += hyperv.o
 kvm-$(CONFIG_KVM_XEN)	+= xen.o
 kvm-$(CONFIG_KVM_SMM)	+= smm.o
diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 999227fc7c665..e901581a0901c 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include "lapic.h"
 #include "mmu.h"
+#include "mmu/fault_injection.h"
 #include "mmu/mmu_internal.h"
 
 static int vcpu_get_timer_advance_ns(void *data, u64 *val)
@@ -194,3 +195,8 @@ void kvm_arch_create_vm_debugfs(struct kvm *kvm)
 	debugfs_create_file("mmu_rmaps_stat", 0644, kvm->debugfs_dentry, kvm,
 			    &mmu_rmaps_stat_fops);
 }
+
+void kvm_arch_create_debugfs(struct dentry *dentry)
+{
+	kvm_mmu_fault_injection_init(dentry);
+}
diff --git a/arch/x86/kvm/mmu/fault_injection.c b/arch/x86/kvm/mmu/fault_injection.c
new file mode 100644
index 0000000000000..25155ecd70a3b
--- /dev/null
+++ b/arch/x86/kvm/mmu/fault_injection.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include "fault_injection.h"
+
+#include <linux/dcache.h>
+#include <linux/debugfs.h>
+#include <linux/error-injection.h>
+#include <linux/fault-inject.h>
+#include <linux/init.h>
+#include <linux/kvm_host.h>
+
+static DECLARE_FAULT_ATTR(fail_tdp_mmu_cmpxchg);
+static DECLARE_FAULT_ATTR(fail_tdp_mmu_resched);
+
+bool tdp_mmu_cmpxchg_should_fail(void)
+{
+	return should_fail(&fail_tdp_mmu_cmpxchg, 1);
+}
+ALLOW_ERROR_INJECTION(tdp_mmu_cmpxchg_should_fail, TRUE);
+
+bool tdp_mmu_should_inject_resched(void)
+{
+	return should_fail(&fail_tdp_mmu_resched, 1);
+}
+ALLOW_ERROR_INJECTION(tdp_mmu_should_inject_resched, TRUE);
+
+void kvm_mmu_fault_injection_init(struct dentry *dentry)
+{
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	fault_create_debugfs_attr("fail_tdp_mmu_cmpxchg", dentry,
+				  &fail_tdp_mmu_cmpxchg);
+	fault_create_debugfs_attr("fail_tdp_mmu_resched", dentry,
+				  &fail_tdp_mmu_resched);
+#endif
+}
diff --git a/arch/x86/kvm/mmu/fault_injection.h b/arch/x86/kvm/mmu/fault_injection.h
new file mode 100644
index 0000000000000..e8d21491d12e8
--- /dev/null
+++ b/arch/x86/kvm/mmu/fault_injection.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __KVM_X86_MMU_FAULT_INJECTION_H
+#define __KVM_X86_MMU_FAULT_INJECTION_H
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/dcache.h>
+
+#ifdef CONFIG_KVM_FAULT_INJECTION
+
+void kvm_mmu_fault_injection_init(struct dentry *dentry);
+bool tdp_mmu_cmpxchg_should_fail(void);
+bool tdp_mmu_should_inject_resched(void);
+
+#else
+
+static inline void kvm_mmu_fault_injection_init(struct dentry *dentry)
+{
+}
+static inline bool tdp_mmu_cmpxchg_should_fail(void)
+{
+	return false;
+}
+static inline bool tdp_mmu_should_inject_resched(void)
+{
+	return false;
+}
+
+#endif /* CONFIG_FAULT_INJECTION_KVM */
+
+#endif /* __KVM_X86_MMU_FAULT_INJECTION_H */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e12..2739b8bddeb9f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -28,6 +28,7 @@
 #include "page_track.h"
 #include "cpuid.h"
 #include "spte.h"
+#include "fault_injection.h"
 
 #include <linux/kvm_host.h>
 #include <linux/types.h>
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1f..5ff63fe21dace 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include "fault_injection.h"
 #include "mmu.h"
 #include "mmu_internal.h"
 #include "mmutrace.h"
@@ -530,7 +531,8 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
 	 * page table has been modified. Use FROZEN_SPTE similar to
 	 * the zapping case.
 	 */
-	if (!try_cmpxchg64(rcu_dereference(sptep), &old_spte, FROZEN_SPTE))
+	if (tdp_mmu_cmpxchg_should_fail() ||
+	    !try_cmpxchg64(rcu_dereference(sptep), &old_spte, FROZEN_SPTE))
 		return -EBUSY;
 
 	/*
@@ -689,7 +691,8 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 		 * operates on fresh data, e.g. if it retries
 		 * tdp_mmu_set_spte_atomic()
 		 */
-		if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
+		if (tdp_mmu_cmpxchg_should_fail() ||
+		    !try_cmpxchg64(sptep, &iter->old_spte, new_spte))
 			return -EBUSY;
 	}
 
@@ -796,7 +799,8 @@ static inline void tdp_mmu_iter_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 static inline bool __must_check tdp_mmu_iter_need_resched(struct kvm *kvm,
 							  struct tdp_iter *iter)
 {
-	if (!need_resched() && !rwlock_needbreak(&kvm->mmu_lock))
+	if (!need_resched() && !rwlock_needbreak(&kvm->mmu_lock) &&
+	    !tdp_mmu_should_inject_resched())
 		return false;
 
 	/* Ensure forward progress has been made before yielding. */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 15656b7fba6c7..28be52f1f6a61 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1629,6 +1629,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_preempted_in_kernel(struct kvm_vcpu *vcpu);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 void kvm_arch_create_vm_debugfs(struct kvm *kvm);
+void kvm_arch_create_debugfs(struct dentry *dentry);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
@@ -2084,6 +2085,15 @@ extern const struct _kvm_stats_desc kvm_vm_stats_desc[];
 extern const struct kvm_stats_header kvm_vcpu_stats_header;
 extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
 
+#ifdef CONFIG_KVM_FAULT_INJECTION
+bool kvm_mmu_invalidate_retry_should_fail(void);
+#else
+static inline bool kvm_mmu_invalidate_retry_should_fail(void)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
 static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 {
@@ -2102,7 +2112,8 @@ static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
 	 * kvm->mmu_lock to keep things ordered.
 	 */
 	smp_rmb();
-	if (kvm->mmu_invalidate_seq != mmu_seq)
+	if (kvm->mmu_invalidate_seq != mmu_seq ||
+	    kvm_mmu_invalidate_retry_should_fail())
 		return 1;
 	return 0;
 }
@@ -2132,7 +2143,8 @@ static inline int mmu_invalidate_retry_gfn(struct kvm *kvm,
 			return 1;
 	}
 
-	if (kvm->mmu_invalidate_seq != mmu_seq)
+	if (kvm->mmu_invalidate_seq != mmu_seq ||
+	    kvm_mmu_invalidate_retry_should_fail())
 		return 1;
 	return 0;
 }
@@ -2160,7 +2172,8 @@ static inline bool mmu_invalidate_retry_gfn_unsafe(struct kvm *kvm,
 	    gfn < kvm->mmu_invalidate_range_end)
 		return true;
 
-	return READ_ONCE(kvm->mmu_invalidate_seq) != mmu_seq;
+	return READ_ONCE(kvm->mmu_invalidate_seq) != mmu_seq ||
+	       kvm_mmu_invalidate_retry_should_fail();
 }
 #endif
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed075e..3e029ce6497aa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2126,6 +2126,14 @@ config FAIL_SKB_REALLOC
 	  For more information, check
 	  Documentation/fault-injection/fault-injection.rst
 
+config KVM_FAULT_INJECTION
+	bool "Fault-injection capability for KVM"
+	depends on FAULT_INJECTION_DEBUG_FS && KVM_COMMON
+	help
+	  Provide fault-injection capability for KVM.
+	  This will cause rare MMU operations to occur more frequently (e.g.
+	  SPTE cmpxchg failure).
+
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
 	depends on FAULT_INJECTION
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6c07dd423458c..c371ec3eeed1c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -49,6 +49,7 @@
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
 #include <linux/suspend.h>
+#include <linux/fault-inject.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -1103,6 +1104,14 @@ void __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
 {
 }
 
+/*
+ * Called after kvm->debugfs_dentry is created to create KVM-global
+ * arch-specific debugfs entries. dentry might not be valid.
+ */
+void __weak kvm_arch_create_debugfs(struct dentry *dentry)
+{
+}
+
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 {
 	struct kvm *kvm = kvm_arch_alloc_vm();
@@ -6301,6 +6310,16 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	kfree(env);
 }
 
+static DECLARE_FAULT_ATTR(fail_kvm_mmu_invalidate_retry);
+
+#ifdef CONFIG_KVM_FAULT_INJECTION
+bool kvm_mmu_invalidate_retry_should_fail(void)
+{
+	return should_fail(&fail_kvm_mmu_invalidate_retry, 1);
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_invalidate_retry_should_fail);
+#endif
+
 static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
@@ -6330,6 +6349,12 @@ static void kvm_init_debug(void)
 				kvm_debugfs_dir,
 				(void *)(long)pdesc->desc.offset, fops);
 	}
+
+	fault_create_debugfs_attr("fail_kvm_mmu_invalidate_retry",
+				  kvm_debugfs_dir,
+				  &fail_kvm_mmu_invalidate_retry);
+
+	kvm_arch_create_debugfs(kvm_debugfs_dir);
 }
 
 static inline
-- 
2.50.1.703.g449372360f-goog


