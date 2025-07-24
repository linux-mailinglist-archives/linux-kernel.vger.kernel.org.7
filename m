Return-Path: <linux-kernel+bounces-744790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023D8B110FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C072D4E4BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD3284B25;
	Thu, 24 Jul 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQMy5/xO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655A2B9B9;
	Thu, 24 Jul 2025 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382347; cv=none; b=mRw9vwL8b1TOYYnyYNIki3cw5SHdpLCf/mM3GcxKlGgmgMVE/WIIag5KB1Ei9VAdrKsDaxXD3NPtbkWZfu+H+wDk5kGgU6h2DBGgT35TgBx0MYVsnMfCuwTuD6SBVcd1uAi1p3J7Bng465Ys7zCuH9VJyJpQjtby9huu9OXt6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382347; c=relaxed/simple;
	bh=bDEFCr2xwwwnCQ8jIyBlnF++v/ngvfb1dqqjQ+ZrSnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfOWfT3cdmtSXFZM0LJM4EBYkw+Dwsdc2BSFHpnnXUj8lXRp3Xc466ywwGFzi2ChG6ryZqeaUwZPFky/sQCsg98e6Kl1O0uHSosYWfiaQ0IX1PFQ66A0Fdw3BknHqxlnPnpTTwjwVFPYviuYY9be40M5qGpDQstRi0it8vrb+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQMy5/xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFDC4CEED;
	Thu, 24 Jul 2025 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753382346;
	bh=bDEFCr2xwwwnCQ8jIyBlnF++v/ngvfb1dqqjQ+ZrSnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQMy5/xOFtzSXCTpfZ6VlPjxEfW6BuU2z1ipDM1Zx38Atqf6qioUG9deSq+wbRPn2
	 7BonXuwu6GSnD0QlrV6kjnXUiJOqiVmK/nKfU0XUES/4OGB7z3d917On1Le7+/BP/P
	 Irnp0sGM+3EuG6vEaak51+fMXyfUqRk2krgeX2Nw=
Date: Thu, 24 Jul 2025 20:38:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bruce Qin <bqn9090@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix if-statement alignment and
 line continuation in rtw_ap.c
Message-ID: <2025072444-irrigate-cardstock-60a8@gregkh>
References: <2025072409-promoter-shame-8105@gregkh>
 <20250724172034.44679-1-bqn9090@gmail.com>
 <20250724172034.44679-2-bqn9090@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724172034.44679-2-bqn9090@gmail.com>

On Thu, Jul 24, 2025 at 07:17:14PM +0200, Bruce Qin wrote:
> This patch fixes several style issues in a multiline if-statement:
> 
> - Moved '&&' to the end of the previous line to follow logical continuation style
> - Fixed indentation to align with the opening parenthesis of the expression
> - Avoided ending a line with an open parenthesis '('
> - Moved closing ')' to the end of the last expression line (as suggested by the maintainer)
> 
> These changes improve readability and conform to Linux kernel coding conventions.
> No functional changes.
> 
> Signed-off-by: Bruce Qin <bqn9090@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 383a6f7c06f4..c652e0cd35f3 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -258,11 +258,9 @@ void expire_timeout_chk(struct adapter *padapter)
>  		} else {
>  			/* TODO: Aging mechanism to digest frames in sleep_q to */
>  			/* avoid running out of xmitframe */
> -			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt)
> -				&& padapter->xmitpriv.free_xmitframe_cnt < ((
> -					NR_XMITFRAME / pstapriv->asoc_list_cnt
> -				) / 2)
> -			)
> +			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
> +			    padapter->xmitpriv.free_xmitframe_cnt <
> +					((NR_XMITFRAME / pstapriv->asoc_list_cnt) / 2))
>  				wakeup_sta_to_xmit(padapter, psta);
>  		}
>  	}
> -- 
> 2.43.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

