Return-Path: <linux-kernel+bounces-836037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE56BA8993
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91813BB1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74F2D47EA;
	Mon, 29 Sep 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fxgz0vuJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284A2D3728
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137764; cv=none; b=fI4o91tEze9CXK8EHrLEj9y7jkknqAo0A0Z/sXuYV3pHaTxAGMf3ryez1uti1piBJQvpfZdI1mJPAhDQfYnFld6nitXCKXg0wFdQRoKTxK6Y0/D8g3F2hFHU/Dqekc+83QfmONiVmtlvCcDrC/NxU7hIPWBOO+E9wNE+AQGv8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137764; c=relaxed/simple;
	bh=dSTafO0Wfmu1tsE0JuYHYquZxnO+mteeMPPolrhjE5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnxG3SiVOyf8M+z6dOO+Ekhl83CHgL5T2topPQTpqg4cUkL0FBjKiHSRyxZ80lzF3p9QVXagLYjoQ3pl0ptUfY/QEJXOugoawRbqgSWnjFtPLGu0sQjHYnJXeiqgglkQuBEOwK3M28xR9K+/UhCANSva5yLYccEMFlJXc9G8CHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fxgz0vuJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso9149933a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137761; x=1759742561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3P+b1nntEpP8NlkC2PbHvgc9UNBVCKeA0Cy8fPRIVo=;
        b=Fxgz0vuJpY2oSWco7+W7PiGBJs/Z+vRsWm45+wv1HI3udqyWHncidmW6Ofsi8fc8fR
         i+No1EUWa33d9EFkfaXgr3BkA1MDcQ8cW1PZikNrqqFz7hYkHz0+CaHyfQwPWhdFjvps
         3fkLUKnBiLXYbH+VrucWuvOGh+dg0pzQcTJ5M4+DC9GIcrJ4JhIxGwCPx/RlVtmrpemY
         ewtPcNSiQcyvaC0sBhCgcjfsRAnmcFVKpGRZtob8HiyaB3DwFWBwGyRcygeD8y1H9xw5
         iaGQYjgdbOkdtR1ltAwGB6ymY8xhI2xhP7KjhCV8d09UQeBofBtLzEX3sYCEyEvEctcx
         ZlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137761; x=1759742561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3P+b1nntEpP8NlkC2PbHvgc9UNBVCKeA0Cy8fPRIVo=;
        b=CEzAVON183HTi8XqEUtEuPx7e3QezWpx/BT6rIYOLstGeHeAytI5wfJc+VnEe15QF3
         T09MJ1afk2+EHINRq2ypUUw2rsSk72EBlYw3soj5fuCRenLhgo61UpqvYII/CnyHMgBD
         Hgpg2GhpMiL0ayJaJfeD4mm0PxNucpT0w9oqklsjmVYknM7fMR2O8FOOKlPr3Wdh0ONY
         7+rmiN3ZoDBtz6i5D7MufQLodmbqxWsvhlOwh/GHjlZnZpVZK6O4Uqx9cfzY9WwHKU1h
         RvJ/AJBY+pxOnqlU0NRlbDB7Xf0II5wHm1Dj6aPL0Jk1uE++sTPK/NFVL+D0ClO0ihGl
         umXg==
X-Gm-Message-State: AOJu0YxWUpA8DfHbifHVoslZPYAfnueQShsdDhGdkTGpGDu9ZDIUHNNw
	IolHfFxN8gs9s1FcMmH9MAo5k26P3MHkJIAYVO6bqlsql4PxEjQ3GUUL
X-Gm-Gg: ASbGncv5ceykN/Jk0fl6jIOhxf9IW9qC0/486ZbnpiUEcpjE2hS/M/7szqNXaHSts5v
	YXBnDpQkcTBYeN6ELxtnJC8I24YpH8Ippyz3CY23MBgVXPVJibQdPhMD0Rgs/zFLYFGHfhqsqX5
	StE+mvm1LC0JsuM8pUYTTraKNnUx4slY1NCxSyc8DskjmAmTkF3daY97RZ2SrWHMzFsa74Rc8Uw
	lBjigu0nixLidW+gPflGs4USz7eA/eBm65H9Ev6mVTHcNXyIN2hPr6kk/vcA4jSkIYu0HwGVyZW
	yBRDIVIFlK3PUXs0K7Gm5P9+cKXnsIzZC5FjOoNmabGUN6JB6Ot9jcewlHZTjAYPeDQk9W1WU9V
	qWigXWmlQ49VEe4+ap3uGo4nL2UQFjA==
X-Google-Smtp-Source: AGHT+IHgoR0hf5g2HMHuDmYVCAC33uJarphDIsZTc//ymRvUrt3I6JVghWnibJc4SlH583MceQ0OWA==
X-Received: by 2002:a17:906:f586:b0:b3d:d6be:4cbe with SMTP id a640c23a62f3a-b3dd6be501fmr494957366b.18.1759137760701;
        Mon, 29 Sep 2025 02:22:40 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:40 -0700 (PDT)
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
Subject: [RFC PATCH v3 23/24] sched/core: Execute enqueued balance callbacks when changing allowed CPUs
Date: Mon, 29 Sep 2025 11:22:20 +0200
Message-ID: <20250929092221.10947-24-yurand2000@gmail.com>
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

Execute balancing callbacks when setting the affinity of a task, since the HCBS
scheduler may request balancing of throttled dl_servers to fully utilize the
server's bandwidth.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d1d7215c4a2..7639e9abba1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2950,6 +2950,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
 	    (task_current_donor(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
+		struct balance_callback *head;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
 		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
@@ -2968,11 +2969,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}
 
 		preempt_disable();
+		head = splice_balance_callbacks(rq);
 		task_rq_unlock(rq, p, rf);
 		if (push_task) {
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    p, &rq->push_work);
 		}
+		balance_callbacks(rq, head);
 		preempt_enable();
 
 		if (complete)
@@ -3027,6 +3030,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	}
 
 	if (task_on_cpu(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
+		struct balance_callback *head;
+
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -3040,16 +3045,19 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			p->migration_flags &= ~MDF_PUSH;
 
 		preempt_disable();
+		head = splice_balance_callbacks(rq);
 		task_rq_unlock(rq, p, rf);
 		if (!stop_pending) {
 			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 					    &pending->arg, &pending->stop_work);
 		}
+		balance_callbacks(rq, head);
 		preempt_enable();
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
 	} else {
+		struct balance_callback *head;
 
 		if (!is_migration_disabled(p)) {
 			if (task_on_rq_queued(p))
@@ -3060,7 +3068,12 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 				complete = true;
 			}
 		}
+
+		preempt_disable();
+		head = splice_balance_callbacks(rq);
 		task_rq_unlock(rq, p, rf);
+		balance_callbacks(rq, head);
+		preempt_enable();
 
 		if (complete)
 			complete_all(&pending->done);
-- 
2.51.0


