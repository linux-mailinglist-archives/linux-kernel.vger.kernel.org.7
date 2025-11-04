Return-Path: <linux-kernel+bounces-885106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A03CC3201D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD15B3A91D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A332ED5B;
	Tue,  4 Nov 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAGarafe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E842561AA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273116; cv=none; b=jOtX1xTulpBV+dsQdFzszUjYnHTrahcsX++lLBkYAfrB2wZaxOAqC8iHEB3SKfdPUJS1Y/vkh3aQ2ifvygNyi+wz4o6sEz4fY1f3ZXThvQBKw+Bksbca9rByIxE/xI/1PW+COpht9+xVUkv9OMIeAeSW6KzckVVUAZCxeUZxPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273116; c=relaxed/simple;
	bh=weW89vnmyG5oTafIV03g20GvXEz+VFjYFLeNzuHr/eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLTpW/sXlMXPFPwHR7U6YTg1/9WpBg5Dbo3JLAfNQZoGWcZzxhgB47ea1t4Ahw/tdFm2VD/yV2TSFrzWldLS8+PS5dbTGiFhyqmBTtQS91gwff+5arwSvBiadhwR/9p0sq3nX3hbtvPGi+mJW3GuI+H2M2lI3ubDd2FucmYk3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAGarafe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762273115; x=1793809115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=weW89vnmyG5oTafIV03g20GvXEz+VFjYFLeNzuHr/eU=;
  b=hAGarafe1zefm5j2Ttu8cJjkFk9k6DP81QrAxMvhNUvmvtcYgY4BfCt9
   vLHljPFGKlnwkFVvdQZO+pW4wQcXkFMFZlWBL3Yv3rEafCFn9sCoLC6hG
   cNL/AHjjYP6lWLo0/7JhLWCoZ6+bJUiXeqCreChWOO2f75/sSjVG9JxW7
   KcL80+bkx1Ez7b0bLQTyWPi92o3sJZFod8Nobb1WNndSJttBelIr6ZLJ4
   qkD9iMBDJ4VEYfQZ0WXkg07+Z7hbQP+BqIEJ0r2YYo8KMPJkW5WdxoOqR
   k53UyQzWfF01oV/C0lmkGZ4PQh/E/GUpAto8l3kl0/8K0FxHfg2pBZ1fl
   Q==;
X-CSE-ConnectionGUID: 4Aohx5SDQOKWD81oXXtsYw==
X-CSE-MsgGUID: 32v1cvcEQNCD+n1JbDDyMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75722202"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75722202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:18:32 -0800
X-CSE-ConnectionGUID: FPVwuIPSTeiDck1FutEXbg==
X-CSE-MsgGUID: j3pgOscdTMC8jKOCkteCLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186436267"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 08:18:31 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGJjo-00000005Vhx-3Cwa;
	Tue, 04 Nov 2025 18:18:28 +0200
Date: Tue, 4 Nov 2025 18:18:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: regulator branch mess
Message-ID: <aQonVNgqJI56nspA@smile.fi.intel.com>
References: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
 <aQocq1eRjOOjiRdY@finisterre.sirena.org.uk>
 <aQogTFANK1fMtloW@smile.fi.intel.com>
 <aQojdTvP94aYVW4l@finisterre.sirena.org.uk>
 <aQolne8AKHXdJw0-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQolne8AKHXdJw0-@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 06:11:09PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 04:01:57PM +0000, Mark Brown wrote:
> > On Tue, Nov 04, 2025 at 05:48:28PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 04, 2025 at 03:32:59PM +0000, Mark Brown wrote:
> > 
> > > > which doesn't doesn't correspond to "thousands" of lines.  I really
> > > > can't tell what on earth you are talking about here.
> > 
> > > I look at it via GitWeb [1] and that's what I see:
> > 
> > You are not describing a concrete problem here.
> 
> The merge in your regulator tree for-6.19 branch which is
> 
>   commit 9de2057bbdfb58f4d9bb1476135317cd3fe6aa52 (patch)
>   tree 97c34e939fd59891ab122d191ebbe8837a0010d3
> 
>   regulator: pf9453: optimize PMIC PF9453 driver
> 
> contains tons of unrelated (as far as I understood the intention of _this_
> merge) stuff in it.
> 
> OR
> 
> it doesn't describe the _need_ to have all that to be merged for the series
> that is less than two dozens of lines changed.

Because "base" keyword in the series points out to the 

  commit 98bd8b16ae57e8f25c95d496fcde3dfdd8223d41 (tag: next-20251031)
	Author: Stephen Rothwell <sfr@canb.auug.org.au>
	Date:   Fri Oct 31 20:35:57 2025 +1100

  Add linux-next specific files for 20251031

  Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


And that merge did it. If you are going to send this to Linus, I believe it
will become a trouble.

-- 
With Best Regards,
Andy Shevchenko



