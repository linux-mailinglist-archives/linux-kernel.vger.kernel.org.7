Return-Path: <linux-kernel+bounces-761527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB390B1FB69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F277178DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4D26FDB3;
	Sun, 10 Aug 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSHq8/FO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73645246BD7
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754847465; cv=none; b=BCLLzD2QMRfVocBC6vE6jqYda9o/9hbQeYEJbN22M3WaXo0KWakzpMrmCFIdlTHBGHCi0bgUKkbLPHH+S4l7UWO/GdsYpwwhwWwIjtQOmNZxq0Cvzegom937psEP/+bXxKqU6XjOp8htte0gOk3/xsDuje5+vPsImpMVN82uS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754847465; c=relaxed/simple;
	bh=IQANVj1qjIqP2py4nDdelIPoqtOaywRC0fCXaOHYbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VkZcvSwbF+p6GXxyAOLggfRIe1BCnr8p7zMaEGuZVwJmOzBWpfWc4yfPKoWuxYbYVo+s2xim5WVXPH3VhXJ21AmckLiJLEktCAoDhonnz5PnGikwuZdEDvXrEcnP4v2yO+3zQTQUhhKPXqSpmfkLMiYRS5T43xKJgatyXFu6X+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSHq8/FO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754847462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=CqeifxCXqtUPoufTGd78LwzLTftk3/MuUkvijeAKGhI=;
	b=QSHq8/FOfZASGHk/LOgac1w/RXLg6h2SPvDyDjVPM6GtwzCSVv4i4DJiOwPwD/lJ0E75NJ
	OhEI+Pv2lJ0lvLMNwHWzCDmqoZV2p3oWdzq4MW0TXtopYK+gJd97GM1jyOa921Dvdmc/DY
	EYBl6aqNPfYPc0/eMW2DrpIrpWuzpaw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-hgilzUi2NYmeKv9NyKT1xw-1; Sun,
 10 Aug 2025 13:37:36 -0400
X-MC-Unique: hgilzUi2NYmeKv9NyKT1xw-1
X-Mimecast-MFC-AGG-ID: hgilzUi2NYmeKv9NyKT1xw_1754847455
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 774B618003FD;
	Sun, 10 Aug 2025 17:37:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A9D6C1800280;
	Sun, 10 Aug 2025 17:37:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 10 Aug 2025 19:36:24 +0200 (CEST)
Date: Sun, 10 Aug 2025 19:36:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	Xiang Gao <gxxa03070307@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pid: change task_state() to use task_ppid_nr_ns()
Message-ID: <20250810173620.GA20007@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

to simplify the code.

Note that only tpid and max_fds really need rcu_read_lock(), we could move
task_ppid_nr_ns/task_tgid_nr_ns/task_numa_group_id/get_task_cred outside of
rcu read section.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/proc/array.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..69269745d73b 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -157,13 +157,11 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 	unsigned int max_fds = 0;
 
 	rcu_read_lock();
-	ppid = pid_alive(p) ?
-		task_tgid_nr_ns(rcu_dereference(p->real_parent), ns) : 0;
-
 	tracer = ptrace_parent(p);
 	if (tracer)
 		tpid = task_pid_nr_ns(tracer, ns);
 
+	ppid = task_ppid_nr_ns(p, ns);
 	tgid = task_tgid_nr_ns(p, ns);
 	ngid = task_numa_group_id(p);
 	cred = get_task_cred(p);
-- 
2.25.1.362.g51ebf55


