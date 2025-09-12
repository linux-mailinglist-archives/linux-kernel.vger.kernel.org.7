Return-Path: <linux-kernel+bounces-813222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC9B54221
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA52D189B377
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D92773EC;
	Fri, 12 Sep 2025 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG6JH1dw"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F12727FA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655590; cv=none; b=M5hRPaen5ZzacDKHdVHLZiL4ooYnDxbat89nLhb67Py4643/Il3dtiFg5GvE5s9ioL1yoX+nlVYgWt67I1RrMO4CH6C8Dk9PCoxMCAXUrDaH4PNoOFYoI/JV2KAHviTAqAtrWOqSCS2+MKg7whR29EMo4OuVeRVMHzynUfSbxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655590; c=relaxed/simple;
	bh=MX1w83UOZEf81BM03IWyiKl+JUlUbpTxoo7f/yqQn70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhGCw4iNCFEY0EZa7/ujzUw1W1d8mqjDmhgTRzZ2n8n7HsKEQGNw4kY2FahZK3L7S0rXjhVhKSwVB84QPKs3Qvc1FLEjEftkddEeYH6mNLZMIbGLrDsvU44mYZXrjxwP6Z/FrRrT5EPPXTUXokZMFI9E5CHFhTQmHDbWm5wHGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG6JH1dw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso10685115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757655586; x=1758260386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMrKC6ZHeMB/WtgXy9wnHklNs5TKpDEoxNzIFCdknAM=;
        b=FG6JH1dwU0i2mIzIUXRsAYD1icyuO7HlZG76LWjvEUsbfO0CabL/crpaR/hrX0TXDL
         SaXw1g4e6pNTwFJv1ICnJbF6DxR4dRr8cPgymqWVPrBZ0U/bo3CbIxBmAJMDcXGiM3+Z
         2J4nU66T3JolotdEoJ4C3nsi9ONQZ7y4k8UQq7z7IQociY6xv6pU2u0L89PqQYee2aNz
         1ZKK3Wod0CdBZl6TuY83XLmOZlC4zVQQceFj+6deJ09SSwGfVE7Fcy+pa0E8h7EuUVlB
         5ELMIOVoVodEvCj/kuy35wMVQvCq3hK4PXZXiKpK329su1cSiqPwokkFp44VgEfDEy0j
         MCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757655586; x=1758260386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMrKC6ZHeMB/WtgXy9wnHklNs5TKpDEoxNzIFCdknAM=;
        b=Dqt6w2Po9DOuiMagDhWjS9dLU2M68MOBJaLt/S/1ympd4lyj6hVR1rwLyRnNewjv2m
         mhV4jKJYZ5qtRNDG/RDeA0JWNYV2P7DvaKG3TPVRXWYdM0vTIT+pmmX37cUWh83W+iub
         C1TLAoSAACO44agtaDOPoFxQfnJURWbYKZG7p8BbbNWhyYHM+vnFMQWMRo3MWN7Z5Fbh
         joM8FUTTmN8ilvV3is2ILDNJO3Jyh7D/dFZmI1v0MPZbTTsx4eIYmwm37HqmGkeMormW
         PMhP5wNDlcdYYs3mqzKQLUAbr0fvE+4l0whoI3ZAsQ0IG0g3GkPGCe07Frw4CWJ0NYyC
         O/XA==
X-Forwarded-Encrypted: i=1; AJvYcCWbnuPe+/AxG6E2gLrIfvOJ0lQBI4Bx4uyERUDqBj9elrCxXyGK+O2EtMssWLgI9zgEL3dMNE2/t6MvYIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ94BkY8Qh41LmzspC31ywNPBEDM5LIW/bAsba+k4DZJXaLkC
	IMV4nM04XLArCwELCNt4IoHkoeIvoFs10XoF9zR/z9cj5HFnbTPVnYqd
X-Gm-Gg: ASbGncvT0S2b+dsZjWguH2F2IhyWF1RdsxjevEByS58gfP8biaRiVR1SGEr8YkywdSj
	pdpS9rxNNBaFtAozMMSOp4exBV3kiT7Ont8pFvhVKVkiORVYJE3JdjXuP6NtEe2a0mnkR9hP2fv
	HhwnNWJyAE3hQrn5thJs6r0Q1yJpZrM1s4yx73lilGd1NyBvcp+qaS+nYT8mLJPQBh1vgD8MXvX
	W0LfjEQ5Zj4VJ56jHMPYmE8tKYKiSae6IedkRtjX/V6X0fcAxi00t00UfN8G9GKX+uRRCKT6obL
	cV5/TT6m49rdFodeDiyl0peRpE3b3DyQGPsrrSiPvBBq9TWKhWBvF+AwFGvZ3FM0JDvW93FcBE8
	IEjHFN9Gw7mXMNtqZzh+qblfol7Zdl0Ux8/y9Jy61R1GNZQFC1zaCNQWfss6CAwLbBngy8SKBPK
	NMtp7fTBN0ex3Y
X-Google-Smtp-Source: AGHT+IEtKRq9h5gg5SM1g7UnxI5hucMYOjAikspAs0SIjwI44zIFoqOb9u4cr5bvtZnfQlvAomUbdQ==
X-Received: by 2002:a05:600c:5801:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-45f211d07bdmr10472575e9.14.1757655586340;
        Thu, 11 Sep 2025 22:39:46 -0700 (PDT)
Received: from laptom.homenet.telecomitalia.it ([185.92.96.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd27dsm5032925f8f.41.2025.09.11.22.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:39:45 -0700 (PDT)
From: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
X-Google-Original-From: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
Subject: [PATCH] sched/deadline: Add reporting of runtime left & abs deadline to sched_getattr() for DEADLINE tasks
Date: Fri, 12 Sep 2025 07:38:29 +0200
Message-ID: <20250912053937.31636-2-tommaso.cucinotta@santannapisa.it>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250912053937.31636-1-tommaso.cucinotta@santannapisa.it>
References: <20250912053937.31636-1-tommaso.cucinotta@santannapisa.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCHED_DEADLINE scheduler allows reading the statically configured
run-time, deadline, and period parameters through the sched_getattr()
system call. However, there is no immediate way to access, from user space,
the current parameters used within the scheduler: the instantaneous runtime
left in the current cycle, as well as the current absolute deadline.

The `flags' sched_getattr() parameter, so far mandated to contain zero,
now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=1 flag, to request
retrieval of the leftover runtime and absolute deadline, converted to a
CLOCK_MONOTONIC reference, instead of the statically configured parameters.

This feature is useful for adaptive SCHED_DEADLINE tasks that need to
modify their behavior depending on whether or not there is enough runtime
left in the current period, and/or what is the current absolute deadline.

Notes:
- before returning the instantaneous parameters, the runtime is updated;
- the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
  in CLOCK_MONOTONIC reference; this causes multiple invocations from the
  same period to return values that may differ for a few ns (showing some
  small drift), albeit the deadline doesn't move, in rq_clock() reference;
- the abs deadline value returned to user-space, as unsigned 64-bit value,
  can represent nearly 585 years since boot time;
- setting flags=0 provides the old behavior (retrieve static parameters).

See also the notes from discussion held at OSPM 2025 on the topic
"Making user space aware of current deadline-scheduler parameters".

Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
---
 include/uapi/linux/sched.h |  3 +++
 kernel/sched/deadline.c    | 19 ++++++++++++++++---
 kernel/sched/sched.h       |  2 +-
 kernel/sched/syscalls.c    | 16 +++++++++++-----
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc..52b69ce8 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -146,4 +146,7 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
 
+/* Only for sched_getattr() own flag param, if task is SCHED_DEADLINE */
+#define SCHED_GETATTR_FLAG_DL_DYNAMIC	0x01
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5b64bc62..b1c7c988 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3328,13 +3328,26 @@ void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
 	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 }
 
-void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
+void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
+	struct rq *rq = task_rq(p);
+	u64 adj_deadline;
 
 	attr->sched_priority = p->rt_priority;
-	attr->sched_runtime = dl_se->dl_runtime;
-	attr->sched_deadline = dl_se->dl_deadline;
+	if (flags & SCHED_GETATTR_FLAG_DL_DYNAMIC) {
+		guard(raw_spinlock_irq)(&rq->__lock);
+		update_rq_clock(rq);
+		if (task_current(rq, p))
+			update_curr_dl(rq);
+
+		attr->sched_runtime = dl_se->runtime;
+		adj_deadline = dl_se->deadline - rq_clock(rq) + ktime_get_ns();
+		attr->sched_deadline = adj_deadline;
+	} else {
+		attr->sched_runtime = dl_se->dl_runtime;
+		attr->sched_deadline = dl_se->dl_deadline;
+	}
 	attr->sched_period = dl_se->dl_period;
 	attr->sched_flags &= ~SCHED_DL_FLAGS;
 	attr->sched_flags |= dl_se->flags;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c51..42ddfccb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -353,7 +353,7 @@ extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
 extern int  sched_dl_overflow(struct task_struct *p, int policy, const struct sched_attr *attr);
 extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
-extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
+extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned int flags);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f3..d7eac588 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -928,10 +928,10 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	return -E2BIG;
 }
 
-static void get_params(struct task_struct *p, struct sched_attr *attr)
+static void get_params(struct task_struct *p, struct sched_attr *attr, unsigned int flags)
 {
 	if (task_has_dl_policy(p)) {
-		__getparam_dl(p, attr);
+		__getparam_dl(p, attr, flags);
 	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority = p->rt_priority;
 	} else {
@@ -997,7 +997,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 		return -ESRCH;
 
 	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		get_params(p, &attr);
+		get_params(p, &attr, 0);
 
 	return sched_setattr(p, &attr);
 }
@@ -1082,7 +1082,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	int retval;
 
 	if (unlikely(!uattr || pid < 0 || usize > PAGE_SIZE ||
-		      usize < SCHED_ATTR_SIZE_VER0 || flags))
+		     usize < SCHED_ATTR_SIZE_VER0))
 		return -EINVAL;
 
 	scoped_guard (rcu) {
@@ -1090,6 +1090,12 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		if (!p)
 			return -ESRCH;
 
+		if (flags) {
+			if (!task_has_dl_policy(p) ||
+			    flags != SCHED_GETATTR_FLAG_DL_DYNAMIC)
+				return -EINVAL;
+		}
+
 		retval = security_task_getscheduler(p);
 		if (retval)
 			return retval;
@@ -1097,7 +1103,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		kattr.sched_policy = p->policy;
 		if (p->sched_reset_on_fork)
 			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-		get_params(p, &kattr);
+		get_params(p, &kattr, flags);
 		kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
-- 
2.45.2


