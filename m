Return-Path: <linux-kernel+bounces-809974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C090B5142A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AA81C21868
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1B2C159A;
	Wed, 10 Sep 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qHTKkuq7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAMpNM77"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B7269CF1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500969; cv=none; b=OQIJperqbRA/VLSg38UcnzsUSA6yaZY60Ix+RB1tUhdT6eBgNBbVoWC9M2CBWBvGXlsY+2RRXD2ixxJZCyVHwWfE4mlcH0Sb/IR52TX0DQNd/ePL62Vy7PAEP4y8JwlK12D8jFELc00jk4tAytiiCYXpTEMuiP2QeIUTBAwASI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500969; c=relaxed/simple;
	bh=co57jl75K096qomkbwgvypPBxFutwSMmugrJac+wmLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEL+XoW7CSm3XkO6WcaP5IBVnZmdUi6nrJHD+CnZV7JTfFiHd/E80p28r/Xx6mOMH14z9qsx7LnyLzXHWe/FwuzZH2sAJLWNcKTkkNkM69G9gLsKSaz96dJa9bxFBXCvTn22SVkud2CrCa4kK6LPQ0tNcDS32iFYci3O34B8edY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qHTKkuq7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAMpNM77; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Sep 2025 12:42:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757500965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrDNERTJnCX//78uTKO+avBPskWsCrgCUjEY960NOWI=;
	b=qHTKkuq7RL8FJ2FBB50Y97yfEqgmQBUVyiL2JML95qfWauUz+cdCpvBA/1EQW40mqeONVq
	jJsBeorZlA2YtjmpSn9/3CSDRI3GUbEkMoGx0qw+OkHjj3gOuUUR2pdfcTZ763GDtOorDa
	XlLtcMUe8N62ARskuyl+6pY1Ul5Ys7x9pjYJANZKQ2iF6QNZyvzDHOF3ya1KD/W7l3Ntun
	ANG7NPchUxQYqen6E58lZhTvBa6w3DnDWyAVQa6uzEzckF6tnLlxgSpn0zLe5eeCOFt4Jd
	4qrn2ajeUjF78Y91i5E2yp9dapUDTstv2yccyOyfTHGC1bUP/Kjo18gEoqAE4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757500965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrDNERTJnCX//78uTKO+avBPskWsCrgCUjEY960NOWI=;
	b=oAMpNM77d1Qm2TO/VKzusHWEy3cCyeSoVfovEnt967+I74lT7JexaD2xtcFgQDNMKLWjo/
	rIom1Jnu9A4a2vBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
	andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] futex: Prevent use-after-free during requeue-PI
Message-ID: <20250910104243.TUMt9HM0@linutronix.de>
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
 <20250903130712.br0G6lOq@linutronix.de>
 <a1808501-559e-4762-b0ea-f1fffd2e7f19@kernel.dk>
 <20250904162820.NS1U-oZp@linutronix.de>
 <4918e983-9964-46a2-aee0-59c91a9c6b35@kernel.dk>
 <875xdruzl4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xdruzl4.ffs@tglx>

syzbot managed to trigger the following race:

   T1                               T2

 futex_wait_requeue_pi()
   futex_do_wait()
     schedule()
                               futex_requeue()
                                 futex_proxy_trylock_atomic()
                                   futex_requeue_pi_prepare()
                                   requeue_pi_wake_futex()
                                     futex_requeue_pi_complete()
                                      /* preempt */

         * timeout/ signal wakes T1 *

   futex_requeue_pi_wakeup_sync() // Q_REQUEUE_PI_LOCKED
   futex_hash_put()
  // back to userland, on stack futex_q is garbage

                                      /* back */
                                     wake_up_state(q->task, TASK_NORMAL);

In this scenario futex_wait_requeue_pi() is able to leave without using
futex_q::lock_ptr for synchronization.
This can be prevented by reading futex_q::task before updating the
futex_q::requeue_state. A reference on the task_struct is not needed
because requeue_pi_wake_futex() is invoked with a spinlock_t held which
implies a RCU read section. Even if T1 terminates immediately after, the
task_struct will remain valid during T2's wake_up_state().
A READ_ONCE on futex_q::task before futex_requeue_pi_complete() is
enough because it ensures that the variable is read before the state is
updated.

Read futex_q::task before the updating the requeue state, use it for the
following wakeup.

Fixes: 07d91ef510fb1 ("futex: Prevent requeue_pi() lock nesting issue on RT")
Reported-by: syzbot+034246a838a10d181e78@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68b75989.050a0220.3db4df.01dd.GAE@google.com/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/requeue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index c716a66f86929..d818b4d47f1ba 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -230,8 +230,9 @@ static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 			   struct futex_hash_bucket *hb)
 {
-	q->key = *key;
+	struct task_struct *task;
 
+	q->key = *key;
 	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
@@ -243,10 +244,11 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 	futex_hash_get(hb);
 	q->drop_hb_ref = true;
 	q->lock_ptr = &hb->lock;
+	task = READ_ONCE(q->task);
 
 	/* Signal locked state to the waiter */
 	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
+	wake_up_state(task, TASK_NORMAL);
 }
 
 /**
-- 
2.51.0


