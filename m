Return-Path: <linux-kernel+bounces-873606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E1C143F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F284C1AA5E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397ED307AC6;
	Tue, 28 Oct 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4G9Xy7Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7D26C3A7;
	Tue, 28 Oct 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648899; cv=none; b=IonzDtvRdrx+fW+I5vpW2iExr7tEUtJlVKNxTVZS1R7ZTPJNup5p8Ha0D44EZhQZrOOMdMCrwngLhQvN8HZ5IJj5Uvodm74dCvN1WDewgFmcfMxwmJCFbXBwamLbUmWCbl8Dz9c5q9ywp03U8vuGJ7wJc+8Cblm+alDTBXrcUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648899; c=relaxed/simple;
	bh=tNF3NVjCKUJmaGz92k5s0fNZFi9duePZm2Fk14uSDrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYiZzFEVL4BHVstVUOY9bStBCyn9GhWtRNh3dixxO+ZEYD3TSnagvM8ESrUa/IbX0Mp+7Nf2RiARrmNkA5w7KM3O+0+bPQYMBy8gBG4ZBUmuJfnfZ3KszJQ2SFqbfc/s49klv6Um0IxgmzYRAaISwahIpX//YYMPMnBJnRdvyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4G9Xy7Q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761648898; x=1793184898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tNF3NVjCKUJmaGz92k5s0fNZFi9duePZm2Fk14uSDrw=;
  b=f4G9Xy7QCNKAdxnSWGbsAyRioNrQLU1CnXtA8M/tQEZ7qeJaeoP+67f0
   BKqXKrduHmMntwkSeg30yBp6hhLy6Rpw6q5k+NF44bbO5AqnVJm+YuKSr
   /Iveal+C9y6KG1HHmguXzBSxgHlONYrsuHbv2DMV7d+HZ1pIbOHZDV6aT
   RnXliq06nK+UO5WruK1FjTw3s/L1Ki9nYS1FTw1nWqC23Mq/+NrDMwx99
   5Ciw2tN02EcYsDb6RTVdDIuLl3aPycj1yXNwApgJ1PET/trrubN44UBg2
   yNSPuZlts9XLLQ2uiViKjJeIfCB2KQI3llJ8eofGXmPYrRpVvs2kOUjsi
   g==;
X-CSE-ConnectionGUID: 1ivGBndWQBuDD3bj+x2ByQ==
X-CSE-MsgGUID: ePiJdklrSLyDIAQKGm4EFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89215408"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="89215408"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:54:57 -0700
X-CSE-ConnectionGUID: io9eWLyCTN667L12GYdkYw==
X-CSE-MsgGUID: 7yVL/8YESPSWsfQr6K7FDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184491741"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 03:54:55 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDhLo-00000003Htz-0HA8;
	Tue, 28 Oct 2025 12:54:52 +0200
Date: Tue, 28 Oct 2025 12:54:51 +0200
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
Message-ID: <aQCg-xZ_kAemfgZQ@smile.fi.intel.com>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
 <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
 <7898408e-1b33-4f22-84d2-12bcd6254402@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7898408e-1b33-4f22-84d2-12bcd6254402@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 28, 2025 at 11:38:00AM +0100, Hans de Goede wrote:
> On 28-Oct-25 11:02 AM, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
> >> On 24/10/2025 06:05, Qiu Wenbo wrote:
> >>>
> >>> regulator_unregister() already frees the associated GPIO device. On
> >>> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
> >>> random failures when other drivers (typically Intel THC) attempt to
> >>> allocate interrupts. The root cause is that the reference count of the
> >>> pinctrl_intel_platform module unexpectedly drops to zero when this
> >>> driver defers its probe.
> >>>
> >>> This behavior can also be reproduced by unloading the module directly.
> >>>
> >>> Fix the issue by removing the redundant release of the GPIO device
> >>> during regulator unregistration.
> >>>
> >>> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")
> > 
> >> However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
> >> call to gpiod_put() when the module is unloaded; doesn't that mean that the
> >> same issue  will occur before that commit?
> > 
> > Actually a good question! To me sounds like it's a bug(?) in regulator code.
> > It must not release resources it didn't acquire. This sounds like a clear
> > layering violation.
> 
> I think the problem is that when it comes from devicetree it is acquired
> by the regulator core.

Hmm... I probably missed that, but I failed to see this. Any pointers?

> Only when passed as platform-data as we do here does
> this layering violation occur.
> 
> I do believe that a transfer of ownership ad done here is ok for
> the platform-data special case.

-- 
With Best Regards,
Andy Shevchenko



