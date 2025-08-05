Return-Path: <linux-kernel+bounces-755775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A13B1ABA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1EE189BC78
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A91426C;
	Tue,  5 Aug 2025 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QX14jHtS"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5EA11712
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754352633; cv=none; b=iESm/6XfnJeeWE4mNDoQH+1hIatoc8vEbVu4cbFXSfwZqGo7l4TBllsvFz0SDt8DttJ3ASEWZThJ7qRsmQ0DGyz4uDApJ69QddeDI3TAIem1bspMYBpSVT5ajUfy+Xcc872IwJ/fuTvCkTSpzV2rRt9PzF8wK3ItI/rQZ19mKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754352633; c=relaxed/simple;
	bh=/jIyZ3vxc5yOJz8eq2jnXO9zsRLJJRYD4yIfq+4N4fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KAwRLDNv0uihwTuWLEZPOd/+eRwkp2/UUb+zc3oFI/ssxlGsl3qp/xMulgZauuLIGQuRQy4OwERGOScnXHgH6hXO/TjZw/zDrI6SJ1FxmObr2vCACG+SJRrXyDocnO1ImxBXKvYyMfm8zESltDGSB9fjlm7kmMZ1QYPYEoLeAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QX14jHtS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fd831def4so37851075ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754352631; x=1754957431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIeS0C86+abrJEjDYhOjEa8sLe9goDqWWWMSzD9uDgo=;
        b=QX14jHtSBWd3YsfNGNrLSNpbdfEms3BtpmyRyyagXslH6XlCkk1ndPXsjFglaBhr3Q
         BABVlq+5kX2U6tLKRgLudvm6JNzeqwEjaOMYHVtRgUygpimrqwGGYglqxM0qjhgeSewG
         ePxx/IX9nfv5Ne8e8+rIKpSNhR8NzFVaNyE50SKbfkUvNtH5AUeu6yEsVBd6yuhtZr0g
         ek3/wM9A9XGFggs+w2FcCyj2ZR60oLnQmyRuPVx5ZP+AomMLv7j95O+xwPBMhrQjqkW4
         vzZBz0QPQvT8zDCmhCA7Na8edclwqvl5NmU5Uua758LOF3qc93djPPvEUuw2ENhv8hV9
         FhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754352631; x=1754957431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIeS0C86+abrJEjDYhOjEa8sLe9goDqWWWMSzD9uDgo=;
        b=UvClWf+qswNXdvGiavue+HkJ4H6eXGC22cxuDAMs6Xc1cEgT/gfCQOT85B3IPRApUB
         YM+72LSXHDh4j8lPsihfNL18wNnEK4Zy5kVKDLIlewk8djhVxKBKwkOD407v7HBYz10H
         9p7CQgyIa2I6VzevI3oHHdDdZ2eZdUBkXSmqEGZ3Mo11VPjBdz5hNeWJBVLhKlPZmQbi
         ZLR60/vqNCQnvLWlLw8FlPn9NMU1KRDeRBIk0C1eGt3VRLK72+uCxRcbJOmawccmXyOv
         LOFCsIdsIdawIWcswPbnsX41/exNir9QEQoy3SakwG2skd8JkcQPf+P+T/soD2eAUjvo
         HiXA==
X-Gm-Message-State: AOJu0Yw7ATyEo/86dCgMvrtIL450iDJlO1OSGVSnTw67F8gXpCWQMp6n
	2xG04c0+6QFnYvVWwb17E+Q5kHopFGlha0EZvHxQEL1Hxi/YeEk5KypPVA7F10Tj9GM+ncNDJxS
	SvSgZPoy+TIcglvGD7rjNDqh8gYjeWeaFfO0EYT/5Lgbq9poNSiYxFI8IxrlrP2E5kCUilCcXM5
	w6frIUgfjzr2LHD2JMLKkD4Iiqztyd7fCtTiMheHqXNbOcHta6
X-Google-Smtp-Source: AGHT+IG57F4Brzc5sr0W+8K7HS/j3yikskwfNYoUZxNpX7sjROjP6clJgUBVPCKDU27gbA1f4v+ue2l/EzTX
X-Received: from plki15.prod.google.com ([2002:a17:903:1a0f:b0:23f:e59c:8c1f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d094:b0:240:2eae:aecb
 with SMTP id d9443c01a7336-2424700627emr107448005ad.43.1754352630531; Mon, 04
 Aug 2025 17:10:30 -0700 (PDT)
Date: Tue,  5 Aug 2025 00:10:02 +0000
In-Reply-To: <20250801192157.912805-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801192157.912805-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805001026.2247040-1-jstultz@google.com>
Subject: [PATCH v3] locking: Fix __clear_task_blocked_on() warning from
 __ww_mutex_wound() path
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, 
	syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <valentin.schneider@arm.com>, Suleiman Souhlal <suleiman@google.com>, airlied@gmail.com, 
	mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, 
	dri-devel@lists.freedesktop.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The __clear_task_blocked_on() helper added a number of sanity
checks ensuring we hold the mutex wait lock and that the task
we are clearing blocked_on pointer (if set) matches the mutex.

However, there is an edge case in the _ww_mutex_wound() logic
where we need to clear the blocked_on pointer for the task that
owns the mutex, not the task that is waiting on the mutex.

For this case the sanity checks aren't valid, so handle this
by allowing a NULL lock to skip the additional checks.

K Prateek Nayak and Maarten Lankhorst also pointed out that in
this case where we don't hold the owner's mutex wait_lock, we
need to be a bit more careful using READ_ONCE/WRITE_ONCE in both
the __clear_task_blocked_on() and __set_task_blocked_on()
implementations to avoid accidentally tripping WARN_ONs if two
instances race. So do that here as well.

This issue was easier to miss, I realized, as the test-ww_mutex
driver only exercises the wait-die class of ww_mutexes. I've
sent a patch[1] to address this so the logic will be easier to
test.

[1]: https://lore.kernel.org/lkml/20250801023358.562525-2-jstultz@google.com/

Fixes: a4f0b6fef4b0 ("locking/mutex: Add p->blocked_on wrappers for correctness checks")
Reported-by: syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com
Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Closes: https://lore.kernel.org/lkml/68894443.a00a0220.26d0e1.0015.GAE@google.com/
Signed-off-by: John Stultz <jstultz@google.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v2:
* Rewording of "lock" to "mutex" in commit and comment for
  clarity
* Rework __clear_task_blocked_on() to use READ_ONCE and WRITE_ONCE
  so we don't trip over the WARNING if two instances race, as suggested
  by K Prateek Nayak and Maarten Lankhorst
v3:
* Add READ_ONCE and WRITE_ONCE to __set_task_blocked_on(), to avoid
  tripping similar warnings as suggested by K Prateek Nayak

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
 include/linux/sched.h     | 29 +++++++++++++++++------------
 kernel/locking/ww_mutex.h |  6 +++++-
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 40d2fa90df425..62103dd6a48e0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2144,6 +2144,8 @@ static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	struct mutex *blocked_on = READ_ONCE(p->blocked_on);
+
 	WARN_ON_ONCE(!m);
 	/* The task should only be setting itself as blocked */
 	WARN_ON_ONCE(p != current);
@@ -2154,8 +2156,8 @@ static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 	 * with a different mutex. Note, setting it to the same
 	 * lock repeatedly is ok.
 	 */
-	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
-	p->blocked_on = m;
+	WARN_ON_ONCE(blocked_on && blocked_on != m);
+	WRITE_ONCE(p->blocked_on, m);
 }
 
 static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
@@ -2166,16 +2168,19 @@ static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
 
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


