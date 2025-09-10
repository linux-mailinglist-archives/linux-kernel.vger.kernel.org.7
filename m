Return-Path: <linux-kernel+bounces-810460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0155B51AED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BE01890F05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB42B218845;
	Wed, 10 Sep 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8n0CbPL"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B824113D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516418; cv=none; b=UDRuoKKLMO0QnXNxZJHK3P3v+6zYE4uXpz/IzMrMzK9Kv1CnbMIopnIaefJjxkEEGI21592DiN3ykjqzNB5VGR5p6iXnVWthNL2Rys6vtq9A2Nz9tXH0I/O+KghRLMAemc8a+352yZhAmTCSTl5+DHBqreK+g72ob0qqltST0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516418; c=relaxed/simple;
	bh=mj4aTjAhXm1oQMFjwSvdAby3YvIWkrlmqIlIG/NLtLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nca+UPmc2OQvzHGIHP7t7VI5Mc/S7ve54w2WfVZv/BGc0VdHedjqVFoQCYa/3Q03Lu1/gV4+dK22+sqqN6sslhxHy/h93cfL96/M9+RIUMTy1LA77/qQRZhQdxJGJZcAdYIM4A/DRJfPpjOoc3qc6OTBXicXHd8YavyWS+v0KYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i8n0CbPL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e751508f21so1448734f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757516413; x=1758121213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qm4BnuN4F+PgUIqciwrBi4SGMbZAHGuiuhtIXw7Lc+Y=;
        b=i8n0CbPLPSvmVToKwqdzCT12JrG0mjNyJ7KIgmGCMtl1KBytA5zA7Xxpf8Y0UrHAxM
         GUw+64j413BTo30ShDD4DvS84vYcjYemHTbBtckdA6J1Vo8lvrgtDH3WMDjVoubQOcb2
         mpsVxWxrDpivYCA8cAsjvmhjz1qUgrEUI9lgZ+yMVJbAPzFYx79esOLdfm5QHtLb3E9H
         wemwUwzaVPgnv1szWY0CxNNxJWzfhCih+YqLCB9b1hzebrOm4xqokxwoqZGbLBvJ/1Tf
         wtbv+DeeRdBt0JxREL109YlbrDcEc5D3I5cq1LG8U18SX3IkaJCUaJ5aSNGf/jP4PNS1
         PJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757516413; x=1758121213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm4BnuN4F+PgUIqciwrBi4SGMbZAHGuiuhtIXw7Lc+Y=;
        b=sls1+OiWbg95JAyFn4HkujLbZyUj44+hFhmf38y+J9P+OXy2m1BTEIjUSyA1ZFzbQv
         4d5F3g+dKjaYcQcB8X3SO508ayK9UiU1JUUBgxoN5BmI0mY4ETf4EfZI1cnRT7ugYzCV
         05MTk/WM+x7hV8UvZVdG8RgQo8q1gmuOHm1yA5U9Bd82W1WaQ9UooNznoIqRQtr+5zGz
         vW8o6kHVYjDr46/i37KSyzY/ltcGpLYBf897B1XF/7zED8fGA3pVzWToVb3PTEYhe+t6
         /jF6v74LNFc/+qLRXpwlZzDIldz3Rm363kHhBOIMTN9ZkIrD1FtGhMVqR6iNHfSrR5B6
         /9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCX75gVTQbikVu9ik1YpwAhBnaRrjqtDA1aYPce7bV6i0G0pdplm67isikxuM3Cic1kRS9vHpVeQiVFi97g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOddUpAYrV87mDSoc9P+c/vkA42aC13ES4z9VHIIVq2GLaFgGa
	oD35tW+ZylcJKOXSYIicICALYZYeGFs/CO/NqD2xgtNHPMgYQhct2CthQdTK5Fs48tE=
X-Gm-Gg: ASbGnctRnOBJPfkx+nHSq60i4GYC9AgEf96jiDcQrzT7XainKr2NlbZg4AmjIR7XszO
	4+3649xSfpKP4H5DhpbtHgz7kc+TnGdGT0u114vz9+2mvLwuJZtYYIvGZoOnwEcs4dyQOvwC91r
	7LsXZgy93o1KoMEqWhdpXiM6+teCQ1tgB78l6Umg4jdZPfvHZ82gYxLRpQkA7Zf3IK2eq21m4JV
	hu2RCWhzdxHpjiq9wgce/e9A4hDKtR2P5DYR0RFEmBhqU12A08kg3ak8Xm2toO7mlvgYAHUF1vo
	jKGABWp5MIPQvOA4P5rBMNaGTU6zhIMVb3Bv+Cta5tcjsZLBZu9nqotK5jH3L77APpguhnux6Px
	Qllx9C+PgE9GL5wvM28or0v0GX37v4q5TpJtX3qstFw==
X-Google-Smtp-Source: AGHT+IGZmk0FhRSVP3L+RvTwmEjLMIw0vFrPN+Kvpj28uGK1L2407qxDNR0B3/KgO9wxczRbTJMp6A==
X-Received: by 2002:a05:6000:200c:b0:3df:d8ea:1f7b with SMTP id ffacd0b85a97d-3e64c87e42dmr11763123f8f.51.1757516413111;
        Wed, 10 Sep 2025 08:00:13 -0700 (PDT)
Received: from [10.11.12.107] ([82.76.212.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223898csm7663993f8f.39.2025.09.10.08.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 08:00:12 -0700 (PDT)
Message-ID: <4991cd24-c549-4f4c-a7cb-c9f0e331c4bc@linaro.org>
Date: Wed, 10 Sep 2025 16:00:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: core: Check read CR support
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 "Jakub \"Kuba\" Czapiga" <czapiga@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Konrad Adamczyk <konrada@google.com>, Adeel Arshad <adeel.arshad@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20250910103355.629421-1-czapiga@google.com>
 <87frcucy3p.fsf@bootlin.com>
 <CABkukdpRxHFg9FbaV1GnS5UG3-ZxdxPbjKYdUpdmvOcLs5phKA@mail.gmail.com>
 <87a532cqnr.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87a532cqnr.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/10/25 3:45 PM, Miquel Raynal wrote:
> Hello,
> 
> On 10/09/2025 at 16:30:43 +02, "Jakub \"Kuba\" Czapiga" <czapiga@google.com> wrote:
> 
>> Hi Miquèl,
>>
>> On Wed, Sep 10, 2025 at 2:05 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>>
>>> Hi Jakub,
>>>
>>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>>> index ac4b960101cc..79deee3a50d3 100644
>>>> --- a/drivers/mtd/spi-nor/core.c
>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>> @@ -2608,6 +2608,10 @@ static int spi_nor_setup(struct spi_nor *nor,
>>>>               }
>>>>       }
>>>>
>>>> +     /* Some SPI controllers might not support CR read opcode. */
>>>> +     if (spi_nor_read_cr(nor, nor->bouncebuf) == -EOPNOTSUPP)
>>>
>>> There is a spi_nor_spimem_check_op() helper which might be better suited
>>> for this purpose?
>>
>> spi_nor_spimem_check_op() works only for spi-mem devices. spi_nor_read_cr()
>> handles both spi-mem and spi-nor controller. Using spi_nor_spimem_check_op()
>> would require adding a variation of spi_nor_read_cr() that would use
>> spi_nor_spimem_check_op() for spi-mem and spi_nor_controller_ops_read_reg()
>> for spi-nor controller.
>> Another way would be to do this check only for the spi-mem as spi-nor
>> controllers seem to be deprecated in favour of spi-mem.
> 
> I'll let that choice to SPI NOR maintainers but we've collectively asked
> to switch in favor of the spi memory API for quite some time, I would
> not care too much about compatibility with the two remaining controllers
> that have not yet been converted.
> 

That's correct. It's been a few years now since we stopped adding new
support for the SPI NOR controllers, so feel free to ignore that part.
All we did on that front was to make sure we don't break anything.

> But here is a proper illustration why spi-mem rocks and why SPI NOR
> controllers, besides making no sense (because we also have SPI NANDs
> now) have a flacky API as of today's standards.

Right. I'd very much like to see the SPI NOR controllers converted to
spimem or removed altogether.

Cheers,
ta

