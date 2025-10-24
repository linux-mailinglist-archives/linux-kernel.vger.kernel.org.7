Return-Path: <linux-kernel+bounces-867918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D9DC03ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF621AA2F65
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073E2BCF5;
	Fri, 24 Oct 2025 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Ra456RKt"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70BE33086
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264250; cv=none; b=E/k3M/z9qo2JWLfrcWCT2QZqAYam3YnQG2/Gxc8mcU+rAjvQwxJTVB5oHwwmdX3r3Ystj/orV5Ufv77PTdCISV/EA5iFBjmwUpnsfhcVDVreu2+oGoUYEGEV1Vqk+Snlra/0YqXFs9d8ri8KudPNjskOBEsg4ckI/JLlIeztp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264250; c=relaxed/simple;
	bh=PQewqef8yzvtBnGMpEYxHFkLVWv3yesJZz1LSiXZ7bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnM4e3argzNC7X4ZUE2BXdq4gf6w91hdaAeF+vLIar70tyJFbj0+ZZsiGm4kTJBGcSUPiGTOrstgG5j9rnBcXWQmmTZHwtNl4oy8JFWFzwLy99+JjSsSOickjfjsRq5u1ru9iiV2YrtaaChUxcuPaQbhUWO4Wk1g90IjcIUgbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Ra456RKt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-292322d10feso12353275ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264248; x=1761869048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iB+cZBHLCpSws7+7BlwrY++97OnOWh6DYfkP9FhnwvQ=;
        b=Ra456RKt+p87Z+5ies0CTv89TWrQCPK7lbWxIH0eBhWlxEnqI4yBsK1BqumB6uL2I5
         VYsgSukp1FYWJQ8A344agSKJbQeP1SJjZRthEALNXkloajZ6BcW1a9EMPPGYxMcMMFSY
         2lqHI1byB2VO8Dk7gnrw5yzkAKTaE3tCltY7in3UTsx4vnIXHKVhC368bdmBZoLgQamh
         T///7SWmLfFO6nx4pG9SQq2ypMQ6urUiKZroSmdCkF5hteRz1vzBv6R0mmY1BnA8thiO
         AYVY2KD1jDKqWJVyqV2UzG4kRqBTVfwoh+v1TeZZMNvi2bPDX1lStqQmLyzEYTpk8AjO
         La1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264248; x=1761869048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB+cZBHLCpSws7+7BlwrY++97OnOWh6DYfkP9FhnwvQ=;
        b=S3nHWNYgofmuj25U20kqhLSvYAWeG3PlFDPBt+qJ9BoN1I7L+Stg8Pst97WB5tNjRu
         NiKZeVOVYNB8MqQVVoZZn7qjkaoAAVswky5AxQFTFfSY8SDo8wTICsD0fMRn1BEyygJa
         7pwvSFMKQOf0JJD4iecskfy92ynADqsSxJQGDfJlOZkWNxenUq+Y5kLsVysBsMzUffp8
         uL06IbIP38CHwxOx2TTeLUuKHpc9L7Nq473U/Rmt32bkGTI4dwKduzGc1lFwlNShdepN
         3xSoGXSiDulcqpiZuHa/TdT3OK08v9um/69htnc5RqoMnvaLEOTfMIs4sg+MgbtF+ueX
         KE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW//x+BGx1x2cSaSiya2/8uiRH5mjO+hhXJ2QQ6jehVtdtyiHYTdZJekvbPews+0+XK9LzPabO2cRxejOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBz1lf03Pa6vWT0ed3j3bAADaymrRsN3Dfr1i1+Wi+We/lMGvW
	pBRL/Dkd7YK+xM1PrcWFFSXWooO9uAzj7z2enm0yKhpuzGeWxGya3FOuuRkfhnxi9QY=
X-Gm-Gg: ASbGnctVgGTkAEyVoxs6UXkfZvl1x9toWqe4/YY6INnU7Wnm5niHYk47MyLLYqZtaAD
	HKQn7Vbg8GYV21129r0isUD4HYeU7JeHPRg2KvCAO57PZ2YBxAgPUg9eWpU1fcuITzoh+VCuCyt
	vmRwGfs3JWK3a1W2Cku14hSj78uxFUpzGBG11ylVeLGsNEoUtQn75YKSQreEvNXhFp91+gnfZDJ
	0gZi5OxFQNjWvtzuZTDC6lEzFcWtAfNpdqazgOr/o6/zh7HjWSGu5cx9AYj7N5uETy63foZGFD9
	KyGI0PQPP9nnwUFpEdM0A+skszTMLLipA+OObLM0MACN+rilyue9U3m3rurTpg3Zi9/cfAIz/WF
	E2pkL7vk4uTd9uSSLAZD7BTWQojCTGDDwFWllSllPXxxtW7elCtiv44G8AJTk9ITwxRXfNmU8Lt
	MRwhMjgjnboYHS69gy
X-Google-Smtp-Source: AGHT+IG1GOEsittfwiwfypAgRO1bXivhphlMMbLL2fhQ3i2Er7Mu9kpHhxTrXPCZNYaEGYBC76LFsA==
X-Received: by 2002:a17:902:ef4e:b0:290:d8f0:60be with SMTP id d9443c01a7336-29489e70291mr8426785ad.30.1761264248064;
        Thu, 23 Oct 2025 17:04:08 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:07 -0700 (PDT)
Message-ID: <aea95912-9f06-4a3c-897b-d985c18e89e8@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] spi: fsl-qspi: switch predicates to bool
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-5-elder@riscstar.com>
 <aPq7ZnKrxbokwHxP@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq7ZnKrxbokwHxP@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:33 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:16PM -0500, Alex Elder wrote:
>> Change all the needs_*() functions so they are no longer inline, and return
>> bool rather than int.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - New patch: predicates now return bool type and drop inline
>>
>>    patch (patch 4).
>>   drivers/spi/spi-fsl-qspi.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 1e27647dd2a09..1944e63169d36 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -276,34 +276,34 @@ struct fsl_qspi {
>>   	u32 memmap_phy;
>>   };
>>
>> -static inline int needs_swap_endian(struct fsl_qspi *q)
>> +static bool needs_swap_endian(struct fsl_qspi *q)
> 
> why drop inline, and next patch needs_disable_clk() have inline.

That was a mistake.  I intend to drop inline on all of them.
Will fix.

					-Alex

> 
> Frank
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_SWAP_ENDIAN);
>>   }
>>
>> -static inline int needs_4x_clock(struct fsl_qspi *q)
>> +static bool needs_4x_clock(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_4X_INT_CLK);
>>   }
>>
>> -static inline int needs_fill_txfifo(struct fsl_qspi *q)
>> +static bool needs_fill_txfifo(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT253890);
>>   }
>>
>> -static inline int needs_wakeup_wait_mode(struct fsl_qspi *q)
>> +static bool needs_wakeup_wait_mode(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_TKT245618);
>>   }
>>
>> -static inline int needs_amba_base_offset(struct fsl_qspi *q)
>> +static bool needs_amba_base_offset(struct fsl_qspi *q)
>>   {
>>   	return !(q->devtype_data->quirks & QUADSPI_QUIRK_BASE_INTERNAL);
>>   }
>>
>> -static inline int needs_tdh_setting(struct fsl_qspi *q)
>> +static bool needs_tdh_setting(struct fsl_qspi *q)
>>   {
>> -	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
>> +	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>>   }
>>
>>   /*
>> --
>> 2.43.0
>>


