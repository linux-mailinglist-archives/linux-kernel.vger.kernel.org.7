Return-Path: <linux-kernel+bounces-890091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12028C3F35C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B202734D325
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456C320A1D;
	Fri,  7 Nov 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yMEFko5S"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6577B31B82E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508352; cv=none; b=XhNBm0KSPPa7w2U54AbfTvuQiU7dxNjj3tQb1wGiN6SnCFBq0eohX5I119WlKfhNpPM4E9PiCPcdgewvmc2WmjVJzKK3aOmoumHvF5GMUuwDVKLhzPedh2tc0row2DCs+XMMj/QFfPX7qIE0eYCbxvdHNs9ysKxn4B2vLv1rIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508352; c=relaxed/simple;
	bh=lGiiTh0OxHYfMPwWWByZmpNfww+xM4wQ1NhzqyQ8ka4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lUwvC13TlRVW8qocqUgnk/WN3D+sNlVRqVGRXr+m64yQFZB1sXtk6tPmC0ReHCcygwChQmmhyTgSzLX5WWJmFH8/aVQ3GRp1dkf6RyEUMqnGfzmmdudt08IiTSlhBPIxqe/oB2HwRZvSGZJ0ZAkvf8H+G0d6m5k0m3Mwq1Dq7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yMEFko5S; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-640cdaf43aeso610438a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508347; x=1763113147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlb+Kpako7K/ZFQ9pzs/izhh1i5WG8pq3BDkIYjd07Y=;
        b=yMEFko5SGjITFaJjPSw3Wpa5wmKFbfaJQdb4daLzv1+AgcWHeNYGsjiQEq+DsWfoSp
         pdFR3S9DkskxvZHqrNkFG2mwDNUGwdSSz0F0/err0P/ev8ceMz9FJId4HHS8YMVOfzKt
         5U+cOJa2XCcAl/6Y/vzrEMwalnEmvKUFLSouTLyT9i0H1f+4sX5bCUB6MJqlGThFll+z
         bRRV7wGVG7MHfx0WISvPkomrcSfNOHZpHV9pVpW9EF5Immp9Y5E98WqXnrppiq1moaHA
         kwJuWbepEu+Fidj//PyGckw/g/9v+nqsaSeBoumanv/OQcPOnenFBehpzF6uUt+mwTtC
         izGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508347; x=1763113147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlb+Kpako7K/ZFQ9pzs/izhh1i5WG8pq3BDkIYjd07Y=;
        b=XWVxMXTc3w+oGX5oSiPPm0S8m0f0yL37Aflv+MGlD7a30pcJBTwm87jZFKHsBlZKNR
         LzsBPGrgxmYNxLTKJJ5+jJ/wWq2Dm1g/F2oZc3nMr6dJIHJxhZkYeflk8pGm0tFTD650
         Hnu79mE4GlKev/2t40uzIKUvY3JazkU1dj9/7r0J0XoDw2S+fwocZAOCK6rmQ27vQx/7
         j+pdSY1A+iy9e2tc7DFSA7HEmZXb8WZdNOy2uPGxRYuiAad+VgKpG9jFmqajDl7sdtGS
         gs+WCKbdRys0E/ciNC5qW3S7mwdg6JBJoNTPdRvD3rJROF/lGG2mMv91LOHUPbluJYKW
         7xUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbNqDLXd5g0877ZWt63zajKv1+CvrBme6wVcesuyAJtciJTk+P9HGPmFDaqGZ1u0bXzDhe3tBZu4UFJr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nc56Xr0u+o+5ts6s/vJZQZsZ7S4N23FkKVO/KIiF2j/oUnhv
	kUjKrcymM7fTk2R7fuTIoRRGa74ZxrOIRRDX5vV9tHf2f+3COgJt+aJkum8giHe8tgt6kEo3aDn
	JeAt6GJSvnngMoZPC9/Eo0g==
X-Google-Smtp-Source: AGHT+IEPUDfqI4f4pqaRXkiNLHF/RceZQGy7tc5T8KjH7dmMEaQgNtTWnGWGyW4qmBIMMTOEr9LUfZoX341KfPIY
X-Received: from ejcvx5.prod.google.com ([2002:a17:907:a785:b0:b6d:529d:6eb3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d89:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b72c0cec57cmr250144766b.33.1762508347314;
 Fri, 07 Nov 2025 01:39:07 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:32 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-21-vdonnefort@google.com>
Subject: [PATCH v8 20/28] KVM: arm64: Add clock support for the pKVM hyp
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
index a244ec25f8c5..f55a9a17d38f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -17,7 +17,7 @@ ccflags-y += -fno-stack-protector	\
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
 
-lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o tishift.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 CFLAGS_switch.nvhe.o += -Wno-override-init
@@ -29,6 +29,7 @@ hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-y += ../../../kernel/smccc-call.o
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
2.51.2.1041.gc1ab5b90ca-goog


