Return-Path: <linux-kernel+bounces-749080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03FB149DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80AB4E14BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1E275AE8;
	Tue, 29 Jul 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQRAHV2D"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E43278E77
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776799; cv=none; b=fCwKm5gTfVUmT00vhXl/ptHlCVcAi2iQp5ZkPCRIdu1blTFnZTzofXPiafZvP/YkSPDt2TktVShVJXYeFNhEnk9rurYg48M6JKXeAJ08TVggNg7zCR5jVRGszy16lSpwFR0Z1E3bZf1aws0dvZBR7L4k8bNNprLBeYXuF5mIhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776799; c=relaxed/simple;
	bh=G9Y0WTqgPEP/0PUyf6rRBrHpWFUxSCuG/ZYeAAHbSBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BOg3eKoettm2U4aCHv0wfTrBp8VvHXQ3Ima1z3fo2c+rKjCfioGxaMjmlx0KwZh0iiUqIJrzLPTZKMzCezP0y2AZ5z9jEutpL9yPZfMJCL8QsZNGJWev9JJQ8EE9SoHGZbjeWEHS2en3g+2aTsTb1amQDIBVomAOAAY2nPY1eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQRAHV2D; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-754f57d3259so8660540b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776797; x=1754381597; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7yGmakvlGT634aR11Csz05fa+gmD+2vIJ9rH8M6yTyo=;
        b=AQRAHV2D7RbT6K8xnj5a8KCOP/QNMGheY0jUjHRDJmDOx48g5lUUEwbNEW8jb9B4PL
         HTJ/8ib5HhsceVWIF+FDXQe36ZS9mkOSykjbBAmxzw/TwqePZvfJsYX27JZS4r9eeemp
         zZ5MBcYvb4ZJcYvKOstS5rVxZm0Eja6XUzb0/nl9Dqptwcz8fbNbdyvBqGQF4ZH/Lphg
         jeQUee7mGkbyKEVmNo01oN1Yovg3b98s+JMx79YjjpzxrCxRj8SUIA3UhfoRtEh6ZOiZ
         9TLeznp8115p06wXnsBL9OFy00r06U5aFtTQ2GBoFhVsYa4hZPpuwR4xtaWZMD1/AYqb
         mDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776797; x=1754381597;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yGmakvlGT634aR11Csz05fa+gmD+2vIJ9rH8M6yTyo=;
        b=qAH+RzhHplY41q7hA01zbY0CRMSrBTzfD/omfn0uxP5PxI55I0hN4GdZmXYyCOgeRj
         tFx3F4HLZ9p6ZiosXj036rbjJzz7E2ITsKRBeCb+z969HIqcDf5jxYVV02IVnF5QMmKd
         vgH+DR0TvaqFfoCQrHQSMcgv7YsdjVV3kwgRF61mGWScqSF3DuagM9Cr/8ckN5iC9EqY
         VxLGVDXmIFSHUbi+OetNibHkflpVtMXYp93ucY+oLLDPY7U7YVuhxs+YNX9LNWe4ZLoF
         sG7+IxyBvM4wxolRHAzsZkwqdWvCjIrWicBGs41gscU6SEb+3Zd47pqdk5TgyAUae1lM
         M4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVJjdQZylDq4EBKrD3z5B+K60ZzfnwB4mZG/TS48OZdBT6IhB28xzloc1OKllQGrCgTNAvOxG6YjhThUy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEiUJIoIWvby5k1OL4bcLIR9d7drZgV0UZMz3kCPLayguUR1i
	g8OrWn7QD5jjAlvtGqKfRdt7erlvf1qFdNZv4tMgDsbI5lSLal6Jxjau+ODG6Th2btqfeNo77rr
	gSa6jiQ==
X-Google-Smtp-Source: AGHT+IFNuMReO/chIStJlUvvk+LkUMhF7qnFNrzRzITSnP2mlhqW0sOsowPwW0OTBaOmH6EkTjLF3fwLlmk=
X-Received: from pfmm16.prod.google.com ([2002:a05:6a00:2490:b0:746:3185:144e])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c96:b0:749:464a:a77b
 with SMTP id d2e1a72fcca58-763349b95e7mr20176257b3a.18.1753776796333; Tue, 29
 Jul 2025 01:13:16 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:12:54 -0700
In-Reply-To: <20250729081256.3433892-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729081256.3433892-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729081256.3433892-2-yuzhuo@google.com>
Subject: [PATCH v1 1/3] tools: Import atomic_fetch_{and,add,sub}
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yuzhuo Jing <yzj@umich.edu>, Yuzhuo Jing <yuzhuo@google.com>, 
	Guo Ren <guoren@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Import necessary function (atomic_fetch_add) for ticket spinlock
Implementation.  In addition, also import those that pair with the
imported ones (atomic_fetch_sub, atomic_fetch_and).

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/arch/x86/include/asm/atomic.h    | 17 +++++++++
 tools/arch/x86/include/asm/cmpxchg.h   | 11 ++++++
 tools/include/asm-generic/atomic-gcc.h | 51 ++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index a55ffd4eb5f1..1fb7711ebbd7 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -66,6 +66,14 @@ static inline int atomic_dec_and_test(atomic_t *v)
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", "e");
 }
 
+static __always_inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	return xadd(&v->counter, i);
+}
+#define atomic_fetch_add atomic_fetch_add
+
+#define atomic_fetch_sub(i, v) atomic_fetch_add(-(i), v)
+
 static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return cmpxchg(&v->counter, old, new);
@@ -85,6 +93,15 @@ static __always_inline int atomic_fetch_or(int i, atomic_t *v)
 	return val;
 }
 
+static __always_inline int atomic_fetch_and(int i, atomic_t *v)
+{
+	int val = atomic_read(v);
+
+	do { } while (!atomic_try_cmpxchg(v, &val, val & i));
+
+	return val;
+}
+
 static inline int test_and_set_bit(long nr, unsigned long *addr)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, "Ir", nr, "%0", "c");
diff --git a/tools/arch/x86/include/asm/cmpxchg.h b/tools/arch/x86/include/asm/cmpxchg.h
index 5372da8b27fc..2d89f150badf 100644
--- a/tools/arch/x86/include/asm/cmpxchg.h
+++ b/tools/arch/x86/include/asm/cmpxchg.h
@@ -12,6 +12,8 @@ extern void __xchg_wrong_size(void)
 	__compiletime_error("Bad argument size for xchg");
 extern void __cmpxchg_wrong_size(void)
 	__compiletime_error("Bad argument size for cmpxchg");
+extern void __xadd_wrong_size(void)
+	__compiletime_error("Bad argument size for xadd");
 
 /*
  * Constants for operation sizes. On 32-bit, the 64-bit size it set to
@@ -200,4 +202,13 @@ extern void __cmpxchg_wrong_size(void)
 #define try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+/*
+ * xadd() adds "inc" to "*ptr" and atomically returns the previous
+ * value of "*ptr".
+ *
+ * xadd() is locked when multiple CPUs are online
+ */
+#define __xadd(ptr, inc, lock)	__xchg_op((ptr), (inc), xadd, lock)
+#define xadd(ptr, inc)		__xadd((ptr), (inc), LOCK_PREFIX)
+
 #endif	/* TOOLS_ASM_X86_CMPXCHG_H */
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
index 08b7b3b36873..cc146b82bb34 100644
--- a/tools/include/asm-generic/atomic-gcc.h
+++ b/tools/include/asm-generic/atomic-gcc.h
@@ -100,6 +100,23 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 	return likely(r == o);
 }
 
+/**
+ * atomic_fetch_and() - atomic bitwise AND with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_and() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_and(int i, atomic_t *v)
+{
+	return __sync_fetch_and_and(&v->counter, i);
+}
+
 /**
  * atomic_fetch_or() - atomic bitwise OR with full ordering
  * @i: int value
@@ -117,6 +134,40 @@ atomic_fetch_or(int i, atomic_t *v)
 	return __sync_fetch_and_or(&v->counter, i);
 }
 
+/**
+ * atomic_fetch_add() - atomic add with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_add(int i, atomic_t *v)
+{
+	return __sync_fetch_and_add(&v->counter, i);
+}
+
+/**
+ * atomic_fetch_sub() - atomic subtract with full ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_sub() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_sub(int i, atomic_t *v)
+{
+	return __sync_fetch_and_sub(&v->counter, i);
+}
+
 static inline int test_and_set_bit(long nr, unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
-- 
2.50.1.487.gc89ff58d15-goog


