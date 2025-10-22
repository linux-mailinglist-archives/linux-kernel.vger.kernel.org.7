Return-Path: <linux-kernel+bounces-864119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D1BF9F40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 922344EA379
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9282D9798;
	Wed, 22 Oct 2025 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="gnBDGDz9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7CF2D948F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107672; cv=none; b=Z0R0ihyEmbI72+mhq44HZBe58byWbOMU72Y+3BuuQVWNktKYFb4+Muqn3eQ+ZdvzdCve9t+FHAx5VKSZ+KT4jL3PF9GMGJSuFP9CXLjpfvtdsvkuF0DHjDZPCJ3R2x+gixJFOphKk6awVT2JUG2ewosQ8XxtM4XrORpkd7tz7lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107672; c=relaxed/simple;
	bh=Goyx1DuFl/fOnbQXpijC04VlfkeSYrobSs3FUEza79w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJonQq+e2FffK+5CuETD4EGzJLKNWTt3qsW280jkmiDKoEM1ewciGU9kNDC4t/XWmL1XvE5kscmzlrajl5947si3V2MVfcKytQ3T0zCCoO1f6yZjf4Vf38jLIp82HwA2EqidYU8aaoEECV9aRxgwkGZOCZH5C7bt1+ZcWzyCW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=gnBDGDz9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5515eaefceso5223383a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107670; x=1761712470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDiGuotIxX46vya9PSPOnNWB7duItx5Jd361PWPn4+w=;
        b=gnBDGDz92BzY9Xf8L9luYAk431jG9f8kAbslyXTVcqrK3jXeN3GBulVMam0QacRV4g
         epN05+WR7Aqdtkz8ydyZi6rF6vUEsgzD1fICPQOkJJYCK9dW70rNpJTjM7GUcGHGFcH/
         r4hr2Cv88L8Ak27Okvh3rkeX81e8Su4OqyBQmmeCkQjhdJzLEevN4YYiHoSNt4r65Gm+
         09NSRXIS7MwcOESvskN86Yn3OFMvg3RaxNR3jbMl07InJ1rKkOlbTwVt+Ugg6iVYEuv7
         20QysUeaMGlKFfDpjCguoEowxThQsBuULM6B5vhmQrlWwg0QjY1nWTweJTfDXxKc7iad
         6m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107670; x=1761712470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDiGuotIxX46vya9PSPOnNWB7duItx5Jd361PWPn4+w=;
        b=RdbQLvuAyliTB6P+CMMpHVcJUS9I4wq5Cx/VcsUgt4GwIIoLLcSAYAWg6oJ3ByYUdN
         EVCiGqiXFny8c5xvxLhIUXwPN520rWU10cgBl9E9m0zc4MAtC+0Frinea9Wvq7eNhpVK
         OqnoA5tE39bJdcF0k54BrRAP9fiEq602/rLELNLdO7k59o9TOjPnjaHrN2+ql8jys3EX
         eL3k+/Df6VCQTjFBsg60jbEDxclUELUAQa6ZZN9+aBe4M4Ms/GhSyutd1YaDiI5FAw8D
         QhWJYfiN11Jc4kKJUJWTX6f3y9Wl//5hx9zNZkx9guKOrRYaRwL+YdvUUi+lj2kDv8gK
         lhpw==
X-Forwarded-Encrypted: i=1; AJvYcCW4eCHHDbbxk65B+aOsogm6LZLSeoF00ksRKF6GYSdebNJDAb7KxNG3plcEiIgQPW1CsCVsFet+gHfsrBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjHmTLXCib95bkQ1dEg4Usz7ziKBK2ISTcgEPdhiDf1RAPmzWV
	t2FOFZ09hhe8ZmC447W2682YE8m+93Jj9Dd0klN1r5YEhaloXD51SXBRqAbcz4MviMg=
X-Gm-Gg: ASbGncv0VlOAD9hzJFDYFM3ybxXF8ymZ0cv+THVqAmFDBc7nT7eL9HU6Lm1MF5pQ87z
	qjvVLFALdw+zntX9PFvWcC+TUPUx/bMkcTg9EF/6LxqnEHendDEsRFQgXT+CZMgfEY47COabrz+
	77MUjV9lsYb0vfk5N8hnDEbmmf+IfiAMbV8EObA9cXKGAuGa3cUc5Q3iEKEzJ8huX6Q+hq9oriD
	uCuV58IgGkIxdckwuslzKzDm79ykMY/5uWV0by1b0PmtGYhXg3al26Qth9H4//KtUldlLud0xwa
	lRqY8//IDAFo5z5uE16WcBCuu2IH60494Ze+iEM5tySAXQOPjWiisccQ/JAg0Zn5ynb80XIyOh5
	nII76LF0987XXKip/dgvgyLlptwbcLw/7HtYk5xOhW1Blcjw3qCS9hPtK9PANo8So45WlvRBAJx
	SlIVBx+Gg/a9KDpo46kMUJRmSk7XmyGmR8/g==
X-Google-Smtp-Source: AGHT+IFAmBZDikILCClmp+7vVKcnj+i3LKl9ZiDVNdmnt9krXWJ4kKo97aK6dBcsuheQDKRB7IIDbw==
X-Received: by 2002:a17:902:e784:b0:292:39b4:e785 with SMTP id d9443c01a7336-29239b4e9cemr216223575ad.26.1761107669783;
        Tue, 21 Oct 2025 21:34:29 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:29 -0700 (PDT)
Message-ID: <91bd83c0-c721-41aa-9716-a750b73c7e41@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] spi: fsl-qspi: support the SpacemiT K1 SoC
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-7-elder@riscstar.com>
 <aPaML32I0Ao1xhpX@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaML32I0Ao1xhpX@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:23 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:49AM -0500, Alex Elder wrote:
>> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if
>> ARCH_SPACEMIT enabled.
>>
>> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver
>> by defining the device type data for its QSPI implementation.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/Kconfig        |  3 ++-
>>   drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 4d8f00c850c14..2e3d8bd06ceb2 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>>
>>   config SPI_FSL_QUADSPI
>>   	tristate "Freescale QSPI controller"
>> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
>> +			ARCH_SPACEMIT || COMPILE_TEST
> 		   ^
> 		   align to here

OK.  I was mimicking what I saw on the only other instances of
a continued line in the file, SPI_BCM_QSPI.

					-Alex

> 
> Frank
> 
>>   	depends on HAS_IOMEM
>>   	help
>>   	  This enables support for the Quad SPI controller in master mode.
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 9ecb756b33dba..f4f9cf127d3fe 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -267,6 +267,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>>   	.little_endian = true,
>>   };
>>
>> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
>> +	.rxfifo = SZ_128,
>> +	.txfifo = SZ_256,
>> +	.ahb_buf_size = SZ_512,
>> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
>> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_NO_CLK_DISABLE,
>> +	.little_endian = true,
>> +};
>> +
>>   struct fsl_qspi {
>>   	void __iomem *iobase;
>>   	void __iomem *ahb_addr;
>> @@ -998,6 +1007,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>>   	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>>   	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>>   	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
>> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
>> --
>> 2.48.1
>>


