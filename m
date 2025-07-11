Return-Path: <linux-kernel+bounces-726947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164AAB01347
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1E61CA0A82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383981CEAA3;
	Fri, 11 Jul 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f32cnsqH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACED1A2632
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213876; cv=none; b=RlJxHwnFzjVff/BZw/uf4wNfZ8m1hotzwDsBqODb2NJSErJF7ZommUbXcQK3HdaOC1vyfajBzLQyBopR4dn321W5AJxy59IqgXvN6Ng5NJUPt205fmacikeI6LJ7KHGiTZyBigmbZVUkidXsZVWw38mx1p8miWTxGx3rT36gI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213876; c=relaxed/simple;
	bh=J3Glk/xNSeEiaL0rKhHSpm7c2uPTqO9KADW0OZgNWFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZX+M/B+VPyWHLperw1hVRzLPgt4gYtSo4ol/rxS1fRXgFZXvYHl+z9OlpLhqr6XuAFUgwQ9tPdJGuePMb7yh+3Z4vdOZxvDorHeWNp1FK9BiHzwTvra866iFV0JnKGbAIUytxKvgLMNNZFAqRHWg20RH5pinqKPXh2SVDT05n10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f32cnsqH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752213875; x=1783749875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3Glk/xNSeEiaL0rKhHSpm7c2uPTqO9KADW0OZgNWFQ=;
  b=f32cnsqH/xWZWII0mfWM+GVGJ4R2jd59x2botjQnrU4Cfp/C9Mj4fofF
   156YdElXAzqFSTB6WfC9dwcJBzbddqv/30oTk8mcYPb1xLhleSBnZpSXX
   my41h9GSNGyyQFIrTevLSMElE9RPdi9S5g3UyCa/RlLaXauTP/2ReWZX5
   s0DxbCoH80DuxEizXpdreFhUPmVtjZy9hKHlf0mez+vcdwfmkkKfBoqkt
   dVAFBuNPvZmlsZPBKPlcuzPOI3+zLNuxsVeqtgnVmQC84DiZqpwJsT6b3
   ZhBDF/pN7SezAkpWuDukjjae7CzjyxwZomqA92eQjGEXxbgG/ml0VO1oB
   g==;
X-CSE-ConnectionGUID: K3bYQHM0Rp6kVkqnhz0GSA==
X-CSE-MsgGUID: bx4mWrReSECWSvGzo3LGtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="53725819"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="53725819"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:04:34 -0700
X-CSE-ConnectionGUID: pJJ2eCVOS/mww1vFOCpruQ==
X-CSE-MsgGUID: iVVUBv9sRN27wyV0LiY7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160620009"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:04:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ua6s1-0000000EQrj-0vZ4;
	Fri, 11 Jul 2025 09:04:29 +0300
Date: Fri, 11 Jul 2025 09:04:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <aHCpbB7cfwfdFBzl@smile.fi.intel.com>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
 <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
 <20250711014947.GA863150@ax162>
 <aHB7fV7QgNp8Fre4@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHB7fV7QgNp8Fre4@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 10:48:29AM +0800, Feng Tang wrote:
> On Thu, Jul 10, 2025 at 06:49:47PM -0700, Nathan Chancellor wrote:
> > On Fri, Jul 11, 2025 at 08:54:25AM +0800, Feng Tang wrote:
> > > On Thu, Jul 10, 2025 at 03:01:33PM -0700, Andrew Morton wrote:
> > > > On Thu, 10 Jul 2025 12:48:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > sys_info_avail[] has another purpose for being a counterpart of si_names[],
> > > which could be extended in future, so we make it obviously stand-alone. As
> > > for definition of si_names[], we explicitly added comment:  
> > > 
> > > 	/*
> > > 	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
> > > 	 * below is updated accordingly.
> > > 	 */
> > > 	static const struct sys_info_name  si_names[] = {
> > > 		{ SYS_INFO_TASKS,		"tasks" },
> > > 		{ SYS_INFO_MEM,			"mem" },
> > > 		
> > > which has also been discussed in another thread:
> > > https://lore.kernel.org/lkml/aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local/
> > > 
> > > And I suggest to keep sys_info_avail[], and either Nathan or Sergey's patch
> > > works for me.
> > 
> > We could do something like this to keep the sizeof() obvious and
> > separate, while still eliminating the variable? Happy to bike shed
> > aspects of it like the macro name and such.

...

> > +#define SYS_INFO_MAX_LEN (sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1)

The ' + 1' is batter to leave for the names below.
Or at bare minimum it needs a semantic explanation.
If it's for NUL, definitely shouldn't be part of the
definition.

> >  int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
> >  					  void *buffer, size_t *lenp,
> >  					  loff_t *ppos)
> >  {
> > -	char names[sizeof(sys_info_avail) + 1];
> > +	char names[SYS_INFO_MAX_LEN];
> >  	struct ctl_table table;
> >  	unsigned long *si_bits_global;
>   
> Looks great to me, thanks!
> 
> We can even move the SYS_INFO_MAX_LEN definition close to si_names[],

Agree.

> initially sys_info_avail[] was next to si_names[], and was moved inside 
> "#ifdef CONFIG_SYSCTL" region for compiling CONFIG_SYSCTL=n case.

But let me think a bit, perhaps we can come up with something even better.

-- 
With Best Regards,
Andy Shevchenko



