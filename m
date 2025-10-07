Return-Path: <linux-kernel+bounces-844370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B227DBC1B49
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3ACA234F742
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B402E1F11;
	Tue,  7 Oct 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWlz6IEZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713B2DC77E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846986; cv=none; b=GDaTWz6lQ85SRAwFxPyFD8SMFIYIvMtYvGfimtrQLuEetDsouKFFaBxP8nGlbKwgc5gBB0daKLat1h6B5mGUStgdHr218agwLRaiG29EuaZdAN5EYXGcgS75kLy/bUQr/IK8+AzL3abON+PmscMKy9JxgLZjutNL0i6tjaI7guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846986; c=relaxed/simple;
	bh=BbNmQemkRXT0PPX4T4yxdzIGVzZNni1zIWvxlTMEN54=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XykcPUp0filQrKvZ+PcUQtiEsDBBIb3W/0iJ+gObPq5aYZOdv3lPUvi3POkLlm5RKnz4I/YpPDNn3+hZEcH5rrElBLCKLUwBR/GG20J36nDhHL4HmwOKcLxyp8KYFc5e+TNwpe2xFHVnOCqovw1g+P70THNYeymj0Gs23FyPZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWlz6IEZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759846984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=fKLnyQUCu2ZpDNTuQSd/OvsIqqCGMU2IGAT+l5MmJp8=;
	b=TWlz6IEZAcWCwjdEb81YtQZLTfr2IxBNudTwNthzJwu8L9fxjyJ/A3qf0vGogZsRKqBV7C
	pkyinLEdJvL6s3DYThRh11PWZt+h+TJlhqOX5zXHJxLjUTKPQQyWGByi5d27Hs/l8J8uYi
	RCBiP0dE5SCTHoLgNwlFsSoh8Ae3+rM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-m3dv1AaBMiSKFYaGGsGHRA-1; Tue,
 07 Oct 2025 10:23:00 -0400
X-MC-Unique: m3dv1AaBMiSKFYaGGsGHRA-1
X-Mimecast-MFC-AGG-ID: m3dv1AaBMiSKFYaGGsGHRA_1759846979
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4440E195609F;
	Tue,  7 Oct 2025 14:22:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1EC52180047F;
	Tue,  7 Oct 2025 14:22:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 16:21:38 +0200 (CEST)
Date: Tue, 7 Oct 2025 16:21:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] seqlock: change do_io_accounting() to use
 scoped_seqlock_read_irqsave()
Message-ID: <20251007142132.GA17130@redhat.com>
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


