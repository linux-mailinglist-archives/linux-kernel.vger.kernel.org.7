Return-Path: <linux-kernel+bounces-878935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC9C21CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948A7189168A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E936C247;
	Thu, 30 Oct 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jhj+rZRc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF1437A3C8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849730; cv=none; b=bpMO8yHO0NJLEEpJKIqoOk76R1JCQG4bYX2FjarFCd59l7DjPujnclHLqKVvw6nfJA0yl1rNvzvEErxVQv8IlIub7rU7icNs1D9SCS6fdTImWt9mNXzmgXIRu1kSoWnP3eauuMp+sQdsGz+J9gS1Dp7qgdLT/SDiQ/zypKE1wLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849730; c=relaxed/simple;
	bh=qfWVp/47gDYfMV04cUy/+JxeEB45pBCZPvYNWIkA2Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H43foorXPOWaA6jUAq9Q9XQqtWnYBnJZMS3bsoobshpSSSjxQ5rMINq7BYHkGOtBhODxWnUF6omLv/k3UwulqGqR/6X1yVhUICKmlX6BYnvW4XD71l5GkQEcONDCRVWQlqMChVIPqDCyyCpzgPedZffuoadYwODOXx3I2J+vSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jhj+rZRc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VuDtk6Wfak+z/PHOCu2vMlEQrltrT5X8Ug5SksNAYSo=; b=jhj+rZRcsQ4+mzhzN3eGx8eXO/
	WVoRqVsbq7J2wsK8BfEZRlW8UpXjG0GDrC+/pWxA+ruzWXQCXA3L9jH84jHZo++nb8rRe7gWXhwtK
	NBZuFe48KzwzpWIstySmJVpMav6Ss7kbjQWMeijIcG38T4PDfP8lmFG+Y9y4PTUPU3a1GRRmph7Vq
	RukM91dVr0Rfv7VxMsftfBKXGcHjvXMRkwPZU3twV/59z9VDHyhomeoavg0k/9uPicAF2ziWBTG5G
	4pK5tR0gWSmO/7woJPztGCQqGsTuVABbJYyvfcKWA+Wo3JcemUr2bG+mJBTHBl0rBn1+9aylft8t5
	mI/X4S0Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEWjL-00000009m0N-1s8q;
	Thu, 30 Oct 2025 17:46:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5143C30029E; Thu, 30 Oct 2025 19:42:05 +0100 (CET)
Date: Thu, 30 Oct 2025 19:42:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>

On Wed, Oct 22, 2025 at 12:11:51PM +0200, Gabriele Monaco wrote:

Sorry, finally cycling back to this.

> > So how about something like this for starters?
> > 
> 
> Thanks Peter for sharing this patch, I run it through my test and the model
> seems to pass (i.e. no more boosting after deadline). What I found curious
> however, is that throughout the test, servers went only through replenish
> events.
> The system under test is mostly idle (6 periodic dl tasks on a 16 CPUs virtme-ng
> VM), so I expect not to see any task boosted by the servers, but in 5 minutes I
> didn't even observe any start/stop for the server.
> 
> I'm not sure why this is happening, but looking at traces it seems replenish
> occurs more often and perhaps doesn't let the server stop:
> 
> <idle>-0     [009] d.h3.    14.312395: (+950124) event_nomiss:         -9: idle x dl_replenish_idle -> idle
> <idle>-0     [009] d.h3.    14.312401: (+6)     sched_dl_replenish:   comm=server pid=-9 runtime=50000000 deadline=15253307235 yielded=0
> <idle>-0     [009] d.h3.    15.262771: (+950370) event_nomiss:         -9: idle x dl_replenish_idle -> idle
> <idle>-0     [009] d.h3.    15.262781: (+10)    sched_dl_replenish:   comm=server pid=-9 runtime=50000000 deadline=16203668554 yielded=0
> <idle>-0     [009] d.h3.    16.213117: (+950336) event_nomiss:         -9: idle x dl_replenish_idle -> idle
> <idle>-0     [009] d.h3.    16.213123: (+6)     sched_dl_replenish:   comm=server pid=-9 runtime=50000000 deadline=17154029879 yielded=0
> 
> Is this expected?

Sort of, that was next on the list. Let me see if I can make it stop a
little more.

