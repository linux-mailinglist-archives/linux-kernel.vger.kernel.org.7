Return-Path: <linux-kernel+bounces-822910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B4B84F36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9857C16EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD121FF23;
	Thu, 18 Sep 2025 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="U1kYPwFI"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3262E9ED5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204160; cv=none; b=NWJicXJ8HVa+37vVnA1gIP9PYY2Ezodfx/V8xXsOBhHy0p7/ujH0Mpe67wrybaDrvUdkhHZVjTNffF0v5w0TYl8lpBNkkP3GxSh3OB55PC9zUTubF3uIHVUnGSVlSJTRXKT7dTwS4eT09DUNtAXc1YP1h24v50Zlv2w8Kp8/Xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204160; c=relaxed/simple;
	bh=sGKZ00n5UDQXEyHBMBFXRLZojhXv5KW24a44k+cS0BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRwTV7AesQekIC5CPEBoSEhkdsyJuxsSnkAiKYzozJ9cnG5Db9oqjFAMntZ241n1PiW7sARQXGiDWdr6ZjSNy1ONAXSBu8YMWANZY6qgnYg1zkgRnfYiQZylk1ifjGWPn4JLyuseALbOCPQl/52RrglA3iKz9JdKGJ0LG51Cy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=U1kYPwFI; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7960d69f14bso3169616d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758204156; x=1758808956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mN2EtEp97sJogExyeUW2p5bKBNRveeYjjBUrQmZ9S8k=;
        b=U1kYPwFI09c9NCUMeznb5gL6M14UadhybYyX9w1RfKhHjMfKUzDr7EsopyBjycR122
         qK4Xb9ugumoxe5n+HKTQEPq8QRYbN26ewX7NDSKJozxAhBo9QJKvNlOZKh3N1n1PI81S
         y7ZfeZdb/TdDQYmDMY66+GtH0ONrDdNqIYkDplhSIUChxMSgfZVqmIR0XSmakr3VJIFg
         +XhPIumLdnwxacng2T+sYyjqZBz9MIn3DeejPTIyvXCHidwiEgrsF8akZI/QdhIOKmTu
         Rz8Fu+8O0IbZymSIGEGSNGKQHlD3Rrq/2xi/HmS6WuNt+g5qZY52jpmhi/NPuo9tNPN+
         mxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204156; x=1758808956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN2EtEp97sJogExyeUW2p5bKBNRveeYjjBUrQmZ9S8k=;
        b=OOrTVO3RAi7o4go+HKdXenbVZ0iqqx711hPkkQjCgg3NysFIwOu/QPGpabfS7ILqEO
         hemVlncK5x3u+CFAc3YyOrqRle2cQKUeEGUe74wmEBzLo9V9R/5J6w6Cre+Tv/ln724y
         JUn+752UKItt9Ze19tQzJiQgMIXReGCjHbn+cKS2W+yIYNaixH7nNH+FJAQh62p4p98t
         uDH9Y75bU5Y6m5zH94aE2zTuAfrMMgzmlbJbIgjKbFR8z8k72NWBsA7qlGwC2+i2S1lr
         GOUoX4rgY6+MrraRBPMIi1iTQzgttIsvA9UBIEGcze/tO2B9AkYhYrvpwqkbIiZxhQzZ
         kJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5PKkbK/4t+ZEOwp9JIv3vj8J6bSHZd5+VzLTZsF0/lTEK/i8tblHSBhMKUYyh6STijgarlK630gJ+M+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS0blngAqZZ1BWQ77DFyOrFLex1TRBXm2g9seUPl143o5Qdffz
	kLRQ1oFl1PbQkJb5C8FajlNejS5DkgQxMj1e36jnU931DUFaUuGKkmtxMPfSOSDDtw==
X-Gm-Gg: ASbGncuUf35g0mI09ieu0trthp6+U+011GoBpr7u4J7KVrMGfcobFHx1oUlMKHNkYX/
	f6I3EKaDocykE5nJXrI9RaECOfPotY3epUvIYKbn4VtRRJDHTQ52qIs98jsFLqw5EZsGHWqgxzI
	AzO6wX/BdPjTHzwpzdWsbdwtKhgAEjsNoQgc9AiMAshiBf9TLrxdseztuE2/+XW5TRkE/icHcvz
	TKZgzFDWUw39scezN7c6V4NQFadkGeVVfKifCMVYHXb/mbmSDqP8EWPIT9cLWiLljgvNTzZWt2y
	a64yTS7knDsDDQz+ppaFGMoEvydhdclH3NmdjaMLtG6xdd55MY7PPWYRboLQQFrzIorXJnSlr+h
	wC9A4R1N21CdMgCRE+X3VBWZ2MClSVT/r2Jrzm00cprAlXKsL0cFvDxjD+sH2Wa4w
X-Google-Smtp-Source: AGHT+IGlt2hbobisXSeZHsNze0BfPPP53bsTOpqMhw+K8n1S/Ym1JROT13oEyZ3NdZHmGsAomrN0gQ==
X-Received: by 2002:a05:6214:252b:b0:70d:6df3:9a88 with SMTP id 6a1803df08f44-78ecf4ffb35mr51718416d6.56.1758204154421;
        Thu, 18 Sep 2025 07:02:34 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7934693139asm13525086d6.21.2025.09.18.07.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:02:33 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:02:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: ehci: Add Aspeed AST2700 support
Message-ID: <95dfea8a-f5ec-488b-bdd0-fa12acd3dce8@rowland.harvard.edu>
References: <20250918064919.224927-1-ryan_chen@aspeedtech.com>
 <20250918064919.224927-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918064919.224927-3-ryan_chen@aspeedtech.com>

On Thu, Sep 18, 2025 at 02:49:19PM +0800, Ryan Chen wrote:
> Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
> 32-bit DMA addressing, the EHCI controller in AST2700 supports 64-bit
> DMA. Update the EHCI platform driver to make use of this capability by
> selecting a 64-bit DMA mask when the "aspeed,ast2700-ehci" compatible
> is present in device tree.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/usb/host/ehci-platform.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 6aab45c8525c..edf1fb4033c2 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -27,6 +27,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/sys_soc.h>
> @@ -122,10 +123,18 @@ static const struct ehci_driver_overrides platform_overrides __initconst = {
>  	.extra_priv_size =	sizeof(struct ehci_platform_priv),
>  };
>  
> +#define EHCI_PDATA_COMMON        \
> +	.power_on		= ehci_platform_power_on,	\
> +	.power_suspend	= ehci_platform_power_off,	\
> +	.power_off		= ehci_platform_power_off
> +
>  static struct usb_ehci_pdata ehci_platform_defaults = {
> -	.power_on =		ehci_platform_power_on,
> -	.power_suspend =	ehci_platform_power_off,
> -	.power_off =		ehci_platform_power_off,
> +	EHCI_PDATA_COMMON,
> +};
> +
> +static const struct usb_ehci_pdata ehci_ast2700_platform = {
> +	EHCI_PDATA_COMMON,
> +	.dma_mask_64 = 1,
>  };

Arggh!  This is dreadful.  Just have two copies of the initializers.

Better yet, change your of_match data into a boolean property for 
overriding the default DMA mask and then use the original 
ehci_platform_defaults structure.  Look at ohci_platform_probe() in 
ohci-platform.c for an example.

>  
>  /**
> @@ -239,6 +248,7 @@ static int ehci_platform_probe(struct platform_device *dev)
>  	struct usb_hcd *hcd;
>  	struct resource *res_mem;
>  	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
> +	const struct of_device_id *match;
>  	struct ehci_platform_priv *priv;
>  	struct ehci_hcd *ehci;
>  	int err, irq, clk = 0;
> @@ -250,7 +260,10 @@ static int ehci_platform_probe(struct platform_device *dev)
>  	 * Use reasonable defaults so platforms don't have to provide these
>  	 * with DT probing on ARM.
>  	 */
> -	if (!pdata)
> +	match = of_match_device(dev->dev.driver->of_match_table, &dev->dev);
> +	if (match && match->data)
> +		pdata = (struct usb_ehci_pdata *)match->data;

Do you really want the of_match data to override the platform data?  
Consider a system that has both.  Which one do you think would be more 
important?

(If you take my suggestion above, this question becomes moot.)

Alan Stern

> +	else if (!pdata)
>  		pdata = &ehci_platform_defaults;
>  
>  	err = dma_coerce_mask_and_coherent(&dev->dev,
> @@ -298,7 +311,9 @@ static int ehci_platform_probe(struct platform_device *dev)
>  		if (of_device_is_compatible(dev->dev.of_node,
>  					    "aspeed,ast2500-ehci") ||
>  		    of_device_is_compatible(dev->dev.of_node,
> -					    "aspeed,ast2600-ehci"))
> +					    "aspeed,ast2600-ehci") ||
> +		    of_device_is_compatible(dev->dev.of_node,
> +					    "aspeed,ast2700-ehci"))
>  			ehci->is_aspeed = 1;
>  
>  		if (soc_device_match(quirk_poll_match))
> @@ -485,6 +500,7 @@ static const struct of_device_id vt8500_ehci_ids[] = {
>  	{ .compatible = "wm,prizm-ehci", },
>  	{ .compatible = "generic-ehci", },
>  	{ .compatible = "cavium,octeon-6335-ehci", },
> +	{ .compatible = "aspeed,ast2700-ehci",	.data = &ehci_ast2700_platform },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
> -- 
> 2.34.1
> 

