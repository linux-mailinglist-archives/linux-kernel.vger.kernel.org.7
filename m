Return-Path: <linux-kernel+bounces-897239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA8C525B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACF93AE886
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF48328B78;
	Wed, 12 Nov 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="IBN/EQeB"
Received: from mail17.out.titan.email (mail17.out.titan.email [3.64.226.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12A32C33C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.226.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951838; cv=none; b=eHj9tSuwgzYXRfAtnQY4Vdm3qXAHdDM7NYXOarAS0+Ui9XdjdE6p9aWJ2UtbeP1VwYjCg6HYAGpVS2b1H0ir2yiKPlSo+sgPia+eXBZZ6dmZwq2attXJZIITTQA8XSAd5F9BT8iK7UpYkYxFySfiK2EPYulxUVxvOkctvAZidlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951838; c=relaxed/simple;
	bh=E5uUb7+fbX62Zh2Uz+APdCR0qyuD2bfcfohAbeZ7Yr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hHptK0x0kjTw7mY0tbfavZPafSPKlNiJmfzOlz4tIrpbhhmeS+BVlEs5YHc4MFGlUQBxI/t//h914N+RtNT8rQkXxpxDEu/wh0I0FxL7rGb74BpgG4fxp17mko1fyFKvbFfU6suKDIUNds2SJS94riL7umNaFo8KD+jeKkSwHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=IBN/EQeB; arc=none smtp.client-ip=3.64.226.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4d62g634Jtz4vxN;
	Wed, 12 Nov 2025 12:25:38 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=1ha9FVX34PW7qq5iLHUavAVRdbNPoP4zzhmRO+QDUeY=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=mime-version:subject:to:from:cc:date:message-id:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1762950338; v=1;
	b=IBN/EQeBpjZssXUFnTUZFCa8q7TUhF3SWrBsezkJujqPqzfYf4Z4JNYge1HmRd54XtHFLuYx
	6i75WHhJtF7/gf5VjCW5ueLgPkbsNr9csFTPWhMJ8G15haejHu4GdbSn0ptno/ULsX3GYv8fxqZ
	oETrZVImnq6NcO++b+yj4bXo=
Received: from morpheus.112glenside.lan (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4d62g55m6nz4vxG;
	Wed, 12 Nov 2025 12:25:37 +0000 (UTC)
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
Subject: [PATCH 0/2 v5] Reintroduce NEXT_BUDDY for EEVDF
Date: Wed, 12 Nov 2025 12:25:19 +0000
Message-ID: <20251112122521.1331238-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1762950338277317561.1240.4361959595493664707@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=d4QPyQjE c=1 sm=1 tr=0 ts=69147cc2
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=CEWIc4RMnpUA:10 a=7qnGvtjcerDTETLpIb4A:9

Changes since v4
o Splitout decisions into separate functions			(peterz)
o Flow clarity							(peterz)

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

Mel Gorman (2):
  sched/fair: Enable scheduler feature NEXT_BUDDY
  sched/fair: Reimplement NEXT_BUDDY to align with EEVDF goals

 kernel/sched/fair.c     | 152 ++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |   2 +-
 2 files changed, 131 insertions(+), 23 deletions(-)

-- 
2.51.0


