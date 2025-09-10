Return-Path: <linux-kernel+bounces-809762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE5B511B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3154E174D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB823101DE;
	Wed, 10 Sep 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7egpuAF"
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402025487A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493807; cv=none; b=bUel7cBFU7V+w60eJiPW5WE1ia1FFj4ztn12Nkaaz9DbSuoVCenQkhHujcdQLA+Ckc+962rbsJVGhwKyxYlZipaboX8Wn0WBhZMkACYKCEDBQT2zHwfUKVk0UkP5bSBjw6ybLkDxPUKIsEsH52dTOMP/s5bWtc7VWLXBUpW/nfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493807; c=relaxed/simple;
	bh=Nlc3OCe+pYQmx9MdStU8UBNBHqvj1OAFI0o5y2OdU38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcyB04g3PP8tjJIVyq/gI8gQMfHgtU6Nwud/w8l73c0h7Mft5/sTMec5Hp6iq4ZNenXdu+SLgHzjE7nr9jaEAYB1XYe7Htq/PAXjAV14jZUtGEzGFqr5jl/U5r0eO5GJEvhdi97nZ9SgIxp9zKB6Ra54ttb/P9jvmaTyQWr/1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7egpuAF; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-32dc6616f7dso123085a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493805; x=1758098605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7pubvzxlwPmZmcWWzt0bfeaOSQmlwvky4xhCsbA/fE=;
        b=d7egpuAF41XhEjXJtXRwfBgfhEM35Lh8K252HOGZ4bckxlQEn0u7PNeJ8ewJAD1tGT
         8Sqo05Wrs9wUK9Xp14zG0KlPfiZkKCa5dWh4bGsq8r2QPOCTIdKnDW7gtgXz0akulS2y
         MIWOS2YlrBOwO3OC676EGeUcMWjJSErRTWpS23sKeVfw/tGiPJqJb3LPid8Lg5UylzFa
         D5p294MJwklOTrKxklFajZqqjCemrfoVsYgVXtnxSsuawzwA+7qzI7kf6jFKRTPkU4vc
         /tlICQHw5kEgt2Wan93DMHdTjdIU842+JENLPL2vBRu8WH2MpnmJtzRxqz1mV4e/PZ3H
         Cm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493805; x=1758098605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7pubvzxlwPmZmcWWzt0bfeaOSQmlwvky4xhCsbA/fE=;
        b=mQ6/KiLNCsjMdI/P6aAr246BGMByo/O623qwsKsrC47yecDTAdt0GXreKNxzSOpOsG
         GNYBGx6BvmZsOnrMMnxf7B7yl9J5jdqA6QsueNW8Odaq0Xw5UNOiHoo0+3H58JZOaU4p
         3RygY9Rlu/8uV+y2rw6a4MzI+6aYltay6/0GyyDPbn2bVAX6cWX3OwMjXEJ4i67e/Eb1
         HTmyF/WrhyrZQob1xfWRzpiGCrGr0f2nNTz5Bcq+xGMqENFmdNZrJHan5RpIycqmxYRw
         w/vXGGFIsB2lcFt2EqluthMrsU+rfLqvX4wabRO3OIkryx43C4IqaGpmb3HQU8oyPmuG
         Py4A==
X-Forwarded-Encrypted: i=1; AJvYcCWIkVpIrD8vGhP84BLZuY+nTmw/pF0+UlGUl7w7TF+PyqETtMeRYPaW46KtPibKmMCEimIj99wFdaESQ1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4GNswfjlGcTylAJJbdAG7bP4bGciVvY9QKwOyFy9NweHsROX
	6JrhSprEFkr99yZIRBD/wTMPsq/iEeNYjFjF6LtNZz6o5qDnqwozqv9A
X-Gm-Gg: ASbGncu1fqM21nNyTW/wEcuowgLZvpgZKm3qwu/5XDpMekAtf2lp2/l6Naz3HvEm1N3
	9TSebYSb5R4iduA4crRqYPIQK5DNaYLTSi7l/Sw25zelXEfFfu2Czud85lQVoV80c81T4L8xJ9S
	qefj7eU6EZXMxRshdD8Oa93BEJ5U4/nrH5T/1xcR99WbO1pSLINSF1PPnWwD4WizbJESpjGF1Xn
	iWZbQzRRRbv7I6aavZj4mupL8QqISXoXWxH4m3vbX6THQRyBdC2T2lDQKR3yfYNo1cE/y0tVHaY
	YUSmsyL9DS5ToiB8VyB+Hj65MWCPLeFc6g5dY1O5VINdgQbtuqRsLMT2WAEp4EeHsAuYnF/KmtU
	h2+LeHmBK6iKg8C0jbWBXhsecQrOZtBwsHeMC11c=
X-Google-Smtp-Source: AGHT+IEjX59ynnG36UBgDgP+plCWnD8XFLXYWApJdydHgPvYSI0mneEMuazzh9VoRpo1fVbWdTM7cA==
X-Received: by 2002:a17:90b:38c4:b0:327:ced1:26e2 with SMTP id 98e67ed59e1d1-32d43f7ee69mr18197201a91.18.1757493804926;
        Wed, 10 Sep 2025 01:43:24 -0700 (PDT)
Received: from HUC.. ([202.43.239.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a50b2f6sm1882734a12.18.2025.09.10.01.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:43:24 -0700 (PDT)
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
Subject: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
Date: Wed, 10 Sep 2025 16:43:16 +0800
Message-ID: <20250910084316.356169-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
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
2.43.0


