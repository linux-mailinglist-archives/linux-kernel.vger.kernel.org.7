Return-Path: <linux-kernel+bounces-779259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D323B2F12A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7C5E69BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337F2F5479;
	Thu, 21 Aug 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI32oti1"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904262EAB80
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764099; cv=none; b=GKC827jKZTzUTd9dh1CNdjYEhlmVNGDLFYqTCYeXfU4wCIEhHpP1RSBedD3YxkfGgco54Bi6G5EY2OUq+Ro5uvHfwBR/5U437YEpqriiwZ3G9otisFAwiq/1/vJc3c2AQpBah9cTyk1RKSFMSJDIMz9KCU4GjC2XKiCO3M8G7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764099; c=relaxed/simple;
	bh=VN6dK6H7Zc4iEnBzTtDQa6gXAMoJpEbsVnVKSYbAq0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RfSfxzq0+THsnw0mluhLSQB3EuTpCNetsCmPf+clxbNkmhY+bDNwF+hRW4HVYYldp66j1EmF268IFHWbseDKr8c7hYsGKjqHL1I6lZZzqZ/QbkUT65BaQNVSaidJaj1Fv2s2/YENeVzBMzOH/FV+Zv7W/AKIaiPJ1zuF+hi26w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI32oti1; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0c5377so3307295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764095; x=1756368895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOFNDacMW6nvsJMgDPU7r8kmdvWL23ZcJqIAku3JKRo=;
        b=XI32oti1wJVXAOuCJQ87o5JbxzELz9R29+CTZZPMdrvnHsIPWm74Kq9wMPTajg1jt8
         Cmab8kfqYcWyZfp49xx4J3q21ZQ6DfunMAHuhczUYc976W3OGv6nur1jfti7EyqYfG6c
         UcHSBNXXRzCHQrRaiFHLxlkOAOf8v8HNCbVcGlONea6dgSnfd3UP6+9euSkIOu4s8vtY
         aShc58yfL4kVED2vRHIeL6Geth8/3G5O1eo4G3lnBRCXVzDByNNaCMNsDzS6MZgne5JT
         qWs63H8dHd3Ib+YS39XN6kJZo6nAfzmFkzGK+VuLHxsfTzvGjIoGTWXxLZwRO5sRUVsN
         D6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764095; x=1756368895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOFNDacMW6nvsJMgDPU7r8kmdvWL23ZcJqIAku3JKRo=;
        b=HJv5Q1D0Uuk/nzyA3QweQDvkLa2ROEwZ0i9I173dfBZbgoRk3zHeYgPobauX35wV/+
         nmuAjv9RcwOUIfJCVmzvZ1OJk1T1O3HJJgZ7UbFy7jgsILiAvYefWhW/tCdokVCa/GA4
         Cz/F89y46o83K6UvD1Rv/8967izjWSdCdjNXmfSEZhfrTkCLNZsq7WWz6fDWxp+at4sP
         PTXizNTGfFRCrqazSUl3/HDNFI9hsEgPpXhVw0DrjqLesp3uzB72dIMM5t+P3icwCUZl
         8Bf4kriIkVJOTMZuLMa8MOBNWzgFgxhmkVx0UG2aFz+9zLDPezMDucuD1bemkq36aX3e
         cULA==
X-Forwarded-Encrypted: i=1; AJvYcCVM/q86G+kYwr6FhifCrWqbKcRgLThE8m0uXLd8q3oexHqgR4NsJ8cPeOTZy7R0DILkNV0Qm37/LDg+KqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcwgr44L0OVlRORciJLAR/8L7GVECLEARP0TOJPIdBB524ZGtr
	hW0wgTZ5p45+6qlaTNlzFHaufB3QPa8k6/pAVD+vVaBvONC2w5tAuNl3hk0M7/nxW4TAIKLOVfx
	broAvl9BqhDZvNJOZyMdfNQ==
X-Google-Smtp-Source: AGHT+IFBwm4nsjQFbZ2TuWuaXuLzNFlXoEJJyhjLRg44n+oKsrUh+xl35jfaVRxhiG9z7P8qTxgzFlBgbH+883qw
X-Received: from wmbes8.prod.google.com ([2002:a05:600c:8108:b0:459:da33:b20c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b84:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45b4d85b22amr11092705e9.18.1755764094894;
 Thu, 21 Aug 2025 01:14:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:11 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-24-vdonnefort@google.com>
Subject: [PATCH v6 23/24] KVM: arm64: Add selftest event support to pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest event that can be triggered from a `write_event` tracefs
file. This intends to be used by trace remote selftests.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 79019e11f529..522cccef32b7 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -94,6 +94,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_reset_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_enable_event,
+	__KVM_HOST_SMCCC_FUNC___pkvm_write_event,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
index ce3953bc884a..3d1244972869 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -24,4 +24,18 @@ HYP_EVENT(hyp_exit,
 	),
 	HE_PRINTK()
 );
+
+#ifdef CONFIG_PKVM_SELFTESTS
+HYP_EVENT(selftest,
+	HE_PROTO(u64 id),
+	HE_STRUCT(
+		he_field(u64, id)
+	),
+	HE_ASSIGN(
+		__entry->id = id;
+	),
+	RE_PRINTK("id=%lld", __entry->id)
+);
 #endif
+
+#endif /* __ARM64_KVM_HYPEVENTS_H_ */
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index e06358aaf1af..dc2ac3049428 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -45,6 +45,7 @@ menuconfig KVM
 config NVHE_EL2_DEBUG
 	bool "Debug mode for non-VHE EL2 object"
 	depends on KVM
+	select PKVM_SELFTESTS
 	help
 	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
 	  Failure reports will BUG() in the hypervisor. This is intended for
@@ -82,6 +83,15 @@ config PTDUMP_STAGE2_DEBUGFS
 
 	  If in doubt, say N.
 
+config PKVM_SELFTESTS
+	bool "Protected KVM hypervisor selftests"
+	depends on KVM
+	default n
+	help
+	  Say Y here to enable pKVM hypervisor testing infrastructure.
+
+	  If unsure, say N.
+
 config PKVM_TRACING
 	bool
 	depends on KVM
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index f8361520967b..81d8628a9047 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -631,6 +631,20 @@ static void handle___pkvm_enable_event(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_enable_event(id, enable);
 }
 
+static void handle___pkvm_write_event(struct kvm_cpu_context *host_ctxt)
+{
+	int smc_ret = SMCCC_RET_NOT_SUPPORTED, ret = -EOPNOTSUPP;
+#ifdef CONFIG_PKVM_SELFTESTS
+	DECLARE_REG(u64, id, host_ctxt, 1);
+
+	trace_selftest(id);
+	smc_ret = SMCCC_RET_SUCCESS;
+	ret = 0;
+#endif
+	cpu_reg(host_ctxt, 0) = smc_ret;
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -677,6 +691,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 	HANDLE_FUNC(__pkvm_enable_event),
+	HANDLE_FUNC(__pkvm_write_event),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 70c0939ebc6a..5b5d17a47ecc 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -317,8 +317,34 @@ static int hyp_trace_clock_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(hyp_trace_clock);
 
+#ifdef CONFIG_PKVM_SELFTESTS
+static ssize_t hyp_trace_write_event_write(struct file *f, const char __user *ubuf,
+					   size_t cnt, loff_t *pos)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = kvm_call_hyp_nvhe(__pkvm_write_event, val);
+	if (ret)
+		return ret;
+
+	return cnt;
+}
+
+static const struct file_operations hyp_trace_write_event_fops = {
+	.write	= hyp_trace_write_event_write,
+};
+#endif
+
 static int hyp_trace_init_tracefs(struct dentry *d, void *priv)
 {
+#ifdef CONFIG_PKVM_SELFTESTS
+	tracefs_create_file("write_event", 0200, d, NULL, &hyp_trace_write_event_fops);
+#endif
 	return tracefs_create_file("trace_clock", 0440, d, NULL, &hyp_trace_clock_fops) ?
 		0 : -ENOMEM;
 }
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


