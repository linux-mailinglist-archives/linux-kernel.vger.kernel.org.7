Return-Path: <linux-kernel+bounces-835470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E7BA73B2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58BB1895F20
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BF2218AB9;
	Sun, 28 Sep 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUkLj1bt"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7F139D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759072481; cv=none; b=cNkB93IDPSWdH1PHwR2yNL3EJ4oLhLxLZG3cCMU5i6Zcu/ayF7aPmDeRZCQCAup0IcyvvkE5L3BbZlrsnuu4jySaE819WtrYx0FI2sKBiGj2dF/CyuTcAqOh591K3sMmvnI83b2pQQJaCw5s1SOFCBTCE7pqoKgew63lgus0aTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759072481; c=relaxed/simple;
	bh=CDMAwGb99g0u5zZtDjfzfeLGp6qPyMQ3iSXm2SNLDVs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NhxeNfHIR3i5dBFmYNaSInosVYQvmcwllOBbZbW7ce9FR1xDxngOegGpAREjFp4nsmicTWTI9DmcoUoKxzfA1kxVcN3ovKxb5Lfc2ONquYCJS1xaK6AKSRqpn4gv+9tSeZ1/JZeftFS50CP+xjW75VCylZhLdFZEz2QnUthlMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUkLj1bt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3853998b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759072479; x=1759677279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaB3l4Mr/O4ed0cROnds4AszeErwSzJiBj5Hjg3S0rU=;
        b=DUkLj1bt/Key+OEDAkflPPruZ//HaK1who/SQv02uuOas7xtv5JlZQAVEcm4BZLf/9
         WyL1mGI0dxX6Ma2uW2sqHXsOYkfTXBcxuV4KGQ548ldf9nykKF+/ymLHEnGw730+WFXg
         Jzvw3tjCphdcmzOQdMNkOnOBKogVRQa3bRMbzeFQRKdTYQSAywNCHf/Td4OmsqsbvTw1
         qjJqSwUjnn578hof2nbJbANIZkIGnGuEBi0l8sYlDjAxZIcxtL+IZPt3UbJUVBS5Zj/K
         XUA1E4FO+wI0+UKguVJpTgT5xd5Xgg7/XTsSgEgKbrgbJFs7+3KOWIx0k0QaYVx9rTz5
         2wmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759072479; x=1759677279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaB3l4Mr/O4ed0cROnds4AszeErwSzJiBj5Hjg3S0rU=;
        b=INSDKHVhkwgMU74n6C5u+P6mOyr+ibc2Hp0obZ+pFbfUdmm2oWIhHqbJCT9uwFLk8d
         EaNOKOvC0s+sjAtRyaxWf4IgD4KTfUm0S/WPiuLsD2/f8+xZ21dKYwC9wBpRAUtbIOpf
         duotvw28v3hBvcF29sJz2NJWJ93KdYJZexzA6qRh2QbrJZtbty1QS14IYW8+2jXn1G4O
         tEMdCfugp3Xux/5pZw3tpQgaS9xeu8OsCH0b493phqqUzf+wBPOfgxuiOjKY2PBGhdr4
         GkcYV8TZpf+7MLbZjc+p8NNceL+x0QiHeRgT4pD36s1LnqpUt2+FKb5HlppK3Q8AtLjq
         qGZA==
X-Forwarded-Encrypted: i=1; AJvYcCVx5pj3hF081FELY9gCdxd8MN0HdXJQqHB6M1zT+TGXjmwu+l94HI8/25oo4l8b+oB7E0l2HAawoZRuPK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROMXHtajE69iHNwvNQq7d/RzRYjf3af80gZeM6XeyC92YlbhK
	0Jb178lqnAs/wRrtDi1olEJOv0MUErlNj2gp9PlmA65G4+fnvDrEUoNX
X-Gm-Gg: ASbGnct1CLS+FUTiCqec4NL2in73CBGtmacqPkms5w1AyPEDbOXPMQq3e1WYlNuFLWS
	Djf3aHnsusV0F04DHM04Ce5xGpn8ENlIxwj+Pp/8Ppyx5psCCIP2EmdK8tbzafQmJ41ppLMqzDr
	JRPYHZ9hSIqTopxs7fWb0CRqX/7wTQN3g3qhETSNivDEcPbuS/ulSEV2ZHwzmybGueAJyi1hHpq
	PGKzrh4tVM7uqmE17sj4SpD0ODuYRqDnvfuh0jF/mwPUM3vWMHcwFAtzZzsEV4w5N+ACze/JFA/
	mqVkgci3GGrz+RJ0mcd8XHVGo8fjnlPov08Wk1CsZYTqdytGhlXv9GmiMTJrIxkN1mSYhVsEk+z
	dEjRyMGtwgOEqsEEslsogdlP7GFoLmtBf1BuQJA3jtW8WNVnq
X-Google-Smtp-Source: AGHT+IE4mmlOb2rS0tnqQhYepSyP8oTSLAYM7W8aDF1hwkK13jMWx3UYCzuh8SZVIhGb7llWLYYKDQ==
X-Received: by 2002:a05:6300:4ca:20b0:2fc:d558:78a9 with SMTP id adf61e73a8af0-2fcd5587a41mr6066982637.28.1759072479401;
        Sun, 28 Sep 2025 08:14:39 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7820d7020a8sm3127153b3a.93.2025.09.28.08.14.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 08:14:38 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jemmy Wong <jemmywong512@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Add _TIF_NEED_RESCHED_LAZY to __resched_curr check
Date: Sun, 28 Sep 2025 23:14:21 +0800
Message-ID: <20250928151421.60919-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TIF_NEED_RESCHED_LAZY flag can be set multiple times in a single
call path. For example:

entity_tick()
    update_curr(cfs_rq);
        resched_curr_lazy(rq);
    resched_curr_lazy(rq_of(cfs_rq));

Add a check in resched_curr_lazy() to return early if the flag is
already set, avoiding redundant operations.

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---
 include/linux/sched.h       | 2 +-
 include/linux/thread_info.h | 2 ++
 kernel/entry/common.c       | 2 +-
 kernel/entry/kvm.c          | 2 +-
 kernel/sched/core.c         | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4ce0a76831e..5946434b2dc4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2041,7 +2041,7 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)

 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
-	atomic_long_andnot(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY,
+	atomic_long_andnot(_TIF_NEED_RESCHED_MUSK,
 			  (atomic_long_t *)&task_thread_info(tsk)->flags);
 }

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index dd925d84fa46..a7512ab612ad 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -67,6 +67,8 @@ enum syscall_work_bit {
 #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
 #endif

+#define _TIF_NEED_RESCHED_MUSK (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
+
 #ifdef __KERNEL__

 #ifndef arch_set_restart_data
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 408d28b5179d..ac6eff43d07e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -27,7 +27,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,

 		local_irq_enable_exit_to_user(ti_work);

-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
+		if (ti_work & _TIF_NEED_RESCHED_MUSK)
 			schedule();

 		if (ti_work & _TIF_UPROBE)
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 8485f63863af..cacb24f0fc86 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}

-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
+		if (ti_work & _TIF_NEED_RESCHED_MUSK)
 			schedule();

 		if (ti_work & _TIF_NOTIFY_RESUME)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..15bf4b132153 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1108,7 +1108,7 @@ static void __resched_curr(struct rq *rq, int tif)
 	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
 		tif = TIF_NEED_RESCHED;

-	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
+	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED_MUSK))
 		return;

 	cpu = cpu_of(rq);
--
2.50.1 (Apple Git-155)

