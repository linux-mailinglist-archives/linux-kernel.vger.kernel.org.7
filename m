Return-Path: <linux-kernel+bounces-725755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1DB0034C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5563B3AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521792264CF;
	Thu, 10 Jul 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duyg+cau"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1C8460
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154010; cv=none; b=bi2wBmChA9n2CGONV6oDB8cbBUCVTYy5lkCDksyX+shMZldH61In+59cqCXjoXNsl1eb+9tIKFgkAzLJEylYwXMnKhU0rqTpvMllai20esS13mY3QInXuxM7bQr0VbG+rMgwe/UVnu27P2PBwYkdZrATFAP2YZdiZOnEsoj0/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154010; c=relaxed/simple;
	bh=eoHEOPqtPot+nMo3X4Md2pa3SToIkCcDZR1VSAo+SAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFymjfX6zPoReFPfijrUYDknXd73Jvmg65dpM0p6KeCfWl6ijljhQkGSiBDepiKruz3nlXzOFKJ0fBD8/WIvu8xzn9olJLL/IYV/FJYl0H+ZkmdWtRdUXncx8KPEtjesGSRhPs0Cf/HsBCp2CKDEITq7lDdB47N09PuIiQ3s92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duyg+cau; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154009; x=1783690009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eoHEOPqtPot+nMo3X4Md2pa3SToIkCcDZR1VSAo+SAM=;
  b=duyg+cau6p441jgAeaBSjoqRh9A6gGyVqmwFa1EErMz3H7Rv+9vZhjcS
   RYMlEa4iDnjgh4ty1M3+sDkzlt4dCPE1RDk1HxaYAm2qcJ2cnbLpBpJhq
   v+Ny3ienUsaTSGIGcCMJ1QnfXqjvjvHrEDOlw8JTukmyLBLE2u0EFL9Pf
   JVGp0RyHB6e4Ohx5QeyZB9lz/OzzV3O4NYDE/uCFxkpEuA1CZJUqxFqqh
   qKpi6WhXBwWkZ0LbX4S7iLe3zOnky3g3bKHs5Cylw/BswS/hhOCpv9ddV
   WNRwV9+L6VzHolEP7VKR3TpcHetsEuYtAcZqoN1ZlMadFLAli2ZP4h2v3
   w==;
X-CSE-ConnectionGUID: si0Mh2g3StSiWc++pgyefg==
X-CSE-MsgGUID: s+gCoWKDQIueZ74igQUFWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="64691263"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="64691263"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:25:03 -0700
X-CSE-ConnectionGUID: ubKzlcS2T1+dIdrrwAerSQ==
X-CSE-MsgGUID: 1nO5fjqYQv6x4OMEhgOIlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155501932"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:25:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uZrGl-0000000ED7d-1cT6;
	Thu, 10 Jul 2025 16:24:59 +0300
Date: Thu, 10 Jul 2025 16:24:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] panic: Fix compilation error (`make W=1`)
Message-ID: <aG-_K-wauw1MPF_g@smile.fi.intel.com>
References: <20250710094816.771656-1-andriy.shevchenko@linux.intel.com>
 <aG-Y2RhcxgrWuq27@U-2FWC9VHC-2323.local>
 <aG--Yu57lpHnroCe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG--Yu57lpHnroCe@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 04:21:39PM +0300, Andy Shevchenko wrote:
> I don't understand why this mail was sent with LKML being dropped...
> 
> On Thu, Jul 10, 2025 at 06:41:29PM +0800, Feng Tang wrote:
> > On Thu, Jul 10, 2025 at 12:48:16PM +0300, Andy Shevchenko wrote:
> > > Compiler is not happy about the recently added code:
> > > 
> > > lib/sys_info.c:52:19: error: variable 'sys_info_avail' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> > >    52 | static const char sys_info_avail[] = "tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks";
> > >       |                   ^~~~~~~~~~~~~~
> > > 
> > > Fix it in the same way how, for example, lib/vsprintf.c does in the similar
> > > cases, i.e. by using string literal directly as sizeof() parameter.
> > > 
> > > Fixes: 9b5072c04c46 ("panic: add 'panic_sys_info' sysctl to take human readable string parameter")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thanks for the fix! The issue has been reported, and the linux-mm tree already carried fix:
> > https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-nonmm-unstable&id=0a080b90dc6fe0a1e7df954a0d8c7e486e83b189
> > 
> > which doesn't hit linux-next tree yet.
> 
> With all the respect to Nathan's fix, I prefer mine for a couple of reasons:
> 1) __maybe_unused is a linker time workaorund;
> 2) we still have unneeded variable dangling;

Should be...

"With my patch:"

> 3) less code to maintain;

1) ...

> 4) vsprintf.c has many similar cases and there the approach is different.

2) ...

> Note, the fix is still in unstable branch, hence can be pulled out.
> 
> Andrew, Nathan, what's your opinion?

-- 
With Best Regards,
Andy Shevchenko



