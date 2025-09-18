Return-Path: <linux-kernel+bounces-748805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B49B14626
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDF4542437
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1A20E6E3;
	Tue, 29 Jul 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvy3uJGj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006020296E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756010; cv=none; b=G5MfhvsdlhJO0LXLytIG9lMI0z/AXeSsa3PUAs9lr9bzJ7CqcBNvDrkEtz9sEEjOxbyGkqBkUoPCOsJbGs5zyi3tnq1HqqwflMHRO+LC7aJ8086hjWs1p72PnJf10npm7koyrNrvwTNjamFW5IQBckQNx1DVIKwJ6zLmWwAL4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756010; c=relaxed/simple;
	bh=4ISGW0qCLPw0BM53+WZj1UO7Eu/DiHDQi040hwtDTro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=d2o2a1QtuktGsGSCwbquI5OcpDtmh92Ho6hKVXVq6ASYYkc9GyQoz3iGyQtPsUNwEY++hRFLsLy8nLmK+qShc1T5PuVkKKRcyEJBT2chk6piShKspJtS0VfVz2SMi4FY7/DSuaxrwbNok6+b9bRZXaHcFFsQpukzKdy2NenJnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvy3uJGj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403e4c82dbso12415315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 19:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756008; x=1754360808; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZDFdixHdB12wePHGCdlmdShiJsvmZbe+2EaeGSxRAI=;
        b=yvy3uJGjVeSFxfka0z1c0zQiLzmtMvwka3ld+dW61JGQdNKt+rPtw2RRh0s5zkj7vB
         TBiB2Wkdp7NlJv0AwYrY8jby+27RbFo6+QsLLaBQu2BL4Sr3axPH6F8WuG2vyEZr2Ze6
         leFFoYnXCNCcMUe4j1dSPmZYx+qtDvYMn0UQepywD+Dt0zI2BJROOGC1dUUGuT36GnKN
         9xyTVl0q3pTGTjg+W8ODZbLVUJVYPDBYqipjkCJisMLnl66wlT9L7GLcjXgS5uVavXQV
         JggyLiBGICQHWGtSPSmyAA3wKYcCc0ri9yaSW3McrCdgmZK8JFd6PDFGkEMky/MkxKSY
         oB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756008; x=1754360808;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZDFdixHdB12wePHGCdlmdShiJsvmZbe+2EaeGSxRAI=;
        b=OjYphjrxnZschElXCBf1wnN+GY1rqGGNkcLxQs5mcNzoGJuQORrFl0lZwsf3Wi8vrT
         z5ZnSNW3HMITeGGUoA2fAdty6ksO3zwnINaX6Jc8trTFKxoLF4kXq+iG5EnrzdWoyNxS
         e3bw4syn9Z1C+MDmsR8qc9e1oW/AW9gvXvJIY36OfO8eq8l1ad4FyKezVU7kCnNREPqY
         EZ7LJLxtewzyrNhftwF69KKc0ES7jFft8RURGVkdF/IIhPUD9xMuWRdy0Q3bkjnAFgab
         xSvjTDqcUFwOxNmSy8A2BH4cGgaqfoD+KhrX41Mp2JzQhdD4zIdOCYt9bhQ67nGMPoOh
         I02A==
X-Forwarded-Encrypted: i=1; AJvYcCXFayxMFytRb9ZOdXiDhH+YWdZbwlGBSM+KQuIzqlltViefAi2CV1EZm9G7CLEykgMz1DFWowPhw0/o4fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Vl8w/SkK3KX+wvCHe64CkP0Ju7uo09jL/bDaQC3SxCyP5baM
	0NU9Tu54CQcRSnSlI5JHUpt7oLHucCCfAktxGaaOQG49cxWmyZNsnTCHL5ZIAAixH8kuyrM/7gL
	zIXR5Yw==
X-Google-Smtp-Source: AGHT+IGT/z+KJFAljNSW6NANlfZq/RIKeylnOweKpxXQz/9KYWN22xeESvB+lMHSNFQTjy3lnaZ3WI8wSiY=
X-Received: from plbme16.prod.google.com ([2002:a17:902:fc50:b0:23f:8c3f:e0fc])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:240:71a5:f30
 with SMTP id d9443c01a7336-24071a51d35mr8329275ad.22.1753756008099; Mon, 28
 Jul 2025 19:26:48 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:35 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-3-yuzhuo@google.com>
Subject: [PATCH v1 2/7] tools: Import smp_cond_load and atomic_cond_read
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

Import generic barrier implementation of smp_cond_load_{acquire,relaxed}
and import macro definitions of atomic_cond_read_{acquire,relaxed}.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/include/asm/barrier.h  | 58 ++++++++++++++++++++++++++++++++++++
 tools/include/linux/atomic.h |  3 ++
 2 files changed, 61 insertions(+)

diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 0c21678ac5e6..5150c955c1c9 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -63,3 +63,61 @@ do {						\
 	___p1;					\
 })
 #endif
+
+#ifndef cpu_relax
+#define cpu_relax() ({})
+#endif
+
+/**
+ * smp_acquire__after_ctrl_dep() - Provide ACQUIRE ordering after a control dependency
+ *
+ * A control dependency provides a LOAD->STORE order, the additional RMB
+ * provides LOAD->LOAD order, together they provide LOAD->{LOAD,STORE} order,
+ * aka. (load)-ACQUIRE.
+ *
+ * Architectures that do not do load speculation can have this be barrier().
+ */
+#ifndef smp_acquire__after_ctrl_dep
+#define smp_acquire__after_ctrl_dep()		smp_rmb()
+#endif
+
+/**
+ * smp_cond_load_relaxed() - (Spin) wait for cond with no ordering guarantees
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Due to C lacking lambda expressions we load the value of *ptr into a
+ * pre-named variable @VAL to be used in @cond.
+ */
+#ifndef smp_cond_load_relaxed
+#define smp_cond_load_relaxed(ptr, cond_expr) ({		\
+	typeof(ptr) __PTR = (ptr);				\
+	__unqual_scalar_typeof(*ptr) VAL;			\
+	for (;;) {						\
+		VAL = READ_ONCE(*__PTR);			\
+		if (cond_expr)					\
+			break;					\
+		cpu_relax();					\
+	}							\
+	(typeof(*ptr))VAL;					\
+})
+#endif
+
+/**
+ * smp_cond_load_acquire() - (Spin) wait for cond with ACQUIRE ordering
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ *
+ * Equivalent to using smp_load_acquire() on the condition variable but employs
+ * the control dependency of the wait to reduce the barrier on many platforms.
+ */
+#ifndef smp_cond_load_acquire
+#define smp_cond_load_acquire(ptr, cond_expr) ({		\
+	__unqual_scalar_typeof(*ptr) _val;			\
+	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
+	smp_acquire__after_ctrl_dep();				\
+	(typeof(*ptr))_val;					\
+})
+#endif
diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 332a34177995..6baee2c41b55 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -36,4 +36,7 @@ void atomic_long_set(atomic_long_t *v, long i);
 #define cmpxchg_release		cmpxchg
 #endif
 
+#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
 #endif /* __TOOLS_LINUX_ATOMIC_H */
-- 
2.50.1.487.gc89ff58d15-goog


