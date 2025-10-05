Return-Path: <linux-kernel+bounces-842339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360BBB989A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03B63BA53C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA528C00D;
	Sun,  5 Oct 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwCkOf9Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC428BAAC
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759675929; cv=none; b=mW46qa2Y33Hkt43ieM63y0wwGbE8F5WoVL7Via1O33SCmIamq/FRnLeFQUNvSsDQ18tw6tgrkvJdXRfI+2UbuXHtIC/nkfXGrsD0nAajGh9Cxwk8fEeDcTayUmP2Sedl3yrRHLx4Rp+g8gn51Ubh9i0Z4cFk8ovOuMzIJYMXaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759675929; c=relaxed/simple;
	bh=9UiiJgLfv8sTOHiIZgjN6sokKuWFef4zdJDK9xhs/bY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=msR8Idjz32fleWtdGin94YOTaGhYeC715joKgBMv60W8wENZiTFMEYZunH7IxM27nUga2eOC9SF8w6aE74tjgcL7r0oxEVijeo16xhpNX6viqmcae77AXw0cAwlcXBT/44D5HiJM74FU7sY1tUHt55ws3sBJb1lOa6KP0x6gb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwCkOf9Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759675926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=ZSx5lQ4+7qrnZX1hvWPArhIGF76mwlIvFYhojlX36ik=;
	b=VwCkOf9QnaqerIXRzENwi+geNvnmvHhOihN/iZ/7R4l7H34KG4O0bqPv5MfH9KkQ2OqQAr
	lINgDryaPtaaAfmbxJugcEJCFizY+4nGeyBl14wIOtO7dLav/6op7kDjGjjCe6Wi1BZPCv
	tazElKQwNRszQ2bQ/KB1xR27FE5Z3Po=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-k9gnyN4YOhi3jiAyMQi3KQ-1; Sun,
 05 Oct 2025 10:52:03 -0400
X-MC-Unique: k9gnyN4YOhi3jiAyMQi3KQ-1
X-Mimecast-MFC-AGG-ID: k9gnyN4YOhi3jiAyMQi3KQ_1759675922
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4970195608B;
	Sun,  5 Oct 2025 14:52:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E34F319560A2;
	Sun,  5 Oct 2025 14:51:57 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Oct 2025 16:50:40 +0200 (CEST)
Date: Sun, 5 Oct 2025 16:50:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] seqlock: change do_io_accounting() to use
 SEQLOCK_READ_SECTION()
Message-ID: <20251005145035.GA1263@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

To simplify the code and make it more readable.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/base.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 62d35631ba8c..7ec507efbb99 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3041,20 +3041,15 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 	if (whole) {
 		struct signal_struct *sig = task->signal;
 		struct task_struct *t;
-		unsigned int seq = 1;
 		unsigned long flags;
 
 		rcu_read_lock();
-		do {
-			seq++; /* 2 on the 1st/lockless path, otherwise odd */
-			flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
-
+		SEQLOCK_READ_SECTION(&sig->stats_lock, &flags) {
 			acct = sig->ioac;
 			__for_each_thread(sig, t)
 				task_io_accounting_add(&acct, &t->ioac);
 
-		} while (need_seqretry(&sig->stats_lock, seq));
-		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
+		}
 		rcu_read_unlock();
 	} else {
 		acct = task->ioac;
-- 
2.25.1.362.g51ebf55


