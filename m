Return-Path: <linux-kernel+bounces-879595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC441C23898
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C379F1A2664D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D720329378;
	Fri, 31 Oct 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNsc5XaP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182225DAFF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895406; cv=none; b=UkkdykcdhLrFwTmLlBRRvqGLyYfSKfAEb7O58fECeMbWLsI1MWX4/wz+Mm6dacsVB9W9rnWw2QmaUCSWfLkETsb2sfMqDLBFcEY8QlgUJFpRjvItPDgkJ7yn/bgux8nDFd7iZt29es/6oD69IBQNHappJOam5lDL/t5a6nw60Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895406; c=relaxed/simple;
	bh=VxJvgA0Urihg+26cyQudWVgGQSZ0AbgOsRa3y9iqFyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJb22AiK0+yQuODMPD4HuE+slpFvFRaS1fHlonpfUU43f8SPISJgq2gQs+EchGfBQX1Uhmoxby6pRJOqgCz0GYNWi7SGNC8+xAH06toXACe4/TVPSbCI5aFwhNCqKi6/iCNHzLuNHF0r3Im57LBKq71+lFnE5fguH8eBqKjuxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNsc5XaP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761895405; x=1793431405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxJvgA0Urihg+26cyQudWVgGQSZ0AbgOsRa3y9iqFyc=;
  b=ZNsc5XaPPvCtawnuKEi8HU1Ee15AhltG4HVeJQKt/EDaFt0A9SJsBkKO
   kKsQ10aVFxXBKKY2ZIyJ69zPeBU384dvG0N2iljXkRNXjek0I/yC6B0GA
   cpH94a3UsIayapVISOW1q9XmfKPXaeEwG3fis22zClD8cEIcySBiLQezA
   lpwWK3GXCg3Wr0PYI3LIUk4TzxDKnV+DAoAZ1bn3Pf+cmOrvon16FyQKw
   TDGTSgfhqRTDOPAj8oufXRlyPJtSrbQiPzvtDAdv9eYqZuLxGFzNfD0fR
   KfpXDh5EgYDSNz2sx6cffgM8lgzDQEZecKwEsjncmsDJLzMDWSpEauHyy
   g==;
X-CSE-ConnectionGUID: /1GNOMTHR3Cm7xEagbgEsQ==
X-CSE-MsgGUID: gRJVpuvgTeilJyQNmUI7yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64089999"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64089999"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:23:25 -0700
X-CSE-ConnectionGUID: P/y+xvLuSLKs5QNea5CL1g==
X-CSE-MsgGUID: R5JmFG+0STi/Rm+uQpq+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="190513098"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:23:22 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEjTh-00000004C1l-4AZ0;
	Fri, 31 Oct 2025 09:23:18 +0200
Date: Fri, 31 Oct 2025 09:23:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aQRj5T5WOY5rOLiy@smile.fi.intel.com>
References: <20251030132007.3742368-1-andriy.shevchenko@linux.intel.com>
 <20251030132007.3742368-4-andriy.shevchenko@linux.intel.com>
 <20251030200616.741d411b7c44875854e89606@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030200616.741d411b7c44875854e89606@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 08:06:16PM -0700, Andrew Morton wrote:
> On Thu, 30 Oct 2025 12:44:19 +0100 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > -static const struct sys_info_name  si_names[] = {
> > -	{ SYS_INFO_TASKS,		"tasks" },
> > -	{ SYS_INFO_MEM,			"mem" },
> > -	{ SYS_INFO_TIMERS,		"timers" },
> > -	{ SYS_INFO_LOCKS,		"locks" },
> > -	{ SYS_INFO_FTRACE,		"ftrace" },
> > -	{ SYS_INFO_ALL_BT,		"all_bt" },
> > -	{ SYS_INFO_BLOCKED_TASKS,	"blocked_tasks" },
> > +static const char * const si_names[] = {
> > +	[ilog2(SYS_INFO_TASKS)]			= "tasks",
> > +	[ilog2(SYS_INFO_MEM)]			= "mem",
> > +	[ilog2(SYS_INFO_TIMERS)]		= "timers",
> > +	[ilog2(SYS_INFO_LOCKS)]			= "locks",
> > +	[ilog2(SYS_INFO_FTRACE)]		= "ftrace",
> > +	[ilog2(SYS_INFO_PANIC_CONSOLE_REPLAY)]	= "",
> > +	[ilog2(SYS_INFO_ALL_BT)]		= "all_bt",
> > +	[ilog2(SYS_INFO_BLOCKED_TASKS)]		= "blocked_tasks",
> >  };
> 
> We have this const_ilog2() which appears to exist to work around a
> sparse shortcoming.  But only net/ethtool/common.c uses it - plenty of
> other sites do what you've done.
> 
> Which makes me wonder whether const_ilog2() can be removed, switch
> everything over to ilog2().

Good question. I haven't noticed sparse errors, I always use make W=1 C=1 for
my local builds.

-- 
With Best Regards,
Andy Shevchenko



