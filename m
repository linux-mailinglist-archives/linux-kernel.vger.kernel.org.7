Return-Path: <linux-kernel+bounces-809890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B137EB51333
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D67648048B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BEE3148C7;
	Wed, 10 Sep 2025 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HlipuqdQ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0CD25DB06
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497898; cv=none; b=lxtPPzDSHA0lgQxgK31QvD3yYLwKVjvi+Xz131Rq6NXp2jrW1T9jxg5Y3kPEFHfqjJmXBrQIVR8bEuWZ9cKg2ZSUMeRmYKkg0mD7bI0/4Utt8oiOzi7MzO9iKRv32zs46iRGk3VXXBbzQS8tX8dFsKeaC4dlg2NNlVFWL5u6vZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497898; c=relaxed/simple;
	bh=e4TTFxWbfCAruZCvvckJLtHWN3hktCeBCZI+2cmgIrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMbL8VzC84jr11WCX6Nj27gjxQj8PRO8TsUW6nCNPFWalKwCIvIPshxiSmZJdwS8UGqkGYwI1mnwSw8E6F7L2BF2WROdzHwN8qK39e4qT0jlYZ7fSNwJtj4wuetHKb205vYcxkivu7RjLHI0YplD7+HMcH5CoEq0qSILl2mHkFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HlipuqdQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77460a64848so1505659b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757497896; x=1758102696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhkrDCBZE1HQCcoT5uSllVkcfT4YZeL1VIJqEPNvTDM=;
        b=HlipuqdQof6ieid0CQK8VUf6bCBGJ1oKJEyyBGixZues9NKwtJ37s9aJxH34UwFeDz
         dmeVTFB+qwm6K+y8gAdd+lUltJMwZ/eToksBVSkHTfEMcQCkGSPCCV5Nmx93YouIlNxJ
         ktNWRRU6+EZ9o9rZHdQeFx4JVIi6tJo1HtFi0kL2Kx34TCVDltK9qL5Rh79RLMw2eNIR
         gW6kOlO7KWdiQDcX86JGzkkz6yBwXmlP6txlswzZZ9Cnu8C8r8miRUYXdLHxCqYFzG5p
         1d8IeiGm4nDQIDnAXh29s99R99Tocst1txpE+2we5rTddWKD3PolWEsqhT/BIMoH7y9Z
         jRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497896; x=1758102696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhkrDCBZE1HQCcoT5uSllVkcfT4YZeL1VIJqEPNvTDM=;
        b=TYWIrjwMdbaB2SczYKyJhe3yQ2bxg6Xq8dqlCrntfQPF9rbxm3C3DKfFyGgNx2nv8X
         kg+ewnx4aC7SrBI1tIt7DdprlfbEao9fjhZ305Q8FrlL1UCNZtbgiWPU3MznIpJW3fgd
         +vfhjkT5Ts4qCtA9B9zxL2sajBOhcbVAYFuL/w1smkSqIP9jlvyVXkDMSyp1LIJjteFA
         xrW/91leZAfiBE8KMiT8cYw5uQwjGJ8CxTEePZweR4xQ3A+mu7dAi5qkp34CdGogWQaP
         IcTOeoL0tl4y2TLlHRTRRZPI2lzj3V5XfnuJp2YgAAZcX9296ABvjO5sjL2r+YvMHERz
         MC+g==
X-Gm-Message-State: AOJu0Ywslk6X9iJ+K1pF6vkQaQJWcE/+rQsWrzNlchkRKt5duT2zyZKR
	tvCZJy69HQOSml2pCjJxNr1p1LkLffdoCIyHCvcb1vSuBADFbL/0QpMLMvnotDC6rw==
X-Gm-Gg: ASbGncv2qHaaaorddj57DY/vaEB2rMmSiCi8dekrNpCgEqL5sbKl7xZEdbyJP17OEQj
	rmEIoZCJgzWxF23tbZ3vK41dvNXYnZ6HCAcdGJ6MosiOxfDdxdhvaT9ANLtVe37a2EpmCpTQ54O
	3+fMfX7pSPgt0IiFoCGxmuOz6jyxZ0igs4ZKXR539Nnum5f0nF/cuoTh9XCzF421q7WluGqV4lj
	s4TjwFyPTbeAx6r7Y9b/AMeqXisWDYPsyL5sRh3tX8YHdQ2SPSxdumqWeB0Yx4U2GG3/Z8Lh6TE
	Q5wP7oaAEnXG0lhDjw29vbld2s0SJAHoC+Y4+iTbwRxhRQubLZFUbac91/9BVOXlPEk+U6tzu5G
	vgdYDafoH340SAJsjvFvolkJqVq3mq+oZl+etZnrHtggEYU4EeYlDZdnOtIFekKQf3TfajnUrLJ
	fI5nw0Hgbpzw==
X-Google-Smtp-Source: AGHT+IFF3i3IWo+xqIZXLLhITk3nlcct04gm0352Icsw+69CRyxsMwcBjxoZ9MfilSofK0SnEl3ipQ==
X-Received: by 2002:a05:6a20:4322:b0:240:489:be9a with SMTP id adf61e73a8af0-2533fab5821mr21778099637.23.1757497895854;
        Wed, 10 Sep 2025 02:51:35 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548b81f5acsm1850623a12.1.2025.09.10.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:51:35 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] sched/fair: Do not balance task to a throttled cfs_rq
Date: Wed, 10 Sep 2025 17:50:44 +0800
Message-Id: <20250910095044.278-5-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910095044.278-1-ziqianlu@bytedance.com>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing load balance and the target cfs_rq is in throttled hierarchy,
whether to allow balancing there is a question.

The good side to allow balancing is: if the target CPU is idle or less
loaded and the being balanced task is holding some kernel resources,
then it seems a good idea to balance the task there and let the task get
the CPU earlier and release kernel resources sooner. The bad part is, if
the task is not holding any kernel resources, then the balance seems not
that useful.

While theoretically it's debatable, a performance test[0] which involves
200 cgroups and each cgroup runs hackbench(20 sender, 20 receiver) in
pipe mode showed a performance degradation on AMD Genoa when allowing
load balance to throttled cfs_rq. Analysis[1] showed hackbench doesn't
like task migration across LLC boundary. For this reason, add a check in
can_migrate_task() to forbid balancing to a cfs_rq that is in throttled
hierarchy. This reduced task migration a lot and performance restored.

[0]: https://lore.kernel.org/lkml/20250822110701.GB289@bytedance/
[1]: https://lore.kernel.org/lkml/20250903101102.GB42@bytedance/
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3dbdfaa697477..00ee59993b6a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9369,14 +9369,19 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
-	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU, or
-	 * 5) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
+	 * 2) target cfs_rq is in throttled hierarchy, or
+	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU, or
+	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
 
+	if (task_group(p) &&
+	    throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
+		return 0;
+
 	/*
 	 * We want to prioritize the migration of eligible tasks.
 	 * For ineligible tasks we soft-limit them and only allow
-- 
2.39.5


