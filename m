Return-Path: <linux-kernel+bounces-836015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DABA8951
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C4C1887BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED5286D63;
	Mon, 29 Sep 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqKK9BGk"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8577274659
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137747; cv=none; b=QuL+yCWGiUnqqyrtEte/KYO5g4xjS21KLPr1IEifEi+og/BJ8Dvw2LZ+807Nw92Q2kos22XaUMdvqzZiWHVCkJ32IB0ZGfiUM+7rhexB1UG1gHI9ONXlPF7sI8XN/DaQNqOPdXZOomnwxA4/ny7UcYT07A3VHrnuaKz83PMTT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137747; c=relaxed/simple;
	bh=/Nvv3+IoLrE1qokv5D7XIZ4rmVNSJbEEYyhfkWbXFsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwtSwUYp3BqpaC8Vt5K41eWTyk0ceJlf9+DrkzGivDLfUl+Brrozfl0VdDQMFjk7Hyc/HuL73HbtJCvBYMtke97llHZg1fz/2RTp6ah5ONujImWi1uh1+LOwmlT3hZmODYh0slYutA3xAOBx0hdeKcOA8jCmM+sVb9w5qAjPoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqKK9BGk; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so6356885a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137744; x=1759742544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spCan/N9K4QxlTmBD9/alPS6yosYlCXKA4lq5unkhdM=;
        b=UqKK9BGkgHAjVqpZpWtoseIFDMQA+tIT3r/bUxfFDsGb01Xqi/rhIYEw7tp9tnyqHG
         pysvCnuC6lFQQzj/r54aKcdUBeYoQrN/RUYVl7haZggjuW2l1kpogKtSlHhKmpMaZS5t
         VqDf17CR7j34gso/+C7tWu3vAhyeBn50HwRC9YFH8/+6cv5592iLDHvraJq1+Rkn2cT6
         ha76/nWJmBBegsu2ORAzvRn0dQRb50b5jLQZDdbZajNgZditwJSn6i1TiklLa8y8f6b6
         qFblhjVWFHIchFBlBrPhkjKJSMf6a6QVWCDHsby/ubc14Cz9mwvPkvpg6LjjtEVaDT+s
         pyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137744; x=1759742544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spCan/N9K4QxlTmBD9/alPS6yosYlCXKA4lq5unkhdM=;
        b=NTmQ2cR48WeOdWQi5BYGh2Ge246a2ZQpjoV2cROAkWEycG4Lebofa4JBClAkFAVRDH
         +458RYPMbuLXS5cdioj8nmo7Lgjgi2eMZTY5IsSh3ULwE6ZSUmBQB91QbgN7BLt4mrGd
         t9ZSG1O7mosFvsomEDDcplELWgSio5PzTJ276/cWCyH15qAUQBZ3P1unSSQYHKLfSPvK
         X5EvMTfRuY3vCjWpjf3xlZkoIKx36rOpj2oQlAMblT+P7/hMut144TIG/c7rDcob5N00
         VobvTzpXP+4Onk/UnMdfRVY5q5PrxTGSsxI9E7i0ygVTWNqCNSBuIFmCyliGEAOurXBS
         +yKA==
X-Gm-Message-State: AOJu0Yyui6K5SIk57ZaDOq61KnLwwbOHqHXzycGj5hiaNXKbrDatTWOY
	ydWtaBNg1/gJ4FhnGu8qB43pyQ5YfSeRwuxit3NEUEEQkNP+FK1WsFiD
X-Gm-Gg: ASbGnctIH4C2T4WxZduZkMkMdJn5ZXl+Vd4GuQeN8JHHKI31gzdPEVG9wgvlOYEGRSd
	pB1BvFUU4NMeVY3Vu6EsmGGScPXnW87HcnjjSN89TRWg9qmvm/kr7ZtVBOo1VJG9ZpjM9D5lP+w
	xZnLT0/0XJKjJ78edSzvbnIY/4IikloCqQJk4Z4kXYRzSAU7CICyeqle5xZgGgZSnVVDXCR4fUL
	nV5s5YSX5hACW/uJtHDOsaqgyn1Oy9o0y/HyMx21VpEDt02/mM9g8verch6e4qEA/swmTQi32UP
	JoIVn8dOU2rNitPw2OnERPzOR2ybycM6KjZWUJiZ4QzqGlcHDdLroi3u+QwhH2V0sF/reg6O6Ub
	oY12BnyKUw3H6VvKkmV0vlZby3h/8lg==
X-Google-Smtp-Source: AGHT+IGjA+ST+aacUoohlmqOoXtrfNZh2pdwSqRCZXFbbGwhKyw22UgOknjetLUulTKWkNEUVBcvFw==
X-Received: by 2002:a17:907:3fa0:b0:b04:67f3:890f with SMTP id a640c23a62f3a-b34bbbda1e6mr1910135666b.33.1759137743961;
        Mon, 29 Sep 2025 02:22:23 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:23 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v3 01/24] sched/deadline: Do not access dl_se->rq directly
Date: Mon, 29 Sep 2025 11:21:58 +0200
Message-ID: <20250929092221.10947-2-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Make deadline.c code access the runqueue of a scheduling entity saved in the
sched_dl_entity data structure. This allows future patches to save different
runqueues in sched_dl_entity other than the global runqueues.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f25301267e4..5113c3a2633 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -874,7 +874,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * and arm the defer timer.
 	 */
 	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
-	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
+	    dl_time_before(rq_clock(rq), dl_se->deadline - dl_se->runtime)) {
 		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
 
 			/*
@@ -1184,11 +1184,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 			 * of time. The dl_server_min_res serves as a limit to avoid
 			 * forwarding the timer for a too small amount of time.
 			 */
-			if (dl_time_before(rq_clock(dl_se->rq),
+			if (dl_time_before(rq_clock(rq),
 					   (dl_se->deadline - dl_se->runtime - dl_server_min_res))) {
 
 				/* reset the defer timer */
-				fw = dl_se->deadline - rq_clock(dl_se->rq) - dl_se->runtime;
+				fw = dl_se->deadline - rq_clock(rq) - dl_se->runtime;
 
 				hrtimer_forward_now(timer, ns_to_ktime(fw));
 				return HRTIMER_RESTART;
@@ -1199,7 +1199,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
 
-		if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
+		if (!dl_task(rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 			resched_curr(rq);
 
 		__push_dl_task(rq, rf);
@@ -1467,7 +1467,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
-		replenish_dl_new_period(dl_se, dl_se->rq);
+		replenish_dl_new_period(dl_se, rq);
 
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
@@ -1581,21 +1581,22 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 	/* 0 runtime = fair server disabled */
 	if (dl_se->dl_runtime) {
 		dl_se->dl_server_idle = 0;
-		update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+		update_curr_dl_se(rq_of_dl_se(dl_se), dl_se, delta_exec);
 	}
 }
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
-	struct rq *rq = dl_se->rq;
+	struct rq *rq;
 
 	if (!dl_server(dl_se) || dl_se->dl_server_active)
 		return;
 
 	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
-	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
-		resched_curr(dl_se->rq);
+	rq = rq_of_dl_se(dl_se);
+	if (!dl_task(rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
+		resched_curr(rq);
 }
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
@@ -1651,9 +1652,9 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
 		dl_se->dl_server = 1;
+		WARN_ON(dl_server_apply_params(dl_se, runtime, period, 1));
+
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 	}
@@ -1678,7 +1679,7 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 {
 	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
 	u64 new_bw = to_ratio(period, runtime);
-	struct rq *rq = dl_se->rq;
+	struct rq *rq = rq_of_dl_se(dl_se);
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
 	unsigned long cap;
@@ -1755,7 +1756,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		p = dl_task_of(dl_se);
 		rq = task_rq_lock(p, &rf);
 	} else {
-		rq = dl_se->rq;
+		rq = rq_of_dl_se(dl_se);
 		rq_lock(rq, &rf);
 	}
 
-- 
2.51.0


