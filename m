Return-Path: <linux-kernel+bounces-636450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E06AACBA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AE9983D31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6728A730;
	Tue,  6 May 2025 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z4RaSyxm"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8600628A416
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550152; cv=none; b=kFqA6QuvRXwuu93SxmqondpSS/g+yBLaOm7SnPuG0xoRwUHI3z9fIKND5pn/WTmRgrrl4KKQckEIFQoQFAW6S7NP3M/0CWi8gFVpJ2YM6w50snMaaUbTqsLA3S/yyD7uloz2JrsXKNUwOfmpt5My7DxrHhZhj7MXWq98Z3J4PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550152; c=relaxed/simple;
	bh=uK5a0ct2ICnUqn9DjzHC3LReJzEGHdu5Q2c70Mx74pA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mdDDZsfZu/u0sO1yHjI5bxLoKQRikFCv3kndDXbrdg0oCcyRVtDzJGFHZSqArbAyV0Dk1fHEaitvuoyyOHdZ3WERxv9tnxu/iyvp7gQrCX7fvQ/6uSkKZ2QC1ZiXmAYJkdGolhh4vef9GDyuiz4lHe0UFI8cGhQ1OR6LFaJV5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z4RaSyxm; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so36459125e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550149; x=1747154949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTKmizrXds5p9DE6J3WP7/kKkm1zSi2V0hVoZxXRS+Y=;
        b=z4RaSyxm+PFjNai2Au6r3FBzNiXbeB7tC3g1PelnEE3o5kWaWMsaZIhZgmyiXRROAM
         xKo+xRtHk+BUEa1W2iGYQR1DQrdy+H0sD5MDIsgbjiJRJMhoPA7FSrlDFJg6M0Qx4XV1
         CHs44+WuFK7k21YYpBuJtptHxLs0aJQjW5WekiO0jvljA6UKPXjkSv+TYVe/FG+To5Ry
         6QFZMnh1p8IPea46QqwCmHTo4x+KtiZnYeXAnjtrko6NRnw6SwExDg40111ipUubhtW6
         cVbBgxfTym83TmQY8d06OrnSnc8bVvURtvj3mzTtiGAF5vevJVzF4P8VQjSxvHXEdzhD
         5V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550149; x=1747154949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTKmizrXds5p9DE6J3WP7/kKkm1zSi2V0hVoZxXRS+Y=;
        b=Wpxc11QHdy4nGOmUC+sa+eZlTjZzTp2729Ft6XD76KYbD9PZ+jYRHfLrMF7B37oUnP
         PciS2OszTKsfJpDlHuto8l6zr4LBw0TWh1dxG+dZ/BJAmiS3Ue/mgO2dWKqlk3KKFCLq
         OtpQzXNU2htO7wv909+5T7jxidbUTwzpuTtVaf/8ZhNYVM48BcGjrEWlBs/0jYuR/ffK
         dap6d3Qc0gI6KMYy0IneVK+5CmpCIp1KBju1OUl1Ehyv4rbHHhr3hj4cfULZ0K+Oq1Yp
         tIq5PAgqn8LXf/e7Lzd7OdYABaIfAPtiHzCuFY0pNifNv1IMT4bdFnJxaZb/9cc2vXHS
         +Rcg==
X-Forwarded-Encrypted: i=1; AJvYcCXT4d8PRX9woNEM64/2xPvuP1MnSsmiAlPK/osSQ1lNCavWFa7hNJbvZWXKEMk70y2Dn/07ZcVMFk2kFaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSm4+1T8g/QUbiQsCzSXcObB1f5OOmo7yBLnvp8634ZpWfLTy+
	9v4INP2Kbo9W+7jiUVhPqowteaKbezYaGfEbwS8gqg8zm/Fl6vxzBm9vEihAC+dW0h/JWJEosSh
	qIK+rXmckct/G71r7Wg==
X-Google-Smtp-Source: AGHT+IE2t1cIjH9YYJy8Ayf9wJ/0y3Ak3eh6UWYMS00LUPr9De3lPaQ9ChoJojhjdULWg+br9k0N5dgvgMI3890q
X-Received: from wmben3.prod.google.com ([2002:a05:600c:8283:b0:43e:9aac:5a49])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3552:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-441d0fbd626mr38701485e9.4.1746550148999;
 Tue, 06 May 2025 09:49:08 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:12 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-17-vdonnefort@google.com>
Subject: [PATCH v4 16/24] KVM: arm64: Add clock support for the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
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
index b43426a493df..68d14258165c 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -28,6 +28,7 @@ hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o
 hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
 hyp-obj-$(CONFIG_LIST_HARDENED) += list_debug.o
+hyp-obj-$(CONFIG_PKVM_TRACING) += clock.o
 hyp-obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/clock.c b/arch/arm64/kvm/hyp/nvhe/clock.c
new file mode 100644
index 000000000000..879c6b09d9ca
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
+					   clock->data[bank].shift);
+	}
+
+	return (u64)ns + clock->data[bank].epoch_ns;
+}
-- 
2.49.0.967.g6a0df3ecc3-goog


