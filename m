Return-Path: <linux-kernel+bounces-867921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 87665C03EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC661359BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B824B28;
	Fri, 24 Oct 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="BEppYB+d"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E27189BB0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264261; cv=none; b=De4eD1l3NbE4Wob8GKZnMsNCCcnRPWbJ06ShPEzcJSEZXP/AMWKHCCQBTl5SMUineXvziFZefSk2cUswHSC4dmjj1YYCR0SBhP8dZVBqyvkeJ5oaBPuWrzOvMlMxOEoLPPCnk1V0CPLxrtIr80pcALnYRKLkju1B4w6NmJV0tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264261; c=relaxed/simple;
	bh=dcbemmyeeMmTnjiRx8pMVuxWJgKXnilUcIcodBpT8G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFogbrPE9hhNHME7KsuBVJUSI1QyN42Te8/nQZqC7EvC+6OneF0JSRdbv+XXCAJP+NV39f7HHmV8Lfl6L8rsHmeN34xYfUCCYL5YTcaqurKQgrncrj70DxIzoyEyKOIGrVO2PBXltk1Tr/YXKUPfYcNlpCQwonAvs6Tg2pRLUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=BEppYB+d; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33bb1701ca5so1409378a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264260; x=1761869060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+K9cJwbaPRk/hXgfMNgGGaWCdBEf3vNiXBdImnfxaI=;
        b=BEppYB+dZR/HQkBHf02ZH4zQzKbxMtB1UqBZrsoNFDa6n4UpcsNp2viYtufYTl1MxU
         FoKSUJTxDvCiMgyaV+yw90wnnI7sYU8a0mv7oFu+tBVZy/RQaFKoOEVBiIEOVbiUpUtQ
         HQ5UTFJWtvMv0ecWbMpZOicbK2fzVsbTIXNMhBYfknpORadqGMmQ+MO1vjg3UcFYyAFg
         TEfqw5QAhDCirUCm7i9PFsHpUVv0s7AdDyz/J5gXfg8NHi23bUwTAtKZWqDkn3tySzui
         DT/TfLSRHkA26kky+scX8WSZO/LrOuEtiCUUXiXGB66lTsbxMeF6DenwJ2mqKzKiyqsN
         /XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264260; x=1761869060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+K9cJwbaPRk/hXgfMNgGGaWCdBEf3vNiXBdImnfxaI=;
        b=eWPzlAmUVD7mVz4nRJRZNVjzckuLNC4+Kl8de8BasQBQI/yqvkD2ruyrY2JkjrdqgE
         R2HCplnS+q8yvB77bkFgfSJzh11JvDgBtnLrU+g9godfq7Yx77A1auxH44xveV32fp6P
         fVg1UAv6WkqIA3LPc/38YuIU4CR/N1bawj4OVm/T4QMpTbfc0AISjQgc2p8eqCQ55YR7
         gruDZFNY3KjyNiB+OaU50hrAnyhVhe6sFHunL7yXa0KZyKy4jqshsFAjxmtztdoxFUg6
         0UnuS08Avi2TBKbPwUIVJFY2V5tdFYpmi95X8Z/WWSXA1TZtPud+XbzGki1ZddrX6faT
         NL2A==
X-Forwarded-Encrypted: i=1; AJvYcCVcfRpBkAkayP5SftsZKrQ/dZozImrvJxZX+I9+981kqkLuV5b5+5s02/EA6yvycHaxjry84I27ZaAXytE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGZksVtNsdaVE0t0fnhqt9PP/h0KnZetXy8QkILDazbc4IIb2
	mKyT4vfm24nHz9MPXJAQUNSE1FHTG4Tu5GriYQ173TJQWzfZ81vAsQe0hNQ0AEe1Nf0=
X-Gm-Gg: ASbGncu1SXzUgbqM7OSi2a9vKCgofuSKRvau8zMyylrEBkto7DH78JPvCW1kFyvzVP9
	wvxPSWz2mo+Rz2eyP05WXWwKWwMDEu8LJndxClG5rTaT7t0AlAFtn3UleFoEUdnuMtM/RH+2aSe
	NgcZWYkRLIDOk9TxXnH62PVeYnpw+54jR8TpHaghXhVLx7M1SB85riMYMjKG9weMV8UrwxZpicf
	kVNxuKvwtGXlUaSk1v9ml472DLP0z0ETOBlYHg/Wjm899DNfdXTav4sfSZB1FHy2qfBKrScnRlG
	mxSG6OfzppMNrYgyMmg+sVnX0DnhAhsAXBnwzF03ZteZuiFcxmm6tkaUGgX25DdHgY74fTaTuem
	G11likCrMAONwKOhwndz8dACPd/UOVvfP25E4+z3N8c+Is0hHCOaoIgOfxxnvv6G88frb1WnMKr
	u8E06USRBc+PNwGTFkw6npPpRMpMA=
X-Google-Smtp-Source: AGHT+IE6HvbwvsCvQ5Cwmi6yqRRJUHyh9wrThsLz6Rz6ydecgfWWPWXRIw3RN/OVaQzDTAtqVvVBTg==
X-Received: by 2002:a17:90b:2247:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-33bcf8e5f10mr34441928a91.22.1761264259653;
        Thu, 23 Oct 2025 17:04:19 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:19 -0700 (PDT)
Message-ID: <f1a77da8-edf9-4e14-a7f9-01680f60fce6@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] spi: fsl-qspi: support the SpacemiT K1 SoC
To: "han.xu" <han.xu@nxp.com>
Cc: broonie@kernel.org, dlan@gentoo.org, Frank.li@nxp.com,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-8-elder@riscstar.com>
 <20251023195615.ke4rjhlgrxiavv6r@cozumel>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251023195615.ke4rjhlgrxiavv6r@cozumel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 2:56 PM, han.xu wrote:
> On 25/10/23 12:59PM, Alex Elder wrote:
>> Allow the SPI_FSL_QUADSPI Kconfig option to be selected if ARCH_SPACEMIT
>> enabled.
>>
>> Add support for the SpacemiT K1 SoC in the Freescale QSPI driver by
>> defining the device type data for its QSPI implementation.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - A continued line the Kconfig file is now aligned
>>
>>   drivers/spi/Kconfig        |  3 ++-
>>   drivers/spi/spi-fsl-qspi.c | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index 4d8f00c850c14..592d46c9998bb 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -435,7 +435,8 @@ config SPI_FSL_LPSPI
>>   
>>   config SPI_FSL_QUADSPI
>>   	tristate "Freescale QSPI controller"
>> -	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || \
>> +		   ARCH_SPACEMIT || COMPILE_TEST
>>   	depends on HAS_IOMEM
>>   	help
>>   	  This enables support for the Quad SPI controller in master mode.
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index a474d1b341b6a..d4b007e8172b2 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -268,6 +268,15 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
>>   	.little_endian = true,
>>   };
>>   
>> +static const struct fsl_qspi_devtype_data spacemit_k1_data = {
>> +	.rxfifo = SZ_128,
>> +	.txfifo = SZ_256,
>> +	.ahb_buf_size = SZ_512,
> 
> Do you need to set the new sfa_size here for multiples of 1KB requirement?

Wow, yes.  I'm very sorry, I shouldn't have sent this series
out so soon.  I'm not at home and am not using my normal
development machine.  But importantly I admit to not testing
this on the target hardware before sending.

I won't do that again.

					-Alex

> 
>> +	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
>> +	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_SKIP_CLK_DISABLE,
>> +	.little_endian = true,
>> +};
>> +
>>   struct fsl_qspi {
>>   	void __iomem *iobase;
>>   	void __iomem *ahb_addr;
>> @@ -1003,6 +1012,7 @@ static const struct of_device_id fsl_qspi_dt_ids[] = {
>>   	{ .compatible = "fsl,imx6ul-qspi", .data = &imx6ul_data, },
>>   	{ .compatible = "fsl,ls1021a-qspi", .data = &ls1021a_data, },
>>   	{ .compatible = "fsl,ls2080a-qspi", .data = &ls2080a_data, },
>> +	{ .compatible = "spacemit,k1-qspi", .data = &spacemit_k1_data, },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, fsl_qspi_dt_ids);
>> -- 
>> 2.43.0
>>


