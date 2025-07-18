Return-Path: <linux-kernel+bounces-736984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC728B0A653
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C271C83C25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDA2DC35D;
	Fri, 18 Jul 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1xj0U+a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FB22AE45
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848585; cv=none; b=Qv08oVMfPnxqDV1En9rowiqVUe/lqvZpNaE6gcSav/M6khPUqrTPemgCBM/zcv3WmZecp1LJkxM6WlheqMJowjLykShhq+6KWHATVJRFEkqd10cREDMCDodKrcNWGXMgi+byJ0S/Sc4bNoFDdfh6szQXAhMnKGYYhOtt2qcZh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848585; c=relaxed/simple;
	bh=YZEdiclavxGKvFkxmgb7/GCU1hQExyS/NX8OjYaAS6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhb4UHo3yXF8z/6zTIsnVa3ce71kqWNERm744jlQG43jEKCO+QzBEWqoYG9jiTlMCXFncE9bUnmlUw/l8noGqaP/bZmwvj9OfrxmIxX9f8Q6xan60Lauor0+zOv9Pr0sACLc4n+hZtMROX/7E90DwrSas8R+vmoRD6hpenfKvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1xj0U+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752848583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pojxtTU8EzxE9ySMSgFI02sitMHZBbxkd6YoCtwUqgU=;
	b=J1xj0U+adBDIOkhQE748wY497pTqE2xWX0HE2NIQDxMXzVeLHD8zkbQyn2KPmHysS3Afqr
	dDgdk6OdptNn5BK/EnJOgNJseuW22FKrh9R6YFnC9KKqYBrUWKoFuSdgr/NdNTO+2sHTQX
	LTVOrKPwRpp0qKlqT97HqbjlCtXhAn0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-SvNx8D85OAGLmZq4q6b4Sg-1; Fri, 18 Jul 2025 10:23:01 -0400
X-MC-Unique: SvNx8D85OAGLmZq4q6b4Sg-1
X-Mimecast-MFC-AGG-ID: SvNx8D85OAGLmZq4q6b4Sg_1752848580
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so11090725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752848580; x=1753453380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pojxtTU8EzxE9ySMSgFI02sitMHZBbxkd6YoCtwUqgU=;
        b=Yq+U1J5w8Zp7Kza81fzFXjyonicmq8UXX9M0VewRHx4B4BDo1b+GOUxsBXRycKxTDe
         tE0Z6phs1e+25XDLglu6AT0QbSQINgR8M/k9x52MqR5Eg+vab35ummm3wezohsLsemxQ
         KXeQp4dX79JkskSYRQEPCaY9DK4OOZVYs8dTaVh+quc9qyu9ji0knQ7gj90jODOkDr0G
         cYE7OEfFmJ76i6H038XF4VIyP9pWlUVEyaZkty5iMnHY9Ro3NApdY1M7976OIa/vqptg
         kEhuo4HPVp/ESWmfBWesokT06b2EMr+Kn1P0BA2qG0N8NjgND/VAFQeHoeNeS6QDP9ZC
         lP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQpMOxBL3iRT4cIZ1x31LcwR2NxAMw2zccIUV7IRc1rYsUcXV/No9qNAkxOPZ3WeRn9Cy8wKGBHWxGXbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJ/54BOaQVgENyKiPc5B4dDQ9NxO45oExTpNAMmQp9Pqek3Lh
	GUTfTYREJPrec9Gooj3tsAOdy0N74IYis5HpaKry6Xub+qdf7/JAb+tyfOVz9IzzbdQafvwIjsS
	ryRPLl1B9KWynXlE+4zE6SHXtjcgJXLq5M9SrkVUtZi3xjjP1bhL6LPHOWXL1NU35IQ==
X-Gm-Gg: ASbGnctLb2nBDs7L8QZVIe0Al+3h9V/p29KPKG91er1Z1lcJEyF0kx2r5FFP48kW+OC
	GsLK78zfLosslupOCCLLntz1cJ1WmaKdfSNYHD5OIZ1JeG98yjAHdQrCGNBl02PZCy/Xrs5713z
	7uey2hWyd11zwZwXx85xOSwGFnAk5d5Z1tOnAONq+zKsm/OH/sQ9iq6mIPwgVEp8DOdBExXP6Ay
	bf7LlW7DjP4SiPIk3jjO/d/JNEZzD8ow6srXV5SiDPOIN6LR3lfYjsbhxOJVoRcn8/rZNwq85/k
	utHiDYpvcvd7gmTdLJwtCeNYnnfsZ4ii/SqsB1t0OnAC7Uo/Uc5Zh007FomHfc391nedMg==
X-Received: by 2002:a05:600c:314f:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4562e34ad97mr117043625e9.2.1752848580342;
        Fri, 18 Jul 2025 07:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzdxeehhirncBLPwZBCDVu8vuz89brLFxiZB83cofQAHyn6QmtmcmFcl/oFeJHThYRs8y8XQ==
X-Received: by 2002:a05:600c:314f:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-4562e34ad97mr117043325e9.2.1752848579862;
        Fri, 18 Jul 2025 07:22:59 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.35.128.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886286sm82046055e9.26.2025.07.18.07.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:22:59 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:22:55 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [BUG] Bw accounting warning on fair-servers' parameters change
Message-ID: <aHpYvwRizPkUe8Iv@jlelli-thinkpadt14gen4.remote.csb>
References: <20250718113848.193139-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718113848.193139-1-yurand2000@gmail.com>

Hi,

Thanks for reporting.

On 18/07/25 13:38, Yuri Andriaccio wrote:
> Hi,
> 
> I've been lately working on fair-servers and dl_servers for some patches and
> I've come across a bandwidth accounting warning on the latest tip/master (as of
> 2025-07-18, git sha ed0272f0675f). The warning is triggered by simply starting
> the machine, mounting debugfs and then just zeroing any fair-server's runtime.
> 
> 
> The warning:
> 
> WARNING: kernel/sched/deadline.c:266 at dl_rq_change_utilization+0x208/0x230
> static inline void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq) {
>     ...
> 	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
> }
> 
> Steps to reproduce:
> 
> mount -t debugfs none /sys/kernel/debug
> echo 0 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
> 
> 
> It does not happen at every machine boot, but happens on most. Could it possibly
> be related to some of the deadline timers?

I took a quick first look and currently suspect cccb45d7c4295
("sched/deadline: Less agressive dl_server handling") could be playing a
role in this as it delays actual server stop.

Could you please try to repro after having reverted such commit?

Thanks,
Juri

---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 25 +++----------------------
 kernel/sched/fair.c     |  9 +++++++++
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5b4e1cd52e27a..e7ed7ae1871d7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -703,7 +703,6 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
-	unsigned int			dl_server_idle    : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b31..1ad1924ee767a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1152,8 +1152,6 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
 static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
 
-static bool dl_server_stopped(struct sched_dl_entity *dl_se);
-
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
@@ -1173,7 +1171,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		if (!dl_se->server_has_tasks(dl_se)) {
 			replenish_dl_entity(dl_se);
-			dl_server_stopped(dl_se);
 			return HRTIMER_NORESTART;
 		}
 
@@ -1577,17 +1574,15 @@ void dl_server_update_idle_time(struct rq *rq, struct task_struct *p)
 void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
 	/* 0 runtime = fair server disabled */
-	if (dl_se->dl_runtime) {
-		dl_se->dl_server_idle = 0;
+	if (dl_se->dl_runtime)
 		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
-	}
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
-	if (!dl_server(dl_se) || dl_se->dl_server_active)
+	if (!dl_se->dl_runtime)
 		return;
 
 	dl_se->dl_server_active = 1;
@@ -1608,20 +1603,6 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	dl_se->dl_server_active = 0;
 }
 
-static bool dl_server_stopped(struct sched_dl_entity *dl_se)
-{
-	if (!dl_se->dl_server_active)
-		return false;
-
-	if (dl_se->dl_server_idle) {
-		dl_server_stop(dl_se);
-		return true;
-	}
-
-	dl_se->dl_server_idle = 1;
-	return false;
-}
-
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task)
@@ -2388,7 +2369,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			if (!dl_server_stopped(dl_se)) {
+			if (dl_server_active(dl_se)) {
 				dl_se->dl_yielded = 1;
 				update_curr_dl_se(rq, dl_se, 0);
 			}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c2..b2b6f3f6a12db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5802,6 +5802,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5885,6 +5886,10 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/* At this point se is NULL and we are at root level*/
 	sub_nr_running(rq, queued_delta);
+
+	/* Stop the fair server if throttling resulted in no runnable tasks */
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+		dl_server_stop(&rq->fair_server);
 done:
 	/*
 	 * Note: distribution will already see us throttled via the
@@ -6961,6 +6966,7 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
@@ -7044,6 +7050,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	sub_nr_running(rq, h_nr_queued);
 
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
+		dl_server_stop(&rq->fair_server);
+
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;


