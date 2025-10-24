Return-Path: <linux-kernel+bounces-867919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6152AC03EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBE6735996F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797D171C9;
	Fri, 24 Oct 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="q3HI3nMa"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C36F2F2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264254; cv=none; b=rSP+Uh/0viLf8NId7r/W0avp648Odk2d5VxynhdrUjuZTM22LkjS280K3P/oQ4qL4wCFgT75wOEfAYUMgUsHpTpiLnmmu2msUN25qR8nn157BtPLKyBDA6XI0BxcQ/Yr1lvipzVy1xYXC8vmUzSjVliHbJv9x106d+wqB0iap5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264254; c=relaxed/simple;
	bh=oBXWaTXlxJXobBTW+QXHPr5R6s0tFE5GXaxWYWcUIRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ab1v4mk7lNrhwC+woEc7CVu9aGw7YwnN0L312a9Qs4maC+4eeDu+Heke7L9sKcs1s3gT0/UMTIalr0xygEWEqiPq3bR0vjF1YY26pIK4lPSPc1H3ve8TCvC5jV35A8bgBjy2rhGynAxcpFSPpO2t7poy771qxSALlokPlZPjZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=q3HI3nMa; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so1530903a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264251; x=1761869051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kG8oovmqRaNzTSGBD2RsxBVDQfNgYBWR0ofPiKC/9wo=;
        b=q3HI3nMaugihBDvnxCS+CJ8jBGkNSGOFaa2rv+do8kpblY1CYtlw8m6FIOul9v/dbK
         Hkix1HXQmA5TZxqxzyKAornUdR0ibT5kwXeEyXkZQKCFrKCyxh63gfTGjgtX0Tf1iPSq
         tSraqwdSKsQrAJ0fcbu+RtxdqjK4rTJB0Il8PkhHpPAEXzCJaUYa6UyDkXWhcZxiwbDM
         tU974PGnw1ry8CaWRxhn1m3280T+LTHUCWJpg0Ufhal//5cY3mCr7kSp90vAB47kgCb/
         8KewH3z4s4TNV7IVzQFX6nR1JYrx/Uc9M3MQ1GbTRcvRISfuyS4zFKDdmRfXfyTlaOti
         EcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264251; x=1761869051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kG8oovmqRaNzTSGBD2RsxBVDQfNgYBWR0ofPiKC/9wo=;
        b=SHN8E3ftammVYzUkHlvxOxEzghMrMdE5NvOwhwhogXI0fFA0sXCvIg2eIbRtn+Ba0Q
         HBpx/hodXhAW5RNxumsHz2rr3Fumz/VWHb7wx3pxSijezkUNq37xhHY6qQ0xTlTvw3yZ
         lGy21wFBWeFy9xV/U2isdTAxAA9nftDxEW5JYnEQ6wPvraC6okBHJNd/W8WSeQXy7Hao
         8fAI0UmfSHgd9BJDl8x8H+9OTWrUXBX+9M9+EfZcu/DtY8bKfHVYBf5Bg3GOWeQUe6qe
         chiJnXHeOmZSVAkCr/ZwVpazXpj/9MPc5AwDkSzBic0Q25aSbIdXNmBPuBgKp3NLlDFn
         Cg/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmMwPh3fs1JKI1h/ksCM6rW2B7OmVZkxjIm7r44fawz4QNoAGIESAcVHP3FnxkzV4+UWNPrG3jxmK2ZoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4k67lUAu9cXMHUu4n5tNXlzqs1y1c91PvuEioFYiRHgsqgsI
	qhBHc2Ss7NrbVQfqbjeiBpv32ejSu/7KJxw9Ivv4uhAVVQRtGZvwLDuloxP1xvG7Wtc=
X-Gm-Gg: ASbGncsf5M0raaoA/h3hHqr5P+TqeIKoAi5u/ib/o5DMHLmG9LyAPTJgacpiZi6lA2c
	ATl077pUQFru0zahrrLit6bngGwZ1JwEi4m4x1g9QyC94kDTv+O18bJWkJRQnaRKdO6L0lTL4ew
	ZpaiwiIQ8KVO8RwvIANARSarbW1mVQ/O0/q0l0B7jmnh6630BfMFjlhjUWc5xDgl+QBoBKOC0ex
	+sh//YX0+oyYDPkNz9W8mp76oWvXY+vMp4O3uE553vD4rJ6JP5NI8OV+olZpsdREjQufU232phA
	8jUPC0yWPkrQSTgCRB/On8MkQ2oXwIBFmJ9ekzDc0kNaMrG+qz0EcA076i+1tofdxf0/Zv39WdS
	Sfr3uYJRTxlTeZKWJKH9Q/0pOglUtQONA24JRUuAMElthbarmmG1cRwLb6ggZI3zExVOXwbCnM5
	h9nOwDurjUl8z19tUa9LPII1lOWfZw9Qzp2TVOXA==
X-Google-Smtp-Source: AGHT+IHSGU24WurHFEd08HU+CrxqEKTFB2CNJlwi6t/j28NxxvFCPIXZXTfDae9QkSIwWA6BVf5SSA==
X-Received: by 2002:a17:90b:48c6:b0:32e:59ef:f403 with SMTP id 98e67ed59e1d1-33bcf8e95c3mr35479556a91.17.1761264251417;
        Thu, 23 Oct 2025 17:04:11 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:11 -0700 (PDT)
Message-ID: <a43b6ddf-c552-4db8-89cc-49951015161d@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] spi: fsl-qspi: add a clock disable quirk
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-6-elder@riscstar.com>
 <aPq75FBuYvFQrbQE@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq75FBuYvFQrbQE@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:36 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:17PM -0500, Alex Elder wrote:
>> The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
>> clock when changing its rate.  Add a new quirk to indicate that disabling
>> and enabling the clock should be skipped when changing its rate for
>> operations.
> 
> remove "for operations."

OK.

>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - The quirk flag is now named QUADSPI_QUIRK_SKIP_CLK_DISABLE
>>      - The predicate now returns bool and is not inline
>>
>>   drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index 1944e63169d36..c21e3804cb032 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -197,6 +197,11 @@
>>    */
>>   #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
>>
>> +/*
>> + * Do not disable the "qspi" clock when changing its rate.
>> + */
>> +#define QUADSPI_QUIRK_SKIP_CLK_DISABLE	BIT(6)
>> +
>>   struct fsl_qspi_devtype_data {
>>   	unsigned int rxfifo;
>>   	unsigned int txfifo;
>> @@ -306,6 +311,11 @@ static bool needs_tdh_setting(struct fsl_qspi *q)
>>   	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
>>   }
>>
>> +static inline bool needs_clk_disable(struct fsl_qspi *q)
> 
> needs_skip_clk_disable()

OK.  I was trying to avoid the double-negative:

     if (!needs_skip_clk_disasble())
	clk_disable...()

But I'll do as you suggest.

Thanks.

					-Alex
> 
> Frank
>> +{
>> +	return !(q->devtype_data->quirks & QUADSPI_QUIRK_SKIP_CLK_DISABLE);
>> +}
>> +
>>   /*
>>    * An IC bug makes it necessary to rearrange the 32-bit data.
>>    * Later chips, such as IMX6SLX, have fixed this bug.
>> @@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
>>   	if (needs_4x_clock(q))
>>   		rate *= 4;
>>
>> -	fsl_qspi_clk_disable_unprep(q);
>> +	if (needs_clk_disable(q))
>> +		fsl_qspi_clk_disable_unprep(q);
>>
>>   	ret = clk_set_rate(q->clk, rate);
>>   	if (ret)
>>   		return;
>>
>> -	ret = fsl_qspi_clk_prep_enable(q);
>> -	if (ret)
>> -		return;
>> +	if (needs_clk_disable(q)) {
>> +		ret = fsl_qspi_clk_prep_enable(q);
>> +		if (ret)
>> +			return;
>> +	}
>>
>>   	q->selected = spi_get_chipselect(spi, 0);
>>
>> --
>> 2.43.0
>>


