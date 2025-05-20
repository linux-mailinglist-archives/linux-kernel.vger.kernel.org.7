Return-Path: <linux-kernel+bounces-656154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7BABE26B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 20:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6544C1076
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE16280CE8;
	Tue, 20 May 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMXTpW2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729E27F16F;
	Tue, 20 May 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765036; cv=none; b=UebOKJWYK6I6jHXNrbtCcKlwnJHJi6ZceyuAJb4o2exoaN4eGmy53u6QbkYl3qBntSWWpbR/r+lpS8aaa7b0uwC2Py4ncQNQNQyNubjXfLX+rb1/KfUniEd33YmS/xk9SxxUnsAFOcXUl5e6LexXEfSHM4j6m2jRVs9ohE/UPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765036; c=relaxed/simple;
	bh=Ogh1PdF0JAlJWO/+lBOhxSFsXjnxR2nDdagy97sp5ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ux64e6NoS9Be322QVp/wktYcle9KUhN1zTcJ1qPR7OLgHgD6xKknobiWYa5iDHNwKeWk8u4ZMQ35OqRteC+96sid1QS+3WyVPzSmxFn9ho5PpEdnjX8t7vXdcm4Yq/KimK/cib2TualEoFOuIR+v2lflyPzeKEcxAcc/0kN5V0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMXTpW2s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765035; x=1779301035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ogh1PdF0JAlJWO/+lBOhxSFsXjnxR2nDdagy97sp5ig=;
  b=eMXTpW2sU8XJVDt4wtaI5YY/FFnAzQmmJMvzIxki48KEtj9MHR43XIIf
   /PrkbX8uyTHPY3gjoif8u8qGNBoPrylLEoPVLBb6wA3ru+je79HTWnUaw
   TtXMmIl8HT2LpRUokTtdUlFr8Yj3yfFmBBl28KOej18IE5Xc0leOcYIsw
   WT2caGqbYV4zzCa8cBdeVYWuiUzQ+G7QCF+bmyny617iKIU3jMP8GLZai
   3nwcSi7ixTuEwI52zrYiHjHHmdcN/+Wf5HyD4UqrLGPln1oixBGqouH8c
   2QATGfzze5SLDcIR4eVltyp30BtuPXL6HQII5cF3p/JJ6QLPdipiaRn8D
   w==;
X-CSE-ConnectionGUID: kuELNmGWRzCLmU9LfIrezA==
X-CSE-MsgGUID: fwr61FsvQty8dezjMxRHTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49847953"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49847953"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:12 -0700
X-CSE-ConnectionGUID: BnETvbfGR+aQlXw8/jHg9w==
X-CSE-MsgGUID: 0v6oyintSmi29JxEe0p8ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514705"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:12 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 02/16] perf: Only dump the throttle log for the leader
Date: Tue, 20 May 2025 11:16:30 -0700
Message-Id: <20250520181644.2673067-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The PERF_RECORD_THROTTLE records are dumped for all throttled events.
It's not necessary for group events, which are throttled altogether.

Optimize it by only dump the throttle log for the leader.

The sample right after the THROTTLE record must be generated by the
actual target event. It is good enough for the perf tool to locate the
actual target event.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 915698f47682..cd559501cfbd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2744,14 +2744,16 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 	event->hw.interrupts = 0;
 	if (start)
 		event->pmu->start(event, 0);
-	perf_log_throttle(event, 1);
+	if (event == event->group_leader)
+		perf_log_throttle(event, 1);
 }
 
 static void perf_event_throttle(struct perf_event *event)
 {
 	event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
-	perf_log_throttle(event, 0);
+	if (event == event->group_leader)
+		perf_log_throttle(event, 0);
 }
 
 static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)
-- 
2.38.1


