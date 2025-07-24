Return-Path: <linux-kernel+bounces-743983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECFB10670
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370FA17E41F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D02D5C9F;
	Thu, 24 Jul 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmKbow0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B2BEC2A;
	Thu, 24 Jul 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349387; cv=none; b=tGFvweOPHz17+UKvv/XBD25rgg+CP12LETJltvBb4xc4nqyFl7B+SnBi+/mcwA2BY7eA2Daodb9ztQjJQGw8dzNz+zJy/IYHqlAa4SYpD5mMxAAewUyzlhqK/6u9E2GCTfjURemWDzWxE9twamuP2OKrQiGIJzLi9A7OZR6Jt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349387; c=relaxed/simple;
	bh=hJ+qDTjJTutUzkw5F3UrGnP8vVbU5na5wyZWNxpsKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxH3/Q2SPV5rPu2xKSVaQWSH800EBtIbMSRmlaIx2yG0fjtO+yE3iee7dI76/449SM9DB9fGEQkdaV6Klo5X+SqK6oL78Y4PHl0/MfHseo11RKHS+ruuUA/9Tuw6ogoGzOPmHBjLGRGWYu7YiXrDdkTrjKcoFkZunFz45v9WIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmKbow0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9704EC4CEF8;
	Thu, 24 Jul 2025 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753349387;
	bh=hJ+qDTjJTutUzkw5F3UrGnP8vVbU5na5wyZWNxpsKWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmKbow0pEuWtmE5lXRHXQGkeC/REs3KcBRsJT62SHHApV+jwD+2dUAnIMGFJSaaoR
	 gELi6EbktCobQzqqNfaAvgFtSkVZO6Wqxb/4DKnAutOi6/zMDJPigcUC5VIW4swmMw
	 glSTChbXdT0d9CBQIPNFm98lCbQpEMox7b1lqwog=
Date: Thu, 24 Jul 2025 11:29:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bruce Qin <bqn9090@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix if-statement alignment and line
 continuation in rtw_ap.c
Message-ID: <2025072409-promoter-shame-8105@gregkh>
References: <20250720173444.33407-1-bqn9090@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720173444.33407-1-bqn9090@gmail.com>

On Sun, Jul 20, 2025 at 07:34:44PM +0200, Bruce Qin wrote:
> This patch addresses three checkpatch-reported style issues in a multiline
> if-statement:
> 
> - Moved '&&' to the end of the previous line to follow logical continuation style
> - Fixed indentation to align with the opening parenthesis of the expression
> - Avoided ending a line with an open parenthesis '('
> 
> These changes improve readability and conform to Linux kernel coding conventions.
> No functional changes.
> 
> Signed-off-by: Bruce Qin <bqn9090@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 383a6f7c06f4..838d2feed883 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -258,10 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
>  		} else {
>  			/* TODO: Aging mechanism to digest frames in sleep_q to */
>  			/* avoid running out of xmitframe */
> -			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
> -				&& padapter->xmitpriv.free_xmitframe_cnt < ((
> -					NR_XMITFRAME / pstapriv->asoc_list_cnt
> -				) / 2)
> +			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
> +			    padapter->xmitpriv.free_xmitframe_cnt <
> +					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2)
>  			)

Why is this ")" on this line down here?  Shouldn't it be on the previous
one?

thanks,

greg k-h

