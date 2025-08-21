Return-Path: <linux-kernel+bounces-779252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F2B2F0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464EE1C219F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8A2EFD87;
	Thu, 21 Aug 2025 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNqeDHQk"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A242ECE87
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764088; cv=none; b=ePyp6ooAplzDyflO9ItXkvnznBFa5yyEU92tJvzaBBSdtyVpj/jjetO580TFGob/oUWyYAI4R1LcClnoW0/HNx3rBlZ5QNQX54MpBC37ZhIAI3p20T2HZN2OXgTe0lNA9+zemqgKZu7RshyzQKWHrCJCaersHsmSBZvt6UbYvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764088; c=relaxed/simple;
	bh=ssX6pnv/BMHDiEMq3MmpaclSzI29qITuu1YF5wLH5RY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duzsGk5bF9jJvu+dD2vYJD9sBMvhmunPbv21lxovBzjiEkt3/uv5lj2h6F3KG1Zivj3hIbIMEHf3MBCNFDpBwFWEs8uQZRRIbY2YNcLROVar/ReNWglzGbhDmLbY2XEICdPygNB3SAqRMJ5zCt4g81ca71R/vgocWnlRxBqdIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNqeDHQk; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9e4146902so284910f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764084; x=1756368884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6PqHQ+VSrJuXFil8vRzl3n00OmPsRbJiS1vDm4o6lA=;
        b=rNqeDHQkimAUlj+uYuSBK3YH1mLaL7eCdR/saeEeNuuF5Nwky1J1r0sATitJo3p0tw
         ijHxulxRWb6mOtfYj6fUIf1oVZOLA7ryhrjSbhgfJQqOmEC5b8MNo9LYzVUkc7YlRual
         11vIwqmFxx8HWY6pE8QliW6JC1x0k53mqe9wnBykSlqhi2mXiBUuOKJufKjIiKW+l85k
         eqW8YTnkRqAxby/0yaVkpn2Ui+8pj44Dhe2Sd2Z2l/ie8Oy15PpG8oGQ/PSLL0RICOUe
         wzr0LDM9nyCSwEH8bPYHOqPt4zEZLkcwPz8PadpWufoi9SNNUJpKWrQPbQcN1q6hfrIr
         xnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764084; x=1756368884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6PqHQ+VSrJuXFil8vRzl3n00OmPsRbJiS1vDm4o6lA=;
        b=w2xr85GybSiYYqOpJgCybWfalQE9vuTvmNF5zyfc0BLzlt3KSVdEGcM+51s+Vf8wqB
         Q1qNvePRljh7tJx8THfak+69+WpJqj29+rwxunjVpMhbtT7Wq7ZRoRa/O4ZMzv672OSm
         286SWXHP+haAKU5AIYkFbAVtj/vIk+HldtXrqEaG9MIhVVlNF4Lm9ZWYsyfM2atTPFeE
         gMpdzqZzRSr3PPnRGmKJOuNcaFhROBZz2GR3C1sLQAKuJ2M54OWPVl+9mnnrnbW20qGh
         c1vxWaS6/gsgGIfc3KrVEoFfcGmKhnQtTyIz1/WBoNK9Ar/LMBoDXVP1R+sdBnJBRkB1
         y+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP4jnBiXzBeX1WVVUyklxhYordcWtpR2JwykSed1L2zTAYdapY+elz6UACUmu6SPrCNfbrN7wua/NJses=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVIMASy5M8aw31TKJMH8/fqUvV1uAl4y8OaXS3w3ZH3GHOM4Z
	Rb30OnUCjX9FSShnXUyz0B771d99Zo1oEuY6UypO31KAvUOEhV63AkN4LWcK6jwhFosDJAIqS/x
	pGPD00kHz1OOeO9fPvC0u6A==
X-Google-Smtp-Source: AGHT+IHjSHmggKyPUo9IkQhNfhc+5LXvr/ll1IavLoHjTMFXBwqe1Lx+YS0W/l095EMX48jc3sXU+Ed9/HB+3KTX
X-Received: from wrar28.prod.google.com ([2002:adf:b1dc:0:b0:3b8:fa02:c0b5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2d82:b0:3c4:edc0:2895 with SMTP id ffacd0b85a97d-3c4edc02d24mr532633f8f.62.1755764084544;
 Thu, 21 Aug 2025 01:14:44 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:04 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-17-vdonnefort@google.com>
Subject: [PATCH v6 16/24] KVM: arm64: Add clock support for the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

By default, the arm64 host kernel is using the arch timer as a source
for sched_clock. Conveniently, EL2 has access to that same counter,
allowing to generate clock values that are synchronized.

The clock needs nonetheless to be setup with the same slope values as
the kernel. Introducing at the same time trace_clock() which is expected
to be later configured by the hypervisor tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index e6be1f5d0967..d46621d936e3 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -146,5 +146,4 @@ extern u64 kvm_nvhe_sym(id_aa64smfr0_el1_sys_val);
 extern unsigned long kvm_nvhe_sym(__icache_flags);
 extern unsigned int kvm_nvhe_sym(kvm_arm_vmid_bits);
 extern unsigned int kvm_nvhe_sym(kvm_host_sve_max_vl);
-
 #endif /* __ARM64_KVM_HYP_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/clock.h b/arch/arm64/kvm/hyp/include/nvhe/clock.h
new file mode 100644
index 000000000000..9e152521f345
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/clock.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ARM64_KVM_HYP_NVHE_CLOCK_H
+#define __ARM64_KVM_HYP_NVHE_CLOCK_H
+#include <linux/types.h>
+
+#include <asm/kvm_hyp.h>
+
+#ifdef CONFIG_PKVM_TRACING
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
+u64 trace_clock(void);
+#else
+static inline void
+trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
+static inline u64 trace_clock(void) { return 0; }
+#endif
+#endif
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 0b0a68b663d4..607357e36026 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -17,7 +17,7 @@ ccflags-y += -fno-stack-protector	\
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
 
-lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o tishift.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 CFLAGS_switch.nvhe.o += -Wno-override-init
@@ -28,6 +28,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
+hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
new file mode 100644
index 000000000000..600a300bece7
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/clock.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Google LLC
+ * Author: Vincent Donnefort <vdonnefort@google.com>
+ */
+
+#include <nvhe/clock.h>
+
+#include <asm/arch_timer.h>
+#include <asm/div64.h>
+
+static struct clock_data {
+	struct {
+		u32 mult;
+		u32 shift;
+		u64 epoch_ns;
+		u64 epoch_cyc;
+		u64 cyc_overflow64;
+	} data[2];
+	u64 cur;
+} trace_clock_data;
+
+static u64 __clock_mult_uint128(u64 cyc, u32 mult, u32 shift)
+{
+	__uint128_t ns = (__uint128_t)cyc * mult;
+
+	ns >>= shift;
+
+	return (u64)ns;
+}
+
+/* Does not guarantee no reader on the modified bank. */
+void trace_clock_update(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = clock->cur ^ 1;
+
+	clock->data[bank].mult			= mult;
+	clock->data[bank].shift			= shift;
+	clock->data[bank].epoch_ns		= epoch_ns;
+	clock->data[bank].epoch_cyc		= epoch_cyc;
+	clock->data[bank].cyc_overflow64	= ULONG_MAX / mult;
+
+	smp_store_release(&clock->cur, bank);
+}
+
+/* Using host provided data. Do not use for anything else than debugging. */
+u64 trace_clock(void)
+{
+	struct clock_data *clock = &trace_clock_data;
+	u64 bank = smp_load_acquire(&clock->cur);
+	u64 cyc, ns;
+
+	cyc = __arch_counter_get_cntpct() - clock->data[bank].epoch_cyc;
+
+	if (likely(cyc < clock->data[bank].cyc_overflow64)) {
+		ns = cyc * clock->data[bank].mult;
+		ns >>= clock->data[bank].shift;
+	} else {
+		ns = __clock_mult_uint128(cyc, clock->data[bank].mult,
+					  clock->data[bank].shift);
+	}
+
+	return (u64)ns + clock->data[bank].epoch_ns;
+}
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


