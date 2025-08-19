Return-Path: <linux-kernel+bounces-775360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C3B2BE58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA813AC8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FAB31CA5E;
	Tue, 19 Aug 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdIooph2"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA417996
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597608; cv=none; b=lOlMiKIGK2ta+ycnZmbWlE/Lr4qVGnrFV/VEExh46LBi4DEg9lWlZic4ujAMdN2BEr7F44XzXbDKqcfreA0WZsCk4HVssGa/dSCxcfl2dc9pnvOoEZyzwOl8c5j7jHDfH5UkQcg3qVdCK6tYPjNaHjEqDxUBHcO9uKgqU+5gY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597608; c=relaxed/simple;
	bh=jzGnOmF7Sk4LwrNAoupPd1iop6vJLnCtHUZ3GO0ffG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A0cNV2Lx41ewiUyqZVzG/ydroLBQSiha52Cb89LUxt07zv9bjv+skGF3kvTUoz5pgsUHYHD1pJX86amFczEc9CbvI+Lf2XrStFX0tp4iuouCJGvJycSvSqUziy85TQFzogBMCScIWiD03JnMk/YwcAu06mG/xYl41OeHqGnf96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdIooph2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78c66dcso717377366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755597604; x=1756202404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjBR+kR0t8TJ8QuirCE4bg/F9pyLOUYw+FF6LSil2u8=;
        b=kdIooph2lqV0R4lJaAqUiRFto8KCbnHqUdqUc0UsKxtdmiVsbC39n6LkEaPrCqE90n
         OOacvCpM3z/Rw7dM37qltNglAAiOkGUgSVwnvkznYBsJaIV86sD8Hpu1zuixCRq4YK8S
         yZTjXVKlM1p3Rvf5xALrsyi5nF/Bi32snAOcQAGrPObj3tFC21T9OtG+cwxHbWYmhgVB
         WDv7gkVBlbKgo5PTQVyU5rbM/Dh88Ph0ubSBbLVD74Pjl/zHcY0Pfgss3c1xphH6aEml
         fU2IhvzAmqz+g1qB8FZBplSEbrG+iikKuLDrIou+LJIK3e7by/2XlJxWnxPURnWYtnrm
         5wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597604; x=1756202404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjBR+kR0t8TJ8QuirCE4bg/F9pyLOUYw+FF6LSil2u8=;
        b=WrGEaXd6oINfPg2kWcPbsUIZ5bQp2Tw/2dWfE+XayE9Oj3ixqF5oEFjvaxDatutXw6
         jKY5sFPz9SPEpXhw4fuqbZoA7nVKanDcBfKiWdxFLvB0q2CxYXNQTEZaeQnWImcOI56B
         HaVM/qN/LFny0kfZXDrx0l0+6tgGKh8HpqNqT67GZEnndC/yAJziBE23KF9/gE4h9htT
         LuWyPsN/TR1zGqdRzrhS7hO2V/jpqzFC5H3IL4Sz8AkWAX96Pi/lA+aQGZe7G5dOTqBP
         OUP9oBqUnWRnF2jMiBr2bW/cqqA7yGZCAKgKGma+IxILg0FiIdgQ/v0UJLJfGBTGl2Ka
         HecA==
X-Forwarded-Encrypted: i=1; AJvYcCXvxgLJhUxOTYJgxrc3JYk+cDZ9qp2PtgHgGaVONOuBOpk8Wcxa+iBG5LVPZ58zZvv8z8g0UgCv4a6Rd40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEf8J828zkR5lATzRPYYrNtriJiZvINb5l/nvK5Il69Xt19kv
	cUSuEsLzyVeZmOLeER6EZKAYiDakoWgd9GV6Rlbbt4LspVF8pchvff3vLYMsMzyP1nM=
X-Gm-Gg: ASbGnct7Q8E6qozPX9POXjGITkYS+8uvSIszVNc30cQEM/HGrS0ZHzD2gfxS8yrlB6j
	1qDL56seuFmjqKNASGZ2UN6xLLqTlGt8lB3knAsfbPxqjrzJYIHKgw4RidAgB592rYZMTcv56qV
	KZguN09NGBAgREKT9eA7i7oUX6/xYNYeoW3CedvXhhVOv5mgaO85pzQ+f94mg3xZCONr1J2GbWA
	iQAQX038a9vH1hZUd1HsuvK+6hWHeGk0GjCVqzOsMOle1REqH+9GV7cBVNKaer3+l/NvpMOMoH4
	p+UNDx3N2DcVy/yCtP7EW3ezQ7LhBWHHTbwfQES2j4a9FmpxMopAdIJJKaDnHQuuozaSJybeq9l
	xIcKKNycVFOrjGlV48BFH1i5700eI73FKRJSRshotXAsC
X-Google-Smtp-Source: AGHT+IFPRArZTdTP+NLIy/Vie9G8nvUNWq182V7aJXvkqOBztXScKlilBZHnaP0cP/Vv2uPVCLOzAQ==
X-Received: by 2002:a17:907:3f1b:b0:af9:a4de:f092 with SMTP id a640c23a62f3a-afddd1caabcmr172982166b.55.1755597604424;
        Tue, 19 Aug 2025 03:00:04 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.104.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccea7sm977812366b.67.2025.08.19.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:00:03 -0700 (PDT)
Message-ID: <e55326b7-7f52-4497-897b-32d67f522cd5@linaro.org>
Date: Tue, 19 Aug 2025 11:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] spi: s3c64xx: Remove the use of dev_err_probe()
To: Xichao Zhao <zhao.xichao@vivo.com>, Andi Shyti <andi.shyti@kernel.org>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "open list:SAMSUNG SPI DRIVERS" <linux-spi@vger.kernel.org>,
 "open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
 <20250819092044.549464-7-zhao.xichao@vivo.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250819092044.549464-7-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 10:20 AM, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/spi/spi-s3c64xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b1567243ae19..3a00f9e480c5 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1268,8 +1268,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  
>  	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sdd));
>  	if (!host)
> -		return dev_err_probe(&pdev->dev, -ENOMEM,
> -				     "Unable to allocate SPI Host\n");
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, host);
>  


