Return-Path: <linux-kernel+bounces-841347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2DBB70EA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE521AE21B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9820C477;
	Fri,  3 Oct 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCZtq87f"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D09275860
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498766; cv=none; b=XJV0eieHdoKUi9Hz+Fh7zJl0wklgtxWPcesMPVLU4qbB+7HiPXkyDW1buzExKQ01FQELXPI+Cz7JKoQDwxXDcy8LsA3xByPPpi3P7yLtyUHOh2kablVNdvf8i1aoU9SJd5u8XMjEe232hyQpYStnl3WA9fcish+1evPoUinNdsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498766; c=relaxed/simple;
	bh=YYPtZx7KhRfp3aC5CCHm1JhakHuUybZFtGRIGxxWxOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWSp8QZiLRKhAAw+Xgf91K2VvzoD44JpuCejBS6tPKooEgkfV9h1+74XM8e3tDRdtfHg7Sl8sVdecVOajw1XUpbC+O7ewAAD2zKKzMoPcllNCXc+7NpOFOh/FGRcHIORQcnDI3Bb3FhmFI0L4Id3Dws7Xo7byd0OLhm4/ZxH6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCZtq87f; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so17181525e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498759; x=1760103559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKoVOt7SfjBg9tHla8UyfyracQ+ttFmAkYCdQchY/Cw=;
        b=lCZtq87fp7XIeA07taExq7f6LF2XAmOYipitqXFlZcKUle5n1oflrXgmbuUHd/fRi0
         THf739/V1IEuKLAoBhXzDeKXRIenqw2DJm/WeirljNZySWrofzMoRms+gCebqYEvFkfU
         1kbsOR2fGeohZc9cbZCnO/ryEwcpFgys7VunPaq0jnr/DFwANRmZV1Ie61NTE0r/ghgP
         tgZ+3TQHC489eMFFNqFNAkPmsf0vDU6Cdv3MVOqSfs8ARzTBTF7RBS5kFKCFcm1dzD5Y
         kjBP5NvBvOR4IM3Bhg5FiPXGdzaQB3YLzNEB6EI4mSLLYfCUtASbTW84jbjZpUuEjaKW
         2/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498759; x=1760103559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKoVOt7SfjBg9tHla8UyfyracQ+ttFmAkYCdQchY/Cw=;
        b=AtXdjWCzHnpUbDcV1bhtEZXpRMQ7535W+isTzjqFE+momXVQVodb7KSX+/T4OLjHLQ
         Z1u9u7glmV3ywHEuL1HIjIKk93bkQJ2lIDBJTR7m131vqhEvmKZCYKTXyI5Drr9kuQGO
         UT8KLnM/5RetXXDBhwRH3xZTt58vhjOdEc0a6HFjlr78EHpJPoipzEwkFUEdb9FHKnCV
         hAcg+RUyY6zpHerFCjCcvuN97NV9B4/Hahv+f5Ra2g9LxpOsmdPOvZGiMr7qLg6qpplr
         2rFBDMY5exw7b8Q7x5DKL8uYz12vcQA+0t07Sen/5Pvg5Jat1W/cEkXBqPNm04V1lmFk
         YH5g==
X-Forwarded-Encrypted: i=1; AJvYcCVRwznx/TSmUJS1Icz+mFc5BqPIs7QHZd97w84DtGtbbX8Lgz9t2DtitsufGiPlh12v576tXTMzeDmtEW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjdgjPMe3c2rCEmAkT2LksVnbSwr60IgzNPKq8UvH/FmDXN/s
	DwpKN6o14h9D8d6jffJsjmuViUUUVjjCyTwqo7DIs2ly8dKFfJzuj/Y0KmqstUq8pqiTje/xxqq
	KOJvWVhYXRp0s7H2WLtdBqA==
X-Google-Smtp-Source: AGHT+IF3XrIOuZLzr95zLbd7FnCvuwGAUE/NKipTgwAL9Vm4NhQ+xCaEbNPY72ptqM5YQLLSLemYx+UklOwNUX8Q
X-Received: from wmoe6.prod.google.com ([2002:a05:600c:4486:b0:46e:67c8:72a6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3551:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-46e7115c811mr23867565e9.36.1759498759672;
 Fri, 03 Oct 2025 06:39:19 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:21 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-25-vdonnefort@google.com>
Subject: [PATCH v7 24/28] KVM: arm64: Add trace reset to the pKVM hyp
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
index 36a263422e4e..a7c5e9fc27a0 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -608,6 +608,13 @@ static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
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
@@ -658,6 +665,7 @@ static const hcall_t host_hcall[] = {
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
2.51.0.618.g983fd99d29-goog


