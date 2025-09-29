Return-Path: <linux-kernel+bounces-836023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658B8BA8969
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD52C7A76EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951032C21C1;
	Mon, 29 Sep 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZTpFgTc"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7FF2C032E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137753; cv=none; b=N+PabZDLsBsUMq3fbL9IFd63tsoPo/3XoN8opIvDTTGXJrrSsCfPNbEQ92sJd4bNg3a1ekutHg70l5WrcXlf4vFBEQj5SCZGKHXN50het/liYKlHfDj2ZHKd50ybIWd1uXurUBMR+lkVe7AHqpwS3x9Diqqn4IKyDUOEFtzoOlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137753; c=relaxed/simple;
	bh=SXheP6/xZI9zCv3GztLGmkKg9TdEclhTg9jkgRMvDHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECpEb4PBLcl5d1YRL56W4lu3vAdIFhucKYdp6iaWQezA1cdl1gLfZOEeKwvgkvbJuuLgzaxkAnxjzv2CX5FgnAh8O9kHgf0DIaZ/e/l5DbB/xt7owunI5HM83kyrzx4rDfOJ88fidHxHWDJ/glXjbJ+F93doxG6tqi8KUOKzdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZTpFgTc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so6357045a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137750; x=1759742550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGK2m7a0HEycJlq9ku+st1/ytMVTFoHVuVKupFmTy4A=;
        b=AZTpFgTcQ6EPqDL9E2wEF+eY6uQ5j18iacynR/0wxqouEi8waPs0S2uAptIKnsCacc
         oS5Q9ODJPEv9kPQ96acQqMBRKgN+FEJBDkKPAAHIncTVG4rtqQxFBDOlPX2/LGdG/7QP
         iqJi9Z5u0VjYykt66w81xwlg7+HAj7iAkif1i4wJ5fRiNN5h5i8juR8BxbSMDD+Mzot6
         l+wyyt2OLTlCTUZpoE8wgHLn2w58qDpFWXbCwkQPOGp93pXTEtwxOcs/E0n0CQ5Xhedv
         A83bMU7tgwJNuSMC84Cp/1A5o44lmbsn8bv2mkbBnSUWWlRRfABUcFwWtE/9YJmZRN4t
         TSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137750; x=1759742550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGK2m7a0HEycJlq9ku+st1/ytMVTFoHVuVKupFmTy4A=;
        b=QRPd2UDjdjkg9Hrip/2NcohppJXKXHyopCMr5ykPuziK9PENGujf8jJ09ZJYVbdK2U
         lGuzX2XNC/7dXVfYionRH3dfQIcJUjtBU2Lc5cly4a9ub1u1gBFldWAm91LTW5+qGWJ7
         M0uBpuYnuTRvwNh58MF0kXjDzhpYiesXPF74XCN5zMBzse5nBik8rHBRNVRaup2jxFp6
         T0f4tZmZEXZ46+4LGlsqRTypS3YMv3Ijvi1H2NwE3dXosLgmg2xztckgbbGQA+hx2ATp
         XV2aU13VfPYeVc/oM3sSFMh0eirpzAEKuv7qsAD0OPicLQrAFoOYxmcRHiVkWKJBDhKV
         oOmA==
X-Gm-Message-State: AOJu0YyJ3ItcRFmb1DUZIP4hYIIvHTo5gXJ8DraOzQ8Q49y9Za09E4Ib
	JrgSL/pwnS38iGXRmjUfKCQQLsq7RLSnzEf9aFpesm91gvb72X1098tC
X-Gm-Gg: ASbGnct8i63C6sxSP7xDBXNiTHi1f9lGS4Lslp/ey5pX6zhjeA152/L1lS4QnE8/CwJ
	kUJUoR1XOG6AP6QRm0jvqP2bHWEh8IhMd8bLQTI2cszE88LWlzMBfHJZu5meTR4QbLXBlNootPl
	i3ic0hbZ5G47y892vVnUGwgrTqSRruOy5p6ixaSTYsY63hEq9vYXfq6DeNeThEyE+nX3GhP5MHO
	zdyDuqGBF0uBA36pEihW4k9d9pf+VnhxIKGxiB5VI5/ky6ADZl2IS50FFbcs7hqH796iUE/uzgd
	Tin7WOzD6ymWVBG3atuowmF6hNNPZJXjXqe/+WHzkgag5tWtvV0Vza7if1dvf6Y8Tv/AVsE1+Sr
	4hXM5X8LYqxXhpEw14uiSkvk7fKgDWA==
X-Google-Smtp-Source: AGHT+IEHhc2vnZ95ykOQEE9lhp4XhTYXnTApSwqPZRq7uMqEWUjgr0DvOUn5SQERoFKV0hhfVI9atg==
X-Received: by 2002:a17:906:478f:b0:b2c:bf1e:2788 with SMTP id a640c23a62f3a-b34bbbd9e1dmr1619575966b.39.1759137749950;
        Mon, 29 Sep 2025 02:22:29 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:29 -0700 (PDT)
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
Subject: [RFC PATCH v3 09/24] sched/rt: Add {alloc/free}_rt_sched_group
Date: Mon, 29 Sep 2025 11:22:06 +0200
Message-ID: <20250929092221.10947-10-yurand2000@gmail.com>
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

Add allocation and deallocation code for rt-cgroups.
Declare dl_server specific functions (no implementation yet), needed by
the allocation code.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/rt.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 84dbb4853b6..3094f59d0c8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -93,8 +93,43 @@ void unregister_rt_sched_group(struct task_group *tg)
 
 void free_rt_sched_group(struct task_group *tg)
 {
+	int i;
+	unsigned long flags;
+	struct rq *served_rq;
+
 	if (!rt_group_sched_enabled())
 		return;
+
+	if (!tg->dl_se || !tg->rt_rq)
+		return;
+
+	for_each_possible_cpu(i) {
+		if (!tg->dl_se[i] || !tg->rt_rq[i])
+			continue;
+
+		/*
+		 * Shutdown the dl_server and free it
+		 *
+		 * Since the dl timer is going to be cancelled,
+		 * we risk to never decrease the running bw...
+		 * Fix this issue by changing the group runtime
+		 * to 0 immediately before freeing it.
+		 */
+		dl_init_tg(tg->dl_se[i], 0, tg->dl_se[i]->dl_period);
+
+		raw_spin_rq_lock_irqsave(cpu_rq(i), flags);
+		BUG_ON(tg->rt_rq[i]->rt_nr_running);
+		hrtimer_cancel(&tg->dl_se[i]->dl_timer);
+		raw_spin_rq_unlock_irqrestore(cpu_rq(i), flags);
+		kfree(tg->dl_se[i]);
+
+		/* Free the local per-cpu runqueue */
+		served_rq = container_of(tg->rt_rq[i], struct rq, rt);
+		kfree(served_rq);
+	}
+
+	kfree(tg->rt_rq);
+	kfree(tg->dl_se);
 }
 
 void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
@@ -109,11 +144,65 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
 	tg->dl_se[cpu] = dl_se;
 }
 
+static bool rt_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return false;
+}
+
+static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se)
+{
+	return NULL;
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
+		return 0;
+
+	tg->dl_se = kcalloc(nr_cpu_ids, sizeof(dl_se), GFP_KERNEL);
+	if (!tg->dl_se) {
+		kfree(tg->rt_rq);
+		tg->rt_rq = NULL;
+		return 0;
+	}
+
+	init_dl_bandwidth(&tg->dl_bandwidth, 0, 0);
+
+	for_each_possible_cpu(i) {
+		s_rq = kzalloc_node(sizeof(struct rq),
+				     GFP_KERNEL, cpu_to_node(i));
+		if (!s_rq)
+			return 0;
+
+		dl_se = kzalloc_node(sizeof(struct sched_dl_entity),
+				     GFP_KERNEL, cpu_to_node(i));
+		if (!dl_se) {
+			kfree(s_rq);
+			return 0;
+		}
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
 }
 
-- 
2.51.0


