Return-Path: <linux-kernel+bounces-722044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06510AFD3B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FC5583832
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C02E4985;
	Tue,  8 Jul 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEJRKd5b"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7922E5B11
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993801; cv=none; b=KCJGLFIiYY9uqfUKggE6G/kU33UtQ7Sp8FS3yf27B9qgoPbE8n6peTolUskZWgZHGStM7yM0NvndZdV/0Cv+HC+fcIyk+k+ne8KjLye9WzyZGRppail2fCa3sMlBu5h2ZkI/GhCvICmnEGej2sOKp8DNjI3n7EMmv9a06Y2ImoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993801; c=relaxed/simple;
	bh=+hKCEhP4wYBwtiBfNHK4dWd4+CVQUfB5UoPPhvv3fqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8RJhif9X8f5DyXWSLgRejjvKyRBnaVztipxOTWHYzrAm9fN5+Msbcibo1uzrSj8mhsUM7DbQLf5IvURl2DKGNkAHz31/a00Ct7/pnk4bvzrxPUkk3e33AaHVturq9Jp3DSNx0Y2fSiKsN3ABaVCyd5zP83k+CgvpmAHHtkp2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nEJRKd5b; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so66094f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993798; x=1752598598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw0/sY1luj9u4dFIQwVq3jk5mAy8ce+dq4koRYOPL3I=;
        b=nEJRKd5b9060RWMf69cHOSzfZF6T5JrietJhhMsu2OMi3hSh1m9Z1F2XePAYmyNbab
         OFkDixBBGCf4V/Y2HGARIjeG+fAPAwKCuyytPLKUwFxllv7HShgBnPFzi8KBQmpZgmf2
         9S92fUjlSOjNl0iM0na4H+hisgGNf03wuM0a1rieZ2uSTb+Xa4DYwg+ee74gSSYh2hWQ
         LXl7x25sT37Qi7+Q+fqIb8oPl93i1yk/CJx1O5PXH922OKwFRAlsjN6iBxDWt4Gt6FF4
         L6G1YidgPwclkoJviEBY18URzAXb36Id1KYQ5wCx4yPSLZJLTMOrDO4jYotTgxcnDH7W
         Vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993798; x=1752598598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw0/sY1luj9u4dFIQwVq3jk5mAy8ce+dq4koRYOPL3I=;
        b=IC9S72GFTW1GCiUdT6ToICT0C7dY/tah8+aObPsxSJOmusjjBBFf7hndzZdyTJY7jX
         N8MAz2rOhSUGJRdIIDfrODkAHf8m2QPsv/hefIrTPxFLQBY8/shho6bnG8zUXWY8mnnv
         /vFtNcTAhECe2ELH99RGL1j8vStouI5thDQ/bAETaG7FAM/LRtCI6aL7MYoYP1pOqXSx
         dPXxAOtwTYCLvwZHASUq+byLsCC8NS2UgPQfFsw+ETy4VUVx+5m7Uy5HJU2YV21tRVt6
         U9wNsROU8eiswJ2pxuHmMIwf53ZfGEJ0MSY1kP/XvgC37YPOoZQdw2oORZVMeJN+zpbj
         FDwg==
X-Forwarded-Encrypted: i=1; AJvYcCX1yTauZlEbhw9ovdQhkBrfJJRAGV64sZAYeGxnXxHSCHdLAvjVOiZWFm2pR2HiT3nXICsGxcSZjvyPMIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU0hdoSzu2Nb5RqtS/DabUCsINn9sm8rUqW1HFc8xdAaS9uxC7
	B9/mkLtlwiFrI+5xz25xPOQ7UHdF/gQNK3/AOsDDOz7eRCBNbyP/rFOEaRUWIhtiqNY=
X-Gm-Gg: ASbGncunMmycJ6IyGLGQxP2oUtUwMlrvtGwvO2Uo5vsWLmJYU3JWvsYBpd5OCH7eP8o
	i8tSlkJGf1MMiP7MzaPzEvEipofTwKHuIEaPWuEa4e76ynbruOTb5pLtb3NSupbdebtUUwKPCiz
	5VF8hZ71a53sCTltdqQsyDAd4BkGdV0oZPQMDTiIdXQcCXSrkxWBKhScjWumAGn98clZsvZU5sJ
	w14X3P4b3gPjtyzaH7FSMW3OILdihemJHV4VzeubtVjuHM0lsU+9k8qbXNkjCSMdHnr+RSlPOZA
	jFcAiGmuGggn41ANCOOsMyEzTYzsB5BGipPAJhZ7QLX91418GqKgVKepn1SqC5UZ1gs+ELI=
X-Google-Smtp-Source: AGHT+IEhFOlmagskQM2r5RzgT7BHKcPGdBCsQxmqbsZNtHcOI+6pwTYyTcX41NSxWi6wI0OkFi9pAA==
X-Received: by 2002:a05:6000:40e0:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3b5de034ac1mr3523393f8f.25.1751993797811;
        Tue, 08 Jul 2025 09:56:37 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:37 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	dhaval@gianis.ca,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 3/6] sched/fair: Remove spurious shorter slice preemption
Date: Tue,  8 Jul 2025 18:56:27 +0200
Message-ID: <20250708165630.1948751-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708165630.1948751-1-vincent.guittot@linaro.org>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even if the waking task can preempt current, it might not be the one
selected by pick_task_fair. Check that the waking task will be selected
if we cancel the slice protection before doing so.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97cf99bb71d6..7e82b357763a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -931,7 +931,7 @@ static inline void cancel_protect_slice(struct sched_entity *se)
  *
  * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq, bool protect)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
@@ -948,7 +948,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
-	if (curr && protect_slice(curr))
+	if (curr && protect && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -992,6 +992,11 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	return best;
 }
 
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	return __pick_eevdf(cfs_rq, true);
+}
+
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
@@ -1175,27 +1180,6 @@ static inline bool resched_next_quantum(struct cfs_rq *cfs_rq, struct sched_enti
 	return !entity_eligible(cfs_rq, curr);
 }
 
-static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
-				    struct sched_entity *pse, struct sched_entity *se)
-{
-	if (!sched_feat(PREEMPT_SHORT))
-		return false;
-
-	if (pse->slice >= se->slice)
-		return false;
-
-	if (!entity_eligible(cfs_rq, pse))
-		return false;
-
-	if (entity_before(pse, se))
-		return true;
-
-	if (!entity_eligible(cfs_rq, se))
-		return true;
-
-	return false;
-}
-
 /*
  * Used by other classes to account runtime.
  */
@@ -8666,6 +8650,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
+	bool do_preempt_short = false;
 
 	if (unlikely(se == pse))
 		return;
@@ -8714,7 +8699,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 		 * When non-idle entity preempt an idle entity,
 		 * don't give idle entity slice protection.
 		 */
-		cancel_protect_slice(se);
+		do_preempt_short = true;
 		goto preempt;
 	}
 
@@ -8732,22 +8717,21 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	/*
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
-	 *
-	 * Note that even if @p does not turn out to be the most eligible
-	 * task at this moment, current's slice protection will be lost.
 	 */
-	if (do_preempt_short(cfs_rq, pse, se))
-		cancel_protect_slice(se);
+	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
 
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
 		goto preempt;
 
 	return;
 
 preempt:
+	if (do_preempt_short)
+		cancel_protect_slice(se);
+
 	resched_curr_lazy(rq);
 }
 
-- 
2.43.0


