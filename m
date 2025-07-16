Return-Path: <linux-kernel+bounces-733023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E0EB06F09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACD750410B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE128B407;
	Wed, 16 Jul 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N4cGcm2h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC44A11;
	Wed, 16 Jul 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651306; cv=none; b=g7aMfnENonmhWclHP6dPGZzTIR5xaaJWZXTZM6azPo57XwAisK5+ILnYb5x7EZoRKjZEpjaliZQf/EjsjFaA6Yqrcg849BCKx6KPFgSwMx73EJSRbks26CHJrPqu2JapZCIEFwknxfI4wLQsXQsnBUmBI/YtIZAtNIxFF1ynGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651306; c=relaxed/simple;
	bh=0tuKormBsP6swmsUBQoxnh8G7NopetuC3C1pYAEYNqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzK5J6HhgoB8K9WWi8DskFajtoy/IERf1hKtbs3Rs1BvdvAOU4/g0oPuKg4to7QTnicAG9UZmAoOHVveDWLGPnT3+skS9RtE/D6Y/bX8R5ApMwMMwG4nyqai1WOqHbfKHyCUvzWGgQttMqI8hh4Jw/xiuhZKL0jWRtLRFWmhnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N4cGcm2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6047EC4CEF0;
	Wed, 16 Jul 2025 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752651305;
	bh=0tuKormBsP6swmsUBQoxnh8G7NopetuC3C1pYAEYNqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4cGcm2hKCV43g0MpO8JciXX3TNMVb5fuEtEGqkgIvdgWhx0HoLGqHOO+jzxhVhUU
	 6lnv+TlezJF2un8EWNxvDcUDS9k7cadcHTO+8FwhjL6zR0+mEeOgzosnSNROs0vqzv
	 wsmiFFPkNciO5nqORekL0gmfXUahsA+JWYXo+biI=
Date: Wed, 16 Jul 2025 09:35:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix multiple checkpatch warnings in
 rtl8723b_cmd.c
Message-ID: <2025071640-audibly-sketch-9d55@gregkh>
References: <20250716041236.61270-1-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716041236.61270-1-ignacio.pena87@gmail.com>

On Wed, Jul 16, 2025 at 12:12:36AM -0400, Ignacio Peña wrote:
> Fix the following checkpatch warnings:
> - Comparisons should place the constant on the right side
> - Braces {} are not necessary for single statement blocks
> - Block comments should align the * on each line
> - No space before tabs
> 
> These are coding style fixes that improve code readability.
> 
> Signed-off-by: Ignacio Peña <ignacio.pena87@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c | 40 ++++++++++----------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
> index 56526056d..4f33f4f0c 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
> @@ -24,9 +24,8 @@ static u8 _is_fw_read_cmd_down(struct adapter *padapter, u8 msgbox_num)
>  
>  	do {
>  		valid = rtw_read8(padapter, REG_HMETFR) & BIT(msgbox_num);
> -		if (0 == valid) {
> +		if (valid == 0)
>  			read_down = true;
> -		}
>  	} while ((!read_down) && (retry_cnts--));
>  
>  	return read_down;
> @@ -35,13 +34,13 @@ static u8 _is_fw_read_cmd_down(struct adapter *padapter, u8 msgbox_num)
>  
>  
>  /*****************************************
> -* H2C Msg format :
> -*| 31 - 8		|7-5	| 4 - 0	|
> -*| h2c_msg	|Class	|CMD_ID	|
> -*| 31-0						|
> -*| Ext msg					|
> -*
> -******************************************/
> + * H2C Msg format :
> + * | 31 - 8		|7-5	| 4 - 0	|
> + * | h2c_msg	|Class	|CMD_ID	|
> + * | 31-0						|
> + * | Ext msg					|
> + *
> + ******************************************/
>  s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
>  {
>  	u8 h2c_box_num;
> @@ -57,13 +56,11 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
>  	if (mutex_lock_interruptible(&(adapter_to_dvobj(padapter)->h2c_fwcmd_mutex)))
>  		return ret;
>  
> -	if (!pCmdBuffer) {
> +	if (!pCmdBuffer)
>  		goto exit;
> -	}
>  
> -	if (CmdLen > RTL8723B_MAX_CMD_LEN) {
> +	if (CmdLen > RTL8723B_MAX_CMD_LEN)
>  		goto exit;
> -	}
>  
>  	if (padapter->bSurpriseRemoved)
>  		goto exit;
> @@ -80,7 +77,7 @@ s32 FillH2CCmd8723B(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8 *pCmd
>  		else {
>  			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, 3);
>  			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer+3, CmdLen-3);
> -/* 			*(u8 *)(&h2c_cmd) |= BIT(7); */
> +/* *(u8 *)(&h2c_cmd) |= BIT(7); */
>  		}
>  
>  		*(u8 *)(&h2c_cmd) |= ElementID;
> @@ -438,13 +435,14 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
>  
>  		}
>  
> -/* offload to FW if fw version > v15.10
> -		pmlmeext->DrvBcnEarly = 0;
> -		pmlmeext->DrvBcnTimeOut =7;
> -
> -		if ((pmlmeext->DrvBcnEarly!= 0Xff) && (pmlmeext->DrvBcnTimeOut!= 0xff))
> -			u1H2CPwrModeParm[H2C_PWRMODE_LEN-1] = BIT(0) | ((pmlmeext->DrvBcnEarly<<1)&0x0E) |((pmlmeext->DrvBcnTimeOut<<4)&0xf0) ;
> -*/
> +/*
> + * offload to FW if fw version > v15.10
> + *		pmlmeext->DrvBcnEarly = 0;
> + *		pmlmeext->DrvBcnTimeOut =7;
> + *
> + *		if ((pmlmeext->DrvBcnEarly!= 0Xff) && (pmlmeext->DrvBcnTimeOut!= 0xff))
> + *			u1H2CPwrModeParm[H2C_PWRMODE_LEN-1] = BIT(0) | ((pmlmeext->DrvBcnEarly<<1)&0x0E) |((pmlmeext->DrvBcnTimeOut<<4)&0xf0) ;
> + */
>  
>  	}
>  
> -- 
> 2.39.5 (Apple Git-154)
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

