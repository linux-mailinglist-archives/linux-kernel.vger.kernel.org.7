Return-Path: <linux-kernel+bounces-751962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F4DB16FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9905B17EA94
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EA2BE645;
	Thu, 31 Jul 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN6OGzZz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC32BDC09
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959350; cv=none; b=J6OZu4lTYLRjAPEza6lFsP/ihEeAppFFqJPkALFsjCs8KW93CQKcu+og/gPwYZ6l9HCldCKu9XwO9donFqIVHsTPLqBJlKLQg9dB3/oEo/hpPe86vWw/apjthwRO9+jSR4L8qAALwkLwD3dJqYpjaZ7lKj8e1lkGJPpMEjE+VgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959350; c=relaxed/simple;
	bh=TDuXtiBRf5XyOqVakO8h9p+u/BxiS5DyyaQsPNw9mBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAh2pCYVwpEXAJWb/WJEJ4UaFLBXa4Lhu5Vxrb6GNCyQmi01w+UJKHJptiokCY4hTwOP+159yj3WduUAgo6Y+a51xosxRoDp3sqnkcBRsyL2+Ht3kMIuyzCkgJIuaCqKfuVZDlNHGqtLIyRQoBGv9tuEqVLpbFi/U3kDn0hEmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN6OGzZz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b792b0b829so706136f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959347; x=1754564147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV5At0v2MxwIlo7gcdYLnxR3OpnsqgCRXMq13jPhmuk=;
        b=mN6OGzZz9e774aQnhnI3QcqApopcQ1hx//hZb4opFu1R3gLCu1sh+1oKUddcEvhgfj
         9nLNTzBJ0A7qz5AAE82Dg6usbVQYyyRhRzSHCOCpdmr6ZzjdqqqG5sc0OfMsrXI3Vi2X
         CSAwc8NFc+mNlogyy4fkHcviz6pObWiIQO1H5ju59QIQ+w4NqL/i2XdV/ogwcA/pDRtl
         8S6PNeVMP9eZoJ+t1vaHKpzUuv1n1BFBx0bMgIz7/qy+NnvNSie6ezre4wxUfKSTpbOI
         xIO/R62kELzi5u3eIYVhX4zIAl4H/KG3ggnViFTb/Ajn/p/b+s60Xf3kxpl6TUh3Qdlv
         Bp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959347; x=1754564147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EV5At0v2MxwIlo7gcdYLnxR3OpnsqgCRXMq13jPhmuk=;
        b=BoJwKaTT4VIrrKIlh6oqr2PuZuRnShCW75jLyuj7zZcUixTbw1/lH70khkjwFQxhhA
         sfozwwXkxiVD+Nw+qtX3pSe0UQzVbJPYc+BaO+D8j2NheiUVg0rrJWYRbfP6W61yd7K4
         0tUwSfuA5Q5UeQsYAJC0lg9dfbBwFRgxRzPhdSie2ZZhm4dpejxxaoXqn7IxLHHKe6vz
         CCA4gRn3T+jfTDmKdijhYoC8vtBNjIvxxmh/R1RUkM71PSn6HT2mzPIM0ZZG5hHykITP
         QIG/oMNT2fE5vwmDfSo+AdPktCmPwiKM2qS6ukzCIoeIFPocLnoMBeYy0MZnmYX6vgtY
         8aiA==
X-Gm-Message-State: AOJu0YwwJ7mKDPH4l5bX5ZiqA75WgzQ0dEUiAwKzCw39Lixt/6ZytYPy
	wIRInZVfVOETDPaz6s/lUOwHK/BxPMhbS133AK2Vpjj9Kd28eNuiLFIQ
X-Gm-Gg: ASbGncuGx2qFgtbCJo3q4hgx5peXP0IQ5DdvsQ5ENPP100v6SkTciWVmGi5aksbIYbS
	EoLNDUUsfcYpcIAm/GprRnaE7eyiS8Hm3PXej7DIMBza2foKiGZzfQR37OVcr9z1lT93T8ufnik
	mLJDkXAGA0ZIfaMswWOb/3l5cL15S1BIx5MQWHHl7WV5ZwHjxFpfkd+Sg0gaccnUsu8ohjs2jEG
	guLQ/XVF4aYMJM1MhnbrH7omFT+f2aUFS2LiyV0fHZK7ClMOBECxjyEx6iTlJReeOefTe5yMh3d
	LawEy6H8Wbe+mVWSF60IQAB3v0nmbvDAyC+PEFiZEZTMv03KUPMz0vK/NfieunEkPnXEl96/ki1
	WZ9xhHRJXHBPlaivwWgo2k/Fi6Zfr3g==
X-Google-Smtp-Source: AGHT+IGDDa6RRleE5kYPN07mlH8Es4goEc4/iuBLPGtFq5ZYSEu4efaNzW+5pUtOabs8CvDN5zKcTw==
X-Received: by 2002:a05:6000:2f85:b0:3a5:2694:d75f with SMTP id ffacd0b85a97d-3b79501df77mr5776287f8f.52.1753959346949;
        Thu, 31 Jul 2025 03:55:46 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:46 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/25] sched/deadline: Distinct between dl_rq and my_q
Date: Thu, 31 Jul 2025 12:55:21 +0200
Message-ID: <20250731105543.40832-4-yurand2000@gmail.com>
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
index 40d2fa90df4..f0c8229afd1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -724,12 +724,14 @@ struct sched_dl_entity {
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
index 46b9b78cca2..73ca5c0a086 100644
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
 
@@ -1641,11 +1642,13 @@ static bool dl_server_stopped(struct sched_dl_entity *dl_se)
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
index 8719ab8a817..a8073d0824d 100644
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
2.50.1


