Return-Path: <linux-kernel+bounces-897451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96510C52CED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C98335037D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09D733ADB7;
	Wed, 12 Nov 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nu1tFFT0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283F2BEFF3;
	Wed, 12 Nov 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958628; cv=none; b=EOot4TRDmhifI2VigAyse5QPES6e1fUnr5NoeQ8p38M9rIoFWNUwS1MAc6osWtOVY+IJhReQpsiC9wJVB88XTqLqqFmo+REQGJSK/SPEb2svh5QNEKxKmwj0HrT0PsZwQ+tXI+HGlVMTCOJB1SYyaP7SA5zh6KQARSDTiKgJxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958628; c=relaxed/simple;
	bh=ilC6tGexmJ0iIDVMobFd8bh9Opvb8ZsC7ENTeTEJYZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJYRizbsGUaUFcQCZr/8Ctrfjrlcg6Nwwtz1vDAyuDoxkQg7E1pYwRiqlO8qlEAHhoXRC/iHFA+kjIxdyV1iDVscsqhkIQ2XCXIT7R40UUMsIBMv/L6fpPm+Nm53KbwOvs0ZjtjhdsiynC7uCsHBI5/5rgf4t1uJXcQCQYbEjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nu1tFFT0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762958627; x=1794494627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ilC6tGexmJ0iIDVMobFd8bh9Opvb8ZsC7ENTeTEJYZw=;
  b=Nu1tFFT0ANv5EzPxsV+8iJpFp5r47Pmuk3lGBZIAwtbpBuWfci1VZp6x
   G2uxoB3EiL9iDyz8m8GJogRaoIqUIf53Od1U2M/rUV7X7DvywLhb2tVmG
   uKyh89lPYana+DilAvEHiIyFyZ6cMDfnQRNg3tFgyjewtcu+3UJ0SaBZ9
   c34BrrGEG/MNu5Hb32n1w7KuOTtozQ7RChEcnwJmpvc29jGD+YHiWW7Ns
   ozA1ZMqd127oQ0DNzu7TjU70/6Hys8OnbfQO0MaieiyTGHDt3ou1hYIfX
   3RXwvKrr5iA+HrO3ihLmbeuHXDOvK8enk/+vnNL/VvqLTau80Eq/iGZyE
   w==;
X-CSE-ConnectionGUID: 6WGC9r3YQQKIbmTgcEjBvg==
X-CSE-MsgGUID: fksfhszQQlGbstPrpl627w==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="87662344"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="87662344"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 06:43:46 -0800
X-CSE-ConnectionGUID: Tof3iMyERSKtKocPqcmnTA==
X-CSE-MsgGUID: sm94GNjRSQmH4cACIOSAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="194217467"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2025 06:43:43 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id EE0D195; Wed, 12 Nov 2025 15:43:41 +0100 (CET)
Date: Wed, 12 Nov 2025 15:43:41 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com,
	Denis Benato <benato.denis96@gmail.com>
Subject: Re: [PATCH v17 0/9] platform/x86: Add asus-armoury driver
Message-ID: <aRSdHcO1WCPmG63W@black.igk.intel.com>
References: <20251102215319.3126879-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102215319.3126879-1-denis.benato@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 02, 2025 at 10:53:10PM +0100, Denis Benato wrote:
> Hi all,
> 
> the TL;DR:
> 1. Introduce new module to contain bios attributes, using fw_attributes_class
> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
> 3. Remove those in the next LTS cycle
> 
> The idea for this originates from a conversation with Mario Limonciello
> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
> 
> It is without a doubt much cleaner to use, easier to discover, and the
> API is well defined as opposed to the random clutter of attributes I had
> been placing in the platform sysfs. Given that Derek is also working on a
> similar approach to Lenovo in part based on my initial work I'd like to think
> that the overall approach is good and may become standardised for these types
> of things.
> 
> Regarding PPT: it is intended to add support for "custom" platform profile
> soon. If it's a blocker for this patch series being accepted I will drop the 
> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
> separately to avoid holding the bulk of the series up. Ideally I would like
> to get the safe limits in so users don't fully lose functionality or continue
> to be exposed to potential instability from setting too low, or be mislead
> in to thinking they can set limits higher than actual limit.
> 
> The bulk of the PPT patch is data, the actual functional part is relatively
> small and similar to the last version.
> 
> Unfortunately I've been rather busy over the months and may not cover
> everything in the v7 changelog but I've tried to be as comprehensive as I can.

This is more files starter with asus in PDx86.
Perhaps it's a time to have drivers/platform/x86/asus/ ?

-- 
With Best Regards,
Andy Shevchenko



