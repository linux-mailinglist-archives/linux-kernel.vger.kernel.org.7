Return-Path: <linux-kernel+bounces-751981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C796B16FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A343C545B61
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F942D2398;
	Thu, 31 Jul 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScXvXLmk"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943232D1301
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959365; cv=none; b=pagsJyl6EWTCYlPJu/rOZF0RRPrio+waH+NWhbHLbgfDPhxUmUtj0tm20ouvjEqkQ7NjYlEr09qi7h6m04Naaf7QdDz3DZhXAf3Def9I4ZtJl0GbRiRmSgqZu/o8v2hjganY6Qyz1+PsmolK6W8ZOOLosdipp58HJCz3bCDSolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959365; c=relaxed/simple;
	bh=33Z2Y3YOQwE+2eVhBbmvS1yb+JUXhQFuskeiQAMZ/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mX3PETAgi4bXR1j3y5K5rmflG3dRwezwhCWF+67zMfIyW6VeOzdiq0Hq5QD4wbz2r6seESvLHRfpPEmzMOQzuj06+A5oGhmBYsCEVYSONNNqST15rXP3IbauUy0ULqRIIuP+87mGJ0Tl8HFXuvBy97cvB9PzFzxciVyRn5IHPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScXvXLmk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78a034f17so658456f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959362; x=1754564162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UExeYnjsYht+iw9f1NhGR2WA3gC27Fs4pKhtTeEITRw=;
        b=ScXvXLmkN8UP52N82Gs6YPT0ps9j7/hc0PRYkd1ScJ8FTrVvRnfwSv8yKF8OQ41tdw
         VU3R/feYFysU4QMswkdvUjiqkdIsCon8eXjzs9pyUWle0rIp//yIHJYJN5p2lRfU9gZU
         voz9I+niHWEErNgHOQE+WZYG0/Lffr8i85LJbDxDqvJhzoixZKF8a7t9C0IiMh6Pk/4U
         owH83ueuLFD3F2reToQODX1RxeNUEDHvpeck+gdE3r4u1Sw++NKnCMlwS98/0SQvhpJX
         dnTXYuZjW52O/HsnhXdGKvCLE4RPEy8FRlq4r5FsFB2IkHF7omo5HhTIbWWVsLODWNth
         GMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959362; x=1754564162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UExeYnjsYht+iw9f1NhGR2WA3gC27Fs4pKhtTeEITRw=;
        b=fV4cTjcffV8K91wsoHxu1W7Rg9ZSZGWZurY1uDh4zNXeyY7DHoj+6W0YkqmmsmI/dT
         9xArt+X7MrpsDr3fGj5IxDirlh8MB/a2H4th4VyOmgCMqiBUIciSvDa3IoRJlmOkqYii
         jdJdoCzqoPnGZDLkQfjnbM5mVXihUqPjyeMKvYmAyP+twLXbjLVh1/bgvNyyrL5G0gdV
         2jZQY3tYEEI6qHCruUyLR8u8BQtTfpm4+ukKVXVYUPAy1ec+EYQtl1lFryEYpe7EE2fB
         l69fXJ29uATODv6n3O6Ny8z6+/Em78B2rcIusnDes93Pwp+9HYBi4vIWecVHh6bpRZt5
         AjGQ==
X-Gm-Message-State: AOJu0YzkEDluRFDtslk4qLXNCmmfJXB2lA8+AJeUwyAYzFUqBHuuUumb
	v2+DdplDd3lz3976Dy4U2ij+SQpn483mJCb62H3yIbPzVbNgdFQFpbD8BAPfRLY4LKs=
X-Gm-Gg: ASbGncslzoFYUkFxlcvaitylmIV1m9K8lmqQVk51fUirLN8NhqrBeiaqN84C/kuvsAG
	70rovltisFfi93I7csvt7admG2OAVq5yJcqA856rIqIZ6LraBTLA7jZaBX4ZhWCY3EDs6o8F0HH
	TkWLaMEF2fiVwYw1MpWH4fCdMEy+YNQ9vBGCZq0hcTjpVG7qUCs5hKH1pnzVB4p723kKXbMbSG1
	FCmSu2AHg3sXkVDE2ku/SZT/SQ6Aal7hQjDiScZXBhrWsaQyETlQDosNBPYYwAZT10oarJaObEZ
	1Go5RgMo7TFSv3Pyy1XfBrNzrUhJYrOGRo75Pp9OKJM3vsfl4Hn/8RxFKE8DweqtCafqZSexqCu
	7RRp8RE0/Odz8khUQt1PwQ6USl5vLKA==
X-Google-Smtp-Source: AGHT+IFMnFvjaD1MozpayBu55S0JsGLwx1gfUJPUN3Iab9yjfsTa279BuV0zO+Jai5iJv9FjhBCtyw==
X-Received: by 2002:a05:6000:288b:b0:3b7:9350:44d4 with SMTP id ffacd0b85a97d-3b794fc2be0mr5414578f8f.11.1753959361857;
        Thu, 31 Jul 2025 03:56:01 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:56:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 22/25] sched/deadline: Make rt-cgroup's servers pull tasks on timer replenishment
Date: Thu, 31 Jul 2025 12:55:40 +0200
Message-ID: <20250731105543.40832-23-yurand2000@gmail.com>
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

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 6 +++++-
 kernel/sched/rt.c       | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e263abcdc04..021d7349897 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1308,6 +1308,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
 	u64 fw;
+	bool has_tasks;
 
 	scoped_guard (rq_lock, rq) {
 		struct rq_flags *rf = &scope.rf;
@@ -1321,7 +1322,10 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		if (!dl_se->dl_runtime)
 			return HRTIMER_NORESTART;
 
-		if (!dl_se->server_has_tasks(dl_se)) {
+		rq_unpin_lock(rq, rf);
+		has_tasks = dl_se->server_has_tasks(dl_se);
+		rq_repin_lock(rq, rf);
+		if (!has_tasks) {
 			replenish_dl_entity(dl_se);
 			dl_server_stopped(dl_se);
 			return HRTIMER_NORESTART;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 677ab9e8aa4..116fa0422b9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,4 +1,3 @@
-#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
@@ -145,6 +144,11 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
 
 static bool rt_server_has_tasks(struct sched_dl_entity *dl_se)
 {
+#ifdef CONFIG_SMP
+	struct rt_rq *rt_rq = &dl_se->my_q->rt;
+
+	group_pull_rt_task(rt_rq);
+#endif
 	return !!dl_se->my_q->rt.rt_nr_running;
 }
 
-- 
2.50.1


