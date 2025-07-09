Return-Path: <linux-kernel+bounces-724250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68CAFF071
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB11171424
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61804233735;
	Wed,  9 Jul 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwIvbW8i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7E1F5858
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084401; cv=none; b=Qpm7zjjsUbxak0rtylFL0nt8Lz137o0NWPutcW/62RsD4uilMnyADxMOKBdntmX7KnFDPP3jQysqLphQHPbD16b6c9Rb9kbhwgcmvY3wloEq7UpPmG4qsTQUHwfGmL0QuqVH+edeKitMGKdOxpznHmEnfeYBY9Kwm6VRcewDIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084401; c=relaxed/simple;
	bh=YQTvvMQGSj+fZz1Zi6HDqmjP70x9DzNpdzD9hYU3t38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0nqFpEcaaXbXmJUGmOOpRgfc3Y50UBi4NaK9Z/0902d5q9ThkixwngvDJXtwP9Mcz9AFhxuSXGtKr0nnGELZGhrVWjhY9OkzrTKepFE8qavdY7yWccc8HueT3ewZbJVpSd+xOlIGSzfaIlD7rZDMw9rPQp+TNUh60dzMv2QTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwIvbW8i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752084398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WeDwu2zu69oEp9VfmX+dLhpajZtwBjF+LIZPp+bj91s=;
	b=dwIvbW8iCtInYvp8idTNxcAFNbcv4Uu03g3M37Z7WvkjIM4kBruO6VIS7uv/cAFR9eRnyx
	5H+mcbgnwQsLPFa4rLZzqUldC2lbGLfxZlY0xfCC1mxLYxnHWa8LRyaw3ng/8jB1vWkAJg
	P9m3ybVVYFOSikOM9buvXuVkpOAyhH8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-bd9l1Kr7P5mnfkZIKtB8rg-1; Wed,
 09 Jul 2025 14:06:32 -0400
X-MC-Unique: bd9l1Kr7P5mnfkZIKtB8rg-1
X-Mimecast-MFC-AGG-ID: bd9l1Kr7P5mnfkZIKtB8rg_1752084391
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F8BD19560A1;
	Wed,  9 Jul 2025 18:06:31 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.224])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF2961956089;
	Wed,  9 Jul 2025 18:06:27 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/mutex: Disable preemption in __mutex_unlock_slowpath()
Date: Wed,  9 Jul 2025 14:05:50 -0400
Message-ID: <20250709180550.147205-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jann reported a possible UAF scenario where a task in the mutex_unlock()
path had released the mutex and was about to acquire the wait_lock
to check out the waiters. In the interim, another task could come in,
acquire and release the mutex and then free the memory object holding
the mutex after that.

Thread A                      Thread B
========                      ========
                              eventpoll_release_file
                                mutex_lock
                                  [success on trylock fastpath]
                                __ep_remove
                                  ep_refcount_dec_and_test
                                    [drop refcount from 2 to 1]

ep_eventpoll_release
  ep_clear_and_put
    mutex_lock
      __mutex_lock_slowpath
        __mutex_lock
          __mutex_lock_common
            __mutex_add_waiter
              [enqueue waiter]
              [set MUTEX_FLAG_WAITERS]

                                mutex_unlock
                                  __mutex_unlock_slowpath
                                    atomic_long_try_cmpxchg_release
                                      [reads MUTEX_FLAG_WAITERS]
                                      [drops lock ownership]

            __mutex_trylock
              [success]
            __mutex_remove_waiter
    ep_refcount_dec_and_test
      [drop refcount from 1 to 0]
    mutex_unlock
    ep_free
      kfree(ep)

                                    raw_spin_lock_irqsave(&lock->wait_lock)
                                      *** UAF WRITE ***

This race condition is possible especially if a preemption happens right
after releasing the lock but before acquiring the wait_lock. Rwsem's
__up_write() and __up_read() helpers have already disabled
preemption to minimize this vulnernable time period, do the same for
__mutex_unlock_slowpath() to minimize the chance of this race condition.

Also add a note in Documentation/locking/mutex-design.rst to suggest
that callers can use rcu_free() to delay the actual memory free to
eliminate this UAF scenario.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/locking/mutex-design.rst | 6 ++++--
 kernel/locking/mutex.c                 | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/mutex-design.rst b/Documentation/locking/mutex-design.rst
index 7c30b4aa5e28..51a3a28ca830 100644
--- a/Documentation/locking/mutex-design.rst
+++ b/Documentation/locking/mutex-design.rst
@@ -117,8 +117,10 @@ the structure anymore.
 
 The mutex user must ensure that the mutex is not destroyed while a
 release operation is still in progress - in other words, callers of
-mutex_unlock() must ensure that the mutex stays alive until mutex_unlock()
-has returned.
+mutex_unlock() must ensure that the mutex stays alive until
+mutex_unlock() has returned. One possible way to do that is to use
+kfree_rcu() or its variants to delay the actual freeing the memory
+object containing the mutex.
 
 Interfaces
 ----------
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a39ecccbd106..d33f36d305fb 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -912,9 +912,15 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	 * Release the lock before (potentially) taking the spinlock such that
 	 * other contenders can get on with things ASAP.
 	 *
+	 * Preemption is disabled to minimize the time gap between releasing
+	 * the lock and acquiring the wait_lock. Callers may consider using
+	 * kfree_rcu() if the memory holding the mutex may be freed after
+	 * another mutex_unlock() call to ensure that UAF will not happen.
+	 *
 	 * Except when HANDOFF, in that case we must not clear the owner field,
 	 * but instead set it to the top waiter.
 	 */
+	guard(preempt)();
 	owner = atomic_long_read(&lock->owner);
 	for (;;) {
 		MUTEX_WARN_ON(__owner_task(owner) != current);
-- 
2.50.0


