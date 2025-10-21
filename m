Return-Path: <linux-kernel+bounces-863141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE26BF719C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C2119C15AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1E33CEAE;
	Tue, 21 Oct 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="VpB9qJnx"
Received: from mail19.out.titan.email (mail19.out.titan.email [3.64.226.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB033CE87
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057335; cv=none; b=en6k4+/HLX/Km6W9QFApNHyu8gjLWqK0gsCHovFgmF78BYSm5QUPat8KGlu62cLpZIS0mQeHgir69LZ22iLHgUbOAxftWkKYJqFfdiXeabv2WwQFrjpaZyTEuh2rSzAdoimneryJtx6uI67V0wHO6Wg5Vnocj3fDg63tpZJgWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057335; c=relaxed/simple;
	bh=M0vUg9ScIYDue1iXJfO/7r+HMGwFtNoo/vNE/sqnPgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJGHOrhyMlsyWEKdEqD7pRoAXTPSTG2Sbd+EMoF8a97fGLNmbTrURG/E9AdQPSbZKiv01qArloom87MNKX6uzkgm7Pg2Ab7XF53iSbBGaRQ8qxuLf1BNnWFCwRtVaKYqlXOKNlFGvMpHL+W8DQP7dl2pU6I/lJRxx6pmBDJjwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=VpB9qJnx; arc=none smtp.client-ip=3.64.226.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4crZRT2y3xz4vxR;
	Tue, 21 Oct 2025 14:28:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=f+CmWseMNZ4jCfsnpCg2cK9m4FU9d6XdbLu8dkaLNis=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=cc:message-id:from:to:date:in-reply-to:mime-version:subject:references:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761056933; v=1;
	b=VpB9qJnxlXG+6F8hiMv6IR6G/IElozKBcgNlBXjbT6LIfY5ero5QN8INOxAP/ZONc1P/en3j
	Gf0GldMiyQgwQMjNgn6Tvv3sdFkN10VWmBzZ24YRrfzTGgE3Qr5oQvB9qf2lpfulIZ7T6mnvHZz
	mELsWu0W4VxNYzOlSrR78bBQ=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4crZRS5hhYz4vxP;
	Tue, 21 Oct 2025 14:28:52 +0000 (UTC)
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
Date: Tue, 21 Oct 2025 15:28:23 +0100
Message-ID: <20251021142824.3747201-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021142824.3747201-1-mgorman@techsingularity.net>
References: <20251021142824.3747201-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761056933262078975.2237.4440503035604619902@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=68f798a5
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


