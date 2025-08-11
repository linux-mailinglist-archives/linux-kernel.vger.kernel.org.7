Return-Path: <linux-kernel+bounces-762626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B21B20917
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FAB2A3219
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6BF2D3EDD;
	Mon, 11 Aug 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McXHSEOX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282722422E;
	Mon, 11 Aug 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916264; cv=none; b=lAxiBFLR9cbIsDVgzRqlndfu8SKcsCTr6t+ZsQ+VHQDbqHg+3/dWTf52kjyt+DZt2WY+WY3y/3y6jqlIEaa84UITtK/ashEV4UAENgujCBscWs5E92H1WucYgRmSxBmE3c1sSFIligmMLZhgjVO0PjSUpgAfi2flOuAtqlvQP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916264; c=relaxed/simple;
	bh=vQ+vW3bb4SLO8jvImSIJRfB/JR6jIDTFO9Yuv06+5oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvVig6SDuCVmZMmB+INIzQT/o2qLMHviJimrhctoaYLMsikS7gHAX1p78McZUrKCiMJ7w+nLDSLEsiz+tOtktaremtyZkoOo9MP0S9pvShSLC7d8Ar2YSSyiciJuxMvIncTNxfTs6CB3cbrdA7Z2OwbC/ccJrjA/hRE5nWI4LJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McXHSEOX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754916262; x=1786452262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vQ+vW3bb4SLO8jvImSIJRfB/JR6jIDTFO9Yuv06+5oQ=;
  b=McXHSEOXg7VD8JkGaIKWzF4PYwHXFblPm+iFez6ziiVVNZP1oqEL8ZiD
   d8g7wt5Xb8jx27ZRbvVY8a3twVj1hFEcK88uwqMaQ/mBmphscIRkJUWXJ
   P6FIETVTwQjbC1So4/IKow+Nau9QPfZJaYUHHqXK6eL/zQcHQ45G5E5x6
   aHAST1ThsKRtazhdyr8zd6nU5tUKIDUj+NtEaMeTRKOOqDOBAMtvgz2Mt
   qB0Vt+75vcnlIKgsrRjnrB6CyR+XkWEw/hzXgT8gejyj9D5GRFVgSEG4Z
   SC42j60QuoOCYmszpbebjpqivMlIuxsrW6XtFM84dLqBQ+BlmHYJuivRB
   g==;
X-CSE-ConnectionGUID: 8nLWcKWGRlaUdJZKViPtVQ==
X-CSE-MsgGUID: 4Jh9jiMZQYaLmHbzap5yzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="59779612"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="59779612"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:44:21 -0700
X-CSE-ConnectionGUID: pP11mqFeTMO9P+0bNzVPnA==
X-CSE-MsgGUID: /PMSQW+ORlWWFlHWtCezgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196903247"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:44:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ulRsu-000000052Y1-0cvd;
	Mon, 11 Aug 2025 15:44:16 +0300
Date: Mon, 11 Aug 2025 15:44:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
	Hans de Goede <hansg@kernel.org>,
	Peter Korsgaard <peter.korsgaard@barco.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
Message-ID: <aJnlnx2qF6P61jJN@smile.fi.intel.com>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
> In preparation of dropping support for legacy GPIO API from gpio-keys
> switch the driver to use software nodes/properties to describe
> GPIO-connected LED and button.

...

>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/io.h>

>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/gpio_keys.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/machine.h>
> -#include <linux/input.h>

> +#include <linux/gpio/property.h>
> +#include <linux/input-event-codes.h>
> +#include <linux/property.h>

The idea of sorting here is to have more generic first and then more specific
(per subsystem in use) groups of headers. So with your change it should look
like

#include <linux/delay.h>
#include <linux/dev_printk.h>
#include <linux/dmi.h>
#include <linux/err.h>
#include <linux/io.h>
...
#include <linux/leds.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/property.h>

#include <linux/gpio/driver.h>
#include <linux/gpio/machine.h>
#include <linux/gpio/property.h>

#include <linux/input-event-codes.h>

(I also added blank lines to make it more explicit)

...

Otherwise LGTM as here it looks like we establish platform device ourselves and
hence no need some additional magic Hans mentioned in the other series.

-- 
With Best Regards,
Andy Shevchenko



