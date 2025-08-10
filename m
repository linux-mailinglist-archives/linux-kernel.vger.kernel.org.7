Return-Path: <linux-kernel+bounces-761526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B9B1FB68
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A4C3BB614
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D73274B34;
	Sun, 10 Aug 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7N3POv+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF16267B89
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847458; cv=none; b=Fdj5PqhXjPjnlY8sSBVbRSZjFfpEjfr+CB13V/e2glf+Zb2+8RM9OrP0+xO9Kx8njuotXpHrgh+zd+TBw+pUXSvmK4leysIeLH+bdhZYPO4gpH2bE1QRfXe1cFbCIy2IaoGfE65wr5IMse3vl4OCYWF6ZcR+wY4YqKdCLfT+OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847458; c=relaxed/simple;
	bh=pp3bDiO4t/5svTAkTasgFzeilOigT8hS+mSRlS8q6ng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JZU4EM4agemoK33u8DcSNFNgo0/v0yLzKua6LZLpbefzLtF6dxPOGJ7Pnd7uZIWW5VYMwmv8pp7tf2eYGiIrMYIDFUv10M3T8yDbZ+U/v6yAtyU0sWW6RzjNRJRk2/E4Xrk32emFA7yOurtEtZgMP5+wS2Ls2R2wUjIqpIej52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7N3POv+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754847455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=7ZtM3GbkBWf5hwwQy1My5mtFU6rBapqZsDax9iEQkls=;
	b=Q7N3POv+Bik3jKklj8xp5rylHA0yG20kTvSYqTyijAo88nPy12PRJnl/lJav/gH+az2X40
	3KWaKsr9kfYur5aewlaqNuvUpFy3v+Hg99ulDd5UfAcyRDd3SgQ40fWR5ztCJSbWckUVbx
	dm/FDXohZuiWB8eMYfm6RcrzeVKYJkc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-M_wfsuYzOn6SkXxrYywkZQ-1; Sun,
 10 Aug 2025 13:37:32 -0400
X-MC-Unique: M_wfsuYzOn6SkXxrYywkZQ-1
X-Mimecast-MFC-AGG-ID: M_wfsuYzOn6SkXxrYywkZQ_1754847450
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5C1D19560AA;
	Sun, 10 Aug 2025 17:37:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B6B5C18003FC;
	Sun, 10 Aug 2025 17:37:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 10 Aug 2025 19:36:19 +0200 (CEST)
Date: Sun, 10 Aug 2025 19:36:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	Xiang Gao <gxxa03070307@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pid: change bacct_add_tsk() to use task_ppid_nr_ns()
Message-ID: <20250810173615.GA20000@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802022123.3536934-1-gxxa03070307@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

to simplify the code.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/tsacct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 16b283f9d831..6ea2f6363b90 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -57,12 +57,11 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_sched	 = tsk->policy;
 	stats->ac_pid	 = task_pid_nr_ns(tsk, pid_ns);
 	stats->ac_tgid   = task_tgid_nr_ns(tsk, pid_ns);
+	stats->ac_ppid	 = task_ppid_nr_ns(tsk, pid_ns);
 	rcu_read_lock();
 	tcred = __task_cred(tsk);
 	stats->ac_uid	 = from_kuid_munged(user_ns, tcred->uid);
 	stats->ac_gid	 = from_kgid_munged(user_ns, tcred->gid);
-	stats->ac_ppid	 = pid_alive(tsk) ?
-		task_tgid_nr_ns(rcu_dereference(tsk->real_parent), pid_ns) : 0;
 	rcu_read_unlock();
 
 	task_cputime(tsk, &utime, &stime);
-- 
2.25.1.362.g51ebf55


