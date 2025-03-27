Return-Path: <linux-kernel+bounces-578898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA87FA73A44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 18:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B51D170F36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AAA1AE01C;
	Thu, 27 Mar 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DbjYPUBz"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B079D2114
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095841; cv=none; b=Htm72xn63jBu7nIn6me4hWlosP0VGi+BkznjGnvaLR42SezGzxuCSfT1PF4Glz3w5dYDbh8PFOYjTg5e+N+k344eEB2Nlv4SPLttoDid4IVxeCPFgure16WNQfR1HzO4iRWBpbo6XRnHbF9On72dT4nh2ktlnTsaUBTo+8VPl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095841; c=relaxed/simple;
	bh=F3Us6le0sIiVn4g7WXS2x7d7NBrZXcRAh8W39F5pEJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXm+C4gZRZyfAYbdthmvZbbMYoT4uXpldYvEBJZ+6gdZrGkiGWLhwj6sY6StaHJiebUsoUL2sVvbCl3wxjcuYsjmTURF9TUGKLY79prbibovEvCRYAMCDp/MNYBvSounpG7gj5fuGfIuIHAJ6ALPpLHPk1n+MbMucppdM7ubPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DbjYPUBz; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Mar 2025 17:17:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743095826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7bRxmqvl0+EuoCZKk7jNhwWn1DNhdJGHNDr013jHgxA=;
	b=DbjYPUBz42FxzuG4ZqZCVqWnpgGhfPXHNMZS+EKOSShqqcziRC01QRCKJqMEAUA86jYT7c
	VQYhH2WpnOaSP0rYN4bB8X4OlJbZZgIZz7iUp5CKNAsiIq3wYc1yNJQCrzFCdLEt+QdLgx
	eVHrqdlkrvzfCWhV0YqlS2BGROUvuDM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z-WIDWP1o4g-N5mg@google.com>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
 <Z9r8TX0WiPWVffI0@google.com>
 <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vznaaotzkgkrfoi2qitiwdjinpl7ozhpz7w6n7577kaa2hpki@okh2mkqqhbkq>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 27, 2025 at 03:38:50PM +0100, Mateusz Guzik wrote:
> On Wed, Mar 19, 2025 at 05:18:05PM +0000, Yosry Ahmed wrote:
> > On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
> > > Is not this going a little too far?
> > > 
> > > the lock + irq trip is quite expensive in its own right and now is
> > > going to be paid for each cpu, as in the total time spent executing
> > > cgroup_rstat_flush_locked is going to go up.
> > > 
> > > Would your problem go away toggling this every -- say -- 8 cpus?
> > 
> > I was concerned about this too, and about more lock bouncing, but the
> > testing suggests that this actually overall improves the latency of
> > cgroup_rstat_flush_locked() (at least on tested HW).
> > 
> > So I don't think we need to do something like this unless a regression
> > is observed.
> > 
> 
> To my reading it reduces max time spent with irq disabled, which of
> course it does -- after all it toggles it for every CPU.
> 
> Per my other e-mail in the thread the irq + lock trips remain not cheap
> at least on Sapphire Rapids.
> 
> In my testing outlined below I see 11% increase in total execution time
> with the irq + lock trip for every CPU in a 24-way vm.
> 
> So I stand by instead doing this every n CPUs, call it 8 or whatever.
> 
> How to repro:
> 
> I employed a poor-man's profiler like so:
> 
> bpftrace -e 'kprobe:cgroup_rstat_flush_locked { @start[tid] = nsecs; } kretprobe:cgroup_rstat_flush_locked /@start[tid]/ { print(nsecs - @start[tid]); delete(@start[tid]); } interval:s:60 { exit(); }'
> 
> This patch or not, execution time varies wildly even while the box is idle.
> 
> The above runs for a minute, collecting 23 samples (you may get
> "lucky" and get one extra, in that case remove it for comparison).
> 
> A sysctl was added to toggle the new behavior vs old one. Patch at the
> end.
> 
> "enabled"(1) means new behavior, "disabled"(0) means the old one.
> 
> Sum of nsecs (results piped to: awk '{ sum += $1 } END { print sum }'):
> disabled:	903610
> enabled:	1006833 (+11.4%)

IIUC this calculates the amount of elapsed time between start and
finish, not necessarily the function's own execution time. Is it
possible that the increase in time is due to more interrupts arriving
during the function execution (which is what we want), rather than more
time being spent on disabling/enabling IRQs?

