Return-Path: <linux-kernel+bounces-836022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FBBA8963
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0A1189DE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC62C1595;
	Mon, 29 Sep 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqdNjNCT"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A29D289
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137753; cv=none; b=a06JGexzRc6FLnPXzRh+Vsj/gVG3Uqz2mWuwCnElaBp4yR3MWi3SaioEcpg9XKmgtlrCMxRi38DZy95vAd3lxQPbteywB3QCoXiUixbuXP3TLR+4cpQNcwlf+2bFrdBUuO9+9/EM1KLJdcKpsMg5fUb0jDCY+NLCQW+ROqeyeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137753; c=relaxed/simple;
	bh=PWg23h/Ek2S/NeMbR69Z43bG27wBpoR47R8x2RBYyUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqHnsTgM7hxydGFI4xRZqUFGxrReMxDYJjUkg/s/qtZXchhCPNUrdR9QZAhE2TK88U4YAnWw784chi1+CKfdTw7ZPb9r/WWv2pgIvC7Xg7heLCHr83qian6sQ6ixLBIj+CJPg5C8rtdp3L/CxMzAgduqjjr0EcpIkNd7ONq7UHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqdNjNCT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso145344466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137749; x=1759742549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzinNLU2Xw+DwWnbw6AoHDjNZrWmaSiy854G2AxZOYQ=;
        b=DqdNjNCTktLdIjyB1jRnvlSS1AIMMPmIn5aQ2fMnkfUnMrYEvX4Z2nWShvWkKkP8m1
         +HQLDfYnjE1/rLDh/7FaHms5rBL5wGW9RTnp0U/gVnYouhHVqv36BlSjmwwkoGcq2d8x
         4N+ZraRRyn/2Y5hvHM1MQe8BIBIK6sOh3KFb7sZuuTHrOFOAl9FDzbleQv/FACPpCxG8
         MZeKS8+dkY4WdwK78O1qe34bt+6AHberXjgmxPgDx3iZkY84pW9EYQZpuw3okAMPwdbZ
         pSlkm/S8z40r0DAPbLQFBQLMxbfq92VgVqOEn2cOrfTzGqp8+Mnqe/7Db0Vw0/NCG51l
         mt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137749; x=1759742549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzinNLU2Xw+DwWnbw6AoHDjNZrWmaSiy854G2AxZOYQ=;
        b=rFbd/7ah+oJLCTkdXZkXN8/vb5CyZNL/4K9Df2I8Pg0upGHPPWOBqitlpZF6mVUXEO
         HNtkRHOdP0x/Uk9DgZ+xtWfZdWja6oCl1C11ZeFWE1mmRYf5XDJwxqlVjhyMKgcQwnTU
         xIoCBYoDylnHhjnbVUHvi+Xe9H1QNKVu9XonrI8nqZMCAeEjGt5F4HCuGfkMacgj6gtH
         mkqYSieXmKo9jKVA5U1k0LQNkNXSZJChk1JAu8StX7nbjYSBRpBP2U6kwRQCz4V+hCIT
         vmaSgdPfMUV5S+pO8peschIbLdZqDqNcdxnvoQoY9EjUo/MDMHXImaa+6pilcDZS0n0f
         rghg==
X-Gm-Message-State: AOJu0YyTfcLJF30Y3yi3yuWR8IUKsmLD6zqd+V6Bz5eYs2H1i6N8fkNG
	5zwlOSf8aI/DNeBrAlAlOKGkBZpSA8ncekFSD0mTVfT0T4kbJ8miHAfk
X-Gm-Gg: ASbGncs4TNg/TKMrklQV4+f3m3soME1YehGCDQ0H//4uGiAXyuMBSRux959qa+ZJnY3
	wBDvHaI57xZnI+rrLPEEp6iBbpabbj5fav0+Mw/DU6HMkQgmhEsqt1uJh+BEeLx8+dOUKiQjesB
	0WdD/e+HPRWhbkhU+fOr3FDc2bKORpYfO+wkWsLiqe+j2ZPrNhHGOdqzuklIEqOG+64m0MIs3vM
	BXjA2tVzSxpbCs5CSVkGAoXOZaxj6xcdoOjrJq/gegLLxmCvFwUsTy43JIYbbesJM0TNBwkUCkv
	z2N2gj+qm5/Dw6RzZpEhlNHKuXyAFtK44ETr+pdDpD8PeJYz30+5pMcrabXtwBWH3W7Lg8vJPtx
	z6BM/jJuYOy+v6f+HhBE=
X-Google-Smtp-Source: AGHT+IHrDJdhCrtJ10dnGENNvCxknjjLx5jfwMqeniBulAcmXqVH9OCnuD6UTbGtexmXPkGEG/tv6w==
X-Received: by 2002:a17:907:b1b:b0:b3c:e14c:e24 with SMTP id a640c23a62f3a-b3ce15b5f15mr450740866b.13.1759137749207;
        Mon, 29 Sep 2025 02:22:29 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:28 -0700 (PDT)
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
Subject: [RFC PATCH v3 08/24] sched/deadline: Add dl_init_tg
Date: Mon, 29 Sep 2025 11:22:05 +0200
Message-ID: <20250929092221.10947-9-yurand2000@gmail.com>
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

Add dl_init_tg to initialize and/or update a rt-cgroup dl_server and to
also account the allocated bandwidth.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  1 +
 2 files changed, 34 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5c8fe80b585..34a1494d782 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -340,6 +340,39 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
 	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
 }
 
+#ifdef CONFIG_RT_GROUP_SCHED
+void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period)
+{
+	struct rq *rq = container_of(dl_se->dl_rq, struct rq, dl);
+	int is_active;
+	u64 new_bw;
+
+	raw_spin_rq_lock_irq(rq);
+	is_active = dl_se->my_q->rt.rt_nr_running > 0;
+
+	update_rq_clock(rq);
+	dl_server_stop(dl_se);
+
+	new_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	dl_rq_change_utilization(rq, dl_se, new_bw);
+
+	dl_se->dl_runtime  = rt_runtime;
+	dl_se->dl_deadline = rt_period;
+	dl_se->dl_period   = rt_period;
+
+	dl_se->runtime = 0;
+	dl_se->deadline = 0;
+
+	dl_se->dl_bw = new_bw;
+	dl_se->dl_density = new_bw;
+
+	if (is_active)
+		dl_server_start(dl_se);
+
+	raw_spin_rq_unlock_irq(rq);
+}
+#endif
+
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d433abe1c9c..9853f321363 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -394,6 +394,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick_task);
 extern void sched_init_dl_servers(void);
+extern void dl_init_tg(struct sched_dl_entity *dl_se, u64 rt_runtime, u64 rt_period);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
-- 
2.51.0


