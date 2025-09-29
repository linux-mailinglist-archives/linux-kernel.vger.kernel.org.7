Return-Path: <linux-kernel+bounces-836028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E87BA897B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD68C189E054
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8262D0629;
	Mon, 29 Sep 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLpmd+8p"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0905286D63
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137757; cv=none; b=L6DUGp28hJ5ZjZgiyCQiJH9NgPrt771vmQF3AEDbrQAu0uYggL0XOJPfZJ+jXlMff5BxRmdasiMv8GOEmIE6NfEp6XoPyrrUZM33LCA9JArdTlI0FjUvNNb6UmGC42/2jvAbey9TUZQ247XZiPiRh4e6QBdR04fcKxFwES+HfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137757; c=relaxed/simple;
	bh=OE3e7QjLyUEcviZfsBugdK1SdHoykK0TuJW0UPWcFUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md/g+R/BLwE5reofGBFU4UBU7mbD1PTUEiXejjy6YesjRxiGJ9IxjS/inFgBTyaBv81Dg9FcAxPW/iSYDIm0LcvW//sfSpeT0HfBhkbFngeC2JZN2CQSfM+SoyEKDdAOUXPlLqtLoxnQykNVS9CdJ5fppghaWjjjDWr9k3K92Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLpmd+8p; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2e66a300cbso863894566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137754; x=1759742554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMlwnkxKk+zcMClE+vVN4lHuHMN3457FeNpmPjxk3go=;
        b=KLpmd+8pHmfI+tIF/XgMcyaZugDGFyD1S3v5z+vnpp+wmxFv9tTjUcOXGVt0epooJj
         O9AGzGfFfb5i45bbtE/pvoQxbqvB1k4bI+3dARi++U/UmEfn00vBMdcn3I+OoxZvUdPi
         CfyK0OvLutecw4iGizsaLIXmzRM8G5WlfsLOHbisCW1tZD+VW1tW0fJlVqsW7CZcDYxv
         gbYeZxNEFB9NciF2qVVQdGXCDHCnCNnnKbABKatYdSMfbv+2xh6HutE82U52gv4/fxDH
         WvkX/eUSmdMO5WOSEj5EMQweas2pBL8JjHJi/mXjSqWqlofU0uAIkUGWh7Yr9AjofGJ4
         F3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137754; x=1759742554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMlwnkxKk+zcMClE+vVN4lHuHMN3457FeNpmPjxk3go=;
        b=bao+PSM8qM36+Vsgl1bVWzsvokznjdEYduckkY5L1gk0zzRiobtrjFU0JKLiRkWfsb
         YGu/slu84ylpiQyVe2pFBVPzSHc5DySZ0reC6EYTujoSoojnx6QnULVU54ewkV/fXrqb
         jDe1ieJFyOshfOwsK/WsJqKQayd8M2RXdzFmw9M9ZHjwqcL7E/G+hhAjhQ28i9FfgRib
         KvlTe+Yi0LQROWeGTwEzUWRNdKUT+4vRIwru0v44aLc4vaOAxSNsuIouJYtEk8aiyG8v
         QP7TK5jPl3/BGE6AzcGL+Xc2DqpaYJc0DjLQzxs4+JyjsbL42ZrxesoFd06bHb8HsaiA
         LWeQ==
X-Gm-Message-State: AOJu0YzM7bnMpca7pGlPOGj9Evj5e/CNLrEDPjbLE/DaY/zubvjQOOEe
	V15sMaBXFnAMA1Svt99qprCkAAQUQizO2ixbh9lkSSeCL2PZWcS3Dr8W
X-Gm-Gg: ASbGnctgRgt5J46C/1x4ueb3xpJU9XH609siG4C+4I/cu69akOBpkEimAbJ1UyPCiGC
	bojbR4haYsQ9bZt2wJWdu4ihQGLgDrV+jOVdO8uDga6zI/gGISdcDHLtKvOPvF0ZTkZ2dd6WKzb
	KbDsJ6fGRoGwCC9WdmQrb1RAZar9/0gr1jJz76Bdc5kW9p+z39YeJ1QkfhXHOT2+PMP5Brr09y8
	HocimpC4HT8YNj6mGU9tVZb4c54JneBpVMM49KXr3kq+gg5L9ML9iAioOACz7NSdXK4XlysWGrh
	BNbjc8qdN5+6UyaIXFn45/K4YTI1Rq24eJT2iL5t44YgAhSF+1I4j4DD+zkG+X0MrFwOVn/YIYm
	KylYG9LZsWYenIBJ8QSs=
X-Google-Smtp-Source: AGHT+IF476mouee226vXmTR6yINrp78K5Vwc2/xGClwUm27zxjgQfBp+GLTogHG6L4P/AA+lzG+kWA==
X-Received: by 2002:a17:907:a088:b0:b3c:8b25:ab74 with SMTP id a640c23a62f3a-b3c8b447df4mr586947866b.10.1759137753919;
        Mon, 29 Sep 2025 02:22:33 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:33 -0700 (PDT)
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
Subject: [RFC PATCH v3 14/24] sched/rt: Allow zeroing the runtime of the root control group
Date: Mon, 29 Sep 2025 11:22:11 +0200
Message-ID: <20250929092221.10947-15-yurand2000@gmail.com>
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

In HCBS, the root control group follows the already existing rules for rt-task
scheduling. As such, it does not make use of the deadline servers to account for
runtime, or any other HCBS specific code and features.

While the runtime of SCHED_DEADLINE tasks depends on the global bandwidth
reserved for rt_tasks, the runtime of SCHED_FIFO/SCHED_RR tasks is limited by
the activation of fair-servers (as the RT_THROTTLING mechanism has been removed
in favour of them), thus their maximum bandwidth depends solely on the
fair-server settings (which are thightly related to the global bandwdith
reserved for rt-tasks) and the amount of SCHED_OTHER workload to run (recall
that if no SCHED_OTHER tasks are running, the FIFO/RR tasks may fully utilize
the CPU).

The values of runtime and period in the root cgroup's cpu controller do not
affect, by design of HCBS, the fair-server settings and similar (consequently
they do not affect the scheduling of FIFO/RR tasks in the root cgroup), buy they
are just used to reserve a portion of the SCHED_DEADLINE bandwidth to the
scheduling of rt-cgroups. These values only affect child cgroups, their deadline
servers and their assigned FIFO/RR tasks.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7c7622303e8..94693093b70 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2123,13 +2123,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
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
@@ -2216,6 +2209,10 @@ static int sched_rt_global_constraints(void)
 
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
+	/* Allow executing in the root cgroup regardless of allowed bandwidth */
+	if (tg == &root_task_group)
+		return 1;
+
 	/* Don't accept real-time tasks when there is no way for them to run */
 	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
 		return 0;
-- 
2.51.0


