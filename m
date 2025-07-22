Return-Path: <linux-kernel+bounces-740395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98BFB0D3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ED43A4827
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8652E5B0E;
	Tue, 22 Jul 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+DYrc1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985612D3EE6;
	Tue, 22 Jul 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169862; cv=none; b=p1wkTrXmydvKuJbQ4aKgRoVHA4SuUI9NzW7K5AZuiJWZZeUmNRnJhs34fVlOeslc3MBsJNya4YdG6zgqlHNivPOSXeZwAAG1zELyfLNVuFSguwK64NteUz5XD5/XnoDJI9BcYMwOd4/1Emnwi2cLfY+hqwoDD25/sBSNoy1+D0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169862; c=relaxed/simple;
	bh=wQrJ9UHPZYFTmcGKkglIDRkfLqzGfb57w5Nsxc2fB6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olY5AX8z6FRMoYEIbtcU88LRkrY617I6AKP3P3V5jz5LdWyu0Zn2QDABcsj2czmOTmlTNqQvhDGaE9sklLJfMyarcRSAGVqeQ541OUgiqQJPIQT7NUaGDZbAwpwVnd1vBj8jYL/k4KrT5NUAtuDeLr4PeX0OsnX2pdN/b5MW3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+DYrc1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57DEC4CEEB;
	Tue, 22 Jul 2025 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753169862;
	bh=wQrJ9UHPZYFTmcGKkglIDRkfLqzGfb57w5Nsxc2fB6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+DYrc1rZ2uYtfNP+SOFC7CbIfLhffy+Vmgjs1nFMwCk+C4ZJragAwK4ItUvuMHIP
	 vWl8GNW6Q9Hxq/nCACy/eR5rEXHoo8eToi5cuU4Bl3Rnd6FRmXYERWmOXh1Q/beUpf
	 Od03LNRefmETRc7sTFOlBzEQLqCLb0vC4QwFRX8s=
Date: Tue, 22 Jul 2025 09:37:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ali Nasrolahi <a.nasrolahi01@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 2/2] staging: rtl8723bs: fix comment style and
 formatting in osdep_service.c
Message-ID: <2025072233-duh-atrium-2ff5@gregkh>
References: <20250721164343.8395-1-A.Nasrolahi01@gmail.com>
 <20250721164343.8395-3-A.Nasrolahi01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721164343.8395-3-A.Nasrolahi01@gmail.com>

On Mon, Jul 21, 2025 at 08:13:43PM +0330, Ali Nasrolahi wrote:
> Signed-off-by: Ali Nasrolahi <A.Nasrolahi01@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> index a00f9f0c85c..60c3da009a5 100644
> --- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> +++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
> @@ -7,9 +7,9 @@
>  #include <drv_types.h>
>  
>  /*
> -* Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
> -* @return: one of RTW_STATUS_CODE
> -*/
> + * Translate the OS dependent @param error_code to OS independent RTW_STATUS_CODE
> + * @return: one of RTW_STATUS_CODE
> + */
>  inline int RTW_STATUS_CODE(int error_code)
>  {
>  	if (error_code >= 0)
> @@ -152,7 +152,6 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
>  		kfree(ori);
>  }
>  
> -
>  /**
>   * rtw_cbuf_full - test if cbuf is full
>   * @cbuf: pointer of struct rtw_cbuf
> @@ -204,6 +203,7 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
>  void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
>  {
>  	void *buf;
> +
>  	if (rtw_cbuf_empty(cbuf))
>  		return NULL;
>  
> @@ -226,7 +226,8 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
>  	cbuf = rtw_malloc(struct_size(cbuf, bufs, size));
>  
>  	if (cbuf) {
> -		cbuf->write = cbuf->read = 0;
> +		cbuf->read = 0;
> +		cbuf->write = 0;
>  		cbuf->size = size;
>  	}
>  
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

