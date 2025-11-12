Return-Path: <linux-kernel+bounces-897450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BAFC52EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC61561844
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BEA34026B;
	Wed, 12 Nov 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Out3uWq8"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78533ADA2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958585; cv=none; b=m106F/Bo75J0CU4YPNQEjmyJxWCPQhqfPCtE8pc9+7ueCFNnn1R0xJVsmbipxEqIt+Jy56apMfirB+/4b4Qzqn90dnE1Bo0m1UfU3Kbguz9ip6hXVs5z0bU7WzX6c7WGCfMAHqx7cjkj2Z2gaCV+SkioMXqS32IWS06U064cVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958585; c=relaxed/simple;
	bh=HQ1BuCdtx31MJO66P0IH2reHy9XCEC4e6H5ICye6D+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHFl7+zSxaZwmnFGNSdu1l4EqLlfiB7d28FnyVdJYA8KCtQiZH70t6up1DCP7p+vGMgWuA89a4W/HwICNDLaFHQ2aM7RTJDqpdk1uZjsLhWERV81gaIwbUwmLqfoC0Frc/2EiIxz6dNZTFTqIAbCSqRUvCocrHV4njKYRUCQj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Out3uWq8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BoymI715aJc9OnICmdEYBrfRAy666rfRY7hmU1L+bI8=; b=Out3uWq8oHD42KuoP2ZN+4gIBZ
	HiqCtpkLAnq2HUDBAvnsEgCeDL0x1l/763exZwuWZAOBFSGWl1h48mSxg2lQ3Z5QKkkUTDdYDddcw
	lSa22o+Ou6f/RZTHo+jCBielWK4unGG1KYXGNhKpJW/8WVBXRnjvTKHTLC7glwdZN0sBi7L+XbUsf
	RVWCL1zeZBTRB226joAiqw9XOfPQwaREpNOJx6GP+pGgdqcxvnhO0ZcUeHHYJ6fakdoNr12M5eadZ
	xOZ7sqQNPmfbWUKq2M5KDEpSAIxTuOEt0AHkBn4LYrlf2f/mgrO0kAe4hdjV+Q5MRgs6X2XtIGNP5
	DTWAT8eQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJC3X-000000063HE-0RfK;
	Wed, 12 Nov 2025 14:42:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CD4EF300265; Wed, 12 Nov 2025 15:42:41 +0100 (CET)
Date: Wed, 12 Nov 2025 15:42:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Chris Mason <clm@meta.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Josh Don <joshdon@google.com>
Subject: Re: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
Message-ID: <20251112144241.GP278048@noisy.programming.kicks-ass.net>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.525916173@infradead.org>
 <2acd7c1d-e2b4-40a0-85de-55f9b2635dad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acd7c1d-e2b4-40a0-85de-55f9b2635dad@linux.ibm.com>

On Wed, Nov 12, 2025 at 08:07:24PM +0530, Shrikanth Hegde wrote:
> 
> 
> On 11/7/25 9:36 PM, Peter Zijlstra wrote:
> > Pull out the !sd check to simplify code.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   kernel/sched/fair.c |   10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12811,14 +12811,16 @@ static int sched_balance_newidle(struct
> >   	rcu_read_lock();
> >   	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> > +	if (!sd) {
> > +		rcu_read_unlock();
> > +		goto out;
> > +	}
> 
> when is sd null? on isol_cpus ?

Yeah, partitions (cpuset/isol_cpus) but also spuriously during
domain-rebuild IIRC.

> if sd is null, i think we are skipping these compared to earlier.
> 
>         t0 = sched_clock_cpu(this_cpu);
>         sched_balance_update_blocked_averages(this_cpu);

let me pull that sched_balance_update_blocked_averages() thing up a few
lines.

Thanks!

