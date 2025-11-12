Return-Path: <linux-kernel+bounces-896838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA284C515B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F133A4B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89902F998D;
	Wed, 12 Nov 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9F1wImC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7562BF017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939368; cv=none; b=kcs4l3AfgXeciDCXr3Ct7wSG7CJCSY+B2JekvTF4mhGO37+/Fv/jFaoT397eauaZAhyz0+cJbJfthQvbb2OMvjb2e0Y4wMzlhyxuZwJAalGd0Q3JudDExS2iW5WXLUqdWuDjTxUo8h1J6YJcWD9V3PkWLvnvoVNFfqUFjZ/z8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939368; c=relaxed/simple;
	bh=irP/NYx314ad1KcqSO0MFFrZXRvRXpdw+52ymx49qRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j5qrr8C1QcDwx17nmxuI+qRyL7yLiRkcWDCcibtc1e5Qlif4dT0qt3j2EDTdkjAS7IX3pKToI9+BwhWHQ8LnUcUQ/6a4xgIA9sICUimAXpJTthZ6BkZBC0vUYOlc7PNzzIz4I4E6Xtaa7c3tLzqaOUdJ7Nio1+u0l7WIz9fIbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9F1wImC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so259521f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762939362; x=1763544162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwBqkT0dayuRt6r3Xh02njTiGQp2OWToLaNl9xy/5Ho=;
        b=y9F1wImCGXtYIkR3bMhmbtRoR5yL7vd2XqY7LEpuVsLyAaxe6kVMr9doPqUAzdb25f
         3PnSPIeKLD/T/xHDAulFfoP3E73Lc35T2pRrfjhMKNRpVaJ8crun4UTdvi0+4aNzD7zH
         Wvz0tqpE+Yj6tlQmbiI7eOP3V8cnGBByq/a3C3Yo0NTd1K7Rurvam7+FDtQUBQgQ3A4P
         5t1xOKxpKEr0eCME1L2gaAQ/bc/l9yvnKNWsWs0Mm9onGY1QsWPacq5GjRkX6KS0Dnyy
         y6Ge5jA5v9/nGXL3BiIqah0PXZXPGfoD2jyIslRmWkJIUfOTO+G0hdYRvfQw4+6b/OVH
         zwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939362; x=1763544162;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwBqkT0dayuRt6r3Xh02njTiGQp2OWToLaNl9xy/5Ho=;
        b=D0IWm15mrzEnA/c3+8xjIXkseUnHA9guTXmcfite2MmouW85KysCkGF70zgk0iWSe6
         zwXCaMa0euJ2jTk96/JRsQbcH+UogsCz40WS9RKJN2lxItOkPTgQAmE0kyuJvpInWAKh
         rI4giA8FQ5Q0afd5nWgaMtdgC2qcF1QLOw5YDZO15knxKmb2tRQnHDlg6OV7zn0Ogc4P
         sPLX7nkFwY8cqu0DcaYke4V6TN7cqY5PpSB8Jg7GmrXwaV73HJTYO3iJOr+yM2zzfdfq
         XUMinTEk4fPBcqDBWqJEXA3VYpHp4kjz8HI/O4oC10nNFxV5GohPTBvOIiuMnJ+/S2YX
         85YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWzex51ljbqOF/IKcwYuPRDC4RbVJXVodE10pwBX8E1jqtpKXICE5hcEtlaf826jKLfZwqYFM1bOEpPx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSys1eeXca69p6nw6DAQ6hhlCJ0XQLZXam5yaIIlRYFbJTihDf
	3ZsXr+sCpmGJVsxfr5hkfBbEoq+Pv9Rzhoaeq3ts5phfM2zutSLyHFuV3Jk4uxSYf8U=
X-Gm-Gg: ASbGncspT4+pTZ3ZN+6G+JmR4HOaMOoqJ1Vm2KXfwp/cOuYncPXd75Xh/cri5h3SFAz
	IADDy2/N2Zn46OIz9N3Q0IHTZdnXmELw6dX9UpJl9EkgVmj5tdg2uVhbRN7QdgQwRUH9MU75PQK
	XL472DHfBYhCj6Hex2qeI1sZsO2c73Pb5wmTKKaFEE2IbyhzDo6V0N2wsd1Ir2nQzLUzIyLYdFM
	DdTFl8Is672PAJK5iHfVzEwCc+tyow+fuj8d8/Ui5TLTjDBN2qhttN1yZEgzbCEqcKCOwjVQa8t
	anQF1zZKSQ69qBdWPykSgrWFdyXAvGbCapJcbKB9IWxs1/d7moNGNKbQdy9Tpscpq5UwHVKuqOy
	ry/yY0LdIWA2kRZBNc7/OKf2AZ/ajkzq/AHyKGEbsoSxbaBDniE6+Dko+KmLdKTmwG8SRoTznoc
	rEH2X6IA==
X-Google-Smtp-Source: AGHT+IHVj/yhPNsguLn+9iN6v36uGx0TqDeIQDAvMb7zZQB2BMHPjxqAzj8p/cZVed7p0kysc8mvog==
X-Received: by 2002:a05:6000:4308:b0:42b:4185:e590 with SMTP id ffacd0b85a97d-42b4bdd5872mr1717415f8f.58.1762939361592;
        Wed, 12 Nov 2025 01:22:41 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac679c5dcsm37014843f8f.44.2025.11.12.01.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:22:41 -0800 (PST)
Message-ID: <ea9d58d9-30bc-4793-a111-1df428f74e31@linaro.org>
Date: Wed, 12 Nov 2025 11:22:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Haibo Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20251112-nor-v3-0-20aaff727c7d@nxp.com>
 <20251112-nor-v3-5-20aaff727c7d@nxp.com>
 <013215bb-3562-484f-868d-485d0da095d8@linaro.org>
Content-Language: en-US
In-Reply-To: <013215bb-3562-484f-868d-485d0da095d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/25 11:21 AM, Tudor Ambarus wrote:
> 
> 
> On 11/12/25 8:48 AM, Haibo Chen wrote:
>> mt35xu02gcba is similar with mt35xu01gbba, but with four
>> dies inside. According to datasheet, it contain SFDP and
>> support 8D-8D-8D mode. Add comments here, remider to change
>> the code in future if has a chance to test on this chip.
> 
> you'll need to rephrase a bit the above> 
>> Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>> ---
>>  drivers/mtd/spi-nor/micron-st.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>> index 6d081ec176c37249e5ddb724b61bd70f68088163..cc053b4d615ade3f12068618f8355779561dce55 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -206,6 +206,12 @@ static const struct flash_info micron_nor_parts[] = {
>>  		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
>>  		.fixups = &mt35xu01gbba_fixups,
>>  	}, {
>> +		/*
>> +		 * MT35XU02GCBA contain SFDP, so no need the size
>> +		 * and no_sfdp_flags here, should similar with
> 
> this is expected for all the flashes that have SFDP, so no need to
> specify this again here.
> 
>> +		 * MT35XU01GBBA, but with 4 dies. If someone can
>> +		 * test on this chip, can change accordingly.
>> +		 */
> 
> How about we rephrase this to:
> The MT35XU02GCBA flash device does not support chip erase, according to
> its datasheet. It only supports die erase, which means the current driver

drop "only" as it supports sector erase as well :)

> implementation will likely need to be converted to use die erase.
> Furthermore, similar to the MT35XU01GBBA, the SPI_NOR_IO_MODE_EN_VOLATILE
> flag probably needs to be enabled.
> 
> With something along the above lines you can add:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
>>  		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
>>  		.name = "mt35xu02g",
>>  		.sector_size = SZ_128K,
>>
> 


