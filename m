Return-Path: <linux-kernel+bounces-725332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A78AFFDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7800B5A4B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC9290BBD;
	Thu, 10 Jul 2025 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPuR5zDA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4528FAB7;
	Thu, 10 Jul 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138696; cv=none; b=NlSNxACIB7uEvIjrXXEJgZ+9P90fhn6zlBcoLb8qLwjG7RDGl6s/raSvM7C9bQmE6o5FWJ3D6lJ7UE62C1ROc7hRPZfL//993eKPmpX9EN5ws0uIeO7+c1DZKBR0b6BgWxgpV/n6tTf/H1nGfpigRb0d0e6xImCD/t5ioLtac88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138696; c=relaxed/simple;
	bh=6zT7544EdwmN2PRH/ep6ZfVlA7IWtCalFHFlMXlmwW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wsm++QbMs9jqqKvEPMFB+q36hoMEipn+iQeVD71HC0em+8srBrYuQ5kAZO8BfRwHSkgqIQVaCotifDehLEF/j43R1zGVxlJqEMzeAH6ETyYgwM31+dbdTc0C6X40qjihKeKJmpEIynTDdOMOz0bsS2qbUFN3CUqsJdeQqjr7E1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPuR5zDA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752138695; x=1783674695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6zT7544EdwmN2PRH/ep6ZfVlA7IWtCalFHFlMXlmwW0=;
  b=aPuR5zDASk2XcKkOx3ge+mJJr4jZ33/aFKqRhvZREYoluVp5+ub6VbwE
   hDbOQu3aIn+qpexDB/p6JAUkRP8+7AWF3BvEqSinS8lzl3eiPnw8XySQr
   InBUl1p3f9wPM1klpXfPoaNSHBP8jQdbEruOXf/DMDP6M7wgXqB8fBpUy
   4CDUxaktJWmV3PbnqXGxyYiQPOsqs9hQ/+140ygPAtEAI5r9/jnme2QXa
   4whuLrli1Z9wi8+50Uip+pcuqTo3VxwtOzGI7kxW88EUnfSpcsrAWbthw
   jO/xewUbiA5enTVtFNKRUhd2C731D8m3ZwReBZ/2oVBVvbNR+K4VEMmqJ
   Q==;
X-CSE-ConnectionGUID: b7aJvsw8RVmjCfd5+fk0nA==
X-CSE-MsgGUID: XEcctVkTSpa9ic8weQBC8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="64671266"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="64671266"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:11:34 -0700
X-CSE-ConnectionGUID: asMwvGc9QsWvjZa3prkH/Q==
X-CSE-MsgGUID: lrhl5rFQQBK0FpdEAvfIRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="155786583"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:11:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZnJQ-0000000E9Uf-1Twi;
	Thu, 10 Jul 2025 12:11:28 +0300
Date: Thu, 10 Jul 2025 12:11:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: imu: inv_icm42600: Avoid configuring if already
 pm_runtime suspended
Message-ID: <aG-DwJ-2l76Px2ko@smile.fi.intel.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
 <20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:35:14PM +0200, Sean Nyekjaer wrote:
> Do as in suspend, skip resume configuration steps if the device is already
> pm_runtime suspended. This avoids reconfiguring a device that is already
> in the correct low-power state and ensures that pm_runtimeM handles the
> power state transitions properly.

Can't it be done by one of the hints to the runtime PM? Something like
SMART_SUSPEND ?

-- 
With Best Regards,
Andy Shevchenko



