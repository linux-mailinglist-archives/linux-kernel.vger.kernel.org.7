Return-Path: <linux-kernel+bounces-878410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB718C20856
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BE43A8B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CEF22A4E9;
	Thu, 30 Oct 2025 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8mk32Ef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F317A2FC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833548; cv=none; b=F551YWMr+J+1zIaQQqhmwckEac72BVlzgMGIhmX4LF03Hg/RTRxmI2sLiWNY/cJqXhWTY18AG+Rs9EN+c3O66xl8VBnght+D7BagJF9k3VhzjVoX6zxxCBASzWk7zuakAgWWQBo0THm1XvxlEKMVJw7E202Wb9kC6k31ks/AHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833548; c=relaxed/simple;
	bh=sxKqqPcMaiwdrMzmo+k7zvJe79ruFcNlib8Heu2zD0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDe9KFWpONUPLxnucwJRu4npzLvOxCp+8eqZjqGoo/JuWi9SbuciLW9UnNTerJ9P8p0JfgXCDDIcEql6kiMK71qamQDK3bZZ/QG0MYL+G+iOwrKKInUcfTw+S//L2OxYH8R8hKI0JlKEgce5eYhcq/Wq+8Xlui02U+wxMPzDts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8mk32Ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E15BC4CEF1;
	Thu, 30 Oct 2025 14:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833548;
	bh=sxKqqPcMaiwdrMzmo+k7zvJe79ruFcNlib8Heu2zD0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8mk32EfLMMjtcJOaImvKWZccD8qX6wp+osT+Un6waD7AtVSdpgeJvLfgUIX8WLRt
	 NOgQcL0voKgfJNVxehtCTSdTuNNGncYcFrR0WgIoW4C8k95PX1QsCDwLX+kY4aNNPH
	 67fZ9nsue48N3NGVk3GpSQANH/ff79DPEi+6lNG2ouQ0f2zyacj1Sr4n7wKKBD6If1
	 unBSXtZB1Zw6VXFZuA4wc51dLwQ6rIJaJow7dP0267gOd13o6l150umdGal+s1FGhc
	 xDgMPMgm5/7j8O6iztBnUZjjA/JxFEoijHDoCERZNPrpVDbHKfjca7udaU4ig9HrxX
	 jdZ0Fg2TZ64qg==
Date: Thu, 30 Oct 2025 15:12:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RESEND PATCH v13 0/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aQNySRvImq2yaUef@localhost.localdomain>
References: <20251020112802.102451-1-gmonaco@redhat.com>
 <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c1e6b45-79b8-463a-8c41-565d9ed8f76d@redhat.com>

Hi Waiman,

Le Wed, Oct 29, 2025 at 10:56:06PM -0400, Waiman Long a écrit :
> On 10/20/25 7:27 AM, Gabriele Monaco wrote:
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
> > * the nohz timekeeper core (must be available to handle global timers)
> > 
> > CPUs are added to the hierarchy during late boot, excluding isolated
> > ones, the hierarchy is also adapted when the cpuset isolation changes.
> > 
> > Due to how the timer migration algorithm works, any CPU part of the
> > hierarchy can have their global timers pulled by remote CPUs and have to
> > pull remote timers, only skipping pulling remote timers would break the
> > logic.
> > For this reason, prevent isolated CPUs from pulling remote global
> > timers, but also the other way around: any global timer started on an
> > isolated CPU will run there. This does not break the concept of
> > isolation (global timers don't come from outside the CPU) and, if
> > considered inappropriate, can usually be mitigated with other isolation
> > techniques (e.g. IRQ pinning).
> > 
> > This effect was noticed on a 128 cores machine running oslat on the
> > isolated cores (1-31,33-63,65-95,97-127). The tool monopolises CPUs,
> > and the CPU with lowest count in a timer migration hierarchy (here 1
> > and 65) appears as always active and continuously pulls global timers,
> > from the housekeeping CPUs. This ends up moving driver work (e.g.
> > delayed work) to isolated CPUs and causes latency spikes:
> > 
> > before the change:
> > 
> >   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> >   ...
> >    Maximum:     1203 10 3 4 ... 5 (us)
> > 
> > after the change:
> > 
> >   # oslat -c 1-31,33-63,65-95,97-127 -D 62s
> >   ...
> >    Maximum:      10 4 3 4 3 ... 5 (us)
> > 
> > The same behaviour was observed on a machine with as few as 20 cores /
> > 40 threads with isocpus set to: 1-9,11-39 with rtla-osnoise-top.
> > 
> > The first 5 patches are preparatory work to change the concept of
> > online/offline to available/unavailable, keep track of those in a
> > separate cpumask cleanup the setting/clearing functions and change a
> > function name in cpuset code.
> > 
> > Patch 6 and 7 adapt isolation and cpuset to prevent domain isolated and
> > nohz_full from covering all CPUs not leaving any housekeeping one. This
> > can lead to problems with the changes introduced in this series because
> > no CPU would remain to handle global timers.
> > 
> > Patch 9 extends the unavailable status to domain isolated CPUs, which
> > is the main contribution of the series.
> > 
> > This series is equivalent to v13 but rebased on v6.18-rc2.
> 
> Thomas,
> 
> This patch series have undergone multiple round of reviews. Do you think it
> is good enough to be merged into tip?
> 
> It does contain some cpuset code, but most of the changes are in the timer
> code. So I think it is better to go through the tip tree. It does have some
> minor conflicts with the current for-6.19 branch of the cgroup tree, but it
> can be easily resolved during merge.
> 
> What do you think?

Just wait a little, I realize I made a buggy suggestion to Gabriele and
a detail needs to be fixed.

My bad...

-- 
Frederic Weisbecker
SUSE Labs

