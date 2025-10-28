Return-Path: <linux-kernel+bounces-873982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BDDC1540B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D41F46224F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DDC23EA96;
	Tue, 28 Oct 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9PRNEbM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E81531C8;
	Tue, 28 Oct 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662854; cv=none; b=Jz/KfqFsQ+gvBN0+h2yNZ7gb0dHf5goxecaT6vo7Q1luX8ZXY8HYihV5SdxWjkfpSSzvRNxxMFK6ktxU0AHaCE/DokQiqQ+TutLJrPlTDq+0uiwO+yBzdpYsiWpVG+keoDlW0YlI2FDHDfWRVPSm2e1RGTmP9kRME3EV5SJUQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662854; c=relaxed/simple;
	bh=7vSNE6yMFa+2O2ShnNz7OwPIIPY5v8dFcqNEAH2xgTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHQe83ufGA8W24Kd+G1lG2WdWRJ+N3nV2upn79Tu6tUfVvAVBfptA7zf3+f5c3pw+oeQzq0MA7MM+pZuuu0/TWHjNPrVop3MjRgMkmWeYlxh2TMfdoY1DsFOPMXi9KkfryaGE+KSRb5tfSAX2XZm6Z3fvpZND8WNZ+td5uI7Cdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9PRNEbM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761662853; x=1793198853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7vSNE6yMFa+2O2ShnNz7OwPIIPY5v8dFcqNEAH2xgTQ=;
  b=C9PRNEbMJC/D7LJ85KhfvvQ2b0aZjx1MU71LUPK5Cdv6zzmWdFbH0bO8
   R9iaYwRJWNYvuQQh9rrdIE3Ca4QtbrLOr4WqY5AkwEZa29KB3/a2sS076
   pyOmVr9+TNwElR7ZLqp/1dSzNBo9LCmSFKlqWaRgh7SjMSSI5ayyHaI22
   DGHW0uEhZTZwDjIRxtYnKrPUusJrGW9YhtfXD8m/1NpslGijlwUhanh18
   iV2cE+eQ4g/NlGghHPibnwg5Sdd3s8dXHhGy67jStMyEM1kqnFeYk1Cbq
   YLNJ64TjRA+berwMjA+vrxwfhO0qQPgKJP6VhKdtdqlsnKfVsutj5uxUc
   Q==;
X-CSE-ConnectionGUID: QJyxnVHfR3aQEH+VLG4D6w==
X-CSE-MsgGUID: zkzAOGQgQVu5wpRtfyXoNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75211874"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75211874"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:47:32 -0700
X-CSE-ConnectionGUID: AL5NgIAYTZybH6SBe6p0Kw==
X-CSE-MsgGUID: QB67Gw9tSqusFegLaxBhDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185823265"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:47:29 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDkys-00000003LFf-36zn;
	Tue, 28 Oct 2025 16:47:26 +0200
Date: Tue, 28 Oct 2025 16:47:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Dan Scally <dan.scally@ideasonboard.com>,
	Qiu Wenbo <qiuwenbo@gnome.org>, Daniel Scally <djrscally@gmail.com>,
	Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
Message-ID: <aQDXfk1BZIxD4H8S@smile.fi.intel.com>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
 <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
 <7898408e-1b33-4f22-84d2-12bcd6254402@kernel.org>
 <aQCg-xZ_kAemfgZQ@smile.fi.intel.com>
 <d1cef8a6-1c67-4932-85e7-07c0e00477bb@ideasonboard.com>
 <aQCrLVBBOBVCnoJ8@smile.fi.intel.com>
 <492c05bf-bf0f-4cca-af3b-121fdffd05e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492c05bf-bf0f-4cca-af3b-121fdffd05e8@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 03:36:56PM +0100, Hans de Goede wrote:
> On 28-Oct-25 12:38 PM, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 11:09:12AM +0000, Dan Scally wrote:
> >> On 28/10/2025 10:54, Andy Shevchenko wrote:
> >>> On Tue, Oct 28, 2025 at 11:38:00AM +0100, Hans de Goede wrote:
> >>>> On 28-Oct-25 11:02 AM, Andy Shevchenko wrote:
> >>>>> On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
> >>>>>> On 24/10/2025 06:05, Qiu Wenbo wrote:

...

> >>>>>> However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
> >>>>>> call to gpiod_put() when the module is unloaded; doesn't that mean that the
> >>>>>> same issue  will occur before that commit?
> >>>>>
> >>>>> Actually a good question! To me sounds like it's a bug(?) in regulator code.
> >>>>> It must not release resources it didn't acquire. This sounds like a clear
> >>>>> layering violation.
> >>>>
> >>>> I think the problem is that when it comes from devicetree it is acquired
> >>>> by the regulator core.
> >>>
> >>> Hmm... I probably missed that, but I failed to see this. Any pointers?
> >>
> >> They can come through the struct regulator_desc.of_parse_cb(), which is called in
> >> regulator_of_init_data(), from regulator_register(). For example: https://elixir.bootlin.com/linux/v6.17.5/source/drivers/power/supply/mt6370-charger.c#L234>
> > 
> > Ah, thank you, Dan, for the pointers. Indeed, that's how it's done. Hmm, still
> > why can't we let the regulator consumer to decide when to clean the resource?
> > I think this is an attempt to have a refcounting against shared GPIO resource
> > and it should be done in the GPIOLIB (if not yet). In regulator that put
> > call should probably be conditional (based on the source of GPIO request).
> 
> Fixing this sounds like a somewhat big undertaking. In the mean time
> I think we should move forward with this patch to fix the immediate
> issue with the double free.

And I am not objecting to apply this as you may see in the tags given so far.
In regard to the undertaking it seems in Bart's (GPIOLIB maintainer) TODO list.

-- 
With Best Regards,
Andy Shevchenko



