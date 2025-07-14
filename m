Return-Path: <linux-kernel+bounces-730161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD1B040D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A481886541
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658F254854;
	Mon, 14 Jul 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="P8z8khuJ"
Received: from mail14.out.titan.email (mail14.out.titan.email [3.64.226.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047A253B56
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501633; cv=none; b=mKGgot7WgIDEvBKnVzA6gYE4mWXz7UqKsZP1CWga1w/TBdd6q/BhKbyc6OXKCABw/9kzUQJ/0mErDeiFQyjB9XJdTJ4pxMwYoHyFl/qhunAmG91jf5WvaD08RPXIW5w7y1kD5/RB3zY0X8BmK/ImATWQQQQ2cIBhkMgFUWhf50o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501633; c=relaxed/simple;
	bh=x5G8kL1CUIOR9jcy8C0Q57to54kHBK8R6frRTLjQMuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtC0ISkEYCzp5q5VAQJcgUZTiofzYq4coNo05xZCyryWbK0mZ+dODShdSbwSMp9QDIycppf6v8BPMG2fd6FORnDrkVzXGkGl9Mz7/eya3Myk8var0HHcesuQuOnwatC3VkFq9uvUmHqFtJGwsY8AXFn0ZmNE9LbG4BgcARxo6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=P8z8khuJ; arc=none smtp.client-ip=3.64.226.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 97F4A100009;
	Mon, 14 Jul 2025 13:44:53 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=hXNpBnwdiMETHMCZkcq4PmR7aed4RRRi1VgaVs0E+AI=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=cc:to:message-id:subject:from:date:in-reply-to:references:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752500693; v=1;
	b=P8z8khuJcfgr55Jlg2j13klJR2LjsjurH3bdsdfPRiJ9JlUVWb0nNJ2mLs9EZOP7Jor2tkt3
	R+VZ2wwtWR8SPara1wgBaWbxKElNqdQmzTJ62OSqLPUwFI393RNVIL9p0V6ld5g+Wg0IPIPPQek
	t89Rw/WFSu1OaN95VnVW6EoI=
Received: from mail.blacknight.com (ip-84-203-196-90.broadband.digiweb.ie [84.203.196.90])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id D754C100018;
	Mon, 14 Jul 2025 13:44:52 +0000 (UTC)
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Enable scheduler feature NEXT_BUDDY
Date: Mon, 14 Jul 2025 14:44:28 +0100
Message-ID: <20250714134429.19624-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714134429.19624-1-mgorman@techsingularity.net>
References: <20250714134429.19624-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752500693471018071.2332.3235603129952337881@prod-euc1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=HKo5Fptv c=1 sm=1 tr=0 ts=687509d5
	a=+XWPlUOTt03IZrtNKHUAqA==:117 a=+XWPlUOTt03IZrtNKHUAqA==:17
	a=CEWIc4RMnpUA:10 a=R_Myd5XaAAAA:8 a=ju5EweARRdpvCuRmCuMA:9
	a=L2g4Dz8VuBQ37YGmWQah:22

The NEXT_BUDDY feature reinforces wakeup preemption to encourage the last
wakee to be scheduled sooner on the assumption that the waker/wakee share
cache-hot data. In CFS, it was paired with LAST_BUDDY to switch back on
the assumption that the pair of tasks still share data but also relied
on START_DEBIT and the exact WAKEUP_PREEMPTION implementation to get
good results.

NEXT_BUDDY has been disabled since commit 0ec9fab3d186 ("sched: Improve
latencies and throughput") and LAST_BUDDY was removed in commit 5e963f2bd465
("sched/fair: Commit to EEVDF"). The reasoning is not clear but vruntime
spread is mentioned so a safe assumption is that NEXT_BUDDY had an impact
on overall fairness. It was not noted why LAST_BUDDY was removed but the
assumption is that it's very difficult to reason what LAST_BUDDY's correct
and effective behaviour should be while still respecting EEVDFs goals.

NEXT_BUDDY is relatively easier to reason about given that it's a
point-in-time decision on the wakees deadline and eligibilty relative to the
waker. Enable NEXT_BUDDY as a preparation path to document that the decision
to ignore the current implementation is deliberate. While not presented,
the results were at best neutral and often much more variable. It's known
that it has at least some users due to bug reports but less clear what
workloads benefit from the current implementation.

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
2.43.0


