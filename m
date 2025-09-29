Return-Path: <linux-kernel+bounces-836038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF164BA8999
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781B83AB1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7442D481C;
	Mon, 29 Sep 2025 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt0rYXTK"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B612D3A71
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137765; cv=none; b=QgcGzvUw/tqIaT1b4wmWMO6q7tLEJlxbgrCoubuHguWgR12K0ck3C0PinD9Xc5lP9rPTUH7kkMPIeoJoV9FfJqfz6FGBoF6q/mZ1o48oom/xEn/Rt8ftLfLO6xaYo4g5UfrDgWAWO5QcXAXKKCONaafvBlJdITJCboRKdrALd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137765; c=relaxed/simple;
	bh=3pttDbYbABLZI5Kna45k6qR+8PXaeJRJV25CcDASDwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYkaH+ygZ4F+yOEADwfQMLZxknN+s9wnMlWKSou8UT9zqM8sdkSF0+KgzPi9U3QyF3BCbVrlbJKhmfJXh4DpOVDBlPfdVyL7xfXWZ2ClQy3IsltmKtHx1/vMCuBOOONsKH32eubplEXu/vX2JMybXZ2XmB0/2J7rxwJpZnKI6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt0rYXTK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b346142c74aso841712766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137761; x=1759742561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hleM5rVXWBZmpwO2/flr+0eqHP7XnDYEg6jHQEy66OI=;
        b=Pt0rYXTKVK+Rhk9SWfkv+QfoXt62BK35pvQzJPoBwepL+U3+bEnKFnBBC3mzX1uN8x
         zmQxE4zsJk01Fd7nvfG1awtrp98qRhWNDQm4P2bcAi5ivTrZsIBnVSnfT+S0flwcsXd0
         rzg8IIh6qFkF6tuLbIN/3qsx0AssL00+cRbmK+EnemvlNjoE5+HSrqSdmDoQD7Y4yKDi
         W4/Kdwctx9JyERoMiH/k7gi8T1ssLpqI7jhYaCOhxJ9KRpO6sx1fdupkBgAL8fr9XImZ
         asrFqL1bFET3m0HyiOoJvDS6S1l2zwOjteHiKTLtNf5CYDOXbe14RceS/F2LFaEVw8rK
         cvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137761; x=1759742561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hleM5rVXWBZmpwO2/flr+0eqHP7XnDYEg6jHQEy66OI=;
        b=sm9TLXctQ+E8I2uCQ55PL9YEb0Y7wt2ngpXpyBEudqVHG/2CrnuYTO2q02zrUuCct/
         gg+1P0SjB4uA+/0gt64dmGS8905CxPt7HNFc5dVG+dUtGOL5ahECYi5CSbdrbFwMR+a/
         pO1G22Q00bSH7x1gjGCcR0v0wBXWw7YYj/zMidBrfM3zrKuPbLcd6f2ECosTpWB4HTEz
         y0DVYPmxU3cCRdNkVuc6UZtpfC1UAd0Cp69DA3tS6jjRt07n1qLYC+6btxEM4EPgZLd8
         KJrnqeyKzzRugWYnfX7ljQEVSFHi0MnwXQb5tOZRIL1V/kZ5zfiArVYBqGyXp0XKgx/G
         zRRw==
X-Gm-Message-State: AOJu0YxSpppnAhuYybCNT17I5fYABPjxdvLhYW7r0qiDt82nDDzaDZIN
	T7C+EAojmMTAiO5ojdqcswXlxQe8PGZ8GFZec0Ttepo94vwN0ay7XbQa
X-Gm-Gg: ASbGncvXN8wm+8z5bJmxM9I8/ji9BsTWZTUbkhh0zp+OYnFopsEcDlGfgxM+AVyqbLz
	FPPN2VTWCmJ67e0x3qXoGz6Gw8dlILES58fvszpaxqYtdn+Pbb3l2FY2F9nub/KF5CoHnW9FMSc
	Zirv0XhZs1EgmiPWhkzh2cR6dLXxbjZd1UjZMPgyVkFJHCELnHoqNOPDA3PfVDNx/DbdUuSxJe3
	JBZm4x4SAs8wWtbz/wsWkx8rJbZ/CHYg2u5zL2V+3wwtneAtiFYC1F5uWx5NSRMgjZ0S8XqhIQx
	HHFp9Fc81LhDIoDbGY1VuBNxwL1ADNNClD9XPiQNl/g1fhWs2gk5MEa2adWrC8zotef+omxbPii
	T/o9v17S6c5KwqnIIXye8Ec4ogIk3Xg==
X-Google-Smtp-Source: AGHT+IGgZWI9G5c+HIV6R5gmn/yt7GQkHR4PiGN+xNFOQELEBVnt6zHE006xZsEcouAIhBZ+XhSBvQ==
X-Received: by 2002:a17:906:6a14:b0:b32:2b60:ee7 with SMTP id a640c23a62f3a-b34b77d9ed9mr1685371966b.24.1759137761385;
        Mon, 29 Sep 2025 02:22:41 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:41 -0700 (PDT)
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
Subject: [RFC PATCH v3 24/24] sched/core: Execute enqueued balance callbacks when migrating task betweeen cgroups
Date: Mon, 29 Sep 2025 11:22:21 +0200
Message-ID: <20250929092221.10947-25-yurand2000@gmail.com>
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

Execute balancing callbacks when migrating task between cgroups, since the HCBS
scheduler, similarly to the previous patch, may request balancing of throttled
dl_servers to fully utilize the server's bandwidth.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7639e9abba1..8d99a0c20c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9251,10 +9251,11 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	struct balance_callback *head;
 	struct rq *rq;
+	struct rq_flags rf;
 
-	CLASS(task_rq_lock, rq_guard)(tsk);
-	rq = rq_guard.rq;
+	rq = task_rq_lock(tsk, &rf);
 
 	update_rq_clock(rq);
 
@@ -9281,6 +9282,12 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 		 */
 		resched_curr(rq);
 	}
+
+	preempt_disable();
+	head = splice_balance_callbacks(rq);
+	task_rq_unlock(rq, tsk, &rf);
+	balance_callbacks(rq, head);
+	preempt_enable();
 }
 
 static struct cgroup_subsys_state *
-- 
2.51.0


