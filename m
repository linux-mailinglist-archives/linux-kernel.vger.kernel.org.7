Return-Path: <linux-kernel+bounces-725214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C465AFFC11
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D4C179047
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E428C5BE;
	Thu, 10 Jul 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zrAHWqK0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC1A28BAA4;
	Thu, 10 Jul 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135709; cv=none; b=I/KFGAbiUzRVfuqmTnz7tho3QjSY+gOvqYAnh5lyjmVlwuNnrdh+7zBawSJYIKbppXiKVQmZJ8wPU783Tz1tveZimUA6uok03WmTDyxREn4nf0gmENhMajgUwMPQkA86iEaA705ujMVjR48PgIFIBx0oSn0ALpzHxrX3jr82FD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135709; c=relaxed/simple;
	bh=H/Hd8HddUy8afmkqUiQOVW3MfJzPIzVt1rLSzQxpsog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3PkXW08fGLv/8GehXgkMXDY6QVodx+5qRD4xZTyWzciYrHBVBegSu2KOa4HALAU+Ww2uiR9k+SXP5xsXajlEZzDnunznI1S1l4vv7NJjWOe8OOrtjESDHOuBdwqB9ABzrD6CPC+wLFmiK/3Pf8e8HEktODorE6wXHFIx8tj8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zrAHWqK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41112C4CEE3;
	Thu, 10 Jul 2025 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752135708;
	bh=H/Hd8HddUy8afmkqUiQOVW3MfJzPIzVt1rLSzQxpsog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zrAHWqK0LwR5i/BQORBn9fRVMu/CZKPfauqUx1D/j7GyHBP+PJXIiVzrn2qimtrOa
	 TSkUFYQ7+Q+uU8rAClj/Iv2uVu+4RnffLZEJqemmvJX8C9lkKIo3Cqmvw+E08LptMs
	 c+jcWEvecLNxfKqkMixelqre+ps4FuqFG2FPpvfg=
Date: Thu, 10 Jul 2025 10:21:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: jackysliu <1972843537@qq.com>
Cc: viro@zeniv.linux.org.uk, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: functioni: Fix a oob problem in rndis
Message-ID: <2025071026-fanciness-size-1d5d@gregkh>
References: <tencent_8E3F0D0AD7E5F6DC1F3009EA1DB7391A8505@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_8E3F0D0AD7E5F6DC1F3009EA1DB7391A8505@qq.com>

On Thu, Jul 10, 2025 at 04:14:18PM +0800, jackysliu wrote:
> A critical out-of-bounds memory access vulnerability exists in the RNDIS
> (Remote Network Driver Interface Specification) implementation.

It's not really "critical" as the specification never claims to be
secure at all, and we have said for years that you should never run this
on system that you do not fully trust (host and client.)

> The vulnerability stems from insufficient boundary validation when
> processing SET requests with user-controlled InformationBufferOffset
> and InformationBufferLength parameters.
> 
> The vulnerability can be fixed by adding addtional boundary checks
> 
> Signed-off-by: jackysliu <1972843537@qq.com>

Please use a full name, not just a one word alias.

And what commit id does this fix?

> ---
>  drivers/usb/gadget/function/rndis.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index afd75d72412c..cc522fb4c06c 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -641,7 +641,8 @@ static int rndis_set_response(struct rndis_params *params,
>  	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
>  	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
>  	    (BufOffset > RNDIS_MAX_TOTAL_SIZE) ||
> -	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
> +	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE) ||
> +		(BufOffset + BufLength+8 > RNDIS_MAX_TOTAL_SIZE))
>  		    return -EINVAL;
>  
>  	r = rndis_add_response(params, sizeof(rndis_set_cmplt_type));
> -- 
> 2.43.5
> 

As I asked before, please run scripts/checkpatch.pl on your patch and
fix the issue it found.  Can you do all of this and send a v2 patch?

thanks,

greg k-h

