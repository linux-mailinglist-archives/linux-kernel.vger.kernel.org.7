Return-Path: <linux-kernel+bounces-613045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA0DA95758
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DE316EF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152C1A83FB;
	Mon, 21 Apr 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeFUviDn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B471EF38C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745267315; cv=none; b=K7l5eE4fp01cxMdz+Hu7dYy2dTQODlMuW1bXzGtk6bKuuMcr1gUFb68LAWbvZDWclFQzgRjFp/yBwZFc1FBGUQQLxMKTF2/Hl4X8/Uyd5lTLUP18Fdd+fSDkGmgM4cekuFAHY9365f+erQzzIm2UXuNvXVo2+fb0qc/LupHeKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745267315; c=relaxed/simple;
	bh=w7134AAQPCrqzf6IBUYVMpfbVS3VMXdxg95NM1vHUoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkEsrxas2B2sBPB/8IXbGbvZr+3Aa3AQYAJ2cAAL4k2SofC7LpilpR9EYyEuVsOlfZh3JAqn0mfmNfHOzdmSLMSsveDemxTr6TRAMdTGHkHBQ2YMaIvzT6HELZmXCiTw1ZusANzYdnoAI8mhZc4b/d8EC/aHNgPPJ8VFgYfS1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeFUviDn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745267311; x=1776803311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7134AAQPCrqzf6IBUYVMpfbVS3VMXdxg95NM1vHUoQ=;
  b=KeFUviDnQ9rH2KKpvfFB035MopCeMVz1+0TPj9+7YXgsGbh93HG0juAN
   JSFTtqF8tJCoA0Eod5TDLAMWnhpN1U8QVyLYliN/vPozkyjqQ2XAOhQhO
   QDttMYn2zPBaPOIvpaWyCtypAZJtDw0+xk8GaHj+E9Yrj0IXyrpYprVwv
   /aSvNjiJug116NvC+7f8DuE9qKv6PGwMpY7N8mk1pDR9/Z4mS2SP2P/PO
   QWtfxJvwTd66oJ9zCEMLH4/H61KIu2hua/7+CBkVDRyAuwA0nUFckldRN
   DM+Fd3PIvuVuFoIicbE7hPTEQFzric6s06Sy7Q5SlxKZiDodGG7Z4MTEl
   A==;
X-CSE-ConnectionGUID: YuZzq7tGQZWE6BhBwWPcng==
X-CSE-MsgGUID: khmWkhIrQvOAlSs5m/gN7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="64339541"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="64339541"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 13:28:31 -0700
X-CSE-ConnectionGUID: Vee3AjaRRdiOn2LSyNLJOA==
X-CSE-MsgGUID: c+OURRjJTYijqPckGjZDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="131724376"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 13:28:31 -0700
Date: Mon, 21 Apr 2025 13:28:29 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 10/26] fs/resctrl: Improve handling for events that
 can be read from any CPU
Message-ID: <aAaqbUk3gZbCan13@agluck-desk3>
References: <20250407234032.241215-1-tony.luck@intel.com>
 <20250407234032.241215-11-tony.luck@intel.com>
 <da51ba61-4ff0-4db4-a55f-743f6a3ea7da@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da51ba61-4ff0-4db4-a55f-743f6a3ea7da@intel.com>

On Fri, Apr 18, 2025 at 03:54:02PM -0700, Reinette Chatre wrote:
> > @@ -619,7 +622,8 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
> >  			goto out;
> >  		}
> >  		d = container_of(hdr, struct rdt_mon_domain, hdr);
> > -		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
> > +		mask = md->any_cpu ? cpu_online_mask : &d->hdr.cpu_mask;
> > +		mon_event_read(&rr, r, d, rdtgrp, mask, evtid, false);
> 
> I do not think this accomplishes the goal of this patch. Looking at mon_event_read() it calls
> cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU) before any of the smp_*() calls.
> 
> 	cpumask_any_housekeeping()
> 	{
> 		...
> 		if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
> 			cpu = cpumask_any(mask);
> 		...
> 	}
> 
> cpumask_any() is just cpumask_first() so it will pick the first CPU in the
> online mask that may not be the current CPU.
> 
> fwiw ... there are some optimizations planned in this area that I have not yet studied:
> https://lore.kernel.org/lkml/20250407153856.133093-1-yury.norov@gmail.com/

I remember Peter complaining[1] about extra context switches when
cpumask_any_housekeeping() was introduced, but it seems that the
discussion died with no fix applied.

The blocking problem is that ARM may not be able to read a counter
on a tick_nohz CPU because it may need to sleep.

Do we need more options for events:

1) Must be read on a CPU in the right domain	// Legacy
2) Can be read from any CPU			// My addtion
3) Must be read on a "housekeeping" CPU		// James' code in upstream
4) Cannot be read on a tick_nohz CPU		// Could be combined with 1 or 2?

> Reinette

[1] https://lore.kernel.org/all/20241031142553.3963058-2-peternewman@google.com/
> 

