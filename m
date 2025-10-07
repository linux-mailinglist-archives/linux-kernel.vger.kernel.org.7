Return-Path: <linux-kernel+bounces-844369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3A4BC1B48
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE2019A45F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FFB2E093E;
	Tue,  7 Oct 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi2X2MIb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE3C8E6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846981; cv=none; b=Ix6fo8rsI1LamVdSwBasKgxhgAsxKTwtEOYpzQi8+30g26AWq0IZKFst5qaaf+xXKaY7dLwwT3IEwD2QeqqQ1qMxOkEeMo40gFjHvX8nazSIZ/pY9phpVD650pENFDgzKk8CIQV6sJowfEXroxUbtwcwBq7Y5nvxSxIKFuTK2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846981; c=relaxed/simple;
	bh=PKq/HM8C2Xv7OWMoIILS6DZ84AfGURYMW+igTgy7FvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fs64YF5cllmKY4PD96tHy5lUm+yObGbn0XlmGMM7lo4JTWLMUlMQ6jFA0WUAoaFNPRRewnLcXF4IscoIfND172Ep0f1NA7MWGv0zgbLQuzjsBD0WAhHZl36/qLkouOsyGBJuBPdWGsRSgKVmuFX6ZvytW2TDqQgwPH0J1NNtRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gi2X2MIb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759846978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=t6EsGNKU+HFfruQUpBJy7+ykll9vexiISVYh4SJGvp4=;
	b=gi2X2MIbPX3l4gi0UapQosbqtsrmxHIcPZ3/W2wqBsEU//S8xX2RQQm+a3nViqaXqdCteR
	E/n1GGrJ7MYoYJ+VVzXynfxM1DLq56o+FTRokEOZT4loNh5fU4FjtEsr+wvd6JUVKQ1W6/
	DaPBnnMJrMrd+eDfP5lQ8BsqbUH17bE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-te5Xb7CqOKKYEzwFdruDIQ-1; Tue,
 07 Oct 2025 10:22:54 -0400
X-MC-Unique: te5Xb7CqOKKYEzwFdruDIQ-1
X-Mimecast-MFC-AGG-ID: te5Xb7CqOKKYEzwFdruDIQ_1759846972
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBDBE1800285;
	Tue,  7 Oct 2025 14:22:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8CF641955F21;
	Tue,  7 Oct 2025 14:22:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 16:21:31 +0200 (CEST)
Date: Tue, 7 Oct 2025 16:21:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] seqlock: change do_task_stat() to use
 scoped_seqlock_read_irqsave()
Message-ID: <20251007142126.GA17127@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

To simplify the code and make it more readable.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/array.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..e9c61448f3ee 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -483,7 +483,6 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
-	unsigned int seq = 1;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -540,10 +539,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	if (permitted && (!whole || num_threads < 2))
 		wchan = !task_is_running(task);
 
-	do {
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
-
+	scoped_seqlock_read_irqsave(&sig->stats_lock) {
 		cmin_flt = sig->cmin_flt;
 		cmaj_flt = sig->cmaj_flt;
 		cutime = sig->cutime;
@@ -565,8 +561,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 			}
 			rcu_read_unlock();
 		}
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+	}
 
 	if (whole) {
 		thread_group_cputime_adjusted(task, &utime, &stime);
-- 
2.25.1.362.g51ebf55


