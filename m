Return-Path: <linux-kernel+bounces-773638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACBEB2A397
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C3E1B60430
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005CE31E0F1;
	Mon, 18 Aug 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txS1dG3I"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC703218D5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522322; cv=none; b=rJrsDwVrpU8McUumfwzatz/JjFdAiBxX1x/X8xQ5YMeqyNDDP+3P1Gm1DCaRSgDcONK/sRe5RySxTEUipqDhwGs3P4bcU+8IZC81gIHFtVje9QUeqtgL5sumbG5ZGeJYvyOzN018Xl23maaZQvCgJlHUwaUCfmXJzEaOfQ8Er94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522322; c=relaxed/simple;
	bh=RpAhxP2uLqbqjInuTE70JRXrQca1fdqD+vDq2S1ckfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iM5w+ZLFa9i9drgT+OXuBlfAC2hnHd7sxMMXzvHFLODKLU2SD1sXEzHnLNXms/1Obki3tCjsOzx76j3FaejlVwSTZTgUBfPe+WUSQFj19nu3bqXTQounu5oeJ/XrdQaXPFbUypkm6vsGxHft78qytnIi24cekNgSSYC4ETWjS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txS1dG3I; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9e4193083so3891764f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755522319; x=1756127119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86BJmrJXeETeW2kp8meE7Uq7AvyYwzMOqYpCJJXyfLs=;
        b=txS1dG3IyrSDBriMFeWWgHeQgrwquh8uAPpEcdMV0g79noALWuVRWDccj7GLJ7S74Y
         xkcSjVV0TP3EUphTRiqj2wd00Nv2vZtKKlt1+cDQk7vHlDVDZWqNg6CFHB5jtR2pYed4
         KYa/OM2BVxixE02a5tGd5K80r8nMYfogIWCMXiAMVqBbLFZxIJP4MTmZ/M/xq0ln6npN
         bJFKbOMdXwvy5iqAHXiX3HMH8XHxU0VRsE89AMD/mE/GT0+6VlT+0LoB7/CsNA3TtOoN
         0FmczBnNwrvZHas8ZQEyissCYVIzhwnGkBJyR0OlpcvH/LtbFw05tsOL04Z7JnJuRv7X
         6fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755522319; x=1756127119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86BJmrJXeETeW2kp8meE7Uq7AvyYwzMOqYpCJJXyfLs=;
        b=Ec3hO6wXJH4fSnIofkTWDT/8BOOPERa5dPHcLaSnQRW/w4PozNIC6IxVbEGMfbMETX
         dYSqIQDPxmTACmp187B20GJozXfpAuDCmej0VWPfwn+1hIIt3nPfo/WekSG+wnEVJead
         ljOlNKIp7w7J4oNqk/GkScx2S9ktXkEe+3v/hdMSWDd9KipYFMf/pJocDRnF8pNroE01
         Lx7DuwAgiT+xoyiegqalXN1SMGaMj6svgRQdLpVycdHtCEp3656ZaLeROUc3kUyAW8WF
         m72o8q16A1nXDXjoxwOMBA8m/lnqcBB3xmT8zntuDyMHL3K42gXQwPx9bxQtEfMZ3ICn
         Aa0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk/SCaGkQ8eiJcI12Tz9TEauvRWy2gCrjdN32JVL6UF9x4RX+ffxzA1fslAnTdUf+nW+h/MGRDC1t33pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9LNu2e1Fyp35WoG3/IhMYTPG9bt6qYRQjCpOK2210jQtilieR
	Cg/HmTsNa8VTwPJ/1F0pxnPbCr56SW1yrRs2Zrkl0TmnNuhkpoYa9iD+UztXuP93oWk=
X-Gm-Gg: ASbGncu3v78v8wcSUcao2NC4ty5MxjQS8rxRmJRSRFVRT5GFcrh93MXTVjyQ9juugAb
	ZuuYI7ZCxEP0832vOLwm2bZnYSt5+NaGVzNcgo8CkjS+zJbGRdF1zyRk2EoVXlHHxQh3httv8lt
	AQ1yfnU3d18XAgG2tQ9OIbYYVjsGqrpSOHmhxZsqeMo7lAZbjIjw24unW1j+yePqkZU2+wMDAw7
	c6TC6Q2HO49q8x/+vm+tbqjkHrOKh4UMy2uFwuIZeHQ6gLlm4vCojFfoi8BfyaCEw3cl2RsU3cQ
	9XrU8B3sx8qk07eK5EYN/8eSAg3o7jx7SDVFw8vidmjaGivKHNGcJT0psx1uLvxHIhcbm6X+H0f
	HU8FhEWjTHhng9qOx1Zol2zgpuMIDks4dHQAytg==
X-Google-Smtp-Source: AGHT+IHcwykrBK8tXrdhApeeaxgZhKOjTfFirzDPuKeFi7nfZYLL6OLNQGBRz5fJTm0ZvXzAmYWt9A==
X-Received: by 2002:a05:6000:1788:b0:3b8:d493:31ed with SMTP id ffacd0b85a97d-3bb690d3800mr10683315f8f.47.1755522318746;
        Mon, 18 Aug 2025 06:05:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758d1csm13236548f8f.8.2025.08.18.06.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:05:17 -0700 (PDT)
Message-ID: <90d40899-c9b8-4628-a0b5-06ee0aa497be@linaro.org>
Date: Mon, 18 Aug 2025 14:05:16 +0100
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 5:49 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:42PM +0100, James Clark wrote:
>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>
>> The driver currently supports multiple chip-selects, but only sets the
>> polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
>> the desired chip-select.
>>
>> Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index d44a23f7d6c1..c65eb6d31ee7 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -70,7 +70,7 @@
>>   #define DER_TDDE	BIT(0)
>>   #define CFGR1_PCSCFG	BIT(27)
>>   #define CFGR1_PINCFG	(BIT(24)|BIT(25))
>> -#define CFGR1_PCSPOL	BIT(8)
>> +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>>   #define CFGR1_NOSTALL	BIT(3)
>>   #define CFGR1_HOST	BIT(0)
>>   #define FSR_TXCOUNT	(0xFF)
>> @@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>>   	else
>>   		temp = CFGR1_PINCFG;
>>   	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
>> -		temp |= CFGR1_PCSPOL;
>> +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
>> +				   BIT(fsl_lpspi->config.chip_select));
>> +
> 
> Feel like FILED_PREP(..., BIT()) is stranged.
> 
> I suggest #define CFGR1_PCSPOL(x) BIT((x) + 8)
> 
> Frank

It's using an existing macro that everyone knows though and I found 65 
instances of exactly this. It can be read as "set bit X and put it into 
the PCSPOL field without any further investigation.

If we make a new macro, first the reader will have to jump to it, then 
it still doesn't immediately explain what the "+ 8" part is. Using 
FIELD_PREP() also has the potential to use autogenerated field masks 
from a machine readable version of the reference manual. You can't 
statically check your macro to see if + 8 is correct or not, and it also 
doesn't catch overflow errors like FIELD_PREP() does.

There might be an argument to add a new global macro like 
FIELD_BIT(mask, bit). But it's not very flexible (can't set multiple 
bits) and you can already accomplish the same thing by adding BIT() to 
the existing one.

Thanks
James

> 
>>   	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
>>
>>   	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
>>
>> --
>> 2.34.1
>>


