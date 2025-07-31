Return-Path: <linux-kernel+bounces-751971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811E8B16FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2217972E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCEF2C15AE;
	Thu, 31 Jul 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff0zefVR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E42BFC8F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959357; cv=none; b=CErVfcA+RBAv63lgE+KvcjnoySa9/y0L/GPVLC3UIeOkQATJ16pBVM8TBoh1CRk5g3uVELBmxmiG/1O9Qudjw/zc9PUCCLFDgH/hcNzbO9qVEDu1lJ7Fxw9rj4hvSGKSOTj4OTi4XM83Tq7KA8F/Hsan4Uq7ek39Hnsf7gUZ3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959357; c=relaxed/simple;
	bh=j3rSyFw1+tmCTEgOl0PEOIDQ8q+5Y19PGpaUbY4ELAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwOogvp3ecNe9cXbld8qKZm21ag0MJxU++a5ZrHfbjKgZMMotsjwjjSxpg5f+3FdnQONKr+wBHBvbySOKx8xwDvLVGi5P9pN4i7ZCpUtRA3hplc1LIla+wL790WAmeJEBEMMzKNNUAU2305L4WdwJNUjile3rXzIMii6rKiBX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff0zefVR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45629702e52so3015585e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959354; x=1754564154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWI0wdc7axH18MCt0Tc2btZEL3SXmvH78G2j6OBM6hw=;
        b=ff0zefVRkF25JmhDxmE0J/bDXRN3b2k2JUKpCaZg2q6UbpLMO8iy1m/PryH2wAuTLy
         Eg1rWPts/tmrS6SeiH+u60XkNCdNovzZ86HnQByHg1hMJOMftoDcSucF/+hXEZipxjkX
         T/sK+fV0Ka2A1ccrqyBfXm/QGpcE532eBHARhwMw0l9rNzfal+jwLbLHGZUih2bmnt56
         KK3FYsQsOalfhaG6hSXXXFgwukWlbAjONTeFruAtlOsAk5Lc+XZ31HxCGEGcsxAxekNS
         /tMMfxxsKflU6rMIFo8mPqTev7DsyW9K4CgHxuU/X98RyIb5qo3tecNswoKfHR/Xy6f3
         J4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959354; x=1754564154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWI0wdc7axH18MCt0Tc2btZEL3SXmvH78G2j6OBM6hw=;
        b=kzZUR9/Rzl6p9Z00Q9HsIU6GtF/X+Hj0pze1v4u5j1fyrxALUzysIy0/oNGcX6z0l9
         0GH0a4qmLitgGt2fiXu+872N1rZpOBvO/t9KSbf4yysHJz/HzAj9uO2Cx9r2tJe/et6J
         JcwcJ25z/q4HbMV9/S8oF53ddFwFfH/CyrcavmC3XE21I2/h/T5066Skzfgpg8QSR8fF
         Z78e12cDTI92bMXIxqx2hFE+WLfZOHzXFqTMXDO9PyLjJGp+7lJtHkG/+JMMTmmPT4xB
         zLPvuujJT97sy+h4gXnJPFHaN9rvhiw0XWyOLUkGmVZ112kUfxMrm8th34+pQT/oS1dE
         B+aQ==
X-Gm-Message-State: AOJu0YzZc57gGxXG6iwx7VdNQyg896J5PJ01NkGflGsjIwGqzoJeIhNo
	gtEt7dFRuP24X/jb3FigDp/YkIFkQiwQ+FNtmRzz7vYfKGIWzXIHri2+
X-Gm-Gg: ASbGncuAe709tiQ9y8TZQVebhk6xJeXqnb1eoi4JQVxwKwykHSZg2dnXjTi92PBXMzs
	/MUqVyF96+vNhcDCQCdpg4drVbr4nEH/ftch4E5gKYL6rHw4PmuuMocOp8P8Z7k4+vuW8vCXP3h
	iQqJvnmmCJ4qDEl3X4dQRYFSoDiWCION+nt6XLjVY+hckFUMO3Rodfwt11ykbKEjIZIkmtNw2Js
	2jUw0CeL8rf7A+YCs01IxipBdymrka92dazlK7BfmBu1OBJdIoqyOEjjOYjN4MFTI8Dd9ufTv6F
	N9ptytpxfoM4IiGgB8dvtZGZJataV2SA/mB7DeLIWvNbma/Pua2FnRPoeqFSxpE2umqzqSTC+XU
	GntgwvQrCx+sB6T/2IEECkTZeyBR68Z6zzod8A9Yo
X-Google-Smtp-Source: AGHT+IFhccSoMoOt0clDq1R5CDBIWX8hg30FplKcZE7h5wg3YTN2Hh81/fxYH0wN5lofMkp9y+4Gvg==
X-Received: by 2002:a05:600c:4450:b0:456:1442:86e with SMTP id 5b1f17b1804b1-45892bc5fecmr61870885e9.21.1753959354120;
        Thu, 31 Jul 2025 03:55:54 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:53 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/25] sched/rt: Add {alloc/free}_rt_sched_group and dl_server specific functions
Date: Thu, 31 Jul 2025 12:55:30 +0200
Message-ID: <20250731105543.40832-13-yurand2000@gmail.com>
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

Add allocation and deallocation code for rt-cgroups. Add rt dl_server's specific
functions that pick the next eligible task to run.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/rt.c | 107 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 38178003184..9c4ac6875a2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -93,8 +93,39 @@ void unregister_rt_sched_group(struct task_group *tg)
 
 void free_rt_sched_group(struct task_group *tg)
 {
+	int i;
+
 	if (!rt_group_sched_enabled())
 		return;
+
+	for_each_possible_cpu(i) {
+		if (tg->dl_se) {
+			unsigned long flags;
+
+			/*
+			 * Since the dl timer is going to be cancelled,
+			 * we risk to never decrease the running bw...
+			 * Fix this issue by changing the group runtime
+			 * to 0 immediately before freeing it.
+			 */
+			dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
+			raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
+			BUG_ON(tg->rt_rq[i]->rt_nr_running);
+			raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);
+
+			hrtimer_cancel(&tg->dl_se[i]->dl_timer);
+			kfree(tg->dl_se[i]);
+		}
+		if (tg->rt_rq) {
+			struct rq *served_rq;
+
+			served_rq = container_of(tg->rt_rq[i], struct rq, rt);
+			kfree(served_rq);
+		}
+	}
+
+	kfree(tg->rt_rq);
+	kfree(tg->dl_se);
 }
 
 void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
@@ -109,12 +140,77 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
 	tg->dl_se[cpu] = dl_se;
 }
 
+static bool rt_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->my_q->rt.rt_nr_running;
+}
+
+static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq);
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first);
+static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se)
+{
+	struct rt_rq *rt_rq = &dl_se->my_q->rt;
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct task_struct *p;
+
+	if (dl_se->my_q->rt.rt_nr_running == 0)
+		return NULL;
+
+	p = _pick_next_task_rt(rt_rq);
+	set_next_task_rt(rq, p, true);
+
+	return p;
+}
+
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 {
+	struct rq *s_rq;
+	struct sched_dl_entity *dl_se;
+	int i;
+
 	if (!rt_group_sched_enabled())
 		return 1;
 
+	tg->rt_rq = kcalloc(nr_cpu_ids, sizeof(struct rt_rq *), GFP_KERNEL);
+	if (!tg->rt_rq)
+		goto err;
+	tg->dl_se = kcalloc(nr_cpu_ids, sizeof(dl_se), GFP_KERNEL);
+	if (!tg->dl_se)
+		goto err;
+
+	init_dl_bandwidth(&tg->dl_bandwidth, 0, 0);
+
+	for_each_possible_cpu(i) {
+		s_rq = kzalloc_node(sizeof(struct rq),
+				     GFP_KERNEL, cpu_to_node(i));
+		if (!s_rq)
+			goto err;
+
+		dl_se = kzalloc_node(sizeof(struct sched_dl_entity),
+				     GFP_KERNEL, cpu_to_node(i));
+		if (!dl_se)
+			goto err_free_rq;
+
+		init_rt_rq(&s_rq->rt);
+		init_dl_entity(dl_se);
+		dl_se->dl_runtime = tg->dl_bandwidth.dl_runtime;
+		dl_se->dl_period = tg->dl_bandwidth.dl_period;
+		dl_se->dl_deadline = dl_se->dl_period;
+		dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+		dl_se->dl_density = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+		dl_se->dl_server = 1;
+
+		dl_server_init(dl_se, &cpu_rq(i)->dl, s_rq, rt_server_has_tasks, rt_server_pick);
+
+		init_tg_rt_entry(tg, s_rq, dl_se, i, parent->dl_se[i]);
+	}
+
 	return 1;
+
+err_free_rq:
+	kfree(s_rq);
+err:
+	return 0;
 }
 
 #else /* !CONFIG_RT_GROUP_SCHED: */
@@ -860,9 +956,14 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	return next;
 }
 
-static struct task_struct *_pick_next_task_rt(struct rq *rq)
+static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq)
 {
-	return NULL;
+	struct sched_rt_entity *rt_se;
+
+	rt_se = pick_next_rt_entity(rt_rq);
+	BUG_ON(!rt_se);
+
+	return rt_task_of(rt_se);
 }
 
 static struct task_struct *pick_task_rt(struct rq *rq)
@@ -872,7 +973,7 @@ static struct task_struct *pick_task_rt(struct rq *rq)
 	if (!sched_rt_runnable(rq))
 		return NULL;
 
-	p = _pick_next_task_rt(rq);
+	p = _pick_next_task_rt(&rq->rt);
 
 	return p;
 }
-- 
2.50.1


