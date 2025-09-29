Return-Path: <linux-kernel+bounces-836035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB7DBA898A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F481C2670
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398F1288538;
	Mon, 29 Sep 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gimy7TQh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EAA2D24B2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137763; cv=none; b=ZagSjVjDTky+MD5YHNQF73OjVQuV/DCkUchDjl1xZkDoVfDYkmN1Bc94ZeAIscfSB3e3HZAtz4AuRxrtio1trtq8dEqtzXCAQLUUJY0xj3iN93QCEDwhg0By1MWW5hxQpUP1FQdlMFKMcxXG/YdInd2jg99pY06Bp03tKlTR138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137763; c=relaxed/simple;
	bh=m3Pzi6tSvc0JP0+0C3UP/XKTq1slnjF8MBXLhDQOUcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxDOmBbgrUbJ8qklRvn0d4riA3Sc5mOV/FdkPR2OjMPKQcf28XjSGSy9nJf9MfyCvVt8CBaFRCV42eE8LQsOc2YlUSVWZcHTGkuAeCAKDk9H0oSEsPLgTiatWGE9TlqmwmpON3o+CU+wjoboQeMsmfVQ53InrvwPv61BLTNiqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gimy7TQh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so171782866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137760; x=1759742560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHFDxjqTBX2TNsqIiC9tqPpLk5YNM8tu+mV6Str/9aY=;
        b=gimy7TQhJOpOYNcWznj5egl0tOS0vXSt+esoocTIcAp35RjWWynqNzASjwgZnn2qMi
         1qQqCF3Fgo/YAv07zfaGl5yDpDtF1p/X9WF6EFvvT/bwZSmLGU0VtFLNjdMUoKwcvbYY
         4rRquAgQc/r8TT2A3i9Ifs2aj8PXD4gouPENMvc1SayK4LuIfOjUYXfF0yyG3JC8qGNf
         +OHohC0Z/CIqlxW2sZ0JWhpE3MEGyZhTq6DHLehrYvmNEuul6Po/yDjqg5Z7lqlkfMeO
         Kb3Dyl+vcapGDXgyMMfja2FN8fUJTRh4tBFj3jTWP2gagBINgpChHvtAzJEQDI5l+q6r
         DgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137760; x=1759742560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHFDxjqTBX2TNsqIiC9tqPpLk5YNM8tu+mV6Str/9aY=;
        b=PSz2E+tCI7GUNQk3s6K5qOZ2S2vEJFJuGaBpvYqaNCQITQgSEZ4rAoTxLYO713zzpQ
         99jo9x4FaQBef9xaKgsamNrfy941XEw/2fEuaTWAarhivCyRrT7FY1mPNUYub9YbPLWb
         U+oDHuEwcSDFSbbZmxIp7AF9sym8I3PbfP/aWn2g/z/EvU8a1bTLffYnhoussb9PxMbc
         6sWmd3K4eXBh6XZjkFOLM2kYzzp4OWatuZ1CWwQXOh0ogbM2E4YWXskf+riTq8bdqqwp
         RR64rIp+S+oLZnONm3lYfCQ+mMMrDJ6a2MOCF2Dpyn8yQ6lz9PXcR0xq3SL7CwmMjZVi
         w5Sg==
X-Gm-Message-State: AOJu0YwNkRwRQmqKrFSbEHYKW95081fV2pdAlRi8QDa+LtBfvM8o2p4U
	Rtk75OzRaRpmzeJEvD2pasonget5dvaA78OtZzAe5iKM3jvJWLoZfz+j
X-Gm-Gg: ASbGncsEg1cqDXHE///s+cb1F/aMTW/ILgDJFsKN4SW1uEEVUoDhUhGVZPNWOMXZnHM
	xskMljgZl6nVvgfKUzuTL/6k0RM+Qor8KTaoWAjIx5xZ54K7I8CCLi+6cEjbiQUhz40sgPEtIee
	oClSdjVKKam0MJJHrPv8ptbYc7MiFzpx8r5a/t9sMEjshE6zqf2AEk/dA/5BbPFHyfAwY5SUM1E
	EUydS2pXXtzd7yusDS5k3GvAFQ1WXuHIvEnVf6xitbEsjrv9UEJiRCtYzKwtyu+xlZyIQDv9sBq
	xuB4hzBLywEq8VMDLiZANkoSk/zGxgw5etfcuDVcKbxPw6LHFyE+mu8+5sDuxlv+U9z8uj03j9M
	NCe4Xvu0aU7Dyg0hgUYfqe9fnqfG2tA==
X-Google-Smtp-Source: AGHT+IHE7LtsON2OlCpiUTAE7zmHeLcehiCmKUGuR5VjB56xRGNZbhIyKHO+uH4Lp9o6A/bhRPqNBw==
X-Received: by 2002:a17:907:7fa9:b0:b30:b2e4:af3f with SMTP id a640c23a62f3a-b34b7fbb4cdmr1789721366b.14.1759137759248;
        Mon, 29 Sep 2025 02:22:39 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:39 -0700 (PDT)
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
Subject: [RFC PATCH v3 21/24] sched/deadline: Make rt-cgroup's servers pull tasks on timer replenishment
Date: Mon, 29 Sep 2025 11:22:18 +0200
Message-ID: <20250929092221.10947-22-yurand2000@gmail.com>
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

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/deadline.c | 6 +++++-
 kernel/sched/rt.c       | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index abe11985c41..27a5d5ffd39 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1290,6 +1290,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
 	u64 fw;
+	bool has_tasks;
 
 	scoped_guard (rq_lock, rq) {
 		struct rq_flags *rf = &scope.rf;
@@ -1303,7 +1304,10 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
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
index a864f569011..b09f0887e3b 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1,4 +1,3 @@
-#pragma GCC diagnostic ignored "-Wunused-function"
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Real-Time Scheduling Class (mapped to the SCHED_FIFO and SCHED_RR
@@ -153,6 +152,11 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 
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
2.51.0


