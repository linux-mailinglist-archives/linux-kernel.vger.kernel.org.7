Return-Path: <linux-kernel+bounces-859344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F4BED55C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7913B42E8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE5257AEC;
	Sat, 18 Oct 2025 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8vlXFY8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C95A1F4606;
	Sat, 18 Oct 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808744; cv=none; b=qpRvYhEA+1pTbOC82+q+U2x384UE6IVXgH6iT+eVTgKbQ3/2DZs8ghmjnwhevsJD05AmEzNIc2DpugZQUA2DhQK3K9m5Z5/FgoNIvncS1KuikhzRzbxq9nAd8ImA6MFheno7/slEKNYDwLe3sJi95drgBX1/kcTNpsf7uiwHaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808744; c=relaxed/simple;
	bh=/X1M7r+VXHWyfIydfI8CBDXxttbvnP9OJALMfohK/Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKC5AemHHnS+4K1wxsyKSTTCaYooxhXzgglu/CKKk1Lnf5fBhHXI7Ms6Rfxc3rLi322GeaROBpyjakpYwTg7xZ3+qYXJ4w3adLzV2MOIZTvYo0hDSfBSxoU4IYvsFsfSloFYDgQjfjrcg2FWFS7BoDwcd1ewx9kNH7ruI+tYN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8vlXFY8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808743; x=1792344743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/X1M7r+VXHWyfIydfI8CBDXxttbvnP9OJALMfohK/Ds=;
  b=W8vlXFY8SxXiV48pd3wOiHgI3QmEhbgAs6QfvHHx+IONdELWKmxqwejK
   6uFF+alJLOr1LhrhuqMVJU2Skn4WKe3wN0QLi5u8WO9zn2XB3VHEiJakX
   /ITe5dyw1IggxGDvYR+nHaRV8RZ88wM4sBogGDNb1M3+AU7W/Qb0iMmWc
   fmoPQ5Tq43V0uiSC3PyGFuK+Omsm5iE9C1l20owyaDT78biRZN6l1r9N0
   ohrvr0zQF+UVSoewu9sBEhcPaneJCdDbqUQ9ZSOXfP4XdpP3WU3+WSFD0
   YJNxGtBNf80fIBhJygOuVKwhGCHWEl6Y1d6sOdHDvVSUyH/MI7TA4kkmK
   w==;
X-CSE-ConnectionGUID: FcWYkVkhTMiuBEe9MK+bXQ==
X-CSE-MsgGUID: 9f2O+fmOQLi6g5S3AlBtzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62206488"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="62206488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:32:22 -0700
X-CSE-ConnectionGUID: Z4LfH32PTkiD+JQhk97cNQ==
X-CSE-MsgGUID: EgBKw2JHRoKc+V/4GB2qVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="206700795"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:32:19 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v94bT-00000000MiY-1MCc;
	Wed, 15 Oct 2025 19:43:55 +0300
Date: Wed, 15 Oct 2025 19:43:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, linux-iio@vger.kernel.org,
	s32@nxp.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com
Subject: Re: [PATCH v4 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aO_PSisFmsYb84r0@smile.fi.intel.com>
References: <20250919135618.3065608-1-daniel.lezcano@linaro.org>
 <20250919135618.3065608-3-daniel.lezcano@linaro.org>
 <20250920102742.4cadb734@jic23-huawei>
 <0ac22118-fd0f-49c0-9aa8-5739925587d2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac22118-fd0f-49c0-9aa8-5739925587d2@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 15, 2025 at 09:17:40AM +0200, Daniel Lezcano wrote:
> On 9/20/25 11:27, Jonathan Cameron wrote:

[ ... ]

>         ceocfr = readl(NXP_SAR_ADC_CEOCFR0(info->regs));
> -       if (!(ceocfr & NXP_SAR_ADC_EOC_CH(chan)))
> +
> +       /* FIELD_GET() can not be used here because EOC_CH is not constant
> */
> +       if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
>                 return -EIO;

Make field_get() public in bitfield.h and use it. We have a handful copies
already which deserves someone actually does that for all.

>         cdr = readl(NXP_SAR_ADC_CDR(info->regs, chan));
> -       if (!(cdr & NXP_SAR_ADC_CDR_VALID))
> +       if (!(FIELD_GET(NXP_SAR_ADC_CDR_VALID, cdr)))
>                 return -EIO;
> 
> -       return cdr & NXP_SAR_ADC_CDR_CDATA_MASK;
> +       return FIELD_GET(NXP_SAR_ADC_CDR_CDATA_MASK, cdr);

-- 
With Best Regards,
Andy Shevchenko



