Return-Path: <linux-kernel+bounces-868143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E008C0476A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77743B9FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC426ED3C;
	Fri, 24 Oct 2025 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sy5aAW1X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D435235B132;
	Fri, 24 Oct 2025 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286535; cv=none; b=qtdQvxwwDQNDGFhWQ1Ml2RquhzSwG/ty1h2ntdfbbxCmvx8swMpKeDNgV8SzXxC7VkgbxNgTpYLQHDOaGCS1zfCPJfogHERBG+HqvXZoNBP2n+Sh4Qlk0CjOdwd2G/FAFoXrDMKftioXq5Co3/S35flKDA2SleYnOOQeVzhwZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286535; c=relaxed/simple;
	bh=yZOXALz3vhxcH1L7uqfvS2PVeWLmdO7dhTHHIuBg0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBpZ+2jlJCmKricxbYKzmOBoQpF7yr7+7CelpC78t6va13pG2swgcgpz99yZHQok0JSgUrC9zhJWh7A4WlXZNycKQ29goP5GxXpXZbRnMZkv59adkHZIMWMKvLMYrisi2MvvjrLo1JPQ27C4c52h+UTndEL3dhv553hzTF5h3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sy5aAW1X; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761286534; x=1792822534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZOXALz3vhxcH1L7uqfvS2PVeWLmdO7dhTHHIuBg0kU=;
  b=Sy5aAW1XujWOonI8pxwXLRxooE3sffJeFAesqmfzSEuyLVBobclcoSgR
   9j/mMLMihOg3qQp8l39PeS0dB0uvsHe7ukCpIoeN8Fvp2+GlNpPkdzT2F
   qfshpUGhRtrNvYQMvVVJxKHp7nX7sy4S1Rd5IcpnnRL9CLNlxAx+pSLJe
   U+LLq5mocYf05b6TO2ksHt8hXUcjxeeY75f+6ME4TsIw2rtBdncniD1nt
   AK94ksbjV0i72+e87RrQyDytOYz1mhm34+5irrfV1iG7YZdcRhdGOajwo
   kbjBOXomc1w9xFeotp7dHEdhBfqiQdkqtPZhQCqvs6XXF9DFO9KCHX8Or
   Q==;
X-CSE-ConnectionGUID: bA5f3SjnRSmLJWU6AGRdUg==
X-CSE-MsgGUID: cbZErmSNTvuyDMPCMynBEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62674638"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="62674638"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:15:32 -0700
X-CSE-ConnectionGUID: e1S+j2yYQ3CzE8gYBn+JAw==
X-CSE-MsgGUID: vwynUzDDTwKQLBdFI5XYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="184422919"
Received: from opintica-mobl1 (HELO ashevche-desk.local) ([10.245.245.60])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:15:31 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vCB5D-000000024nY-1erw;
	Fri, 24 Oct 2025 09:15:27 +0300
Date: Fri, 24 Oct 2025 09:15:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Qiu Wenbo <qiuwenbo@gnome.org>
Cc: Daniel Scally <djrscally@gmail.com>, Hans de Goede <hansg@kernel.org>,
	Qiu Wenbo <qiuwenbo@kylinsec.com.cn>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
Message-ID: <aPsZf-sL3a44hdDd@smile.fi.intel.com>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024050537.92440-1-qiuwenbo@gnome.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 24, 2025 at 01:05:37PM +0800, Qiu Wenbo wrote:
> 
> regulator_unregister() already frees the associated GPIO device. On
> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
> random failures when other drivers (typically Intel THC) attempt to
> allocate interrupts. The root cause is that the reference count of the
> pinctrl_intel_platform module unexpectedly drops to zero when this
> driver defers its probe.
> 
> This behavior can also be reproduced by unloading the module directly.
> 
> Fix the issue by removing the redundant release of the GPIO device
> during regulator unregistration.
> 
> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")

> 

Should not be a blank line here.

> Signed-off-by: Qiu Wenbo <qiuwenbo@kylinsec.com.cn>
> ---

The change sounds reasonable to me. FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



