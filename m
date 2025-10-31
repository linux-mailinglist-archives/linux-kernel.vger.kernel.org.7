Return-Path: <linux-kernel+bounces-880467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D3C25D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90DA14E9255
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3029D29E;
	Fri, 31 Oct 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zcbi8VT0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D152BEC4A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924014; cv=none; b=c9UZy4wYZeHMi+6pQBajLgQo+g+ILSIsJFS2DWqmZK68EcOSvYgy/83BHCADGVpj0wPTCH0x2a2Xn78cRXox/gLpj+gicSNQUh4Lbju/J/iTREjlvDCsmfRwQEBcx8cp+w47mV4GNwOL5oEQDWLAtGwL2AlPUZN1a1SiXP4ukhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924014; c=relaxed/simple;
	bh=QmO/nZOVQ0O8efpTIAHlN+50U9WhBaD7ej5ti6Ps0GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5pFFRUOKYTfdDVmpepCNcs2Sgic2U+GT//RintTUmcrJ4Bos5/yYvRIvVUSX70SCs1ASksQCMXJs/Vv7PmszlV2Q9bYoi+qbniUifnh9if7axSdUDewi250KHN6BqnJmqAZWzb+RXxGW9WOzQN68V7xwi+IrKrcxiw20W+viMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zcbi8VT0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h8bL2TPB6cLF5ZFZFQRP43v5iwip6JKwCi7RFavvBnM=; b=Zcbi8VT03CCzp2BBRylBMMMXgY
	1luxFL36CN+PJ2nAhC8iRshLBhXsfqXzvgs1bsO7yko3egzpvNds6qHFyzE4/KrARypyc03w1SJXA
	jPW5xdoE5+1ZFvRYWI8hydmIKgNU3oqcw/mzqL2sCCsklT39szf8ZIE0mqPawZHRB03FYd80Q2Lqh
	y36Bs6nTT6xF6jUfo+KCcSef7RK1hfeLdmQuSSmarS2R7EburoWyvBCnlq2C6Na3YZi8ce+8CNcDf
	YevbH+OV47qVx3Me6IiaFQS4vgrZclzq8pZlYrGks0+1TU88UCrvxHg1XxUpimPssq3HBKawqzGsE
	nx4oSZAw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEqv7-00000000zFu-1rh5;
	Fri, 31 Oct 2025 15:20:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8735D30029E; Fri, 31 Oct 2025 16:20:05 +0100 (CET)
Date: Fri, 31 Oct 2025 16:20:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
References: <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>

On Fri, Oct 31, 2025 at 02:24:17PM +0100, Gabriele Monaco wrote:
> On Fri, 2025-10-31 at 14:05 +0100, Peter Zijlstra wrote:
> > On Thu, Oct 30, 2025 at 07:42:05PM +0100, Peter Zijlstra wrote:
> > > On Wed, Oct 22, 2025 at 12:11:51PM +0200, Gabriele Monaco wrote:
> > > > 
> > > > Is this expected?
> > > 
> > > Sort of, that was next on the list. Let me see if I can make it stop a
> > > little more.
> > 
> > OK, so I've gone over things again and all I got was a comment.
> > 
> > That is, today I think it all works as expected.
> > 
> > The dl_server will stop once the fair class goes idle long enough. Can
> > you confirm this?
> > 
> 
> I'm going to go through your comment more carefully, but what I can observe now
> is a bit different:
> 
> After this patch, consuming bandwidth in background on fair tasks and on idle is
> equivalent. Updating idle time does effectively replenish after exhausting
> runtime and we never stop the server (IMO this is correct behaviour only for
> fair tasks, since there's potentially something to do).
> At least this is the behaviour I get on a mostly idle system.
> 
> Different scenario if I have the CPU busy with other tasks (e.g. RT policies),
> there I can see the server stopping and starting again.
> After I do this I seem to get a different behaviour (even some boosting after
> idle), I'm trying to understand what's going on.
> 
> Does this behaviour make sense to you?

Ooooh, because idle time is accounted against the server budget too.

That is, idle and running fair are both [2] in my comment. So we never
get to [5].

Humm, let me noodle a bit more on this. Also, I should see if I can get
graphviz to draw ascii art state diagrams :-)

