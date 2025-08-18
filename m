Return-Path: <linux-kernel+bounces-773890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA09B2AB77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D769B60DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69735A28E;
	Mon, 18 Aug 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAN45Hiz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709A1F30A9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528470; cv=none; b=newC/q+RAzx+cb5VIi5cJb4yqdCEZ0hILu3OdMCTNT6TMU1mVHpVexIKJoN5wffzwgY659fi51vPoN1ZsH+5CR7z73R1SRLEdbiy5MyjctKHAdxHMwWHmUnn2T8AuP2BPtNIlgEH8ya3j/VgjTVIfenqYvaUkVOmwkd+OscKt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528470; c=relaxed/simple;
	bh=ifoUL3jsCD9QEp5E4RW0WnOPPi8gp4Hdi1nn9ecnFcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDpFQKSpuj7DmOX+GYuLcnnzGOd82+PP4Axur6LNGaQCy9C5IFtymaVo5WNBZ+zmaUNu9JgjR+ZIRiuaSY+t1fMAI+sO6Ilp4DrcO68ccPm9bTKNlAZqH1n1pLhS+XXEjKccCTe58w05lcc9fzl9tT3br6h0jp7YNVvOAaRN++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BAN45Hiz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b004954so30230745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755528467; x=1756133267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2afKEgQbtq+HgvwtCFhX+9Qh9FWO4YX7knoa3B5YJg=;
        b=BAN45Hiz2Qj4hCIRXveL9HB0BSO2CMtvCrh3krvifgd+Azvm4k4NjaK/fG7PpqfbaW
         Sy7ccYoDN3EtweDRrZeFJneNK6egI/EXfugzG46CsKdM6WlH0B2Fqdm1chHooKM4NCBg
         0pGB9eFEAoPSapdLu0F9z8T4U3cDMmyoY0U07tlx6XRKlJ/StLT0vZMwL54R0KlLGtwK
         jfryBzz6Nsq9yatFCeW8L9bvrHzxU7Vm4yzN2UDjjbw2Rvz3suaMwEz4s3kgqb/Z5yK3
         iy2GFRszC4xFd43LzqXxTqxaXuL5B596z2lm9trgIVDyB56qRcsGujwkTbU2ymRJdxGG
         P2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755528467; x=1756133267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2afKEgQbtq+HgvwtCFhX+9Qh9FWO4YX7knoa3B5YJg=;
        b=DsdnAJCd2iJ2dWkAuhBUGBgPXUk88GpXxMS1qM7mw1n+AVY0geGERM2LhfQMzzLaJU
         /fvCrn4wlcKhwLXG99tbaEZU8UlX7iUkizwBVOME6ObNNnJ9bSJJvznDnwdYnDhwZIzo
         P682BWdwuw3tZ9/XCeTQtt9iHygo78y+SrXmR+phUfe2yhmhpTz94w0GRiYuJNZwOVTB
         fttyYOcBOpUOgmqs6Va0Q+hThFK08NPQv9ZacBIespgjCoVnaUY7FmIt3zUVECxw/RLV
         QheGD9Cmqu7Cb0DCUVTjkszejUovQDb80e4A05psY+Pt+qZEhAx4VTCpfLlE36Udyddh
         TBpw==
X-Forwarded-Encrypted: i=1; AJvYcCU8sssLkMLwJREbpQkPtopgVkE3zKe08CUxGSeOlCIkH08sDzIJU1b4XG3tnEMLf/fBJsuGkmvAqLTqeow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzU20vqPr0L9fZyieO5gYNlAsQ7lJ/M5fP4qgr5L4s6i0lO/wB
	f/I32ykMaOJedw1ynx4xCooqDapk2vY6xEVipVBkrh6a+OASogOoXIU8l2rHU9i+l6c=
X-Gm-Gg: ASbGncvzL8bPn93jtbf/6RzL3wrPlFVEMooQFhqbq0fpQCkdAexohdHAKK2DsX6h9uJ
	V6d/N1ZInETKmTB+PsYZokMnEIBGFyGpJeijqp16EAmTT5CnOpd33LSb1IlBOm03l5ORabjSna1
	8aSes0r/oULIgS0T+h3Eu3UOMZNORTYo/2eqYrnOYAw9kFiQVDHLgPujf8UHTISNIi01ACyC9Md
	I4yjwiC6fncXdcF+CRGWoBVSBBL/0YZD2f8FSKYOkyO5kLCFsqptKuM0PgO73AQct9T38Ev55BQ
	GYxEqrgJVRDe3xtRoo+LbUNpeIz7mzOs3Asl3ilflLhDxu6pxt6XePYAXstjbm3hr0leWbYn1gD
	IctbDivfx1wwknefck/8iYAHN4iY=
X-Google-Smtp-Source: AGHT+IFQZt9NUrq552ZnmOgo1r2cW0JA2ngaMERpzFx/grzhOblNLS8XApQAK6JESCty8GRa8dkPGg==
X-Received: by 2002:a05:6000:4027:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3bc684d7b99mr7876232f8f.19.1755528466878;
        Mon, 18 Aug 2025 07:47:46 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9a8asm13066641f8f.39.2025.08.18.07.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:47:46 -0700 (PDT)
Message-ID: <bd59344b-9dc0-42bd-98c8-80ab9ca97123@linaro.org>
Date: Mon, 18 Aug 2025 15:47:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
To: Frank Li <Frank.li@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
 <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:19 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:52PM +0100, James Clark wrote:
>> Document the two valid pincfg values and the defaults.
>>
>> Although the hardware supports two more values for half-duplex modes,
>> the driver doesn't support them so don't document them.
> 
> binding doc should be first patch before drivers.
> 
> binding descript hardware not driver, you should add all regardless if
> driver support it.
> 

Replied to same on "[PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for 
S32G"

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> index ce7bd44ee17e..3f8833911807 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> @@ -70,6 +70,19 @@ properties:
>>     power-domains:
>>       maxItems: 1
>>
>> +  nxp,pincfg:
>> +    description:
>> +      'Pin configuration value for CFGR1.PINCFG.
>> +        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
>> +                             output data
>> +        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
>> +                             output data
>> +      If no value is specified then the default is "sin-in-sout-out" for host
>> +      mode and "sout-in-sin-out" for target mode.'
> 
> why need this? are there varible at difference boards? look like default
> is more make sense.
> 

+ Larissa. I think this might also be a question for the hardware 
designers about why the feature to swap the pins was deemed worth including.

I'm assuming the flexibility is given for routing reasons. If you have 
another device with the pins in one order then you can route it without 
a via if they happen to be in the same order.

> SPI signal name is MOSI and MISO
> 
> Frank
> 

As mentioned in the commit message of "[PATCH 05/13] spi: spi-fsl-lpspi: 
Enumerate all pin configuration definitions" the names were taken 
directly from the reference manual and this doc text was too. I think 
diverging from CFGR1_PINCFG could be potentially quite confusing. And 
MOSI isn't mentioned once in S32G3RM rev 4:

   Configures which pins are used for input and output data during serial
   transfers. When performing parallel transfers, the Pin Configuration
   field is ignored.

     00b - SIN is used for input data and SOUT is used for output data
     01b - SIN is used for both input and output data, only half-duplex
           serial transfers are supported
     10b - SOUT is used for both input and output data, only half-duplex
           serial transfers are supported
     11b - SOUT is used for input data and SIN is used for output data

James

>> +    enum:
>> +      - sin-in-sout-out
>> +      - sout-in-sin-out
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -95,4 +108,5 @@ examples:
>>           spi-slave;
>>           fsl,spi-only-use-cs1-sel;
>>           num-cs = <2>;
>> +        nxp,pincfg = "sout-in-sin-out";
>>       };
>>
>> --
>> 2.34.1
>>


