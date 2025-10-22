Return-Path: <linux-kernel+bounces-864118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D073BF9F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382554EC69E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ADF2D8DD6;
	Wed, 22 Oct 2025 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZHjikOvl"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E3C2D7DE7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107669; cv=none; b=LfYa6Eowd0r+iifYVExQtUaMDrlJC0UG3QP0l9x8nLWcR+zvieET78Agr5LZ5JI+7vzRa8Fbkk1NRXbmzywR7/Jt25izuvcZVMUXFYDJctaJ4a/FLjP/WhBap9KhkWKGfRQlrug6v+OIqx36m7x0kipaNAqQSAzlqCFAoMdMjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107669; c=relaxed/simple;
	bh=jzTEyl6EsyYKirucDMT2WpjFBD7rzCg5P5uTQ3Im7zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfOF+gwfLsSQXEs6lYY0WkSyYvYNYhr1mxbMmHQLDUMyEIHVcEwWwvOf0vrqai8sbXD1sASmvvTpEYBetNdJYbWGnGbrWrsdzgGsOGlfOfgEYgNQ6L67UawcWjCYQEtjCXYj0Jo/2yfu+5pND/+VuS43iRbSUB9PJcG2Oy7+UEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZHjikOvl; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b58445361e8so490675a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107667; x=1761712467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r07oRrpAm0dALdqxQgRoSXIP8i4Uf1rUZOTVIHgHy6w=;
        b=ZHjikOvlCUFLZzQFmYDBTGEQFBcxn32Aq/TgomvhA5bVqmz1oFuvD0yFTjqik163rv
         F06oojH/whjTqyt61/svwsIeMV44VC1l4w0LCWzO2r0AexemCn3GNAZKrYGr96pMANuT
         Bv0QyKH7FI1ty9WGGq72UFyIppMTRxxYKLL8Mdu+QuvQovJ4Gy6evnCKe9t5Q4U/eOul
         9RBentzkJvBrSms7yVMZwGmDZ7n+rhm4ENR0J9iYNo7an/L5Hv2ZDuI+UoLBim3nNFrI
         C3Z4PC2V/0opy1xQLjtLVe5Xu7FSaX8Xw++CIfrlX420n/Iv3nhSCZAeGWn3ckZHR9zx
         GmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107667; x=1761712467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r07oRrpAm0dALdqxQgRoSXIP8i4Uf1rUZOTVIHgHy6w=;
        b=e5nm1bHvo/EhybErJ6FoSoWASaAtgyHOSx8XoZyLML41G/p728UziUUfLCmIkMh7Wb
         VJ+FCL3XPCbSAvQ2ujccS3sUoQmj6TlbT2gI+VHUO+HkmSaCM2QPw4ZBVQuqeu/i4Ug1
         t3SuTAedPK0fA+KljvxejC5429/zZcW/S+fTLaA4t06Kew9e2L+v5dDHOlMevIUqC04P
         pa2DyuinSb0THPyQBk3e+Kg8B2cTzyHmTuNKI+w8RR8EVjKB2dOUSoIqGXx//OUEpnPK
         glz4Og7vz0kZFFYgurIY2AXvhGFb6CfCBJiNEJlYmSE7hZp1MWoiG3l/8k4lgYo+Wr6m
         g6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWSiXJscoafH4jO/g6mByK+vjNCvLT7nGFrILDnq6qw8i2Tyj+cX6lP/2foRr4oCGZG49fEQ6spzeirJkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfTTTHJNnoF5mnSKlrG75to6G+XKkMNiT3ic+TgPA7sucGUsc
	WbOvlHhve9cbEELOR+CIL68Q3ONaIwOn9/uV6rAmUI2bsi9jh2ZH5Gn6TCXEa1mTHGA=
X-Gm-Gg: ASbGnctWykrJsgQvFErPreyX/cyas9LHDtoYRGvGJZ05YMFwTSavk9VSh4tbCmTPSOq
	EH55M1aTNN/PGG75uSY/mQw8hVpz9P3dwwv9Rj6lSQYqmK3T+LyGy7WRHC4IUVTSRQ4H+VYn7+w
	wLmouto+JawBPuTMaWpTXtRb+DuH2XDlTSBp1nVTCkqgaJH6Zi5NmCQyzrCVDU5tuz7jBMcAQLG
	0y8iRicehdODqLRPc77Dcfx6/SiKpeuSSkGd8bhayyO5fxHkkGOoWKghj9OCoTrhwTuQef0FjfE
	RCNjWivjNmwsFljOsIAKRlg7PccLsXL9dFwAgRALLcLnitNH/Cc/v0HYMM7YPD1I3EQy7OD9YNS
	SnWL5pRUt7/sklQLnrnTsNf7yIKchzZhvTf8A8HLx2zsjneM5RtN3SPJ2BECnRWlShBaHoVU/VF
	FHqRqJckw7eQKI
X-Google-Smtp-Source: AGHT+IEXbwpYqOJzdRZX+yeVCW+HRgEFHEhSfhpnfqLc9E63Y9hId0Tl9GklX8WzGZZ/QxYr9McgUg==
X-Received: by 2002:a17:903:17cb:b0:292:9ac7:2608 with SMTP id d9443c01a7336-2935e02e491mr1133385ad.8.1761107667134;
        Tue, 21 Oct 2025 21:34:27 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:26 -0700 (PDT)
Message-ID: <06af60b7-7ef7-451c-babd-e612a356013c@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] spi: fsl-qspi: allot 1KB per chip
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-6-elder@riscstar.com>
 <aPaLibm+oVKSDbL9@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaLibm+oVKSDbL9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:20 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:48AM -0500, Alex Elder wrote:
>> In fsl_qspi_default_setup(), four registers define the size
>> of blocks of data to written to each of four chips that
>> comprise SPI NOR flash storage.  They are currently defined
>> to be the same as the AHB buffer size (which is always 1KB).
>>
>> The SpacemiT QSPI has an AHB buffer size of 512 bytes, but
>> requires these four sizes to be multiples of 1024 bytes.
> 
> I think it'd better to add field at fsl_qspi_devtype_data, like
> sfa_size.

OK.

> sz = q->devtype_data->sfa_size ? q->devtype_data->sfa_size : q->devtype_data->ahb_buf_size.

Why not just set sfa_size always then?

Anyway my biggest concern on this was what to call it.  What
does "sfa" stand for?

I'll do it the way you suggest for v2.

Thanks.

					-Alex


> 
> qspi_writel(q, addr_offset + 1 * sz, base + QUADSPI_SFA1AD);
> ...
> 
> Frank
>>
>> Rather than add a new quirk to support this scenario, just
>> define the four sizes to be 1KB rather than being dependent
>> on the AHB buffer size.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/spi-fsl-qspi.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 703a7df394c00..9ecb756b33dba 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -795,17 +795,14 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>>   	 * In HW there can be a maximum of four chips on two buses with
>>   	 * two chip selects on each bus. We use four chip selects in SW
>>   	 * to differentiate between the four chips.
>> -	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
>> -	 * SFB2AD accordingly.
>> +	 *
>> +	 * We use 1K for each chip and set SFA1AD, SFA2AD, SFB1AD, SFB2AD
>> +	 * accordingly.
>>   	 */
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
>> -		    base + QUADSPI_SFA1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
>> -		    base + QUADSPI_SFA2AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
>> -		    base + QUADSPI_SFB1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
>> -		    base + QUADSPI_SFB2AD);
>> +	qspi_writel(q, addr_offset + 1 * SZ_1K, base + QUADSPI_SFA1AD);
>> +	qspi_writel(q, addr_offset + 2 * SZ_1K, base + QUADSPI_SFA2AD);
>> +	qspi_writel(q, addr_offset + 3 * SZ_1K, base + QUADSPI_SFB1AD);
>> +	qspi_writel(q, addr_offset + 4 * SZ_1K, base + QUADSPI_SFB2AD);
>>
>>   	q->selected = -1;
>>
>> --
>> 2.48.1
>>


