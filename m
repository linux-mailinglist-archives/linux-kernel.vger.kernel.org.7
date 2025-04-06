Return-Path: <linux-kernel+bounces-590129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A53A7CF45
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 19:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC11188BFF6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59977190678;
	Sun,  6 Apr 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ceZYQpWl"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F614B092
	for <linux-kernel@vger.kernel.org>; Sun,  6 Apr 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743961047; cv=none; b=sJ8ITeluSTxMumymyW0ZXGmYGaiIpoEpnHxIoxaWJwJO002SQc4kLS3I7cJm1wpzdarF2yILIHor2doS2egCPg7wmOQS6Gj61m1jDXKtMZ8GJaHgEWE9cqmg7vKgaWsIBEFeqg0qf9YJ/yvLyFm8x0BLaDSCnVzxBFSfjWJZjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743961047; c=relaxed/simple;
	bh=sH2Ny93X2vyJnTcewpo1S2IF8GKfBxc4fWMa58Kg9mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjlFJWMk7v4434kLQ9Hah2MouImn/83N8By6bIk/Ry6kwuRkiuTWko+5dL8ddNvxmu/lVXxH2hgMULkSlypX+O1Gqw3yUB30dfqjKIZX2VSJdZDu0DSP9Bhclkr7ZFinLCHvY99am38USYsZ4suvu3gXgA/3NfOL8wi5AoKafVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ceZYQpWl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 6 Apr 2025 13:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743961033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7uHlHes3zQj3Ipe3BYOH+iLJ9DR2l41JdYucAC4FPjU=;
	b=ceZYQpWlSfm+KQS7gHMEln5VIbroDBCQR8xcHq9KhfW9KNmJQtNx0CrVLc0iFA3omQ/GCs
	kTx2DuyBhXTFA0eDsNcQIDXD+71rZ//UTgVaaF7QR1MiQplC/9zJxYzOAhYzFwmvqMwm/a
	/7mttALNDLz9mhTU34XDUKcaCtJ2QPc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Integral <integral@archlinuxcn.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bcachefs: refactor if statements in
 bch2_opt_compression_parse()
Message-ID: <cxiovbh5tdwvt2k33bmdaonyncrdipbt6qj3h3gjyyi5mbzf4z@ss532ksrku46>
References: <20250406152659.205997-2-integral@archlinuxcn.org>
 <20250406152659.205997-3-integral@archlinuxcn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406152659.205997-3-integral@archlinuxcn.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 06, 2025 at 11:27:00PM +0800, Integral wrote:
> Refactor if statements in bch2_opt_compression_parse() to make it
> simpler & clearer.
> 
> Signed-off-by: Integral <integral@archlinuxcn.org>
> ---
>  fs/bcachefs/compress.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/bcachefs/compress.c b/fs/bcachefs/compress.c
> index d68c3c7896a3..adf939b47107 100644
> --- a/fs/bcachefs/compress.c
> +++ b/fs/bcachefs/compress.c
> @@ -713,10 +713,11 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
>  	level_str = p;
>  
>  	ret = match_string(bch2_compression_opts, -1, type_str);
> -	if (ret < 0 && err)
> -		prt_str(err, "invalid compression type\n");
> -	if (ret < 0)
> +	if (ret < 0) {
> +		if (err)
> +			prt_str(err, "invalid compression type\n");
>  		goto err;
> +	}

I prefer the old code for this one

>  
>  	opt.type = ret;
>  
> @@ -724,14 +725,13 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
>  		unsigned level;
>  
>  		ret = kstrtouint(level_str, 10, &level);
> -		if (!ret && !opt.type && level)
> -			ret = -EINVAL;
> -		if (!ret && level > 15)
> +		if (!ret && ((!opt.type && level) || level > 15))
>  			ret = -EINVAL;

This part does look better, though.

> -		if (ret < 0 && err)
> -			prt_str(err, "invalid compression level\n");
> -		if (ret < 0)
> +		if (ret < 0) {
> +			if (err)
> +				prt_str(err, "invalid compression level\n");
>  			goto err;
> +		}
>  
>  		opt.level = level;
>  	}
> -- 
> 2.49.0
> 

