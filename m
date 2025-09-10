Return-Path: <linux-kernel+bounces-809888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC95B5132F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2851C25D56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8031DFF7;
	Wed, 10 Sep 2025 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XC8QF85z"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0306E30EF69
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497881; cv=none; b=icTOjtwhYHpVuyysP6AsYWpvWlP6pxbBS39Ac5fQBRYtBUmGl5tWHQRRK+ffXijJYIVxV+1RXDTr/osub28jckxrGMj3cmDjuc67yUpm3CpkurPCVNDuPzuDv01Vx/camWYARvoG+anhPjQlScUg1uX4yk8vCy8X7rC3AmWg0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497881; c=relaxed/simple;
	bh=dQarK1+MK5EzNxypAdjzskSxZASZk2eoueH4p+weyRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BV0oyVBAFzHDUVbN3+3qc/jYsJsDAd4SERs4OI5KVeP7kIZgevS/abJsFgkmL5nJM8xcP0uiVCWliioSJcJCOqMMnzNGh/kGbliekQW1+baB98Z28JNXPg/V0+swUpecWjnQmLLA8k60FOujR1mWZmRAOVUEQ4V9e7p0F/0h3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XC8QF85z; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7742adc1f25so3172859b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757497879; x=1758102679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNuQPZfQnXL5EQi47WEKgLiiG7HGygdxhbHZFwHI3wY=;
        b=XC8QF85z1as/9B5rUq8KLmbD2p391Ofy58oIR767GqUE5tG3OFe2ss9BuSnxBjqv43
         On6SmexeN2fI99SeAIqwyu/b2N7G3YKrO1xg0jA3oxlI5YR7is4Ic84Encc+kaOud+Ec
         vTADPa6f+xCJh+iLMxlgrkK2eWop+a8X1DErDkj+8YqkR+FjGHdvo4jHjXezpmLyVnSa
         O3Yayq7GcdUsqQoi4oPkwwqnwOSS1WF13bLPCoB3UzvWLRE9zhl+JPsdeRI3ATdNfdLt
         vWVi4X4Xc47nCz3/Z4MAeaKLAjBrQefVgi+lcidmuHez+NtaWREqmfA110ap0LEfMPIs
         AXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497879; x=1758102679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNuQPZfQnXL5EQi47WEKgLiiG7HGygdxhbHZFwHI3wY=;
        b=ie9INUJ57Ux+T5SZiU91GYFg5B7lLJ3C0n+qVjlFflJvkv4fB8hhedYpGbtYnqrc06
         CC9dpu4DCPgbNCR/d7+KLzkezek4wpJFDANazD5AePOcYjsr3OwoGRlPh03Nukm0YEVr
         QKs1k1j2iCeL3CAsVLJLQzPUZo5LJf2qckOFPYHC/k7j/tWBOn3TTL2BdVutCGb6HFAi
         sRheIzC7g9PuSjPTDSFK4crramlNpCnJOjvwiNzDgmRb7TwQXTyAsy4RRTNZ0M1hvrj9
         rWc6+zCwlH55AbCSbku3KKqbkHEEAjAWoBQm8D+cDmFg2K4zKSHhYMzh6yb6zx54hlwb
         iNTw==
X-Gm-Message-State: AOJu0Yy2PRFU/SJ+HcK4lZ/1XiO6xSWOBaBO4H+Kblj+EL7Dyv+x9rIp
	Y5QzZuuWUnXq6CvdYmPeFe8tyMXSsLoNLBjpcnWom6iBBe4FE4yRVFlZMTeti+2dqQ==
X-Gm-Gg: ASbGncuCnh2UYNmxgPHgFu/Ni5C5oBQZ7p42D8AVuHiR04sWOA+2I6PBKGrkSon2O7r
	SusEbzTl3sO29LTziV1T0duzxn0pNHg40dHW2IENewbdwPpVd3slXEyNJC1e8ndaspYrXz9TqCo
	3d96EFbsrkwXiCo4s26Xhi3FubwK/GzV5gZQ96cs4+ZSj+OjQVHl9ZaGV1KIpL88T3OElCe0lVG
	pYXKd3xp+VH8M5bvGLbVSbrkPlZmjoMuzD55hubEngDRb7r+s9Pj/QSbwDA4YNVi6SvMlKKigwF
	cl4+nZQVz41LdGQ9FlaboOuujUUfl2EeT1jMqwu4fH8/VSgzrgznHy2B4iENX2JTHQAXZNgjB9e
	0r9ltSGIxT0iOmPq6LQ8wy7hkNnztWuIy7Ah9ucZUgFW8gJE3IwCOqbCZsHyUC92XNggOX96Ypn
	gXlqTJFeBqm3KeFUwMy9ly
X-Google-Smtp-Source: AGHT+IE+NhmrnNJXNKSVjlTjp3RxW0RpcG97OXtafHQj59Kmvoeb2Vs8PTiln/f9k4O08wu9UzFDkg==
X-Received: by 2002:a05:6a20:244b:b0:24f:b82d:424d with SMTP id adf61e73a8af0-25341e68314mr20868884637.37.1757497879205;
        Wed, 10 Sep 2025 02:51:19 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548b81f5acsm1850623a12.1.2025.09.10.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:51:18 -0700 (PDT)
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
Subject: [PATCH 2/4] sched/fair: update_cfs_group() for throttled cfs_rqs
Date: Wed, 10 Sep 2025 17:50:42 +0800
Message-Id: <20250910095044.278-3-ziqianlu@bytedance.com>
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

With task based throttle model, tasks in a throttled hierarchy are
allowed to continue to run if they are running in kernel mode. For this
reason, PELT clock is not stopped for these cfs_rqs in throttled
hierarchy when they still have tasks running or queued.

Since PELT clock is not stopped, whether to allow update_cfs_group()
doing its job for cfs_rqs which are in throttled hierarchy but still
have tasks running/queued is a question.

The good side is, continue to run update_cfs_group() can get these
cfs_rq entities with an up2date weight and that up2date weight can be
useful to derive an accurate load for the CPU as well as ensure fairness
if multiple tasks of different cgroups are running on the same CPU.
OTOH, as Benjamin Segall pointed: when unthrottle comes around the most
likely correct distribution is the distribution we had at the time of
throttle.

In reality, either way may not matter that much if tasks in throttled
hierarchy don't run in kernel mode for too long. But in case that
happens, let these cfs_rq entities have an up2date weight seems a good
thing to do.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f993de30e1466..58f5349d37256 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3957,9 +3957,6 @@ static void update_cfs_group(struct sched_entity *se)
 	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
 
-	if (throttled_hierarchy(gcfs_rq))
-		return;
-
 	shares = calc_group_shares(gcfs_rq);
 	if (unlikely(se->load.weight != shares))
 		reweight_entity(cfs_rq_of(se), se, shares);
-- 
2.39.5


