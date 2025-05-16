Return-Path: <linux-kernel+bounces-651373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BECAB9DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A5F9E6D52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22D1F8EFA;
	Fri, 16 May 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vo4Nd3Ux"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C31F4179
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402876; cv=none; b=UWFr9dacXqchkj12tJ1tQ6sR/O9rqgV/Yg8WBxa+v2NwXrunntFJfrLfDy0l/XIa0jOlLsWnyPzsYFz/1V6uTBcIo/J2h0txddGTgbp975IeCQAgVB13EcNVOdpzcBxJhGvCWfGxGHMS2n2fLT914fX28DMLgbffaiJR23VCexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402876; c=relaxed/simple;
	bh=GIq7tCpS5o60lK9Ijz4ADQdx4nU8SBoHG5/76Idfmes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oCOo5vTTk2lTaskN0SLH70XcDlbURaRQY6NLw+QpvXPXqbM/PfT3pms6IZgrSyE+u3Vt5CZ05SWtqilsoNkY5lXYrfj46GfmL9IFE2kV+mwdNILn++e0FYOzHtlO3/wONBaRpN3C80q/vdAjrW/YCV2EBUwr/eqRj7h3z5CW5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vo4Nd3Ux; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a2046b5e75so1080134f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402873; x=1748007673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUFR7mX34CGfKgUCmeQsVwEXViGiZ8lwRuzfDv0/YGY=;
        b=Vo4Nd3UxnmXg0SWmz32mPCQ4KsdGv3nkOZ0QSvYhd5mId4Fp6G5yPo+ir9ot9hSeOt
         IQzpJHNsQtCJRyWyknnsrlSWX291I+6cpO2U/voH3ZNUBlksRwPyXVOXS+Rwb6PJMwz1
         oPqOq0MtzazPvs1WTKqpgiJoxq9XxCfmmvR9qmPg3BvyDP6AQYU8/zMJ8D0mU3/uonWA
         s/vQa45g6ugqUiy+Z9m4Uv5rJXHR9KGDaeFYk/n0+TPz3w+PuHHAGm2Iyn39XyJS06x6
         1lJpqOclwirrl2MSHcsJwGJOAvpkfCLw6PbsDW0ly8EgNUPzXgezIIQybRsFahHHcuX/
         cEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402873; x=1748007673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUFR7mX34CGfKgUCmeQsVwEXViGiZ8lwRuzfDv0/YGY=;
        b=izwhhE7uNgyQvjfUvlpOt1Nh92UW5VbugexM8oJitxSTXvhwaEklKq6L2YS+vvlRM0
         5IbwP5rlCgJKEJpqtzvKUv/5cFKGqbnaMbM3/NAXNTx0YumJdXmDjXZmQeZDs1UVyhPF
         u+v62JUILyl8Zvir8p5Z14117FJEre1dDwGibLTknjVJDE93grAl6BMErgBnUKlGDwH4
         BHyyaFlaVn0GYoA10ye3YCdod6PI3s2xSLivITS+QtfwaSR8XhxXQzujBImDHVk2iunH
         fJ7k3VGsJ3Qyln/PLbtFnIE2BBOjngE/V4GddbA/5UWqFKtdfQGUoEaKzE3/q2DgtY9D
         9FIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7BikzKoffAo4n5etLLoeygIQyD+48q7c+s6JlfC+MqbPzaxwas38u0pIAIISMl99TvogFcHzvaHPNI7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyia1rQ5rQ0ovXLpxrG6kcdpUr99GBPec1/yt4G6zdl8327xBOo
	FwlnHa3HN8k8wUrOCom6KCSXMjdclRWIiFKZHHonCN/DJLaQ8OtRk0w88KSEHZlLNEfWSXx8Sch
	T3abK0SOMtZtAGBpW7sqSWw==
X-Google-Smtp-Source: AGHT+IGVC4fNdiNzu3iXYOkrkXpo832GHFE68H+xlkXG8UXT/PiO3x3xWk/shQQW7MtLSB2W1QhSu6ppGBlSn/hS
X-Received: from wmbhc21.prod.google.com ([2002:a05:600c:8715:b0:440:5d62:5112])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:598f:0:b0:3a2:1f1:c3ad with SMTP id ffacd0b85a97d-3a35fe92b09mr2272113f8f.26.1747402873067;
 Fri, 16 May 2025 06:41:13 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:27 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-22-vdonnefort@google.com>
Subject: [PATCH v5 21/25] KVM: arm64: Add trace reset to the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Let the hypervisor reset the trace buffer when triggered from the
tracefs file remotes/hypervisor/trace.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d122d79718a0..c40820a4b049 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -91,6 +91,7 @@ enum __kvm_host_smccc_func {
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
index c73229fb5e1b..65260bfd33ac 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -605,6 +605,13 @@ static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
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
@@ -655,6 +662,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_load_tracing),
 	HANDLE_FUNC(__pkvm_unload_tracing),
 	HANDLE_FUNC(__pkvm_enable_tracing),
+	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
index 32fd889315f0..b6d97237a7a0 100644
--- a/arch/arm64/kvm/hyp/nvhe/trace.c
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -230,6 +230,25 @@ int __pkvm_enable_tracing(bool enable)
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
index a6664a03f8a9..5c115c3a26a1 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -301,7 +301,7 @@ static int hyp_trace_swap_reader_page(unsigned int cpu, void *priv)
 
 static int hyp_trace_reset(unsigned int cpu, void *priv)
 {
-	return 0;
+	return kvm_call_hyp_nvhe(__pkvm_reset_tracing, cpu);
 }
 
 static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
-- 
2.49.0.1101.gccaa498523-goog


