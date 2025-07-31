Return-Path: <linux-kernel+bounces-751977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA1BB16FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A587C1AA8314
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C22D12ED;
	Thu, 31 Jul 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfCjHFu/"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980932C325F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959362; cv=none; b=Xomafff9Y/ez1dPUtJQnGqgfTSH3ty/8RVafR6p/yu2E+Ei/JmHXeh6P7jFTM6Q7T5LGFLd3E/GriqYcQ5JZEukymyt50KXfJgVew/X4RUspHPCaPlTQ4E/xWSpGG1/AqV2khc4srQMd5dmzf4ouzEEJdMjKM6qlRmTMCeDcnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959362; c=relaxed/simple;
	bh=o3Xn5RS6R+mYhqsW2xGF7xOIDPgstLl2QFHTFT45Z2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD4oca8n58GOWD0uGSjo5mME3AoL0qJAtqvtn75CEtFMvEZQPGbYp/nXF71ag88cTQlAm/zct7ff/JaH9pL2M8nJJ5QrfJ9wtuOUwwwEhz6HyT8M1Lk189GlDA/wcP8rYXrBURjI0tx0q0iA/tYUp3KnjoPkhh0SNb2Ssm9rczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfCjHFu/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so485087f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959359; x=1754564159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hga7bxShN6VAEkqm5Kbc7Uh0UaKMqOrTHjafHB8ysB4=;
        b=YfCjHFu/IGDbj0RI5Cp41jc18+h6nxpXnBd3KWBpf0OSbRm6CAbia3ESA3xRVjv7bX
         1FgjsCKLCYdnEgRHGNl7qChoUGVy2E90zrfnB4204v/iiUSnXpkPt9FjnuaQhv4A3OgF
         czsqe0TKFqJszFhZdcbdiOu6K3aGbJ+A2f0QFC7iA8D2auPZHOc42T0qhoXEPb7l83yh
         pSAGqWgsr0nBtoV+SphHkQoT8Y9kzZzjcgzdgDI0sNn8a2kSza40jv7SBrHvJieMSdEH
         l4DahDETblIILKd069t+BwHICBg1qIxJCOnw2KTB2GJsoU5t0Op16LFeiHmI1JaDrmOF
         QDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959359; x=1754564159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hga7bxShN6VAEkqm5Kbc7Uh0UaKMqOrTHjafHB8ysB4=;
        b=H52R93KOSnXMOgEMFjyRl9W9988z9eSe/Iy8+jE0IojVW7p4csbwQ9wzIzo4MQJu6Q
         GJFg04hq+g9aLCumU2Xsv7XEG5o5m+7vv/6YiYz7hBw7heWCYCJQb4ns+26PWjXzoCUb
         oGutgCxrF9E6Uz10Im6ct29BWOIkSl61gHxarQp7kRc6HH+kBTW+oEuWAjF+zAaQ04tR
         7nFrZ9+3vTTRO9jnBlWvqXe/PBkpME3xNIZV2lg5nqSzcvYwdF++mpkUdwci10hvkhX8
         ZXPETV8qGVO1LM848XYX2bok1eQRF799kD16LEJYKpqeqiL08NHYd4tbBUD7NUG8qPLn
         zqUw==
X-Gm-Message-State: AOJu0Yzzw98bawPiU1H1eHsxRUW6tZh84n6KUvokHuUOi8XKZRDEXgzr
	ZrD3SdtMMW5Zue2NTxpGrWENh7LxacfiXz8WDja0UhTD9lj0Kr1Ixt+E
X-Gm-Gg: ASbGncu7XMEIdpx0f0QMIyWwuKAIFmSZHiKQzseKVYBAtiKB7eCzUbnejPK7qUsILFb
	zguhgv721d58H8KZmCDXeNZVuy1ZroEir418n9E0k8mmYsYI0etcCUQV1nlUVgh9dbcq+DvxFAB
	oMn56vpU58jPl2PpDRoKhhvT6PZBBpvSpMabTSA45tteY02OG8AAlDYGhcZXwsigtDfkaJkq5HX
	g/ovqMdUI8YpJr1/wUvT/WHC0otk+jfL3HLzgcEWUH876RuCwmhXw01rn+gA4AvD1ZchG8OyeKs
	WtBjuZGUk+MqlodAbu7yrKGIiX4QvrgjxS6DHezEF0gCZcQ1C8xuWebQ0efU/1ldM2dCFqGVwlH
	ktiEo/uoNty2Hy4ywjTk=
X-Google-Smtp-Source: AGHT+IH71lNuvewEWXshWp6RphVFa9Qi7ttHjsyjqaKAWvZYWD+0xxpmzVJ/76N9cq0nHmWFeHpjWA==
X-Received: by 2002:a05:6000:4212:b0:3a3:63d3:369a with SMTP id ffacd0b85a97d-3b794fc182dmr6057778f8f.25.1753959358760;
        Thu, 31 Jul 2025 03:55:58 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:58 -0700 (PDT)
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
Subject: [RFC PATCH v2 18/25] sched/rt: Zero rt-cgroups default bandwidth
Date: Thu, 31 Jul 2025 12:55:36 +0200
Message-ID: <20250731105543.40832-19-yurand2000@gmail.com>
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

Set the default rt-cgroups runtime to zero, otherwise a cgroup-v1 kernel will
not be able to start SCHED_DEADLINE tasks. The bandwidth for rt-cgroups must
then be manually assigned after the kernel boots.

Allow zeroing the runtime of the root control group. This runtime only affects
the available bandwidth of the rt-cgroup hierarchy but not the SCHED_FIFO /
SCHED_RR tasks on the global runqueue.

Notes:
Disabling the root control group bandwidth should not cause any side effect, as
SCHED_FIFO / SCHED_RR tasks do not depend on it since the introduction of
fair_servers.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c     |  4 ++--
 kernel/sched/rt.c       | 13 +++++--------
 kernel/sched/syscalls.c |  2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 85950e10bb1..3ac65c6af70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8719,7 +8719,7 @@ void __init sched_init(void)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	init_dl_bandwidth(&root_task_group.dl_bandwidth,
-			global_rt_period(), global_rt_runtime());
+			global_rt_period(), 0);
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 #ifdef CONFIG_CGROUP_SCHED
@@ -9348,7 +9348,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		goto scx_check;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		if (!sched_rt_can_attach(css_tg(css), task))
+		if (rt_task(task) && !sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
 scx_check:
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f37ac9100d1..75a6860c2e2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2122,13 +2122,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	static DEFINE_MUTEX(rt_constraints_mutex);
 	int i, err = 0;
 
-	/*
-	 * Disallowing the root group RT runtime is BAD, it would disallow the
-	 * kernel creating (and or operating) RT threads.
-	 */
-	if (tg == &root_task_group && rt_runtime == 0)
-		return -EINVAL;
-
 	/* No period doesn't make any sense. */
 	if (rt_period == 0)
 		return -EINVAL;
@@ -2215,8 +2208,12 @@ static int sched_rt_global_constraints(void)
 
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
+	/* Allow executing in the root cgroup regardless of allowed bandwidth */
+	if (tg == &root_task_group)
+		return 1;
+
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_group_sched_enabled() && rt_task(tsk) && tg->dl_bandwidth.dl_runtime == 0)
+	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;
 
 	return 1;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 7c1f7649477..71f20be6f29 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -633,7 +633,7 @@ int __sched_setscheduler(struct task_struct *p,
 		 */
 		if (rt_group_sched_enabled() &&
 				dl_bandwidth_enabled() && rt_policy(policy) &&
-				task_group(p)->dl_bandwidth.dl_runtime == 0 &&
+				!sched_rt_can_attach(task_group(p), p) &&
 				!task_group_is_autogroup(task_group(p))) {
 			retval = -EPERM;
 			goto unlock;
-- 
2.50.1


