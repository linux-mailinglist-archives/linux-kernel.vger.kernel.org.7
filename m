Return-Path: <linux-kernel+bounces-852029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211C1BD7FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF3118A35A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA72BFC8F;
	Tue, 14 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ18CaUv"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9CE10E0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427810; cv=none; b=HQmuMAAHPUO6SzTDEd41sUDN7R27KVYfRiUyRIp6yG9svjT4q+GPmPolbkMeoJ3I9OSFCuhFeXQcMlqe3Qnep6tqSsbPoEKqOfofohjbZb07hZYtKUnETRNw1O+5tpc578Jwxpue1DPqszUf/yLsaqZICy9JRqhFpSfj73DJw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427810; c=relaxed/simple;
	bh=3qHaE9tBSqwFcYac8g9XB/FdheXHOPN2wDFOBo5X6wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzFyL6c+1M0nq9eVNMHc8Eb4YzO9UdVGBXpBxi5QDdx2m9wdDzapWBMDndUpRvxjA2lF5JgMMrUW/N6HSupNN8jxQeWoDNnhrI90dMIJ8w9KqoBLw82hr0gxVjqaZvoUwK8dWdDq0lm9sujsk/kcNKhQvboUCJUyc66EGVmeSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ18CaUv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b55517e74e3so5531741a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760427808; x=1761032608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMxe1fu9SNqNuqtpuFB1b7agW+KhZuKja11JUM838r8=;
        b=IQ18CaUv8dcHGN3JuzJN9DK4kF+/baOKJRyouzYtniVi/wd4k35TuQZz6yYdPaxlT5
         w2+jlSjsUUb5vwSEiCyL40axLA1MvBF7OX1olg7EeOHC7gX8s4fv//z3ZPNZCeIzD5pG
         MaTlXm1EDmxNbMYZL/sektMLlFDKXlYr/r/BhtmldgRfxzFpoD3jwXFNjVM/81xOoSUU
         7WYHQy7+4hh4NSXZ9NUw0SemUi2YzLmRkBjag2fTdz72QsIgxlKyNiz2TDwZbIHh9r1Y
         sqFp3WK6uGTaACO1IeVAiVe7RjLcNULsj0DrDZFH+UOb1luLFVewYbXTsVdhgtqiKsrk
         i4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427808; x=1761032608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMxe1fu9SNqNuqtpuFB1b7agW+KhZuKja11JUM838r8=;
        b=WIwtdGuOJsSDzN2NhnuFZsEpKW2Fy8GOPUQ/a+HCeRx2zRESEBhc6kHyK4M7Y535Z3
         lotZlIhBNaHK8AGKu3JaiAZUJspfyqb+xnoCEcD2K0iGiI5te/9+aWk2U2xjhYvoVBiz
         DVhUtgGsHH2rb+1ya3sW3dbfIcrOtFxkvRE+bf8H2ov/UChsuJuEP7868M4W0t9Mnwsc
         4WJbexXty6OnAT5284Bu9xYahgBfvSA5kWPfYoBHW+EwroTinW0R0KuLrnzcE76mqFZE
         9ZR/+23EMdi2MGWATbWIiZV/7RxQsAkpdVpkFpBV3GBty88K4zJ6AuTHOhMyyhzDHzrn
         d3HQ==
X-Gm-Message-State: AOJu0Yx5/VRBxHbhnLmL/nqIs0Ve6O+udC20mLRbRA2d0XYEPAKOAZeF
	rTO2vdC2Prly21GKju5JOteNQMBkXBc62OfGIWQHj8CFuRYmLOJvMQUB
X-Gm-Gg: ASbGncsaSpXhscq5Vfxr0dl3mTYN4BbrFYZQY0CMOdihWpNLSzuuPtWLnXQR8aoinNb
	Fyz12VDAjwAeEKRyySCLZLro0/p0efSuXEY16C9ouiVIVD42SneFc4aI6MpqSchCGbZHQjzaiAO
	ggPn+oQRLbqMryYfZhIDdGnzcJgJ/Xw9W04i/cFNHfMleRa++c48ZMPOgJF8fTBpzYCPfNhYGoG
	izX7KLt6ClwDkx3EJjgk7dRaFLmVKdToN5FUeleo68WOkcbvXzSyOQ47t9K4HmH39N4fxKljW/k
	8pC68iGOc/d0mAWVKmCHRSGUUtu84/qRJqP6RHbz4KS+w9jPUYF0HYyHD7TtUJz8X5Z9ilD+JQw
	tiwrAB6ZtEt2aUXO9s5RPGo8/RBuh87VWX7GjV5UNQ8kVqa63/j8LrGxNmIAHsDltyNMmxylP
X-Google-Smtp-Source: AGHT+IEt/qN/f1UsFncdy0V7XvZPdFCD18LAZvZ7xFpk/8yREELWc+CrvW2vI0EHugufZC4ekjybrg==
X-Received: by 2002:a17:902:e54f:b0:28d:18d3:46bd with SMTP id d9443c01a7336-2902740089cmr343161635ad.43.1760427808304;
        Tue, 14 Oct 2025 00:43:28 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61acc413sm15006455a91.20.2025.10.14.00.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:43:27 -0700 (PDT)
Message-ID: <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
Date: Tue, 14 Oct 2025 15:43:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>,
 Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Songtang Liu <liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20250929074645.416-1-ziqianlu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello Aaron,

On 2025/9/29 15:46, Aaron Lu wrote:
> When a cfs_rq is to be throttled, its limbo list should be empty and
> that's why there is a warn in tg_throttle_down() for non empty
> cfs_rq->throttled_limbo_list.
> 
> When running a test with the following hierarchy:
> 
>            root
>          /      \
>          A*     ...
>       /  |  \   ...
>          B
>         /  \
>        C*
> 
> where both A and C have quota settings, that warn on non empty limbo list
> is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> part of the cfs_rq for the sake of simpler representation).
> 

I encountered a similar warning a while ago and fixed it. I have a 
question I'd like to ask. tg_unthrottle_up(cfs_rq_C) calls 
enqueue_task_fair(p) to enqueue a task, which requires that the 
runtime_remaining of task p's entire task_group hierarchy be greater than 0.

In addition to the case you fixed above,
When bandwidth is running normally, Is it possible that there's a corner 
case where cfs_A->runtime_remaining > 0, but cfs_B->runtime_remaining < 
0  could trigger a similar warning?

So, I previously tried to fix this issue using the following code, 
adding the ENQUEUE_THROTTLE flag to ensure that tasks enqueued in 
tg_unthrottle_up() aren't throttled.

---
  kernel/sched/fair.c  | 6 ++++--
  kernel/sched/sched.h | 1 +
  2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e..128efa2eba57 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5290,7 +5290,9 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *se, int flags)
  	se->on_rq = 1;

  	if (cfs_rq->nr_queued == 1) {
-		check_enqueue_throttle(cfs_rq);
+		if (!(flags & ENQUEUE_THROTTLE))
+			check_enqueue_throttle(cfs_rq);
+
  		list_add_leaf_cfs_rq(cfs_rq);
  #ifdef CONFIG_CFS_BANDWIDTH
  		if (cfs_rq->pelt_clock_throttled) {
@@ -5905,7 +5907,7 @@ static int tg_unthrottle_up(struct task_group *tg, 
void *data)
  	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, 
throttle_node) {
  		list_del_init(&p->throttle_node);
  		p->throttled = false;
-		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP | ENQUEUE_THROTTLE);
  	}

  	/* Add cfs_rq with load or one or more already running entities to 
the list */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..871dfb761676 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2358,6 +2358,7 @@ extern const u32		sched_prio_to_wmult[40];
  #define ENQUEUE_MIGRATING	0x100
  #define ENQUEUE_DELAYED		0x200
  #define ENQUEUE_RQ_SELECTED	0x400
+#define ENQUEUE_THROTTLE	0x800

  #define RETRY_TASK		((void *)-1UL)
---

Unfortunately, I tried to build some tests locally and didn't reproduce 
this corner case.

Thanks,
Hao

