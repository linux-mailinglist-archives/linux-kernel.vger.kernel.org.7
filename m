Return-Path: <linux-kernel+bounces-720510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE990AFBCB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36683B5C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE96223DF1;
	Mon,  7 Jul 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdlMng6J"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F71E8322
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921059; cv=none; b=YlGzfuNs1gfa6OsbfneXsYeTxk/bS1dwhnBJxRDfB+100y2CVVp7X63KE1kjl7/1Auw1EIn7UF886ZSWw/TJ54vyM5Dtf3K4+y4UIwPFLj5bIst3AjU8DevvjjA6pNYvlXtzMDQGAuznmnq/Xf+fkPkDuCACzCrQc/FvBzy4EH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921059; c=relaxed/simple;
	bh=vtzyhv9a/esCi91sq/GucpYona1JPGP894PNVA+Aruw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kbfi7iyf7S5Uq/X6kvpE+Daux/uzJs+BLUQDAdidZzRbBdUng7PaPIyTnq7XqNQ0Xb365My/dYqvMTNSPdWKx8l3esp5mMVoLX2fvVfjdu5+W7//UbN5hcH3VFQ7C/NuugpINj14kOmgG8NDiot7hMwXvQUS/77MPu+ECtvw6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdlMng6J; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2fb347b3e6so4348319a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751921057; x=1752525857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtamtensSo2O4q2/DkAjxE9NIlfjTtUqP5/1W59cAKQ=;
        b=tdlMng6JPjQMn2friiwjg01ItE+73Gdjdjw8E6TezqrTvxdtZRDUJjEZTuM16dRlVl
         fkhXrxkrUDKmMYlxZ34VLqVleeQRrwHleytTTpRIfiel5yjE7ect50O3xrNu2GqqzQ5M
         ztrFnAuUB4/V5CGMI0IsQbEVZvnAxYfaKGF6OWvEP0UpZXWKWhks8TexkmR+hEGEqAlg
         MwvwLE76AfqvrNTKMtan33DHjnHt5rgA/0JSuLaeMJT3uFFh/ZLabTz+Jui/DL683ayK
         V7VlKabpqLSY74FukhRBJSbUHfU1rEtO5SZaLM7tglHuFGbjnyNxIGdIkY3SsIlt4cxC
         Jd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921057; x=1752525857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtamtensSo2O4q2/DkAjxE9NIlfjTtUqP5/1W59cAKQ=;
        b=ALmr7gfsdbw4dnpTb2tPoN4zuz4/jRiSGg+vRg3lotjEg2Uu3/LraEakpByai4Y04g
         qPRpXztx3OpD1M4bT3kLhFg7DGuc81JdtZjbfK7Ge3ZCyi7l6wtQO2MQZGNSOUmgBliO
         cXy8n+QHpsj25xcAtk25MMHz2JpypUq9qYharwW3OOa2cn0jsQRYWVPCsVY8/NwVh4iz
         5oxPwglAXAbwcNKIVA+rI34DO3WV7+5dZCPcOgh+QKcKdGb/mEIDG04bQTD5mq8sS4p8
         qzsoarPfHd/CD3ALsARKt6JAuQy5TWtebiCM82DnnXEN1x1fOmPp+VYbObFlpzDSFScp
         EIfw==
X-Gm-Message-State: AOJu0YzTBbuZGuHkU8ayKRQ1aAjTlEJdX3LKzyEvbPbfmw2qguiPB/HL
	1dHGqmyAF9h/KJlg3DNwZOkObKFiwB7n2tgdoHl6f0osd/3yu5j7Shjks4eIpIjoa4J8JhDcpWp
	nygliLbgDstd5uiUYD82v0J1s9B7bEzoz8VWl5mzKjlua/fbd78dZFfvKftq/AwFAscaNL5Fq8C
	gOME3h6jX4/un85cTW9CNbbGoalEW3t+jCwOhT19LWjpdYyfSb
X-Google-Smtp-Source: AGHT+IG4FN6+gTahsP4YSBFaxpNQCv9V8b+i4y0+uAiReg1PMGVLD93sWSc6lTngqfi/r0t5ViTPJL40vo9c
X-Received: from pgbda5.prod.google.com ([2002:a05:6a02:2385:b0:b2e:beba:356])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:b98:b0:215:fb74:2dc2
 with SMTP id adf61e73a8af0-22b4214ddabmr855529637.11.1751921057122; Mon, 07
 Jul 2025 13:44:17 -0700 (PDT)
Date: Mon,  7 Jul 2025 20:43:48 +0000
In-Reply-To: <20250707204409.1028494-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707204409.1028494-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707204409.1028494-2-jstultz@google.com>
Subject: [RESEND][PATCH v18 1/8] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
sched_proxy_exec= that can be used to disable the feature at boot
time if CONFIG_SCHED_PROXY_EXEC was enabled.

Also uses this option to allow the rq->donor to be different from
rq->curr.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Switch to CONFIG_SCHED_PROXY_EXEC/sched_proxy_exec= as
  suggested by Metin Kaya.
* Switch boot arg from =disable/enable to use kstrtobool(),
  which supports =yes|no|1|0|true|false|on|off, as also
  suggested by Metin Kaya, and print a message when a boot
  argument is used.
v8:
* Move CONFIG_SCHED_PROXY_EXEC under Scheduler Features as
  Suggested by Metin
* Minor rework reordering with split sched contexts patch
v12:
* Rework for selected -> donor renaming
v14:
* Depend on !PREEMPT_RT to avoid build issues for now
v15:
* Depend on EXPERT while patch series upstreaming is
  in progress.
v16:
* Allow "sched_proxy_exec" without "=true" to enable
  proxy-execution at boot time, in addition to the
  "sched_proxy_exec=true" or "sched_proxy_exec=false" options
  as suggested by Steven
* Drop the "default n" in Kconfig as suggested by Steven
* Add !SCHED_CLASS_EXT dependency until I can investigate if
  sched_ext can understand split contexts, as suggested by
  Peter
v17:
* Expanded the commit message a bit to clarify that the option
  allows the split contexts (rq->donor and rq->curr) to be
  different tasks, from feedback from Juri Lelli

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 include/linux/sched.h                         | 13 +++++++++
 init/Kconfig                                  | 12 ++++++++
 kernel/sched/core.c                           | 29 +++++++++++++++++++
 kernel/sched/sched.h                          | 12 ++++++++
 5 files changed, 71 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9d..5b89464ca570a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6387,6 +6387,11 @@
 	sa1100ir	[NET]
 			See drivers/net/irda/sa1100_ir.c.
 
+	sched_proxy_exec= [KNL]
+			Enables or disables "proxy execution" style
+			solution to mutex-based priority inversion.
+			Format: <bool>
+
 	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52c..ba2a02ead8c7e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1664,6 +1664,19 @@ struct task_struct {
 	randomized_struct_fields_end
 } __attribute__ ((aligned (64)));
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static inline bool sched_proxy_exec(void)
+{
+	return static_branch_likely(&__sched_proxy_exec);
+}
+#else
+static inline bool sched_proxy_exec(void)
+{
+	return false;
+}
+#endif
+
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
 
diff --git a/init/Kconfig b/init/Kconfig
index af4c2f0854554..6844b25303913 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -875,6 +875,18 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config SCHED_PROXY_EXEC
+	bool "Proxy Execution"
+	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
+	depends on !PREEMPT_RT
+	# Need to investigate how to inform sched_ext of split contexts
+	depends on !SCHED_CLASS_EXT
+	# Not particularly useful until we get to multi-rq proxying
+	depends on EXPERT
+	help
+	  This option enables proxy execution, a mechanism for mutex-owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8988d38d46a38..853157b27f384 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static int __init setup_proxy_exec(char *str)
+{
+	bool proxy_enable = true;
+
+	if (*str && kstrtobool(str + 1, &proxy_enable)) {
+		pr_warn("Unable to parse sched_proxy_exec=\n");
+		return 0;
+	}
+
+	if (proxy_enable) {
+		pr_info("sched_proxy_exec enabled via boot arg\n");
+		static_branch_enable(&__sched_proxy_exec);
+	} else {
+		pr_info("sched_proxy_exec disabled via boot arg\n");
+		static_branch_disable(&__sched_proxy_exec);
+	}
+	return 1;
+}
+#else
+static int __init setup_proxy_exec(char *str)
+{
+	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boot time\n");
+	return 0;
+}
+#endif
+__setup("sched_proxy_exec", setup_proxy_exec);
+
 /*
  * Debugging: various feature bits
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295e..6b61e0c7f6e78 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1151,10 +1151,15 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	struct task_struct __rcu	*donor;  /* Scheduling context */
+	struct task_struct __rcu	*curr;   /* Execution context */
+#else
 	union {
 		struct task_struct __rcu *donor; /* Scheduler context */
 		struct task_struct __rcu *curr;  /* Execution context */
 	};
+#endif
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
@@ -1349,10 +1354,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
+{
+	rcu_assign_pointer(rq->donor, t);
+}
+#else
 static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 {
 	/* Do nothing */
 }
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
-- 
2.50.0.727.gbf7dc18ff4-goog


