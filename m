Return-Path: <linux-kernel+bounces-877711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C7C1ED53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF9414E7A35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9D337B9F;
	Thu, 30 Oct 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fm6vtm1I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F8270552
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810275; cv=none; b=c+7KL5TlVh+A3vwmPTzBAblixB8PIVCoKNBnu6M2OVzmPK+ORtFiAHz5lQbRoLwF0pEJRJArmpZSzV1IB7awj6JeLakiVVlk/kHbB7kt+Rw1Oua1BLlFJDryGwjQ3awWNIduyfTOyPhcaOvwsO3rT7RruNKTv3mJ7s+AkZQtOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810275; c=relaxed/simple;
	bh=SICwjK6vCKq3+LVX643xUhGRCzL6raUz0toA1E451io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiyIQ2oVt5rJ46+eGEqeWPzZcu4a/Yr6mrt8ngMp42le3FtRbhGXJmbKkV8KBAAK0sxsbRYBNH+p7AIyTbshNa6ctx/wm0JfAIZ6CFxfMEUeMHTJHydKwg1WMN2uKsM4flgJOKZBRJ8FLX/t9h/OKmjQBmjLq9EKmEmWYulKT3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fm6vtm1I; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761810274; x=1793346274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SICwjK6vCKq3+LVX643xUhGRCzL6raUz0toA1E451io=;
  b=Fm6vtm1Igwdgk70qkuiJnumq3aoE49SmUB1CIOp6C68zk/m+TuqdP2tw
   2CTE67SSW8UbDIexBBv/OWQAawFoprUeDsVxjtJr+sRBVcj0ynUwyXyNK
   a6VgjoWj/D30xyYZU2cVzh0QmcTiXq7o0CzOROFJd2GsLWBzrWsmMGQHo
   YRdnfRfJZbUrG6dL4MnB0NAYyLDvNEanIcU2/ic7WxlALQCIvIc32ropc
   DklRXx1i2luT4p2B9c0gRtkONb5RX0RWfIsbpOfdpIosrutX/57r2oO6U
   3YmxDP/es7ula+BelkSXBrJAo1586RoLNrPRImGSdHRYwpf5XCwq+yLwJ
   g==;
X-CSE-ConnectionGUID: AyWtM5P7QW+awC3chSjtXA==
X-CSE-MsgGUID: CZzwQE0HTYG2pBqM9hsMlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81362046"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81362046"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:44:32 -0700
X-CSE-ConnectionGUID: pg4uiwfFRuyf6+9kuZ2yVQ==
X-CSE-MsgGUID: Y+Cvrg5zR2ywZxKApS6IMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="216736688"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:44:30 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vENKd-00000003pnl-3bev;
	Thu, 30 Oct 2025 09:44:27 +0200
Date: Thu, 30 Oct 2025 09:44:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 6/6] panic: sys_info: Factor out read and write
 handlers
Message-ID: <aQMXW40RKiKJ78Ks@smile.fi.intel.com>
References: <20251029111202.3217870-2-andriy.shevchenko@linux.intel.com>
 <20251029111202.3217870-8-andriy.shevchenko@linux.intel.com>
 <aQLIFovZGopZb-QX@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQLIFovZGopZb-QX@U-2FWC9VHC-2323.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 30, 2025 at 10:06:14AM +0800, Feng Tang wrote:
> On Wed, Oct 29, 2025 at 12:07:41PM +0100, Andy Shevchenko wrote:
> > For the sake of the code readability and easier maintenance
> > factor out read and write sys_info handlers.

...

> As the if and else block each has only round 10 lines of code, and fit a
> screen well, I'm not sure whether adding 2 new functions will improve
> readabilty, but I'm fine with the change.

It increases readability and understanding as, for example, one don't need to
check what "write" is when giving as a parameter, Also if you noticed one of my
patch actually made it short by a few lines. So, better to compare the before
_the series_ and after. And even so, the size is not often the main metric for
the readability. I made this patch as I obviously see the benefit of it.

P.S. Thanks for your review!

-- 
With Best Regards,
Andy Shevchenko



