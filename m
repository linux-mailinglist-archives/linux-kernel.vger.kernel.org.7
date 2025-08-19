Return-Path: <linux-kernel+bounces-775127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E928B2BBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128BF527FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FFD257AC6;
	Tue, 19 Aug 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmDZTJF2"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD0C30E0D4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591674; cv=none; b=kzbjmePcnhY/OksjrQm1EucaLYbDhs/TO5PjJNh3EL2+aSPOOzuyd1hV2uzjn2WB+Xox5vTGPYZSWVy7ZZk5LRz9czgEdqqcpTsO7xk/tW8keo8pa4ycsw5gL6i4CE16RN9fS6m/PTdNLpJ8KxMLn4CXJA54smwtEp44E8VOAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591674; c=relaxed/simple;
	bh=wUlUXNYlT2av8wbOvTTdJzvL3+bwtI0HGI8+TD3utoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cefeQCd+0tyVP+CEHHSQpXjjW5rg2KOuu+hNfv3hAMHsb8IN2UX/3qLUCfVQLPkiXkcuuD4XfjYHdiMq3svLYJhJsinNLYm7drEdS/BznsTFQIOGf/i+yGSQ34ndhN6m2K60hDk5NA8LpJPpAASlgDZOvebRTYA+0GGYLDCuhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fmDZTJF2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e4147690so3325846f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755591671; x=1756196471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYn6biyygAUVxiflH2dTAhFnJ7gRMdUiaEcaWo4kcaM=;
        b=fmDZTJF2mG69Ua/UVUnJ2SscbGShP8niY3cJvTDWgpIQKRnSEQ+XxoJPAMhnpxQjKS
         2hSOQsNKf2IWePq1N6am0Maq+s+HNOP7FThaisiC4S7rk/s+RHUzKsJhyVcUpJDM32SK
         zQCMa+lLILxx/V3oHJD+ZYU9IazkdqM5Runv2BjAPy2fpxA/sjNFuVRvCIgKuUGzszre
         NkrRUK/gTv7VCUt4/4/EqKAhXh1HD6SKRoEEmm5ZVPjh8V37XGzb3HPxc4lazUCM/vbm
         Ko72WSMvkt1tFUjsyeBshSyAjfBmu80PkfbJrARUzwXWcs38xxfdkNFZ7V+JWKNpym+l
         /kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755591671; x=1756196471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYn6biyygAUVxiflH2dTAhFnJ7gRMdUiaEcaWo4kcaM=;
        b=mdop2JRDNhhoX9ziFR2QDdwBWHZoFbkZTZAq1re4Peg3m3xX70xrphvdhDP+nL9DGg
         lWUUrIFQld5aQj5ad/Pnmi3HeYMrsoUPNc9QK+gGNrGlfGrilx9oKI/Cv3axyeFSIr9O
         xMLYbgWp308mBq+StUUjOpXldnL3xjaatIUByqIFmFjga3V4zzOa5gRUkeh6hKlhzSbh
         chigYWWIRf6owlUP9cuZOveP+eUmztr5nw696WDoyIQ2ZQDrbWfANxsoi21C/zoNXnCy
         w4t1Y/CuaUBnQxBGviGUwQ0HcwF9JKwHz2EaXzZv+6CML2/drJDRFycLLc3KBblsVnRw
         t4bA==
X-Forwarded-Encrypted: i=1; AJvYcCXLL/qlonybtzBk5Sdi78Nn0nqxiQUCShn67VWLHTaeGnNayTyVCH9+uTS3YiwPjO12Am/8vkH/FWusFYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMd1VaTXJqAzR61kNX5ZQW3G1y9Fktkzg1M8GfjEG8W5GX4rQ
	qjWd+M/74L3HUp7OvQ48xNcNvjLAkrtnt/6ydQ9ac5a2t1gUmht7QX4ib77HObPsCww=
X-Gm-Gg: ASbGncs5qr/1sZVrRqohWrawB9bb5hPvcKyBWbb54m6bU0gSX3osm5o/DIwDQs1yYpC
	ZFIXltxteh8G/G8TfFcZfHfbT9yFV/KOV1zIVazH5RDVcGUOXsKYXw2cKdyDUXwrUu+PJws5Eta
	uj/NsS/h9SftUiDQjA14k6nOSygeHfyPEDMZVMZcqOjCbVR6ckw9I/j6b9RxPArr/sKc3Waaz5C
	vz2xFuJR3GY1ghGYo+OhZxlCe9athdSv/Y6kk8OwjuhV3KX9ogZRKbOW1mvfCzESgDSxK0FBdCR
	3RqnAjNAnUo1gpRsfjvY0OD/8mqVLaPF6liLs2qD0sagJ2BnMXPO0Ub3kUD6GpcxmIlFjWoAHqG
	Km3Ti7M38JM/LgvWrUxAFCt59gyk=
X-Google-Smtp-Source: AGHT+IFMCXCK9wgxZ9X1waWYq1FWyGk6N/vUke9mVrMaFS0aIoajO/AFuehg2yaWUxtXmN5DBKI78w==
X-Received: by 2002:a5d:5d0d:0:b0:3b8:f887:c870 with SMTP id ffacd0b85a97d-3c0e9f01259mr1308081f8f.19.1755591670842;
        Tue, 19 Aug 2025 01:21:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c56454sm2659047f8f.58.2025.08.19.01.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:21:10 -0700 (PDT)
Message-ID: <7a81e256-ec55-4baa-a054-04c4fba0b5c7@linaro.org>
Date: Tue, 19 Aug 2025 09:21:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
 <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
 <90d40899-c9b8-4628-a0b5-06ee0aa497be@linaro.org>
 <aKNEfJrD+pp8+0dT@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aKNEfJrD+pp8+0dT@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/08/2025 4:19 pm, Frank Li wrote:
> On Mon, Aug 18, 2025 at 02:05:16PM +0100, James Clark wrote:
>>
>>
>> On 14/08/2025 5:49 pm, Frank Li wrote:
>>> On Thu, Aug 14, 2025 at 05:06:42PM +0100, James Clark wrote:
>>>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>>>
>>>> The driver currently supports multiple chip-selects, but only sets the
>>>> polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
>>>> the desired chip-select.
>>>>
>>>> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
>>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    drivers/spi/spi-fsl-lpspi.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>>>> index d44a23f7d6c1..c65eb6d31ee7 100644
>>>> --- a/drivers/spi/spi-fsl-lpspi.c
>>>> +++ b/drivers/spi/spi-fsl-lpspi.c
>>>> @@ -70,7 +70,7 @@
>>>>    #define DER_TDDE	BIT(0)
>>>>    #define CFGR1_PCSCFG	BIT(27)
>>>>    #define CFGR1_PINCFG	(BIT(24)|BIT(25))
>>>> -#define CFGR1_PCSPOL	BIT(8)
>>>> +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>>>>    #define CFGR1_NOSTALL	BIT(3)
>>>>    #define CFGR1_HOST	BIT(0)
>>>>    #define FSR_TXCOUNT	(0xFF)
>>>> @@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>>>>    	else
>>>>    		temp = CFGR1_PINCFG;
>>>>    	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
>>>> -		temp |= CFGR1_PCSPOL;
>>>> +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
>>>> +				   BIT(fsl_lpspi->config.chip_select));
>>>> +
>>>
>>> Feel like FILED_PREP(..., BIT()) is stranged.
>>>
>>> I suggest #define CFGR1_PCSPOL(x) BIT((x) + 8)
>>>
>>> Frank
>>
>> It's using an existing macro that everyone knows though and I found 65
>> instances of exactly this. It can be read as "set bit X and put it into the
>> PCSPOL field without any further investigation.
> 
> Where have such pattern in kernel?
> 
> Frank
> 

Grep "FIELD_PREP\(.*,\n?.*BIT\("

65 results, e.g:

   return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));

James

>
>> If we make a new macro, first the reader will have to jump to it, then it
>> still doesn't immediately explain what the "+ 8" part is. Using FIELD_PREP()
>> also has the potential to use autogenerated field masks from a machine
>> readable version of the reference manual. You can't statically check your
>> macro to see if + 8 is correct or not, and it also doesn't catch overflow
>> errors like FIELD_PREP() does.
>>
>> There might be an argument to add a new global macro like FIELD_BIT(mask,
>> bit). But it's not very flexible (can't set multiple bits) and you can
>> already accomplish the same thing by adding BIT() to the existing one.
>>
>> Thanks
>> James
>>
>>>
>>>>    	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
>>>>
>>>>    	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>


