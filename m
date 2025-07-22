Return-Path: <linux-kernel+bounces-740393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF02B0D3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5483A528B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B7E2E49BA;
	Tue, 22 Jul 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FnyQufKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C092E49A4;
	Tue, 22 Jul 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169854; cv=none; b=pOdYdAQwdCD80Fc+LpVwO+dEPxSh3mI7Tt2nw5PT+2Dxn4jhcyh+D7m6msQBfAcSt21zH1sVeXWWOi6W/vnVlsISsNRLoH2f2SnxZx0lx2lk9aYBdEDNSlqx58lwBJeVMEpeuqvwJeaa5CpZwp1w3oqJTo2x7jkVuPnSXLGjF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169854; c=relaxed/simple;
	bh=2EUwiNyXmmuhM5rxIewdixPcv5XvuZw0V+Q11YUN8iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHxQ1cUXkn9NWOyk3ffSQvKER+Wc4/382gjRBFFtxRUXI2ewPKAOYECa7AEiHsy2rV7vXUeEDL4l9C5sS2SAlxetbCCqEzHxk0mW7tcTgZPG040z5p71GnEIkmmjiBwJHyQMMBQxagFxUIcRTiESaRlaF00XaG0Js7u2jfGv4Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FnyQufKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5499FC4CEEB;
	Tue, 22 Jul 2025 07:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753169853;
	bh=2EUwiNyXmmuhM5rxIewdixPcv5XvuZw0V+Q11YUN8iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnyQufKowC21Htmo5nnwxdLogCRpYRVDCODJB++AWugSnd3RGHPiXUniayZXYHzT7
	 SIQ2CwYiGGvJKJRdYay6J9c7vqsrbGz5TJVT70+5xEYqBrof32dc5HpLV9YSm+THVs
	 qYAr1Qwr5ZffHrm0UgneP3hLcxMFgU7CxHRKl88A=
Date: Tue, 22 Jul 2025 09:37:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali Nasrolahi <a.nasrolahi01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/2] staging: rtl8723bs: fix comment formatting in
 basic_types.h
Message-ID: <2025072209-retract-rocking-c69d@gregkh>
References: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
 <20250721164343.8395-2-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721164343.8395-2-A.Nasrolahi01@gmail.com>

On Mon, Jul 21, 2025 at 08:13:42PM +0330, Ali Nasrolahi wrote:
> Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
> ---
>  drivers/staging/rtl8723bs/include/basic_types.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/basic_types.h b/drivers/staging/rtl8723bs/include/basic_types.h
> index 57bb717327c..e2f203910be 100644
> --- a/drivers/staging/rtl8723bs/include/basic_types.h
> +++ b/drivers/staging/rtl8723bs/include/basic_types.h
> @@ -26,7 +26,7 @@
>   *	1. Read/write packet content.
>   *	2. Before write integer to IO.
>   *	3. After read integer from IO.
> -*/
> + */
>  
>  /*  */
>  /*  Byte Swapping routine. */
> @@ -94,7 +94,7 @@
>  #define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
>  	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
>  
> -/*Description:
> +/* Description:
>   * Return 4-byte value in host byte ordering from
>   * 4-byte pointer in little-endian system.
>   */
> @@ -105,11 +105,10 @@
>  #define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
>  	(EF1BYTE(*((u8 *)(__pstart))))
>  
> -/*  */
> -/* 	Description: */
> -/* 		Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to */
> -/* 		4-byte value in host byte ordering. */
> -/*  */
> +/* Description:
> + *	Translate subfield (continuous bits in little-endian) of 4-byte value in litten byte to
> + *	4-byte value in host byte ordering.
> + */
>  #define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
>  	(\
>  		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
> -- 
> 2.50.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

