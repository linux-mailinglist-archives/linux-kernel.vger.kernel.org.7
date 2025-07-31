Return-Path: <linux-kernel+bounces-751961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE1B16FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D14B172FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD1E2BE054;
	Thu, 31 Jul 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTTEAsU3"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6D2BD5A3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959349; cv=none; b=fzrV1DBznleiAjKgb1+EFCYb0hFfAxN5mK6mSMceeCLW+GbfVemtJMEgeiGuIaAFXIy3U+RmDZz0ic0y1nyp3+IdTk0NqXnCUTuGz/yLB4+v0CpnB0KcRgyuPHL0mzlD6sfIlJ3LZpcP8JyiWSurqoMImJ3QMTa0cEMgE1QFJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959349; c=relaxed/simple;
	bh=7zHuy3Bzmy3kpmP2kbCBpXVwxrJx8uxdFSO/UfUhAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmimCY/tOY1sMv6dxqhTMCTUbrda+NYzmYmiI3dAHQ0r1DSYjilh9UrqhouF08mT4AJBhjgyOHxZgqINTLnVH89C6zLcOwGI2Rcuoxk3m1G7GsXCuyrDmhhxc38wlnfkfRmJDYTz1YLDYXnOp1GlhEk/1q1iPqIGC4y0DWENe5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTTEAsU3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7823559a5so488411f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959346; x=1754564146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzi2jPoOSdH5XG/gZrMJeOKkz0/pDG4/KykhFPpTSrE=;
        b=CTTEAsU3+0Ro2/COg8j4nFQW89eo1OUdfv+6a9mhJZKqODxNr1z7+8w5kp20xT6AKu
         dn6Ei9JzGVTJlTqyHSSUQ+0eEhqJ7Xdk0rqRZ2jVOTpfXI7DiXFlNbOKE2Bo1/9FbGps
         jR3plHAHnvWl4bBrbB3XOuWz8WNoxC3IzKN7GE53HwxmOkN2TvFNRy9Zte9oTU6ne80O
         azav6+jPysbw6L3n+W/S2P5Ir+JMZ33cp3cbWqSp04aB1v3FBOaArDwb94VhSnugtYud
         wXKv446hO5YGeIqQ5423Jeir8BZKjF7lCU4rFCPQeXx/6YL1dI8i+elLsPPeIkPkKeu3
         ZnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959346; x=1754564146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzi2jPoOSdH5XG/gZrMJeOKkz0/pDG4/KykhFPpTSrE=;
        b=DllsRjkrJVve9Vx/RgbInezSsGdMtmD5mREsZsp3M/HPDqkjr4BdDiWgCP3nC0bC9Z
         SiuHLS+4UqLwGKxzQv42JWN2rB35Uo3M0fJ6ZQCxcyttzGQmkv10O2AG2gbInpH9QZLM
         W3ndsVTzFGiqn0ynmdlWt5dGNGbdHu1kHQPtUrkq8zrx12iXAbDnG2Q9WJfhXxcmfW0Q
         1Uao25tC2M0NnAcvcOn6XU4T+r8eRhXmrfMOIarbcyx1l/YN+D6Mi7jkRwEkuXae7zcz
         8ANVxUzmHSMYOvmUCiBrEu0CXEfrFK0ei1LwHDGvJNf4MgxpkREXYOwLPFqyGKCO24Xm
         5v4w==
X-Gm-Message-State: AOJu0Yxs1zIIVC1uFcxkSsZAF8VkqQYp5k+aInefLsMEzFkB7P5jtx7h
	8STO1RdTtMe4EPkGiSiBhj3RGen2pB4mgyC61IEsond50a0tMXGKdtfP
X-Gm-Gg: ASbGncuH7qCIMj42J7+FIjx/hvCZM68vjMxhg0zeCKr8q/uwd5pg+BFp+mgiElKc7GU
	1sOdtEJos2kYisss82vSHh6XjLE49/Zj+XXiS2xcTjT5CTeDANcA6XoiQCjy98PChVoJGcwI+1k
	h+XCbjOn4+FuG7r85Z/MjNjWhJT8pshGAe3P135aeXOLHlkKVxzew70f7Q/YkwU6qR1w6XUNm2q
	NWPij3Ud/aLPOodfgpbDkhbQxN9iJDPe/qknedjPbT7Y4mpOCUefgh0ox7nKCyR1tkA5uykVPOw
	NMRdwSn0A2lIEqqOI4W9tBabXjLljSTcrj8nYDRRe5JLKf8ksAzWOkZwhxabNBg6HUGyfgDecs9
	gjjrDYE+CvNaDe4sP/sk=
X-Google-Smtp-Source: AGHT+IGuhmZKx5E9GRCc9EnhnDq0z3y7OE0+CKyG8WVwqqH7o54scX+YtHNHMWjn7N8aeWjjij8zug==
X-Received: by 2002:a05:6000:1889:b0:3b3:9c75:acc6 with SMTP id ffacd0b85a97d-3b79503d7d3mr6049492f8f.59.1753959346211;
        Thu, 31 Jul 2025 03:55:46 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:45 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/25] sched/deadline: Do not access dl_se->rq directly
Date: Thu, 31 Jul 2025 12:55:20 +0200
Message-ID: <20250731105543.40832-3-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
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
index 8ba6bf3ef68..46b9b78cca2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -892,7 +892,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * and arm the defer timer.
 	 */
 	if (dl_se->dl_defer && !dl_se->dl_defer_running &&
-	    dl_time_before(rq_clock(dl_se->rq), dl_se->deadline - dl_se->runtime)) {
+	    dl_time_before(rq_clock(rq), dl_se->deadline - dl_se->runtime)) {
 		if (!is_dl_boosted(dl_se) && dl_se->server_has_tasks(dl_se)) {
 
 			/*
@@ -1202,11 +1202,11 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
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
@@ -1217,7 +1217,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
 
-		if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &dl_se->rq->curr->dl))
+		if (!dl_task(rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 			resched_curr(rq);
 
 		__push_dl_task(rq, rf);
@@ -1485,7 +1485,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 
 		hrtimer_try_to_cancel(&dl_se->dl_timer);
 
-		replenish_dl_new_period(dl_se, dl_se->rq);
+		replenish_dl_new_period(dl_se, rq);
 
 		/*
 		 * Not being able to start the timer seems problematic. If it could not
@@ -1597,21 +1597,22 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
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
@@ -1667,9 +1668,9 @@ void sched_init_dl_servers(void)
 
 		WARN_ON(dl_server(dl_se));
 
-		dl_server_apply_params(dl_se, runtime, period, 1);
-
 		dl_se->dl_server = 1;
+		BUG_ON(dl_server_apply_params(dl_se, runtime, period, 1));
+
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
 	}
@@ -1678,7 +1679,7 @@ void sched_init_dl_servers(void)
 int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
 {
 	u64 max_bw, new_bw = to_ratio(period, runtime);
-	struct rq *rq = dl_se->rq;
+	struct rq *rq = rq_of_dl_se(dl_se);
 	int cpu = cpu_of(rq);
 	struct dl_bw *dl_b;
 	unsigned long cap;
@@ -1752,7 +1753,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		p = dl_task_of(dl_se);
 		rq = task_rq_lock(p, &rf);
 	} else {
-		rq = dl_se->rq;
+		rq = rq_of_dl_se(dl_se);
 		rq_lock(rq, &rf);
 	}
 
-- 
2.50.1


