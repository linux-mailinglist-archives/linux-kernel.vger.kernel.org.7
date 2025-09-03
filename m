Return-Path: <linux-kernel+bounces-799329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBCB42A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934BA1887E92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9673336997A;
	Wed,  3 Sep 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAqFij9G"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021636808C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756928711; cv=none; b=qGlJRnaOyBZdgvxsutWM9ruqoy16IeAQWOzyawCOLsQF5eK7o6Fi/1aAab96tfMFGUUEvoediS086FqKvAyDXrAMNJrFvCojeylKS3IPWIkfBohrm9GGb0dE69ycTJrkEmMkF/8wJbT0uG0pt55me0tlMGleEiLsGfQ3W08VqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756928711; c=relaxed/simple;
	bh=7IEWcm8us9vmBMU3584kE797tvzwdo7OwGXxguuwARQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VdIVIVB7+PHwzgF4GYxX2SSo9RzLe4KyyCizJQbx2qW5UDJsM5qZQ3hyTHUvUVlFoDvoMLIurc9CZHhkCR4bA1TUIr64uPMPpyl6uCvLp5tR1/JXeORNpb92dY3cMxquzuKivx2h5KTt4lShLrxC6DYiARNLm5VebNTXqT65rq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAqFij9G; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-804512c4373so60037385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756928709; x=1757533509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPmZgpH78dyHbtmHWdLrneqqYQ+ydVlA4Y0sZXa+eVk=;
        b=RAqFij9Gcl1eGj0dY3HfHktHL+oL5I1N277FadHAusUArPOwG+rsfAcv7HEdAaP+qs
         XtFOBuqlYleQ6OOxWEGHYqTLbTafr1Mp+2pomrYYokroYD3WD7Ejyr9gPctwL+Q0RlQf
         XPAN+yNvjY66UnugCk9QgFFv/m5ctlrI14O5NJpSl5kuJYG6d+dTZMYb5Sp3NoLNmGAO
         DkZA9fQGwafqVbfZBT1m2cObwwb9ndPmFDQi8GJWDtBlk3aCZidsXV9mG6v7rhsfA8rx
         jRwTF7aAUKaD/0bEHX8RCVMjHgxTy39pTCB2BSzZq/239hW08vsttM593CDn4IosKixI
         2tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756928709; x=1757533509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPmZgpH78dyHbtmHWdLrneqqYQ+ydVlA4Y0sZXa+eVk=;
        b=LQFIi31Kahnz5ADmzZDcD1+PiMPj3Rok8tplcSuvQX2M+llZL9yl76rOXFlKWEnxZo
         7W4eClDtjm102Hjol7hfn04EZNn3S5q/rNNAwpa65j5POoDqz/QOg7EYyQWaNxnisH+c
         vsKjPQ2fEHC4rUOD5dxV0wwdOYyvbtqfsizV8eVkyorzTp8k6DSZ5qJ7BD4V+xYdTL8U
         W544dDU9DgBKi8QQbIL2lK9QlL7WhZ45nVpdmtFu6EoDbJgiTLTXENskjBhvOckZD0Sx
         bwnSHh/GaoA1Uw0RqZtQZxtW1sXCCMkHPJUfaoQCfaBeN/xdy+L/SbXPHaGPdUw49J2K
         ld8g==
X-Forwarded-Encrypted: i=1; AJvYcCUUb8W3oHtuz5S0+OoxkPFRPhed5TAfYNwfGTjERWq6iwzeslvAshOcKC29v04YMwBj9H0vyTVWlXIbK3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI7XxQHUEXLgFelsOWTMNo2fcnsEfBfEMIfUPbQOwftC0EJmUX
	RtPxvjpeZYYHMKCzFo00IChofzsCl1j4+Zyu3lDr2U84NNYiuL2F3m+4EejbMbWJg4qT+4CBmfL
	rZx3B2Ke2WA==
X-Google-Smtp-Source: AGHT+IFG2nR6q1V9H6XX2gR8HGprCJoeGE60Pt9bBvsRouwz10WVe8PH4nhkKWJ6ijEYAfSVxpBEwSLhx64d
X-Received: from qkbdx3.prod.google.com ([2002:a05:620a:6083:b0:808:15f9:475])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:a80a:b0:801:a5f7:1645
 with SMTP id af79cd13be357-801a5f71a68mr1334143785a.85.1756928709114; Wed, 03
 Sep 2025 12:45:09 -0700 (PDT)
Date: Wed,  3 Sep 2025 19:45:00 +0000
In-Reply-To: <20250903194503.1679687-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903194503.1679687-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903194503.1679687-2-zecheng@google.com>
Subject: [PATCH v4 1/3] sched/fair: Co-locate cfs_rq and sched_entity
From: Zecheng Li <zecheng@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>, Chris Mason <clm@fb.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Xu Liu <xliuprof@google.com>, 
	Blake Jones <blakejones@google.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Improve data locality and reduce pointer chasing by allocating struct
cfs_rq and struct sched_entity together for non-root task groups. This
is achieved by introducing a new combined struct cfs_rq_with_se that
holds both objects in a single allocation.

This patch:

- Defines the new struct cfs_rq_with_se.

- Modifies alloc_fair_sched_group() and free_fair_sched_group() to
allocate and free the new struct as a single unit.

- Modifies the per-CPU pointers in task_group->se and task_group->cfs_rq
to point to the members in the new combined structure.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 kernel/sched/fair.c  | 23 ++++++++++-------------
 kernel/sched/sched.h |  8 ++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e..fc8bc2d4614f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13321,10 +13321,11 @@ void free_fair_sched_group(struct task_group *tg)
 	int i;
 
 	for_each_possible_cpu(i) {
-		if (tg->cfs_rq)
-			kfree(tg->cfs_rq[i]);
-		if (tg->se)
-			kfree(tg->se[i]);
+		if (tg->cfs_rq && tg->cfs_rq[i]) {
+			struct cfs_rq_with_se *combined =
+				container_of(tg->cfs_rq[i], struct cfs_rq_with_se, cfs_rq);
+			kfree(combined);
+		}
 	}
 
 	kfree(tg->cfs_rq);
@@ -13333,6 +13334,7 @@ void free_fair_sched_group(struct task_group *tg)
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
+	struct cfs_rq_with_se *combined;
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
 	int i;
@@ -13349,16 +13351,13 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 
 	for_each_possible_cpu(i) {
-		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
+		combined = kzalloc_node(sizeof(struct cfs_rq_with_se),
 				      GFP_KERNEL, cpu_to_node(i));
-		if (!cfs_rq)
+		if (!combined)
 			goto err;
 
-		se = kzalloc_node(sizeof(struct sched_entity_stats),
-				  GFP_KERNEL, cpu_to_node(i));
-		if (!se)
-			goto err_free_rq;
-
+		cfs_rq = &combined->cfs_rq;
+		se = &combined->se;
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
 		init_entity_runnable_average(se);
@@ -13366,8 +13365,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	return 1;
 
-err_free_rq:
-	kfree(cfs_rq);
 err:
 	return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..8b37de788eeb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -745,6 +745,14 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+struct cfs_rq_with_se {
+	struct cfs_rq		cfs_rq;
+	/* cfs_rq's sched_entity on parent runqueue */
+	struct sched_entity	se ____cacheline_aligned;
+};
+#endif
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {

base-commit: 5b726e9bf9544a349090879a513a5e00da486c14
-- 
2.51.0.338.gd7d06c2dae-goog


