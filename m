Return-Path: <linux-kernel+bounces-877843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6441C1F2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6576B4E7DCC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ABE33B6D8;
	Thu, 30 Oct 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2WpCXKn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D12EC57F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815166; cv=none; b=P0r9IqQ0NXXywV9somOS7d8g+sU+mwOJMpBWnAu7IHhxne0nFOS8KL8lXrCCOD4FdV2Je+jnnlC2zrqGaw+BNAtFzJYQoyNhVL/cf167UF1UjibKzqG/xW6Qk3matY/E80UqIVPpOV4A03TPI6gdlXTIkHrNJwH5YgNQJKO4pE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815166; c=relaxed/simple;
	bh=HsKC+zcyFLH66rjNva/+tvVdTIbfOcrfHZ5MCi0O5A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTX9mkLmC4GkhuMN8HS6S/inLqvhFK3c4KJ25KKKoBFJQ3DyTWVSx4URqNw2sbTVHlFvknDLjEmzCq6WDQvmc9o2LEAofg2oA5MJv1VMdmFSTsT70xqVjWMr758Tdekf2KzO7NEMadoQL/BN4M8GiY6qNv5FwTv51h6mAtDwacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2WpCXKn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761815164; x=1793351164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HsKC+zcyFLH66rjNva/+tvVdTIbfOcrfHZ5MCi0O5A4=;
  b=M2WpCXKn7sjR2kXVS/3pUbSA2/tX2jBO0FCHDHJsWF0NCGDpMkSnxatK
   IjzW1Ck4+nTjcasDyQFfQUBochL3GaoV/R8t0pOq3Tgp5FPjgzpyX9+2P
   YfjZC12/eeWkr73+1NTPh0kn9ZGThsUZJ9UReKHKvRz+Z+6ACZNjxIphn
   slk5102TvHSPXpb/EQ9lPxN7jD+PgZ8FpL0WV/XAKJnUIS8bPnbnOppLZ
   IoCm31cDMaxxnJtqacA5rvW0TSTQOeielEoULEdRsHZGFDWB3rW7GHwIY
   sRdYCK2MyVhsLLDyeOcYFjpntXJ0x8fBv2tju7eClwqFYZ6TdAJgVW4Ga
   Q==;
X-CSE-ConnectionGUID: TVnz0vmzQ2exeKwsUJTQDA==
X-CSE-MsgGUID: 5eMTF7fZR6+8d7pIx7AotQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74626791"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="74626791"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:06:03 -0700
X-CSE-ConnectionGUID: T32j+I2oS9mr2yJPyEQSFA==
X-CSE-MsgGUID: qicPPsFSR5i+74S7clXZhA==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:06:02 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEObX-00000003qz3-2XBu;
	Thu, 30 Oct 2025 11:05:59 +0200
Date: Thu, 30 Oct 2025 11:05:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 3/6] panic: sys_info: Replace struct sys_info_name
 with plain array of strings
Message-ID: <aQMqdyh9n7h8Wedm@smile.fi.intel.com>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-5-andriy.shevchenko@linux.intel.com>
 <aQLHDaIqkMQTJHTT@U-2FWC9VHC-2323.local>
 <aQMVivr15od8Mpct@smile.fi.intel.com>
 <aQMlpFoLuPhVwijR@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQMlpFoLuPhVwijR@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 04:45:24PM +0800, Feng Tang wrote:
> On Thu, Oct 30, 2025 at 09:36:42AM +0200, Andy Shevchenko wrote:
> > On Thu, Oct 30, 2025 at 10:01:49AM +0800, Feng Tang wrote:
> > > On Wed, Oct 29, 2025 at 12:07:38PM +0100, Andy Shevchenko wrote:
> > > > There is no need to keep a custom structure just for the need of
> > > > a plain array of strings. Replace struct sys_info_name with plain
> > > > array of strings.
> > > > 
> > > > With that done, simplify the code, in particular, naturally use
> > > > for_each_set_bit() when iterating over si_bits_global bitmap.

...

> > > >  		names[0] = '\0';
> > > > -		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
> > > > -			if (si_bits & si_names[i].bit) {
> > > > -				len += scnprintf(names + len, sizeof(names) - len,
> > > > -					"%s%s", delim, si_names[i].name);
> > > > -				delim = ",";
> > > > -			}
> > > > +		for_each_set_bit(i, &si_bits, ARRAY_SIZE(si_names)) {
> > > > +			len += scnprintf(names + len, sizeof(names) - len,
> > > > +					 "%s%s", delim, si_names[i]);
> > > > +			delim = ",";
> > > 
> > > For SYS_INFO_PANIC_CONSOLE_REPLAY bit, it is a NULL string, no need for
> > > an extra ','?
> > 
> > If you look closer to the original code, the behaviour is the same. Feel free
> > to update behaviour separately as I tried to keep the functionality to be not
> > changed with my series (with the exceptions of the fetching issue).
> 
> I gave the comment by code-reading.
> 
> And to double check it, I just run a simple test by adding "panic_print=0xff"
> to cmdline, with the current kernel, by running "sysctl  kernel.panic_sys_info"
> on current kernel, it will get:
> 
> 	'kernel.panic_sys_info = tasks,mem,timers,locks,ftrace,all_bt,blocked_tasks'
> 
> And after applying your first 3 patches, it will show:
> 	
> 	'kernel.panic_sys_info = tasks,mem,timers,locks,ftrace,,all_bt,blocked_task'

Thanks for the test, now I see the issue! Before si_names has no entry for that bit.
I will address this in next version. Sorry for the confusion.

-- 
With Best Regards,
Andy Shevchenko



