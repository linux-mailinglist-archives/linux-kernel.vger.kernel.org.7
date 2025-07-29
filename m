Return-Path: <linux-kernel+bounces-748807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D45B14629
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C081C3AF8C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE99E21CC4F;
	Tue, 29 Jul 2025 02:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Een4VQzq"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81E2147E5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756014; cv=none; b=feLxyRtQSmfuCNyp+nGC8X+Znxd+HQco4LVres0Ed2zbk15IzrdiXRy7l4Yf2RthV04Wre86srTmN3VLDBzHb1g2zMVpsO+aWd4NYsMVW091ZZiqfHGUsBsIDEgGHF0PU+uHF0xwacX0uy7NwGLMNhJk7qsKTrxMa+jUESrtg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756014; c=relaxed/simple;
	bh=5uumQFEakBzCNefgnK5KQH0r1rdGvF5P6NYOneXfUyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M8Az6Dv2b+8ImXD/fDIx/T6GdxW5YZT0gCkvYp7v6+IXg3OydLtXfL8rr/mxHG6n3gd/E9ZMbP5TVNmTQwnZayXm1cSiuFJEYwCE++w9qqKURBwgEWFrCnoHrJFwD5jxaxd75X245yaLdErzoBTJwQPKl7B1cEmZZGVX5lmfJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Een4VQzq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b41f56fdab3so1593889a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756012; x=1754360812; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nR+qnYIXhky/aP885u9agL4XJhjaPZr+Fl5Gin8Crt0=;
        b=Een4VQzqbZ7JY+H+sBZhtsSbJZNoRQuxZyHaJGHoFW7XQ90mp6N/X3Ijibf7Bdtrrz
         Sb2aP0LLU2J8Ada6Xxjhir5kInaJyO+CqxKbnnPQ00oFe15jbyDOYG0BXnP7Jnh/uR3u
         fJsfJ1x5Fn94qiPSVyb2JaUeUeP6qasSbz5Mbqk7ncGB+oRU97z/rSoI6WFi/rtfQRks
         KMK139+peZ21r2X+uTDYyV4Y/gQcLmx0LAgENqRFLas6/KrcZM2dbYGt0da8bq2uXhQG
         ivlt536Tx3sIeLPzBc5ViVyToQQpCJ8ZjoxM5z02y/b9UX+v9WAz0A0d2XwLJSqEUyng
         enRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756012; x=1754360812;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nR+qnYIXhky/aP885u9agL4XJhjaPZr+Fl5Gin8Crt0=;
        b=Qk+UPUuo8e3yI4AQ4gLrWKOAs+7wUHK7TgSYdCu1T0YSfkAMwv6fgtBAjgB3ryhqdx
         Cw74HF6C7hEFO5pO0dHxQHm9aSsR+DhVPRZLOJHgkU+VFCp5C5MtJWOMmDFHsBaG9poy
         rxGDgqaENQkLc3MLl9ut+G2tnSpNPx53qZdnYZgXAU1KJA1JC2M847RkDECvkKaj4cBF
         hq1+hRGA7IB6dUgfXnjJq/NWx3ke/z8o4oTNAn4t8O5JuWUMkbPL5GLbU49AMrXWr5pQ
         mG4E7O21aFuWRz6VW7MmAOz0r8WS6h+FEhAHOH6BC1E+OfWsp9Da2U434L3VV0pcFVUD
         XO5g==
X-Forwarded-Encrypted: i=1; AJvYcCU1kukt9yV2l0SYYLUxQvNnRcDSmlXkLbpPKrmZI9mW+80HWb/djlpssjRtlvsSnDZ9wI0rSFKgjA4Yy/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqruHVCMuGOzsi6qm0PzfAgI6Fx/+Zzhnrh6aMfUHBJ+SkY2Im
	TeFVH57h6jcwTijl5l19aB74vup4imaG2hUPZg/e3lyxZHOOhOu/LE+TLYYcmwR4fGZGMQkhG6V
	Wf4J0uQ==
X-Google-Smtp-Source: AGHT+IGaz+zt9fkjFW/IQ8BgR/CTX8RaQPImDuqvY7R9r+tO/y2WcXT503K699hl7CqHOeIz+AfKnHSrNZE=
X-Received: from pfjj11.prod.google.com ([2002:a05:6a00:234b:b0:746:30f0:9b33])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938c:b0:220:33e9:15da
 with SMTP id adf61e73a8af0-23d6ffe49aamr22500947637.2.1753756011644; Mon, 28
 Jul 2025 19:26:51 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:37 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-5-yuzhuo@google.com>
Subject: [PATCH v1 4/7] tools: Implement userspace per-cpu
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Implement userspace per-cpu for imported kernel code.  Compared with
simple thread-local definition, the kernel per-cpu provides 1) a
guarantee of static lifetime even when thread exits, and 2) the ability
to access other CPU's per-cpu data.

This patch adds an alternative implementation and interface for
userspace per-cpu.  The kernel implementation uses special ELF sections
and offset calculation.  For simplicity, this version defines a
PERCPU_MAX length global array for each per-cpu data, and uses a
thread-local cpu id for indexing.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/include/linux/compiler_types.h  |   3 +
 tools/include/linux/percpu-simulate.h | 128 ++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 tools/include/linux/percpu-simulate.h

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index 9a2a2f8d7b6c..46550c500b8c 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -31,6 +31,9 @@
 # define __cond_lock(x,c) (c)
 #endif /* __CHECKER__ */
 
+/* Per-cpu checker flag does not use address space attribute in userspace */
+#define __percpu
+
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
diff --git a/tools/include/linux/percpu-simulate.h b/tools/include/linux/percpu-simulate.h
new file mode 100644
index 000000000000..a6af2f2211eb
--- /dev/null
+++ b/tools/include/linux/percpu-simulate.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Userspace implementation of per_cpu_ptr for adapted kernel code.
+ *
+ * Userspace code does not have and does not need a per-cpu concept, but
+ * instead can declare variables as thread-local.  However, the kernel per-cpu
+ * further provides 1) the guarantee of static lifetime when thread exits, and
+ * 2) the ability to access other CPU's per-cpu data.  This file provides a
+ * simple implementation of such functionality, but with slightly different
+ * APIs and without linker script changes.
+ *
+ * 2025  Yuzhuo Jing <yuzhuo@google.com>
+ */
+#ifndef __PERCPU_SIMULATE_H__
+#define __PERCPU_SIMULATE_H__
+
+#include <assert.h>
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/*
+ * The maximum supported number of CPUs.  Per-cpu variables are defined as a
+ * PERCPU_MAX length array, indexed by a thread-local cpu id.
+ */
+#define PERCPU_MAX 4096
+
+#ifdef ASSERT_PERCPU
+#define __check_cpu_id(cpu)						\
+({									\
+	u32 cpuid = (cpu);						\
+	assert(cpuid < PERCPU_MAX);					\
+	cpuid;								\
+})
+#else
+#define __check_cpu_id(cpu)	(cpu)
+#endif
+
+/*
+ * Use weak symbol: only define __thread_per_cpu_id variable if any perf tool
+ * includes this header file.
+ */
+_Thread_local u32 __thread_per_cpu_id __weak;
+
+static inline u32 get_this_cpu_id(void)
+{
+	return __thread_per_cpu_id;
+}
+
+/*
+ * The user code must call this function inside of each thread that uses
+ * per-cpu data structures.  The user code can choose an id of their choice,
+ * but must ensure each thread uses a different id.
+ *
+ * Safety: asserts CPU id smaller than PERCPU_MAX if ASSERT_PERCPU is defined.
+ */
+static inline void set_this_cpu_id(u32 id)
+{
+	__thread_per_cpu_id = __check_cpu_id(id);
+}
+
+/*
+ * Declare a per-cpu data structure.  This only declares the data type and
+ * array length. Different per-cpu data are differentiated by a key (identifer).
+ *
+ * Different from the kernel version, this API must be called before the actual
+ * definition (i.e. DEFINE_PER_CPU_ALIGNED).
+ *
+ * Note that this implementation does not support prepending static qualifier,
+ * or appending assignment expressions.
+ */
+#define DECLARE_PER_CPU_ALIGNED(key, type, data) \
+	extern struct __percpu_type_##key { \
+		type data; \
+	} __percpu_data_##key[PERCPU_MAX]
+
+/*
+ * Define the per-cpu data storage for a given key.  This uses a previously
+ * defined data type in DECLARE_PER_CPU_ALIGNED.
+ *
+ * Different from the kernel version, this API only accepts a key name.
+ */
+#define DEFINE_PER_CPU_ALIGNED(key) \
+	struct __percpu_type_##key __percpu_data_##key[PERCPU_MAX]
+
+#define __raw_per_cpu_value(key, field, cpu) \
+	(__percpu_data_##key[cpu].field)
+
+/*
+ * Get a pointer of per-cpu data for a given key.
+ *
+ * Different from the kernel version, users of this API don't need to pass the
+ * address of the base variable (through `&varname').
+ *
+ * Safety: asserts CPU id smaller than PERCPU_MAX if ASSERT_PERCPU is defined.
+ */
+#define per_cpu_ptr(key, field, cpu) (&per_cpu_value(key, field, cpu))
+#define this_cpu_ptr(key, field) (&this_cpu_value(key, field))
+
+/*
+ * Additional APIs for direct value access.  Effectively, `*per_cpu_ptr(...)'.
+ *
+ * Safety: asserts CPU id smaller than PERCPU_MAX if ASSERT_PERCPU is defined.
+ */
+#define per_cpu_value(key, field, cpu) \
+	(__raw_per_cpu_value(key, field, __check_cpu_id(cpu)))
+#define this_cpu_value(key, field) \
+	(__raw_per_cpu_value(key, field, __thread_per_cpu_id))
+
+/*
+ * Helper functions of simple per-cpu operations.
+ *
+ * The kernel version differentiates __this_cpu_* from this_cpu_* for
+ * preemption/interrupt-safe contexts, but the userspace version defines them
+ * as the same.
+ */
+
+#define __this_cpu_add(key, field, val)	(this_cpu_value(key, field) += (val))
+#define __this_cpu_sub(key, field, val)	(this_cpu_value(key, field) -= (val))
+#define __this_cpu_inc(key, field)	(++this_cpu_value(key, field))
+#define __this_cpu_dec(key, field)	(--this_cpu_value(key, field))
+
+#define this_cpu_add	__this_cpu_add
+#define this_cpu_sub	__this_cpu_sub
+#define this_cpu_inc	__this_cpu_inc
+#define this_cpu_dec	__this_cpu_dec
+
+#endif /* __PERCPU_SIMULATE_H__ */
-- 
2.50.1.487.gc89ff58d15-goog


