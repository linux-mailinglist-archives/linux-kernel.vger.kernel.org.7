Return-Path: <linux-kernel+bounces-727967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C96B021E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA781894DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78412EF289;
	Fri, 11 Jul 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwcmNbe1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C91A4F12
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251786; cv=none; b=iouL2uB+1pguTzw11nK1HagBIbGAtRhD8OEJ4rKQ47jK2W75LaV4Y9Eihp/HHkAW0CmHhOXerhz5Pplrpj+a6c83F1N4NADvqXidwE5uLE+8wMZFxrG3msgpAPsh8LAa1Vv3o6vH5Eq0pOCbOZDeCXDChnfR+/oFE4eeaPknepk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251786; c=relaxed/simple;
	bh=R24/dWus6pIyEPBhNDOQpAg/IhrN7y0hDwOBS3yngz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhvEnYOTT7+sKobncT8LI8xKrlH6Vk6U49mOcgFwDYOzTTCFnirbqkzrpY+njkoRzHw0EQdwep+0aAU9qzzHblXEYhS3rvpv43lcpxt5O5fvBr20DvDDbGdYJAHkrEoMeJ5pfdM6H2HR9hZWRF9RNiFDj6eln3kHlPvhkipUBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwcmNbe1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752251785; x=1783787785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R24/dWus6pIyEPBhNDOQpAg/IhrN7y0hDwOBS3yngz4=;
  b=VwcmNbe1a4xk7FY4Xd55esfhx7HcKJT4q73WoeDbv2xgm1TP6QSvFW6p
   RBwk4GTkBVyn1SaGrnauX0N5iP1SSibLe9sxRQ5hbMYnDZupnvjSrdMRW
   wEZaal0tmawIDz8H2zG1PU1hx5RQ040E6UlJLfk2ACHYqa4RFtMdxmOEW
   9XGcGsW4duKqlDnJ5wxLIM7Sf4QfSo/+ruBX7gdeLgob5WrszGhyUh4Q8
   UIWAVp3EELmHZ4K1wGb335TMRTwHFvdoNLJofW8+7o2C4tu90czX/yWbV
   eQGKJn37D+L3eTLyjPRbX05CXZmx4Wt8keaCCOaHzXH6GjkCHtszAfCP+
   g==;
X-CSE-ConnectionGUID: FAWGZ6t6T2SCf/ly4qaHFA==
X-CSE-MsgGUID: RhHO6lc4QO245MQGddhExw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42184858"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="42184858"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:36:22 -0700
X-CSE-ConnectionGUID: lVPlj/O3SHOQQynPfaBMoQ==
X-CSE-MsgGUID: 4UgIR1GiSoqIZ/a7at0kRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="160960690"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:36:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uaGjR-0000000EaFf-2ano;
	Fri, 11 Jul 2025 19:36:17 +0300
Date: Fri, 11 Jul 2025 19:36:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [rft, PATCH v1 0/7] panic: sys_info: Refactor and fix a
 compilation issue
Message-ID: <aHE9gQlm7x0YFHHo@smile.fi.intel.com>
References: <20250711095413.1472448-1-andriy.shevchenko@linux.intel.com>
 <aHD_1QopiVCU-vzh@smile.fi.intel.com>
 <aHEw1U8x5WfGaMsC@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHEw1U8x5WfGaMsC@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 11:42:13PM +0800, Feng Tang wrote:
> On Fri, Jul 11, 2025 at 03:13:09PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 12:51:06PM +0300, Andy Shevchenko wrote:
> > > While targeting the compilation issue due to dangling variable,
> > > I have noticed more opportunities for refactoring that helps to
> > > avoid above mentioned compilation issue and make code cleaner in
> > > general. Please, give it a try.
> > > 
> > > I put a revert as the first patch of the previous solution, but I believe
> > > the previous solution may be pulled out without a problem.
> > 
> > Btw, I can try to pop the fix upper in the series, but since this
> > whole feature was only a few days old, I propose to drop it completely
> > for now and start again. Please, Cc me for the review.
> 
> Can we just take your fix and nice cleanups? Do we really need to drop
> the whole series? My gcc haven't raised warnings in the past several
> versions, and I will install clang for more complete compiling test
> beside functional test for future patches.

> Anyway I don't think it has fundamental blocking issue, but I'm fine
> if you insist to do so.

Let's hear Andrew who took the series in the first place. As he says
I will follow. But personally I prefer to drop the whole set and start
from the scratch.

-- 
With Best Regards,
Andy Shevchenko



