Return-Path: <linux-kernel+bounces-897226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F630C524DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE1E189ED0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AE33555E;
	Wed, 12 Nov 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Q1+mqiAo"
Received: from mail303.out.titan.email (mail303.out.titan.email [3.68.153.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142A30F800
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.68.153.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951538; cv=none; b=TuKE3SnUgIXku5wcsa5ArS6oBzgFvzJGPi/IWVOFtgKgIw2d+Rgvi8ader211fpcxgavkHRIXfolgLooMbNf8uQXpvxYRj/oBZICw+r+p1Wvi5Y5ncEQoWGyDPlml2E1C44WeZXknMPmc4/6muMNz5HvIkSB4LfiDmap42lvl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951538; c=relaxed/simple;
	bh=geeV3IjWgD6tk98/BEsAD58QhWgKlm8p4cu8VIhNzEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5JDG+VjAS8ZZMWUgugbFIlW2rH44Z2Mujl8gpk7njE9fen7obiU0/uTCN1kHsDsMmIu+tfWGyNpvzDbCbxK8jXobF+kGZRgJvlBdLV/LlUqX7swDJOJOlprqC7w5GXHLXEMuPyQO0zgJLKZiLvmeu4ZSofD5A59MDWF+W8y4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Q1+mqiAo; arc=none smtp.client-ip=3.68.153.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d62gJ6zsFz4vxR;
	Wed, 12 Nov 2025 12:25:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=NOD69Z2Z6GRF71CeNbvPuLQNPzIehNNZNP+KY6DzNBw=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:to:date:mime-version:cc:in-reply-to:references:subject:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1762950348; v=1;
	b=Q1+mqiAo9cMavEOocuUdCTNJbXVmwxgoG9dEzZ5DRTPO1iEBhZaywXyxx7uAa3lqieVZz/xI
	eARkJ5TGQaxhTzIqpNDVkc21TDoT+PZ4p4Oe79230l/zQYoUGrYgZkVKQd/1QZT/rSAwKJ2K7F0
	xxxroRroh93yypj0JHlig3w8=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d62gJ30F8z4vxG;
	Wed, 12 Nov 2025 12:25:48 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Enable scheduler feature NEXT_BUDDY
Date: Wed, 12 Nov 2025 12:25:20 +0000
Message-ID: <20251112122521.1331238-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112122521.1331238-1-mgorman@techsingularity.net>
References: <20251112122521.1331238-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1762950348822632817.1240.7433418304940738252@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=d4QPyQjE c=1 sm=1 tr=0 ts=69147ccc
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=AW7cwINLPZqLRmdQVWoA:9
	a=L2g4Dz8VuBQ37YGmWQah:22

The NEXT_BUDDY feature reinforces wakeup preemption to encourage the last
wakee to be scheduled sooner on the assumption that the waker/wakee share
cache-hot data. In CFS, it was paired with LAST_BUDDY to switch back on
the assumption that the pair of tasks still share data but also relied
on START_DEBIT and the exact WAKEUP_PREEMPTION implementation to get
good results.

NEXT_BUDDY has been disabled since commit 0ec9fab3d186 ("sched: Improve
latencies and throughput") and LAST_BUDDY was removed in commit 5e963f2bd465
("sched/fair: Commit to EEVDF"). The reasoning is not clear but as vruntime
spread is mentioned so the expectation is that NEXT_BUDDY had an impact
on overall fairness. It was not noted why LAST_BUDDY was removed but it
is assumed that it's very difficult to reason what LAST_BUDDY's correct
and effective behaviour should be while still respecting EEVDFs goals.
Peter Zijlstra noted during review;

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


