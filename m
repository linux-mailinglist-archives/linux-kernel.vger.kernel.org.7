Return-Path: <linux-kernel+bounces-706963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43401AEBE58
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 19:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1272F175546
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E92EAB8C;
	Fri, 27 Jun 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GPxM4YA5"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E81DF244
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044690; cv=none; b=mjvlQUtJSUH9Ftk3Qim2CLX5VbNSVbKLnkuBvr7UFWDabw4lcbZmjQnU5nhHOFe1zyXUlbVSx4XUU9/vijQpSu++W2I1VeXvlI5XJBC8mhkASHjWk6Ee7ASp51MXeZkEEV+ctztnZ7FB995NczbxD4x24KjcALOEAmd3hxYeb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044690; c=relaxed/simple;
	bh=NLX9SbHhgJ2ZYzaQ/Iwrr7y+VTFqKbjsoqNKxm7jvRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHnjuh1hKZs5S5mMlW9r50t2s7ecIlZyzh+n2sv+PulelwohHnPZJBuCKT6Js7UP20P9ZE8s/zOx3J/Y0w6UjMRnaUMJ8dflT8fQKaBHgJRmrKyeQ4mUF9ygg+iLnBBAAwZrcJbYiNvWwI2PsU9r0T0dhtwM4dlXo6iWo5AJZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GPxM4YA5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Jun 2025 10:17:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751044676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYWgHymkoVzb35T69i1z7qhWfmrbkaY7mAFuq52RhI0=;
	b=GPxM4YA5OYWBBbWd+VerIZDiDk1YBIgol2ghwEO6nV7CnXwliNQih4FfJy0T/zHOxGHtFs
	IFYtdFztKjhh2Chgwp+opmjYm1RXayXXBVBWVnRgsjxjQn+xPdmrZX2XHrWNLNEAK1Rt7u
	zF7R1bvsJEXIADC5BDpmNXPeAfjnVLs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
Cc: "tj@kernel.org" <tj@kernel.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: Re: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <wbff6zths3lvd7df2lblcyzzabovxkjrbxt7x734mdt7qdr3kh@v3urgrdibben>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 27, 2025 at 01:15:31PM +0000, Wlodarczyk, Bertrand wrote:
> > The kernel faces scalability issues when multiple userspace programs 
> > attempt to read cgroup statistics concurrently.
> > 
> > The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush, 
> > which prevents access and updates to the statistics of the css from 
> > multiple CPUs in parallel.
> > 
> > Given that rstat operates on a per-CPU basis and only aggregates 
> > statistics in the parent cgroup, there is no compelling reason why 
> > these statistics cannot be atomic.
> > By eliminating the lock during CPU statistics access, each CPU can 
> > traverse its rstat hierarchy independently, without blocking.
> > Synchronization is achieved during parent propagation through atomic 
> > operations.
> > 
> > This change significantly enhances performance on commit
> > 8dcb0ed834a3ec03 ("memcg: cgroup: call css_rstat_updated irrespective 
> > of in_nmi()") in scenarios where multiple CPUs accessCPU rstat within 
> > a single cgroup hierarchy, yielding a performance improvement of around 40 times.
> > Notably, performance for memory and I/O rstats remains unchanged, as 
> > the lock remains in place for these usages.
> > 
> > Additionally, this patch addresses a race condition detectable in the 
> > current mainline by KCSAN in __cgroup_account_cputime, which occurs 
> > when attempting to read a single hierarchy from multiple CPUs.
> > 
> > Signed-off-by: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
> 
> > This patch breaks memory controller as explained in the comments on the previous version.
> 
> Ekhm... no? I addressed the issue and v2 has lock back and surrounding the call to dependent submodules? 
> The behavior is the same as before patching.
> 

Oh you have moved the rstat lock just around pos->ss->css_rstat_flush().

Have you checked if __css_process_update_tree() is safe from concurrent
flushers for a given cpu and css?


