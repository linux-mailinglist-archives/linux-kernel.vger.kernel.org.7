Return-Path: <linux-kernel+bounces-836018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA55DBA8957
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8317317CE17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26ED296BBA;
	Mon, 29 Sep 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf/Q5C5x"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D42868AD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137749; cv=none; b=co4j5T+3bslNW4Ga0uJDm84P7oTVxnhabyH/cpdxf9eL3NmIekvJz+0JhLZa4yEV3TQJkIkbJ0Z+mhgkpNmstqF1pu60DsEdmVyzzpRaB6Px5RvBjfHmzqQut1GAYtiTtCMLlNylXsNLFzworb8iKG7sjBYRgVgk/XGRElzlCX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137749; c=relaxed/simple;
	bh=48+i5rW7eRi70EVsLTYHWmDFwwj22lT+qIPuNDi/IYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhVIm4FvyOIQZpgD4dcrkJPZCDPuNCNATTe8K3MmifbizRjIrt456mifNvvXVT4E2HrhvW3HYtetqUl/Y7AE8TdQ42lL1gUiK5//Qeune9g51J7v9NTL1laYhbAs9aSu1bcmx1xO94pbo3Bq2a7pHc3IZ3TcZN9VcJm2HdvqwaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf/Q5C5x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634c01ca9dcso4426051a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137746; x=1759742546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoGXqYKPgkRonEfbC7CzVFU8BRc0pw6mQcE9m7FqR9c=;
        b=Bf/Q5C5xSMkA0nY83lpw0v43kPnmqLpq3DoH3l5RYPU+lP0KG2ri5KgrJnIxt7uvvO
         TLAcKuHEsQoHw0/or+XTpUfYa75kuRmKU4fKQWb6u55/XjQDg4+zjLJPoMsNb3UE8xs9
         xJF4VeK3Fb0R3rWTQvO0VMI6XojX8Gq5iQcDhpqIHDWjGOTesSJ9z8xYsFL9iLk9DfuU
         pF4iVDX9EXxz6mf+UZ075r5LwcX9hH/urIsa+Z2Cw/xzeVb2SJjZnReOIsBZFf6OtnSS
         hnN0871duZFvMnJ91IcNOjXE3euL3vpV9SMDUG0IS25zcqwgDanOZJACbUcycxDTjmeb
         8g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137746; x=1759742546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoGXqYKPgkRonEfbC7CzVFU8BRc0pw6mQcE9m7FqR9c=;
        b=ODsln4R61hxf9RxW5BR2Xc4yT6HTDpXMUYC50B6YoPqTlLOrQlyagKT2DLtOSZqpUu
         W7pJqkTrRf0xe4afsBK7atL+2BTMWUEhTxZz4lFAc7JMEuU/BXEDh4mkwL0NlEyWv+Ku
         Vxqjf3SHk3F+oY6YwiySm4i3mY/idVgo4LLG/vrTyDIVmi0O/iENJ75Hj0S8uAZrmHQI
         1H5faECWa/6T2ylsVKIjZfXuLnEiCjRz1KoIKyOcra+oz5mKdbLcEpl8e9lHnLYemytF
         r6Qj0bgCScICWxw0qzBSC1YRaQOJIvXAdMF+C9Ovd01+WDfRbzrAcRn8ef4U18q0v/S8
         8/cA==
X-Gm-Message-State: AOJu0YztLHWt5eprLSP4es9PBcfN3Hee5dQiOnvFlQ9CqWXOFDjIXTXW
	rUeM8c7Y7sT9U5BdJrBzDILWiGAn16oOScEtTzmh1bOLwZchTKz/zE4cHwBjOn2T
X-Gm-Gg: ASbGnctxyUObyvXManIQKUq6dxmC/9MLXh31FSH/nOaSKApyWGNLQELrOL3/218cirv
	TAcU+baXfL5rgPCjlFqYYWo9GUDgR1hbobbavPQW8ooiU2Hw3S79SQnieJJqPn2Jn28/rghsQsZ
	BYI+8bUMMywYdMZUU2b8/b7J39q3v31c6YVQ6adceWxonqml9BZtWEYQiRGLeasa5wPO5Xr4CTg
	B7WwU8WJKyEDhtmJPjIqbSWDBAKPS+5rcXs1natpxWpzBeYoEnShvhjcEQPggqD3BHBClK38QPi
	pEGwAvXYyefWs6hn3XFA1dj+5QfzUMoW2Pa2F20Qib7H8g1ZaqF3eN7z9xLeIsee/zczFWDP4gg
	mEYPYhdzTW/0SVcC8mj36r0FjzvUjezSuczhM6z5t
X-Google-Smtp-Source: AGHT+IEhLbBZpwHYi84vsUqDkJBVR0XSQ1j4ZTzHZHefq61fvkR7VVVp7HZzaryM4lzsIFXoNetFNw==
X-Received: by 2002:a17:907:9305:b0:b10:9e5d:d173 with SMTP id a640c23a62f3a-b34be3ebc89mr1786875766b.41.1759137746192;
        Mon, 29 Sep 2025 02:22:26 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:25 -0700 (PDT)
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
Subject: [RFC PATCH v3 04/24] sched/rt: Move some functions from rt.c to sched.h
Date: Mon, 29 Sep 2025 11:22:01 +0200
Message-ID: <20250929092221.10947-5-yurand2000@gmail.com>
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

Make the following functions be non-static and move them in sched.h, so that
they can be used also in other source files:
- rt_task_of()
- rq_of_rt_rq()
- rt_rq_of_se()
- rq_of_rt_se()

There are no functional changes. This is needed by future patches.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c    | 52 ------------------------------------------
 kernel/sched/sched.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a7d063d2303..a599f63bf7f 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -168,34 +168,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 
 #define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
 
-static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
-{
-	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
-
-	return container_of(rt_se, struct task_struct, rt);
-}
-
-static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
-{
-	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-	return rt_rq->rq;
-}
-
-static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
-{
-	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
-	return rt_se->rt_rq;
-}
-
-static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
-{
-	struct rt_rq *rt_rq = rt_se->rt_rq;
-
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-	return rt_rq->rq;
-}
-
 void unregister_rt_sched_group(struct task_group *tg)
 {
 	if (!rt_group_sched_enabled())
@@ -296,30 +268,6 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 
 #define rt_entity_is_task(rt_se) (1)
 
-static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
-{
-	return container_of(rt_se, struct task_struct, rt);
-}
-
-static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
-{
-	return container_of(rt_rq, struct rq, rt);
-}
-
-static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
-{
-	struct task_struct *p = rt_task_of(rt_se);
-
-	return task_rq(p);
-}
-
-static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
-{
-	struct rq *rq = rq_of_rt_se(rt_se);
-
-	return &rq->rt;
-}
-
 void unregister_rt_sched_group(struct task_group *tg) { }
 
 void free_rt_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2499b36a3c5..831ab576842 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3040,6 +3040,60 @@ extern void set_rq_offline(struct rq *rq);
 
 extern bool sched_smp_initialized;
 
+#ifdef CONFIG_RT_GROUP_SCHED
+static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
+{
+	WARN_ON_ONCE(rt_se->my_q);
+
+	return container_of(rt_se, struct task_struct, rt);
+}
+
+static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
+{
+	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
+	return rt_rq->rq;
+}
+
+static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
+{
+	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
+	return rt_se->rt_rq;
+}
+
+static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
+{
+	struct rt_rq *rt_rq = rt_se->rt_rq;
+
+	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
+	return rt_rq->rq;
+}
+#else
+static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
+{
+	return container_of(rt_se, struct task_struct, rt);
+}
+
+static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
+{
+	return container_of(rt_rq, struct rq, rt);
+}
+
+static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
+{
+	struct task_struct *p = rt_task_of(rt_se);
+
+	return task_rq(p);
+}
+
+static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
+{
+	struct rq *rq = rq_of_rt_se(rt_se);
+
+	return &rq->rt;
+}
+#endif
+
 DEFINE_LOCK_GUARD_2(double_rq_lock, struct rq,
 		    double_rq_lock(_T->lock, _T->lock2),
 		    double_rq_unlock(_T->lock, _T->lock2))
-- 
2.51.0


