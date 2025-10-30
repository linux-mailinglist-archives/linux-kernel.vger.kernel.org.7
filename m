Return-Path: <linux-kernel+bounces-878753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1191C21644
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053EB1A61E47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57F3678D5;
	Thu, 30 Oct 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvzVaCq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6633313260
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844239; cv=none; b=AkDZVr3AZ7P6sXla4bSXR5arufUKupRthDu4uzWjKLBv7Getw7VbnhQpZaN/icq+ET9QaRbqh3/3mOkzON/sM9CCHPtDxEvD7mpFq5dAFADQDX3DAsAU7KMnho6/ph+Udu1Ambu3C6KGkfB9ip/MKJ7LixplJS6Zde/xnl/HLGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844239; c=relaxed/simple;
	bh=5i8i7KAz8WkbGotj3gMj+TbKVqbsl7y8b8HQ3zc+31g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKzqiiZaya4PfeXwz9I250ZG+NLaya6GZ/Dec6QbT3/VrwMUH+CAHo6uqCpeiHv2oecSN0DKlBmij6IwglK8lcSwEGIyUuefJKz6tbuXKUAWLJxFBZoqWkzJBeUZYtFmO/Rc5jM32gUA9FnkCq+yFn343OulW3J4ig3eztce3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvzVaCq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159FCC4CEF1;
	Thu, 30 Oct 2025 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761844238;
	bh=5i8i7KAz8WkbGotj3gMj+TbKVqbsl7y8b8HQ3zc+31g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvzVaCq6SVKZ7nfeYM03rF3XTx5SzgziFwBD02e7H51aOxoYjvBt+Ity/ZvL2fZ9W
	 utju/xxzJHzgPcIyO3dt2B7v6QePuVHz1YivY6FoW/IDHQqRBg0x6tUC+OlUtWbrMb
	 f26ZbbobMBvCcEAXjV4g+r4Gdj4SqzLPezHb6R4ZROaCwSFXq54gUCh/2dgEj0wF3Y
	 eVIguduU7dDTHInF00EYMAUhQd5JFEYj3xmhpqyn+OyWW3wFnKQXjdWIQAkBBt/nZ1
	 wYP4XrjFhhbzne4J8uEOk/IlRw9zirM1QA9PYyVbspSMNpaztOcnfJXd0KEVp5v0XO
	 /Lm2XN8pfzwAw==
Date: Thu, 30 Oct 2025 18:10:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aQOcC1GaUlLWsUPv@localhost.localdomain>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
 <aQNySRvImq2yaUef@localhost.localdomain>
 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
 <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
 <84511fa7-3a28-425c-b0fd-8d971a5f7eb1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84511fa7-3a28-425c-b0fd-8d971a5f7eb1@redhat.com>

Le Thu, Oct 30, 2025 at 12:37:08PM -0400, Waiman Long a écrit :
> On 10/30/25 12:09 PM, Gabriele Monaco wrote:
> > 
> > On Thu, 2025-10-30 at 11:37 -0400, Waiman Long wrote:
> > > On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
> > > > Hi Waiman,
> > > > 
> > > > Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
> > > > > On 10/20/25 7:27 AM, Gabriele Monaco wrote:
> > > > > > The timer migration mechanism allows active CPUs to pull timers from
> > > > > > idle ones to improve the overall idle time. This is however undesired
> > > > > > when CPU intensive workloads run on isolated cores, as the algorithm
> > > > > > would move the timers from housekeeping to isolated cores, negatively
> > > > > > affecting the isolation.
> > > > > > 
> > > > > > Exclude isolated cores from the timer migration algorithm, extend the
> > > > > > concept of unavailable cores, currently used for offline ones, to
> > > > > > isolated ones:
> > > > > > * A core is unavailable if isolated or offline;
> > > > > > * A core is available if non isolated and online;
> > > > > > 
> > > > > > A core is considered unavailable as isolated if it belongs to:
> > > > > > * the isolcpus (domain) list
> > > > > > * an isolated cpuset
> > > > > > Except if it is:
> > > > > > * in the nohz_full list (already idle for the hierarchy)
> > > > > > * the nohz timekeeper core (must be available to handle global timers)
> > > > > > 
> > > > > > CPUs are added to the hierarchy during late boot, excluding isolated
> > > > > > ones, the hierarchy is also adapted when the cpuset isolation changes.
> > > > > > 
> > > > > > Due to how the timer migration algorithm works, any CPU part of the
> > > > > > hierarchy can have their global timers pulled by remote CPUs and have to
> > > > > > pull remote timers, only skipping pulling remote timers would break the
> > > > > > logic.
> > > > > > For this reason, prevent isolated CPUs from pulling remote global
> > > > > > timers, but also the other way around: any global timer started on an
> > > > > > isolated CPU will run there. This does not break the concept of
> > > > > > isolation (global timers don't come from outside the CPU) and, if
> > > > > > considered inappropriate, can usually be mitigated with other isolation
> > > > > > techniques (e.g. IRQ pinning).
> > > > > > 
> > > > > > This effect was noticed on a 128 cores machine running oslat on the
> > > > > > isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> > > > > > and the CPU with lowest count in a timer migration hierarchy (here 1
> > > > > > and 65) appears as always active and continuously pulls global timers,
> > > > > > from the housekeeping CPUs. This ends up moving driver work (e.g.
> > > > > > delayed work) to isolated CPUs and causes latency spikes:
> > > > > > 
> > > > > > before the change:
> > > > > > 
> > > > > >    # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > > > >    ...
> > > > > >     Maximum:     1203 10 3 4 ... 5 (us)
> > > > > > 
> > > > > > after the change:
> > > > > > 
> > > > > >    # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > > > >    ...
> > > > > >     Maximum:      10 4 3 4 3 ... 5 (us)
> > > > > > 
> > > > > > The same behaviour was observed on a machine with as few as 20 cores /
> > > > > > 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> > > > > > 
> > > > > > The first 5 patches are preparatory work to change the concept of
> > > > > > online/offline to available/unavailable, keep track of those in a
> > > > > > separate cpumask cleanup the setting/clearing functions and change a
> > > > > > function name in cpuset code.
> > > > > > 
> > > > > > Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
> > > > > > nohz_full from covering all CPUs not leaving any housekeeping one. This
> > > > > > can lead to problems with the changes introduced in this series because
> > > > > > no CPU would remain to handle global timers.
> > > > > > 
> > > > > > Patch 9 extends the unavailable status to domain isolated CPUs, which
> > > > > > is the main contribution of the series.
> > > > > > 
> > > > > > This series is equivalent to v13 but rebased on v6.18-rc2.
> > > > > Thomas,
> > > > > 
> > > > > This patch series have undergone multiple round of reviews. Do you think
> > > > > it
> > > > > is good enough to be merged into tip?
> > > > > 
> > > > > It does contain some cpuset code, but most of the changes are in the timer
> > > > > code. So I think it is better to go through the tip tree. It does have
> > > > > some
> > > > > minor conflicts with the current for-6.19 branch of the cgroup tree, but
> > > > > it
> > > > > can be easily resolved during merge.
> > > > > 
> > > > > What do you think?
> > > > Just wait a little, I realize I made a buggy suggestion to Gabriele and
> > > > a detail needs to be fixed.
> > > > 
> > > > My bad...
> > > OK, I thought you were OK with the timer changes. I guess Gabriele will have
> > > to send out a new version to address your finding.
> > Sure, I'm going to have a look at this next week and send a V14.
> 
> I am going to extract out your 2 cpuset patches and send them to the cgroup
> mailing list separately. So you don't need to include them in your next
> version.

I'm not sure this will help if you apply those to an external tree if the
plan is to apply the whole to the timer tree. Or we'll create a dependency
issue...

> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

