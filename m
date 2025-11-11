Return-Path: <linux-kernel+bounces-894984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A5C4CA06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADAB18C0806
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C57D2DC35C;
	Tue, 11 Nov 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iC3rAGJP"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844A1E7C23
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852825; cv=none; b=l13t1Pww3lXZ/SiynkT3I3HJCoqxuYwYkyRXZwj9rXwDD9uKKZ1EVmmtGoagdp6wOyzHRNZiOQmTM0xalN+25EkyE6xesuiQMD9fb0zsauxVFzX1gqTTPhJCiOCyXTIbKPG+iiRX5m8VdUQSM743+XJPPnzbwnKw7LnPlp327Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852825; c=relaxed/simple;
	bh=LwXh8WK26AJaQ7ZCIdlPCs6xPljwkOq9QQrm0FZM220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU3HwdBeO3NMVjb3r47dxfWB/3Nqnhg7yGEclz9JWNCoI8Q8t2q7JCeiL9Sg8Sm748puioGxNyVnlByjV0hhCH/9OhFDvyPaOV/O6xQzlTr0u3NWaRdB8sCOS4/BHknE4iNZuKi0ucrpb9t9Z8rpMzRSzm9zLi7ivYEpQaNWyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iC3rAGJP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dcYcPJY3H/k/eRT5a19gEpotDGRZ3dyDyv0pbSbHEqM=; b=iC3rAGJPIGbJqt79QVgO4ZHiOM
	60CHwyGgI0dnucPfdRyI4AtVFKHx/zx6mNB31+4oRunpc8qyuG2X1Ox+T27XJAeS3eNq6XEHOtB7D
	DpSsECr61/5m1mbzzoS/dXxTPXtI8K7SzcMdbJkYe+DUIn+WKn8GgpCuoqBAT/TXXhSQ3X+gVuoaJ
	27rRnk6FYaSaKrfF0PrLuoSkU5ZfDiiCvh8O0s4dMdzct2a1aH3fkONl8SyIVwrr3Jrt+29cUq+uh
	1ACCo1VMUWHNkuCkf5jS36UDdaosRl94NhAWXWqqfLTBuQ5mz1iNZU5HQ/oBt6JalHLsM6ktDmNWF
	8JJrJErA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkXq-00000002RRr-2Ln2;
	Tue, 11 Nov 2025 09:20:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E0AF300328; Tue, 11 Nov 2025 10:20:09 +0100 (CET)
Date: Tue, 11 Nov 2025 10:20:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: Chris Mason <clm@meta.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Josh Don <joshdon@google.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched/fair: Proportional newidle balance
Message-ID: <20251111092009.GE278048@noisy.programming.kicks-ass.net>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.770122091@infradead.org>
 <ee62fc73-2a08-4648-8852-afa9e2705c8c@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee62fc73-2a08-4648-8852-afa9e2705c8c@os.amperecomputing.com>

On Tue, Nov 11, 2025 at 05:07:45PM +0800, Adam Li wrote:
> > @@ -12843,6 +12858,22 @@ static int sched_balance_newidle(struct
> >  			break;
> >  
> >  		if (sd->flags & SD_BALANCE_NEWIDLE) {
> > +			unsigned int weight = 1;
> > +
> > +			if (sched_feat(NI_RANDOM)) {
> > +				/*
> > +				 * Throw a 1k sided dice; and only run
> > +				 * newidle_balance according to the success
> > +				 * rate.
> > +				 */
> > +				u32 d1k = sched_rng() % 1024;
> > +				weight = 1 + sd->newidle_ratio;
> > +				if (d1k > weight) {
> > +					update_newidle_stats(sd, 0);
> > +					continue;
> > +				}
> > +				weight = (1024 + weight/2) / weight;
> > +			}
> >  
> e.g: Why 'weight = (1024 + weight/2) / weight'

Not sure what you're asking, so two answers:

That's a rounding divide. We have a helper for that, but I never can
remember what its called.

The transformation as a whole here is from a ratio to a weight, suppose
our ratio is 256, this means that we do 1-in-4 or 25% of the balance
calls. However this also means that each success needs to be weighted as
4 (=1024/256), otherwise we under-account the successes and not even a
100% success rate can lift you out the hole.

Now, I made it a rounding divide to make it a little easier to climb out
of said hole (I even considered ceiling divide).



