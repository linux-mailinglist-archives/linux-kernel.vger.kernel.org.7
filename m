Return-Path: <linux-kernel+bounces-863429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D7BF7D98
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A5418C8793
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFBB34C153;
	Tue, 21 Oct 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyoPCrnN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DE34B68F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067142; cv=none; b=Vtn3PX40/zV78EO2m69BSYX7zOe4U59TKAYNiS1AMxzVvnpmEik8GrcN77BVAezbEF+1Dul2DcTLR3quXGuOgD+7fbe0hBNyLC3AMy5rE1g/Tq7YdWQBmKo+sLICkg+GW3xyWAN7UVCrlQqzhSGVJi/X2DjxXr6UU+WMykraZiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067142; c=relaxed/simple;
	bh=D66AJtpzEdEE8Ma1PytkkkZcLyB7/a7V/jHOebqMlTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX3j/TU0oHdmnIjPQ5xP2Bo0OCcZ+07FbfCQ5oLMmXqjiBINMBpru/r+2gYbBDUjT4Qbp1bq/X8cMgy5ohow7tyfH/p6zU5EdNYapjSdXtKq6nzKfl/Q0MTbvqj2Aj5QQc7+ifpWl7hXGoBnpDNwa+tYsfaBqvEOEVZTawR/G38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nyoPCrnN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HwSGltUEIHGRNPyDUa8142xXUwF6AZpPMZYZ26Uoj3I=; b=nyoPCrnNVhUkBEle3sVu40EUWe
	GoBEdWyiuH4AroNqef9eVd+gHJplKle8D++DVW7tDxKWZbjtYRcDjaWSZnoMIBKrLVPTJxPlpGk9p
	wyRIXTd5PJ2KfRJpUG8euel7Ufr4Vc5ZlqXQundQLCvAZNaK8dCBBjdyyRGIng7wScC1sI5K1gLVi
	KVL1p/I/vn4KLGxLYyT/8gkx4xa1yg35/+MvUrRBtb0moeZmCkTKFnUoWnlLkEDLZX17r3NFoHFal
	B1uwvDge43jkZvFUaZSmEioa3hzg+C7fnPpm2NJ82IlR/iYTHSTX/Oed8G4vQC7BY2FqVZThS7Z5A
	3f7RrH+Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBG0Z-0000000DsQ3-0A1m;
	Tue, 21 Oct 2025 17:18:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C0BD300310; Mon, 20 Oct 2025 10:22:50 +0200 (CEST)
Date: Mon, 20 Oct 2025 10:22:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
Message-ID: <20251020082250.GF3245006@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
 <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
 <87y0p9zo9y.ffs@tglx>
 <20251017175853.GH3419281@noisy.programming.kicks-ass.net>
 <20251017181911.GR1386988@noisy.programming.kicks-ass.net>
 <87jz0qzl74.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz0qzl74.ffs@tglx>

On Sun, Oct 19, 2025 at 10:32:47PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 17 2025 at 20:19, Peter Zijlstra wrote:
> > On Fri, Oct 17, 2025 at 07:58:53PM +0200, Peter Zijlstra wrote:
> >> Same is true when you offline a CPU come to think of it.
> >> 
> >> Same is true if the cpumask is sparse.
> >> 
> >> Anyway, just saying, checking against nr_cpu_ids might not be the best
> >> shortcut here.
> >
> > Put another way, nr_cpus_allowed == nr_cpu_ids only work when none of
> > the masks involved have holes. The moment anything {possible, present,
> > online} has holes in, it goes sideways.
> 
> You're right. I was too narrowly focussed on the normal x86 case, where
> nr_cpu_ids == num_possible_cpus ....
> 
> Let me think about that.

So the obvious idea would be to grow hotplug hooks, such that you can
do:

  nr_cpus_allowed == num_online_cpus()

But then hotplug will have to iterate all mm's. Doable, but not really
nice.

