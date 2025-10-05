Return-Path: <linux-kernel+bounces-842337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BF9BB9897
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F237E3BA437
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658728A1CC;
	Sun,  5 Oct 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0/cVPQX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3601F936
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675919; cv=none; b=Lgz4LVTlJfGQPltco39verIwAIrdbUSmElq1+B7A0H0Y3M22UJcbk1QY8IMEDKdGHxyveeRbC9mHecjv0Ai9TT1CSlYEGH9PbmKfKFSUiaSbCe4DF6i4Z+NH4zAafcODcEQQJL3K1ZkP4/nzd2jpK/fT0V+uRvxgvqhreThpCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675919; c=relaxed/simple;
	bh=SBpUcw9njwCcXX018ZZksLmhnkQo+yFEcYoPoFxZg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WCb1iaj+Iux3aEHhQlLyyYPdvt1dxollUsBZaP3ufbYVMVhCVTavGKQBQjdtmHpu/Hv50O2PAwFtyGgRWf/unVTML0oFVJ9A/xfPEgxfgSiUG+DoxbFKiPq8lq5d4WQf2Lsw6ZJzv7+xI58H/+cionEucppzZpjvbqV58ojMuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0/cVPQX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759675917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=d+nrIpiBElTNAUocY+50+3qKyPURcrFXkHy9MYXyToo=;
	b=X0/cVPQXObp0wLOguWalSuTMaaDeKv7s8Pi5iVqTR+NYLSmYRYmY/9zex/uUXTo2Ht6A1h
	t8fY1bBQ1MZwgUZfa371ycRKa82cj5r1ZSKJnNTKBG8WGlgVVDgwlS4LzK1CGYi2Z1Z5B8
	bRPgiJIJnvkx3fRGU6q4pP8dsEfG3tE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-m5vRQLcSOqWiyR-LqQBr8w-1; Sun,
 05 Oct 2025 10:51:51 -0400
X-MC-Unique: m5vRQLcSOqWiyR-LqQBr8w-1
X-Mimecast-MFC-AGG-ID: m5vRQLcSOqWiyR-LqQBr8w_1759675910
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3C6318004D4;
	Sun,  5 Oct 2025 14:51:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C40E61956056;
	Sun,  5 Oct 2025 14:51:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 16:50:28 +0200 (CEST)
Date: Sun, 5 Oct 2025 16:50:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] seqlock: change thread_group_cputime() to use
 SEQLOCK_READ_SECTION()
Message-ID: <20251005145023.GA1257@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005144929.GB1188@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

To simplify the code and make it more readable.

While at it, change thread_group_cputime() to use __for_each_thread(sig).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/cputime.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..2d691075b6d6 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -315,7 +315,6 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	struct signal_struct *sig = tsk->signal;
 	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
 	unsigned long flags;
 
 	/*
@@ -330,25 +329,18 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 		(void) task_sched_runtime(current);
 
 	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq = 0;
-	do {
-		seq = nextseq;
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+	SEQLOCK_READ_SECTION(&sig->stats_lock, &flags) {
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


