Return-Path: <linux-kernel+bounces-733365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93337B073AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D875D1AA77AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0C2F0E58;
	Wed, 16 Jul 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQdhGFIH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B7239E62
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662459; cv=none; b=aVfkP3WoEhYKQmpOVySnqKaNFIOSoTCsNnUxzOp3uPDezXCM84xBm0Zc7wHFHb5d1SguEmON2dE6/y511UaSEXVdGwfdAMH/TjbAPxHE62cs6M9ealw7GVfK2Tr568fh3acn8jjyqB2NgJeHWsIQa+oPY4RfZRll8dZaBqpKK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662459; c=relaxed/simple;
	bh=1G7s2g+LhTaZLzCj/JGa4DdRS7LduhlObBKvrM5xI1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXnD98VQLbRXm3aX1ajtCMxEaXbVlOi162kJmohrcFOGus4n8mahsGvUxEyoH+0ZYNg6cqLo7+Qb9j0erMu14RdjwcJh907CJg9llitI5sKL3go8euPFruW5emfLRKk3pCIUN3cnKt7vMsHM94KLwmH8T2b5hV64K8L6/zVFiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RQdhGFIH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h1htnZ7HbU0dax+8jLweJKuTwxhWEp4qO19a1P7unRM=; b=RQdhGFIHJpsvUDOXkXZ0hB5qv6
	VM1lJw+89H6jG4mhwvrfOF5RHC582tagYQBkhdtu3hkjKz70z+hxnMnoN7SZ/1pt7y3PqQcaxEq2o
	14JsEH6uBo00FUiHh6O5CaZjPKCETWgUpyXTOs0kI9+ptgIY/3FNwP9qXIjZJU5sou5leMEYfmVlt
	BamTj35h5JTRMFDN6EDGkdftWhjjomEvwQ23p9WgjShAk5XBamIpPIPjltxUCqf31YoQ8zPBgsiU2
	cG7rwdU2V1Rz7Zkat0tKF0qgVgXz+ZRVgRmZHm9/9q4jK/gIpYdUwYaZkY5iP2e3veivIa00+LJhI
	bjuK+tGg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubzZC-0000000A5YI-27u2;
	Wed, 16 Jul 2025 10:40:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0AB7D300186; Wed, 16 Jul 2025 12:40:50 +0200 (CEST)
Date: Wed, 16 Jul 2025 12:40:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Chris Mason <clm@meta.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
Message-ID: <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com>
 <aHdMTdPeQ1F6f-x9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHdMTdPeQ1F6f-x9@arm.com>

On Wed, Jul 16, 2025 at 08:53:01AM +0200, Beata Michalska wrote:
> Wouldn't it be enough to use SEQCNT_ZERO? Those are static per-cpu ones.

Yeah, I suppose that should work. The below builds, but I've not yet
observed the issue myself.

---
Subject: sched/psi: Fix psi_seq initialization
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 15 Jul 2025 15:11:14 -0400

With the seqcount moved out of the group into a global psi_seq,
re-initializing the seqcount on group creation is causing seqcount
corruption.

Fixes: 570c8efd5eb7 ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
Reported-by: Chris Mason <clm@meta.com>
Suggested-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/psi.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -176,7 +176,7 @@ struct psi_group psi_system = {
 	.pcpu = &system_group_pcpu,
 };
 
-static DEFINE_PER_CPU(seqcount_t, psi_seq);
+static DEFINE_PER_CPU(seqcount_t, psi_seq) = SEQCNT_ZERO(psi_seq);
 
 static inline void psi_write_begin(int cpu)
 {
@@ -204,11 +204,7 @@ static void poll_timer_fn(struct timer_l
 
 static void group_init(struct psi_group *group)
 {
-	int cpu;
-
 	group->enabled = true;
-	for_each_possible_cpu(cpu)
-		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
 	mutex_init(&group->avgs_lock);

