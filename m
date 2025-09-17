Return-Path: <linux-kernel+bounces-820353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452BFB7C88B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C63A21D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC82EC08E;
	Wed, 17 Sep 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tCxGEl1T"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49AF225390
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101705; cv=none; b=BQDBbSchWtanVzO5HIfVapWXmgmzE60jrOxGkEIALLzt+AWwju0A0XfDK3U/JlqhCZ6QsCViQoATr9qECI7CYKErVvzlFE55iKOf+Xmp1VeSBHTZfJiH9sVje2Uf3rzyschEyS4l9Etsajf6Mi3kH2OU3wK2WKCd/DnxSbLziRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101705; c=relaxed/simple;
	bh=CFtBLZy2hloHIYBb8ZxYEGfcM1Z/Vh5K4mgFPx273Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqxck/8/tScMYYC9S+AYSdLLXrUFS3trOQO5/tk0q4QV+/HahZ3pbeeXJyGDzq4JUuWPvaBpZA0Q8/iJMjDTFo2GYwxJz0eMLmbjR3dEI8naK2P3LT7DVtNhCbCJYRsaRrq37cruLog3prKALwDG3J+16gYf2N/2uvP/rL2Z5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tCxGEl1T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h0DwD3cihRujIZPBxRpyXeQECY5JqNu5hKIpeCKrbm4=; b=tCxGEl1Ti5UaMgyLrtu3pMmV5P
	kOhC6AJzFQV9UQjBsPfRFNkrKoV9JdJNEDx44mUpn3M0RKZxX/9r10nOQzRfEiXJzxa1JbtY6Xl9x
	Im8cugpHVO47BMtsKHuILrxCi390HqOh4/KESE3Kd6E/IT/pDQVSUlW17kJ9K1/0OaUdKAktAEdl9
	d1xxAaHRlHt6uHzEzt+8awKI3k0RbvoAZfygUShoTgXSDMWUYpRybo9e9JDdKD+OOjrzChzTlymA6
	/W8/tSD2cJlk3Xb8w5p5Ui02M8aE5CB0Y8ezrbjw8moX79VBs3QRabscTDSFYBqTfCLcguz8KXcJd
	3AVo+t4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyoYl-00000009gJZ-1YDU;
	Wed, 17 Sep 2025 09:34:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ECC01300212; Wed, 17 Sep 2025 11:34:41 +0200 (CEST)
Date: Wed, 17 Sep 2025 11:34:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>

On Tue, Sep 16, 2025 at 08:29:01PM -0700, John Stultz wrote:

> The problem is that previously the tasks were spawned without much
> delay, but after your change, we see each RT tasks after the first
> NR_CPU take ~1 second to spawn. On systems with large cpu counts
> taking NR_CPU*player-types seconds to start can be long enough (easily
> minutes) that we hit hung task errors.
> 
> As I've been digging, part of the issue seems to be kthreadd is not an
> RT task, thus after we create NR_CPU spinner threads, the following
> threads don't actually start right away. They have to wait until
> rt-throttling or the dl_server runs, allowing kthreadd to get cpu time
> and start the thread.  But then we have to wait until throttling stops
> so that the RT prio Ref thread can run to set the new thread as RT
> prio and then spawn the next, which then won't start until we do
> throttling again, etc.
> 
> So it makes sense if the dl_server is "refreshed" once a second, we
> might see this one thread per second interlock happening.  So this
> seems likely just an issue with my test.
> 
> However, prior to your change, it seemed like the the RT tasks would
> be throttled, kthreadd would run and the thread would start, then with
> no SCHED_NORMAL tasks to run, the dl_server would stop and we'd run
> the Ref, which would immediately eneueued kthreadd, which started the
> dl_server and since the dl_server hadn't done much, I'm guessing it
> still had some runtime/bandwidth and would run kthreadd then stop
> right after.
> 
> So now my guess (and my apologies, as I really am not familiar enough
> the the DL details) is that since we're not stopping the dl_server, it
> seems like the dl_server runtime gets used up each cycle, even though
> it didn't do much boosting. So we have to wait the full cycle for a
> refresh.

Yes. This makes sense.

The old code would disable the dl_server when fair tasks drops to 0
so even though we had that yield in __pick_task_dl(), we'd never hit it.
So the moment another fair task shows up (0->1) we re-enqueue the
dl_server (using update_dl_entity() / CBS wakeup rules) and continue
consuming bandwidth.

However, since we're now not stopping the thing, we hit that yield,
getting this pretty terrible behaviour where we will only run fair tasks
until there are none and then yield our entire period, forcing another
task to wait until the next cycle.

Let me go have a play, surely we can do better.


