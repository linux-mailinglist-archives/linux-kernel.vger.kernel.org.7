Return-Path: <linux-kernel+bounces-798861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B1B423FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2153BDEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE831EA7E4;
	Wed,  3 Sep 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RpoJeYYf"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1CF4D8D1;
	Wed,  3 Sep 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910863; cv=none; b=XDUsxj6biAZeACXuhFS1UmJ15SVtBMBso+6aaBpqP49VRSozAzne4A1jmwjYiEUN6T5A/lkhLOZZB/TG5TqWibggTXw+9Fb4xXUyjLrK2l/+OF/K3ABbwH1vQJgfdOGAddTZm0SzTpsusj/ozcDbRemQAdgdz7nINP/2SzmNZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910863; c=relaxed/simple;
	bh=uIiHVfgXcBHll4tp5RO1iUvvwxGAS287ADmVmicJIzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHhn27Jjjl88uaYJNEeH4C9hUgcySQYWcwIsBRIQFY8OV1RcBWVVwjJKhaghbqa0Sw9GndFurS1xsSBSL8I3B9OAnXaUHJfUoLJwlPaQ2uS/jdNu2trF2PPygZzgm3P/qIeK2rBZR1f8wCtmP0mLcvKhHcsYsn38W36Fpm/3u1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RpoJeYYf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6F08FC8EC77;
	Wed,  3 Sep 2025 14:47:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 80808606C3;
	Wed,  3 Sep 2025 14:47:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BC6A1C22D933;
	Wed,  3 Sep 2025 16:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756910855; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ujR0yYZ5vFQl06mtsamsbnkJePIHaLtqM3Tp5y6BL2U=;
	b=RpoJeYYf/ZHQRw1WFqCDTpBR6Tqg5/1v1LPVh9t0KkpFMj6ZUT+1o1EB987g4ZG6jaF5NZ
	Dm0I6Cdw8RRBspPKZ+ihoaeGMqbkoLI26dcFg6h9Y+3IAMpgrMUPipQnHNPRy+qfKbf42O
	wksiz8pIqvPkYuIz67rDkTvvUZMqu62Drro8GVFdbJhSo8DasJhqHsWE+DQ68I8pFNT6zT
	HbSjAJqnVcpPP5MMY5rLxU8dm+GBQewjQ2ClnRzN8B8NxkYNdjyT3XjoONXIS2d3TyyN8z
	cq3jekRx+zTS95mLK+Y8UY5pk4/XqCSXhRhZuhOqLiH5Yd1+/cG/tILaT4om7Q==
Date: Wed, 3 Sep 2025 16:47:23 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	skhan@linuxfoundation.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 5/7] rtc: m41t93: fix device connection/detection logic
 during probe
Message-ID: <2025090314472377b79cdf@mail.local>
References: <cover.1756908788.git.akhilesh@ee.iitb.ac.in>
 <c3deec9e679cd4e4a49a2cc1cba340c552faefdc.1756908788.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3deec9e679cd4e4a49a2cc1cba340c552faefdc.1756908788.git.akhilesh@ee.iitb.ac.in>
X-Last-TLS-Session-Version: TLSv1.3

On 03/09/2025 19:57:21+0530, Akhilesh Patil wrote:
> Fix the incorrect assumption about WDAY register (0x4) bits 3 to 7
> being 0 after initial power-on to test response from device during probe
> 
> Do not expect these bits to be 0 after power on as datasheet does not
> explicitly mention these power on defaults but recommends software to
> clear these bits during operation. Refer section 3.15 for initial
> power-on default bits.
> 
> Fix the random probe failures after power on by removing this condition
> check. Add alternate response check logic which performs write, read,
> compare check on device SRAM register to check device connection.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/rtc/rtc-m41t93.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
> index 8cc179e08a4a..902797070246 100644
> --- a/drivers/rtc/rtc-m41t93.c
> +++ b/drivers/rtc/rtc-m41t93.c
> @@ -30,6 +30,7 @@
>  #define M41T93_BIT_A1IE                 BIT(7)
>  #define M41T93_BIT_ABE			BIT(5)
>  #define M41T93_FLAG_AF1                 BIT(6)
> +#define M41T93_SRAM_BASE		0x19
>  
>  
>  #define M41T93_REG_ALM_HOUR_HT		0xc
> @@ -290,17 +291,25 @@ static int m41t93_probe(struct spi_device *spi)
>  		return PTR_ERR(m41t93->regmap);
>  	}
>  
> -	ret = regmap_read(m41t93->regmap, M41T93_REG_WDAY, &res);
> -	if (ret < 0) {
> +	ret = regmap_write(m41t93->regmap, M41T93_SRAM_BASE, 0xA5);

Nope, probe is not called at RTC power on but when linux starts. The
whole point of the RTC is to survive Linux. Writing to this register is
breaking functionnality.

> +	if (ret) {
>  		dev_err(&spi->dev, "IO error\n");
>  		return -EIO;
>  	}
>  
> -	if (res < 0 || (res & 0xf8) != 0) {
> -		dev_err(&spi->dev, "not found 0x%x.\n", res);
> +	ret = regmap_read(m41t93->regmap, M41T93_SRAM_BASE, &res);
> +	if (ret) {
> +		dev_err(&spi->dev, "IO error\n");
> +		return -EIO;
> +	}
> +
> +	if (res != 0xA5) {
> +		dev_err(&spi->dev, "No valid response from device 0x%x.\n", res);
>  		return -ENODEV;
>  	}
>  
> +	dev_notice(&spi->dev, "m41t93 device response success\n");
> +

This is too verbose.

>  	spi_set_drvdata(spi, m41t93);
>  
>  	m41t93->rtc = devm_rtc_device_register(&spi->dev, m41t93_driver.driver.name,
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

