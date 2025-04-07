Return-Path: <linux-kernel+bounces-592383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15687A7EC82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BA16B1F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 19:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738525525D;
	Mon,  7 Apr 2025 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jsOVmpnK"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDD21B9D4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051412; cv=none; b=S4upMLY9/GStyEJTKta5CYZ6eHmNAuVJ09sphYUNCqZIZ9GibFWnU8TPFhJJX5hprLITFZIYXpYfchxGtAzz+76YR3kbjcFxMmGKjLhjrCYl9ShDHkl+y+CiuqVN3KjZoRw8kxGG8DVzzlNhpAFElWcc0p6zgdZOVY8E/vuQlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051412; c=relaxed/simple;
	bh=lnljChb7wcxaLBJFNWj47BQXsA6kUPFmKlk2DzfAln8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpgwakOllllPf0xoTqeXtour2mIjdyDWKn02se6ycweCVg0mFVL/UOAfIZ2+SExWnRADQuTkLTQeRMSRVDl57PdgvgbFyk0/5A2sJrm3FiCv7DYPYdo7h0kkQ1EWHbnMitySmiHew0X31gIXpSKxdQaiX7hmPU7rjje7RlTjr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jsOVmpnK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 7 Apr 2025 14:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744051407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxD+8tdFNBkK8LaMZPWAhzmEuw4OC9utqjzeSG7HkIw=;
	b=jsOVmpnKmjcXpL/OYE1KmM6v5uQPf6SR1A80eRo0sqs1IvnU1zEM8S8bBcUESO+jInal4x
	U/NUWZkm5XDnlPKdj+WFgGf2QnzdWmWz1/uXDt2TMEJK68wq2rDm9BQUV6bR8dvkL4K6om
	MenXwT2lY1sh/eUkAjafMOxgzhD4RuQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Integral <integral@archlinuxcn.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: indent error messages of invalid compression
Message-ID: <sd4nbvk24h5aiooqkzczyqfc33t7triwlsrp4neyd6wovmodak@lwvvuurcehbu>
References: <20250407174129.251920-3-integral@archlinuxcn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407174129.251920-3-integral@archlinuxcn.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 08, 2025 at 01:41:31AM +0800, Integral wrote:
> This patch uses printbuf_indent_add_nextline() to set a consistent
> indentation level for error messages of invalid compression.
> 
> In my previous patch [1], the newline is added by using '\n' in
> the argument of prt_str(). This patch replaces '\n' with prt_newline()
> to make indentation level work correctly.
> 
> [1] Link: https://lore.kernel.org/20250406152659.205997-2-integral@archlinuxcn.org
> 
> Signed-off-by: Integral <integral@archlinuxcn.org>
> ---
>  fs/bcachefs/compress.c | 12 ++++++++----
>  fs/bcachefs/opts.c     |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/bcachefs/compress.c b/fs/bcachefs/compress.c
> index d68c3c7896a3..a107aa88a875 100644
> --- a/fs/bcachefs/compress.c
> +++ b/fs/bcachefs/compress.c
> @@ -713,8 +713,10 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
>  	level_str = p;
>  
>  	ret = match_string(bch2_compression_opts, -1, type_str);
> -	if (ret < 0 && err)
> -		prt_str(err, "invalid compression type\n");
> +	if (ret < 0 && err) {
> +		prt_str(err, "invalid compression type");
> +		prt_newline(err);
> +	}
>  	if (ret < 0)
>  		goto err;
>  
> @@ -728,8 +730,10 @@ int bch2_opt_compression_parse(struct bch_fs *c, const char *_val, u64 *res,
>  			ret = -EINVAL;
>  		if (!ret && level > 15)
>  			ret = -EINVAL;
> -		if (ret < 0 && err)
> -			prt_str(err, "invalid compression level\n");
> +		if (ret < 0 && err) {
> +			prt_str(err, "invalid compression level");

You can just change this to prt_printf() or prt_str_indented(), that'll
interpret the \n correctly

> +			prt_newline(err);
> +		}
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

