Return-Path: <linux-kernel+bounces-845424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92007BC4D21
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD4319E2AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963B4246BAA;
	Wed,  8 Oct 2025 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFRHUhLS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8166535966
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926757; cv=none; b=pxrXSHZbXtaPLXNffVWyimh2vs9Z9H4iugLQIperMZ53dvOxt/PCGfijeojTmDsStlnEd1RW+sNsXvIYGJEd2J10QJ6h/8sCc67+58m2y/y8mq8jjUVqdbyWrn1Nmz/lELMNEonNrUBEoFyoP2kIehG0fwbMAn9CDxOrDOlZ/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926757; c=relaxed/simple;
	bh=BbNmQemkRXT0PPX4T4yxdzIGVzZNni1zIWvxlTMEN54=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qdbygd/bGlTDa/7SBiJhGIFw5jFGBV3t7Qh54T3kX7uvV03uEKTiNXV34keaMtWfJVg3A3Lc9D0zPNRjRLw6YZQfv1MBoZuEt/tzGK649Wajkm0QPLuZMU2ujr52NrJ6J9pXkj3SCaWo+oRh5UkF43N4pcibvSh+6eC+EeGH3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFRHUhLS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759926754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=fKLnyQUCu2ZpDNTuQSd/OvsIqqCGMU2IGAT+l5MmJp8=;
	b=RFRHUhLScq37EZGpDRWPtiKFpBqw/eLT+gSUyjCv7YSa8WKH1s+PpgOnOGdSdnQEiwvE2D
	+5tFq8UwXYZEIIdYmBCeTzOfP2JURp2mOexwTcO5yQTQgqOj6qZbdILagk7E5/O4Sp4jhI
	vWzgwgHP8Ra7VqLKgi90mdSFlsPIn+M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-beVTel1LMU6LMlCra8z7dQ-1; Wed,
 08 Oct 2025 08:32:33 -0400
X-MC-Unique: beVTel1LMU6LMlCra8z7dQ-1
X-Mimecast-MFC-AGG-ID: beVTel1LMU6LMlCra8z7dQ_1759926752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA65419560A1;
	Wed,  8 Oct 2025 12:32:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7FB2B180047F;
	Wed,  8 Oct 2025 12:32:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  8 Oct 2025 14:31:11 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:31:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] seqlock: change do_io_accounting() to use
 scoped_seqlock_read_irqsave()
Message-ID: <20251008123105.GA20449@redhat.com>
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

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/base.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 62d35631ba8c..08113bb6af1d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3041,20 +3041,14 @@ static int do_io_accounting(struct task_struct *task, struct seq_file *m, int wh
 	if (whole) {
 		struct signal_struct *sig = task->signal;
 		struct task_struct *t;
-		unsigned int seq = 1;
-		unsigned long flags;
 
 		rcu_read_lock();
-		do {
-			seq++; /* 2 on the 1st/lockless path, otherwise odd */
-			flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
-
+		scoped_seqlock_read_irqsave(&sig->stats_lock) {
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


