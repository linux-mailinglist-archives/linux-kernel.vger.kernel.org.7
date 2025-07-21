Return-Path: <linux-kernel+bounces-739316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB0AB0C4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890121AA4B36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6932D8DB1;
	Mon, 21 Jul 2025 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YU7TuIaw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D822D8794
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102951; cv=none; b=d+VmYqPLULvb2J7FsjHL7ORiXShQ3jRkuTCnwH6lNotV3G1jZT3498Zx8FAr3sXzeu+rWoxBGvN5C9qLjV8FnxXnlFx7fkqUPHzgmiX6DtgxGe1diEjvreZ1U1c0IudbEF1lZuGtvcobKAIrNCHT86jz5OTqqlgp0OBC74DJ5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102951; c=relaxed/simple;
	bh=p7O/0tY6woieztP42FD4hsku4invp4xGfH9uQ9uMDys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d7LvbJW7GT89cfHb/4VHozSRNvGqk7Pi/u8URhAdclzvnihi/MACOzUWbScBn9JWyshzL0XDtSyqkA9VZ+stkLfSHCejLNPGP55AaZoDDkiJhxE7/Aro3oOKBH4QFoGg6ikY6jgHxsokCDbToUJwpXa6K/rzeiG1vPmvQZ/sH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YU7TuIaw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753102948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LXfNKvE2evyn93v5O5aeec0XduUEsctuPU+y+qzVKQw=;
	b=YU7TuIawDqkvBBtaCO1u+xHxLp1X2KG9+hVMfgPwAIUOOTacWy/LxBLSU9isfxN4KFvkta
	xY+Mxm0f7/kbDzMAiIex+sAOv0S+Ot5uoL2DG4fgO2VfzGEd9NLolxiDLZ5y3IByMrzSPl
	CWNGn7zBefqidgGb+SvWxPGrtyD7/x4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-9l9dYDnmNv6iS7HIJOj3yA-1; Mon,
 21 Jul 2025 09:02:22 -0400
X-MC-Unique: 9l9dYDnmNv6iS7HIJOj3yA-1
X-Mimecast-MFC-AGG-ID: 9l9dYDnmNv6iS7HIJOj3yA_1753102935
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 227FB1955E9D;
	Mon, 21 Jul 2025 13:02:10 +0000 (UTC)
Received: from jlelli-thinkpadt14gen4.remote.csb (unknown [10.44.32.63])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4284A19560A1;
	Mon, 21 Jul 2025 13:02:03 +0000 (UTC)
From: Juri Lelli <juri.lelli@redhat.com>
Date: Mon, 21 Jul 2025 15:01:42 +0200
Subject: [PATCH] sched/deadline: Always stop dl-server before changing
 parameters
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com>
X-B4-Tracking: v=1; b=H4sIADU6fmgC/x2NQQqDQAxFryJZNzBGRelVpIupE6cBq5LYoSDev
 aGrz1u8908wVmGDe3WCchGTbXWobxVMr7hmRknOQIG60FONn90O5fjGWb6YFtcLKy5sFnNWHym
 MzxanLs7UUmrC0IDXdmU3/k/j47p+yOH2AXkAAAA=
X-Change-ID: 20250721-upstream-fix-dlserver-lessaggressive-b4-c5af242d3083
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, 
 Yuri Andriaccio <yurand2000@gmail.com>, Juri Lelli <juri.lelli@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753102922; l=1629;
 i=juri.lelli@redhat.com; s=20250626; h=from:subject:message-id;
 bh=p7O/0tY6woieztP42FD4hsku4invp4xGfH9uQ9uMDys=;
 b=KHmtr75sGyuD+LYLyvQhp7j1zjz9Ff+L4DdEr11gB9IHhthrFqhddexFOOwgfhk5TZ2J0Vnem
 NeLhONl94zyDQ+xuLRNkK8MYP6/hjLkR4B5C27JOEz5HvwaXHBhEFs+
X-Developer-Key: i=juri.lelli@redhat.com; a=ed25519;
 pk=kSwf88oiY/PYrNMRL/tjuBPiSGzc+U3bD13Zag6wO5Q=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit cccb45d7c4295 ("sched/deadline: Less agressive dl_server
handling") reduced dl-server overhead by delaying disabling servers only
after there are no fair task around for a whole period, which means that
deadline entities are not dequeued right away on a server stop event.
However, the delay opens up a window in which a request for changing
server parameters can break per-runqueue running_bw tracking, as
reported by Yuri.

Close the problematic window by unconditionally calling dl_server_stop()
before applying the new parameters (ensuring deadline entities go
through an actual dequeue).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f0..02e16b70a7901 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -376,10 +376,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_queued) {
-			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
-		}
+		update_rq_clock(rq);
+		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 		if (retval)

---
base-commit: ed0272f0675f31642c3d445a596b544de9db405b
change-id: 20250721-upstream-fix-dlserver-lessaggressive-b4-c5af242d3083

Best regards,
--  
Juri Lelli <juri.lelli@redhat.com>


