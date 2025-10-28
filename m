Return-Path: <linux-kernel+bounces-873464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8890C13FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB7F19C4313
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BE2EA151;
	Tue, 28 Oct 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWsGL09Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A721CC44;
	Tue, 28 Oct 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645762; cv=none; b=jScy5IVq0AqAa2G7Gyh0iA4Tvx6IRf8/POASkdU0dGC3MMQNj4AMgeiXpHAAVT3l9Ze3cCwYFKRS3Z6dFTAuy6nNv/hF4hkY7Uaaa6ISqYzMEHyMeTRyC1qwBrkTUFQ4UQge+m4WmC55SkZjPUG6xeMO1cWuRMhdzA2LP5j+hk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645762; c=relaxed/simple;
	bh=lQWfisAJs4RJ3y8d55ySLjGc636npxz1pe40KBUeamQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtErVE/n9gepOjgz2VoiDl/+OB1rd7jOrvG99X4Vz6tsMA0MXbrO7FaNFapirRYhWRz021Gf8SmEY8wFtkZEnaJ2jdUYh/Pz3ITLH9LATbBNaK3t6bT5YmLVm33vrVf5fHP5x1szWgq8r+0YvUnj58NV3UAj9oq1bhDMnLpRHV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWsGL09Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761645761; x=1793181761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQWfisAJs4RJ3y8d55ySLjGc636npxz1pe40KBUeamQ=;
  b=SWsGL09Y1pg3o/5V9C32jp1RvMwA/fKbj7JvNOrJ6epgRx2TCj/t6Hop
   46uHA4YGeDnRR9OL6wK01Q3hIxJOA/ToxdwpnerSiQx2mvxVzraxTF2NT
   Rqb1BYV8+g/Ym4+dPGBLX1Mel52YcEzaXk6pFN8H6A3NOtPa6IqQ3vCHT
   IxU1G83lAjYK2JrLhRvhy23+ELoAHqZv+LEt45Bu2FP2A4qo7i/35NyjO
   LZr1sHHDgxuC4V1g7XZDBZ9idJGuEjhsCMTLYFn3TqhtkVXsBCuBrzp0k
   u+Y8M7n53GuxxLxDoEqrcAGiLpDgRgNWtowXw+zxnaPyJCQLMGzcWMXjS
   Q==;
X-CSE-ConnectionGUID: vOJU/I9eSJ+giZMHXofiKQ==
X-CSE-MsgGUID: hvxb4DCcQ4eZ2xTfJPE9gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74416082"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74416082"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:02:40 -0700
X-CSE-ConnectionGUID: 9HQMeyTZRlmPNrPh0jzpQw==
X-CSE-MsgGUID: ggLPNZggTwy4b66UXSalDg==
X-ExtLoop1: 1
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:02:38 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDgXD-00000003HD7-2l9O;
	Tue, 28 Oct 2025 12:02:35 +0200
Date: Tue, 28 Oct 2025 12:02:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Scally <dan.scally@ideasonboard.com>
Cc: Qiu Wenbo <qiuwenbo@gnome.org>, Daniel Scally <djrscally@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
Message-ID: <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
> On 24/10/2025 06:05, Qiu Wenbo wrote:
> > 
> > regulator_unregister() already frees the associated GPIO device. On
> > ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
> > random failures when other drivers (typically Intel THC) attempt to
> > allocate interrupts. The root cause is that the reference count of the
> > pinctrl_intel_platform module unexpectedly drops to zero when this
> > driver defers its probe.
> > 
> > This behavior can also be reproduced by unloading the module directly.
> > 
> > Fix the issue by removing the redundant release of the GPIO device
> > during regulator unregistration.
> > 
> > Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")

> However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
> call to gpiod_put() when the module is unloaded; doesn't that mean that the
> same issue  will occur before that commit?

Actually a good question! To me sounds like it's a bug(?) in regulator code.
It must not release resources it didn't acquire. This sounds like a clear
layering violation.

-- 
With Best Regards,
Andy Shevchenko



