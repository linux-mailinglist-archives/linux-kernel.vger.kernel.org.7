Return-Path: <linux-kernel+bounces-758947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36FB1D60B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A04D3B63DD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E155226D18;
	Thu,  7 Aug 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vfr7E9Zr"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75667231A24
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563938; cv=none; b=R96IOEWSxJRylxWhgZ8bHx3+t/M0HTcYPnYZfT5FwUxsVEV7JkErwR5heJUL75U277DvUJZngAjftjKFEycdQUbml1i7T1X9RJxhsXb1NNFsbRDWjWR/xpZBUFHMrvZ7aZvvpm7lQSQHnFV08smCxymMZVGYnyHIeRfsDF0lbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563938; c=relaxed/simple;
	bh=hfglwkMvFhGOn4QWj+g72ZNFRcXszfY9LNm2lHtcgys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE4GI+lnigjM1x08meeUMTRC3ixSb5WpcK37b7iqklRJdiQgNvRM+dY6UHMicSWXmatAneR4OTGKslGyjZazGohLUkIx8h+Y6H3NPZLhZRV6otV25dd0Mnv0XvdIMsG1wWWVAPlFZ8Ig/K6iY8oYD5IobF+5eX3xAWqRlYxai/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vfr7E9Zr; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Aug 2025 12:51:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754563923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqe6q9lfo06sDNWQSsMLztyPkdiJPfGU7rsiVJ59AjM=;
	b=vfr7E9ZrPSOIdsUhfSvWrORcBxJ3ivRs2hs6UtCvr6ljhjb+aCQwIe83ZFLLG5l5wJJ0Ll
	Jwsqqu1YHXpU7an9hjahZh6KJIqroTCTslRaM+Z+sXVlsauXPWJ9ZSA39qf2KKygnnSiHj
	pekcmzKuI+EekDOYXt/n2HaHqfATxXA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Haoran lee <470658536@qq.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/mod/modpost: For CentOS 7/old binutils
 compatibility
Message-ID: <20250807-elastic-transparent-kingfisher-8f7ada@l-nschier-aarch64>
References: <tencent_6FE857803A1AAB21B71853A2E89626ABA407@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_6FE857803A1AAB21B71853A2E89626ABA407@qq.com>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 29, 2025 at 12:19:46AM +0800, Haoran lee wrote:
> 
> Signed-off-by: Haoran Lee <470658536@qq.com>
> ---

Please note that empty commit descriptions will not be accepted.


>  scripts/mod/modpost.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 5ca7c268294e..216647e2f301 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -30,6 +30,32 @@
>  
>  #define MODULE_NS_PREFIX "module:"
>  
> +/* CentOS 7 / old binutils compatibility */

Since v6.16-rc1 the minimum binutils version has been lifted to 
binutils-2.30 [1].

Which binutils version do you have at CentOS 7 ?

Kind regards,
Nicolas


[1]: https://git.kernel.org/torvalds/c/118c40b7b50340bf7ff7e0adee8e3

