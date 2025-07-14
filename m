Return-Path: <linux-kernel+bounces-730622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78D1B04715
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BE318813B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C3126B2C4;
	Mon, 14 Jul 2025 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9F92bNP"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6126AA8F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516239; cv=none; b=Pjw7gB60WM5psl1FYqsJZVXQd9YDBVx81NCbNlqBN0PnnBYwUGGYyQkVnn1yLPR58jiJoW+k1+Xki1phQcA7OJehw5r3qXC5G4PQX4kQTFEMjp4XX4nI7QI/F13FZXuK5zBRk/n1LPsb4KBtWmfE4Gyk4uqbSDFnlAiZUTq9ySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516239; c=relaxed/simple;
	bh=xKnjXWOY2IrRzosXfQB3Bpso/mm2u4JxGSYgZGdZjIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwuf6cQ2Ab5fq16ndyW2cjRhjodhmfB1CtJAjXZzIG2lxBjMxK1jRJGsQK4ifeW/n1Idxwno+cdojUUAoAItTzHm6jB/G2ItNcRyH+S3NWFxCwrqFngYwi5nRiw2M/6j9JrY7vFUAe/JuC+3NiWKER2J6fXWVNV0EXNblRYUr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9F92bNP; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ea58f008e9so4033067fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752516236; x=1753121036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUc//PEDPwGX6GKHFUnDylrVbmV9/GKD9WpLyzBk2E0=;
        b=Z9F92bNPvUvzoOh9o+Tc/v+cCBf2+qu2MWe2G+RnjWD3C5x+s5lLbCFMjjA6bZZHKa
         W84FRIVVuaQVJ2pqMnhdhw0dQ3pF4LOsc3XrVXolQ6aJ34SCadHwhMOMfQOJAULm48QY
         OUHlIO8OIR6r5SZqjPuKKb2awKYWSxP9R4yVFTA59l7TkKPMj0wCHwV7sgywmQT9hgpk
         ldT9xZUimI5KStO+hW3gwxTtS7p7ud+7upXQkYXbhVwVYA2zQ+YA8BBLAcBV5QdIjhHv
         5FpaNP+G7k6nzJWFPnAKSC1L1uSWICCdR6vRbM98oluqvyDIvrmxKU+aNO1LnzLMerx4
         DtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516236; x=1753121036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUc//PEDPwGX6GKHFUnDylrVbmV9/GKD9WpLyzBk2E0=;
        b=NYbvZe15VfIv2poKepOnpOQglU1sFH5J1vqFuSHCeObiPnboBumutdTvPiXg2kx8I0
         CFLwsT/SYzJVtp5bJ0WqOZaEjwzmLBXHvVRg6R9c5P2N8TOjB2lvbrh+vbcjfOyc0Ill
         kDbZa1VVXBTQZz8bw99Tcy8v5lenA+i0Xnrn4nD15tDO5InhNmp0YzR0OgA49OiU7BOL
         xxr5s9VsE7Lb9wr5U6udKhqQr8sl/0eflDCwnlNTCMjjjy55IsfO1ZxMw69/3ytbKXJk
         A1faEYtqGvIJ2zpPm63RbrTW2fPyHJLW/Llfjm3cJHkia7kiWUr0NLVUw71yPT8i8bRs
         UkkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsEHbSLF/VSExM2xUewpvw14EAbUNKWvSEiaY0DVhJ++tvHgyQq1Y3+umnU1YFOFFrjOvvAmORVKqsQ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoBBBkU7E7wQYWt79jZ/99rza22VsNwNQJ4+fDwwT0D4fk5Ui
	YhyBaHD1xB2KyxyakGR8ZFDYVXRv7QJ6lYOcupdGM6/1Cu5uiEVSLzqH37MmtMu9CeY=
X-Gm-Gg: ASbGnctRGTNRVna3ULHLlQdZdnWENr2ryExhE+9ZVVwHdGUzXEndwxwQ0FGcn6And+q
	4KI1t5EPO/7zJATMGiSsf8J7jo9yBVzbNIae9m80S9XQ7yn02QKW7EeZGuWPIwjsCwYGxEywCAN
	zP8Ny4q8bvFf5D4MVW299iPzHeAt0i5L5FRB7LH/RSrfXD+r7GPXPBlJ2snnzC09DeKS+3Vt3Ej
	cAdrlY+UpEXQmwVVSAZbmYBis1wFZ05OAxoe8kMzZ2VHO5BbwLlCUBgD2Fbe/3If4eaJYcGW4JC
	iMugWZdAEWxPTZXxyPIxcsm8RapFumRSRnKAm200M45C1x7fDKSkcwqr6wXSfyQjOBRX3Pkw1m+
	nBHK+IDe4VROOL5IhyiBSvmSnwGRkKA==
X-Google-Smtp-Source: AGHT+IHTpGx6mV7WMwP1pIKs1b9CdmfJ9vEn7hc8jx+5sU/Mj67Y+rDomjPaMvowTYcY4XUtpdxDwA==
X-Received: by 2002:a05:687c:2001:20b0:2ff:8822:2912 with SMTP id 586e51a60fabf-2ff88223f6cmr1071480fac.5.1752516235811;
        Mon, 14 Jul 2025 11:03:55 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff8dea112bsm84240fac.43.2025.07.14.11.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:03:55 -0700 (PDT)
Date: Mon, 14 Jul 2025 21:03:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Kohei Enju <enjuk@amazon.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/rose: Remove unnecessary if check in
 rose_dev_first()
Message-ID: <96fbe379-cf8e-44e9-aeaf-a8beee2eda9c@suswa.mountain>
References: <20250704083309.321186-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704083309.321186-3-thorsten.blum@linux.dev>

On Fri, Jul 04, 2025 at 10:33:08AM +0200, Thorsten Blum wrote:
> dev_hold() already checks if its argument is NULL.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/rose/rose_route.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
> index b72bf8a08d48..35e21a2bec9c 100644
> --- a/net/rose/rose_route.c
> +++ b/net/rose/rose_route.c
> @@ -608,8 +608,7 @@ struct net_device *rose_dev_first(void)
>  			if (first == NULL || strncmp(dev->name, first->name, 3) < 0)
>  				first = dev;
>  	}
> -	if (first)
> -		dev_hold(first);
> +	dev_hold(first);

I'm not a fan of these sorts of "remove the NULL check" patches in
general.  Sure it removes a line of code, but does it really improve
readability?  I feel like someone reading this code might think a NULL
check was required.

I guess there is also an argument that this is a tiny speedup.  That
could be a valid argument especially if we had benchmarking data to back
it up.

Of course, if you're planning to take over this code and be the
maintainer of it, then you get to do whatever you feel is best.  So if
this change were part of a larger change where you were taking over then
that's fine.

regards,
dan carpenter


