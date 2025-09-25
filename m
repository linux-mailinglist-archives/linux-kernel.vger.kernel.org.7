Return-Path: <linux-kernel+bounces-831893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C1B9DD36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF42423BED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF5084039;
	Thu, 25 Sep 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQd3C2NU"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6B1FDD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784600; cv=none; b=e/39zZjJAQhIYAfGss2Fd71NZuK8Uu6omtaohjTTIJ3fHRsTgX1Fh9lKee2F1E73Y5XE3FhpRTuTL06n74m3CwTRDbRhsvPuI4hUkZu1V3pO74t9udMMTqwBpAtxMXQSEMy9wYC4njn2HTDM1dh88g0J5AuWVtju6pp9J38yXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784600; c=relaxed/simple;
	bh=vILatFAFS8HlIjTQk1vMFe0nVe5DI0PDZLkSgEpZ+9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkAzz3AmtE1BRdbyRY9Etz5npcl1ErhwlFsnEtwZpj276rMxANYiRREnIESsC8K9rm/sG8Q452w2YhqREKjeRstjO+CbmAItIxSWrR+zYVA7vbS3w+mvBbOpQoxqdEVlR1sRHyKcvhh7ALIGnXJ7ti4Md8M+ZXykPfaw7dN/V1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQd3C2NU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4060b4b1200so700679f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758784595; x=1759389395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Up56yeXe5seXQKdJy3u5l5LSHA9K6cXydBHqXSkVjA=;
        b=UQd3C2NUpd0yqd1/4vgQobF5LNFED9DdIGaJGbOeEazgssCCNjJsfPGhnnPIrNrvKS
         Sf71iRlxqM0eEs916G/VsBZUq325My0EdEBAY2M5w225ZaP/4U/5ID/j3FRXKb1jMkQE
         +um5nTk2U5nUsKC003LFSoSkJQeXYNxhJ+tU/7GLiaUCG7LroIMEAsWrsn/wkUpFclRp
         xwogtbURpR+Uu0EfwCh6CzDKqo4d/srp/O/l+Y5WcaYIoN8fejZwdP3N1Xv/+jIWSSq9
         6QsEWVt0Mf0ouUxlevnXn9feqZRClPubP8KXrzN2wtRNnEkgXGe5+xZHHzELLQOamzhG
         q4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758784595; x=1759389395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Up56yeXe5seXQKdJy3u5l5LSHA9K6cXydBHqXSkVjA=;
        b=OTRukJRm32MNsGAR0Ea+NxyY5t/m1/jrroNZlinJaz7SKFPmbKUOYWMoan+Vv7y3Od
         fDzOv1G9xhAXh5hipI0K6hLPmQHqY9eUt1DMhawzxYMKfnkaGh+6POnQaCzOyWCt2KC/
         4G35U2qaLJ1IzJZ0EkFf8N4a9n8wOD7lHphEh2c98qbdqWDHgFFyad44f7zQUxftUEgT
         F3PWwCNBSeyiRjsBUzPGWng9kJ2ySU6VohnyhUSPkvugFpl28XGtuOIDzCJ0DsSCl4xZ
         d6dBSviQwOKlSZE7ebfikjIyw7z5gwDOOxi9uX0QM22IxKND3NqGUBxKPBd3+1jjd5iA
         VhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJlyeWBCtVxEJa+oGJRMDxV0AZh4Rhyxvbx6zj8+0t3j1s3fIlOVYWVF6JbaT4lPPoyhaK927+XncPxEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1n0kYH5PEP+x6DwvFPzT6MQdh6L+4yE2IPU8fu4NZwOI7fCQn
	i6krEA38vNSYgEl6WFobWOxer2FwP0lGQgKtk0W46kVjGiO7OegT0Tfr
X-Gm-Gg: ASbGncsbiLtplVeZIB3wRup3+SdQL9ouBNtrVWMjG459+ltW2JjVEG48rU+szpFNhu7
	m0Fm0ygI1XBWdEl5+HM+KHKU/X/S17xFU26ktmY6cqGV2rfS9ezHbPDloH2b+/KNas+ryjVXqYc
	KR1bJjkm96kicV4NaOJo6zeoguujlJ6EWu0uryUf5/VnBgN5/sHQOtVjp/txusYclTZq8ecSE/i
	k56jWwXpUpVKqZtK49Gpq/5CDA0GjoqTYlaw3SXJaA0FUdalM6Q88hEaswqM6tPAZNlWS2/Qjvk
	g390g970DiACTDjtkGQmWuji01BgyVJeijaF5qBHowT22d5/z5ysOF2Mm7ipy30FyfY2UYZ7nQQ
	6hHHIged3j9k1DFXcnpWUG/3bRK3u2TgkxDHKvLuUCQY=
X-Google-Smtp-Source: AGHT+IEHcboXnBOyHaAZASOT1VSfKPdv8Bjhgsa8EFn5kSV5CqA5cEeATY+PMl/LCbvVXM/l2xI09g==
X-Received: by 2002:a05:6000:4382:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-40e47925a6bmr2769248f8f.25.1758784594858;
        Thu, 25 Sep 2025 00:16:34 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602f15sm1667407f8f.39.2025.09.25.00.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:16:34 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:16:32 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jorge Marques <jorge.marques@analog.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Frank Li <Frank.Li@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] i3c: fix big-endian FIFO transfers
Message-ID: <2wtpklapw5ogsevuvk2l4ngvw7hymer2y4cc454h47u2d7tq44@4mknmpk5yzil>
References: <20250924201837.3691486-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924201837.3691486-1-arnd@kernel.org>

On Wed, Sep 24, 2025 at 10:18:33PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Short MMIO transfers that are not a multiple of four bytes in size need
> a special case for the final bytes, however the existing implementation
> is not endian-safe and introduces an incorrect byteswap on big-endian
> kernels.
> 
> This usually does not cause problems because most systems are
> little-endian and most transfers are multiple of four bytes long, but
> still needs to be fixed to avoid the extra byteswap.
> 
> Change the special case for both i3c_writel_fifo() and i3c_readl_fifo()
> to use non-byteswapping writesl() and readsl() with a single element
> instead of the byteswapping writel()/readl() that are meant for individual
> MMIO registers. As data is copied between a FIFO and a memory buffer,
> the writesl()/readsl() loops are typically based on __raw_readl()/
> __raw_writel(), resulting in the order of bytes in the FIFO to match
> the order in the buffer, regardless of the CPU endianess.
> 
> The earlier versions in the dw-i3c and i3c-master-cdns had a correct
> implementation, but the generic version that was recently added broke it.
> 
> Fixes: 733b439375b4 ("i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()")
> Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This was a recent regression, the version in 6.16 still works,
> but 6.17-rc is broken.
> 
> v2 changes:
>  - add code comments
>  - write correct data buffer
> ---
>  drivers/i3c/internals.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 0d857cc68cc5..79ceaa5f5afd 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -38,7 +38,11 @@ static inline void i3c_writel_fifo(void __iomem *addr, const void *buf,
>  		u32 tmp = 0;
>  
>  		memcpy(&tmp, buf + (nbytes & ~3), nbytes & 3);
> -		writel(tmp, addr);
> +		/*
> +		 * writesl() instead of writel() to keep FIFO
> +		 * byteorder on big-endian targets
> +		 */
> +		writesl(addr, &tmp, 1);
>  	}
>  }
>  
> @@ -55,7 +59,11 @@ static inline void i3c_readl_fifo(const void __iomem *addr, void *buf,
>  	if (nbytes & 3) {
>  		u32 tmp;
>  
> -		tmp = readl(addr);
> +		/*
> +		 * readsl() instead of readl() to keep FIFO
> +		 * byteorder on big-endian targets
> +		 */
> +		readsl(addr, &tmp, 1);
>  		memcpy(buf + (nbytes & ~3), &tmp, nbytes & 3);
>  	}
>  }
Reviewed-by: Jorge Marques <jorge.marques@analog.com>
> -- 
> 2.39.5
> 

