Return-Path: <linux-kernel+bounces-775948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A633B2C6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068541BA5922
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF56221550;
	Tue, 19 Aug 2025 14:11:58 +0000 (UTC)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8321FF23
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612718; cv=none; b=hOnQYKpF/5vtugCqdRlTpEwNlNYV3FKPklSkoNr5dtM7TQ+1M+uHrVIQSWCv7KLYLh3CfyslUFcIobsAfwic4/WfY9Txv55RJrRUC2F1kiyyAadnccJlOITpH+UoUUK78sQYFzuVAmns9QExHQX/MHPnntHtSHG8BUWATaA7K1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612718; c=relaxed/simple;
	bh=h8VMfZ5dQlHMpsx+zcqtlSMw6Gmi35cS5eLWjnjmy54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMC/GvpNPDWCYF3O6i97z3TdKvjeEB11OU/R76Q21V0u0OkNV9OfA7DtfDxcD/leABC34Fmfc7o0AOX3fU0pbuwXRTWcjk+dRU5mRUnCBtnzNV+MkZxqsbH691XvjAB0WL89Gydg0BJIARS2V37fOIljDjuklJ1lSHK9SIKOdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 10:11:33 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
> On 8/18/25 1:32 PM, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> > 
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> > to allow get/set of this value.
> > 
> > Use a filter_type[none, ema] for enabling the IIR filter.
> > 
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> > +		if (data->filter_level == 0)
> > +			return -EINVAL;
> 
> To implement Jonathan's request from v5, drop this error return.
> We'll also need a separate bool data->is_filter_enabled field so
> that we can keep the last set filter_level even when the filter
> is disabled. (i.e. data->filter_level is never == 0).
> 
> This way, if you set the filter level, you can enable and disable
> the filter via filter_type and still have the same filter level.
> 

Thanks, David. This is exactly what I've implemented, plus the
filter_enable attribute.

Adding the ABI doc updates as well.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

