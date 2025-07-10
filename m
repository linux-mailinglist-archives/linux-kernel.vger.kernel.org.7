Return-Path: <linux-kernel+bounces-725654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90D7B00214
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F3F7B6F2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2581258CCB;
	Thu, 10 Jul 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkSLJwiB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE810221561
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752150886; cv=none; b=Dd/Jf3p96FZxbtz7kF8Avd5/akQ+bFdGNwnLBWRS47AY0V39he6XlO4GNwloy+4+hpw+6lzRmunRt9T9m+05oubn7ECFyuL1I571qyPGA7xcGr5g85G1HlVL/u6DWFdqMnnSxgSZDY131/EVgd2r5384N5e4D4w6QagiC2E7DrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752150886; c=relaxed/simple;
	bh=9bKE7oUD0Gk61RNRRe2Oah3JzwBVRmBAszryn7DMJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHmB+Ft3+pq+XFdjEVp149x5nc2gb2eW918uo7h7qEHYnJwi4zB83FiU3ejcIwjsdfTHUj7rCd7oQSbKof+W9svx1a1qts5eUjGfTPKx5XhziVjyHI+n3DmqdW18yXzyswBumm+VYgc0WjG+neBfWrZYHb0HBP82s3NvYxSog7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkSLJwiB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=od2zVa0JVQLB4g//PvMBIQPuUf9XcqKnuBrCm5vJ+GA=; b=qkSLJwiBD8Gakwb0sBQD3t2mCN
	mCfnGDenSOGUcsWlGdzR/RZ232tD1YS9kbkn/LA3Tf9DRq2dTytSQacz42ZvifMY9v3bBLIaITt1+
	+1/BXekb7kOzYVDNwk8LjDbD70JI364XrEmUixXrZu2VMHJo34uUgM7lShjfkRm4lsZNf4KB5IFz3
	3rRP9sARkyTljvF9xir36ZyqeZOBX9S1+6WA0M4h35gaC9Hh8t9O2d9aJXEGTmH3ICn1itshLldHa
	P/S4FvgBcghJLMDu6AxH1VDRCPlBD/bPsmLGZjHoE5BStthDoI0cZ7SpCD3m2IGwilmjV2hD7F/Dr
	LyUXg8QA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZqU0-000000090t0-20my;
	Thu, 10 Jul 2025 12:34:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98CE3300125; Thu, 10 Jul 2025 14:34:35 +0200 (CEST)
Date: Thu, 10 Jul 2025 14:34:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, dhaval@gianis.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
Message-ID: <20250710123435.GM1613376@noisy.programming.kicks-ass.net>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org>
 <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
 <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>


> > If I set my task’s custom slice to a larger value but another task has a smaller slice,
> > this change will cap my protected window to the smaller slice. Does that mean my custom
> > slice is no longer honored?
> 
> What do you mean by honored ? EEVDF never mandates that a request of
> size slice will be done in one go. Slice mainly defines the deadline
> and orders the entities but not that it will always run your slice in
> one go. Run to parity tries to minimize the number of context switches
> between runnable tasks but must not break fairness and lag theorem.So
> If your task A has a slice of 10ms and task B wakes up with a slice of
> 1ms. B will preempt A because its deadline is earlier. If task B still
> wants to run after its slice is exhausted, it will not be eligible and
> task A will run until task B becomes eligible, which is as long as
> task B's slice.

Right. Added if you don't want wakeup preemption, we've got SCHED_BATCH
for you.

