Return-Path: <linux-kernel+bounces-805836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC5B48E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745B844071E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4283054D0;
	Mon,  8 Sep 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UP4LvblI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02319E83C;
	Mon,  8 Sep 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335726; cv=none; b=eN1y6xvu+K38dHJsGC7TFmwaWCDVZB5er9Y2ZZfk5S+3kyRWLyVzjGs8Xo8gvTPc4oLHxwgYp4pGVOxYMQX+7/8FIZYwhel+dzgSGqg8En8sCeqZpPiNdMBtxCUSKA6oqSbdL9ppKPE2+sP8g8TxcMm9VukY7cYV5WPF9IKsoDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335726; c=relaxed/simple;
	bh=l9OVqk8HYCSdxP7Ig8AbEPR9sLrHUEKh7OgJJGlVtqk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T3cHmQcfZt3aTvxkPhJawg3XHaSQfKOYbMR+IbgYv5pRw9Dc901mXhpdu2yDvqT8NmaslAI0L9ulAnc8TQkaiS80AXXhgwKSQ7/Nn6A0ia45T3Rmy+st8W+zvXtVO9l5q1U72/nwGh/K2+NcsWnQa1oX2OheOBz6z/+C/rmavl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UP4LvblI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757335725; x=1788871725;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=l9OVqk8HYCSdxP7Ig8AbEPR9sLrHUEKh7OgJJGlVtqk=;
  b=UP4LvblI0PTRtfyQMXtbrpTXu85TbkXbbazuUukL3OznecR4LAEJdyhG
   pwsAWWNo82SjQh55+QRB/txuLfl3iIWsrVznb9ozQ3Dat8jWIkWzK0UOe
   RWCDT+Qtln20J2RgokoL7FdE1JOrwDK14cio/dFuQuYR5LPtSBnvCZB5C
   lkevtmmGilynyyjVszAwtNMr5PoQDYakO0S3Dciv2cMLdGbpeIFoEeCbZ
   iN9VZlBA6bTMaZc8keRpFGHHYnOl7M6yeGeInKCGhp7oaqolSih7Vrp9V
   0PiYs9crTR2JXRbB6ckYM6CzV7LNwOmY5JLU5I+WYH0bJFDCHtVj4DASp
   A==;
X-CSE-ConnectionGUID: yIMIqgIWTJO3amTlBpPAsA==
X-CSE-MsgGUID: W0xUiwAfSwaGSSxR/0d+yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="58802949"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="58802949"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 05:48:44 -0700
X-CSE-ConnectionGUID: U8UIiLaNRLegZav0CF2MSA==
X-CSE-MsgGUID: cvmWh0axR8+1qhbZWE7gaw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 05:48:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Sep 2025 15:48:37 +0300 (EEST)
To: Hans de Goede <hansg@kernel.org>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Santosh Kumar Yadav <santoshkumar.yadav@barco.com>, 
    Peter Korsgaard <peter.korsgaard@barco.com>, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
    Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
In-Reply-To: <ae657b82-acd3-4a1f-ba21-3ce394531819@kernel.org>
Message-ID: <ceb10a43-424f-45e8-68b5-d506573a63e3@linux.intel.com>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr> <aJnlnx2qF6P61jJN@smile.fi.intel.com> <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org> <aJoQE2CQv3nzaSqc@smile.fi.intel.com> <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
 <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org> <4151a14f-8427-41a9-84cf-e901080d0eb1@kernel.org> <7bylxufp3r5qzf5axqrtytamkveaw5dpsidmdyiany4wkexbpd@s4yremtvct4a> <ae657b82-acd3-4a1f-ba21-3ce394531819@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Aug 2025, Hans de Goede wrote:

> Hi,
> 
> On 11-Aug-25 7:59 PM, Dmitry Torokhov wrote:
> > On Mon, Aug 11, 2025 at 07:44:01PM +0200, Hans de Goede wrote:
> >> On 11-Aug-25 7:40 PM, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
> >>>> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
> >>>>> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
> >>>>>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
> >>>>>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
> >>>>>
> >>>>> ...
> >>>>>
> >>>>>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
> >>>>>>> hence no need some additional magic Hans mentioned in the other series.
> >>>>>>
> >>>>>> Not entirely like with the x86-android-tablets patches this
> >>>>>> declares a software-node for the gpiochip:
> >>>>>>
> >>>>>> static const struct software_node gpiochip_node = {
> >>>>>> 	.name = DRIVER_NAME,
> >>>>>> };
> >>>>>>
> >>>>>> and registers that node, but nowhere does it actually
> >>>>>> get assigned to the gpiochip.
> >>>>>>
> >>>>>> This is going to need a line like this added to probe():
> >>>>>>
> >>>>>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
> >>>>>>
> >>>>>> note the software_node_fwnode() call MUST be made after
> >>>>>> registering the software-nodes (group).
> >>>>>>
> >>>>>> Other then needing this single line things are indeed
> >>>>>> much easier when the code containing the software
> >>>>>> properties / nodes is the same code as which is
> >>>>>> registering the gpiochip.
> >>>>>
> >>>>> Ah, good point!
> >>>>
> >>>> This is wrong though, the software node need not be attached to the
> >>>> gpiochip (and I wonder if it is even safe to do so). It simply provides
> >>>> a name by which gpiochip is looked up in swnode_get_gpio_device().
> >>>
> >>> Ah interesting. This is very different from how fwnodes generally
> >>> work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
> >>> like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
> >>> the reference to the fwnode of the type of device to which the
> >>> reference points.
> >>>
> >>> IOW the standard way how this works for most other subsystems
> >>> is that gpiolib-swnode.c: swnode_get_gpio_device() would call
> >>> gpio_device_find() with a compare function which uses
> >>> device_match_fwnode().
> >>>
> >>> I see that instead it uses the swnode name and passes that to
> >>> gpio_device_find_by_label().
> >>>
> >>> I must say that AFAIK this is not how swnodes are supposed to
> >>> be used the swnode name field is supposed to only be there
> >>> for debugging use and may normally be left empty all together.
> > 
> > Hmm, given that I wrote both the references support for software nodes
> > and gpiolib-swnode.c they work exactly as I wanted them ;) Yes, in
> > general name is optional, but for GPIOs it is needed.
> > 
> >>>
> >>> I guess using the swnode-name + gpio_device_find_by_label()
> >>> works but it goes against the design of how fw-nodes
> >>> and especially fwnode-references are supposed to be used...
> >>>
> >>> Having a fwnode reference pointing to what is in essence
> >>> a dangling (not attached to any device) fwnode is weird.
> > 
> > I agree it is a bit weird, but this allows to disconnect the board file
> > from the GPIO driver and makes it easier to convert to device tree down
> > the road as it can be done in a piecemeal fashion. If you want fwnode
> > actually attached to the gpiochip then:
> > 
> > 1. You can't really have static/const initializers in most of the cases
> > 2. Fishing it out from an unrelated subsystem is much harder than
> > matching on a name.
> 
> Ok lets keep using the current swnode.name based approach then.
> 
> That certainly makes things easier for the x86-android-tablets
> code.

Hi all,

I'm left uncertain if there are any remaining concerns with all these gpio 
conversion patches (the 3 independent ones and the larger 
x86-android-tablets series)? While I see there were a few back and forth
items between you three, it sounded like there's nothing left to do and it 
was all just based on wrong impressions/understanding, is that correct 
deduction from my part?

There was also an almost promise from Hans to test the x86-android-tablets 
series, is that still on plan/pending?

-- 
 i.


