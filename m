Return-Path: <linux-kernel+bounces-774626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D3B2B531
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C36F525AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0A14A8E;
	Tue, 19 Aug 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4tMuMFn"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5054A11
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561741; cv=none; b=cTquZV5X2Vsj42MjUnAcC3f86VKWYVHUaVOwvR5RJ4qSWGIgq6et5u0Fn6LE4FWEKmgsdzjS8FS/xA2luwZlfzqFevH5jekmITD/4eBowEFgocDTmjdA5pavapjqVBxAdsAFV6iQ2MlYZm/j0t9oEhQa61Jx8FytoqxlQPaXxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561741; c=relaxed/simple;
	bh=IYI91/LE9Llcly1/RR9GAXRgHt5xZK04GitaKe7QsYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL02ElLKQ7YaTyK9nen2ciZuERgT6ICyAaFS5cNeljDoY0ArJoc7DmmfMITBJYWKcStNMmAy6QautD+c7Jpny0bdXkuHvjCTqyfT/mt0XMhBrQ4ijvj85FqXkJwbeJcpj6e9sePCeQizjXAlGJcEISNH9cXSscxr2AWib4owKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4tMuMFn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-435de820cd3so3017325b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561738; x=1756166538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMsgbwBVAVhf//iwhRHAmazuWGfkfHKPwkTozN8mYH0=;
        b=W4tMuMFnm25GdNZbPYhPn7cwIhzmZU7JAQ54Nx5hcDY4ZvarRH/o5jDOkUL2YAbG2g
         lnuGIGF3aGFdgaF+4j7mDk3X8CFNvDQEjhIdrA6JvyvYgUj9nEzBFu8nCXyEKqa8TuaY
         cZBaOpOCAPNNFmVe5dnw5ERkOMAMsMo9kWnMT8snfWi7+mGq/bfBE2NJj1WpokRLBnFp
         h+JJWEeA1G/NHsQoY6lm844YTdNfHv6aAxKLpWIVg1m31FpNgyWm0n0Xh0/1ggAmxs4a
         Ewyco05MWIm8QQNy2bzdIXppbPBbdBDBPoB7tZu/p8wuCOajACLWd5wBsQ9efx00YLv3
         k+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561738; x=1756166538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMsgbwBVAVhf//iwhRHAmazuWGfkfHKPwkTozN8mYH0=;
        b=T+yuxWqgZrsjbZBC+XzQOuVay7li0Pzt4NoGEKyPAM577LZp63u+j+NTrofeTa4e6M
         1tvvoRcUZz3ANIYkqZDgaNpOuz2HLDNxF72ahTJ/tkrRZcdQA2jVwv3L8XRJNlAOj2Sc
         2Ot5OTcvVCwYxes/0N9NEMnjyP5SvnBKIWN80OC4RNLZESp8k+nk9jEMdXU+KMt61/C+
         zZWrvW07dOFF+ALU1mlaRxcf4AeCdpm58t6YFLM3ZzQjL4Qee7ybreskdjLmnCshVCYF
         KSwlxWZ2jqkZJ1fHZakhPw1YbEMv0FNZT0O7lof2Uf2VbD8Jekqlewq8pfo6z4QN2D8J
         Pm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWujFLNNJ+i8FjDgXKsEBXqRJeisLe1c2UohGE30FAVLD9b6zvaIASzQz6FBrMuycvEld96Q3MxacvaA7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7A1O9uTl4EfCwWwlzVGq8PYk7Y3yXMEqcwvH6GE2X2VzdGJE
	zrlYa6mXelV6UOQDzXjHL7kITNstdKMcSKXwhUfzilrYuSrsPKOpoK8Rk1ywW9evqw==
X-Gm-Gg: ASbGncsMbHdHo2nFs077GhMu5IMveijaiobeh4dAcjI6xec8ACzX+jFnHgqTeQknGAf
	ouHCBZn3Od9ABfZKHY81kIc60XW34oAsFtAewIlDCtsPi3s0yLNoKs6BboAW8zNLiGrnkOCvVlS
	4Q++jYOVa+4dNB3OLyYlHCuBCG6IhZ08UCofOjNk/d4J8CDFIeaQAbliDQvArs5AcTfV0NcVJRR
	nHKYlteNniyiIG3JtLQidnKMvrXkUfbyTb/5NBtpoPu0v7J81IkFagcvKDPsgN3br5AVNVAuIZm
	8oZxm8prF1WxFaw8z4QNky94gH/xJVKjm9+P5Z4hg2XVetdjl6zsL3b2LXigkJpqfIn7sKP9XpK
	IvAKvw7zSvZbFthAjN6JeNqJK3KEqAHzWm8V3QiA+GAVphjyzVvy/6rWvbiwwB6Q=
X-Google-Smtp-Source: AGHT+IHxC2a8ADbE8Man2mxRnjf7l32j3oW2wJDIpc4tYOrxF0mDpcOuNs9sRV+UqoA+G+aHiT1l0g==
X-Received: by 2002:a05:6808:11ce:b0:433:fe69:fd85 with SMTP id 5614622812f47-436da1e48dfmr462238b6e.20.1755561738182;
        Mon, 18 Aug 2025 17:02:18 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94786c0fsm2917906173.3.2025.08.18.17.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:02:17 -0700 (PDT)
Date: Mon, 18 Aug 2025 17:02:14 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] MIPS: octeon: Replace memset(0) + deprecated
 strcpy() with strscpy_pad()
Message-ID: <mnqgvgvlnnamfyy7eb54thjs4edkrcdwqy6mg2ybqhf3nxtapu@rntlepvgtbd6>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-6-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:16PM +0200, Thorsten Blum wrote:
> Replace memset(0) followed by the deprecated strcpy() with strscpy_pad()
> to improve octeon_fdt_set_phy(). This avoids zeroing the memory before
> copying the string and ensures the destination buffer is only written to
> once, simplifying the code and improving efficiency.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 5e1dd4e6e82f..47677b5d7ed0 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -13,6 +13,7 @@
>  #include <linux/of_fdt.h>
>  #include <linux/platform_device.h>
>  #include <linux/libfdt.h>
> +#include <linux/string.h>
>  
>  #include <asm/octeon/octeon.h>
>  #include <asm/octeon/cvmx-helper-board.h>
> @@ -538,8 +539,7 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
>  
>  	if (octeon_has_88e1145()) {
>  		fdt_nop_property(initial_boot_params, phy, "marvell,reg-init");
> -		memset(new_name, 0, sizeof(new_name));
> -		strcpy(new_name, "marvell,88e1145");
> +		strscpy_pad(new_name, "marvell,88e1145");
>  		p = fdt_getprop(initial_boot_params, phy, "compatible",
>  				&current_len);
>  		if (p && current_len >= strlen(new_name))
> -- 
> 2.50.1
> 
>

Thanks
Justin

