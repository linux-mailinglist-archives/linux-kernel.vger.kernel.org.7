Return-Path: <linux-kernel+bounces-798309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C650B41C26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37839561285
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342512F2906;
	Wed,  3 Sep 2025 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3QnUAL6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333962F0C6D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896308; cv=none; b=UuhKf2F7G/MiyetgeJJkZN15bmktAUWKiKcONKoGNvEpKQYGUyMcfHOE2ZJqmcOtKeXopOqHtQBnGRIrISuIBgRkOtjStYvhEvTGiusw0fz7Dnw2Td6/shfc2WhtyIRfViZ4zBcX2mnoO83edM8dJEJbUkYwtPPWF9lJVnzFcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896308; c=relaxed/simple;
	bh=4UtO5nfHOeYxD/eO8raCJFgoEWhsx4yjbyMN+ZrOqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clMsr3NiQBifUfWq2+7yeSIZ0sAj9WMngSFrG9XUivtpM7EW6ERj54UwLKEX4FPTTVq1gv3WqQOTLtjMnxsA8yrlE0+9+Pb/J9SxW0mOa0SaTn8u2BwV7Vkla1Aw0wVO59PUn6XjUrM/IuqOx5V93LJLZ5Q0P/LhLmVT7nkvrBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3QnUAL6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756896307; x=1788432307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4UtO5nfHOeYxD/eO8raCJFgoEWhsx4yjbyMN+ZrOqoI=;
  b=i3QnUAL6j4rbNVIBF7Jp8ih/+5qvT5M2++GxltKc161IH7cmXeqhcqlu
   QgrStB2dOqWaJxnuJZq8wNIKL+ZAD+M64pLMZI85DfKcgbYVxV30PgCn9
   Db7GywaNpSDNynQAAyw1fRQsWXLTFpJ0ozeOjzSb23D1cAwtSKOkDr86f
   ERtjNBduTRm7+s/UQBfCNBoHDKQszaxhzHWEUXtlHaZWFjM55tJGQjda8
   KSvX+9gJBg9VqkkEfdbzl7guijwINuB2ZLU2TfJvWXeNdTDWOVm+40/HP
   f+IYVg4y//NmNGZqedsZSaQrtVE1X4cf8nkFMfDvy4JvO9hI4j/BK434s
   A==;
X-CSE-ConnectionGUID: Q/2EzG3vRP+qZX2BgohOqA==
X-CSE-MsgGUID: 9pVImyAfQBan2d5QkZcIUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70304014"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70304014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:45:06 -0700
X-CSE-ConnectionGUID: WEw+a88iR+SXrOKK+VQZfw==
X-CSE-MsgGUID: 00t/2mvRSeK1s3MHE2PpkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="195183550"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 03:45:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1utkz8-0000000AxZU-0yDZ;
	Wed, 03 Sep 2025 13:45:02 +0300
Date: Wed, 3 Sep 2025 13:45:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 2/2] mfd: lpc_ich: Convert to use resource_rebase()
Message-ID: <aLgcLju74eF5V78-@smile.fi.intel.com>
References: <20250903081414.1972179-1-andriy.shevchenko@linux.intel.com>
 <20250903081414.1972179-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903081414.1972179-3-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 03, 2025 at 10:12:29AM +0200, Andy Shevchenko wrote:
> Simplify the resource handling by converting to use resource_rebase().
> No functional change intended.

...

>  	for (i = 0; i < info->nr_resources; i++) {
>  		struct resource *mem = info->resources[i];
> -		resource_size_t offset = info->offsets[i];
>  
> -		/* Fill MEM resource */
> -		mem->start = base.start + offset;
> -		mem->end = base.start + offset + INTEL_GPIO_RESOURCE_SIZE - 1;
> -		mem->flags = base.flags;
> +		/* Rebase MEM resource */
> +		resource_rebase(mem, base.start);
>  	}

We may gain 3 LoC more by dropping temporary variable.

But I will wait for the reviews in general before mocking up v2 of this.

-- 
With Best Regards,
Andy Shevchenko



