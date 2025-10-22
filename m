Return-Path: <linux-kernel+bounces-864117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C69BF9F37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037333B1393
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8C2D7813;
	Wed, 22 Oct 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="RRDW9RU7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320442D7DF2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107667; cv=none; b=mwEF/lhMgkR4lmvMoE9qX0cax8+5Q3xE0plP+6o2L3C6/zMdcRdlpbBtVeDMAc7AKqy86FqpaveTTq0t1U8MwvundhzkNJonsl0S3qIs+JqxvlnfLx/Kci94kAqZkjBU/ol04zTF3Sh9Yzj5zf624Oa3SZZ4Ck0cdp4zglS9ohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107667; c=relaxed/simple;
	bh=M0//wu4eodGM73UzE+/RSQN3dfA7ycS4x9S8XdOl3lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONwyJMaCCLqA6JvnZ1IIo54NmnPAOGpu9+bkivGbhZiOcfpJQsoiaKKo1IAEt3E3u1LAsi1kezRYn6Lsdyhv/JL22kG8T0HBF9GhwRTvk3X44+0fgVBBYat0SQLTZ5aXDok0RHJwaie4lNKkbGwV6uScpLyPyynPzi/44P9kQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=RRDW9RU7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-269639879c3so60415265ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107664; x=1761712464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EssM+PiDmpcGAGhJSWtJ6fJ+4b18HXlZ45HuXkPg0+A=;
        b=RRDW9RU7laJZmotdYwqR2m9vMwxpOoZhDjjRrTxfpvoceparqP8yt9dy6aDGl4Q2Lo
         MgtMpUfcsfZHPpecLRfUL+Q2xr9tMVwBuC6wRRQ9LeIGO1/C60zWBO+DEBWfyX3WuwRI
         iTvi2q0p03ObVjo8iJgDJQMcEX0r2vK6PexfYRCn7Cu+ELm9v9ErffEqJyTOzf+6Kvlz
         8gMfbjdwWVfnvLGPcTUA8HbvxKj8WJOnToTGRv6CN+Pqnh3pur5Ks8fkdA9giLSdzyu7
         boo1MqqIcd+va3CFmsVIEXkBMAuso/NgRFC32llsNpO0Rpe8zD7FRv0u1cEcc4G6wjSK
         75IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107664; x=1761712464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EssM+PiDmpcGAGhJSWtJ6fJ+4b18HXlZ45HuXkPg0+A=;
        b=Wdkk1T9UYG0LldAC8kvpxg4nY8q2cltNbrsIOl59D8IXBZMco2oGQ1WB9DdkSzmzlZ
         f2BnuhLuVIspweD5oh0fJmll0HZfxjAyhTZGZ5U0E3fPv5nzgJmCfBqOPWfsps44sLVn
         vIG/c5D0lyNvVEjvkRJPt33nbYki7BmA0EiK4gzQ4Uug4AXq9oIqTsyOQxXujtF+8mi1
         Fjn3ElTH5KOJwshjs8OM6AXSkpN68GkdP94iOiSKgx0ICsQp7CSZfDcvw7xCTxTTTBgi
         /YpbdIR0z0yJRXWCwh31cdvNQAk+AYWPMy6lWUSdRjEaEMxJkv3ncSYe/NdYOkehhdDk
         Sc3g==
X-Forwarded-Encrypted: i=1; AJvYcCVWt95mMQTgkseiAjbSAY4Mb8QeheR2ln0g43u9D05s2NlXgNiKMOxIFheMuIv82wy9JnoWAtLda8cXqzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRl4ZROgY3OLPUYi37mKXx2SK/eWKYhQ+IvEvztXnKNS4nZIlu
	DA4k6r5NkFFGaoceAq2TxHPsfmLDMjArRY5HwBYZw0wA7mftatN/p0CHMLl9dFuTtJI=
X-Gm-Gg: ASbGncsQ5nI/tr2gkhaqhbfTjKg/oKU6bE96xvj53B95K4lsJ6yykcI/JL5qs4x/gpy
	NA8ztzY704bi54KNSjQc8CumziKjlTl0bBCfPqityTz+Yr4j72bB8FJr5Yke1+8ta+yWHomLNHw
	XYl4uFTkh9ExG+0RBHZN124j6JE16eX/mlVTyag4b8h83aLe2GM8/ybb6g+2cG3VTHUIH7SgEP9
	IfZ5LVrxl2VuoeO3YExT2rXxNzC0vCmBGIOyHhLPesc/vpf987pP9FUKT5DgfGuRUoV8L/sOsTt
	s4UrQVJqjL0PkLdEliaqgFO3wzK1DH5nWz+xguQfuDO5z8epMcQbeDUn28lDZxMupRyc8xrCX+8
	83y/OI9iNnczIrQU10/7iMS2TvJgQzGp/cQcAL+TKxTWpoEwu0aQdRPU8pWDwoXZnZvV//KeZjO
	6PQw9xBMKw/7kR
X-Google-Smtp-Source: AGHT+IF+2IOi2vlkb7frAQI7xnO/+5ggSuzSXcXZ4DCJ3RIWA9BMWmGP9exglnUcXrvVgUWfIgCoyg==
X-Received: by 2002:a17:903:228f:b0:24c:ea17:e322 with SMTP id d9443c01a7336-290c9c89cbemr234187615ad.3.1761107664444;
        Tue, 21 Oct 2025 21:34:24 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:24 -0700 (PDT)
Message-ID: <d13590f1-937d-4ef6-8d2f-d0647557b695@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] spi: fsl-qspi: add a clock disable quirk
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-5-elder@riscstar.com>
 <aPaJ479zH/90fJ2d@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaJ479zH/90fJ2d@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:13 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:47AM -0500, Alex Elder wrote:
>> The SpacemiT K1 SoC QSPI implementation needs to avoid shutting
>> off the clock when changing its rate.  Add a new quirk to indicate
>> the clock should not be disabled/enabled when changing its rate
>> for operations.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 1e27647dd2a09..703a7df394c00 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -197,6 +197,11 @@
>>    */
>>   #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
>>
>> +/*
>> + * Do not disable the "qspi" clock when changing its rate.
>> + */
>> +#define QUADSPI_QUIRK_NO_CLK_DISABLE	BIT(6)
> 
> NO_CLK_DISALBE look likes not clk disable capability. Maybe
> 
> QUADSPI_QUIRK_SKIP_CLK_DISABLE

OK, that's better.

> 
>> +
>>   struct fsl_qspi_devtype_data {
>>   	unsigned int rxfifo;
>>   	unsigned int txfifo;
>> @@ -306,6 +311,11 @@ static inline int needs_tdh_setting(struct fsl_qspi *q)
>>   	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
>>   }
>>
>> +static inline int needs_clk_disable(struct fsl_qspi *q)
> 
> bool type?

Yes I agree with this suggestion.  However all of the other
needs_*() functions return int and are marked inline (neither
of which I would normally do).

You want me to add a patch to update the others too?  If I
do that it will look more like this:

static bool needs_swap_endian(struct fsl_qspi *q)
{
         return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
}


					-Alex

> 
> Frank
> 
>> +{
>> +	return !(q->devtype_data->quirks & QUADSPI_QUIRK_NO_CLK_DISABLE);
>> +}
>> +
>>   /*
>>    * An IC bug makes it necessary to rearrange the 32-bit data.
>>    * Later chips, such as IMX6SLX, have fixed this bug.
>> @@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>>   	if (needs_4x_clock(q))
>>   		rate *= 4;
>>
>> -	fsl_qspi_clk_disable_unprep(q);
>> +	if (needs_clk_disable(q))
>> +		fsl_qspi_clk_disable_unprep(q);
>>
>>   	ret = clk_set_rate(q->clk, rate);
>>   	if (ret)
>>   		return;
>>
>> -	ret = fsl_qspi_clk_prep_enable(q);
>> -	if (ret)
>> -		return;
>> +	if (needs_clk_disable(q)) {
>> +		ret = fsl_qspi_clk_prep_enable(q);
>> +		if (ret)
>> +			return;
>> +	}
>>
>>   	q->selected = spi_get_chipselect(spi, 0);
>>
>> --
>> 2.48.1
>>


