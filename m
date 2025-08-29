Return-Path: <linux-kernel+bounces-791118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACAFB3B229
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1391C27B96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 04:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843611E1E1C;
	Fri, 29 Aug 2025 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yAapb0he"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584B30CD9F;
	Fri, 29 Aug 2025 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756442092; cv=none; b=AtvAEj24T7dtKfxsTPgEt3cPkoVMEFXJlpDEIapqmhqT/zuyQQPRcu47NRHtBeozuGE2IqAMFE/kHOo9wHxjKgzXUbjx1ajsskwxDreFpTaYXb6vblEmMOhmxoY1JEI01/nPnx7DgByWYv2pzqENlgEV94wyw/PqhIb2qJwMSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756442092; c=relaxed/simple;
	bh=VlQ3Mz+r5uMRCf+BfLcw3ZUlAXPfXkZczHUyPQ+xhOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUgflCNg6JcT1KVgButhSKkp7b4Os6KGexiwlcsNVjRYKLC8b4d4xT4PzH6D4m/sVRO/psqZ6GwK6kuOHW1maQM5vA+/48YLmY39b7gdclRy84IX0wgVESF7276Yqxx2cRimeKZEuwAetcvyQh/c4p2Sv9UCjJ8pFvjGBHaqS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yAapb0he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA35AC4CEF0;
	Fri, 29 Aug 2025 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756442091;
	bh=VlQ3Mz+r5uMRCf+BfLcw3ZUlAXPfXkZczHUyPQ+xhOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yAapb0heZRx+LSySIAoIu5qkfrdxo7RAi3c3ma6c86paGH1iQxBQfApyi6hN6EDkB
	 CwFCpsHj1SDR9ahTqYiLgEojUyjGfmVh+P1OAEOcRH3/zSSJgf1amyECveC3rba1T2
	 wYvQpRk4iX/QbKsUrIlr6rwzd/ibpKF7rt3EJRw8=
Date: Fri, 29 Aug 2025 06:34:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] usb: storage: realtek_cr: Simplify residue
 calculation in rts51x_bulk_transport()
Message-ID: <2025082922-almanac-derby-632d@gregkh>
References: <20250828162623.4840-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828162623.4840-3-thorsten.blum@linux.dev>

On Thu, Aug 28, 2025 at 06:26:24PM +0200, Thorsten Blum wrote:
> Simplify the calculation of 'residue' in rts51x_bulk_transport() and
> avoid unnecessarily reassigning 'residue' to itself.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/usb/storage/realtek_cr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
> index 2a6c7c567e1c..758258a569a6 100644
> --- a/drivers/usb/storage/realtek_cr.c
> +++ b/drivers/usb/storage/realtek_cr.c
> @@ -261,8 +261,8 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
>  	 * try to compute the actual residue, based on how much data
>  	 * was really transferred and what the device tells us
>  	 */
> -	if (residue)
> -		residue = residue < buf_len ? residue : buf_len;
> +	if (residue > buf_len)
> +		residue = buf_len;
>  
>  	if (act_len)
>  		*act_len = buf_len - residue;
> -- 
> 2.50.1
> 
> 

Why is this a RESEND?  What happened to the first one?

thanks,

greg k-h

