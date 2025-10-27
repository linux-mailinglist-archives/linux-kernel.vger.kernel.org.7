Return-Path: <linux-kernel+bounces-871724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D4C0E2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C248C460668
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735CA2D876C;
	Mon, 27 Oct 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Bw0NWWqv"
Received: from mail12.out.titan.email (mail12.out.titan.email [18.198.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE192BDC23
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572736; cv=none; b=B4hylgztuO4a7Oe1zTlt5MlYz05TRESX72DkEG0n7AA0uGoVX3uq1hkRUp4hi9T1dWOj6oC7hmQrEClc/jmGu0IKN4gdbJWf8MuQiZ4YTOukNecPXp9jIvUmeK7CEWiuTXDJIi/RPcuT1Pzsw1uz8jCLXAqRjRphsZ9EULkyDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572736; c=relaxed/simple;
	bh=M0vUg9ScIYDue1iXJfO/7r+HMGwFtNoo/vNE/sqnPgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhiCLJG0LWzP6dWfqj+vNa22O3i1D33VM4iaDV2rZtAW4eTGGi/7E2xOFetTIg2aYohTJLqtuhsF4NYZsO4RjbamdkJVs1G88B8MsnDCj5egM8V5aSTtHQb+Vehx/ZG8XZUK0vGxkJ+m9MuVH9JgSXkfJJdv+Lo6bHi6WL+qlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Bw0NWWqv; arc=none smtp.client-ip=18.198.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4cwF3z18ksz4vxH;
	Mon, 27 Oct 2025 13:39:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=f+CmWseMNZ4jCfsnpCg2cK9m4FU9d6XdbLu8dkaLNis=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=subject:date:to:message-id:in-reply-to:references:mime-version:from:cc:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761572383; v=1;
	b=Bw0NWWqv8/nPUKE27JTU50MRDTO30lBQFjyLoPvJF61Lom8bzvsp5GRZlXgXmmrctWuyDGld
	gKcv82KlLz4q0mUv16kN44EttkASbst1aDTzJvNmi6Y2JzJvTrYHILa/Cefv/VwpkwnSGzZj5cN
	vxdFBZJKAGIIB/0+UWPOkbKU=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4cwF3y3ntnz4vxF;
	Mon, 27 Oct 2025 13:39:42 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Enable scheduler feature NEXT_BUDDY
Date: Mon, 27 Oct 2025 13:39:14 +0000
Message-ID: <20251027133915.4103633-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027133915.4103633-1-mgorman@techsingularity.net>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761572382952833946.2237.8319847526839209387@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=68ff761e
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=cMBBGPabaxsa1RgClXsA:9
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


