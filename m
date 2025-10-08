Return-Path: <linux-kernel+bounces-845422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC0BBC4D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2EF19E2561
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776D24887E;
	Wed,  8 Oct 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNf2EpEh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD59246BC5
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926746; cv=none; b=HLMbDVP1/4vYRV+mNPI4D+HLhozkyZ9zYGXf5NIgTyTfka4tqxW3xIYQaHVO0HfChIDpTQLL0pLZA5gG7CE5whld7JCpI1P0NgPJXWmLnlaI5H0nW6CauxlpH9GB3ci9WHT+T3ENPsKj8gi59mdkjMHqx0OKq522pSNtrqjcl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926746; c=relaxed/simple;
	bh=rau0Of92Imxa/DTtgDTx+Cu0VrDp6j2EHky4cVJztmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ERaNeDJJ3iwDgGnTUvpRss5Vgd6H3y5/oKHvqGo5DtD9KWx94NfloLaxiGdWENAiVOp71v39/Kk3l0I36S/jhyh8KNljIRkVhAYqEsJxHMS2pzMYr8gHcRfo4BVPX0kA3hTFRfOaw0N+ipXZQmJDyZ7+kMrKhVg9A5NAW9zp+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNf2EpEh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759926743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=zbuIk8AUUnhPP+HZuAhozUptVNutr+rLH6yGzIfS3zI=;
	b=fNf2EpEhR1+8/PfJgJeqmxufq9pQEqxkMUqAtmOLEnclPx/atZn20X7K57q8jXU8AzFU0I
	aw8fymwMOmi3nVWtO3sMuzqIGOKzn/HdiyH2on5CyJG2ANXcyJbD6wJn7fhAl3nO24ysio
	2HMvIJqKLLCA92xYU0Jgm4kjgeKrBDM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-rmSgDHOlPuK4WyHm3pXA4w-1; Wed,
 08 Oct 2025 08:32:20 -0400
X-MC-Unique: rmSgDHOlPuK4WyHm3pXA4w-1
X-Mimecast-MFC-AGG-ID: rmSgDHOlPuK4WyHm3pXA4w_1759926739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 102DC19560AF;
	Wed,  8 Oct 2025 12:32:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 982151800452;
	Wed,  8 Oct 2025 12:32:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 14:30:58 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:30:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] seqlock: change thread_group_cputime() to use
 scoped_seqlock_read_irqsave()
Message-ID: <20251008123052.GA20443@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008123014.GA20413@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

To simplify the code and make it more readable.

While at it, change thread_group_cputime() to use __for_each_thread(sig).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/cputime.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..94b445e947d2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -315,8 +315,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	struct signal_struct *sig = tsk->signal;
 	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
-	unsigned long flags;
 
 	/*
 	 * Update current task runtime to account pending time since last
@@ -330,25 +328,18 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 		(void) task_sched_runtime(current);
 
 	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq = 0;
-	do {
-		seq = nextseq;
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+	scoped_seqlock_read_irqsave(&sig->stats_lock) {
 		times->utime = sig->utime;
 		times->stime = sig->stime;
 		times->sum_exec_runtime = sig->sum_sched_runtime;
 
-		for_each_thread(tsk, t) {
+		__for_each_thread(sig, t) {
 			task_cputime(t, &utime, &stime);
 			times->utime += utime;
 			times->stime += stime;
 			times->sum_exec_runtime += read_sum_exec_runtime(t);
 		}
-		/* If lockless access failed, take the lock. */
-		nextseq = 1;
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.25.1.362.g51ebf55


