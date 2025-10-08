Return-Path: <linux-kernel+bounces-845423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13107BC4D14
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AAD3A4110
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91D246782;
	Wed,  8 Oct 2025 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqKMo9q6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE923D7C2
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926752; cv=none; b=R10W8rL7LJX/jTqqAmlYfbxyAxzyQ006Jcib+ikX2H5IV0p3BLgi+Xs0JS94uf+1xRaJU6NIbCJ/j1lqp68Oh+NWacMAXJvLkxFqbSlA8XXQAX44Xg4rW7QXyAtmBn+6iPhYHKl9GQqSlU3rgJOnhHgI/Nb2/v97BsHEZ3KIJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926752; c=relaxed/simple;
	bh=PKq/HM8C2Xv7OWMoIILS6DZ84AfGURYMW+igTgy7FvA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=agJ0F7+iMFGSu6gfQKmsM2iLBUFzeFY+azSRfGdavAVm8MWJ4Wtf/SkMZjvd8/a0N+NYtzH6TYBm/mVBomKIsgniUnLbI9Ve9zvAY0LXQ+2eS/QDdOqgCDHF5SjBPS7/PQ9TS/lWXGF8j/1EGffKFS7rQ9PQVQug3GDAFFu1Jd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqKMo9q6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759926749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=t6EsGNKU+HFfruQUpBJy7+ykll9vexiISVYh4SJGvp4=;
	b=iqKMo9q6XWiZM7m3g+dVLdHInLGxHNZFJ5XJr95dhe9TX2j4tNTG1JVBCxpq/H8pH1YL5+
	LgjC/gK4+KPvev/ljJ+uyosPGikX/ayZigSq0Uzyd8o7dL0he95oob1RTUak+n+4vJ4yup
	6p8RSpzeaeVaLoGt16DHlgAQ3N7FOk0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-gUfwxYsVMNelBSQXP_haUw-1; Wed,
 08 Oct 2025 08:32:26 -0400
X-MC-Unique: gUfwxYsVMNelBSQXP_haUw-1
X-Mimecast-MFC-AGG-ID: gUfwxYsVMNelBSQXP_haUw_1759926745
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C81519560A7;
	Wed,  8 Oct 2025 12:32:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5D1F219560A2;
	Wed,  8 Oct 2025 12:32:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 14:31:04 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:30:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] seqlock: change do_task_stat() to use
 scoped_seqlock_read_irqsave()
Message-ID: <20251008123059.GA20446@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


