Return-Path: <linux-kernel+bounces-779253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667EB2F0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD013BA644
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED62EFDB4;
	Thu, 21 Aug 2025 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCC0B0N+"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63842EF669
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764088; cv=none; b=BYkyBTKTRWqx+D33LHL+f/NtpdRR4YtSIYGKmCP8nLeIMCjjYgDmNDcU5LHKxEvVVpmh/o+SzaB9PMb580TtdLrzRVeKH7VqpKBL0lKjjSyL6sfjYsbD8Mjm+CqE9W1LyyeIAZt31+CXBnR3M1Ryl86MPPEWNHK5wvk8GeBsTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764088; c=relaxed/simple;
	bh=VnO5uxAZypvZ2UWGopIwLeZsUhhqxjVgw3yRWhiEeJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F6zOjPIItCQFQmyivwsg7ru0I8pkXB8C072gdTKpNBaWTLfGPcNE9iZ6P9EUnT0bLyVV5ofgbwLkAd8jXyUGrx2394S8gfRhHiYp89BLW4xORZ2xFP1UcSOOOCxthORsNEBtglsMMJiWzRizufk2LUsDjjCZqLeIC90Xc7SimZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCC0B0N+; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso3268415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764085; x=1756368885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ayTXlePj2BFNkEq+sWtJoZ55v9PCeLPmdCVhKrV+hA=;
        b=uCC0B0N+Mt0Mu75Z3umdx91aAuCWawWFmauXF/twXoLQYEVwCGUZTt07TzwHfJa/8c
         LG2Wi9DeZ5PjUkH+TS5JMZwhnvLZIyFaZAm73PqHVOGu7OOdQS9An6HhlquE9lIKCWPj
         SzGIfidUncLEQ0A5c5Kud7ndSS/brFuR3NrzEOgvMdepkL23b8eCw8EIFIa7Cv0MPFBT
         Wz5zECvvLt9GIt09nMxpDUoBauereXKxCDi/AvQi1WZdITTGG6JWCBfAnV18cUc5Qag3
         09orVBqalzX4MIF1pXgDALzdvvmnBY8nEWkN2AvbO2Xkyfb2kcow6PxBRaqB/726p691
         F8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764085; x=1756368885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ayTXlePj2BFNkEq+sWtJoZ55v9PCeLPmdCVhKrV+hA=;
        b=hjiXC7C4qRBfee4w9B3C2s8jV+E38MP7H8zOgiI7qlocvVFvIKk3hlbVs8LGxdmtJ4
         WiZyEcS5ETekYiwxxdKrUo07/AS+5tU/vAfRBfId9Hgn6NlLM9KJIRA+5IPwB/OKcQr3
         MmzbI1zhCPQUcIv8vdqWkqPtmMrOQ/1w7n3cGEn+wJStS0bSURlsHg2mkOHZTIAwouuh
         qL1SEg2YINXmr+gq32W2aqSZ9a88/v7nj66GtBVamJunvWLhU39uMPbVD1uiTnV/unl6
         0EzJB7YVRp5DaRZztHnSVW7VmffIf6nfQIAOrfW/+m4SEicRX9xc5YwlL/0wYJzn3dVg
         71+w==
X-Forwarded-Encrypted: i=1; AJvYcCWoWc+o2NOfhMMFFAu1rOiBT/WV+nP8a4zA2MoU+9/kLdzOWcoKh1OM4gLEhUTREG3RQSLM65+9K0vpZPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2sUmZi7HEv7i87VHurEjtghbkB40lIy5s2HsKuMPWmPoR+2P
	R6k6RFW+ERGgrxf4qcKL+KZWemQL2pmIczhsJVDALm17RnhS6jFDeKf10Y66Gnb6wpxniISnTWO
	ZgANS83S7CtBAtuifnwdC6Q==
X-Google-Smtp-Source: AGHT+IGJcQsJw2xCT8Ka9WpqqAMGLTb8DX8n1699YgsQ2l/bWtYk3YiUzY/UJzq9mNicwWCB9XjdYINkfgkNTmH3
X-Received: from wmqb16.prod.google.com ([2002:a05:600c:4e10:b0:459:e027:2d9b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1909:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-45b4d7cef1amr9070235e9.1.1755764085260;
 Thu, 21 Aug 2025 01:14:45 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:05 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-18-vdonnefort@google.com>
Subject: [PATCH v6 17/24] KVM: arm64: Add tracing capability for the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When running with protected mode, the host has very little knowledge
about what is happening in the hypervisor. Of course this is an
essential feature for security but nonetheless, that piece of code
growing with more responsibilities, we need now a way to debug and
profile it. Tracefs by its reliability, versatility and support for
user-space is the perfect tool.

There's no way the hypervisor could log events directly into the host
tracefs ring-buffers. So instead let's use our own, where the hypervisor
is the writer and the host the reader.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index bec227f9500a..437ac948d136 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -87,6 +87,10 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
 	__KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
 	__KVM_HOST_SMCCC_FUNC___pkvm_tlb_flush_vmid,
+	__KVM_HOST_SMCCC_FUNC___pkvm_load_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_unload_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_enable_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_hyptrace.h b/arch/arm64/include/asm/kvm_hyptrace.h
new file mode 100644
index 000000000000..9c30a479bc36
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_hyptrace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ARM64_KVM_HYPTRACE_H_
+#define __ARM64_KVM_HYPTRACE_H_
+
+#include <linux/ring_buffer.h>
+
+struct hyp_trace_desc {
+	unsigned long			bpages_backing_start;
+	size_t				bpages_backing_size;
+	struct trace_buffer_desc	trace_buffer_desc;
+
+};
+#endif
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 713248f240e0..06e948d066ac 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -82,4 +82,11 @@ config PTDUMP_STAGE2_DEBUGFS
 
 	  If in doubt, say N.
 
+config PKVM_TRACING
+	bool
+	depends on KVM
+	depends on TRACING
+	select SIMPLE_RING_BUFFER
+	default y
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
new file mode 100644
index 000000000000..996e90c0974f
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ARM64_KVM_HYP_NVHE_TRACE_H
+#define __ARM64_KVM_HYP_NVHE_TRACE_H
+#include <asm/kvm_hyptrace.h>
+
+#ifdef CONFIG_PKVM_TRACING
+void *tracing_reserve_entry(unsigned long length);
+void tracing_commit_entry(void);
+
+int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size);
+void __pkvm_unload_tracing(void);
+int __pkvm_enable_tracing(bool enable);
+int __pkvm_swap_reader_tracing(unsigned int cpu);
+#else
+static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
+static inline void tracing_commit_entry(void) { }
+
+static inline int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
+static inline void __pkvm_unload_tracing(void) { }
+static inline int __pkvm_enable_tracing(bool enable) { return -ENODEV; }
+static inline int __pkvm_swap_reader_tracing(unsigned int cpu) { return -ENODEV; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 607357e36026..e640f12808f7 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -28,7 +28,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
-hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o
+hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o trace.o ../../../../../kernel/trace/simple_ring_buffer.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 3206b2c07f82..02b2fdd9a8e4 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -18,6 +18,7 @@
 #include <nvhe/mem_protect.h>
 #include <nvhe/mm.h>
 #include <nvhe/pkvm.h>
+#include <nvhe/trace.h>
 #include <nvhe/trap_handler.h>
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
@@ -573,6 +574,35 @@ static void handle___pkvm_teardown_vm(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_teardown_vm(handle);
 }
 
+static void handle___pkvm_load_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	 DECLARE_REG(unsigned long, desc_hva, host_ctxt, 1);
+	 DECLARE_REG(size_t, desc_size, host_ctxt, 2);
+
+	 cpu_reg(host_ctxt, 1) = __pkvm_load_tracing(desc_hva, desc_size);
+}
+
+static void handle___pkvm_unload_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	__pkvm_unload_tracing();
+
+	cpu_reg(host_ctxt, 1) = 0;
+}
+
+static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(bool, enable, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_enable_tracing(enable);
+}
+
+static void handle___pkvm_swap_reader_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_swap_reader_tracing(cpu);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -612,6 +642,10 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_vcpu_load),
 	HANDLE_FUNC(__pkvm_vcpu_put),
 	HANDLE_FUNC(__pkvm_tlb_flush_vmid),
+	HANDLE_FUNC(__pkvm_load_tracing),
+	HANDLE_FUNC(__pkvm_unload_tracing),
+	HANDLE_FUNC(__pkvm_enable_tracing),
+	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
new file mode 100644
index 000000000000..f9949b243844
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <nvhe/clock.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/mm.h>
+#include <nvhe/trace.h>
+
+#include <asm/percpu.h>
+#include <asm/kvm_mmu.h>
+#include <asm/local.h>
+
+#include <linux/simple_ring_buffer.h>
+
+DEFINE_PER_CPU(struct simple_rb_per_cpu, __simple_rbs);
+
+static struct hyp_trace_buffer {
+	struct simple_rb_per_cpu		*simple_rbs;
+	unsigned long				bpages_backing_start;
+	size_t					bpages_backing_size;
+	hyp_spinlock_t				lock;
+} trace_buffer = {
+	.simple_rbs = &__simple_rbs,
+	.lock = __HYP_SPIN_LOCK_UNLOCKED,
+};
+
+static bool hyp_trace_buffer_loaded(struct hyp_trace_buffer *trace_buffer)
+{
+	return trace_buffer->bpages_backing_size > 0;
+}
+
+void *tracing_reserve_entry(unsigned long length)
+{
+	return simple_ring_buffer_reserve(this_cpu_ptr(trace_buffer.simple_rbs), length,
+					  trace_clock());
+}
+
+void tracing_commit_entry(void)
+{
+	simple_ring_buffer_commit(this_cpu_ptr(trace_buffer.simple_rbs));
+}
+
+static int hyp_trace_buffer_load_bpage_backing(struct hyp_trace_buffer *trace_buffer,
+					       struct hyp_trace_desc *desc)
+{
+	unsigned long start = kern_hyp_va(desc->bpages_backing_start);
+	size_t size = desc->bpages_backing_size;
+	int ret;
+
+	if (!PAGE_ALIGNED(start) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	ret = __pkvm_host_donate_hyp(hyp_virt_to_pfn((void *)start), size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	memset((void *)start, 0, size);
+
+	trace_buffer->bpages_backing_start = start;
+	trace_buffer->bpages_backing_size = size;
+
+	return 0;
+}
+
+static void hyp_trace_buffer_unload_bpage_backing(struct hyp_trace_buffer *trace_buffer)
+{
+	unsigned long start = trace_buffer->bpages_backing_start;
+	size_t size = trace_buffer->bpages_backing_size;
+
+	if (!size)
+		return;
+
+	memset((void *)start, 0, size);
+
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(start), size >> PAGE_SHIFT));
+
+	trace_buffer->bpages_backing_start = 0;
+	trace_buffer->bpages_backing_size = 0;
+}
+
+static void *__pin_shared_page(unsigned long kern_va)
+{
+	void *va = kern_hyp_va((void *)kern_va);
+
+	return hyp_pin_shared_mem(va, va + PAGE_SIZE) ? NULL : va;
+}
+
+static void __unpin_shared_page(void *va)
+{
+	hyp_unpin_shared_mem(va, va + PAGE_SIZE);
+}
+
+static void hyp_trace_buffer_unload(struct hyp_trace_buffer *trace_buffer)
+{
+	int cpu;
+
+	hyp_assert_lock_held(&trace_buffer->lock);
+
+	if (!hyp_trace_buffer_loaded(trace_buffer))
+		return;
+
+	for (cpu = 0; cpu < hyp_nr_cpus; cpu++)
+		__simple_ring_buffer_unload(per_cpu_ptr(trace_buffer->simple_rbs, cpu),
+					    __unpin_shared_page);
+
+	hyp_trace_buffer_unload_bpage_backing(trace_buffer);
+}
+
+static int hyp_trace_buffer_load(struct hyp_trace_buffer *trace_buffer,
+				 struct hyp_trace_desc *desc)
+{
+	struct simple_buffer_page *bpages;
+	struct ring_buffer_desc *rb_desc;
+	int ret, cpu;
+
+	hyp_assert_lock_held(&trace_buffer->lock);
+
+	if (hyp_trace_buffer_loaded(trace_buffer))
+		return -EINVAL;
+
+	ret = hyp_trace_buffer_load_bpage_backing(trace_buffer, desc);
+	if (ret)
+		return ret;
+
+	bpages = (struct simple_buffer_page *)trace_buffer->bpages_backing_start;
+	for_each_ring_buffer_desc(rb_desc, cpu, &desc->trace_buffer_desc) {
+		ret = __simple_ring_buffer_init(per_cpu_ptr(trace_buffer->simple_rbs, cpu),
+						bpages, rb_desc, __pin_shared_page,
+						__unpin_shared_page);
+		if (ret)
+			break;
+
+		bpages += rb_desc->nr_page_va;
+	}
+
+	if (ret)
+		hyp_trace_buffer_unload(trace_buffer);
+
+	return ret;
+}
+
+static bool hyp_trace_desc_validate(struct hyp_trace_desc *desc, size_t desc_size)
+{
+	struct simple_buffer_page *bpages = (struct simple_buffer_page *)desc->bpages_backing_start;
+	struct ring_buffer_desc *rb_desc;
+	void *bpages_end, *desc_end;
+	int cpu;
+
+	desc_end = (void *)desc + desc_size;
+	bpages_end = (void *)desc->bpages_backing_start + desc->bpages_backing_size;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, &desc->trace_buffer_desc) {
+		/* Can we read nr_page_va? */
+		if ((void *)(&rb_desc->nr_page_va + sizeof(rb_desc->nr_page_va)) > desc_end)
+			return false;
+
+		/* Overflow desc? */
+		if ((void *)(rb_desc->page_va + rb_desc->nr_page_va + 1) > desc_end)
+			return false;
+
+		/* Overflow bpages backing memory? */
+		if ((void *)(bpages + rb_desc->nr_page_va + 1) > bpages_end)
+			return false;
+
+		if (cpu >= hyp_nr_cpus)
+			return false;
+
+		bpages += rb_desc->nr_page_va;
+	}
+
+	return true;
+}
+
+int __pkvm_load_tracing(unsigned long desc_hva, size_t desc_size)
+{
+	struct hyp_trace_desc *desc = (struct hyp_trace_desc *)kern_hyp_va(desc_hva);
+	int ret;
+
+	if (!desc_size || !PAGE_ALIGNED(desc_hva) || !PAGE_ALIGNED(desc_size))
+		return -EINVAL;
+
+	ret = __pkvm_host_donate_hyp(hyp_virt_to_pfn((void *)desc),
+				     desc_size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	if (!hyp_trace_desc_validate(desc, desc_size))
+		goto err_donate_desc;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	ret = hyp_trace_buffer_load(&trace_buffer, desc);
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+err_donate_desc:
+	WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn((void *)desc),
+				       desc_size >> PAGE_SHIFT));
+	return ret;
+}
+
+void __pkvm_unload_tracing(void)
+{
+	hyp_spin_lock(&trace_buffer.lock);
+	hyp_trace_buffer_unload(&trace_buffer);
+	hyp_spin_unlock(&trace_buffer.lock);
+}
+
+int __pkvm_enable_tracing(bool enable)
+{
+	int cpu, ret = enable ? -EINVAL : 0;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (!hyp_trace_buffer_loaded(&trace_buffer))
+		goto unlock;
+
+	for (cpu = 0; cpu < hyp_nr_cpus; cpu++)
+		simple_ring_buffer_enable_tracing(per_cpu_ptr(trace_buffer.simple_rbs, cpu),
+						  enable);
+
+	ret = 0;
+
+unlock:
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
+
+int __pkvm_swap_reader_tracing(unsigned int cpu)
+{
+	int ret;
+
+	if (cpu >= hyp_nr_cpus)
+		return -EINVAL;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (hyp_trace_buffer_loaded(&trace_buffer))
+		ret = simple_ring_buffer_swap_reader_page(
+				per_cpu_ptr(trace_buffer.simple_rbs, cpu));
+	else
+		ret = -ENODEV;
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


