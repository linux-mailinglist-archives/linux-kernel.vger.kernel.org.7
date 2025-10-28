Return-Path: <linux-kernel+bounces-873672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4906EC1467D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD32D3BF1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA4309EF8;
	Tue, 28 Oct 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5CxsVIS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008B3090EB;
	Tue, 28 Oct 2025 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651509; cv=none; b=pKvMHVQxXoRN66naKh24gHBn2jC8IOxx/EufHgM+hj41BbHbXv0Kn6FPEQhiD4rvf5uL3Qh8VuyKOPg8oEQxYnOvm64tbhIZos8HmRTw3UyXCz7eNJ8UdMx3RoI9zLXazo2wstQ5XWvK99eShNG6kaYjMhN23dtmRk4NYYQzwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651509; c=relaxed/simple;
	bh=FwB9A75PmLAOWK/7YIAWdYMEzEjWns/tP9qoENwzzoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsFn1vkV6ujx7EOutWv+A+799Xp2rL+V7r5/H9gWv9o55kffhDKf9YAJPmKolbfdhW2kzIsKJRQTxF++GlRmPYoy+/WkGFAQazIv10IXmiZpAJJi0cmJyfZO/ql6+vvfkWiNrHgdMAUqFcHV6q998W5fF9DGaFqMdORV9fe7Nlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5CxsVIS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761651508; x=1793187508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwB9A75PmLAOWK/7YIAWdYMEzEjWns/tP9qoENwzzoE=;
  b=T5CxsVISJPEKVMD9r31dFxgupXuh1zs16vgLKCP5p6V4AJn01opSKEd9
   uQzgI6KO0VU7Xbx7W8Targl4WC5HdTJgrPt2soSG1emwfonw1fU1GCqeS
   0SFrXidlf0gQAxf9o3MaXaEAUlYDmqcUSaUd3hwYXVUO3Nn8Z1vynio10
   3ZFMMz6GolEnaY4AGQi7KN7HJY9BstTS31YZ+YFXldV8LyQ2bQYiy6j/Z
   U6OnaH5wQCFVbN6pUtlg1B73K4fA0SDwJZ/pXZyTilqJcezZoklzg3Wz7
   D1uD5n6erluWj54Blzbsi3ionMx4GO2JNO8e/kL1jszYiP2F68zt5XTUu
   g==;
X-CSE-ConnectionGUID: Q/z9jhHcQWqrP5o5sdcfMQ==
X-CSE-MsgGUID: TzS/jO20Roi0gMFd3d7Zzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62778229"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="62778229"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:38:27 -0700
X-CSE-ConnectionGUID: yjLCpoGdQ4iDHfNRf8GcmQ==
X-CSE-MsgGUID: n/a69aj8T32GgPaLOvztnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185413117"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:38:24 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDi1t-00000003Iap-3yHh;
	Tue, 28 Oct 2025 13:38:21 +0200
Date: Tue, 28 Oct 2025 13:38:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Scally <dan.scally@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Qiu Wenbo <qiuwenbo@gnome.org>,
	Daniel Scally <djrscally@gmail.com>,
	Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
Message-ID: <aQCrLVBBOBVCnoJ8@smile.fi.intel.com>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
 <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
 <7898408e-1b33-4f22-84d2-12bcd6254402@kernel.org>
 <aQCg-xZ_kAemfgZQ@smile.fi.intel.com>
 <d1cef8a6-1c67-4932-85e7-07c0e00477bb@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cef8a6-1c67-4932-85e7-07c0e00477bb@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 11:09:12AM +0000, Dan Scally wrote:
> On 28/10/2025 10:54, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 11:38:00AM +0100, Hans de Goede wrote:
> > > On 28-Oct-25 11:02 AM, Andy Shevchenko wrote:
> > > > On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
> > > > > On 24/10/2025 06:05, Qiu Wenbo wrote:

...

> > > > > However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
> > > > > call to gpiod_put() when the module is unloaded; doesn't that mean that the
> > > > > same issue  will occur before that commit?
> > > > 
> > > > Actually a good question! To me sounds like it's a bug(?) in regulator code.
> > > > It must not release resources it didn't acquire. This sounds like a clear
> > > > layering violation.
> > > 
> > > I think the problem is that when it comes from devicetree it is acquired
> > > by the regulator core.
> > 
> > Hmm... I probably missed that, but I failed to see this. Any pointers?
> 
> They can come through the struct regulator_desc.of_parse_cb(), which is called in
> regulator_of_init_data(), from regulator_register(). For example: https://elixir.bootlin.com/linux/v6.17.5/source/drivers/power/supply/mt6370-charger.c#L234>

Ah, thank you, Dan, for the pointers. Indeed, that's how it's done. Hmm, still
why can't we let the regulator consumer to decide when to clean the resource?
I think this is an attempt to have a refcounting against shared GPIO resource
and it should be done in the GPIOLIB (if not yet). In regulator that put
call should probably be conditional (based on the source of GPIO request).

> > > Only when passed as platform-data as we do here does
> > > this layering violation occur.
> > > 
> > > I do believe that a transfer of ownership ad done here is ok for
> > > the platform-data special case.

As an exception, maybe...

-- 
With Best Regards,
Andy Shevchenko



