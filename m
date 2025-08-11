Return-Path: <linux-kernel+bounces-763528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17279B21610
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021FC463B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E82E11DE;
	Mon, 11 Aug 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCtT8+AI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C562D8DC2;
	Mon, 11 Aug 2025 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942347; cv=none; b=EtUL/iAxoa5D+LC46Ssitnro4XVlB4F918IYXgPmQRdkaKgQujIRZOL4mtvbhLfSGMqmZyK7eOj0IfGAJpB54M50GkHQGoa7DRA9XzHriycJG5HNocap5GkDxgQCkRb+WN2IgVXc78z356/NHnpiXKgTxUkF0F4I5J5TopyjVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942347; c=relaxed/simple;
	bh=RRX3et1p8PcZfIK9kH7CLHCoqEwxkpBx28JQPaaNPW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZrRCmRKenGeY9ihzE6/8bRaNXtUVI4IXhqrG58Q63/iVIlm5bb+vGfZED+1pM+y216OqLB87y7l6+bhP7ftP//iEKAJrigkR7lhNZ3SMppCPHElZHgtUUA3k9sTimwzO31stxFhB6ZFlw+s+pmK+VnjhDoAM7rrpMVTNj37RGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCtT8+AI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754942346; x=1786478346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRX3et1p8PcZfIK9kH7CLHCoqEwxkpBx28JQPaaNPW8=;
  b=lCtT8+AI5pBSAgT+stBogcSGt0Ko225QWVpJhwp2PwsGvk8UDGCOpl+a
   ojHJU84xzInhxnZSd+gXuXMyKK6nR+z7WYzqK8DjnNw4ofYeMEX8D0Mlo
   yNVOPwfT0FS3AOwbzPBVeQe8FH+3PN27Nfr92ukuwIT2il5nxK+j8iXXc
   nY/78JzDZm9RodQyT8PK6LFSzIoJJxQcN3AeYmfzTLwtS4KrnK6ENHSMW
   puflRkrJPJlH/D/RUp180d4u/Y94p55P7hW/AXDeNsHAGkmXJYa/WtkSf
   Gl3MkQuLHi/F429tuwk4F9WitMIV39F5hFcKLHsZyO0TJ6WFnZsNvVVxJ
   A==;
X-CSE-ConnectionGUID: RYW+Sxb1Rm2iNcNjm+H6Ug==
X-CSE-MsgGUID: +eo+x2GART6gmYX5yhP0cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59817310"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="59817310"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 12:59:05 -0700
X-CSE-ConnectionGUID: SS1pUM3kR0CJSF6cqXZGQA==
X-CSE-MsgGUID: lygVx3ulQYK2WAbN1u1srg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170221882"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 12:59:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ulYfc-000000056OD-07XA;
	Mon, 11 Aug 2025 22:59:00 +0300
Date: Mon, 11 Aug 2025 22:58:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
	Peter Korsgaard <peter.korsgaard@barco.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <aJpLg9aEicI9UorC@smile.fi.intel.com>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
 <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 07:40:27PM +0200, Hans de Goede wrote:
> On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
> > On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
> >> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> >>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> >>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:

...

> >>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
> >>>> hence no need some additional magic Hans mentioned in the other series.
> >>>
> >>> Not entirely like with the x86-android-tablets patches this
> >>> declares a software-node for the gpiochip:
> >>>
> >>> static const struct software_node gpiochip_node = {
> >>> 	.name = DRIVER_NAME,
> >>> };
> >>>
> >>> and registers that node, but nowhere does it actually
> >>> get assigned to the gpiochip.
> >>>
> >>> This is going to need a line like this added to probe():
> >>>
> >>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> >>>
> >>> note the software_node_fwnode() call MUST be made after
> >>> registering the software-nodes (group).
> >>>
> >>> Other then needing this single line things are indeed
> >>> much easier when the code containing the software
> >>> properties / nodes is the same code as which is
> >>> registering the gpiochip.
> >>
> >> Ah, good point!
> > 
> > This is wrong though, the software node need not be attached to the
> > gpiochip (and I wonder if it is even safe to do so). It simply provides
> > a name by which gpiochip is looked up in swnode_get_gpio_device().
> 
> Ah interesting. This is very different from how fwnodes generally
> work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
> like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
> the reference to the fwnode of the type of device to which the
> reference points.
> 
> IOW the standard way how this works for most other subsystems
> is that gpiolib-swnode.c: swnode_get_gpio_device() would call
> gpio_device_find() with a compare function which uses
> device_match_fwnode().
> 
> I see that instead it uses the swnode name and passes that to
> gpio_device_find_by_label().
> 
> I must say that AFAIK this is not how swnodes are supposed to
> be used the swnode name field is supposed to only be there
> for debugging use and may normally be left empty all together.
> 
> I guess using the swnode-name + gpio_device_find_by_label()
> works but it goes against the design of how fw-nodes
> and especially fwnode-references are supposed to be used...
> 
> Having a fwnode reference pointing to what is in essence
> a dangling (not attached to any device) fwnode is weird.
> 
> Are there already any users of PROPERTY_ENTRY_GPIO() in
> the kernel? If not then I think that we should fix things
> up to actually do a reference match and not a name based
> lookup.

IIRC we have several users already.

> Andy IIRC you've done quite a bit of work on software-nodes,
> what is your take on this ?

I remember seeing this series that added functionality and even tried reviewing
it, but I must admit I haven't noticed this detail. I tend to agree with you
that it's better to keep handling of fwnodes uniform.

> Note this is likely my last email in this thread for
> a while since I will be traveling without email access.

-- 
With Best Regards,
Andy Shevchenko



