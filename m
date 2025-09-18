Return-Path: <linux-kernel+bounces-822280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B43B8371A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23BF97B8121
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AB2F5315;
	Thu, 18 Sep 2025 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuEoXUzT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEA2EFDBA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182818; cv=none; b=cZb0jJT6BmZaphTYCbpysoh3bHR2BjDokkf6kA4QnH1CWJoQL06q0xhU/N6y3G/yr7xZVnIjbChj9ee+6zBdma+GEY1B/qeyDcQykAWuH3XU9qE1aR1wFMLUu2DbGGtcXMjX9f+tFmA1/fpff00+jtaQx/1707vYxqKiD0prRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182818; c=relaxed/simple;
	bh=OBJBNAFTWF4epETjD0VTBxin86MSefivKrtTrJzuBYA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cvoyqoEUcct2JGr1O05UVaVPPtYoU8dx4+5nh3hi4hGkL2YU+nJvnFfst/g0mssx35ipd8CS2ZReGh6rn5BnhbcQVXTrHA8hIJZ/eN/6Lit+FS2rJqwsW3WSI7m7c3nCGGW3ZiAP69eZKjjmtIpF1CKGLmuLmXcFu41xyhh8Hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MuEoXUzT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Q0Z5JUpWWqXHKko/fT1GheaPfXqjih9iBoI4fmm5N7E=; b=MuEoXUzTJHiFcx6zIruFYn/3a3
	sKg+5IgdA7f3iu/F+byXVXIXbuwJAUpYVJEZZ8T014FxnU5bTI4MIl4UuSbkiwFoH93qQ84Ung1HT
	M4KvgZfoa9M9l3H84yQpc3Z8RJcjk+wA9+b2hJVfIoHoLDCI0BCPcbfBV1x5QTnthQRz7z3JpG5nq
	406aQcnIFU8hM8vIQaQ86aZWqNJPCd9wGBoou4JE6Bzr+3Qv/pSwm4HucBBjuoaO8Kee8lk864uqZ
	vlC5Es3GqP7bEymuhxB9YKneW+HYC2dm9oDQtVjOTJFtdOj9VIwXHwAhEPzWxDWurAbrQWBcT6RxA
	/XodDpgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fC-0000000FbrO-2FJy;
	Thu, 18 Sep 2025 08:06:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1AAE5300566; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080205.563385766@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 peterz@infradead.org,
 luto@kernel.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: [PATCH 2/8] sched/fair: Limit hrtick work
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The task_tick_fair() function does:

 - update the hierarchical runtimes
 - drive numa-balancing
 - update load-balance statistics
 - drive force-idle preemption

All but the very first can be limited to the periodic tick. Let hrtick
only update accounting and drive preemption, not load-balancing and
other bits.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13119,6 +13119,12 @@ static void task_tick_fair(struct rq *rq
 		entity_tick(cfs_rq, se, queued);
 	}
 
+	if (queued) {
+		if (!need_resched())
+			hrtick_start_fair(rq, curr);
+		return;
+	}
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 



