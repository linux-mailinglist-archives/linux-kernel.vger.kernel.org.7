Return-Path: <linux-kernel+bounces-863158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4850EBF723E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212E618868A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744BB2749C5;
	Tue, 21 Oct 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="F0J6y++B"
Received: from mail19.out.titan.email (mail19.out.titan.email [3.64.226.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE822FE0E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057935; cv=none; b=myJsgmk+wCsb2a1etq5ZKL/ldGpTKdnfkERvrfvD+3diobQ/mQrYvDrJ5kZOva9JxFdjrPJ8pmKIgUZSiWlN+0qFkJywNcSSmhp52NNwA5RB/Louw6Vv/B2HC/YZnuOD2D3A5vSRbj8hIkcnOU4ZQCMPSl9V40dBuveinizokQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057935; c=relaxed/simple;
	bh=AveatL9pt5Ba1OWtudoGfLD4mfWX2mDy+IqL3/ucg3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzLeJ8oTX13XQC1zlD4uE3kzRU8VCD1E9mudYcK1mK+OPAIbdK0n9NXEpshG9lK2pjqRswrVBdszgvEpCT1Qdb67rvN0lTpHg+MuY7mlQHqGJedgPdkGKrgmKPyRRtfV83E14zmnyRIliOcikd/9IbVDazch9B84ha8p+kU55vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=F0J6y++B; arc=none smtp.client-ip=3.64.226.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4crZRG5WC2z4vxJ;
	Tue, 21 Oct 2025 14:28:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=FT6F8lxdsXIxZJ5Uz5oR0Tp97ixFg9xUf4/QWCRvvM4=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=from:message-id:mime-version:cc:subject:to:date:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1761056922; v=1;
	b=F0J6y++BM6PQ1Y5ac9nn8uS9DDNbNiAG1BTqeusCXqE5AcY9wm4m/MxQsIGAgRTLs29EMcMe
	7mx0Fs6+42wx+llq9Wt0/u5R990ioOSdGcsRRwnpYA9LVx3yxW8Xim7DfbG8nU5SaGegONbQc9I
	OfiO6LzrNiSode8VxiU4Neqo=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4crZRF3nhpz4vxF;
	Tue, 21 Oct 2025 14:28:41 +0000 (UTC)
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
Subject: [RFC PATCH 0/2] Reintroduce NEXT_BUDDY for EEVDF v2
Date: Tue, 21 Oct 2025 15:28:22 +0100
Message-ID: <20251021142824.3747201-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761056922593006664.2237.8990852766471748465@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Rqw/LDmK c=1 sm=1 tr=0 ts=68f7989a
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=QcgZxE_Df_qfIiiupLUA:9 a=zgiPjhLxNE0A:10

I've been chasing down a number of schedule issues recently like many
others and found they were broadly grouped as

1. Failure to boost CPU frequency with powersave/ondemand governors
2. Processors entering idle states that are too deep
3. Differences in wakeup latencies for wakeup-intensive workloads

Adding topology into account means that there is a lot of
machine-specific behaviour which may explain why some discussions
recently have reproduction problems. Nevertheless, the removal of
LAST_BUDDY and NEXT_BUDDY being disabled has an impact on wakeup
latencies.

This RFC is to determine if this is valid approach to prefer selecting
a wakee if it's eligible to run even though other unrelated tasks are
more eligible.

 kernel/sched/fair.c     | 131 ++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |   2 +-
 2 files changed, 112 insertions(+), 21 deletions(-)

-- 
2.51.0


