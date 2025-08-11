Return-Path: <linux-kernel+bounces-763174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F2AB21133
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4EB18A112D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5772E5B29;
	Mon, 11 Aug 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNdNvv1t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D10A2E5B11;
	Mon, 11 Aug 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928069; cv=none; b=eaj+5CzTf23qB675S6b+cJ0yHTCQpBQomUJj+9lV2nIoQIR1A+l9aC4kgtLmGhrZ+L8f8t/W2Q+Gtu4x6xAw7Qktx8GCKyae220g3wp37OSCVY9yCzyVHPoOB36aqWeHZhkTbfceHGsAViqayRrNUNFSCV32u1jw6pr2byp8tdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928069; c=relaxed/simple;
	bh=RwaWkdKmiTK+8Xy6GbC5Pycw7j37yi1eej0HhVKKtkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKXrjvHiOX88yZsvuKi1W+xoQYCVU7JlEw42QDJEyzdjo7rN0AQQ+Jk7hc12909wIYnFs0yt6m6Vnn6Nf3yc3p0C89P3LeThaa+xghZx8l102ykQONVQiZl+3mti3ZsO2k3PnLyr5drWFugnVI6Vt0bi0Gx3Yf5fA2Hy3X5PF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNdNvv1t; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754928067; x=1786464067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RwaWkdKmiTK+8Xy6GbC5Pycw7j37yi1eej0HhVKKtkM=;
  b=iNdNvv1txhEEdWrQGFkfyfe/wxc47F/QO4krbD3S8zTM1lYLHyLfzxUa
   gSOBfxU24GOWjR2YTm2zdhG74a1ibhLAB9OAAFmnAh6rKv5CU6qDcswhr
   F6mUt/5ML9T4Apwb1nWCTGPsAc9HPCI4xmoefgc+T2mnWujSGfrTqMVQW
   ZkQOXhrfFIIwIeNlUvGUuONpnx44jlGGPkUD1n7b55VUc0J+6/h1PtRZP
   L9FskyCReItu/RUb6UopPptho/wQbiHjbToO9K0QJOJYa5C4V5UYm5vaL
   MRzv36e627l8H67P2MFlnY57GpB9ZLl7aPTbEfLc9kh03s9bWdGberYhd
   w==;
X-CSE-ConnectionGUID: LA5+TpchQXyJjkD8XaZW1g==
X-CSE-MsgGUID: jgvQY8GJR/+t+12hFwWIEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68554746"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68554746"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:01:06 -0700
X-CSE-ConnectionGUID: 1of0qtGzRIu3Qw0llXGC0g==
X-CSE-MsgGUID: xkUFkcYUSkOCx/axOymrQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170396435"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 09:01:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ulUxI-000000054Lr-1vkg;
	Mon, 11 Aug 2025 19:01:00 +0300
Date: Mon, 11 Aug 2025 19:01:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>,
	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
	Peter Korsgaard <peter.korsgaard@barco.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <aJoTvDA6_pxVoV7G@smile.fi.intel.com>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 08:49:21AM -0700, Dmitry Torokhov wrote:
> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> > > On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> > > > On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:

...

> > > > Otherwise LGTM as here it looks like we establish platform device ourselves and
> > > > hence no need some additional magic Hans mentioned in the other series.
> > > 
> > > Not entirely like with the x86-android-tablets patches this
> > > declares a software-node for the gpiochip:
> > > 
> > > static const struct software_node gpiochip_node = {
> > > 	.name = DRIVER_NAME,
> > > };
> > > 
> > > and registers that node, but nowhere does it actually
> > > get assigned to the gpiochip.
> > > 
> > > This is going to need a line like this added to probe():
> > > 
> > > 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> > > 
> > > note the software_node_fwnode() call MUST be made after
> > > registering the software-nodes (group).
> > > 
> > > Other then needing this single line things are indeed
> > > much easier when the code containing the software
> > > properties / nodes is the same code as which is
> > > registering the gpiochip.
> > 
> > Ah, good point!
> 
> This is wrong though, the software node need not be attached to the
> gpiochip (and I wonder if it is even safe to do so). It simply provides
> a name by which gpiochip is looked up in swnode_get_gpio_device().

Do we have all this being documented somewhere? Perhaps start with that?1

-- 
With Best Regards,
Andy Shevchenko



