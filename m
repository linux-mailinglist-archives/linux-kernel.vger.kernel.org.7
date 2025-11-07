Return-Path: <linux-kernel+bounces-890094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F037C3F365
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88162344C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102731987E;
	Fri,  7 Nov 2025 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34kji7Sp"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DD302CC9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508357; cv=none; b=misH113I1DNQpkBuI2cz+PwUyb72dXOs7tri3qRZ4is5FQREImXrrcnAQkXMQZU0lnRwaXydlPlnScgw/hWWxPkeUq3WDlYLiFSpjOFsjZfw/w04yz3bLaryALPdRqCGv8Tzp/ltKyneG+ckLrfK6N5BvB7rSrz7d4rKlH6VwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508357; c=relaxed/simple;
	bh=LNtLVW8oNI3U4HVa0ggAaHW8fxfh+l3SMZbnLj+XxLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EmLlWGcMXpsOK1VjavjzG7pIfe38ldPHYAKJ2rY48CFV+9n6/ykuTDTRrATcSrP9gHp2+w5V3GS1jr/nX9rGzM0evp8gAAaMwYHIcnCS+OYSXi1C84eW+PHJf/T52aXgH7g825DGojEDHBAizbmZifHm3zX3XZ/D4K2EtBP9FYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34kji7Sp; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so348018f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508350; x=1763113150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXzGf2UIzsE9vtnsTrMx+m6Cqky190jMXVJHzI/NpsI=;
        b=34kji7SpxXT2fe/N5+g3C4DIf2y+WrgqlXYY67gbzmT62j6tmb+UJBWJ1Kl0qpI3Ba
         rxGyHWhFeoVoptpc3BmrpQMuTI/qte60/II0yILQQbAl0jDrjdw7s5Mmnsrr0b9U6Rpj
         Xjlmafvsyc1n0Dhh8F0vRLe0huoRvdomR9J69t42M++e0zRNpNcNzhbA1HFYCq1xKXAz
         z9QWHRe7Ku3X8u5N4mbETDRAdpjSXLcOtzgjAF3jpinxzEP5AryOFR5CWPSMvxVEX0UN
         s1pYG4rpg00v90UJgSU97qZHbjROn8CXVrH4pjbN+o2y8krzmBAZPJco+QdxP+0itegs
         A54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508350; x=1763113150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXzGf2UIzsE9vtnsTrMx+m6Cqky190jMXVJHzI/NpsI=;
        b=YWWeU8FvLSW4ksLsgqTusohZjsihFq9DFv9UiLSmzNnmVdNvQ9whyMK27c8or3dnJ8
         nfrUzgFd3dPRpgE+DxnD59hXchr2cVr1rQhc4JN+PDrRKYDfxnWJ8+lSTKMz9s01xsTQ
         X/kLEV81nI8O3TL6fNMCkMr1ejmsVJu6qRQ4GVrWkvXApZqcIBq2CRxVspYXPILRK5Fk
         OQTEHdfIIy1wIGAXhXFjeqVbF6pNql5VRZEjK3b71QrM2qy3y5Wh2Wo3GPlYd9HazThf
         gWxYm6wxWxaWN0UKW81G2sdQboSqNG/5p2Ya1kprs3YnpjAGxu6uz6LdkXcoGxr9jhzW
         2XPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb8gUSa1IQ1Im5h1Cg7nVeRR1/jExjJMqmQkdNlVQjvGD8ZIStHIvvXPVtJE0d5tyH77h/t0/Ky1RBlD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCtMAO8s403fWkjvCoosBQCpaq8Q0oBqAOcci5YvN1HWnntde
	96AbQGpDdAhGuGjmjJimLWoHg58TQ5M9/lrC0t6k1Wr2Wdfm8mrnO7k3T3dtTKawhN81/S5R2Ba
	dlvKF8L/TpkzdXMUP/ArMfA==
X-Google-Smtp-Source: AGHT+IHkRp/N9BfpTVKwGlWfyc4Y1rtqqdCtN6rhng36wKjtc+HvLOewKvEx2dD8PFbJvsAmqePp4tbQ3CaaD1np
X-Received: from wrui2.prod.google.com ([2002:a5d:6302:0:b0:429:de3f:8287])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1869:b0:429:c93b:7f6b with SMTP id ffacd0b85a97d-42ae5ae8b68mr2108050f8f.53.1762508350492;
 Fri, 07 Nov 2025 01:39:10 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:36 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-25-vdonnefort@google.com>
Subject: [PATCH v8 24/28] KVM: arm64: Add trace reset to the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Let the hypervisor reset the trace buffer when triggered from the
tracefs file remotes/hypervisor/trace.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index b6e016584de7..4faabf398881 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -93,6 +93,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_load_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_unload_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_enable_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_reset_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 };
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index 4e11dcdf049b..0d2732f0d406 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -11,6 +11,7 @@ void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cy
 int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size);
 void __pkvm_unload_tracing(void);
 int __pkvm_enable_tracing(bool enable);
+int __pkvm_reset_tracing(unsigned int cpu);
 int __pkvm_swap_reader_tracing(unsigned int cpu);
 #else
 static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
@@ -21,6 +22,7 @@ void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cy
 static inline int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
 static inline void __pkvm_unload_tracing(void) { }
 static inline int __pkvm_enable_tracing(bool enable) { return -ENODEV; }
+static inline int __pkvm_reset_tracing(unsigned int cpu) { return -ENODEV; }
 static inline int __pkvm_swap_reader_tracing(unsigned int cpu) { return -ENODEV; }
 #endif
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index d13ab9baceb6..8adad701fc76 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -620,6 +620,13 @@ static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_enable_tracing(enable);
 }
 
+static void handle___pkvm_reset_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_reset_tracing(cpu);
+}
+
 static void handle___pkvm_swap_reader_tracing(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
@@ -672,6 +679,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_load_tracing),
 	HANDLE_FUNC(__pkvm_unload_tracing),
 	HANDLE_FUNC(__pkvm_enable_tracing),
+	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
index d146ac3046de..1fd9b32950fe 100644
--- a/arch/arm64/kvm/hyp/nvhe/trace.c
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -236,6 +236,25 @@ int __pkvm_enable_tracing(bool enable)
 	return ret;
 }
 
+int __pkvm_reset_tracing(unsigned int cpu)
+{
+	int ret = 0;
+
+	if (cpu >= hyp_nr_cpus)
+		return -EINVAL;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (hyp_trace_buffer_loaded(&trace_buffer))
+		ret = simple_ring_buffer_reset(per_cpu_ptr(trace_buffer.simple_rbs, cpu));
+	else
+		ret = -ENODEV;
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
+
 int __pkvm_swap_reader_tracing(unsigned int cpu)
 {
 	int ret;
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 4f154ec743f3..1062b4310f8c 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -302,7 +302,7 @@ static int hyp_trace_swap_reader_page(unsigned int cpu, void *priv)
 
 static int hyp_trace_reset(unsigned int cpu, void *priv)
 {
-	return 0;
+	return kvm_call_hyp_nvhe(__pkvm_reset_tracing, cpu);
 }
 
 static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
-- 
2.51.2.1041.gc1ab5b90ca-goog


