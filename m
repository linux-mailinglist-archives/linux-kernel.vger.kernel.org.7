Return-Path: <linux-kernel+bounces-844244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B15BC15DC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83431896B53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963252DEA73;
	Tue,  7 Oct 2025 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va0jLv3R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145132DCF4D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840168; cv=none; b=fr9mpzlozL40NvMXSnMKpCpNrLD/Tfvsll14dpb9L1K8TKQcDBDRtWXM/h4Bwlf0vZ97nB8NK/DfAk0Kawp/3DRjIZfgn0lESOZPLOkcXJ0uS85waZ0u+Y8CImpxsBec/WM2LzfHTxRRI4xZJH7O5ZY8FaeVJtpSeCWZOrHakT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840168; c=relaxed/simple;
	bh=4AeJcVPDa0sg5qKqpF+5IQXElkRRd+FP7pzj5t56lUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iVUJ6an02L4+Xj46dQd8xk0O4fskeGOKYBRJFu/fi/lwj9XUU2zojxLrIpNQbJfoQF+bxbqzsNqLtRngm0bceHxFj9u7rafW8V16Bgf1ZT5ptKMtTg6mp6W2vuHetxVXWTRMGn0s6dNUTDI5+/ykNZ7d0R19CA7VimDhHmXs+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va0jLv3R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759840165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U70LBBgdyC3NFcpovpC3/d5OK4NT2RlLPzxWtrv5Hxg=;
	b=Va0jLv3RcgZJblH0hI0Vx/cuuy3T/rPVwSJZ6l8Nwln80Y6DFPrDe144unaOUrumj5oHEl
	arvyOT/inWVBSz7DoYDuW/D/a63E86bqg/mNvi31SU0Xn+XAuAOrRL3jod0SjOqsJUMXY+
	G6pgqKwsAxjmXIlU7i46Bdx/9zMd2kQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-um6Lk8c8MDOXg7-Bgoa7kQ-1; Tue,
 07 Oct 2025 08:29:17 -0400
X-MC-Unique: um6Lk8c8MDOXg7-Bgoa7kQ-1
X-Mimecast-MFC-AGG-ID: um6Lk8c8MDOXg7-Bgoa7kQ_1759840157
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40BC018005B2;
	Tue,  7 Oct 2025 12:29:13 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.70])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A63EC180141D;
	Tue,  7 Oct 2025 12:29:09 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [RFC PATCH] sched/deadline: Avoid dl_server boosting with expired deadline
Date: Tue,  7 Oct 2025 14:29:04 +0200
Message-ID: <20251007122904.31611-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Recent changes to the deadline server leave it running when the system
is idle. If the system is idle for longer than the dl_server period and
the first scheduling occurs after a fair task wakes up, the algorithm
picks the server as the earliest deadline (in the past) and that boosts
the fair task that just woke up while:
 * the deadline is in the past
 * the server consumed all its runtime (in background)
 * there is no starvation (idle for about a period)

Prevent the server from boosting a task when the deadline is in the
past. Instead, replenish a new period and start the server as deferred.

Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

This behaviour was observed using the RV monitors in [1] and the patch
was validated on an adapted version of the models. The models are not
exhaustively validating the dl_server behaviour.

[1] - https://lore.kernel.org/lkml/20250919140954.104920-21-gmonaco@redhat.com

 kernel/sched/deadline.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72c1f72463c7..b3e3d506a18d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2371,6 +2371,17 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 			dl_server_stop(dl_se);
 			goto again;
 		}
+		/*
+		 * If the CPU was idle for long enough time and wakes up
+		 * because of a fair task, the dl_server may run after its
+		 * period elapsed. Replenish a new period as deferred, since we
+		 * are clearly not handling starvation here.
+		 */
+		if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
+			dl_se->dl_defer_running = 0;
+			replenish_dl_new_period(dl_se, rq);
+			goto again;
+		}
 		rq->dl_server = dl_se;
 	} else {
 		p = dl_task_of(dl_se);

base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
-- 
2.51.0


