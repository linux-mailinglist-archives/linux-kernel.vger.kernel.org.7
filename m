Return-Path: <linux-kernel+bounces-667905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6CAC8B33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7663B038F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DD22A800;
	Fri, 30 May 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FU4Xbg5J"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC7922A1EF
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597814; cv=none; b=Fv/hMe8PKkMhNyTI5O00KTZ3zvXyRhR7jLBjpvT5CcyZPmwbZ/H5O6SGKdM0dPOYQsG0TCNQ4ohUlf5G1L6mFbONTUIfRdjoVsuk/XCIkgHztbP7xBMgyeM1PfAKeNdYwkVza8TTA+sxgT6SwTAbPkEOwXZLLEubc5j+2cLJgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597814; c=relaxed/simple;
	bh=vd2C1pogQV46JqBd4R9eC8WzEgBwL6DtuQBJbThvcY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eqhh6pGm2FuiK8BDS+ZNGS8WnbibuWQWMzQrENS458oiLS1kkbqqP6qDGCZjl+PqjIeNqtIE30po1Jitgq8Q7k9i1koVRcr5q3lGeGTrC8HqmcMDxudPGzo1vIcLyh3SizmqltGvdh1Py+HFFupSG0skC/GE/MjCi+6REwvV0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FU4Xbg5J; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c4476d381so1642540a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597811; x=1749202611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GWxjqZwkmZx5+2pv+QLtRl8XC71PyQccoyY/dIwUoU=;
        b=FU4Xbg5JkXTsWoP2NVMq4T/VCUnkpyQejsiTEHcl2yure2y1mHWmP11exSYEnJdlhr
         /FdE7deI2fUaaELz2MqqcsRNahTIaO9I5G1zsgunOCTERvqf58se7Ho9IIgJDjnYAxi2
         T0TsibJyUU0LBKhdDjzJXKG7kkB+JQFLDHuReD4ILaEK0GDJSFiA+fa2tB3r8vTZUR/o
         AGu+W8mrucLYHMnK6b1vbLdNWCa7l3DxnM50Tpq1jlH5jog99k7Vxn3tu36uVfDCA+sa
         HnQw/Oz4L9eF55h0FXhU1zh/9gZRxIYBxVCFyNGqJZmBCq4jRmW/K+4vgzNbw8kuEo5X
         Jm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597811; x=1749202611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GWxjqZwkmZx5+2pv+QLtRl8XC71PyQccoyY/dIwUoU=;
        b=hNxHvdUNAbghhdVrTAy21aOXHUeQ1xOwluJ92P43wB3Q6BpZc0qmUJ7E4dXdpHPfvy
         ObguWz9jv0z9rZbEAtYHRPhsfTHNkbY47ViYJTIhxsIw989o2nAXkNMv7/69tilQs478
         mB6NUqY8xSF5mJ8NfoGdBNPTyeefWutFc/GMca0iLMqZdyOPXyCllEedfroi6VoVFiek
         lzSj8hcLOEGIDcgAnxlYMMmkwCcfftuXmRD/YT4wW/KatJsAIKNPI4He0ZwCjtJb1e3U
         ReXmxSeuaQxast8SQZTJGDPFqS1M4s0zx8O532UUArgRYZvbLhzJwpd0PfQ2SzgJdaqZ
         6vfg==
X-Forwarded-Encrypted: i=1; AJvYcCUPCK7HgxMc1HXLcUPE0UGAgtJhz7wz05KLB4CcbwJcgA5Me59Xn+k5F/eKcYHAYk7mMUPPG0imn7OhhTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yn7WZJWf4XNtGpsfVs0zEk+bCdyFVY0Mdh5hvI2erzr1EFIT
	FC7kwdzZaJx5zydAHnP+O6bBtppTNPAZUQ246lDr8hZBnxtDpslRAT5Q6W6SuyyVtJ0=
X-Gm-Gg: ASbGncukCnINC8LyxP+MZ8LnwfwyIO+5s7olYaKLEN4QyPdtowSnfQNlOQrB/Zgr3DN
	8GU02p7mVo6RP2d4Qb+SIRWopH+VsMlBE4a4HF4zEfcsPgtf6mN7J5nVbNC4widDBIINBc1ldnf
	JpR4WjUlMTtCqCXaZXgwxC+orsMCqJadIngsrcqAgbWLg/9HY1wKM1Z1tZxT8aySMSj+cEjkmYe
	ppnYTYuIqekMJ5Xkh/iTAW/Uv4k+lo/2bx2u3fQ9Tl91HGjv/abBvJdaW0RXSmQSYcBppJ8+MKE
	NpYcZEr2wx8mEauvOQljWGH/MyzyCjQ4UEwk3hn1GRGdtdAWx9/xm+DhQIJp9D20Vx2WIoZs0tu
	EOcgTqZSVJA==
X-Google-Smtp-Source: AGHT+IEd6eqw3bYsn2JQr9oo7VNa3bHRe5ESaa02VpYg0eRHeS5gGe9cNS3vRZsm3BzNT8I7hOudjA==
X-Received: by 2002:a17:90b:5104:b0:302:fc48:4f0a with SMTP id 98e67ed59e1d1-3124446ce79mr4391987a91.0.1748597811484;
        Fri, 30 May 2025 02:36:51 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.36.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:36:51 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 33/35] RPAL: enable time slice correction
Date: Fri, 30 May 2025 17:28:01 +0800
Message-Id: <8941a17e12edce00c1cc1c78f4dd3e1bf28e47c0.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After an RPAL call, the receiver's user mode code executes. However, the
kernel incorrectly attributes this CPU time to the sender due to the
unchanged kernel context. This results in incorrect runtime statistics.

This patch adds a new member total_time to both rpal_sender_call_context
and rpal_receiver_call_context. This member tracks how much runtime (
measured in CPU cycles via rdtsc()) has been incorrectly accounted for.
The kernel measures total_time at the entry of __schedule() and corrects
the delta in the update_rq_clock_task() function.

Additionally, since RPAL calls occur in user space, runtime statistics are
typically calculated by user space. However, when a lazy switch happens,
the kernel takes over. To address this, the patch introduces a start_time
member to record when an RPAL call is initiated, enabling the kernel to
accurately calculate the runtime that needs correction.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/core.c   |  8 ++++++++
 arch/x86/rpal/thread.c |  6 ++++++
 include/linux/rpal.h   |  3 +++
 include/linux/sched.h  |  1 +
 init/init_task.c       |  1 +
 kernel/fork.c          |  1 +
 kernel/sched/core.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 62 insertions(+)

diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 92281b557a6c..2ac5d932f69c 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -144,6 +144,13 @@ rpal_do_kernel_context_switch(struct task_struct *next, struct pt_regs *regs)
 	struct task_struct *prev = current;
 
 	if (rpal_test_task_thread_flag(next, RPAL_LAZY_SWITCHED_BIT)) {
+		struct rpal_receiver_call_context *rcc = next->rpal_rd->rcc;
+		struct rpal_sender_call_context *scc = current->rpal_sd->scc;
+		u64 slice = rdtsc_ordered() - scc->start_time;
+
+		rcc->total_time += slice;
+		scc->total_time += slice;
+
 		rpal_resume_ep(next);
 		current->rpal_sd->receiver = next;
 		rpal_lock_cpu(current);
@@ -169,6 +176,7 @@ rpal_do_kernel_context_switch(struct task_struct *next, struct pt_regs *regs)
 		rpal_schedule(next);
 		rpal_clear_task_thread_flag(prev, RPAL_LAZY_SWITCHED_BIT);
 		prev->rpal_rd->sender = NULL;
+		next->rpal_sd->scc->start_time = rdtsc_ordered();
 	}
 	if (unlikely(!irqs_disabled())) {
 		local_irq_disable();
diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
index 51c9eec639cb..5cd0be631521 100644
--- a/arch/x86/rpal/thread.c
+++ b/arch/x86/rpal/thread.c
@@ -99,6 +99,8 @@ int rpal_register_sender(unsigned long addr)
 	rsd->scc = (struct rpal_sender_call_context *)(addr - rsp->user_start +
 						       rsp->kernel_start);
 	rsd->receiver = NULL;
+	rsd->scc->start_time = 0;
+	rsd->scc->total_time = 0;
 
 	current->rpal_sd = rsd;
 	rpal_set_current_thread_flag(RPAL_SENDER_BIT);
@@ -182,6 +184,7 @@ int rpal_register_receiver(unsigned long addr)
 		(struct rpal_receiver_call_context *)(addr - rsp->user_start +
 						      rsp->kernel_start);
 	rrd->sender = NULL;
+	rrd->rcc->total_time = 0;
 
 	current->rpal_rd = rrd;
 	rpal_set_current_thread_flag(RPAL_RECEIVER_BIT);
@@ -289,6 +292,9 @@ int rpal_rebuild_sender_context_on_fault(struct pt_regs *regs,
 				rpal_pkey_to_pkru(rpal_current_service()->pkey),
 				RPAL_PKRU_SET);
 #endif
+			if (!rpal_is_correct_address(rpal_current_service(), regs->ip))
+				/* receiver has crashed */
+				scc->total_time += rdtsc_ordered() - scc->start_time;
 			return 0;
 		}
 	}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 1d8c1bdc90f2..f5f4da63f28c 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -310,6 +310,7 @@ struct rpal_receiver_call_context {
 	void __user *events;
 	int maxevents;
 	int timeout;
+	int64_t total_time;
 };
 
 /* recovery point for sender */
@@ -325,6 +326,8 @@ struct rpal_sender_call_context {
 	struct rpal_task_context rtc;
 	struct rpal_error_context ec;
 	int sender_id;
+	s64 start_time;
+	s64 total_time;
 };
 
 /* End */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5f25cc09fb71..a03113fecdc5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1663,6 +1663,7 @@ struct task_struct {
 		struct rpal_sender_data *rpal_sd;
 		struct rpal_receiver_data *rpal_rd;
 	};
+	s64 rpal_steal_time;
 #endif
 
 	/* CPU-specific state of this task: */
diff --git a/init/init_task.c b/init/init_task.c
index 2eb08b96e66b..3606cf701dfe 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -224,6 +224,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.rpal_rs = NULL,
 	.rpal_flag = 0,
 	.rpal_cd = NULL,
+	.rpal_steal_time = 0,
 #endif
 };
 EXPORT_SYMBOL(init_task);
diff --git a/kernel/fork.c b/kernel/fork.c
index 11cba74d07c8..ff6331a28987 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1222,6 +1222,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->rpal_rs = NULL;
 	tsk->rpal_flag = 0;
 	tsk->rpal_cd = NULL;
+	tsk->rpal_steal_time = 0;
 #endif
 	return tsk;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c219ada29d34..d6f8e0d76fc0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -789,6 +789,14 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 		delta -= steal;
 	}
 #endif
+#ifdef CONFIG_RPAL
+	if (unlikely(current->rpal_steal_time != 0)) {
+		delta += current->rpal_steal_time;
+		if (unlikely(delta < 0))
+			delta = 0;
+		current->rpal_steal_time = 0;
+	}
+#endif
 
 	rq->clock_task += delta;
 
@@ -6872,6 +6880,36 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	return true;
 }
 
+#ifdef CONFIG_RPAL
+static void rpal_acct_runtime(void)
+{
+	if (rpal_current_service()) {
+		if (rpal_test_task_thread_flag(current, RPAL_SENDER_BIT) &&
+		    current->rpal_sd->scc->total_time != 0) {
+			struct rpal_sender_call_context *scc =
+				current->rpal_sd->scc;
+
+			u64 slice =
+				native_sched_clock_from_tsc(scc->total_time) -
+				native_sched_clock_from_tsc(0);
+			current->rpal_steal_time -= slice;
+			scc->total_time = 0;
+		} else if (rpal_test_task_thread_flag(current,
+						      RPAL_RECEIVER_BIT) &&
+			   current->rpal_rd->rcc->total_time != 0) {
+			struct rpal_receiver_call_context *rcc =
+				current->rpal_rd->rcc;
+
+			u64 slice =
+				native_sched_clock_from_tsc(rcc->total_time) -
+				native_sched_clock_from_tsc(0);
+			current->rpal_steal_time += slice;
+			rcc->total_time = 0;
+		}
+	}
+}
+#endif
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6926,6 +6964,10 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq *rq;
 	int cpu;
 
+#ifdef CONFIG_RPAL
+	rpal_acct_runtime();
+#endif
+
 	trace_sched_entry_tp(preempt, CALLER_ADDR0);
 
 	cpu = smp_processor_id();
-- 
2.20.1


