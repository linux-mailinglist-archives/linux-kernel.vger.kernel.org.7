Return-Path: <linux-kernel+bounces-752544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A799B176F8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA55E1C27750
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DCA2566DF;
	Thu, 31 Jul 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWqW9x+/"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C92441AF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992829; cv=none; b=jgJGpBQ5X/kFynGDs3p76cfpXMiuLzNNRuSH9SVoYlGG1wtD/zoKZGQZA+yNG802buOKAY9aDmYzb/ag4LJ2srZY4TDWnhB19DGq83Dok7IL8MwQ+Sd2T77m8PtXcWjC175M0c1Y0jPzU+Ve7w9HEwHZ4JQjoYjHf5hoG8t1cUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992829; c=relaxed/simple;
	bh=qz8ZOKFShrjaOuixakYY8fEUMMV2nKnq23b8HsIo420=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+6xOC09cpUYNrPbnhfjErpPcMAj0ffBb++31VtzWikaLrtDzbTQ1vnhISV3J4+8NFzYg873fbFM4Bs3yMrG8up5VV0VBULHOtwV960FHXufi21AfHbRU4tSaSJ03WEn3bAayE9fovxSfOfLTTjOIM4yoXOOClxRt9y7l7vs4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWqW9x+/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-75ab147e0a3so1400647b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753992825; x=1754597625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2zswepRFFz227agqCXRGzgOWhu/4sdsUIZ8Cp8ysb8k=;
        b=FWqW9x+/kgOQxUzmnDz/UgcM1LAfBXgULOl3T4FnzwR0AfL5PqqPuXMo3UkH6imsbk
         QmLnAK3fXG3QGggDxZkemkkwmL6+sr4ShF0xkNl7xrHUwb8NvTpeb0vWx8Ry34/A4DB1
         LfxbsPb5R06Ay619PV7rPAjMfYQpD84BDWCrjAsdQAzmfowj7RS3DlBD2umRoJ97ogCW
         bA4udz1u/JR13Zu43X5sTId4k+S6toU4rtk2pixZfAJVoEHy7Gdi2O28UvkcEdT/EWgu
         Fp89ooiEqVtfSOKkbE3dz/YVs3LpGDz0k8kIWee9uuYH731QjwhGC/Fc6u6g3YWwuVPG
         xD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753992825; x=1754597625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zswepRFFz227agqCXRGzgOWhu/4sdsUIZ8Cp8ysb8k=;
        b=PRUx/1OG9Fc9w29FnemOqjsfyl99bc55I8PJ5/UZgpCgRfx2ncMschjO7yTCdjrVv/
         b4/RsX81PEGN5MFrbr9IcLr6T0FxMIo5XrutSt3HoQ9NXaiiK7BkfbE2HPe8btcZ3huM
         FQQ4G9a84eCcUydu5D5JKvmrV3nvawShXjp3mM2AgcZ6ebxsuBimrgSYiXW4aPY0OStl
         qri3RoVZ++v8d3AU3Md1TlnZ58vt8UZCDqJpf9lXJJs4GDuGKUKdOLBhI5KZY3alBTfh
         J3eP7wLlrVEyuysWD9jC9ozG1BTXjs74hGKmR7D5AaInqvMabt9cdORpM2dbiG4pBZ6f
         qU/w==
X-Gm-Message-State: AOJu0YxDyabGRlA2A4bpukJARuJQLsBBg0IIPClU6Nr32r9UGp7loSy0
	rT5zd9QSl3n82D8vXiOKVQlzA0AXppkLmG9tNNY8u5/yB3dDMGfm04jURCFAlCCXtl6mQ2Xgyrn
	fGfibYI6YsZkxtaftMDv9gsW095Ey1jT/ZCuU5V1/cK2HRV+pFb0HYNA3hyKf/DKdN5T/jDuQgW
	JPpsACvghqnL1z2h22NpXW+g0/vHDVQ0Nb9P9PSSr0DXiqcvs9
X-Google-Smtp-Source: AGHT+IFukKL05Gp9jYzgv5oyV5cwTY1GN2KA2iuySkXlUVu2GZZPBul1LGcVGKhaqbxIm2U++oARmjdB2P5T
X-Received: from pfbhj3.prod.google.com ([2002:a05:6a00:8703:b0:746:2a27:3025])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9287:b0:748:3385:a4a
 with SMTP id d2e1a72fcca58-76bdcf23bc0mr174909b3a.23.1753992824659; Thu, 31
 Jul 2025 13:13:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 20:13:22 +0000
In-Reply-To: <68894443.a00a0220.26d0e1.0015.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <68894443.a00a0220.26d0e1.0015.GAE@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731201337.274382-1-jstultz@google.com>
Subject: [RFC][PATCH] locking: Fix __clear_task_blocked_on() warning from
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
checks ensuring we hold the lock and that the task we are
clearing blocked_on pointer (if set) matches the lock.

However, there is an edge case in the _ww_mutex_wound() logic
where we need to clear the blocked_on pointer for the task that
owns the lock, not the task that is waiting on the lock.

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
 include/linux/sched.h     | 19 ++++++++++---------
 kernel/locking/ww_mutex.h |  6 +++++-
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 40d2fa90df425..a9a78f51f7f57 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2166,15 +2166,16 @@ static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
 
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
+	if (m) {
+		/* Currently we serialize blocked_on under the mutex::wait_lock */
+		lockdep_assert_held_once(&m->wait_lock);
+		/*
+		 * There may be cases where we re-clear already cleared
+		 * blocked_on relationships, but make sure we are not
+		 * clearing the relationship with a different lock.
+		 */
+		WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
+	}
 	p->blocked_on = NULL;
 }
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 086fd5487ca77..ef8ef3c28592c 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -342,8 +342,12 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * When waking up the task to wound, be sure to clear the
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
+			 *
+			 * NOTE: We pass NULL here instead of lock, because we
+			 * are waking the lock owner, who may be currently blocked
+			 * on a different lock.
 			 */
-			__clear_task_blocked_on(owner, lock);
+			__clear_task_blocked_on(owner, NULL);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
-- 
2.50.1.565.gc32cd1483b-goog


