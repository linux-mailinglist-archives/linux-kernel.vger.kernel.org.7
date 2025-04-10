Return-Path: <linux-kernel+bounces-597077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E95A834EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 02:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5124626F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72EA1876;
	Thu, 10 Apr 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EjmlpJfC"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57017E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243508; cv=none; b=MznFg+RP6AeXYxL6uU3ReEhB1jAEyIlgGuglJOFVTw290qxDNFCUG7XQ4k2bhtYbrUTvLc3SfbWv7FQAxGBymH7cHa+EQgscPqfxeHYkTCSyBzd4oRwjs6IG4gdEpyKWbZcryG6TQ7KDeb2mO56xs1wkLQNTmodARUmtaAf94SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243508; c=relaxed/simple;
	bh=MMmY/Hg2SPBpq07GYl0alwEt+JGMdE7/iv5NgVskB5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myxOVOwd0j6+4X8eV/rGL0Qrvx+RcbOd0RVEP8f5GRu9ounkx8Bilc8Xr46BAzJCgyR9BLeXhK4dJ8AhATMjtrdYd2qcTFNRQ9TGAv6z70cEsAwqXuVoAN7KiRBd5o/GtBf4fCy+VAhRFOOQjy0NqA/iGpckuWs0LsiqyqHmMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EjmlpJfC; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Apr 2025 20:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744243504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WE0GCsoc/2sLbHf8Sfbw+FhQV6ppZIJBcKSBbwzjqo=;
	b=EjmlpJfCSvz/brHJMvMtDYxwZdlC1RUhCw991mn28+pr0WvjNgBpWyIwEO/RSO6iStunR/
	HOtY/ZKtQ39isyG7DHtmm4FnCS6rJBxWJhyY9m/9I0KgjgebGJsihwa1zcSRLNE/nXcChm
	rNzEQq9pGhSUZnqPTLYomLZi9y2CIQ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Integral <integral@archlinuxcn.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: indent error messages of invalid compression
Message-ID: <xi4xo3didwhs35asguon3opf7gfp2o2h5vqb25l354eibomdnw@2af4auvqen7f>
References: <sd4nbvk24h5aiooqkzczyqfc33t7triwlsrp4neyd6wovmodak@lwvvuurcehbu>
 <20250408103129.61829-1-integral@archlinuxcn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408103129.61829-1-integral@archlinuxcn.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 08, 2025 at 06:31:29PM +0800, Integral wrote:
> This patch uses printbuf_indent_add_nextline() to set a consistent
> indentation level for error messages of invalid compression.
> 
> In my previous patch [1], the newline is added by using '\n' in
> the argument of prt_str(). This patch replaces prt_str() with
> prt_printf() to make indentation level work correctly.
> 
> [1] Link: https://lore.kernel.org/20250406152659.205997-2-integral@archlinuxcn.org
> 
> Signed-off-by: Integral <integral@archlinuxcn.org>

Applied

> ---
>  fs/bcachefs/compress.c | 4 ++--
>  fs/bcachefs/opts.c     | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/compress.c b/fs/bcachefs/compress.c
> index d68c3c7896a3..1bca61d17092 100644
> --- a/fs/bcachefs/compress.c
> +++ b/fs/bcachefs/compress.c
> @@ -714,7 +714,7 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
>  
>  	ret = match_string(bch2_compression_opts, -1, type_str);
>  	if (ret < 0 && err)
> -		prt_str(err, "invalid compression type\n");
> +		prt_printf(err, "invalid compression type\n");
>  	if (ret < 0)
>  		goto err;
>  
> @@ -729,7 +729,7 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
>  		if (!ret && level > 15)
>  			ret = -EINVAL;
>  		if (ret < 0 && err)
> -			prt_str(err, "invalid compression level\n");
> +			prt_printf(err, "invalid compression level\n");
>  		if (ret < 0)
>  			goto err;
>  
> diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
> index cd7b0cd293c7..f35fde896253 100644
> --- a/fs/bcachefs/opts.c
> +++ b/fs/bcachefs/opts.c
> @@ -365,6 +365,7 @@ int bch2_opt_parse(struct bch_fs *c,
>  		   struct printbuf *err)
>  {
>  	ssize_t ret;
> +	printbuf_indent_add_nextline(err, 2);
>  
>  	switch (opt->type) {
>  	case BCH_OPT_BOOL:
> 
> base-commit: 4d37602fceff942694069cf33cc55863277bd1c2
> -- 
> 2.49.0
> 

