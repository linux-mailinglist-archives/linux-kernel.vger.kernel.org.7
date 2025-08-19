Return-Path: <linux-kernel+bounces-775985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D8B2C729
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D203517EBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8048027511E;
	Tue, 19 Aug 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnl5OTqo"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C82749FE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613946; cv=none; b=HtiTSmlfBkMiPXthG76AhLuzQKhkv4ESWo9Kck1/dHFIT2tF93onPZgngTz9wXxVSqONCgyr7kbbzwDux0H+JaGEXURpONX6eM43Yh7DBSDwwvBtm6MNKtGIemyGG/c1Pi4P7JLNw8W6UsOHknvoUkaktrLizMIM6z2XHlgGbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613946; c=relaxed/simple;
	bh=VAC6TUoAexxYg9XZdBS38Y93DNrw6aESRYkLRrU7mDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnwBV6/VspWv+o7Mr9Sc5gITW2uVLDAdslxup1dw0uF6BnatKujAD/fX0LjfQfLM4XsrY+6I12Pv7Ohs2G5G6L6D4/tyIf1JJlYjAhyk6zNQcc6+ztrShXNyrOw1kypGrQ3r/9GYBmtvmbpPdNSFl3rquneIT0qxFbg6h56qIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bnl5OTqo; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 10:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755613941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W+6QbkUa30DPYkTtwq9G12PlrPMsueXfZHzOqhP1QWs=;
	b=bnl5OTqoTe3UQBBL6ZOWWu5KwX2Cwdg2DjWXrQsFiR8w03YI6lj4PAAiv0iL2VqNQSEONf
	mFR6s7VHl8vO8ioy0NygsB+Onmyy+L/tXKJkKqvCx+fya67UcyFirGZD9WvQmomh/dLOxA
	F4rB5gnxQ3+a7K/vt+wvjNSGlPb3GBE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081910-shiny-trout-a937ef@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
 <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
 <f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7292e8d-ac7f-43af-b77a-7a1ad8403962@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 09:15:23AM -0500, David Lechner wrote:
> On 8/19/25 9:11 AM, Ben Collins wrote:
> > On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
> >> On 8/18/25 1:32 PM, Ben Collins wrote:
> >>> From: Ben Collins <bcollins@watter.com>
> >>>
> >>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> >>> to allow get/set of this value.
> >>>
> >>> Use a filter_type[none, ema] for enabling the IIR filter.
> >>>
> >>> Signed-off-by: Ben Collins <bcollins@watter.com>
> >>> ---
> >>> +		if (data->filter_level == 0)
> >>> +			return -EINVAL;
> >>
> >> To implement Jonathan's request from v5, drop this error return.
> >> We'll also need a separate bool data->is_filter_enabled field so
> >> that we can keep the last set filter_level even when the filter
> >> is disabled. (i.e. data->filter_level is never == 0).
> >>
> >> This way, if you set the filter level, you can enable and disable
> >> the filter via filter_type and still have the same filter level.
> >>
> > 
> > Thanks, David. This is exactly what I've implemented, plus the
> > filter_enable attribute.
> > 
> > Adding the ABI doc updates as well.
> > 
> 
> 
> Don't add the filter_enable attribute. The filter_type attribute
> already does the job.

That doesn't solve the problem at hand. An example:

- Driver has 3 possible filter_type's, plus "none"
- User cats filter_type_available and sees [none, sinc4, sinc5, sinc5+avg]
- User cats filter_type and sees "none"
- User cats frequency_available: What do they see?
- User cats frequency: What do they see?

Without filter_enable, [none, ema] driver works just fine. But the
above driver does not.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

