Return-Path: <linux-kernel+bounces-636455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3128AACBB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FD13BC2F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD128B412;
	Tue,  6 May 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJe3mQT4"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E128AB0F
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550160; cv=none; b=rw3DurJoZdxA6SHjELvT5zdMDHWtIrqJIJjLYURtNorCD2ofG0pPct/9MuLXMWZCxWxG3hLuFXsFCKyzsSP/hKG9+uySPFtzhGQjBNTttnrbI84BkZaY2VSAvHKBcV0ufBje0wTxNLzYZSJmiJzgIZV8V/G7VKXjdv35w3mbCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550160; c=relaxed/simple;
	bh=HWOYbsDUxc8qUhWnwL3PLIP7jzejBZmuG99iYYoDR8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OjZP59Mz4qmFh2CQFzw/1XMXLBamsHg1GbAEDyTVEYSDiC7XNqZMaR+7hv5VAovVIvnTeawokGAdQH9GfwYbXe5QaVl8UvaweQNL/aiHJpG3WvM9M8wvePlPUWfgLCA5+2QZoy8eklY/+Dx6upt3jiH9hioyjS5QTpZu03jE3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJe3mQT4; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43efa869b0aso39478125e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550156; x=1747154956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePdWTj+f7Kqu7+m9jiLxrLe0rAI9On0cOEvt/oNt0Dg=;
        b=qJe3mQT45f8N8x9qY1+sJ46axQAT8l80KsFYHDjYkMZRDtDZsVvdY+RGlTx4fe89zy
         SQnm532hmjIQeYre8X4iiHt+m8bfc1I+LGLpQZ0ATROjRKJPX8ESCOl2NLbyLEv2v2TH
         XyTQa1G0NKYml6iRoOksHTaMupOShI3pSqpRmYz8aYLKtoyWr8y4MzP7kSNZfmkIRRiE
         31O4yTNBoJsJz5Oijzw0Zh5g6b7Mf5Ibx5ovYKGcKwSG4eqQCPRsHx2HLDli3t8SiJbl
         wI3rmNbCGnumgs7hWUROC8iFcQ+eu7ACLoctMOSWI3fuSUQl9NH3HIJj7cy/MjHVusBL
         hZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550156; x=1747154956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePdWTj+f7Kqu7+m9jiLxrLe0rAI9On0cOEvt/oNt0Dg=;
        b=R0lvT4KDKkDPKotwMZ2aTq+1N6Fdkv+ERh7RdKhWLMGfRMi7NDsm8wbksd1IOTAttk
         OHncOpX4DVBjH22qs0RvE9WEz7q+83+RnuIYd3SvU2vb1tdi4NrHePC8ofkwK7rHBUZG
         BTh0nOWB+osiJVkJE/9o51X3qVJ2NHzFWt5EDRpN537MhsZVE9XeiVgek3c3+GCAFHAu
         rr8Mx32yLKbcgwxWKzkrmYIxI+3jP7ezHqJkZXbXqnAWYMB/I47SsVokssZD3rQvPakL
         AIRieL2bWonN4LRYNoQcznUOKqd/GI+AN4+Ym2+q+WX1klWZYktNyxRSLnnrWke/Q7oD
         m0sg==
X-Forwarded-Encrypted: i=1; AJvYcCWUgm7MBY9K7wyIKKdZ3TlLF1BvwGAESr+cES/pHSKv2cCwRwC+HRQJyhULMzB1aLhW5VMKQd2yOgzZ1E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv+kgiMuXSdeU5xNdSHJFInuuMs6lqaI5uWancSe2FGBCdn/Ca
	ues40OyM8ph1mn34DzOGTiqKApdn2PfZd2tS0FNSfo4LUtvUF63JGfODUMlBvYIKy5O4/mDPZW9
	p3299AD1OS+ay/zW8rg==
X-Google-Smtp-Source: AGHT+IE88CHvP/t9XPxkguhLrXPQmG2IBHH3TFTt5TaGD8MyAacD97EJhOSmz1XBYyXVpAsyCZjhZpA0WwLhBaP+
X-Received: from wmbhg21.prod.google.com ([2002:a05:600c:5395:b0:43b:d6ca:6dd3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e48:b0:43d:98e7:38dc with SMTP id 5b1f17b1804b1-441c48aa36bmr110506395e9.5.1746550156444;
 Tue, 06 May 2025 09:49:16 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:16 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-21-vdonnefort@google.com>
Subject: [PATCH v4 20/24] KVM: arm64: Add trace reset to the pKVM hyp
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
index 516d6c63c145..c7ad36212a7d 100644
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
2.49.0.967.g6a0df3ecc3-goog


