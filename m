Return-Path: <linux-kernel+bounces-753384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC76B18229
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA095188FE2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5273248863;
	Fri,  1 Aug 2025 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNGTFS5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5719F13F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053657; cv=none; b=lvROerZlrF5ThysxoLo/pCyd8h4X6N5x9RfUY6AyizTLUxkc9DeLIDdsTQq0L7rK6qram/rZ/M41U6+DoWpuNicS0NhLsH8Oi1cHwcn8BtEGoO/OmZnz/jm184BE1RJXqzdPom0aY8wW+wAnGCTTd7SxVDuqP0XT3KGrft0uR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053657; c=relaxed/simple;
	bh=j7y8KCY6NrUVmlOUbXDVCtVZndOnq4LmqUjbLeFOglk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUFOzIe6Em1oVd5ukvPLg5KceffUrlziG23iKNa/AePs0uIR1FSUdIgg2Ou0PzjsO7Xhme2+AuNKNCNBNSsUY/aEukCmt75O5cSo7LwxUwh3lI4GnYHAzkjGrczrIlrNDzO1wzG8yGqbe2v/la2mMVTawoYhuYVRsObhn1jXSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNGTFS5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E677C4CEE7;
	Fri,  1 Aug 2025 13:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754053654;
	bh=j7y8KCY6NrUVmlOUbXDVCtVZndOnq4LmqUjbLeFOglk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNGTFS5YSX9TfKSaU9ggPe4cDO+QklfGW+zEYiOCzv/X7y01UnIiDQA8kqMta7iU0
	 mrc5BHp9CHeyjLH4YOR0m2LKbRAI5JgCrzz8qCYl6u+kE/cYoEiGkD1Q+SXXpI0nqP
	 QzxpTDboxZcrLMubdqTiNr0DUkomGdEc5Gkiz3+3N7W/AJYvp2XI0NBBoFcYM6no2J
	 4nPFYO1bNO/CJ2igXVZ+L42up9Ah3Yo/mAkyiCtP6K587vuuLl6XxSNfFmIIRxmcaM
	 /IMfzSferRMhq9fnd9r6KdGTFIFQ4PVAPMXgIYkqXywYpHqw+V0Dfx1/oFyVQraOz1
	 naQSqQd8VZKgA==
Date: Fri, 1 Aug 2025 15:07:31 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v9 8/8] timers: Exclude isolated cpus from timer migration
Message-ID: <aIy8E7IdpPr_KFtF@localhost.localdomain>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-9-gmonaco@redhat.com>
 <664fc8e7-98f6-410c-976e-2e497e5132f8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <664fc8e7-98f6-410c-976e-2e497e5132f8@redhat.com>

Le Thu, Jul 31, 2025 at 02:25:30PM -0400, Waiman Long a écrit :
> On 7/30/25 9:11 AM, Gabriele Monaco wrote:
> > The timer migration mechanism allows active CPUs to pull timers from
> > idle ones to improve the overall idle time. This is however undesired
> > when CPU intensive workloads run on isolated cores, as the algorithm
> > would move the timers from housekeeping to isolated cores, negatively
> > affecting the isolation.
> > 
> > Exclude isolated cores from the timer migration algorithm, extend the
> > concept of unavailable cores, currently used for offline ones, to
> > isolated ones:
> > * A core is unavailable if isolated or offline;
> > * A core is available if non isolated and online;
> > 
> > A core is considered unavailable as isolated if it belongs to:
> > * the isolcpus (domain) list
> > * an isolated cpuset
> > Except if it is:
> > * in the nohz_full list (already idle for the hierarchy)
> For the nohz_full list here, do you mean nohz_full housekeeping or
> non-housekeeping list?

nohz_full.

> > @@ -436,6 +437,20 @@ static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
> >   	return !(tmc->tmgroup && tmc->available);
> >   }
> > +/*
> > + * Returns true if @cpu should be excluded from the hierarchy as isolated.
> > + * Domain isolated CPUs don't participate in timer migration, nohz_full
> > + * CPUs are still part of the hierarchy but are always considered idle.
> > + * This check is necessary, for instance, to prevent offline isolated CPU from
> > + * being incorrectly marked as available once getting back online.
> > + */
> > +static inline bool tmigr_is_isolated(int cpu)
> > +{
> > +	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
> > +		cpuset_cpu_is_isolated(cpu)) &&
> > +	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> > +}
> 
> Does that mean a CPU in the nohz_full non-housekeeping list is always
> considered not isolated WRT timer migration and hence will be made available
> for timer migration purpose?

Exactly, because nohz_full CPUs become idle (from a tick and timer migration
POV) when they stop their tick. And since they are idle, their global timer
are handled by the timekeeping CPU.

This is much better than making the CPU unavailable like is done in this
patchset for domain isolated CPUs, because unavailable CPUs must still handle
their own global timers. Unfortunately we can't just fake them as well as idle,
like we do with nohz_full CPUs, because that would mean walking the whole timer
migration tree everytime a timer is queued or modified. This would be too
costly.

Indeed that should be commented somewhere in this function.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

