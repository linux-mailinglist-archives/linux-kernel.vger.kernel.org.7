Return-Path: <linux-kernel+bounces-853672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 829AFBDC477
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0EDB4F915F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A262298CBE;
	Wed, 15 Oct 2025 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="O9YSI76P"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919925C816
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497655; cv=none; b=RNRBU7jvwvdcvpPv2YK6kK0CLX5U/CDBQhyIFno9xk7igAHs26Cw4EfxyzsyEeJNSkhkHxJBYQdwaHqdXr5pjoG+YLxWxDa7oh00qSDWrHqkiFmG8gTe31SLEX2EsFW6x42LYseBZMPey2tJXCzOaj5YaKJZvXoJxCcTZlr8M1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497655; c=relaxed/simple;
	bh=4FztB+wmWkCqTcyqk43FQ/ijvv8lF01IQlzMj1iMpxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyAdVjoqbQ+UDNAD1iRE0Vwol+Y8Ky1jSG9V8qtkc7Q6VlJnTtJaZbLmDO4ldkmqo2ONXGTaDMpcz+LqkRNe+F8th0p5Gxw5Ct6497OKpohJip/0kCffMjVaasYc5X6Y8bJcDBdKMuE9uvENJfjwnpA+2WHUes25G1ePaxg28Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=O9YSI76P; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78e9f48da30so76215356d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760497651; x=1761102451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYOi/uzG+pxWc7qB8Kx+PDOI9ywodBDgq0X5/pl/onc=;
        b=O9YSI76PLg8LLQyzOFgvg+LLyDtXQgW8tIIETX0va07hEiNvIfaX35zJl390Syw37a
         /O/DfQULKVokt6wunQO1Ke5s9mQBN4sNC8iapXCW/SxirK9FTVBbiDYvgbUN27jVFXZ/
         ZdHNhjGaMckLLMGBhYz3bzIEufzuphoseo+ZoUntujgvxOwB1K/bg7uwqXaTi2S6J/tL
         EgdZBKr1lOIia5qwiN9OvftNoEliJlO/BYLzUTU2YiGT/8kEfN93sz0H/JsFEsHIgR4S
         FW32L/7yvKxKEiqJck03D1R9ThgrGBf3tPAO35pYwgRBMTq3iAtzr9duanHjsnVqPlGc
         5nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760497651; x=1761102451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYOi/uzG+pxWc7qB8Kx+PDOI9ywodBDgq0X5/pl/onc=;
        b=DH5D09JDkD1CoeFCOy3kUp9KJXbkkuBM/ATP2YanpekiEYqj0lEHsRAdDl5aJK10ou
         W0rexNiOaXHrkOQ3innhlDWvsbjGy2raVmcRRlpq6PxDxSM3iay4IxN9Ycqh6T6XCC9i
         Vlw/HpK5oNAxez0inUQ3V4B6YttwZzyKcH9rHRSMZUSbgZOM6nUT2KfI8QC1y2+IaErJ
         2GCqV2F8TfmLpqT0RgTYks08gN1lq09/a/Oyvjq19Nj0ymBFKUNgZgiptICHn3fLFAjA
         2puokfVWJ5HFNSIQWJTI20sNXXB8DvqwDSsNCtPkKO4n6PvtCj88AUZWlL03KcxSg/IE
         k/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvseHTTL61vazOxsiJV/KLYxtSosqqIioTNC8HilHAljq5b/h7VoTaHN1608y4SFphP88/2JDPkjFjIMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKg07FEy4YhV3xJyZwP691agYExAuYtawgo76FxdSRUqkSW00
	1MoIjRFqV5oO5EIRHddEQ8znCPJvtqKD9Gb8/eTJI4Wkj0hq3JdnqNX6+9lAcv4JnQ==
X-Gm-Gg: ASbGncvmAED9OR/hMfadQ/eo4LBGPTFFub3eP8IUa/BSCHmPffPm+pHwjIkW0ponS5c
	Q1YHCnCxWyfSYIrOyUlifZmoJ+//v9fivexVvruYxSh6Q+1jRRUZPpb+gVaHJ294v32ixnBf45N
	Zton27N0GE13OBi0J9Nt2iCpR+20fP1dGGzgJKzRrfRx/lZAf2b/AQLlutztEVdlHbV+92TRUiw
	CCpvdXyYiTbfY1fD78Auta2zQS5lVmfnwbQGVKAM3x6naAcsFP5taIzble1iWc2GtGAmszGasAh
	4nlEpFZsdjQ2lex4TP+ksGd5RoImE6iq2T15KYMVt3wFpRYsPWD9ohesonW6OX6SKsmjftazosL
	AXJjihJavBiejk+g6RByqXre4iIN3mOs+bUTrp4MtvBrX+S0D
X-Google-Smtp-Source: AGHT+IFAjPLGiMuXqey8nUwdA4Iw0xkYkiAWc5b2GEtlEYT/1lGTfUT34pPAOluVQ9gpFjwEo2ePNQ==
X-Received: by 2002:a05:6214:2121:b0:782:3caf:668e with SMTP id 6a1803df08f44-87b2efa9a8fmr314904506d6.40.1760497651363;
        Tue, 14 Oct 2025 20:07:31 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::9c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b153dsm9788976d6.57.2025.10.14.20.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 20:07:30 -0700 (PDT)
Date: Tue, 14 Oct 2025 23:07:27 -0400
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
Message-ID: <c0d1dc65-6f55-40b9-bbfa-09e8639a28e0@rowland.harvard.edu>
References: <20251014-usb-uhci-avoid-bogus-clang-shift-warning-v1-1-826585eed055@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-usb-uhci-avoid-bogus-clang-shift-warning-v1-1-826585eed055@kernel.org>

On Tue, Oct 14, 2025 at 04:38:19PM -0700, Nathan Chancellor wrote:
> After commit 18a9ec886d32 ("usb: uhci: Add Aspeed AST2700 support"),
> clang incorrectly warns:
> 
>   In file included from drivers/usb/host/uhci-hcd.c:855:
>   drivers/usb/host/uhci-platform.c:69:32: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
>      69 | static const u64 dma_mask_64 = DMA_BIT_MASK(64);
>         |                                ^~~~~~~~~~~~~~~~
>   include/linux/dma-mapping.h:93:54: note: expanded from macro 'DMA_BIT_MASK'
>      93 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>         |                                                      ^ ~~~
> 
> clang has a long outstanding and complicated problem [1] with generating
> a proper control flow graph at global scope, resulting in it being
> unable to understand that this shift can never happen due to the
> 'n == 64' check.
> 
> Restructure the code to do the DMA_BIT_MASK() assignments within
> uhci_hcd_platform_probe() (i.e., function scope) to avoid this global
> scope issue.
> 
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2136
> Link: https://github.com/ClangBuiltLinux/linux/issues/92 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Do you think you could instead copy the approach used in:

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?id=274f2232a94f6ca626d60288044e13d9a58c7612

IMO it is cleaner, and it also moves the DMA_BIT_MASK() computations 
into a function scope.

Alan Stern

>  drivers/usb/host/uhci-platform.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 37607f985cc0..f532d3a0acbf 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -65,16 +65,16 @@ static const struct hc_driver uhci_platform_hc_driver = {
>  	.hub_control =		uhci_hub_control,
>  };
>  
> -static const u64 dma_mask_32 = DMA_BIT_MASK(32);
> -static const u64 dma_mask_64 = DMA_BIT_MASK(64);
> +static const bool use_dma_mask_64 = true;
>  
>  static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	const u64 *dma_mask_ptr;
> +	u64 dma_mask = DMA_BIT_MASK(32);
>  	struct usb_hcd *hcd;
>  	struct uhci_hcd	*uhci;
>  	struct resource *res;
> +	const bool *of_data;
>  	int ret;
>  
>  	if (usb_disabled())
> @@ -85,11 +85,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
>  	 * Since shared usb code relies on it, set it here for now.
>  	 * Once we have dma capability bindings this can go away.
>  	 */
> -	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
> -	if (!dma_mask_ptr)
> -		dma_mask_ptr = &dma_mask_32;
> +	of_data = of_device_get_match_data(&pdev->dev);
> +	if (of_data && *of_data == use_dma_mask_64)
> +		dma_mask = DMA_BIT_MASK(64);
>  
> -	ret = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
> +	ret = dma_coerce_mask_and_coherent(&pdev->dev, dma_mask);
>  	if (ret)
>  		return ret;
>  
> @@ -200,7 +200,7 @@ static void uhci_hcd_platform_shutdown(struct platform_device *op)
>  static const struct of_device_id platform_uhci_ids[] = {
>  	{ .compatible = "generic-uhci", },
>  	{ .compatible = "platform-uhci", },
> -	{ .compatible = "aspeed,ast2700-uhci", .data = &dma_mask_64},
> +	{ .compatible = "aspeed,ast2700-uhci", .data = &use_dma_mask_64 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, platform_uhci_ids);
> 
> ---
> base-commit: 877c80dfbf788e57a3338627899033b7007037ee
> change-id: 20251014-usb-uhci-avoid-bogus-clang-shift-warning-a80166a24472
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 

