Return-Path: <linux-kernel+bounces-878746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4845FC21665
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C95C4EEFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7B3655E0;
	Thu, 30 Oct 2025 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT5OXzNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB383678A1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844137; cv=none; b=qp+JmTs1hQbKo5eobmZtwmbC39V5t/hwGaP/oRJoPkqGbMzlUYU7oYhEjoPlTJxPJqeULd+SmTH7qgi7mG/WgLdP5+28L+D5BeoNNN8lK0ffoTbYvDdo0kEto6+WuY7vjpfud3Z4oXfXDJjAl+lsf/nY3TpKFBRyOPSm+KmPzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844137; c=relaxed/simple;
	bh=Kw/eTAu3T8JEYrBU4lbzvk6yhtsreAjtiErpX/o/1t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=empPlWyltEXV9mX61DFF6Z+77VKfFY2/KHuKrMAGcemiyBU+Zr9aQ0UxqfN49koK+yc4+Nq+RuWHLBbRGPHE5sqAz1D5F7WG6sLtrqZqQ/7WzmCkv0O9mCO8D3agOel5Ll+fD/UssbvntCAemKgOg5bsljQc0DCAjsZaqtyLYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT5OXzNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD55C4CEF8;
	Thu, 30 Oct 2025 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844137;
	bh=Kw/eTAu3T8JEYrBU4lbzvk6yhtsreAjtiErpX/o/1t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GT5OXzNkNf1L/PoochU0ZLDM6lfcVu31OWMGQNR+jf6ZxK3lbtDnx0eFMdb9Y+oqD
	 T0hHgR38v+zM8hkxp5Dbd4NgGa58B23fy+Qv8GQ4GllueOtDGcKDL60N+o6Cav4N7Q
	 xY2kAJD7dBzp09uFORSCtnfBgcdO1toLOh/hzkenmGoxB6+NQNpG8NIppPLoaV5kOp
	 p3ijAfqhidsC3nS238l0Q9Iq9bkGM4evSkTKd3rneKkMuRpo14CfLbIKb+V4/AZka1
	 xcFQ3hChJQgwezsUQfuUbLOcrkpUyzeryJkIvNXTCM6paEWeNXdk3lY+pja8XZAXUW
	 2BLUj2w5F2Qzw==
Date: Thu, 30 Oct 2025 18:08:54 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aQObphtf6Vbc-XLJ@localhost.localdomain>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
 <aQNySRvImq2yaUef@localhost.localdomain>
 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>

Le Thu, Oct 30, 2025 at 11:37:36AM -0400, Waiman Long a écrit :
> On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
> > Hi Waiman,
> > 
> > Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
> > > On 10/20/25 7:27 AM, Gabriele Monaco wrote:
> > > > The timer migration mechanism allows active CPUs to pull timers from
> > > > idle ones to improve the overall idle time. This is however undesired
> > > > when CPU intensive workloads run on isolated cores, as the algorithm
> > > > would move the timers from housekeeping to isolated cores, negatively
> > > > affecting the isolation.
> > > > 
> > > > Exclude isolated cores from the timer migration algorithm, extend the
> > > > concept of unavailable cores, currently used for offline ones, to
> > > > isolated ones:
> > > > * A core is unavailable if isolated or offline;
> > > > * A core is available if non isolated and online;
> > > > 
> > > > A core is considered unavailable as isolated if it belongs to:
> > > > * the isolcpus (domain) list
> > > > * an isolated cpuset
> > > > Except if it is:
> > > > * in the nohz_full list (already idle for the hierarchy)
> > > > * the nohz timekeeper core (must be available to handle global timers)
> > > > 
> > > > CPUs are added to the hierarchy during late boot, excluding isolated
> > > > ones, the hierarchy is also adapted when the cpuset isolation changes.
> > > > 
> > > > Due to how the timer migration algorithm works, any CPU part of the
> > > > hierarchy can have their global timers pulled by remote CPUs and have to
> > > > pull remote timers, only skipping pulling remote timers would break the
> > > > logic.
> > > > For this reason, prevent isolated CPUs from pulling remote global
> > > > timers, but also the other way around: any global timer started on an
> > > > isolated CPU will run there. This does not break the concept of
> > > > isolation (global timers don't come from outside the CPU) and, if
> > > > considered inappropriate, can usually be mitigated with other isolation
> > > > techniques (e.g. IRQ pinning).
> > > > 
> > > > This effect was noticed on a 128 cores machine running oslat on the
> > > > isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> > > > and the CPU with lowest count in a timer migration hierarchy (here 1
> > > > and 65) appears as always active and continuously pulls global timers,
> > > > from the housekeeping CPUs. This ends up moving driver work (e.g.
> > > > delayed work) to isolated CPUs and causes latency spikes:
> > > > 
> > > > before the change:
> > > > 
> > > >    # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > >    ...
> > > >     Maximum:     1203 10 3 4 ... 5 (us)
> > > > 
> > > > after the change:
> > > > 
> > > >    # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > >    ...
> > > >     Maximum:      10 4 3 4 3 ... 5 (us)
> > > > 
> > > > The same behaviour was observed on a machine with as few as 20 cores /
> > > > 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> > > > 
> > > > The first 5 patches are preparatory work to change the concept of
> > > > online/offline to available/unavailable, keep track of those in a
> > > > separate cpumask cleanup the setting/clearing functions and change a
> > > > function name in cpuset code.
> > > > 
> > > > Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
> > > > nohz_full from covering all CPUs not leaving any housekeeping one. This
> > > > can lead to problems with the changes introduced in this series because
> > > > no CPU would remain to handle global timers.
> > > > 
> > > > Patch 9 extends the unavailable status to domain isolated CPUs, which
> > > > is the main contribution of the series.
> > > > 
> > > > This series is equivalent to v13 but rebased on v6.18-rc2.
> > > Thomas,
> > > 
> > > This patch series have undergone multiple round of reviews. Do you think it
> > > is good enough to be merged into tip?
> > > 
> > > It does contain some cpuset code, but most of the changes are in the timer
> > > code. So I think it is better to go through the tip tree. It does have some
> > > minor conflicts with the current for-6.19 branch of the cgroup tree, but it
> > > can be easily resolved during merge.
> > > 
> > > What do you think?
> > Just wait a little, I realize I made a buggy suggestion to Gabriele and
> > a detail needs to be fixed.
> > 
> > My bad...
> 
> OK, I thought you were OK with the timer changes.

I was ok until...just a few days ago, and I should have written about it right
away but you know, being wrong is a process that takes time :o)

> I guess Gabriele will have to send out a new version to address your finding.

Right.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

