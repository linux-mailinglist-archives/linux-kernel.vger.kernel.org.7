Return-Path: <linux-kernel+bounces-890093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E6C3F37A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B1C54EF337
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E8320CBF;
	Fri,  7 Nov 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElGA8Acd"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCE31CA4C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508354; cv=none; b=r3UiPY3mGJlOzZMP3Eu4p+Bxq6yHtXwoDLQWj5q9e1YjbGUWDdbnTiBaij/7L+wYzO5YO9RMUOpxY9Nx9H0zjA70ZVrzQi/WXYDk4Uaj4EWNAZ5JZ867BOBrbKetzBBf+WzPxzxE3oZC0X80Fr8svLKol6jwRv0Qj+EJX+nMOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508354; c=relaxed/simple;
	bh=TUtq5MRQWp6KHUNmPFYZAHkYh/kRdTPm11n0BWNHclo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dseOnm0GO4gAl4fnMFZa4vonaXhTjbaZZZt107PgANRwsGsk0yp0ROinx/A2yHcatBMq4TuK72PD7WgrgD37IK/X8a8bSR+7nprT+igAU2yFqEHX4jpGSE570/+xp1OukrY7qOiZSwHGAurN5YxZx6gIbah/PgaeHntTHjNgvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ElGA8Acd; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4773e108333so3069915e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508349; x=1763113149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AHYu5iV1UBLq1lUvVvEKJjPVUdacmxEDeRrDxC7Nt0=;
        b=ElGA8AcdgoM5HZW4B3lbaEV9P/JWINoF/fxt4IWjt3y5BVb/7OCIDORtDq4MjsNM4a
         JZ2NvLH/RwQjh80E1scSXfwM8SYQbfffFlVBgI8Hpunl6tHoSPOXv+rj/vUW8soyj7wT
         BhHasxHz8QP4PFgd/Jnmf678EJQMGNrIIZaeB/EYDWbRkYmMVGTiMWqX0IyQ47vW+i9c
         r+LsP2/BvNKPZqVyYXFPwhGr7ZoVemC5pplrTs76iF5bzSEUKsw/T0KMAg6NknFxXn/R
         cdLw+/mg+ux4yC2/thW0X9N7TN2xZHrIZvkLUejkh6dHqqLTWRORzH82xxKaaOjEjyT3
         5LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508349; x=1763113149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AHYu5iV1UBLq1lUvVvEKJjPVUdacmxEDeRrDxC7Nt0=;
        b=oGSxOTfnZN8qj73W1narn11u4hhypLSQEXbVjcYjuteYNYYay4/mDgfE3EyHYVv1Hl
         Ym8nDA17PcguZyvF7MWJ/GqQ//VSA72lch2anlpPnmmFJcoRoRIEVcUsEVjZyuw6cYHq
         jd5FrY+ztacGIYczlS2+W2vHphAffN+t+z2cBCD3gj7Zc9zZga2b30OzhDwh6MgJFY5N
         4+2c1RgI9ww1MQNYGeirThwoGAN/3YUXRNmnaa5eOuh9geYTvfTFIRvSEML9wGJa0v4I
         0dC88PIZ2j5VyjLk4Lv4IJbo1KPUrZ9FUDjG8exAE3Zm5TpuuUAXK/L+TD/6FX4dxgN8
         huow==
X-Forwarded-Encrypted: i=1; AJvYcCUz1avIeqi/u7Sg3X5JiE/gMnJfAcweArGRo66JqLUt16FboTwgCypFH7Ge3wqxe9gG6TZu8TzG/f/+2e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/9/k8IPC/3a7gpOy3QrbhR+0moZYYuGsYk/Ec9j+lJSGpzET
	VTcKOnQOi0rUlSn31IlV1pZqKA2v7MqVmNWQzxqRBv3VwVsvla1adu4kQag4yYutgy+dWWu7bDf
	1+P8l36f5AjRX+x2u/KibOw==
X-Google-Smtp-Source: AGHT+IE8QU7z5tGW2bc+89FWOnzez/fIQKL70Q+vhmD8B9VddAqjxcSvP0ZkMm8OumCXtYClUGQXvIN7KvBjAJGp
X-Received: from wmbgz3.prod.google.com ([2002:a05:600c:8883:b0:477:3fdf:4c24])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1396:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-4776bcb20bdmr21803125e9.4.1762508348903;
 Fri, 07 Nov 2025 01:39:08 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:34 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-23-vdonnefort@google.com>
Subject: [PATCH v8 22/28] KVM: arm64: Add trace remote for the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When running with KVM protected mode, the hypervisor is able to generate
events into tracefs compatible ring-buffers. Create a trace remote so
the kernel can read those buffers.

This currently doesn't provide any event support which will come later.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 580426cdbe77..64db254f0448 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -87,6 +87,7 @@ config PKVM_TRACING
 	bool
 	depends on KVM
 	depends on TRACING
+	select TRACE_REMOTE
 	select SIMPLE_RING_BUFFER
 	default y
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 3ebc0570345c..2c184e3abd8e 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -30,6 +30,8 @@ kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
 kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
+kvm-$(CONFIG_PKVM_TRACING) += hyp_trace.o
+
 always-y := hyp_constants.h hyp-constants.s
 
 define rule_gen_hyp_constants
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 870953b4a8a7..c485e54417e2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -24,6 +24,7 @@
 
 #define CREATE_TRACE_POINTS
 #include "trace_arm.h"
+#include "hyp_trace.h"
 
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
@@ -2345,6 +2346,9 @@ static int __init init_subsystems(void)
 
 	kvm_register_perf_callbacks(NULL);
 
+	err = hyp_trace_init();
+	if (err)
+		kvm_err("Failed to initialize Hyp tracing\n");
 out:
 	if (err)
 		hyp_cpu_pm_exit();
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
new file mode 100644
index 000000000000..98051c3fb0c2
--- /dev/null
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <linux/trace_remote.h>
+#include <linux/simple_ring_buffer.h>
+
+#include <asm/kvm_host.h>
+#include <asm/kvm_hyptrace.h>
+
+#include "hyp_trace.h"
+
+/* Access to this struct within the trace_remote_callbacks are protected by the trace_remote lock */
+static struct hyp_trace_buffer {
+	struct hyp_trace_desc	*desc;
+	size_t			desc_size;
+} trace_buffer;
+
+static int hyp_trace_buffer_alloc_bpages_backing(struct hyp_trace_buffer *trace_buffer, size_t size)
+{
+	int nr_bpages = (PAGE_ALIGN(size) / PAGE_SIZE) + 1;
+	size_t backing_size;
+	void *start;
+
+	backing_size = PAGE_ALIGN(sizeof(struct simple_buffer_page) * nr_bpages *
+				  num_possible_cpus());
+
+	start = alloc_pages_exact(backing_size, GFP_KERNEL_ACCOUNT);
+	if (!start)
+		return -ENOMEM;
+
+	trace_buffer->desc->bpages_backing_start = (unsigned long)start;
+	trace_buffer->desc->bpages_backing_size = backing_size;
+
+	return 0;
+}
+
+static void hyp_trace_buffer_free_bpages_backing(struct hyp_trace_buffer *trace_buffer)
+{
+	free_pages_exact((void *)trace_buffer->desc->bpages_backing_start,
+			 trace_buffer->desc->bpages_backing_size);
+}
+
+static int __load_page(unsigned long va)
+{
+	return kvm_call_hyp_nvhe(__pkvm_host_share_hyp, virt_to_pfn((void *)va), 1);
+}
+
+static void __unload_page(unsigned long va)
+{
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp, virt_to_pfn((void *)va), 1));
+}
+
+static void hyp_trace_buffer_unload_pages(struct hyp_trace_buffer *trace_buffer, int last_cpu)
+{
+	struct ring_buffer_desc *rb_desc;
+	int cpu, p;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, &trace_buffer->desc->trace_buffer_desc) {
+		if (cpu > last_cpu)
+			break;
+
+		__unload_page(rb_desc->meta_va);
+		for (p = 0; p < rb_desc->nr_page_va; p++)
+			__unload_page(rb_desc->page_va[p]);
+	}
+}
+
+static int hyp_trace_buffer_load_pages(struct hyp_trace_buffer *trace_buffer)
+{
+	struct ring_buffer_desc *rb_desc;
+	int cpu, p, ret = 0;
+
+	for_each_ring_buffer_desc(rb_desc, cpu, &trace_buffer->desc->trace_buffer_desc) {
+		ret = __load_page(rb_desc->meta_va);
+		if (ret)
+			break;
+
+		for (p = 0; p < rb_desc->nr_page_va; p++) {
+			ret = __load_page(rb_desc->page_va[p]);
+			if (ret)
+				break;
+		}
+
+		if (ret) {
+			for (p--; p >= 0; p--)
+				__unload_page(rb_desc->page_va[p]);
+			break;
+		}
+	}
+
+	if (ret)
+		hyp_trace_buffer_unload_pages(trace_buffer, cpu--);
+
+	return ret;
+}
+
+static struct trace_buffer_desc *hyp_trace_load(unsigned long size, void *priv)
+{
+	struct hyp_trace_buffer *trace_buffer = priv;
+	struct hyp_trace_desc *desc;
+	size_t desc_size;
+	int ret;
+
+	if (WARN_ON(trace_buffer->desc))
+		return ERR_PTR(-EINVAL);
+
+	desc_size = trace_buffer_desc_size(size, num_possible_cpus());
+	if (desc_size == SIZE_MAX)
+		return ERR_PTR(-E2BIG);
+
+	/*
+	 * The hypervisor will unmap the descriptor from the host to protect the reading. Page
+	 * granularity for the allocation ensures no other useful data will be unmapped.
+	 */
+	desc_size = PAGE_ALIGN(desc_size);
+	desc = (struct hyp_trace_desc *)alloc_pages_exact(desc_size, GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	trace_buffer->desc = desc;
+
+	ret = hyp_trace_buffer_alloc_bpages_backing(trace_buffer, size);
+	if (ret)
+		goto err_free_desc;
+
+	ret = trace_remote_alloc_buffer(&desc->trace_buffer_desc, desc_size, size,
+					cpu_possible_mask);
+	if (ret)
+		goto err_free_backing;
+
+	ret = hyp_trace_buffer_load_pages(trace_buffer);
+	if (ret)
+		goto err_free_buffer;
+
+	ret = kvm_call_hyp_nvhe(__pkvm_load_tracing, (unsigned long)desc, desc_size);
+	if (ret)
+		goto err_unload_pages;
+
+	return &desc->trace_buffer_desc;
+
+err_unload_pages:
+	hyp_trace_buffer_unload_pages(trace_buffer, INT_MAX);
+
+err_free_buffer:
+	trace_remote_free_buffer(&desc->trace_buffer_desc);
+
+err_free_backing:
+	hyp_trace_buffer_free_bpages_backing(trace_buffer);
+
+err_free_desc:
+	free_pages_exact(desc, desc_size);
+	trace_buffer->desc = NULL;
+
+	return ERR_PTR(ret);
+}
+
+static void hyp_trace_unload(struct trace_buffer_desc *desc, void *priv)
+{
+	struct hyp_trace_buffer *trace_buffer = priv;
+
+	if (WARN_ON(desc != &trace_buffer->desc->trace_buffer_desc))
+		return;
+
+	kvm_call_hyp_nvhe(__pkvm_unload_tracing);
+	hyp_trace_buffer_unload_pages(trace_buffer, INT_MAX);
+	trace_remote_free_buffer(desc);
+	hyp_trace_buffer_free_bpages_backing(trace_buffer);
+	free_pages_exact(trace_buffer->desc, trace_buffer->desc_size);
+	trace_buffer->desc = NULL;
+}
+
+static int hyp_trace_enable_tracing(bool enable, void *priv)
+{
+	return kvm_call_hyp_nvhe(__pkvm_enable_tracing, enable);
+}
+
+static int hyp_trace_swap_reader_page(unsigned int cpu, void *priv)
+{
+	return kvm_call_hyp_nvhe(__pkvm_swap_reader_tracing, cpu);
+}
+
+static int hyp_trace_reset(unsigned int cpu, void *priv)
+{
+	return 0;
+}
+
+static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
+{
+	return 0;
+}
+
+static struct trace_remote_callbacks trace_remote_callbacks = {
+	.load_trace_buffer	= hyp_trace_load,
+	.unload_trace_buffer	= hyp_trace_unload,
+	.enable_tracing		= hyp_trace_enable_tracing,
+	.swap_reader_page	= hyp_trace_swap_reader_page,
+	.reset			= hyp_trace_reset,
+	.enable_event		= hyp_trace_enable_event,
+};
+
+int hyp_trace_init(void)
+{
+	if (!is_protected_kvm_enabled())
+		return 0;
+
+	return trace_remote_register("hypervisor", &trace_remote_callbacks, &trace_buffer, NULL, 0);
+}
diff --git a/arch/arm64/kvm/hyp_trace.h b/arch/arm64/kvm/hyp_trace.h
new file mode 100644
index 000000000000..54d8b1f44ca5
--- /dev/null
+++ b/arch/arm64/kvm/hyp_trace.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ARM64_KVM_HYP_TRACE_H__
+#define __ARM64_KVM_HYP_TRACE_H__
+
+#ifdef CONFIG_PKVM_TRACING
+int hyp_trace_init(void);
+#else
+static inline int hyp_trace_init(void) { return 0; }
+#endif
+#endif
-- 
2.51.2.1041.gc1ab5b90ca-goog


