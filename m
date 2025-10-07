Return-Path: <linux-kernel+bounces-844368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63370BC1B42
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFF5F4EE52A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7CA288C2D;
	Tue,  7 Oct 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq5BwML7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18AC8E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846974; cv=none; b=tZU+99raP11pn22RxIG5ZuBDcoAhGuAgQWHJ+z5LU/LkMtnmNsD1K6HZ9dHH5hnnSHsizRl2QWQ/bBAZXuDX8xnAv6BJ24IJAOwFrkdts5IOwTTpz/IJFKNKbcothxy9dvPSRrI+R0I72htylfUpMtnANHxBefBYqZI1Tz5yHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846974; c=relaxed/simple;
	bh=rau0Of92Imxa/DTtgDTx+Cu0VrDp6j2EHky4cVJztmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qfo9K7Iseg8gF+Nc/DT7cnRizceIatqtA9gp/ejE249D90TMzmC1A0RDOs5TRsmbSpXU+df4iTGZWop68XOP0DT19N+RDn3W7Ke7dUe1eWTrMevOqsmIu9mDuCXHdNU0r+fvfA7HdnQA3LsXNlsEX3uwauj5ebWVqEBjltkdC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dq5BwML7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759846972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=zbuIk8AUUnhPP+HZuAhozUptVNutr+rLH6yGzIfS3zI=;
	b=dq5BwML7mcqzMmE4n0GUO6/vILKnUsKhXrkAhzdAWgADnbpVr0GSggmxLBu1eMfpc1aQVd
	ttloIMeQH0GXdcHxGXmT7fNJmRhQSUIrHyjwXdaWIkHNUBA88DXC4reQJIaEmg1yQh0tiL
	+7WeOpOyCx/8OcUjvF7TZVL8fP2Yb/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-DkFC6j_UNP6dfZcdoE2xtQ-1; Tue,
 07 Oct 2025 10:22:48 -0400
X-MC-Unique: DkFC6j_UNP6dfZcdoE2xtQ-1
X-Mimecast-MFC-AGG-ID: DkFC6j_UNP6dfZcdoE2xtQ_1759846966
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45B6F1800579;
	Tue,  7 Oct 2025 14:22:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 821CB30002CC;
	Tue,  7 Oct 2025 14:22:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 16:21:25 +0200 (CEST)
Date: Tue, 7 Oct 2025 16:21:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] seqlock: change thread_group_cputime() to use
 scoped_seqlock_read_irqsave()
Message-ID: <20251007142119.GA17122@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007142043.GA17089@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


