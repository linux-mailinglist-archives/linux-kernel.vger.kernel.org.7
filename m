Return-Path: <linux-kernel+bounces-751970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D5B16FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1447B41F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE292C158C;
	Thu, 31 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR2U2bTL"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2912BF012
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959357; cv=none; b=BB8UYEdekO0NxUwW2flZbL605QzvfXP/9FBn/W6NpNeFeV6vuTk0mbjHHzXXcoQ06zkyPJFLHoHuNI5ZYVuJi+mJbeLRmHVZL3NDZjgn4uEviftuiqER8KechDw+h4iys5jc1vGSj797PZ1bRwj9tbbScKP42DBx2m5mly3yntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959357; c=relaxed/simple;
	bh=89Ej/L+xXNc2n2O1xoDK9fP54YtIRq9uSUgx+r+oUnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv1WfuM0vnNBql4tqy9DWo+br1VQnpw9XlvcyYDraX25ZjYontAPqj9UaxRZh+kGFiyyqNEFLW3+/zRNd82z3BJ1aqMkXWbDY/AgCWsuOIGT6SIuTJfxyOQUwkPT6UPg+Q4VpfvPJcZBk4Jjb3GvEE8jauQACJvck+XxSCIRomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR2U2bTL; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a588da60dfso136501f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959353; x=1754564153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv3iRJDYgpMDxRSvFG+C/LPY2Ji1gd5ewL7Azcb/wOA=;
        b=IR2U2bTLaxNmdj4AMbIya0JtPXbkS0KP6XbMmOIVrmRsAhtf+wnYR9ypYrcq/Hap+S
         FMP6ahaQ+xRdl1B4W0iVpelyrgftxifMLEcfVhLiLrAG0tgcmUFRpZ1Yka/hTuQFakT3
         4twQ/7KDLmyMTsTOE65N2fdJif6S/jFDLWPzC3h5t+GYYrIbAdBlP8b0dhItjDq82iBX
         GMNYnbe5lvzZQBxXPavyAmkR76RV/YZYpJsXysjY3rgEFmCIyJ8ii44cQLUjNmJeHX0Y
         NYGeDlCpON/YpEHfJGA6zrXyoTjeERMWlIFVorErXhD6jEXLeM6OGVPBlN86orv90UWl
         P2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959353; x=1754564153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jv3iRJDYgpMDxRSvFG+C/LPY2Ji1gd5ewL7Azcb/wOA=;
        b=eY+oRgZ2cEO/w6mDgTN9PWzy4QveLJeQvexQDqMEj6GnJ6g/CsPxj1Mr47DdTSxc2b
         UNZmWlIQJV3qSzXGBtvKw66OWBGpQBoUc7tNfI26k4UU9ZzLvtkMWx/DScPe4ZZe5UP4
         9vKBS37TgKBuT8qd9mDKlRyYg3Za4Wicdc83+xhoYOMSa3yT1Uv7EPFSFBTq52oONwtd
         KB/3rIFI95nTOYah+iF+fuUKZlxirkd21JTMN9WrJvE+Vn74yh+t78iW1LzDjBNAeSqD
         EXuuRYvIYjy3/FZurCpfjJIpn3SFIKyO1OWm2CJkKFP5+WKVlTsRIAGsaNVFnvGaBElR
         TXfw==
X-Gm-Message-State: AOJu0YzBxmQ+oeRUxn5Z5LZ5/PBymriGSodwXD8kDhkhAZJtcZXUI6yy
	5G/hb7Ntw3S04ci6b0JUduE4CObPzqD3RXKQlZo0itnKmpA8vLdpMBqg
X-Gm-Gg: ASbGncuSwLCJZg1qgc5PVL9hYHSd8iMJ+04x6MedHngsPaXstb/fzGgaDGyO9dSIhVd
	r0aHGPfi/UB5IHrU5uD7EJenncxkoa/9XThzfr5XdxN/2RvqvuK1r4TMfEwYLvTQb65jRwZDLXv
	JWhMCEP5V3iD00YX7b0s2JV+gvzp53D4niNlJ/D1viu2XLVGjx+9d7sCqd84ue1dUgq5OCLl28E
	WU49XbUH45sDY3pyJ1SOInXYimkIij68FjUn9/ZhSsUg4f8I+0URX5PqEuHDTIoGfntfg9BC+lY
	jNGrcHzNlJwhXSHlMAVfqK5wIMGcx7ONDU9w9emislPrZB41MPHj+q6K36hxf0RptHWJnK/Ep7C
	y8c9qoA5nRdoOEmqeBOc=
X-Google-Smtp-Source: AGHT+IHwTBBgUxn3U7tBA9I6lZ8ZpnW2PYiM9+n19M7sdQapa9jpb1FYib5G71azbdijP1XtbDK6XQ==
X-Received: by 2002:a05:6000:2212:b0:3b7:944d:e5e6 with SMTP id ffacd0b85a97d-3b794ff1593mr5393750f8f.36.1753959353312;
        Thu, 31 Jul 2025 03:55:53 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:52 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/25] sched/deadline: Add dl_init_tg
Date: Thu, 31 Jul 2025 12:55:29 +0200
Message-ID: <20250731105543.40832-12-yurand2000@gmail.com>
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

This function is used to initialize and/or update a rt-cgroup dl_server, also
accounting for the allocated bandwidth.

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
index b8228f553fe..264838c4a85 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -365,6 +365,39 @@ void cancel_inactive_timer(struct sched_dl_entity *dl_se)
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
index 3283d824859..611e3757fea 100644
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
2.50.1


