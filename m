Return-Path: <linux-kernel+bounces-821405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1BDB812D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109CD4648B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C32F7463;
	Wed, 17 Sep 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxcA1dSj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2834BA23
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130255; cv=none; b=p6hkZ2xVDCgnocTtXBkgZJodFdxx2YGz+pa3FDN4xmgHfQk+TTyKyVomFoEvD7GWkzpOiheDgantY5RSYSRr6A7mMyzLZHAcyc3zNSyzq5cvhzhki5YVHv4DCYnvBWlRmC6E6WOk5YygNEFRU4HnZoHEbyg6Mgy6zKYmA827W8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130255; c=relaxed/simple;
	bh=QA5OY49WfK/lx7gDzPSDCw76gPxnCyvW5v/Bfs73aKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIL8TwU188sDWDzqDSJjyJoWELuDhFI/UksIt4t5z8PmITBtrAkP5OAGeMvhr/7pjOYNeMvFgaOLr/77jiBfI6Dc87M5dtRJ57ub9g8NEdIB82Iu69vZXo2n1Gs3vTUR3/QelZFBEn4HJXceRx7w6vNkK4rY0XzLM1oVHAOndu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hxcA1dSj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDKloXtqzKlGD688W3HBLzrsmBHOyXoERASTXFgY8F0=; b=hxcA1dSjLZdbhDgX8PLYlYZCyq
	g6FQXsXE2b6lKfq+UHcyYgvPd/24x96zJzyUnkAk+fwyndRpna51TSDsDEEZkeRMSEX+4Mpq+6ZEB
	R5QLuBBT15qOEWCWNNOQ2NqMhUsaFjllBW1pM4O1zz2grhaic4M2KL8RLGUccCeR5hQBMjkCRSigi
	loc7Go+Ws++CMToEHnX+imQtJBfom4OIr1RfGLtG9PsjWBLp68D4X675bidH8Mv5T7zEjex4s8FF2
	EQuYx6hvXNd1mI7G6X2ehNuavROqV8m9Or7kRpyckYtxhgvtieNn4h8eG2/7DND68yOHRokFxNqSD
	6z9X73tw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyvzL-00000007Tqh-2oul;
	Wed, 17 Sep 2025 17:30:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 372CE300212; Wed, 17 Sep 2025 19:30:39 +0200 (CEST)
Date: Wed, 17 Sep 2025 19:30:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20250917173038.GA973992@noisy.programming.kicks-ass.net>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
 <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
 <CANDhNCqK3VBAxxWMsDez8xkX0vcTStWjRMR95pksUM6Q26Ctyw@mail.gmail.com>
 <20250917093441.GU3419281@noisy.programming.kicks-ass.net>
 <20250917122616.GG1386988@noisy.programming.kicks-ass.net>
 <aMq-BKLSIG9JrRb7@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMq-BKLSIG9JrRb7@jlelli-thinkpadt14gen4.remote.csb>

On Wed, Sep 17, 2025 at 03:56:20PM +0200, Juri Lelli wrote:

> > + * By stopping at this point the dl_server retains bandwidth, which, if a new
> > + * task wakes up imminently (starting the server again), can be used --
> > + * subject to CBS wakeup rules -- without having to wait for the next period.
> 
> In both cases we still defer until either the new period or the current
> 0-laxity, right?
> 
> The stop cleans all the flags, so subsequent start calls
> enqueue(ENQUEUE_WAKEUP) -> update_dl_entity() which sets dl_throttled
> and dl_defer_armed in both cases and then we start_dl_timer (defer
> timer) after it (without enqueueing right away).
> 
> Or maybe I am still a bit lost. :)

The way I read it earlier today:

  dl_server_start()
    enqueue_dl_entity(WAKEUP)
      if (WAKEUP)
	task_contending();
	update_dl_entity()
	  dl_entity_overflows() := true
	  update_dl_revised_wakeup();

In that case, it is possible to continue running with a slight
adjustment to the runtime (it gets scaled back to account for 'lost'
time or somesuch IIRC).


