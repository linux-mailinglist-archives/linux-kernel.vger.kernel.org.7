Return-Path: <linux-kernel+bounces-590080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A81A7CE6B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B8D3AB84E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F965224F6;
	Sun,  6 Apr 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DsXbdsi1"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D621883F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Apr 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743948723; cv=none; b=O1lzUW+ej53y5xhnLDlmkqt7qd2oYtfCXOomGjKyZFhJtPOwKy5F9nsBkYPAjYJ53Pm6BqAzg4Nns17/M5Syk6Jh3mNQo8uVEGC56nv6h/f+Ny3Z0aL2DLUll/1+Qv3sNw7d/A8wBg6ibFqdchLNFTDPhvdR7l0cCDZs0+BhIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743948723; c=relaxed/simple;
	bh=lqZbfkbk0ZcA2LIuruKYg/F+tzBLHT//KF3zOSp5VXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NApXx5utw8Iw/j/kEwuE0GaagjrW0X5sQhzzBDubcYpzxoK4Zt99gcD2x6CyyJSu4spBbORSy/+tsJasGVjYP99TwVYlvd+o0ZVp1xfwZST532Q2HvkMaX+uXewpp+9xAQuh+g81C+9a6EL6ie/3QByIdUsSVM/Xz9pYl0L0ZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DsXbdsi1; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 6 Apr 2025 10:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743948718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pWF83rzDf1eFbwOMCuQAlihrrS/Vai0y6L2bpP28ty8=;
	b=DsXbdsi1+soakr/Bj8mmB2XEYgYjZuirj4x2fqzYuyKqzYnvdJhPZRCXllmqLVEpETamBb
	LTaT0Ie3gaRtZZUfyLDYdsJiroLtG8UZKdjOEo3Q607mt4oLMD83sQ0N+3cPtPXRWcaLyN
	MwsZ5/6n33LS+nwT/vyKBgLSiZQtmfA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Integral <integral@archlinuxcn.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: return early for negative values when parsing
 BCH_OPT_UINT
Message-ID: <hepk5mxy7zfr534i4mbqbjr3jzkqytbnfz66lelzcewwu5h47h@df7qq7laaypr>
References: <20250406135929.178583-2-integral@archlinuxcn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406135929.178583-2-integral@archlinuxcn.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 06, 2025 at 09:59:30PM +0800, Integral wrote:
> Currently, when a negative integer is passed as an argument, the error
> message incorrectly states "too big" due to the value being cast to an
> unsigned integer:
> 
>     > bcachefs format --block_size=-1 bcachefs.img
>     invalid option: block_size: too big (max 65536)
> 
> To resolve this issue, return early for negative values before calling
> bch2_opt_validate().
> 
> Signed-off-by: Integral <integral@archlinuxcn.org>

No new -EINVAL in kernel code :)

> ---
>  fs/bcachefs/opts.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
> index e64777ecf44f..31f90c177c6c 100644
> --- a/fs/bcachefs/opts.c
> +++ b/fs/bcachefs/opts.c
> @@ -360,9 +360,15 @@ int bch2_opt_parse(struct bch_fs *c,
>  			return -EINVAL;
>  		}
>  
> -		ret = opt->flags & OPT_HUMAN_READABLE
> -			? bch2_strtou64_h(val, res)
> -			: kstrtou64(val, 10, res);
> +		if (*val != '-') {
> +			ret = opt->flags & OPT_HUMAN_READABLE
> +			    ? bch2_strtou64_h(val, res)
> +			    : kstrtou64(val, 10, res);
> +		} else {
> +			prt_printf(err, "%s: must be a non-negative number", opt->attr.name);
> +			return -EINVAL;
> +		}
> +
>  		if (ret < 0) {
>  			if (err)
>  				prt_printf(err, "%s: must be a number",
> -- 
> 2.49.0
> 

