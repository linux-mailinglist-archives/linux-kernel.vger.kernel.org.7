Return-Path: <linux-kernel+bounces-692576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B78ADF397
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 19:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7EC3BF448
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 17:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1A1F12FB;
	Wed, 18 Jun 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ah8H35Mx"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A0186E40
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267045; cv=none; b=XnD2zS2dBJtrCytNzkSQDCNS4L6ogN27SRtUORywMRTC6Nf/XNPDxhmYk5xfs8UlH348KLbtKHkH67xqJ3W3UdVE4PQ6ZMa2YBEJM1+O89OZl6ZShyxdmpA4o3mx973dlCdHF0pzVo/OSvEiH9bdBUR+OQ8b5UwxDR2FfztFr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267045; c=relaxed/simple;
	bh=X1C92uROOo3sK56Kzjyle9jmoOKdo3deN3qrLlEjFQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8FNNLMzBUKdpW9WdVifV1WrgTYy4iUk2VbcQ46muFuElu6jGT1R3lYbIBwLxP0/oApOhGpZsx6VRyKa2ToioFUdnj3S8hH7A65LPnbna4t1gxlZvvqn4zF8bmHJOfA1ALLAnWc6Pw1uLaeDZRyqegFdQ2rhWJ+UQYVaSRoajrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ah8H35Mx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Jun 2025 10:17:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750267035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08M7aDoaYxn4VXVn2UWYGWVYxCC7c2fUSA97sd4G05k=;
	b=Ah8H35Mx+aglBVh5NgE2r4kqC6+emr0vNzSZUD8wm1PrJqvn9YYEbQf+2qrGbZIh7PmoZB
	vVFpEjE4TTSHnBYE0C2Go+HJ13exmW2/d5o+VzegRQK0T75VzkQfvw0pBAFvO1Wl4jENXE
	NjCl7hBVBUaJEvwtO+JP5AG1l8foBpU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, "tj@kernel.org" <tj@kernel.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <z6twrrv53dzqfpytydpdgjg23dvbxyod6zi2fyeebzduyf4pzi@jqyatn34wi2a>
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
 <5f055416-9c49-42c0-9ba0-e45f6aaeac04@gmail.com>
 <CH3PR11MB78947E610456E1EDE1EE8B21F172A@CH3PR11MB7894.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB78947E610456E1EDE1EE8B21F172A@CH3PR11MB7894.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 18, 2025 at 04:05:45PM +0000, Wlodarczyk, Bertrand wrote:
> Thank you for your time and review. 
> 
> > The kernel currently faces scalability issues when multiple userspace 
> > programs attempt to read cgroup statistics concurrently.
> > 
> > The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush, 
> > which prevents access and updates to the statistics of the css from 
> > multiple CPUs in parallel.
> > 
> > Given that rstat operates on a per-CPU basis and only aggregates 
> > statistics in the parent cgroup, there is no compelling reason why 
> > these statistics cannot be atomic.
> 
> > Have you considered the "tearing" that will occur when writes and reads are happening in parallel?
> > The existing state is more of a snapshot approach. Changing the fields involved to atomic and lockless reading/writing can result in inconsistent values, i.e. fieldA might be more current than fieldB.
> 
> Yes, I considered it. In our scenario, "tearing" means that we have the newer data then the last "snapshot" and the output doesn't sum up in
> sum_exec_runtime. The "snapshot" suggests that these stats not need to be super precise because we're accepting outdated state.
> I'm not considering "tearing" issue as very bad here. 
> Additionally, I'm sure that the "tearing" can happen but I didn't observe them during the benchmark runs.
> That suggests that's a rare occurrence or I didn't trigger the right condition to expose the issue.
> 
> When multiple cpus tries to access the rstat the slowdown caused by css_base_lock is so massive that atomic change is preferable.
>  It's better to get even "teared" result than spinlock cpus and disable irq for such long time. 
>  
> 
> > By eliminating the lock, each CPU can traverse its rstat hierarchy 
> > independently, without blocking. Synchronization is achieved during 
> > parent propagation through atomic operations.
> 
> > Even if the tearing scenario mentioned above is acceptable, removing the lock will break synchronization of flushing non-base stat subsystems.
> 
> > -static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss) -{
> > -	if (ss)
> > -		return &ss->rstat_ss_lock;
> 
> > This was needed for non-base stat subsystems like memory and io.
> 
> From what I could find in code the flush with css and cpu arguments is implemented only in two subsystems: memory and io.
> Both memory and io have its own locks for them.
> I tested the benchmark (provided in gist) with memory.stat and io.stat hierarchies.
> In both cases the KCSAN doesn't have any issues, and performance is unchanged in comparison to the commit
> e04c78d86a9699d1 (Linux 6.16-rc2).
> For cpu stats the performance is much better after patch. 
> 
> I can't find a scenario when lack of this locks triggering some kind of issues.
> Maybe you can help me with that?

Please look at *_local and *_pending fields in
mem_cgroup_css_rstat_flush().

