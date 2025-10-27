Return-Path: <linux-kernel+bounces-871477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ECEC0D651
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB57434D131
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5712FFDC2;
	Mon, 27 Oct 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG7a4pxy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9919ADBA;
	Mon, 27 Oct 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566815; cv=none; b=dpsOoHXy0lXlw3YoeKGFcKzVfgmIztw/kxzUEbOFBoDbnTOC2tUoU17MaWOkG7gdzMOZ9hGucBVIHIgX6REJ13BgpFlju71zr/OWLpZbD1+xP+5yfCpz0i9dZIUua1kVISCkkgi1hUbM33TLmVgQzeefXJRZwkgpCINqKSH4Eg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566815; c=relaxed/simple;
	bh=bd9xs45Eax+hvL9RuVs0Ic37ps90njj6saptvTUvmPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plXUFL4DZDo7Bh8SHTA201ytig7Mb4fNh0hw9sRKmJmnLpFeZdxEjV+IMnVPeZLo/bPEKI1Km2619WzpjJX7tMEwv7lVM5LyGtj4jI0y+iJxwBIPMzoAR80Yy3X9Orhp2UYpzlFXxoxlUo48+3E0FX42jOvFyKZ04vLCU9IC7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG7a4pxy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761566814; x=1793102814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bd9xs45Eax+hvL9RuVs0Ic37ps90njj6saptvTUvmPo=;
  b=cG7a4pxyr2n67lUzIztUhw268a1weIjKb1bKGk9Sr9P2nllsGu5k6IXq
   aoCUu2JLaO0FDmacOj0KgFKslQQy5rCC7+/XtYCxg8/gJDkBTzuIyLWQU
   iAfyoIA556M2mjHa+rzI8GUAGMSwR61O1FVg+mKRZl8pW7KEx1eqiuQRK
   U65js38h7HsFY+SRQGsTDUyY1b84P4BnjVKBSHC3z+p4DG3EWNH/Vm4+f
   m5aYD5w0A2vlKb0/q5yWpfxIxRa3czSGB9sLPB71nRo3M0fbFItmY+Ujx
   ITEzLUR/7LP1lc9uPexzdJAsaqWPDEXM1+Bk5N9QbSIWI8yen/P5y+g//
   A==;
X-CSE-ConnectionGUID: Lz+g3NiFQLugMEyqtO0Low==
X-CSE-MsgGUID: x28Dy2qqQE2YsVFEM4N9CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63531889"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63531889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:06:53 -0700
X-CSE-ConnectionGUID: hS2F1AicRM+iMguUpBzz+g==
X-CSE-MsgGUID: 7AnycQYeQaSEkVKEkGdAlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="189396668"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:06:51 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDLzs-000000030Sc-3dn1;
	Mon, 27 Oct 2025 14:06:48 +0200
Date: Mon, 27 Oct 2025 14:06:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ciju Rajan K <crajank@nvidia.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
	platform-driver-x86@vger.kernel.org, vadimp@nvidia.com
Subject: Re: [PATCH platform-next v3 1/1] [PATCH platform-next]
 platform/mellanox: mlxreg-hotplug: Add support for handling interrupt storm
Message-ID: <aP9gWId8aav-LjA-@smile.fi.intel.com>
References: <20250923134954.3016697-1-crajank@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923134954.3016697-1-crajank@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 23, 2025 at 04:49:54PM +0300, Ciju Rajan K wrote:
> In case of broken hardware, it is possible that broken device will
> flood interrupt handler with false events. For example, if fan or
> power supply has damaged presence pin, it will cause permanent
> generation of plugged in / plugged out events. As a result, interrupt
> handler will consume a lot of CPU resources and will keep raising
> "UDEV" events to the user space.
> 
> This patch provides a mechanism to detect device causing interrupt
> flooding and mask interrupt for this specific device, to isolate
> from interrupt handling flow. Use the following criteria: if the
> specific interrupt was generated 'N' times during 'T' seconds,
> such device is to be considered as broken and will be closed for
> getting interrupts. User will be notified through the log error
> and will be instructed to replace broken device.
> 
> Add fields for interrupt storm handling.
> Extend structure mlxreg_core_data with the following fields:
>  'wmark_cntr'   - interrupt storm counter.
>  'wmark_window' - time window to count interrupts to check for storm.
> 
> Extend structure mlxreg_core_item with the following field:
>  'storming_bits' - interrupt storming bits mask.

...

>  	for_each_set_bit(bit, &asserted, 8) {
>  		int pos;
>  
> +		/* Skip already marked storming bit. */
> +		if (item->storming_bits & BIT(bit))
> +			continue;

Instead, just mask "asserted" correspondingly before for-loop.

...

> struct mlxreg_core_data {

>  	u8 regnum;
>  	u8 slot;
>  	u8 secured;
> +	unsigned int wmark_cntr;
> +	unsigned long wmark_window;

Is it okay to use variadic (arch-dependent) types? The context suggests that
this data sturcture has fixed-width fields.

>  };

-- 
With Best Regards,
Andy Shevchenko



