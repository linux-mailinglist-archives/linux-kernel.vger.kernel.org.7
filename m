Return-Path: <linux-kernel+bounces-836016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837ABA8954
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129AD3B544D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5148F2882D0;
	Mon, 29 Sep 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL1xQMHu"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C21EE7B9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137748; cv=none; b=nc1hDOl/O7jUuYwuyPK8zmrNuUfGxt5YAF5WgrI1x6gPDxUfW9T2h22MKpOjVjwEQ4vIsBQM+xIIIZJSfVnOk6c5WtiE7oRenVrjmXaWuaygUz2HW1F/kGJaJSTeH72pAeXVCy1HgBkZCKjKfFr0mC+iu8wVKK/s/9xAl/Ad5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137748; c=relaxed/simple;
	bh=S5MxWR5GoGZBnStHQQUs/qHKLb2YQcNYZa0d7u7q6bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLZDgEVxNbaw7Ec3NQbTNBS+3mmvgFpCFlgyJjhdFaFn4Z2ay36NFFl+XEqZQywqMsAbXREJ9F+g/okB91mSASubncA48xkHCWAAy+T4Cpydj5QCGoOV94X15H2EzVpQ9W7FOAb81It5Bb5oCDgiAJwdX1mWHEC/VbzEHWiFHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL1xQMHu; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3da3b34950so175871366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137745; x=1759742545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQL/+PGJfM/ECDwo+SvhH2uE9jNxwr9mlcuoVIiRG2I=;
        b=gL1xQMHufgzinmaiNZo66jbsXvYNRs9sxMpcyAdnwvXPSWAYOIPrjaRD8oSd91lfjV
         lcYuTV7FJOBLqPcEf9gHMVRJ9Iw4jVmaFgD3g5xZDj1JzAqLWkudYWhXYCOJUbw3x+Uf
         9kZW89kxv0yGiCJkw0DsQW3g2dUZtDE96Eo+kC1md015IMaQcz5iT7+1Hk9RqjXgf8cx
         uNiWr6SSR4rphApTVquqIxW8EShhVCum+Km6QYEwoaQg5/yXpzG9hl93bgL5Yl0xTUqb
         fYyQYWz+D388HOk15Lq3UUdKxOIyUSngsHkumg/1eMD+Uep/SSVMn44rKui/7bBd01jA
         JoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137745; x=1759742545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQL/+PGJfM/ECDwo+SvhH2uE9jNxwr9mlcuoVIiRG2I=;
        b=QcuqyEP9RcVkYE8XcsrpN/IL0n0ZGu7fz19iEkyqX5eh+6Pg+WVhlJ1MiyLPcMDtto
         ssXZzNEPRanmXTOPEJGiUFxk4GR7MY2y+jDi57g7QN5b7iLQW5PvoWdUPknOEpTZtVq5
         P+4n6+v4X5z6Oinhpxto4N9OXx+hjGauLLZCGDTAVSkioqXk/qgWYm9ctWt7rwdUJS0+
         rV9SplvpwSfC5VLcVrceuzumzVndKUXLGxCHbQTO3rNBboSHoeRqwOyaX+0hx/u6M3jQ
         QG5OR/nnKJ8OTOS6p4Xz5TBeecrJ+hsc4FQgBaOq6AvyWCmoyAlzNip7eLRleEU3jqGO
         V8DA==
X-Gm-Message-State: AOJu0Yw7bFxSN5d5yX2zJU2MHzEEuEuQ/us2UAMeG/TwaUqzGzz3Vej5
	OfoLWdedOE0dbxQYUvmur+zdz7s7ttccRldLHdSf++FpNe4+fhAFJPPZ
X-Gm-Gg: ASbGncvA8U/048SS1oUXc7q2Ue8KS+BSqCx5RVVcoIcvdYktxbTOUmWbfeRN7Oc7ApU
	W2ag2GH6hp9/nBmcbfJWeRGXOOB9M+3XR4GkDJhYN7qI0aE1uAt8cqzB4SH7PSpX41BmrWEzTCS
	51YlbI6FxKuSdsmfD7YVaQ9DzD/MLZkCCssubved5+1IcwRARZh+kAbfycxiXgPSXPdHZqOJHTY
	JZ971RV7Xeht5FXuvWazNWqx7GUXIwLDXbBao+3oKY+1Y4G8eNIJ2+fPOdZYNj84kj1j71EdiMP
	lrc0tAPIERqdu1Kv5pOmCbBQLZZLs2/YDZBboKFjdPFuLE9751ewDRXK5d/FW4mmLOulf0NY5HW
	aRPY5rXf56LGjTJZXp94=
X-Google-Smtp-Source: AGHT+IGuX8WBXuHMb9hvcHGd4mXpxHtHFZCkkRcro1SywNYuKbNRTtYgE5xsvvMIJKJOqzM80+2Tew==
X-Received: by 2002:a17:906:794d:b0:b3c:bb7a:c366 with SMTP id a640c23a62f3a-b3cbb7ac5bdmr498051166b.7.1759137744724;
        Mon, 29 Sep 2025 02:22:24 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:24 -0700 (PDT)
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
Subject: [RFC PATCH v3 02/24] sched/deadline: Distinct between dl_rq and my_q
Date: Mon, 29 Sep 2025 11:21:59 +0200
Message-ID: <20250929092221.10947-3-yurand2000@gmail.com>
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

Create two fields for runqueues in sched_dl_entity to make a distinction between
the global runqueue and the runqueue which the dl_server serves.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 include/linux/sched.h   |  6 ++++--
 kernel/sched/deadline.c | 11 +++++++----
 kernel/sched/fair.c     |  6 +++---
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b83335..5022ff99c5d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -727,12 +727,14 @@ struct sched_dl_entity {
 	 * Bits for DL-server functionality. Also see the comment near
 	 * dl_server_update().
 	 *
-	 * @rq the runqueue this server is for
+	 * @dl_rq the runqueue on which this entity is (to be) queued
+	 * @my_q  the runqueue "owned" by this entity
 	 *
 	 * @server_has_tasks() returns true if @server_pick return a
 	 * runnable task.
 	 */
-	struct rq			*rq;
+	struct dl_rq			*dl_rq;
+	struct rq			*my_q;
 	dl_server_has_tasks_f		server_has_tasks;
 	dl_server_pick_f		server_pick_task;
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5113c3a2633..6ff00f71041 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -75,11 +75,12 @@ static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
 
 static inline struct rq *rq_of_dl_se(struct sched_dl_entity *dl_se)
 {
-	struct rq *rq = dl_se->rq;
+	struct rq *rq;
 
 	if (!dl_server(dl_se))
 		rq = task_rq(dl_task_of(dl_se));
-
+	else
+		rq = container_of(dl_se->dl_rq, struct rq, dl);
 	return rq;
 }
 
@@ -1625,11 +1626,13 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
 	return false;
 }
 
-void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
+		    struct rq *served_rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task)
 {
-	dl_se->rq = rq;
+	dl_se->dl_rq = dl_rq;
+	dl_se->my_q  = served_rq;
 	dl_se->server_has_tasks = has_tasks;
 	dl_se->server_pick_task = pick_task;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315..2723086538b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8861,12 +8861,12 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_stru
 
 static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 {
-	return !!dl_se->rq->cfs.nr_queued;
+	return !!dl_se->my_q->cfs.nr_queued;
 }
 
 static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
 {
-	return pick_task_fair(dl_se->rq);
+	return pick_task_fair(dl_se->my_q);
 }
 
 void fair_server_init(struct rq *rq)
@@ -8875,7 +8875,7 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_task);
+	dl_server_init(dl_se, &rq->dl, rq, fair_server_has_tasks, fair_server_pick_task);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f..2499b36a3c5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -382,7 +382,8 @@ extern s64 dl_scaled_delta_exec(struct rq *rq, struct sched_dl_entity *dl_se, s6
 extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
 extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
-extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
+		    struct rq *served_rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
-- 
2.51.0


