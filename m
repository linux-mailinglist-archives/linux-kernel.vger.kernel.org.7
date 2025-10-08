Return-Path: <linux-kernel+bounces-845314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B7BC45B4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9EB34EF537
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4332F5A3F;
	Wed,  8 Oct 2025 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/XOLhjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501EE183CA6;
	Wed,  8 Oct 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919886; cv=none; b=V0yq9gT16KkzFLVENpxbccECS6IyO31pb2xweXh72hZZoPVI8xfT3jyKZdBvO05jTFad6bOgHndhQqQyyjtWZzkQ0/vs7cVbaoA0M7k1vO2lYKSyltU8IzbtA2iuu0SYSsvXvuOC6sHYRSMggWhYTR7ZGGwokUNcc97kBhmKkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919886; c=relaxed/simple;
	bh=Ny8qsYWzCWkwa/+eWir34ici8htTmjY5B0egy+XBGDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTGddlz5oAtTfthjb9STMMJC7kmW0iW2gGBGfOgJPJJ5c75o6Ge7XNmVsluSX27f1aUVEu420BmxabPVQARPdcfcVKeLkB+sBa3xNcMqFbDLJWiZb5K32dtzJcHyIe5kEnLZbjaxLZ26Qc1ABUtcjP+wPz0D28f8DbT4Y+eOIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/XOLhjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5F7C4CEF4;
	Wed,  8 Oct 2025 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759919885;
	bh=Ny8qsYWzCWkwa/+eWir34ici8htTmjY5B0egy+XBGDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/XOLhjkbT0d+ioqN56mJE9JiRHx8HvR9dQjM192Dg6iwwVSyZNzxGXXZrHsjqowF
	 ku9+myVIGXIbWom33BzDIR1f4V9YP1l+EQFHUFVZUQzfyUDV3NTRrBC4j+/WLdZpRT
	 xlxPdDB1xpBgrVdCg25aQNnSkVk2zG4dygQAM+kY=
Date: Wed, 8 Oct 2025 12:38:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ankit@web.codeaurora.org, Bhalani@web.codeaurora.org,
	er.ankitbhalani@gmail.com
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	abrahamadekunle50@gmail.com, julia.lawall@inria.fr,
	viro@zeniv.linux.org.uk, dan.carpenter@linaro.org,
	zhaochenguang@kylinos.cn, straube.linux@gmail.com, mingo@kernel.org,
	tglx@linutronix.de, philipp.g.hortmann@gmail.com,
	vivek.balachandhar@gmail.com, rodrigo.gobbi.7@gmail.com,
	hansg@kernel.org, nathan@kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comment style to match
 kernel coding guidline
Message-ID: <2025100823-outshine-evaluate-3be1@gregkh>
References: <20251001134433.16513-1-er.ankitbhalani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001134433.16513-1-er.ankitbhalani@gmail.com>

On Wed, Oct 01, 2025 at 07:14:33PM +0530, Ankit@web.codeaurora.org wrote:
> From: Ankit Bhalani <er.ankitbhalani@gmail.com>
> 
> Update block comments to follow the Linux kernel coding style
> recommendations. This include:
> 
>  - Ensuring proper formatting and alignment for multi-line
>    comments.
> 
> Signed-off-by: Ankit Bhalani <er.ankitbhalani@gmail.com>
> ---
>  .../staging/rtl8723bs/core/rtw_ieee80211.c    |  26 +++--
>  drivers/staging/rtl8723bs/core/rtw_io.c       |  48 ++++-----
>  drivers/staging/rtl8723bs/core/rtw_mlme.c     |  75 ++++++-------
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 102 ++++++++++--------
>  drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  10 +-
>  drivers/staging/rtl8723bs/core/rtw_security.c |  87 +++++++--------
>  .../staging/rtl8723bs/core/rtw_wlan_util.c    |   6 +-
>  7 files changed, 186 insertions(+), 168 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 53d4c113b19c..c31e64600c0a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -132,9 +132,11 @@ u8 *rtw_set_ie(u8 *pbuf,
>  	return pbuf + len + 2;
>  }
>  
> -/*----------------------------------------------------------------------------
> -index: the information element id index, limit is the limit for search
> ------------------------------------------------------------------------------*/
> +/*
> + * ----------------------------------------------------------------------------
> + * index: the information element id index, limit is the limit for search
> + * ----------------------------------------------------------------------------
> + */
>  u8 *rtw_get_ie(u8 *pbuf, signed int index, signed int *len, signed int limit)

This is an odd format for a function comment.  Can you make this look
more "correct"?  All you are describing here is 2 of the variables and
not what the function does at all.

>  /*
> -* Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
> -* @return true:
> -* @return false:
> -*/
> + * Increase and check if the continual_io_error of this @param dvobjprive is larger than MAX_CONTINUAL_IO_ERR
> + * @return true:
> + * @return false:

What does these last 2 lines mean?

Again, if you are going to comment a function, let's use the documented
way to do so.

Same with other changes in this patch.

thanks,

greg k-h

