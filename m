Return-Path: <linux-kernel+bounces-726946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA9B01346
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC55881AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807991CEAA3;
	Fri, 11 Jul 2025 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDBbG17E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433B155A4D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213708; cv=none; b=URsq/AdEIEyTNC1vp0V6Y1EIqYSiQE+TZEthN6QdV1XjYYHTdvsm9ZDE/FpIu+vLl2ff1TwA1Bqp/4Fy1A06o4/mMRfx9U01ArUDLAff9y2YVchbZ3muSo13ZBPfzN/JA5wdLpK7W1JSmrEFS6m0xX+nFMR0MsSXaganv1EPSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213708; c=relaxed/simple;
	bh=a0G8Yq0Ke1qOBetrXDyUUddRY5vG1x7jY0BZw7V1Ap4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+d7dPUJtlv3PRvGUrjw8z/y4T/ButAuYiGXY8mjX3b/bA/qkZ0EYrRMWNczoD9jkTy6LBiDmVpmtMnNKLHvYGVvzdFH0/oWulvxeXdVvv98NwE2O5hSoBfHs6uqvVf65o+Jw3dvW34mbc5UZpkcOHTzTqfGii5f+n2gJYh73kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDBbG17E; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752213707; x=1783749707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0G8Yq0Ke1qOBetrXDyUUddRY5vG1x7jY0BZw7V1Ap4=;
  b=oDBbG17EDdBaSVNE/dhIgcBpJVHBDOAxaefAFwCslt1Dg0TYFb1yOYbE
   XXkdoJtb8C+3UdgAx7sCBVG3GZgbKkfHv3Z6s5zFLVYtXBSY5KBDSFYGm
   czn29BhoJ9FoCwGDnQD72gcWMJRYHPHcNAiWi+GdNkjWZwEOMSDTJ29fI
   yNSSAgEM+XHIP7Dwk8u+EDQSJ9ikjhP7grDevDmfPe0mxLtrBx38i7wKP
   lSwJ0v2xk62njZU8uhGw2B0BZRroJsad7/AzQhW3y2dWDGVxWX1LwvZ5O
   31JY6X7rqrijBAgenE5azuuiE948GjMK3upNGm9qnegU8Jaxs5ZoLbhpU
   g==;
X-CSE-ConnectionGUID: kNvaSYKXR7qlMMMekNFDDw==
X-CSE-MsgGUID: n/KmnCCXTZODqJqszBlMxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="72086585"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="72086585"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:01:46 -0700
X-CSE-ConnectionGUID: ecdxnWMvR2GuMUIAt//P7w==
X-CSE-MsgGUID: H0D1KJk6RWyhsBiKg88XzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="187285090"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:01:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ua6pJ-0000000EQpV-0Q1M;
	Fri, 11 Jul 2025 09:01:41 +0300
Date: Fri, 11 Jul 2025 09:01:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <aHCoxOK3WlouqbA_@smile.fi.intel.com>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <20250710150133.680679cf8a0f6b2f0bf3369f@linux-foundation.org>
 <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBgwRrFfmEWcp-T@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 08:54:25AM +0800, Feng Tang wrote:
> On Thu, Jul 10, 2025 at 03:01:33PM -0700, Andrew Morton wrote:
> > On Thu, 10 Jul 2025 12:48:16 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > -	char names[sizeof(sys_info_avail) + 1];
> > > +	char names[sizeof("tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks") + 1];
> > 
> > Yes, that's neater than the fix we currently have.  I'll grab, thanks.
> 
> sys_info_avail[] has another purpose for being a counterpart of si_names[],
> which could be extended in future, so we make it obviously stand-alone. As
> for definition of si_names[], we explicitly added comment:  
> 
> 	/*
> 	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
> 	 * below is updated accordingly.
> 	 */
> 	static const struct sys_info_name  si_names[] = {
> 		{ SYS_INFO_TASKS,		"tasks" },
> 		{ SYS_INFO_MEM,			"mem" },
> 		
> which has also been discussed in another thread:
> https://lore.kernel.org/lkml/aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local/

Ah, this is interesting. Let's rethink about the solution.

> And I suggest to keep sys_info_avail[], and either Nathan or Sergey's patch
> works for me.

I definitely not suggest to leave build broken
(try with CONFOG_WERROR=y, which is default).

> Sorry for the inconvenience, and I should upgrade my gcc :) 

I have compiled with clang-19.

-- 
With Best Regards,
Andy Shevchenko



