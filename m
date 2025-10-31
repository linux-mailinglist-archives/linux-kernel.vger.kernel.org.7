Return-Path: <linux-kernel+bounces-880208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4496C251CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EC564F4434
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50EA348443;
	Fri, 31 Oct 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXH3YiIh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C9C12DDA1;
	Fri, 31 Oct 2025 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915128; cv=none; b=IfgpkbkEnM9yfTMSCvJ+qEDbxMm9W2MWpkZBSCikBfS5cmsFFv33a03BYvBq1628vd8WNSwcbAzq4v15p61m86js6cG7Zof98eIcVtuMX0pIZkgiyNs0y5apN+QRE7EUUZ4QUidonou83BWUUAhEDepziVMru4DjrsnCUn60x48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915128; c=relaxed/simple;
	bh=GkOQLeyfaij/XYkI3FhobsjBO6mHEPS5prVE1+pfEoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWtnCO2Po7cCU6r5IY+fKI1csQPoR0t3KlwByRjGG7JA0xQhIkNP1p5ahsVPMmHD+9vPFE0v/k2ZNV3JtBHtnUc2NMrivVo4p2MRWJ7AgYcFroLrhMh82X6XZI/BnX/h2pbfqVf10Vdxh7aK6SR6VdyundYGMOuhlqSduTgpQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXH3YiIh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761915127; x=1793451127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GkOQLeyfaij/XYkI3FhobsjBO6mHEPS5prVE1+pfEoU=;
  b=GXH3YiIhT/9ae+/1FJMrtl0mGTWj3mMWJIC2KBPSb9c1TtRllkJ3IpSB
   a5M/6UyqCPaOuRxk+zkhdksOQOTerinBcw7WUVWF7QKF4wrnOjL0jMEF1
   y65plJ6QDrTw2jolTB0utC/QrCGNF/cN6e9j2H+7yY4AX2m48Aw5eGd59
   z7bM5Uqy4o1ghVpFnR6RdLuBtDJG5XIp7MYTU6pIfsynfX6DM0tZ6GPGT
   hk21f62RqtLDX1rRK1OHMOU406XP569/cBtHCQWk+wZuXOemgG+ZPYPw1
   Wp//l6sLghz+MEa7RxOZ6/QharpWS/152WDw48YeGIwom+WYWULyBiafa
   g==;
X-CSE-ConnectionGUID: yQwi5v69TmyULNRTaAE7Gw==
X-CSE-MsgGUID: JC2CAWuzT66iV25NWSrxHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67913081"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67913081"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:52:06 -0700
X-CSE-ConnectionGUID: BV+22n4ISQWlcC43elCuTw==
X-CSE-MsgGUID: HlD5QPeoRMSTDy3WVngyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185915353"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:52:03 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vEobm-00000004GU1-308i;
	Fri, 31 Oct 2025 14:51:58 +0200
Date: Fri, 31 Oct 2025 14:51:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <aQSw7V7tYjBOtJ7k@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
 <20251031094336.6f352b4f@pumpkin>
 <aQSHVsWGXzigTEMe@smile.fi.intel.com>
 <20251031124530.3db7805b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031124530.3db7805b@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:45:30PM +0000, David Laight wrote:
> On Fri, 31 Oct 2025 11:54:30 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Oct 31, 2025 at 09:43:36AM +0000, David Laight wrote:
> > > On Fri, 31 Oct 2025 08:45:00 +0100
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  

...

> > > >  		tstamp_scale = sensor->sensor_info->tstamp_scale +
> > > > -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > > > +			       ilog2(NSEC_PER_SEC) / ilog2(10);  
> > > 
> > > Is that just a strange way of writing 9 ?  
> > 
> > Why? It's correct way of writing log¹⁰(NSEC_PER_SEC), the problem here is that
> > "i" people do not think about :-)
> 
> Even without the "i" the division could easily give 8.999999.
> So you'd be relying on rounding to get the required integral value.
> 
> > But we have intlog10(), I completely forgot about it.
> 
> And it isn't the function the code is looking for.
> (The result is shifted left 24 and it doesn't have an optimisation
> for constants.)

Do you have an idea how to improve that?

-- 
With Best Regards,
Andy Shevchenko



