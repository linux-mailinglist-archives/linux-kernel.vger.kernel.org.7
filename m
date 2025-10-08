Return-Path: <linux-kernel+bounces-845048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56043BC35D9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278F4189308F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6612BD035;
	Wed,  8 Oct 2025 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6Y00jl4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6E19AD70
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759899942; cv=none; b=BDbX2OSoj6NiyZP23Y2GKc1knDcx6PqrzLNT9QUtz//s9vIMspo6JFug+oFNgI4ELq0re/Gc2MBjFunzeleFhLjzS4e7mMgiX0wS7mO4IKxoqkU0UMceS4DWOz69VhZOt9u16smn8KWDmSgmzOTfb3wIMsHh16DlGPuhn9+hZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759899942; c=relaxed/simple;
	bh=831R8FamUYw2X5eOayXccCmXaemqXqLKRSj7cLPcqnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b863YBCegrdXH6tYJr46/x847GvBkSDsdVowJI4loBuzDcOY8QKqZHS8mmog8j0LDqmbwid3O8NzhoIqNW/ER2mV5a0rACCXaHlmln4AunJ/rmzFqg1qLNZXbElWXrMdrVTUcctRW9tvmeKEAPe588WnWe623amRouQhQ+leTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6Y00jl4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e29d65728so39346365e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 22:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759899939; x=1760504739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inzv5sFPx4qkhUDEjR3qqyNwUkiJV3PDHglkug7/Xs4=;
        b=l6Y00jl4sYsKTSGa2CmudUEbxoI8hmSexpBnkDsUT5p9CJ0FiXh2Va4vy+WjYXSLtT
         NCgBaGxu/xQuNCJIpBCvd+jbf1UuqfgztFls/yAtilMK/hxLyV8uJdqN0Az+OfjCRZBj
         kLwHTqTndnuu1MPvbABfBp/O1Oj+4ofljdVKsCT3oO9312or3U8bWvXsis82nJjKVyhO
         kNjNLkVMB+M4csF2gk1KiX+RmGqgIiQYEivaNkrtpWsQYimh8yorew/qj0BbZSMVHgH9
         07TQ/X1NKZRAn5nWyO5XaSWTMdIGEU/5SVxF4dINRkeazftBDms4LPM8tk1/5UBC5CEI
         /+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759899939; x=1760504739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inzv5sFPx4qkhUDEjR3qqyNwUkiJV3PDHglkug7/Xs4=;
        b=cgyawfygLkzqt2D5lIUFI859eAhc/FnNrRiMGYqeaUlsc9vbR678Qw81pVIUUO5QS0
         C89i3+RJI3wTUlnGmBaj5eVvTxvBbOgZncH0dhHMKJXFiIxmMwkdk1tTdnMnzB6bYoHH
         zW6jX5rS6EB/olj97R0AAGAXajUS9V7lyXRjMexvpUeegISSkwRJgU81Kiv5j8IWNmsD
         b7G9eGx74muG9pN0sFbxritdqwVinlF0r1e+wmz5GaoysnDF3R71zm63Bn8yPvV6aMIn
         PlTz7AsFSE/T5DsBTgl/FDp4q0OOvCtK+ZLFNynAFZDOuDWaXHZBCg1QEc8zh0xt6grI
         i9+g==
X-Forwarded-Encrypted: i=1; AJvYcCUg5q/xDq55ZzK8aq8BTT+W5Gws8HTdHRxtuIIRMlmLb3sfWwS2qtvoKYscZ5o8nM+1jTk1ogODGAFxbQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCoXGQM1Uf5k51EsPDjE2AxS7QkEtXLcQ9cUmK3GNxPr056P0
	cfXp6UYQht9CrnKqv48nGDw9CXboXUiuRYtZrc95lrlQplIGWqeXyoOWHGbdBwp7rSE=
X-Gm-Gg: ASbGncuWSpypq7IZITCR415K9CRPr7+ka1+EkD+urUS7FVCohFQYRqKTy/XU/0tYjTJ
	j9sX1dWfs50lbkud8DNo9WUxdlCaheIjsOtJJqwdA8TX6pK2pyQqIupORv1VCye6snzpV4uAdrk
	SOfh9p4EnnRe4wZeoxjoTEjvfx61VBjVuqR8v+M6ye7Ahgca0LhrT9t+8Jv01LMDzV/dZXrwjmM
	eBEAsOriPhnJskmynbGEoRGqk7AjzVF7X6O6Ekr8HVGHTXHsWQjPAHAa6e6zNgAngjvvox1yzzn
	XKbEuaTddQWFXb1hgW63H2bJSGYxZd32SA+uHIMjo20vDxU6C1iQ0ZfCy3uQqbwhoilNNXNL8M2
	5nzwnQTWMlNHKKVW1daAXpFga7BlwGygR02n0gEi1S5ApSvulDjami9c5Sqi2r2euSIXxfw==
X-Google-Smtp-Source: AGHT+IHiSpn4VVEghpm065DzIFzSuj/unRTmAyxIjTxV2LhIsGjiK7RpMl+LWZaxdsVgGVaIv1RgzA==
X-Received: by 2002:a05:600c:1552:b0:46e:1c16:7f42 with SMTP id 5b1f17b1804b1-46fa9a9659emr12934235e9.11.1759899938601;
        Tue, 07 Oct 2025 22:05:38 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cc939sm6013475e9.1.2025.10.07.22.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 22:05:38 -0700 (PDT)
Message-ID: <27d13306-79a7-40ae-af88-069d1f71f016@linaro.org>
Date: Wed, 8 Oct 2025 06:05:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
To: Sean Anderson <sean.anderson@linux.dev>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 linux-mtd@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
 <21760ebf-99f8-4ea3-8841-e023e00ae574@linux.dev>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <21760ebf-99f8-4ea3-8841-e023e00ae574@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Sean,

On 10/6/25 11:38 PM, Sean Anderson wrote:
> On 10/6/25 18:34, Sean Anderson wrote:
>> The datasheet for n25q00a shows that the status register has the same
>> layout as for n25q00, so use the same flags to enable locking support.
>> These flags should have been added back in commit 150ccc181588 ("mtd:

Were the flags removed upstream and then not added back?

>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
> 
> Sorry, this should be commit f80ff13135cb ("mtd: spi-nor: micron-st: Enable locking for n25q00")
> 
> https://lore.kernel.org/all/20200421063313.32655-1-js07.lee@samsung.com/

The rule is still true today: I don't queue patches that are not 
functionally tested, even if they are based on datasheet info.

> 
>> maintainer...

Don't point fingers please. If you feel the context is worth
mentioning, specify it in an impersonal way and add a link to the
discussion in the commit message.

>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> Tested with a mt25qu01gbbb, which shares the same flash ID.

Would you please let us know how you tested the support?

If you feel generous and want to give back to the community, you can also
describe your testing steps in the documentation from:
https://docs.kernel.org/driver-api/mtd/spi-nor.html

Also, if there's going to be a v2, please dump the SPI NOR sysfs and
debugfs data, see how in the link from above. We're keeping a database
and it will help us differentiate flashes that have the same flash ID
but different functionalities.

Cheers,
ta

>>
>>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>> index 187239ccd549..17c7d6322508 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -486,6 +486,8 @@ static const struct flash_info st_nor_parts[] = {
>>  		.id = SNOR_ID(0x20, 0xbb, 0x21),
>>  		.name = "n25q00a",
>>  		.size = SZ_128M,
>> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
>> +			 SPI_NOR_BP3_SR_BIT6,
>>  		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
>>  		.mfr_flags = USE_FSR,
>>  		.fixups = &n25q00_fixups,
> 


