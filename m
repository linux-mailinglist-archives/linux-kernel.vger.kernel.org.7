Return-Path: <linux-kernel+bounces-890752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6DC40D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DD33A924D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344B226C3A5;
	Fri,  7 Nov 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kRe5kJUM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D725B69F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532301; cv=none; b=Vt6s0JRT5zF6vJCYwXMByA5mP0O78QiPT0hkT8o3s1pmvizphIXiEGCVmE/JHxrdZu+4bPw9oJUA6+1kZEqERdBrhSnARnktw1IaMYK0MGep0ELlM8CSiuhobeLy38/Wnw2poauyNKXLL2eNW3Emy7bUF9PXrjhUR9bT5LyaDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532301; c=relaxed/simple;
	bh=bP8o/crwvkKz2buUsjALT1cMZjD4rVQz1pRpLWhStxs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AOVkZcsc3dLAMQgqxg1lk3zmkk3VnZtBEZdWrVo5m+WxENh8KeYXTol0r9y8AO2ShwFsFPD3cP+0CWs3LtQW5ml79/AbOs2eVKnm2RbCbId7pC8uAbDJHO6PmpWpTL6KdoDUnBFPbRXWpLrN1619wXUW1aqu76ml2W7KcYiKmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kRe5kJUM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=A8wtqIxcaHYAFkpukVmUhv5LoUcO1ERs7wW4nmiSXeI=; b=kRe5kJUMpF+UgAX8NHgurjasTV
	HGJ2iovuKN25Hh8jpDwAwIEJXZXfhfRwksYU54NeArw8MDCm7jXP4uj3GlH4EAv6Ex+yRPBtlgnRU
	lQY8zHGnQffGcqkOeH+3JlwkJqgwZ7gH/giHQf937/Jzjxg6NHXTryd2FZQ13uEjzkgMXcPd4b1xC
	3KA8/px87/TRA5xEjTKHI3pHFI8Eqd1j1uJ4qOm5hGLQ4bx7p3aG7woTDwLQwVArozRWRKQjSGu2/
	LNjZDIYAzc5jO4n7IxYuGSRm3s2/mHYrNCLJXslbng+msXo4Jg9vRnqnYXD+gstIwXsgjQE8NfUgO
	pBBGFOMg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHPA8-0000000DUTL-0OcS;
	Fri, 07 Nov 2025 16:18:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F398330049A; Fri, 07 Nov 2025 17:18:07 +0100 (CET)
Message-ID: <20251107161739.406147760@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 17:06:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Josh Don <joshdon@google.com>
Cc: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched/fair: Revert max_newidle_lb_cost bump
References: <20251107160645.929564468@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Many people reported regressions on their database workloads due to:

  155213a2aed4 ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

For instance Adam Li reported a 6% regression on SpecJBB.

Conversely this will regress schbench again; on my machine from 2.22
Mrps/s down to 2.04 Mrps/s.

Reported-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Reported-by: Adam Li <adamli@os.amperecomputing.com>
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12152,14 +12152,8 @@ static inline bool update_newidle_cost(s
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
-		 *
-		 * sched_balance_newidle() bumps the cost whenever newidle
-		 * balance fails, and we don't want things to grow out of
-		 * control.  Use the sysctl_sched_migration_cost as the upper
-		 * limit, plus a litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost =
-			min(cost, sysctl_sched_migration_cost + 200);
+		sd->max_newidle_lb_cost = cost;
 		sd->last_decay_max_lb_cost = jiffies;
 	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 		/*
@@ -12851,17 +12845,10 @@ static int sched_balance_newidle(struct
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
+			update_newidle_cost(sd, domain_cost);
+
 			curr_cost += domain_cost;
 			t0 = t1;
-
-			/*
-			 * Failing newidle means it is not effective;
-			 * bump the cost so we end up doing less of it.
-			 */
-			if (!pulled_task)
-				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
-
-			update_newidle_cost(sd, domain_cost);
 		}
 
 		/*



