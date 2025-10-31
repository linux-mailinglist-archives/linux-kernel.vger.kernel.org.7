Return-Path: <linux-kernel+bounces-880284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 762DCC25574
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BE194E53FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1783241679;
	Fri, 31 Oct 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y82o2rn2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C93222581
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918519; cv=none; b=fgZBPpPO/7hAXKU77MlrvHzJKdh1MiQNhn71Vny2vXjGl9tmRzSCztgUVE+6CzwTfHZHb6BjsPj8kjsQMwkwH0OgCMkwHx86y4nnPn7i9TsVIkag8g539mMe5GpvXz8lbzmgFRZyoCbEcRgRi+KwWbBENnuA3k8oXLyxx1THR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918519; c=relaxed/simple;
	bh=3iVSnnvbEo3Kt0j4SIDYbqJ4mliV6LNs9A0vdMTPVzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLd44q+tSVYramnihW62cKQMpsCZaYUeoKUdZo93qq6o/IvFTppitfwLxq/1VZ6FTTV+eRigtKMUW2n281qorGuZIL35D4Fq7YtPGPpGm+yd+FCKJBYh1kfxcgf6t/ILx1UTI95G+6vuftBHN9ZeXfaB57LguoJKSmHFhvSXyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y82o2rn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75544C4CEE7;
	Fri, 31 Oct 2025 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761918518;
	bh=3iVSnnvbEo3Kt0j4SIDYbqJ4mliV6LNs9A0vdMTPVzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y82o2rn2NOTFHvKvpqNfCXEueSYYN0FeGSJsoYLqlVBVGBRJe8hmVQgrZeZx+0+z0
	 DPepw1uBIbdukS8nn47clXh4sl+8/hzBXMnFX8Qd/OfB83/vOZrUMo2H1PUR12ztBy
	 WX0rW0CdYRIfFgpJgV8W6Hxz1yq5YxKqvt23ooMYIf9BUXAQbUyiC047idCucuAN5Y
	 XMRRbIXkVyp3YfcjFCqqXlB7PG96PiA2x1DpmyOSF333CsGm+giXHvmj3/e/WVHpMa
	 WWl14gQAn4muhp1VC0VcW0qfky6GLr8DGt46INiDIWHcocXdh45aio/xTnOqTJWqgJ
	 676d1hWbJ9ROQ==
Date: Fri, 31 Oct 2025 14:48:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aQS-M_6_97ZLk0yH@localhost.localdomain>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
 <aQNySRvImq2yaUef@localhost.localdomain>
 <5457560d-f48a-4a99-8756-51b1017a6aab@redhat.com>
 <3ac28b2bf33086a77333791df39b779d55c31df0.camel@redhat.com>
 <84511fa7-3a28-425c-b0fd-8d971a5f7eb1@redhat.com>
 <aQOcC1GaUlLWsUPv@localhost.localdomain>
 <4421ec3d-e4df-4645-9b68-261080bd4760@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4421ec3d-e4df-4645-9b68-261080bd4760@redhat.com>

Le Thu, Oct 30, 2025 at 01:57:50PM -0400, Waiman Long a écrit :
> On 10/30/25 1:10 PM, Frederic Weisbecker wrote:
> > Le Thu, Oct 30, 2025 at 12:37:08PM -0400, Waiman Long a écrit :
> > > On 10/30/25 12:09 PM, Gabriele Monaco wrote:
> > > > On Thu, 2025-10-30 at 11:37 -0400, Waiman Long wrote:
> > > > > On 10/30/25 10:12 AM, Frederic Weisbecker wrote:
> > > > > > Hi Waiman,
> > > > > > 
> > > > > > Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
> > > > > > > On 10/20/25 7:27 AM, Gabriele Monaco wrote:
> > > > > > > > The timer migration mechanism allows active CPUs to pull timers from
> > > > > > > > idle ones to improve the overall idle time. This is however undesired
> > > > > > > > when CPU intensive workloads run on isolated cores, as the algorithm
> > > > > > > > would move the timers from housekeeping to isolated cores, negatively
> > > > > > > > affecting the isolation.
> > > > > > > > 
> > > > > > > > Exclude isolated cores from the timer migration algorithm, extend the
> > > > > > > > concept of unavailable cores, currently used for offline ones, to
> > > > > > > > isolated ones:
> > > > > > > > * A core is unavailable if isolated or offline;
> > > > > > > > * A core is available if non isolated and online;
> > > > > > > > 
> > > > > > > > A core is considered unavailable as isolated if it belongs to:
> > > > > > > > * the isolcpus (domain) list
> > > > > > > > * an isolated cpuset
> > > > > > > > Except if it is:
> > > > > > > > * in the nohz_full list (already idle for the hierarchy)
> > > > > > > > * the nohz timekeeper core (must be available to handle global timers)
> > > > > > > > 
> > > > > > > > CPUs are added to the hierarchy during late boot, excluding isolated
> > > > > > > > ones, the hierarchy is also adapted when the cpuset isolation changes.
> > > > > > > > 
> > > > > > > > Due to how the timer migration algorithm works, any CPU part of the
> > > > > > > > hierarchy can have their global timers pulled by remote CPUs and have to
> > > > > > > > pull remote timers, only skipping pulling remote timers would break the
> > > > > > > > logic.
> > > > > > > > For this reason, prevent isolated CPUs from pulling remote global
> > > > > > > > timers, but also the other way around: any global timer started on an
> > > > > > > > isolated CPU will run there. This does not break the concept of
> > > > > > > > isolation (global timers don't come from outside the CPU) and, if
> > > > > > > > considered inappropriate, can usually be mitigated with other isolation
> > > > > > > > techniques (e.g. IRQ pinning).
> > > > > > > > 
> > > > > > > > This effect was noticed on a 128 cores machine running oslat on the
> > > > > > > > isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> > > > > > > > and the CPU with lowest count in a timer migration hierarchy (here 1
> > > > > > > > and 65) appears as always active and continuously pulls global timers,
> > > > > > > > from the housekeeping CPUs. This ends up moving driver work (e.g.
> > > > > > > > delayed work) to isolated CPUs and causes latency spikes:
> > > > > > > > 
> > > > > > > > before the change:
> > > > > > > > 
> > > > > > > >     # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > > > > > >     ...
> > > > > > > >      Maximum:     1203 10 3 4 ... 5 (us)
> > > > > > > > 
> > > > > > > > after the change:
> > > > > > > > 
> > > > > > > >     # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> > > > > > > >     ...
> > > > > > > >      Maximum:      10 4 3 4 3 ... 5 (us)
> > > > > > > > 
> > > > > > > > The same behaviour was observed on a machine with as few as 20 cores /
> > > > > > > > 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> > > > > > > > 
> > > > > > > > The first 5 patches are preparatory work to change the concept of
> > > > > > > > online/offline to available/unavailable, keep track of those in a
> > > > > > > > separate cpumask cleanup the setting/clearing functions and change a
> > > > > > > > function name in cpuset code.
> > > > > > > > 
> > > > > > > > Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
> > > > > > > > nohz_full from covering all CPUs not leaving any housekeeping one. This
> > > > > > > > can lead to problems with the changes introduced in this series because
> > > > > > > > no CPU would remain to handle global timers.
> > > > > > > > 
> > > > > > > > Patch 9 extends the unavailable status to domain isolated CPUs, which
> > > > > > > > is the main contribution of the series.
> > > > > > > > 
> > > > > > > > This series is equivalent to v13 but rebased on v6.18-rc2.
> > > > > > > Thomas,
> > > > > > > 
> > > > > > > This patch series have undergone multiple round of reviews. Do you think
> > > > > > > it
> > > > > > > is good enough to be merged into tip?
> > > > > > > 
> > > > > > > It does contain some cpuset code, but most of the changes are in the timer
> > > > > > > code. So I think it is better to go through the tip tree. It does have
> > > > > > > some
> > > > > > > minor conflicts with the current for-6.19 branch of the cgroup tree, but
> > > > > > > it
> > > > > > > can be easily resolved during merge.
> > > > > > > 
> > > > > > > What do you think?
> > > > > > Just wait a little, I realize I made a buggy suggestion to Gabriele and
> > > > > > a detail needs to be fixed.
> > > > > > 
> > > > > > My bad...
> > > > > OK, I thought you were OK with the timer changes. I guess Gabriele will have
> > > > > to send out a new version to address your finding.
> > > > Sure, I'm going to have a look at this next week and send a V14.
> > > I am going to extract out your 2 cpuset patches and send them to the cgroup
> > > mailing list separately. So you don't need to include them in your next
> > > version.
> > I'm not sure this will help if you apply those to an external tree if the
> > plan is to apply the whole to the timer tree. Or we'll create a dependency
> > issue...
> 
> These 2 cpuset patches are actually independent of the timer related
> changes. The purpose of these two patches are to prevent the cpuset code
> from adding isolated CPUs in such a way that all the nohz_full HK CPUs
> become domain-isolated. This is a corner case that normal users won't try to
> do. The patches are just an insurance policy to ensure that users can't do
> that. This is complementary to the sched/isolation patch that limits what
> CPUs can be put to the isolcpus and nohz_full boot parameters. All these
> patches are independent of the timer related changes, though you can say
> that the solution will only be complete if all the pieces are in place.

Right but there will be a conflict if the timer patches don't have
the rename of update_unbound_workqueue_cpumask().

> There are another set of pending cpuset patches from Chen Ridong that does
> some restructuring of the cpuset code that will likely have some conflicts
> with these 2 patches. So I would like to settle the cpuset changes to avoid
> future conflicts.

Ok so it looks like there will be conflicts eventually during the merge
window. In that case it makes sense to take Gabriel cpuset patches but
he'll need to rebase the rest on top of the timer tree.

Thanks.

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

