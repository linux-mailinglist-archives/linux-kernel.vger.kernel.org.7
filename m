Return-Path: <linux-kernel+bounces-882731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5F7C2B41F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7752D3494D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0A30148C;
	Mon,  3 Nov 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="JRdIj0ue"
Received: from mail46.out.titan.email (mail46.out.titan.email [3.66.115.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D142FD68D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.66.115.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168236; cv=none; b=X4edt1m5TC58/zZKesAF6AJidyi+c++dBytqdGfUZaVbpxwlMKeactziJvN0SDzGd7DxwivmlGJ9+H3onJK1gCnKgfsaKBYsmK6KmkOS/3J+0a9OQKLZBoZeTSnS7th8GjcyZmxYnAqygZOaDFlYRLkVl8922td1EIEuHa2wbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168236; c=relaxed/simple;
	bh=x5ijRr6zoShOXuf3XYQt/yirv4ClmxPeiV8IUyjCdfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOx210YF9stD8K85GR5TGWptjfGUdY9z2IgIKi9lo7kujPRNCsJu70qtyC/n52gnWa9m2YZ+Nhjx6PR5Yo1UgBI94veGaM9b8I2EvR8jMnzWXklogrDBRoEmdYTIXdeLTJXCrUc7yURUS8oBR4iWa03eWcjx3ttndppI1txrQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=JRdIj0ue; arc=none smtp.client-ip=3.66.115.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d0TJT2yq2z4vxg;
	Mon,  3 Nov 2025 11:05:13 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=TbYREeqZcUMrR1YAd+kGx3dy5Gq9WVZMH5LpAy3n1c8=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=subject:message-id:from:cc:references:to:date:in-reply-to:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1762167913; v=1;
	b=JRdIj0ueHXEE5I0+6zonYkfLBZ96EkBuG9veAYvetV/mljk9i6NdTiehdt17e/+9dDbRiUBO
	a6aSV7jiYm8mK8gFLbhlZSvVggbFERFbKFk9uLML0eXzr26L4onS3S5UQh3zzni51QlJbx6kgiK
	TE+RrGcySs73HvrKxOYdbKAU=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d0TJS4jNBz4vxK;
	Mon,  3 Nov 2025 11:05:12 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Enable scheduler feature NEXT_BUDDY
Date: Mon,  3 Nov 2025 11:04:44 +0000
Message-ID: <20251103110445.3503887-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103110445.3503887-1-mgorman@techsingularity.net>
References: <20251103110445.3503887-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1762167913251950837.2237.4664982510544706816@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=AMAIbF65 c=1 sm=1 tr=0 ts=69088c69
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=Ar0jMg3_USw5jooRBgYA:9
	a=L2g4Dz8VuBQ37YGmWQah:22

The NEXT_BUDDY feature reinforces wakeup preemption to encourage the last
wakee to be scheduled sooner on the assumption that the waker/wakee share
cache-hot data. In CFS, it was paired with LAST_BUDDY to switch back on
the assumption that the pair of tasks still share data but also relied
on START_DEBIT and the exact WAKEUP_PREEMPTION implementation to get
good results.

NEXT_BUDDY has been disabled since commit 0ec9fab3d186 ("sched: Improve
latencies and throughput") and LAST_BUDDY was removed in commit 5e963f2bd465
("sched/fair: Commit to EEVDF"). The reasoning was not documented but as
vruntime spread is mentioned and NEXT_BUDDY cannot, by definition, strictly
obey EEVDF principles.  It was not noted why LAST_BUDDY was removed but it
is assumed that it's very difficult to reason what LAST_BUDDY's correct
and effective behaviour should be while still respecting EEVDFs goals.
NEXT_BUDDY will still pick an earlier deadline but LAST_BUDDY can pick
ineligible tasks. Peter Zijlstra made this comment about NEXT_BUDDY being
disabled during review;

	I think I was just struggling to make sense of things and figured
	less is more and axed it.

	I have vague memories trying to work through the dynamics of
	a wakeup-stack and the EEVDF latency requirements and getting
	a head-ache.

NEXT_BUDDY is easier to reason about given that it's a point-in-time
decision on the wakees deadline and eligibilty relative to the waker. Enable
NEXT_BUDDY as a preparation path to document that the decision to ignore
the current implementation is deliberate. While not presented, the results
were at best neutral and often much more variable.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..0607def744af 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -29,7 +29,7 @@ SCHED_FEAT(PREEMPT_SHORT, true)
  * wakeup-preemption), since its likely going to consume data we
  * touched, increases cache locality.
  */
-SCHED_FEAT(NEXT_BUDDY, false)
+SCHED_FEAT(NEXT_BUDDY, true)
 
 /*
  * Allow completely ignoring cfs_rq->next; which can be set from various
-- 
2.51.0


