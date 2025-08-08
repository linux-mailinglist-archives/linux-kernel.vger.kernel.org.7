Return-Path: <linux-kernel+bounces-760711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF3B1EF24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021207A69C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2011A23BCED;
	Fri,  8 Aug 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqYX0x1a"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64222068F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683413; cv=none; b=SqY1910pgAU3tR28diuyk1Ni2I85LRonAglv9/3kAinx0bk2OhIOURCT/kzR50PqxrN1Ifp9kwNT8Ub8UtlKhGD8OgSI81770cuvMEcLkiBernOdwhgmtSRyFtEfGrJo34jpSwbwDsuSaJ9AgiymQouYoj40cWAI1CI2Stj5sCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683413; c=relaxed/simple;
	bh=NsA/CAR+RtyCAfhqNwO/OEoxhBdFN+ZLJMUpUfq+R8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YtHcwZLZkepzexfEhu4RDqZkQQHq64H6RKuyVhmdDFJRisZfs/JDaV0GbULcb4DH+tqfWycyXfzgvCn0wcOb50OUTC7tky3yrO2BWxs+PtDV4Dh25jYP/vSYtQNBNcLun4yqEGuRspNOb5ClBzsx0PnUh6pc8RlbfFlalNxbnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqYX0x1a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-458c0c8d169so12706705e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754683410; x=1755288210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5OtIhhKwZ5LIpMwZNc9pJdMveQzWwOLEkahic0/q3KU=;
        b=vqYX0x1aW7cdz3UZEIM3LQ0Qb8/8eHRmZeZZC5P26mWPRFQSV5syBEa6cC1IMItLjN
         i/pP8INzxj3u4+r6fgIzrdIVLTtpV/8ryzqBE2GDfWudvFosx21daoA6VzGqVBmOFNLq
         sLnfOeCJYLGLNixN3K5aM8ICOln6ZuV/onUnxsaHTUDUl2JN+7TZuBO5ED1HX26eZZ1h
         XZv0zB3P3WXcxO4kKquz24SnXYo7IXfhSjJYJLBryRtf1Is/o0M/+iAHOUUtKhKytTxk
         xX3DaFxTqdtQkcgXgMNli2g548ryuSZOJOTcESyQKu2g8KbG6bTOCQP3Wtp793YPfqNS
         UVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683410; x=1755288210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OtIhhKwZ5LIpMwZNc9pJdMveQzWwOLEkahic0/q3KU=;
        b=ONJXqOWZU/V49UGy+juuvf3VWEatLLn6HPS9h/VE0lunfPM2GeXYKUEe/npWgEFUtu
         dxyic+Jtg/GRHKudHWKeMVHabomA7ZvrRYyFRvtOynUkhtGypNq4k9gBkuHBItQEXcUP
         zkw7VHyiej0zSdstRiC6wBJ/2pyvsMn7JL/KA6c/uQDMPGYglesC2X98kmjZWb0SvCUs
         kkD3NV2Ad20QBa3KK27/zn+h3Y3lpc+75nf4K9dRzsvIY36+vgqOy0zK+6T9BhTJTjmX
         XhKt0oiLdsVh1OkOGne49Xq/2GJM71Zp7QZXmgNQKJPtrYVv8AT6DtdA3/DqHS40OndR
         4BLQ==
X-Gm-Message-State: AOJu0Ywa1bg4/HSjgSr1rB/lFZnfBHIniT9I6CfR/akB5OXaLMlKSbft
	4PoSZroLQUNc7EnfTQ9VjPduOzwbPrGtkZ8XQ6pNC1630H76Ao0tzDSP/x5OWsg5iRTJYCq/Wbo
	mwvMNDzGBq0iWRQ==
X-Google-Smtp-Source: AGHT+IFhEHRHvFN07ovdSLruJEqx2ftiwQyIcjpEWdBXuq9L2w9g3BjJDajHTGgVHcgWzbhDZDXtlsQ4ywyR2g==
X-Received: from wmsr8.prod.google.com ([2002:a05:600c:8b08:b0:459:ddf8:fed5])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:840f:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-459f4eba76amr37936965e9.8.1754683409865;
 Fri, 08 Aug 2025 13:03:29 -0700 (PDT)
Date: Fri,  8 Aug 2025 20:02:50 +0000
In-Reply-To: <20250808200250.2016584-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808200250.2016584-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250808200250.2016584-4-jpiecuch@google.com>
Subject: [RFC PATCH 3/3] sched/fair: add debugfs knob for yield throttling
From: Kuba Piecuch <jpiecuch@google.com>
To: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, joshdon@google.com
Cc: linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

yield_interval_ns specifies the interval within which any given thread
is allowed to yield at most once. Subsequent calls to sched_yield()
within the interval simply return without calling schedule().

Allowing unlimited calls to sched_yield() allows for DoS-like behavior
because threads can continually call into schedule() which results in
various types of contention.

For example, if a process has a profiling timer enabled, every call to
update_curr() results in an atomic add to a shared process-wide variable
p->signal->cputimer->cputime_atomic.sum_exec_runtime, performed in
account_group_exec_runtime().

In a synthetic benchmark consisting of 80 threads (2 per core) calling
sched_yield() in a busy loop with a profiling timer enabled, we have
observed that ~80% of CPU time is spent in the single atomic add
instruction. Setting yield_interval_ns to 10000 lowers that percentage
to 1-2%, at the cost of decreasing the total number yields that end up
calling schedule() by ~60%. The benchmark was run on an Intel Emerald
Rapids CPU with 60 physical cores.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   |  1 +
 kernel/sched/debug.c  |  2 ++
 kernel/sched/fair.c   | 29 +++++++++++++++++++++++++++++
 kernel/sched/sched.h  |  2 ++
 5 files changed, 36 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index aa9c5be7a6325..c637025792fc6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -946,6 +946,8 @@ struct task_struct {
 
 	struct sched_info		sched_info;
 
+	ktime_t last_yield;
+
 	struct list_head		tasks;
 #ifdef CONFIG_SMP
 	struct plist_node		pushable_tasks;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81c6df746df17..acc87c9ff5681 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4493,6 +4493,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	p->on_rq			= 0;
 
+	p->last_yield			= ktime_set(0, 0);
 	p->se.on_rq			= 0;
 	p->se.exec_start		= 0;
 	p->se.sum_exec_runtime		= 0;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 557246880a7e0..93d2c988d491d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -512,6 +512,8 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
 	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
 
+	debugfs_create_u32("yield_interval_ns", 0644, debugfs_sched, &sysctl_sched_yield_interval);
+
 #ifdef CONFIG_SMP
 	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
 	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3f9bfc64e0bc5..39ca52128f502 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -81,6 +81,18 @@ static unsigned int normalized_sysctl_sched_base_slice	= 700000ULL;
 
 __read_mostly unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+/*
+ * This interval controls how often a given CFS thread can yield.
+ * A given thread can only yield once within this interval.
+ * The throttling is accomplished by making calls to sched_yield() return
+ * without actually calling schedule().
+ * A value of 0 means yields are not throttled.
+ *
+ * (default: 0, units: nanoseconds)
+ */
+__read_mostly unsigned int sysctl_sched_yield_interval;
+
+
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
 	pr_warn("Ignoring the deprecated sched_thermal_decay_shift= option\n");
@@ -9015,6 +9027,7 @@ static bool yield_task_fair(struct rq *rq)
 	struct task_struct *curr = rq->curr;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
+	ktime_t now, throttle_end_time;
 
 	/*
 	 * Are we the only task in the tree?
@@ -9024,6 +9037,22 @@ static bool yield_task_fair(struct rq *rq)
 
 	clear_buddies(cfs_rq, se);
 
+	if (unlikely(sysctl_sched_yield_interval)) {
+		/*
+		 * Limit how often a given thread can call schedule() via
+		 * sched_yield() to once every sysctl_sched_yield_interval
+		 * nanoseconds.
+		 */
+		now = ktime_get();
+		throttle_end_time = ktime_add_ns(curr->last_yield,
+						 sysctl_sched_yield_interval);
+
+		if (unlikely(ktime_before(now, throttle_end_time)))
+			return false;
+
+		curr->last_yield = now;
+	}
+
 	update_rq_clock(rq);
 	/*
 	 * Update run-time statistics of the 'current'.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8b2cd54a09942..14e3d90b0df0e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2827,6 +2827,8 @@ extern __read_mostly unsigned int sysctl_sched_migration_cost;
 
 extern unsigned int sysctl_sched_base_slice;
 
+extern __read_mostly unsigned int sysctl_sched_yield_interval;
+
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


