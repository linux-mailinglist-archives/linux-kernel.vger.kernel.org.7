Return-Path: <linux-kernel+bounces-864116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE628BF9F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 463BF4E3396
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53EC2D7DD0;
	Wed, 22 Oct 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KAHKDISU"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7552D7813
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107664; cv=none; b=Mkmui0FlmOUDR6ozrffDuVIQGhsyUB/pgKRWE5vDIUlPFxXd4znJbvUSZXE2LiRkj5nG+wZy76Zt9QXGYYTb63NzMuxiGpLpK5VA6obRaT0WYZtu7oKGGSY1YDkntl0wXfkLp2KCfYaeDDCjMQUYAc5TdoIAqqFg2+Rws5xcpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107664; c=relaxed/simple;
	bh=szq/rOHUN+3GufB7hVfQTfjTIKoq4aYdgJfWA0SfWRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAbtKCBZS5diAvPMI3YzQPxBJFjF7qlRSxaX9b6pR1OSp/OnFOLkuCNOZUdrRFAEMMwJ5x3TAJFNywmOyTEq6GzzANsTyzNaigqU9OWCxNAM6ntDZN5hohgGf2bs2QWxhRV6jaX/5QhOKe3BCQMC0T38cZVqUfrEJVMFom6ebXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KAHKDISU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so63524795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107662; x=1761712462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXV9nPTtzRS7GB0GpGCBfWyozkzIjx5wpujc/niwppI=;
        b=KAHKDISUocfMwFBSSuAZDS2N0vPxvCNLwl6lMjLM0ohsr1ItTVlls1K98KQ4llrO0Z
         nUcIMHPqNG4KZOVjjdf22OfzEqZcz9wpjaq6p36Lhho6Qt8TvEZ8ln3NHSf4GRPQ0hPu
         gGWNxGQQJxEwavnHJBMiEGgPW4IobrI8oZ1aflO+euXhaWIz6aZZWms24abyjQ3slT/y
         3N/eU0LSw1XsGDCC491wEBmUPf5Ivx8S0jszqcplGcJ0IDNIB9DWhfU1QBQOxVamB2C3
         idJ7kcDb+ww+f34w4bTgVVZxVVm+/mirMTDtLYyLBp7H656+qCr5BnXpfHqXW0W8Lwce
         ja0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107662; x=1761712462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXV9nPTtzRS7GB0GpGCBfWyozkzIjx5wpujc/niwppI=;
        b=itnPA+gRzKtWsXWAEoYJuxQLWrXUwXSJTDQm/hTZNqvIUMWndLNa72y0ZhaTvGQti5
         p/+S1ayNtDjU460G9Z3+1u7oiLCEEcmhnKWcfqLlrSRYKCuMp1VczbYJ9Ld4UkN1jrUK
         +dpVXnvq9sK4OPbmgCbmd7jOitkkuPQ6njQKchpuUAM048BNmhHJIhKIVL5KkfoY8xrz
         r3g8I6jWXKylqo0OPdSOG7/dddN8ORZ6/dRG2jOJdhqwW3CFc4+tJjiSFaSgGRy41xCV
         8FTiI8MkuK4F7ufQxDbOdZpPHUJk+XBo5D+FBpLPWcTJ4dGrarlSBdx7rlySscLBZeya
         U2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU/82bxS5QLU42U1zaQbLJ5PMDhB/jUhjxP9YZljP0dMrzt/Sm1ZLzSB/tVzNoHph+sZ5MPkwSW0dDJFfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuhqc6rK86in2zgeW4Dqf+2L0jHqp1wRb0Cs+JHkhJQZBEh4Fo
	QzdYqz4UaUYDvEbThw0NvRqe89fUpKwVPAzTKgC9xH0xeMcPhxnCzqwWdgP9tGZtrhY=
X-Gm-Gg: ASbGncs4PtdBySx2Qq7hzRYyWoS8LT98pcRIilqUBA4Ddk+4M7HMfaZrp9OCBxIYhjv
	MvsoVkkVAwB/A/n20MIpjNrv78BX2Zqc/47zBBMweSFNM3JNjqQt+6c4ZFfvf2rB9CsoJcIcgc3
	VWkieuum1CuvjtR06qtd23DSNwMI0Wq7phdSNDdyUKKJUUaeftcFfgAdgXDxnEksrmwIF4sMAx5
	RTPECDxc17sBC5Q51xHGXW96v9IkbiqeD4A8f02zadBadyAHoiRkmn8ifZ/x2slGT6s5yLgYPkV
	GTA0KKidlA6qkLva/RZdpsuhYbID7otR7xqIFLO4ZYTa7IL/H5j499l/zM0rokCgVWubgRUorQG
	8OzdR+ClEYkr6fw+rFei4Hgb/u8R9HpSADw4iXHC1rm/jzWLk7enXgAr1pqsWQx6X+waGzePWZa
	a805COeyypAMlU
X-Google-Smtp-Source: AGHT+IGMxMq8ODA384WIjA22NE56jXOrifm3A5Z150bOKY/fGOgxvMMpMNK8BhQcEf3SEUsHJhYpWg==
X-Received: by 2002:a17:903:298d:b0:267:87be:505e with SMTP id d9443c01a7336-290c9cbc185mr219746635ad.23.1761107661774;
        Tue, 21 Oct 2025 21:34:21 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:21 -0700 (PDT)
Message-ID: <c93c1319-2f1f-4303-bb4b-751979f58149@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] spi: fsl-qspi: add optional reset support
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, p.zabel@pengutronix.de,
 dlan@gentoo.org, guodong@riscstar.com, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-4-elder@riscstar.com>
 <aPaIezCu/gXxJC01@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaIezCu/gXxJC01@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:07 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:46AM -0500, Alex Elder wrote:
>> Add support for one or more optional exclusive resets.  These
>> simply need to be deasserted at probe time, and can remain that
>> way for the life of the device.
> 
> Nit: please wrap at 75 chars

You're saying wrap at *longer* lengths, right?  If not, please
clarify.  I'll update in v2.

Thanks for the  review.

					-Alex

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index c887abb028d77..1e27647dd2a09 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_qos.h>
>> +#include <linux/reset.h>
>>   #include <linux/sizes.h>
>>
>>   #include <linux/spi/spi.h>
>> @@ -267,6 +268,7 @@ struct fsl_qspi {
>>   	const struct fsl_qspi_devtype_data *devtype_data;
>>   	struct mutex lock;
>>   	struct completion c;
>> +	struct reset_control *resets;
>>   	struct clk *clk, *clk_en;
>>   	struct pm_qos_request pm_qos_req;
>>   	struct device *dev;
>> @@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
>>   {
>>   	struct fsl_qspi *q = data;
>>
>> +	reset_control_assert(q->resets);
>> +
>>   	fsl_qspi_clk_disable_unprep(q);
>>
>>   	mutex_destroy(&q->lock);
>> @@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>>   	if (!q->ahb_addr)
>>   		return -ENOMEM;
>>
>> +	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
>> +	if (IS_ERR(q->resets))
>> +		return PTR_ERR(q->resets);
>> +
>>   	/* find the clocks */
>>   	q->clk_en = devm_clk_get(dev, "qspi_en");
>>   	if (IS_ERR(q->clk_en))
>> @@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>
>> +	ret = reset_control_deassert(q->resets);
>> +	if (ret)
>> +		return ret;
>> +
>>   	/* find the irq */
>>   	ret = platform_get_irq(pdev, 0);
>>   	if (ret < 0)
>> --
>> 2.48.1
>>


