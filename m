Return-Path: <linux-kernel+bounces-751983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879AB16FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA7D545616
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2F2D3A6A;
	Thu, 31 Jul 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmDDztlT"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118B2D23BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959367; cv=none; b=VHwroZLH1kxHketKRGv4EHMhRlMHstTnnauCKJMoJxGOJavM35/4ZUmF1/8tlKILZL4kIWzUxccN2Sf/DtvuNZ7CMqdkopC5xixFgBcUwwrQZdRywd0YK04oQkbHYnKSQnDF1ocKeieW3v6rurS+3YQkQaAGE84VxBnCVM9OICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959367; c=relaxed/simple;
	bh=CXH/nbHLh4BZqInfPZ2i20418s2hQeb0ON9avKB+N0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBqdD++Z/HTdRYi8EvP/rwp5hYFaTCTnjdq6UQGrNFncD+344O6MvxH4YXhaxbAqg5SGkcMFN1swTmH/S6V2YGc/snBSn/qxAawqHcOC8vPu5GXSQkqeHqJb8yrm9kjQUluqr4E+smFLm2+h2xjQ1B5MMdiSaiyscwksBItkCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmDDztlT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b783d851e6so837752f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959363; x=1754564163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aloRYfRZHcWQKm9mHZFlIFmOkTIhwAj/KWqtVi8IvZo=;
        b=EmDDztlTGrXPH6PfrT8ynX8uXIon1lgGft6GGL0m3toaRbk9g5Y/Kqg66nL8zAk9eC
         LC1ecbDpVHg/UtLnFiZyFhX2UrX/i8bdr731zA9+DzmjdrfJUN3nrqzNBgH8IXd6Fr0c
         ZrUhqkelVbJeVCWweHz8PfCGVAiYEN0h6ddemlXhO9lojLNYSM801jxY7VsCkdISj3h+
         Hqe8/cgL9Ppu+5oJ2u4JaspnoiNiH6JPBya0Elbflb56ku5CSYo4GaJnvZCI6wdnqBmT
         23nD2KQaA7/zXWHfp/CXce2Vrzgn+mZ2/ygtAzgCx6M0NgPMsdOtdIk/O5HMYnwR54DS
         m2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959363; x=1754564163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aloRYfRZHcWQKm9mHZFlIFmOkTIhwAj/KWqtVi8IvZo=;
        b=UvNgXGAE7d4A6/VkxJanIP2Nz1OA4jRJGrditE0WQCy2RXivRWIe/BQyF9NOiFwTlD
         lYtG+9bCCCYEgmthGnoFzumQ+ukRxo0E9mk5PKeay1kdvnxL959P7BlW0dGjtkv1mhwI
         RBoisAcuGKkvRJ2dSR5gjM7U2LNERNTIL79AbUVztpE30DDCCwvSxvfiow/hxeiptQrd
         FEreB+uVERmf02iszz3M2p5Zinp4hOplFfCeaE8OeBE7vx30jdvWRsU0JQsIrySPUDtg
         36SzcLyDb0MrtDbSgF3zwqT6LpzdVrFCWJY1P/xyyGcF106hSniXD5HNsy/Syuvj71nD
         xlRA==
X-Gm-Message-State: AOJu0Yz8FgL4qBrij/Ps8IxcnW42ohDgUNMYwyK9De+w47sgOM4cTttG
	0sr4+s2BMkIYK8/Wv8Cne/q2nvuaqM62b35L0q/gjjfBgYiToeuoG/Ty
X-Gm-Gg: ASbGncuFY2rfd+xIOLjWZ0lOgULTRuEOM2SqrmpUOK6obmc1m0BcpKY7rAru4R8Pe1s
	85BySvFAY31j6676mak2d1MW3pI6gIDtVrI3WDlpEN7bIwLk12lHdbrMj4J7ko9i/Vl+wM90Jlg
	4YiLt2kFq1SOgNVuU/WIJnDTnH+Gw3nY/H3nNfHD7qx7AoFeLlpoeHFiUQdT5jh8+KLXlQBQV2+
	//Y03FLETZjkSdv7Kk39dV7G1d+L8HmW4ZengWDYLLAcdUbm1nJy+FGIe3eH7aZT6hGBko2zGkO
	l06B6k7u2tjrVsqjMlauAAX7Ch4pNlnD9ZWIazd2zOKfLF98yf4YiCtVXPWZ9kPymd6xkljirhO
	pMIkIc6CCeK7GVwNWhNw=
X-Google-Smtp-Source: AGHT+IE2ZLE2HztsKXVGjNeZQAHYrlUVm+ngZJmjVVC6PQHo9dM2yJf52WCYd3LGT2NraaPiE+AosQ==
X-Received: by 2002:a05:6000:4305:b0:3a4:f70d:a65e with SMTP id ffacd0b85a97d-3b794ffe750mr4987689f8f.37.1753959363375;
        Thu, 31 Jul 2025 03:56:03 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:56:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 24/25] sched/core: Execute enqueued balance callbacks when changing allowed CPUs
Date: Thu, 31 Jul 2025 12:55:42 +0200
Message-ID: <20250731105543.40832-25-yurand2000@gmail.com>
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

Execute balancing callbacks when setting the affinity of a task, since the HCBS
scheduler may request balancing of throttled dl_servers to fully utilize the
server's bandwidth.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index eb9de8c7b1f..c8763c46030 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2947,6 +2947,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
 	    (task_current_donor(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
+		struct balance_callback *head;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
 		    (p->migration_flags & MDF_PUSH) && !rq->push_busy) {
@@ -2965,11 +2966,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
@@ -3024,6 +3027,8 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	}
 
 	if (task_on_cpu(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
+		struct balance_callback *head;
+
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -3037,16 +3042,19 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
@@ -3057,7 +3065,12 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
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
2.50.1


