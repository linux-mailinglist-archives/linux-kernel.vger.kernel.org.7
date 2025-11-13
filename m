Return-Path: <linux-kernel+bounces-899684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8721C58B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4894A2FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F342F60B6;
	Thu, 13 Nov 2025 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPMNB2fR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A722D190C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048532; cv=none; b=P9Pq3RFXxSusnLokW+lWJm8MEYdIoxz8/11nkIGoAbKYa0bRRTVCnMRHKD9KQYd2e+OvtXAJDuoG/oak5I7n53GS3CBZZAltG3Wxdft8GTR/KVV+2sy7TpvdQ6/ZRoLu4c0E9WnCCx6cAwxUQrs3NknMl9WtmBTI+mfsibKM6MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048532; c=relaxed/simple;
	bh=uufp0c+6vRpS7yu0MiSOz3lgC+JY/1RrawKtcoSuby0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNImqJZoxIMfGcASBGulCIe/huRgDDdjzl6OdbIiWwvg/7QkpgXn3ZffPKYz7WDZBlucQ5JHUNV5bGCL2hCR5cf0/REVWgEXOBwFvQBTbpuY66LfUzni+KkvpOGOIOOd6aZyxmiox8zdRxBCsXShMGrHOBMppr1LAgRfOkUNqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPMNB2fR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47117f92e32so8428955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763048528; x=1763653328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdckbTlZRYgwauz5tn8aS58Sj8fDyGi1aX7HfTm8ByM=;
        b=yPMNB2fR6wVnfJh68UysMP2+/VTKcbYUhPTXHv1+5uKMJzWrAj8d3CalVx+2yBglGQ
         G4vgAkSCwPd1HBPKtrfff+EjVv1pEBPqgFcgT59tckc8ZnU+B9ZmpvJhArkCN3jdKQ93
         2oKQ80F4O3fGxd9vKEU69QZQsc18V+wJKYwwb6GSWPk7l1Snyxr1gjR4ZIDrtJrgQWm0
         UF/kTwuM+IQ3jyHfJy3vtqh2krHgCMNfUcGh86qRCZXIdCUDDsB+5chr4zSvK/bbuEGF
         4JwiATiB724Yxo473xZjr+npRiSklbemj+7Un5ljfec0lwPE1PBIf/kCuC/2I+LFi4iN
         1LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763048528; x=1763653328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdckbTlZRYgwauz5tn8aS58Sj8fDyGi1aX7HfTm8ByM=;
        b=IkQrL/U962L4F+sfTKPJTBjDUkXcqSNYbGFxvBKBWod82w40411TEcBNpM/NFbkj+T
         pUZZ56v71J71vllfSH0IL3Y67kpIZduAnVxSr56APMNyPI6ouBOtoQU7q0yBRmQOSZcS
         ZJz9/n8Iw+Co1RoKNf0rpZ+QWIxUEtfzu1/S6iiyCyVBibgF5m/KKN0yFgwpqBiA5bl7
         2+gxr+fS1bsty+2JIHKV4yzQ2T39eCXSnBPdFYmFjp8vJcmZPaVNKnBQDVVsdSQUr/bY
         ZiMZ4Ayt1J/ifxa8KTZYeTN/pf9tCXUtWEQspyPLWhdvCv5SIFEHnUyQqx3n0x+NjVEH
         686g==
X-Forwarded-Encrypted: i=1; AJvYcCWJwid/BquGNDI6M8wvc8PjTY94wJmMbrA2SoJghcvQLQOe2TWQk5Bex+6G/t/oiEpKyl3yaZJT7yeTH3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUKVTp72UE+t3wEfQ6kq8pm2/oQBUA85RhU0+8NvQdI4u6uuQ
	z/vCjQ/1B75ulT17wy6vmHwAMnXT8uFOM3jJGWCXnj2O59pQYUgMGfmkK04vKid18wU=
X-Gm-Gg: ASbGnctCyMW+6OWiBCCSnQjf1+xIPS00zy1UXjysQS+GUdDZfLXf00fs43jduC+87fH
	6rwUInTC6a8fZrNokNS/WM+B4qbif5IUoKJzyAbOdODzydWfVXQ0ryOo1rduDkiJTrntX6AYQ0C
	ApCUcqs8DgTK1CZzHyYh36xhxP6rTdSVHIF53KGgOUqsN/XadM3y7IqmNuNge5JVgMLI5H7wHVt
	Y1UlYJ83M3YDUZlZnoDNFBqzRsjhZTLBP63Hrqv+YCjDGG0BzHNaI5WpVkHvkRPJuBZovxRw/Tc
	fYH5j3r6JJXsPdNH6cdK1dkEEZz4Oj7KNlBsIHaIqTPzwYDi4CTQz2E0tIy4eUXflC9iyyBJKWn
	+koz0DDLdBy/i5bfberD/1MTABNpJwZVEi5zZaA7E3MdjfeKkf9WEvBUjAsEsLWhdFNaBNoVwOf
	X8vzj5Cg==
X-Google-Smtp-Source: AGHT+IFlCo98BPfCIQ5CH901ne1qG93gSkHrk0bVofSu01+xDEnw6EvzRBsaTLdl3pxJ6Hq04gASjQ==
X-Received: by 2002:a05:600c:4585:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-4778704406emr72935215e9.3.1763048528417;
        Thu, 13 Nov 2025 07:42:08 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e35b7esm101023995e9.4.2025.11.13.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 07:42:07 -0800 (PST)
Message-ID: <a7c3db5c-bad5-401a-ac97-d59f81950b92@linaro.org>
Date: Thu, 13 Nov 2025 17:42:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
To: Pratyush Yadav <pratyush@kernel.org>, Haibo Chen <haibo.chen@nxp.com>
Cc: Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
 <20251112-nor-v4-5-e4637be82a0a@nxp.com> <mafs08qga9ehe.fsf@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <mafs08qga9ehe.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 4:47 PM, Pratyush Yadav wrote:

Hi!

> On Wed, Nov 12 2025, Haibo Chen wrote:
> 
>> The MT35XU02GCBA flash device does not support chip erase,
>> according to its datasheet. It supports die erase, which
>> means the current driver implementation will likely need
>> to be converted to use die erase.
>>
>> Furthermore, similar to the MT35XU01GBBA, the
>> SPI_NOR_IO_MODE_EN_VOLATILE flag probably needs to be enabled.
>>
>> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>> ---
>>  drivers/mtd/spi-nor/micron-st.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>> index c89c06b1fc61a581fea2e18732be2501a15715f9..f94e9d2d17bf4aa7c36ba3aa37d34f767a9f93ac 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -204,6 +204,16 @@ static const struct flash_info micron_nor_parts[] = {
>>  		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
>>  		.fixups = &mt35xu01gbba_fixups,
>>  	}, {
>> +		/*
>> +		 * The MT35XU02GCBA flash device does not support
>> +		 * chip erase, according to its datasheet.
>> +		 * It supports die erase, which means the current
>> +		 * driver implementation will likely need to be
>> +		 * converted to use die erase.
>> +		 * Furthermore, similar to the MT35XU01GBBA, the
>> +		 * SPI_NOR_IO_MODE_EN_VOLATILE flag probably needs
>> +		 * to be enabled.
>> +		 */
> 
> Maybe I am missing some context from previous patches, but why are we
> adding this comment here instead of fixing the support for this flash?
> What does "the driver will likely need to be converted to use die erase"
> mean? If it doesn't support chip erase, then it _does_ need to be fixed
> by using die erase.
> 
> Also, why does the flash "probably" need SPI_NOR_IO_MODE_EN_VOLATILE?
> Are you guessing based on datasheet and do not have the hardware at
> hand?

Yes, no hardware at hand. He can test with mt35xu01gbba which is a smaller
flash that share the datasheet with this flash, so that's why the TODO
and not a direct change.

> 
> The changelog should also explain _why_ this comment is added here, and
> not just repeat the text.
> 
>>  		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
>>  		.name = "mt35xu02g",
>>  		.sector_size = SZ_128K,
> 


