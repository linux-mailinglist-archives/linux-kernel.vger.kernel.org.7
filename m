Return-Path: <linux-kernel+bounces-667881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8261AC8AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BBE3B1D82
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C022489A;
	Fri, 30 May 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="A3BLCd+H"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A24E223DC4
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597554; cv=none; b=kOs4jWXjzjd+V5V9iizfAPjCPWFPNid8wjaPgJ/mw28mDZUTeHMxyEy7WU1XRLDrXFhXqi9C3iH1YH6H+4gmMNTrUF8SCJFzuer+JtIhvdJrAAu54QO1C8iP75RgtdKT7HIB8CZOEp86oXoFEl2QoEqA3fMRTVSo2/nf/aa50lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597554; c=relaxed/simple;
	bh=p7fOy/mpX7DgxiI+SapqF82ZoB9lHQGYA8nT1M0yWa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPtVY/uXf/0CVV8BqSGWFYsodoUDib2KurkA6Qkdwzw2Vggau7bQu1oBhmSs1/dxejmYTkOWc6oklgPz9vLqLvCsqHTjbBJ5Kpxioy1krqADr1KfNuTEnO78dG/YSi8Tar5+act4abdZVpIjQxrJ4QtNFYnGENdgOhTrPFGsknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=A3BLCd+H; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so1337908a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597552; x=1749202352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/EGT89O+ZEiBiVi4yPzaBsD+Uha5lcnizaJutApCU=;
        b=A3BLCd+H0XngyTK/aF3Qe3w7oFLL/TjuuoQLSpAqpevzMPXgXES+cXNeABDMSAxj54
         jnJJob7xXOtFqVanAP1tnKnxxegezSXETfo+yFjgYlpoEhoWrQ70MtCjgii2VPGOkACD
         +qWuJ+yVZmVykAIebhMKB4OkY4V8mNEWJWaeKE6B8MoRkKXXCWoMt2yzGTuIId3eiWNG
         BBku4qA7Sd31bsvfmRnY7hfj7RCLU1m4vbzep0cDBhxBX8nbfipk058dW/RL2cSaSw7Q
         1/ugwCYRTPAO9I+Yg1nstYKXH1V7v5zsR3dThG7ULbqGrk1KlHjAlkabkC6r/6dm/kIe
         fQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597552; x=1749202352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/EGT89O+ZEiBiVi4yPzaBsD+Uha5lcnizaJutApCU=;
        b=jnPANCFP6xZY10q0QKxGJfQRoFfKBmn+p8DS+a29aNfnsn6BwVh6F4ieQni14b/oDx
         BUS1nzXbAS/lK4oR153uTK9/FaKEHrIg43lISZ889V5T8m3i/rybdMJinrYp4e1E1LZi
         BDN/BeWtM4Zv+0ScjDFXqsSgSsikD9UnjrwV9cYDihiyS7XDk2ldIUDmApZqeBWRFkzg
         7ko52plYFcEFVYimlA1h8QRTP1azHd/GTFey4fqvS7vHDcHEpOAhf2QJyHScjuwwswHi
         aloHUEsxodmSS00R+tXfJ0jkpA85ajKGuYG4KzzvFRF2bxrUr8dbwTFly9jWnIsPD53j
         U1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCV9pVa5DwQVr6N4oLMp3iIOovKt3N5MPgCE5OKQ/dhLyhH4GcjHM7zSqO472jD4ts/XqGx9f0RPOOHNWX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwr+aSYiQ8WQOUeAtfs7qi8WXSjScKW93L0JEy/fcuWLtdDPLI
	jdsOkKpxYNHTCoNJJHojJHi+POe0gYXLIvprwiKNhrM3LsCW2WLE31E2smHm+dqY/pw=
X-Gm-Gg: ASbGncsOukfMB5zxIQv2oKv9fmzHy0gBILoMY4mHo8IzwGAIxsND47btTt8gQrUqU78
	VQKi0EbIu1KI39XeuTT+AOajB36otqRxGtuE2QhhlAJ0s+n838lQ1cYkt+9pDTuy/TdVkwimKzI
	JOdqyXYlWwOIysh5nTFOccrLTuXreKXYVEUMQM7JylKVyrEn7XCEDQjJxYf+lLa1+9U2RfxjZLl
	BkiJIpPfXYq6qL+N52GlxERKp96egU9FsWitskS4JbulX9PEQpiDiRumrEB108zAtS0OK+CBM7/
	j9o5IqPhD/nGp/hk5Z6dsJLCbh8wCNHjuP7TtNhkPyKjG2UI8boMu7+fwarGWy7cTc3GGB1zdfm
	vXz1TzmD1lA==
X-Google-Smtp-Source: AGHT+IHBBO2+1F1DkG3gsf9hrt/klQKja6FHxL7s2ecvsv49mNDcLA/dM81wOfpp/PHgMJRmMz0RTg==
X-Received: by 2002:a17:90b:3dce:b0:311:baa0:89ca with SMTP id 98e67ed59e1d1-31241e98d1bmr3478119a91.34.1748597552297;
        Fri, 30 May 2025 02:32:32 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.32.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:32:32 -0700 (PDT)
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
Subject: [RFC v2 16/35] RPAL: add cpu lock interface
Date: Fri, 30 May 2025 17:27:44 +0800
Message-Id: <8ff6cea94a6438a0856c86a11d56be462314b1f8.1748594841.git.libo.gcs85@bytedance.com>
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

Lazy switch enables the kernel to switch from one task to another to keep
the kernel context and user context matched. For the scheduler, both tasks
involved in the context switch must reside in the same run queue (rq).
Therefore, before a lazy switch occurs, the kernel must first bind both
tasks to the same CPU to facilitate the subsequent context switch.

This patch introduces the rpal_lock_cpu() interface, which binds two tasks
to the same CPU while bypassing cpumask restrictions. The rpal_unlock_cpu()
function serves as the inverse operation to release this binding. To ensure
consistency, the kernel must prevent other threads from modifying the CPU
affinity of tasks locked by rpal_lock_cpu(). Therefore, when using
set_cpus_allowed_ptr() to change a task's CPU affinity, other threads must
wait until the binding established by rpal_lock_cpu() is released before
proceeding with modifications.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/core.c   |  18 +++++++
 arch/x86/rpal/thread.c |  14 ++++++
 include/linux/rpal.h   |   8 +++
 kernel/sched/core.c    | 109 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 61f5d40b0157..c185a453c1b2 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -15,6 +15,24 @@ int __init rpal_init(void);
 bool rpal_inited;
 unsigned long rpal_cap;
 
+static inline void rpal_lock_cpu(struct task_struct *tsk)
+{
+	rpal_set_cpus_allowed_ptr(tsk, true);
+	if (unlikely(!irqs_disabled())) {
+		local_irq_disable();
+		rpal_err("%s: irq is enabled\n", __func__);
+	}
+}
+
+static inline void rpal_unlock_cpu(struct task_struct *tsk)
+{
+	rpal_set_cpus_allowed_ptr(tsk, false);
+	if (unlikely(!irqs_disabled())) {
+		local_irq_disable();
+		rpal_err("%s: irq is enabled\n", __func__);
+	}
+}
+
 int __init rpal_init(void)
 {
 	int ret = 0;
diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
index e50a4c865ff8..bc203e9c6e5e 100644
--- a/arch/x86/rpal/thread.c
+++ b/arch/x86/rpal/thread.c
@@ -47,6 +47,10 @@ int rpal_register_sender(unsigned long addr)
 	}
 
 	rpal_common_data_init(&rsd->rcd);
+	if (rpal_init_thread_pending(&rsd->rcd)) {
+		ret = -ENOMEM;
+		goto free_rsd;
+	}
 	rsd->rsp = rsp;
 	rsd->scc = (struct rpal_sender_call_context *)(addr - rsp->user_start +
 						       rsp->kernel_start);
@@ -58,6 +62,8 @@ int rpal_register_sender(unsigned long addr)
 
 	return 0;
 
+free_rsd:
+	kfree(rsd);
 put_shared_page:
 	rpal_put_shared_page(rsp);
 out:
@@ -77,6 +83,7 @@ int rpal_unregister_sender(void)
 
 	rpal_put_shared_page(rsd->rsp);
 	rpal_clear_current_thread_flag(RPAL_SENDER_BIT);
+	rpal_free_thread_pending(&rsd->rcd);
 	kfree(rsd);
 
 	atomic_dec(&cur->thread_cnt);
@@ -116,6 +123,10 @@ int rpal_register_receiver(unsigned long addr)
 	}
 
 	rpal_common_data_init(&rrd->rcd);
+	if (rpal_init_thread_pending(&rrd->rcd)) {
+		ret = -ENOMEM;
+		goto free_rrd;
+	}
 	rrd->rsp = rsp;
 	rrd->rcc =
 		(struct rpal_receiver_call_context *)(addr - rsp->user_start +
@@ -128,6 +139,8 @@ int rpal_register_receiver(unsigned long addr)
 
 	return 0;
 
+free_rrd:
+	kfree(rrd);
 put_shared_page:
 	rpal_put_shared_page(rsp);
 out:
@@ -147,6 +160,7 @@ int rpal_unregister_receiver(void)
 
 	rpal_put_shared_page(rrd->rsp);
 	rpal_clear_current_thread_flag(RPAL_RECEIVER_BIT);
+	rpal_free_thread_pending(&rrd->rcd);
 	kfree(rrd);
 
 	atomic_dec(&cur->thread_cnt);
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 4f4719bb7eae..5b115be14a55 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -99,6 +99,7 @@ extern unsigned long rpal_cap;
 enum rpal_task_flag_bits {
 	RPAL_SENDER_BIT,
 	RPAL_RECEIVER_BIT,
+	RPAL_CPU_LOCKED_BIT,
 };
 
 enum rpal_receiver_state {
@@ -270,8 +271,12 @@ struct rpal_shared_page {
 struct rpal_common_data {
 	/* back pointer to task_struct */
 	struct task_struct *bp_task;
+	/* pending struct for cpu locking */
+	void *pending;
 	/* service id of rpal_service */
 	int service_id;
+	/* cpumask before locked */
+	cpumask_t old_mask;
 };
 
 struct rpal_receiver_data {
@@ -464,4 +469,7 @@ struct mm_struct *rpal_pf_get_real_mm(unsigned long address, int *rebuild);
 extern void rpal_pick_mmap_base(struct mm_struct *mm,
 	struct rlimit *rlim_stack);
 int rpal_try_to_wake_up(struct task_struct *p);
+int rpal_init_thread_pending(struct rpal_common_data *rcd);
+void rpal_free_thread_pending(struct rpal_common_data *rcd);
+int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045e92ee2e3b..a862bf4a0161 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3155,6 +3155,104 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 	return ret;
 }
 
+#ifdef CONFIG_RPAL
+int rpal_init_thread_pending(struct rpal_common_data *rcd)
+{
+	struct set_affinity_pending *pending;
+
+	pending = kzalloc(sizeof(*pending), GFP_KERNEL);
+	if (!pending)
+		return -ENOMEM;
+	pending->stop_pending = 0;
+	pending->arg = (struct migration_arg){
+		.task = current,
+		.pending = NULL,
+	};
+	rcd->pending = pending;
+	return 0;
+}
+
+void rpal_free_thread_pending(struct rpal_common_data *rcd)
+{
+	if (rcd->pending != NULL)
+		kfree(rcd->pending);
+}
+
+/*
+ * CPU lock is forced and all cpumask will be ignored by RPAL temporary.
+ */
+int rpal_set_cpus_allowed_ptr(struct task_struct *p, bool is_lock)
+{
+	const struct cpumask *cpu_valid_mask = cpu_active_mask;
+	struct set_affinity_pending *pending = p->rpal_cd->pending;
+	struct cpumask mask;
+	unsigned int dest_cpu;
+	struct rq_flags rf;
+	struct rq *rq;
+	int ret = 0;
+	struct affinity_context ac = {
+		.new_mask = &mask,
+		.flags = 0,
+	};
+
+	if (unlikely(p->flags & PF_KTHREAD))
+		rpal_err("p: %d, p->flags & PF_KTHREAD\n", p->pid);
+
+	rq = task_rq_lock(p, &rf);
+
+	if (is_lock) {
+		cpumask_copy(&p->rpal_cd->old_mask, &p->cpus_mask);
+		cpumask_clear(&mask);
+		cpumask_set_cpu(smp_processor_id(), &mask);
+		rpal_set_task_thread_flag(p, RPAL_CPU_LOCKED_BIT);
+	} else {
+		cpumask_copy(&mask, &p->rpal_cd->old_mask);
+		rpal_clear_task_thread_flag(p, RPAL_CPU_LOCKED_BIT);
+	}
+
+	update_rq_clock(rq);
+
+	if (cpumask_equal(&p->cpus_mask, ac.new_mask))
+		goto out;
+	/*
+	 * Picking a ~random cpu helps in cases where we are changing affinity
+	 * for groups of tasks (ie. cpuset), so that load balancing is not
+	 * immediately required to distribute the tasks within their new mask.
+	 */
+	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ac.new_mask);
+	if (dest_cpu >= nr_cpu_ids) {
+		ret = -EINVAL;
+		goto out;
+	}
+	__do_set_cpus_allowed(p, &ac);
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+		preempt_disable();
+		task_rq_unlock(rq, p, &rf);
+		preempt_enable();
+	} else {
+		pending->arg.dest_cpu = dest_cpu;
+
+		if (task_on_cpu(rq, p) ||
+		    READ_ONCE(p->__state) == TASK_WAKING) {
+			preempt_disable();
+			task_rq_unlock(rq, p, &rf);
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		} else {
+			if (task_on_rq_queued(p))
+				rq = move_queued_task(rq, &rf, p, dest_cpu);
+			task_rq_unlock(rq, p, &rf);
+		}
+	}
+
+	return 0;
+
+out:
+	task_rq_unlock(rq, p, &rf);
+	return ret;
+}
+#endif
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -3169,7 +3267,18 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
 	struct rq_flags rf;
 	struct rq *rq;
 
+#ifdef CONFIG_RPAL
+retry:
+	rq = task_rq_lock(p, &rf);
+	if (rpal_test_task_thread_flag(p, RPAL_CPU_LOCKED_BIT)) {
+		update_rq_clock(rq);
+		task_rq_unlock(rq, p, &rf);
+		schedule();
+		goto retry;
+	}
+#else
 	rq = task_rq_lock(p, &rf);
+#endif
 	/*
 	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
 	 * flags are set.
-- 
2.20.1


