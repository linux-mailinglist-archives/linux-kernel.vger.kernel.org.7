Return-Path: <linux-kernel+bounces-749082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A58B149DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F9816A595
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B827FB1E;
	Tue, 29 Jul 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQ136RcE"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118D27AC5A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776802; cv=none; b=PXdtLjILvitH9HrLM1LvB3lewyqerbRJ/+8ycSUsENjQsnZPp0xkbzrxrB70IEka/jzJTTtfDoDscTP/v0NX7Ev2720P8Bb02KtnPW7OFyVzeOkXUxIHUu7jVQHHaJTrWwvMcWWERWdMm7NEVIfUMfNxDFL87/iLltbQFRCZQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776802; c=relaxed/simple;
	bh=wIlIxBChFTMG7kMRZ3YzuSh8kV0vPNTjl542ab4nu3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YkrEiWNMMDGKtRVe4KGjJEt5F3eQxZyVA3YZpovJJiac6NtEk3Rxl7ailNxhVCU6FbTuX7ySpXFUhlSvLfyDnS+a9jwtAtNxcXAlDMTCgY3yNQ8ftCEsV/5166GwPBBTBmfmlXEr388Nf1o/Hj7gIc+KHw6oPwXX7zn806hH5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQ136RcE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-756a4884dfcso5395633b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776798; x=1754381598; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsUjwBpLVzQ5mIZOyiGvQnkCxmITIUZKoOgzZ5YyMZw=;
        b=pQ136RcEa0/Kb+tOHmeDz1Deg++MJ7Hwwuv+ODg3BvBxSvEThSi2YF+/t8F40NbuyT
         zvKTFpHXwGEkZNxnPFiwcDgdqvFuNz5EcsG7dbGxTp1uJ3jUX3IQ125GG5Vq7aJLxciR
         wvON94BoFzZnVn38rLrsUltHR09nhiAkfNDqerjQhn0kJeCoSpX0m0NIeW6j2kiub24m
         EiJauoppsgwwNRRWv15HkFiVWHmex9LKASyBnypDRNobkvbUMsx6fyIQgOOT1oFPgNvh
         DdDixGnwUEcY6QWDsrIpDvJSXKXd29J8H1fn0sMnKAYpMVSA0QLHs1WLNwfJhvYxH5W4
         U5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776798; x=1754381598;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsUjwBpLVzQ5mIZOyiGvQnkCxmITIUZKoOgzZ5YyMZw=;
        b=P+0y0x7ACzY3oc4EyNtOqPQiM02LzHU9+t59Mduj1mtPdQqAhKoI6d496DffqhxdPs
         kr5o6Swq+BF0NLif+abIkMhDNERkQePDYaQHo0Yopn06Fg4MXyKKg6v25VGPQrGhT+PO
         jLjM/sKHOo1C1uh3Yu+BAagD6NlfF4zUgv2WD3jFVcQjy6Mn0CCWWXr8vyFL+6XGEwHS
         apKmyYRQ/3Minuzda/mPpEjoApWAU2ZOf+DFwRL+hJif+0xlxt6DTs5n/qdOwPZr3N/8
         /FSMgm7DeWYfR6gBdWFyi7bgPnfca1O3carhzkNZh6blQAGoqFN/gg99vCtL1NecAKsh
         hUSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmBTJ0Hf7SkY09HK3QcWzg5MLzDGui/zoWtgYGcDFYEPs1AqvgmZhMfuUOMxdbY70O+4zI8ARY5ggl4jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4BgFfiZFyRrxg9zdq2z2HSfvKwA/MCILTKn1OvWuQbyz8xlA8
	8gOzsl7l0nfIYKziF9CV1NCk4S0iUA6p69DJqCDk3Egll1MZSMpribJtREuH78eHn19lJPuqdrG
	E+XRZjg==
X-Google-Smtp-Source: AGHT+IGmZ0F0KObLxBSHlu3SHnlP483NmWhuV4JLZ7ucOE/TKxG1RmC9r56fjS+PXM6PjH97P01ASiU6GEc=
X-Received: from pfbml8.prod.google.com ([2002:a05:6a00:3d88:b0:748:e22c:600c])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f89:b0:742:a77b:8c4
 with SMTP id d2e1a72fcca58-7633227efbcmr22440554b3a.3.1753776798231; Tue, 29
 Jul 2025 01:13:18 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:12:55 -0700
In-Reply-To: <20250729081256.3433892-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729081256.3433892-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729081256.3433892-3-yuzhuo@google.com>
Subject: [PATCH v1 2/3] perf bench: Import ticket_spinlock from kerne
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

Import generic ticket_spinlock implementation.  Updated
tools/perf/check-headers.sh to detect future kernel file changes.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/perf/bench/include/ticket_spinlock.h | 107 +++++++++++++++++++++
 tools/perf/check-headers.sh                |   3 +
 2 files changed, 110 insertions(+)
 create mode 100644 tools/perf/bench/include/ticket_spinlock.h

diff --git a/tools/perf/bench/include/ticket_spinlock.h b/tools/perf/bench/include/ticket_spinlock.h
new file mode 100644
index 000000000000..1d063c99f7cb
--- /dev/null
+++ b/tools/perf/bench/include/ticket_spinlock.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * 'Generic' ticket-lock implementation.
+ *
+ * It relies on atomic_fetch_add() having well defined forward progress
+ * guarantees under contention. If your architecture cannot provide this, stick
+ * to a test-and-set lock.
+ *
+ * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
+ * sub-word of the value. This is generally true for anything LL/SC although
+ * you'd be hard pressed to find anything useful in architecture specifications
+ * about this. If your architecture cannot do this you might be better off with
+ * a test-and-set.
+ *
+ * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
+ * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
+ * a full fence after the spin to upgrade the otherwise-RCpc
+ * atomic_cond_read_acquire().
+ *
+ * The implementation uses smp_cond_load_acquire() to spin, so if the
+ * architecture has WFE like instructions to sleep instead of poll for word
+ * modifications be sure to implement that (see ARM64 for example).
+ *
+ */
+
+#ifndef __ASM_GENERIC_TICKET_SPINLOCK_H
+#define __ASM_GENERIC_TICKET_SPINLOCK_H
+
+#include <linux/atomic.h>
+#include <asm/barrier.h>
+#include <endian.h>
+#include "qspinlock_types.h"
+
+static __always_inline void ticket_spin_lock(arch_spinlock_t *lock)
+{
+	u32 val = atomic_fetch_add(1<<16, &lock->val);
+	u16 ticket = val >> 16;
+
+	if (ticket == (u16)val)
+		return;
+
+	/*
+	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
+	 * custom cond_read_rcsc() here we just emit a full fence.  We only
+	 * need the prior reads before subsequent writes ordering from
+	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
+	 * have no outstanding writes due to the atomic_fetch_add() the extra
+	 * orderings are free.
+	 */
+	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
+	smp_mb();
+}
+
+static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
+{
+	u32 old = atomic_read(&lock->val);
+
+	if ((old >> 16) != (old & 0xffff))
+		return false;
+
+	return atomic_try_cmpxchg(&lock->val, (int *)&old, old + (1<<16)); /* SC, for RCsc */
+}
+
+static __always_inline void ticket_spin_unlock(arch_spinlock_t *lock)
+{
+	u16 *ptr = (u16 *)lock + (__BYTE_ORDER == __BIG_ENDIAN);
+	u32 val = atomic_read(&lock->val);
+
+	smp_store_release(ptr, (u16)val + 1);
+}
+
+static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t lock)
+{
+	u32 val = lock.val.counter;
+
+	return ((val >> 16) == (val & 0xffff));
+}
+
+static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
+{
+	arch_spinlock_t val = READ_ONCE(*lock);
+
+	return !ticket_spin_value_unlocked(val);
+}
+
+static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
+{
+	u32 val = atomic_read(&lock->val);
+
+	return (s16)((val >> 16) - (val & 0xffff)) > 1;
+}
+
+#ifndef __no_arch_spinlock_redefine
+/*
+ * Remapping spinlock architecture specific functions to the corresponding
+ * ticket spinlock functions.
+ */
+#define arch_spin_is_locked(l)		ticket_spin_is_locked(l)
+#define arch_spin_is_contended(l)	ticket_spin_is_contended(l)
+#define arch_spin_value_unlocked(l)	ticket_spin_value_unlocked(l)
+#define arch_spin_lock(l)		ticket_spin_lock(l)
+#define arch_spin_trylock(l)		ticket_spin_trylock(l)
+#define arch_spin_unlock(l)		ticket_spin_unlock(l)
+#endif
+
+#endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index b827b10e19c1..c9f76e3e3d66 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -239,6 +239,9 @@ check_2_sed tools/perf/bench/qspinlock.c		kernel/locking/qspinlock.c	"$qsl_sed"
 	"$qsl_common"' -I EXPORT_SYMBOL -I "^#define lockevent_" -I "^#define trace_" \
         -I smp_processor_id -I atomic_try_cmpxchg_relaxed'
 
+check_2 tools/perf/bench/include/ticket_spinlock.h	include/asm-generic/ticket_spinlock.h \
+	'-I "^#include" -I atomic_try_cmpxchg -I BIG_ENDIAN -B'
+
 for i in "${BEAUTY_FILES[@]}"
 do
   beauty_check "$i" -B
-- 
2.50.1.487.gc89ff58d15-goog


