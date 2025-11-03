Return-Path: <linux-kernel+bounces-882720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260FC2B3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB141892516
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8230101B;
	Mon,  3 Nov 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="ej472WrL"
Received: from mail46.out.titan.email (mail46.out.titan.email [3.66.115.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66F2FF64C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.66.115.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167914; cv=none; b=i7nExYrEph9miw2V/U3ChnidU7ISfhrIGFA2w/ETA4pMiDGIYSWWhMnPYHFwe6IPyuKiGTt8RKhYDp/WEaxrwZf4UqqnKEZ//SLwGmYkblOsC9g5yyCr/jyEHWrMRmihp0fltdRBoDalAFmDLg0KlorXrWhsGBhGTE/lHOMj7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167914; c=relaxed/simple;
	bh=W18v5yG+KjN2PnLk8ZAPuo5ABAhAcfytXJXVDWdlKrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nILUfmf7ioxtKwWnNRQIdVICG28EH7YnZyaRx5RKYWgm1SGads/PGFL2NE+FkUx4N69DI+kgnthQ/metnQPSKeBBIA6nyqm67+tNv4iZPaRapDQOCR2a6yGW3Yc4vgw9aZYRw4nvORS9wNcfSKGyGYbI1sfJvWN1QhhmPxu9+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=ej472WrL; arc=none smtp.client-ip=3.66.115.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d0TJG4GY1z4vxR;
	Mon,  3 Nov 2025 11:05:02 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=VAkNd431g2Hrdyc75Iro8jdBi3HN/YvW1jrWVnVfBS0=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=message-id:subject:date:to:mime-version:cc:from:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1762167902; v=1;
	b=ej472WrLeRw8X9AOLLi0GZk9gX3d4DDCv1djOvdNwQoSyxnVnZ5gWM8BAIxb9a12XWGMzTL0
	AxcQkcVlN2yaQOMeaMm/Ad9lgFmb/yG6TP5Rn1KBUivalyonUQrbM4ARXhAyurqyX5KJvRgYcQY
	0K2JPYZSHX4asNhRcyLZ/aik=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d0TJF3vzFz4vxX;
	Mon,  3 Nov 2025 11:05:00 +0000 (UTC)
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
Subject: [PATCH 0/2 v4] Reintroduce NEXT_BUDDY for EEVDF
Date: Mon,  3 Nov 2025 11:04:43 +0000
Message-ID: <20251103110445.3503887-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1762167902397498265.2237.1991502224486795250@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=AMAIbF65 c=1 sm=1 tr=0 ts=69088c5e
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=7qnGvtjcerDTETLpIb4A:9

Changes since v3
o Place new code near first consumer				(peterz)
o Separate between PREEMPT_SHORT and NEXT_BUDDY			(peterz)
o Naming and code flow clarity					(peterz)
o Restore slice protection					(peterz)

Changes since v2
o Review feedback applied from Prateek

I've been chasing down a number of schedule issues recently like many
others and found they were broadly grouped as

1. Failure to boost CPU frequency with powersave/ondemand governors
2. Processors entering idle states that are too deep
3. Differences in wakeup latencies for wakeup-intensive workloads

Adding topology into account means that there is a lot of machine-specific
behaviour which may explain why some discussions recently have reproduction
problems. Nevertheless, the removal of LAST_BUDDY and NEXT_BUDDY being
disabled has an impact on wakeup latencies.

This series enables NEXT_BUDDY and may select a wakee if it's eligible to
run even though other unrelated tasks may have an earlier deadline.

 kernel/sched/fair.c     | 145 ++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |   2 +-
 2 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.51.0


