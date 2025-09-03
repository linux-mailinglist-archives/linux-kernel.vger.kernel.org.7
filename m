Return-Path: <linux-kernel+bounces-797732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7718B41497
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C201B26A43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FF2D59F7;
	Wed,  3 Sep 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIXcKCZd"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664E4501A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756879285; cv=none; b=km4ctqQOU2ruDPEJPfu9Si5oV1Hsy5vSvKDrkEk+C/J/SlLRxD7Q5Lm7mfikFX61g7zYSl1FDy2mkhEb9cvuWJ0atfA1+uV+F070fn3SOB3jcitkUZX0VJ0bShidE6GC0b6JON1KrpMPVLHlnDDRPJh1oB8uuiwU5qWeQabHFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756879285; c=relaxed/simple;
	bh=f2irSRjyw6seSLumsrbPbvJK4LtwsqdhkTnc+dBeMC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgqokwJ/f9tcxsLD1TWGsmZgAKwSbyIglFwS0ovpbouA/LZB+HjUS2VUUYRiF16POW9zHjWyMGV+e3YbP2aDgMcHUGn2aBtJw0WyGYRXMYF5XXI1oR57/0FcS/fs43qoc+l32JTOOB+cM8WfcocR13R97H6lWjYEpasT21s7V/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIXcKCZd; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b471756592cso4010697a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756879283; x=1757484083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1OI8KydOd+hZ8F0I0Y2mub5CZ4rrPnZDILYEWX6OA4=;
        b=fIXcKCZdW6d/kFekDSqL+ENuGfjs6yCEnXb1Jq+7JbUO8r7Go1QZNZD+MvQzZr2tgo
         hiUcI7kSZJKiagjSEcnfFqUfsS3TuNT5ydgBxpqc36dPee6pE49u4rf2TDHMEIxGPUWs
         CFh7bO2XY18fip1HpFsQcE3sD4azVqtIVfoT1vXYH6VV873rlxIx+C7F3mvfczUfQmvF
         rWjVS4p0WShfkXACXicSLcFAaYewd1TWTrmA0vVBahcpycZtx5qeBkoF7Swk2zQUzVw7
         cu2bXcnE1M2MH91GmUgfWJfdHSoDfHSAkukJruUlF0qoRW2GklDAtHkllha/wYYvc92j
         sMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756879283; x=1757484083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1OI8KydOd+hZ8F0I0Y2mub5CZ4rrPnZDILYEWX6OA4=;
        b=rtjC985vmKTeNpAZPelKoTTaEJex0iFQQ1PN67o8DCp4NFGHswkpWd7sGRa5pnQZzQ
         MUr4JKKhvSNe0VYl4532dbRAuHFJJDwtwLkjRWA21ZerO3qyOX0aFs0TUX3Vtwow2y+p
         fMGLd8TNRBX+T9E9AlZTcR1b3p5KyfKT1HbjAUajVTmjJuva4gTpT8b0O/Ig4RehUct2
         qJxmWrxh5GW0+IySeA2YHMWLrKoEN+CUwOodf8vI7zUrxEUpdFziCccvM4joMZm+rAmH
         t+sM74AYYzujeLU1FHh8DTuyk2pCCBum2pmmlOdO7bxZyiTzCJias+Br3+iD5JOCXu3/
         6kpg==
X-Forwarded-Encrypted: i=1; AJvYcCVq4HsdRSJR15RKvZ9NRVvb3r3WDusZ/QShXnNSYLC5D5GnsVhqVFwzznODTDOmASEo74j1/7MZZtEktIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjUVL67FAWm4z0apksGEDKnAEItaRvj+kiJd0RYjcziGaQQBk
	VHZfYjJha8J2x8l82VqgVWEoOQm0ML4/M28ZuaVCHACxPqomkRewT1ZT
X-Gm-Gg: ASbGnctu7gpBkKFwr+8NcUgePzxGJzocKVElcvjcOKLYBuLZ9wnJSHtib5m5XeVvdpV
	GUU/+uxUiA2AOh/Oh3z9orhuXf1LroXyv5X0zHFSi/jVLzvUncBMM7Sq1GpkSD+X+eU1UW6B8uT
	0BtJSpwlCROZVFibZdSZura31RXPFc2AGSLfN6jBbk4KNemNVI6vCxNsz9FiFi95bHH/33s7zY5
	/u5qMxwVdKrQgEUGM2IsL5SiDtm/GpqBcvUdmIyECE2oVFCfo9D9EFiJ811hFGmGGxgqcs2LxQq
	25uleDFRqRSc+EBn5H/iZ/JPx0m666M3aDAqbKPD3lEaOveOWSVHtPnSZ8wbnIkYZyGHq1LUrww
	JhglEm3Kq21Y/g67243bDJf0T8ljmkDjWokqxSOpG/MZN3rO/Lg==
X-Google-Smtp-Source: AGHT+IGH2vARXYIAPNVjhIeeDbNAJuwGh6PynTlUkdUl8MgYKIotnwOjUU/BgPV+BUP2Z3RGVqHOew==
X-Received: by 2002:a17:903:3bac:b0:249:e8b:2b3d with SMTP id d9443c01a7336-24944a06604mr187100825ad.25.1756879275379;
        Tue, 02 Sep 2025 23:01:15 -0700 (PDT)
Received: from localhost.localdomain ([202.43.239.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723534c0a8sm13767483b3a.79.2025.09.02.23.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 23:01:14 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: hupu.gm@gmail.com
Subject: [RFC] sched: Introduce removed.load_sum for precise load propagation
Date: Wed,  3 Sep 2025 14:00:47 +0800
Message-ID: <20250903060047.5598-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, load_sum to be propagated is estimated from
(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT, which relies on
runnable_avg as an approximation. This approach can introduce precision
loss due to the shift operation, and the error may become more visible
when small tasks frequently enter and leave the queue.

This patch introduces removed.load_sum to directly accumulate
se->avg.load_sum when tasks dequeue, and uses it during load
propagation. By doing so:

  a) Avoid relying on runnable_avg-based approximation and obtain
     higher precision in load_sum propagation;
  b) Eliminate precision loss from the shift operation, especially
     with frequent short-lived tasks;
  c) Reduce one multiplication and shift in the hotpath, which
     theoretically lowers overhead (though the impact is minor).

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 kernel/sched/fair.c  | 8 +++++---
 kernel/sched/sched.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..b8cf3687804b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4561,7 +4561,8 @@ static void migrate_se_pelt_lag(struct sched_entity *se) {}
 static inline int
 update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 {
-	unsigned long removed_load = 0, removed_util = 0, removed_runnable = 0;
+	unsigned long removed_load_sum = 0, removed_load = 0;
+	unsigned long removed_util = 0, removed_runnable = 0;
 	struct sched_avg *sa = &cfs_rq->avg;
 	int decayed = 0;
 
@@ -4572,6 +4573,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_lock(&cfs_rq->removed.lock);
 		swap(cfs_rq->removed.util_avg, removed_util);
 		swap(cfs_rq->removed.load_avg, removed_load);
+		swap(cfs_rq->removed.load_sum, removed_load_sum);
 		swap(cfs_rq->removed.runnable_avg, removed_runnable);
 		cfs_rq->removed.nr = 0;
 		raw_spin_unlock(&cfs_rq->removed.lock);
@@ -4609,8 +4611,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		 * removed_runnable is the unweighted version of removed_load so we
 		 * can use it to estimate removed_load_sum.
 		 */
-		add_tg_cfs_propagate(cfs_rq,
-			-(long)(removed_runnable * divider) >> SCHED_CAPACITY_SHIFT);
+		add_tg_cfs_propagate(cfs_rq, -(long)removed_load_sum);
 
 		decayed = 1;
 	}
@@ -4792,6 +4793,7 @@ static void remove_entity_load_avg(struct sched_entity *se)
 	++cfs_rq->removed.nr;
 	cfs_rq->removed.util_avg	+= se->avg.util_avg;
 	cfs_rq->removed.load_avg	+= se->avg.load_avg;
+	cfs_rq->removed.load_sum	+= se->avg.load_sum;
 	cfs_rq->removed.runnable_avg	+= se->avg.runnable_avg;
 	raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..659935a5c694 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -682,6 +682,7 @@ struct cfs_rq {
 	struct {
 		raw_spinlock_t	lock ____cacheline_aligned;
 		int		nr;
+		unsigned long	load_sum;
 		unsigned long	load_avg;
 		unsigned long	util_avg;
 		unsigned long	runnable_avg;
-- 
2.51.0


