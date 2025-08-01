Return-Path: <linux-kernel+bounces-753771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B273B187AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6797B591C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20EC28D8D0;
	Fri,  1 Aug 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YySHmiFY"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755F1DDC33
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076127; cv=none; b=RiW19QtBVmHESKafb1/7dDpgd5VDQiz/dJsGXS5FUpeVtXJt8yKDBMjUGx0gtO8e4U90zJ2cKKauoZ+Sy54PUg0AJiKtz94wiTBIrsAYbq71DKXDOR3tk3WNqDhoJlAw+K56GPzntQNXFeS2OLTUaImfeoh6g8ORUeahW5ChOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076127; c=relaxed/simple;
	bh=Iu5AaheyiSB7YaIlLfdDOliYanJeXkNI8v6CFpdXGhk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Az8c/DdTjuReJ7wp6Nf9MB6CO/fCV5+UKQNnBYO1smaNpCMPtZDAv3MQMOmoNQMuq6xzeOmyj1aibCYc2EXWWtbMDMJiLx0ABLLFmTAmFb+kAByIqH935gyDHHe6WHzecfRVbNeTdrrLBHsxsJcyFIDHTj6XQs8TsaK8NP0/+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YySHmiFY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b421d38d138so1383497a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754076124; x=1754680924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mNS2Q2IorOCVtYQWCNZdPG9Q8DZamyAzOMDjYDbYBsA=;
        b=YySHmiFY8w2Xrgba3Qy23MtQfFHBYQ6QJGYtK1pG8NZJ6IxRnLRJxWeuVcPsP8/KZj
         LjJuUe55GhpF3xBN+kQWWwYa/X+SnjKvx6LlIsKbESNRYAeZpjfeiNttpdnBINibAyPk
         /T9o53lK7LsdVwB/aKT3gcR/f7GHa5h+vhy1evrtJqiq8uPtRZOvXxP9ZJh84ULu3Rb6
         FeUiscYxLvW3C4K0TfOAaSCR2y53vDxNFSGrWqNpGDnyu0LutiL/qOcv4fcvEwlVNQEH
         MZ5UonH90rzPJdSUqRR4NGTz0MlbI5gzuA52VqWLtDdxzuelA8MEkL3nR5rvMW6hauKw
         xKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076124; x=1754680924;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNS2Q2IorOCVtYQWCNZdPG9Q8DZamyAzOMDjYDbYBsA=;
        b=JnpRzfou8xakFGlhtSRjg4qYtIQspY+j1JQXgiPZ4zIt79F9/c4JDAr9PtetLEdqoe
         lgL95z7P4PWdhyqBZh6rv8wOevEvD7TI2zT1GadCCAtzogDQypLR1TY8c6sjIEtD9lwD
         ORNJhnsCWL0t0Yxf66sW/WB4NyKW7aH2O988GkivDWVUh+PUDsnvTOkJmvGG6MWUTsHf
         uvYpGtBjc5bzhMC5bMUbcxsJ9huK1T5p5NxZ/8vQTpmujAZH4Z88nJqqy0q+KYTj3e0y
         7q/IX46kgHn+0YGuFvg9U9yhBWPbqYUV9TjJLIu+sCeIPRRVgd+BilaELZ2KNIvJkhzG
         ZQKw==
X-Gm-Message-State: AOJu0YzSLO7E/wcBtuefJguIPFKP04GeFts3kUe/sf3hV9RTKvl8+ukA
	tQKtAB7J57C/g/pzs89rZOlrck4a6J+Q7TJ6EKkC69/ECsBYfJ+d1isGHoMYN/CTimWr71vQEEl
	xoiwZ9Uc08m/QiPaeXpLkKj7MEa4u8RA0aAi4O1pfN2UzlvMAtZ9W+QOu5xzlfcO0DxuU6s3FVd
	ApWqBlZ25ZY19VQHQjiv3AJGaKBXdHZhuQG18SpqD24ctwvxR7
X-Google-Smtp-Source: AGHT+IHAqBf/4P00GxPH9TGd4ks7immyJraYaPKAtSJjTsefHZE/ctegZQvAOdE2EzTh4JqYdZOFdCJDwMQZ
X-Received: from pjbeu13.prod.google.com ([2002:a17:90a:f94d:b0:312:e914:4548])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b52:b0:311:9c9a:58d7
 with SMTP id 98e67ed59e1d1-321162b1060mr1309032a91.19.1754076124145; Fri, 01
 Aug 2025 12:22:04 -0700 (PDT)
Date: Fri,  1 Aug 2025 19:21:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801192157.912805-1-jstultz@google.com>
Subject: [PATCH v2] locking: Fix __clear_task_blocked_on() warning from
 __ww_mutex_wound() path
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, 
	syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <valentin.schneider@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Suleiman Souhlal <suleiman@google.com>, airlied@gmail.com, mripard@kernel.org, 
	simona@ffwll.ch, tzimmermann@suse.de, dri-devel@lists.freedesktop.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The __clear_task_blocked_on() helper added a number of sanity
checks ensuring we hold the mutex wait lock and that the task
we are clearing blocked_on pointer (if set) matches the mutex.

However, there is an edge case in the _ww_mutex_wound() logic
where we need to clear the blocked_on pointer for the task that
owns the mutex, not the task that is waiting on the mutex.

For this case the sanity checks aren't valid, so handle this
by allowing a NULL lock to skip the additional checks.

This was easier to miss, I realized, as the test-ww_mutex
driver only exercises the wait-die class of ww_mutexes.

I've got a follow up patch to extend the test so that it
will exercise both.

Fixes: a4f0b6fef4b0 ("locking/mutex: Add p->blocked_on wrappers for correctness checks")
Reported-by: syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com
Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Closes: https://lore.kernel.org/lkml/68894443.a00a0220.26d0e1.0015.GAE@google.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Rewording of "lock" to "mutex" in commit and comment for
  clarity
* Rework __clear_task_blocked_on() to use READ_ONCE and WRITE_ONCE
  so we don't trip over the WARNING if two instances race, as suggested
  by K Prateek Nayak and Maarten Lankhorst

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: airlied@gmail.com
Cc: mripard@kernel.org
Cc: simona@ffwll.ch
Cc: tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org
Cc: kernel-team@android.com
---
 include/linux/sched.h     | 23 +++++++++++++----------
 kernel/locking/ww_mutex.h |  6 +++++-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 40d2fa90df425..700b50d29f7fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2166,16 +2166,19 @@ static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
 
 static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
-	WARN_ON_ONCE(!m);
-	/* Currently we serialize blocked_on under the mutex::wait_lock */
-	lockdep_assert_held_once(&m->wait_lock);
-	/*
-	 * There may be cases where we re-clear already cleared
-	 * blocked_on relationships, but make sure we are not
-	 * clearing the relationship with a different lock.
-	 */
-	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
-	p->blocked_on = NULL;
+	if (m) {
+		struct mutex *blocked_on = READ_ONCE(p->blocked_on);
+
+		/* Currently we serialize blocked_on under the mutex::wait_lock */
+		lockdep_assert_held_once(&m->wait_lock);
+		/*
+		 * There may be cases where we re-clear already cleared
+		 * blocked_on relationships, but make sure we are not
+		 * clearing the relationship with a different lock.
+		 */
+		WARN_ON_ONCE(blocked_on && blocked_on != m);
+	}
+	WRITE_ONCE(p->blocked_on, NULL);
 }
 
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 086fd5487ca77..31a785afee6c0 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -342,8 +342,12 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * When waking up the task to wound, be sure to clear the
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
+			 *
+			 * NOTE: We pass NULL here instead of lock, because we
+			 * are waking the mutex owner, who may be currently
+			 * blocked on a different mutex.
 			 */
-			__clear_task_blocked_on(owner, lock);
+			__clear_task_blocked_on(owner, NULL);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
-- 
2.50.1.565.gc32cd1483b-goog


