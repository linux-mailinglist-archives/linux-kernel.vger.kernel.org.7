Return-Path: <linux-kernel+bounces-854702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A7EBDF28D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D98D4F5F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6FA2D2389;
	Wed, 15 Oct 2025 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="iZ4ozkgq"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4E27E074
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539884; cv=none; b=PbIFy+X7qpR51uhyQLwSYBYwHNmpFHLb3sCChUHFDDEcnBLY+YMz9o85Ca0iHAsj7ANgeYKNbiC2lhhv8Aj5uEDGJE6q6ywYNv67Ibu5cNLUokzyNH8cFSS3XRzJBoc10hEUWqy8zCB+QSf/eYsNnsQBhEtJ9mcVQZydb6m1u4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539884; c=relaxed/simple;
	bh=hrGvM3Qk7r7tukv0tdWGtDReqUMPUw8ee1FwVTWSb+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7FLwg6HjbsIqp7QyrdZnazXoNxi4KRQSaYoBQdRUK/Iqhh1G7BpIMkgrtaNipq44qBvYD9DElIu/TFEB3o5PjoBAdKhXPq+TrfBY6hhsY7lgfQ4NVlcco5tyH8q3whGBQM1fCsYxNgBr9sY/glnNEx+VQSw4/DkCdlit+TQNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=iZ4ozkgq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-879b99b7ca8so102269966d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760539881; x=1761144681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Adpa7m8fOG05p6QgITi5PnCHwpZCCsUy3a+V0Uam0mo=;
        b=iZ4ozkgq/bhM4uBCnxREoEX00tSDtzsxVdOVWtE8/uJ1Px1T9ajaw335OwdFsJlAE/
         FSd5zOux+EHFA5bBcnHEqus/C21Uz4G0rgH5m1xBWSbcE3MT7iPa9/9+nZWYvdZYQmzW
         eFM9Afg0h6y9tnUa7F3tdcDJS770IJiP8KY+10xmZGZK4fOAj1gitvqXDD0zZGzlFNUO
         LAU2ZNNNx8WDrQCrKZl7Fl/ta6R0v6T9ZshJSr++Tg+8ZgIAlyXKQ9pbQQFm38lmqEV0
         CM0qGZWBwd3pbnixm+1cC3R0GgGIPogRfXbf8Sivl5kvjZdTIb3HRPmS6uniUPVyoHqh
         kqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539881; x=1761144681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adpa7m8fOG05p6QgITi5PnCHwpZCCsUy3a+V0Uam0mo=;
        b=qai//pXzMZ0e9QJuwVe2XkMJJqTAXUNYYa6kDj60cRoh0Bqx58SoaJlo8E+RfEmEsc
         73BfUUy5kRAe3BeLilKrHLN32GliWlOSKpHryy2Y7sJzt0qqAuFfNLdk6sYifb9kLUUs
         OS+HGMV5qbl8caH6QucHbqO+ntYi2AulDWKCrrE/6/CYMCCUNNoJ+YYvzK6bkaR76L5f
         RabVDtwIu722NkXU/kwWWhCd/n0UpPGMp7eSRDueyTrzCSQGVZtbvK3/2EULlcVHRoLQ
         5VbiORzwdTwqQEO2ujUTWwbWfJRH5iyAbgmILi/DGSTHjgauYuc9GMUZNFtRJ6ZbbJsz
         IbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjXv/hXdTKE4Ms0xMam3rvOKo8AHNDWlHuTdPrINKg4jzxY1W3apHs+4KsQDzaA66ZLd6c/mezY7AoaQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59q0ZtgoNQRYlEXx4s70ch1WxcQIx1R95xOwfG2lj3SotnVWw
	uXTeIJpb8XF2YqUHqqqQx5fXxuInzsIPvceqH9cod+9iUUmxNCTBwvyazWHkHP8SLw==
X-Gm-Gg: ASbGnctM9sA9wxq/tJR8QM79UJglA8Ao5ZKz6uWoX6YUWz4Qj7GXrpCm7Jl9ZCiBF3W
	G42VKyS13OXfUjcv/mc4Is3HI7RzDBAT16lQKP5+RjsgbbNSNe4pAPWuiEQlp3ih48m1oxR6Wun
	Zm4/iWebRDjTci6vgORUpsKgP619xuOOUlS7AmznnJEwCMfP6sNIL7r9AcRGf1x0iSlmuOVQeE+
	ljCt6ofMWwoD9/YXbcGRdbdI1u/1gg6n41/e+DV7eJwOVBh7ldiVaIwAgvf7Wx3say9N07SXZUk
	6daw7z/Ql3sBXeVEFw1uyxk2P1gZ9zc+4QLSXY6kZWpyroFTajquUHOBFta5tVT6RRKyEDnPUQL
	HOg5fLI5lbw2Kff2k0QSLnjqyK71vyCdtUqmH2GOp3fgQSrj3Iow8EtnXdZ2Btl3m4zH/mzea+3
	D3gg==
X-Google-Smtp-Source: AGHT+IHgATM+vpR/CxE89ZGkxxcoAPFDIHN26iOy/FjOgPnA6lzy6iUTWGNa3baX21y+yQJqVKxzZg==
X-Received: by 2002:a05:6214:5083:b0:783:cc80:1770 with SMTP id 6a1803df08f44-87b2106d967mr418771056d6.25.1760539880497;
        Wed, 15 Oct 2025 07:51:20 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012a79f9sm19380516d6.53.2025.10.15.07.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:51:19 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:51:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] usb: uhci: Work around bogus clang shift overflow
 warning from DMA_BIT_MASK(64)
Message-ID: <a34eeced-c4f0-48de-8f9e-d78b50378101@rowland.harvard.edu>
References: <20251014-usb-uhci-avoid-bogus-clang-shift-warning-v1-1-826585eed055@kernel.org>
 <c0d1dc65-6f55-40b9-bbfa-09e8639a28e0@rowland.harvard.edu>
 <20251015031952.GA2975353@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015031952.GA2975353@ax162>

On Tue, Oct 14, 2025 at 08:19:52PM -0700, Nathan Chancellor wrote:
> On Tue, Oct 14, 2025 at 11:07:27PM -0400, Alan Stern wrote:
> > On Tue, Oct 14, 2025 at 04:38:19PM -0700, Nathan Chancellor wrote:
> > > After commit 18a9ec886d32 ("usb: uhci: Add Aspeed AST2700 support"),
> > > clang incorrectly warns:
> > > 
> > >   In file included from drivers/usb/host/uhci-hcd.c:855:
> > >   drivers/usb/host/uhci-platform.c:69:32: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> > >      69 | static const u64 dma_mask_64 = DMA_BIT_MASK(64);
> > >         |                                ^~~~~~~~~~~~~~~~
> > >   include/linux/dma-mapping.h:93:54: note: expanded from macro 'DMA_BIT_MASK'
> > >      93 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > >         |                                                      ^ ~~~
> > > 
> > > clang has a long outstanding and complicated problem [1] with generating
> > > a proper control flow graph at global scope, resulting in it being
> > > unable to understand that this shift can never happen due to the
> > > 'n == 64' check.
> > > 
> > > Restructure the code to do the DMA_BIT_MASK() assignments within
> > > uhci_hcd_platform_probe() (i.e., function scope) to avoid this global
> > > scope issue.
> > > 
> > > Closes: https://github.com/ClangBuiltLinux/linux/issues/2136
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/92 [1]
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > 
> > Do you think you could instead copy the approach used in:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?id=274f2232a94f6ca626d60288044e13d9a58c7612
> > 
> > IMO it is cleaner, and it also moves the DMA_BIT_MASK() computations 
> > into a function scope.
> 
> Sure, would something like this be what you had in mind?
> 
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 37607f985cc0..5e02f2ceafb6 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -65,13 +65,10 @@ static const struct hc_driver uhci_platform_hc_driver = {
>  	.hub_control =		uhci_hub_control,
>  };
>  
> -static const u64 dma_mask_32 = DMA_BIT_MASK(32);
> -static const u64 dma_mask_64 = DMA_BIT_MASK(64);
> -
>  static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	const u64 *dma_mask_ptr;
> +	bool dma_mask_64 = false;
>  	struct usb_hcd *hcd;
>  	struct uhci_hcd	*uhci;
>  	struct resource *res;
> @@ -85,11 +82,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  	 * Since shared usb code relies on it, set it here for now.
>  	 * Once we have dma capability bindings this can go away.
>  	 */
> -	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
> -	if (!dma_mask_ptr)
> -		dma_mask_ptr = &dma_mask_32;
> +	if (of_device_get_match_data(&pdev->dev))
> +		dma_mask_64 = true;
>  
> -	ret = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
> +	ret = dma_coerce_mask_and_coherent(&pdev->dev,
> +		dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
>  	if (ret)
>  		return ret;
>  
> @@ -200,7 +197,7 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
>  static const struct of_device_id platform_uhci_ids[] = {
>  	{ .compatible = "generic-uhci", },
>  	{ .compatible = "platform-uhci", },
> -	{ .compatible = "aspeed,ast2700-uhci", .data = &dma_mask_64},
> +	{ .compatible = "aspeed,ast2700-uhci", .data = (void *)1 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, platform_uhci_ids);
> 
> The
> 
>   const struct of_device_id *match;
> 
>   match = of_match_device(dev->dev.driver->of_match_table, &dev->dev);
>   if (match && match->data)
> 
> part of the change you linked to is equivalent to
> 
>   if (of_device_get_match_data(&dev->dev))
> 
> if someone wanted to do a further clean up.

That's a small enough matter, we don't need to worry about it.

At any rate, yes, this is what I had in mind, thanks.  When you submit 
it, you may add:

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

