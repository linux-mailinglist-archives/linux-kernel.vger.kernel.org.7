Return-Path: <linux-kernel+bounces-823170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8443B85BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAED91C05D07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D123148A0;
	Thu, 18 Sep 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+NQbqf2"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157A30F946
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209925; cv=none; b=GQNfTW6jwT2Q0y1O4AMFzCqFWeZyMZ6UIwP2FvL5dS/AJg2FG7xJ+z4wg9pIj6jZqxvNLTBjsKp9/x1wFNDyeNl5WBdriajDng1expFt+84q8wuuKXnhR1sNZ8X5tff+2NF6hwXuubwe6TcqHNu4NGEDrlCa1/bVci7SH7GN1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209925; c=relaxed/simple;
	bh=WXZzoEkr5HMQOA3/Bzjsdzdf1qJeWiNkpcYemh5e3Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F30PYflsnLUxWUc/WyhVHmPr/b7lEdd53dY9XK6JdcAW5kdVFEqncsRSvwQfkuZjdtuIYhz4Jf6E2t67RyxU02fgMPQNf/bmH6RYYYll9HWT7KktP5VsCbtqYoZ9Gi60kOvts4wFnayHYoGwtcXD/wFo6AL1gBdCedBf8h0NmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+NQbqf2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso1398266e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758209922; x=1758814722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uU1Yqis+8TjWDixzlQWTPOERfCi/hGhUBKZOoxLfOA=;
        b=O+NQbqf2YVFVjjRoQoT4JMuMM7ya14jitHasgd7TTI2shbA83BRnpd9nF3NLGw4irk
         lnYdF/AznE1ACaoZCSuvSCV80vVb/TKqvrZoCQM7BwL/LnhwQmptvMnlnQhLWPRtoyWs
         iB3GJmHGh/J7oRD1C0DCGgk7Gt/CypHpUJCzvtk5zrlve+dGyOrNIaEtHS/aWxFSUpfd
         4i5iMsl9iWSqtpyp5s7aU7hFZ37CcQmfIaT07XVpOl7JoNM/wA8xI3fv/ZqrQp0S8w/E
         R8Cphnr5n0mzzWkDrdaHlqlLbECXAEK94Dn75qpGnqh6xeQVY4sbpagcndtbmEvOeK+4
         h24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758209922; x=1758814722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uU1Yqis+8TjWDixzlQWTPOERfCi/hGhUBKZOoxLfOA=;
        b=a5glePedULgGStoXvPpntAHfswTNXR62Hns4pBT8HwPzH4P7fU3IIsACUp23/WD3mB
         o9YQgkm7k7EMka8FpQ5BjeVZR2DghO5+nUxF+k5/+MV7JxmrUPKZ+f5m4wNFxRxU6ay9
         j52BJq+owcTE9NqEeYd7/zOcggibfe/qcf2eSHjXRpXh5ubX+XmuIksbJ57AFNEJoFlw
         tMvtnxPCyfG9WnL/xRGIH7ugnS7d1+QX5NIlqKYFYVQjvgwb9mC5cRNQi7xyWqKoGjoL
         TBvBIubvG01dJA6rk8iizOT09fxzRHR1mhGaeaf6O1xfTZBMsO7HKUD2gQnn4b9KI9pq
         7nhw==
X-Forwarded-Encrypted: i=1; AJvYcCVxGlj69QWXRu+17xi1YAbLLuSviqnqHnoCsFRLI7M0GYbMxh8y0YARp8pQqdpj4tzGrG+wa4wma+R2X3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7xpubTNBnsGbHakXPRyhIpFb6Kicsi4tzEqjYEFkgNcEmjXf
	uvxxXaoYMOKGJyuB/qWwheRixt26vYuffa/xh7ENJEo1Lp+OOI9oDGAY
X-Gm-Gg: ASbGncugfpyQMporyrkjX1hnlTRpToxINlYsINfSgZJ4RU7fps612+gcd9oQwZZK9Vy
	4G76Ejr88eErKWkbjceDQBV/GWJTouHDnOalk2N17Wk/6XgMXnvnoKxSUNrZ6Wuf8ZHOsyqJbxJ
	3Yy0Smh4+YBODLl0Sg8iO6dFoCk/npYjWsw1zJRJ1gon8DKxI3cAIHEaLVnGCbfHosJecT6FjnW
	I7P/K36nEd30QQWFgBw229huCQKpTPtiSHO/uQER5hafuHk+UmSF63B1QbHHXj8UciucfLxKGg4
	+oEmD40ouh1Z/BZsHBK16m1apTnRCfDP2VnIHMcksAspta0zEsPZkfq2onmhc7UE0UK4NxKjy7+
	i+Czi87mkyjXIGE44wKiEqEqXK7s1HcxD8fn11jrDy6cb9kigKvOypA==
X-Google-Smtp-Source: AGHT+IGPk7ZNmXlXU2ixuYtToZHIHGFguajk9+7DwOwXUT5jca2TARiZv+la7RKAwfynRhSAjFV3bQ==
X-Received: by 2002:a19:6a12:0:b0:573:68fd:7ad2 with SMTP id 2adb3069b0e04-579e2131278mr36626e87.35.1758209921620;
        Thu, 18 Sep 2025 08:38:41 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a90a20e8sm733118e87.76.2025.09.18.08.38.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Sep 2025 08:38:41 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:38:36 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <20250918173836.0def4d12.michal.pecio@gmail.com>
In-Reply-To: <20250918130838.3551270-1-lgs201920130244@gmail.com>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 21:08:38 +0800, Guangshuo Li wrote:
> kcalloc_node() may fail. When the interrupter array allocation returns
> NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
> and in cleanup paths), leading to a potential NULL pointer dereference.
> 
> Check the allocation and bail out to the existing fail path to avoid
> the NULL dereference.
> 
> Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/usb/host/xhci-mem.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d698095fc88d..da257856e864 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>  		       "Allocating primary event ring");
>  	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
>  					  flags, dev_to_node(dev));
> -
> +	if (!xhci->interrupters)
> +		goto fail;

This is a patch against some old kernel, this exact check has been
added in v6.16 by 83d98dea48eb6.

But it's missing Fixes and Cc:stable, so 6.6 and 6.12 were left broken.

>  	ir = xhci_alloc_interrupter(xhci, 0, flags);
>  	if (!ir)
>  		goto fail;
> -- 
> 2.43.0
> 

