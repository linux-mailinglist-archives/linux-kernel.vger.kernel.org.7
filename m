Return-Path: <linux-kernel+bounces-785163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50379B346C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077785E659E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3782FF65B;
	Mon, 25 Aug 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NcRUClF4"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7266A2ECE8A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138131; cv=none; b=sHn9A/4XuXpdQrSnIAj+oIzXo/fNsBbTKgk/qB3MkpIFqeAJVxjhgUSCprXiQXyAE4bpgl4ELCO5ip2WTK6VQnM5n16nGOX220rfK6kWMLreOggH1W8Fc9EhweBEVuEaIwHVAkt70k34vlvK6H8laEbkdaxOoztATlfy3TJTwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138131; c=relaxed/simple;
	bh=IRrGnU8GP7ncfbvvMS5DUsPXlS3sX82/pTTFd6SsTjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOqTfwnGao0abA4VNGAiXdVWuOhuCRHy5pJq9nSaDDuv7aWatkDYXNXqIHtIZ0KEOY2ZdenEJ5+2+nXXaVnIyMQr19kENBkQ23cvRXaic+6D6iTRzHD7JdcBiKnUFhGJ6v9ec6JYjhF6XaGRy5gpaAby7Y9ms+fdE91ALOFHVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NcRUClF4; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-88432e6700dso71352739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1756138127; x=1756742927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0cjzzyWOyZks1nTu1rGjk9KV3egwe1aayyTboNLSe0=;
        b=NcRUClF4419uY9or4sIjWjpe2GdaATVJjBxK4U7L51C+XrN5OwSTdFTJOvwO7vCWTW
         UejXSVD1wsvJ8mAsOnBWRRHqMHEpU0JpxXiy5UgVtDTjh3HAg1zi21rTUb44hRBP/JsD
         oBeZ1J74XRbVay2JBPWn8ycznjRN48VGc6ElCxnJc/pmpKoEqi+UCk0KrBEtkuTRd4ci
         RiHMfjRwvAHuo8WlYgS/vN0RSYVXdY2iWrh1ABozpTRl/HQ8DKT8++KjBi2U39ucjmQw
         WqV3hH3+/fb2dZigWqt9a+mzLxQSxa8IqCQukly+IOOd+i4KMVbZ4TkpfbS2YjgGOSrA
         8yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138127; x=1756742927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0cjzzyWOyZks1nTu1rGjk9KV3egwe1aayyTboNLSe0=;
        b=qi65sNulfQzvBjfkMxQVLOV+T6cITayXRHKbPbsDCDApQAfv2+x5/9zf8psvwNhfIU
         aZZW4B/oBdPU5l6Hd+i1SAXKs3cCr3LrMaLO/WI16rRxt/4Zuq2eLWrxrCJce4lINYdv
         HKHyVrYkPQr8S14IHcYiMufTBkOEKEXI+SJF5CUhDLnSunSkNb5X56PpMDTJCeWSL5h+
         gnPJu5zu+WLLYWa3fJnB41Hb0V+WEKzv6UOlg6GFutGgTpuskF/Ok5v55h4nsr1Dj/hy
         w1lu5nZq5MKYT77gb6IGPMF7KC1E5TnoqeYo8OqyIiIVRfytymSqysVuymOr3Gb0PYpN
         /thQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIufAkJTY2phBo4KouKQyNVUg2A/dnA8JcfoLT/w6edlAegq/RoNXqdFwhwoeblKzYgN7hOD2EczjywcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGLV1Kx448UpmfsTHH7Xf74Atmyt4ajGabrAs0Kcn/b76odkS
	WuKMCmI2vU/q21XK3e3Nsp/QCkj7/qHMqv+Cl3K0ITkeTeQHkHdyx4TJD/7v67vkhNo=
X-Gm-Gg: ASbGncu99YH66SXnfOP2pIu6/FAy/vd0tUkeDgIUNgvs+Zxp2YiI0tZEiQlH6Y5EPm0
	V1eUs96ifavZjpoGntIdbGQS3JnMyVQCTDaQWUPFuc+lkVIa/yBAOUXrsdBKPt0efamBsx8sPXz
	O2cHBoRSqZLMCkSbraUdFs97QAIUNY96bAIoCkCtcpN2P+WpuTy45Ms4WgqidFAxd5qpTG910Uv
	QcQRcM72Rfp80kSlM8rSfR8/xwDijif0szodt2CP/JaOaTAhvRWqqrWhbU2TCEZJrFxuXW6aVAt
	oVtHYVS9DV3NtcN3X8v/XG/oVoD72MhfgtErsJ2Nmm/bCDrO5OXhQjT2VxShD2nkHZdpegq4J9v
	8ZQJuSllE7YFwB42sDzZOBMV45jx/LNsi+cRQHMlD3MdooN/zQyxek92xMC7+Zg==
X-Google-Smtp-Source: AGHT+IEL2QvsFMnDcZXTzmhm/4l1RIr9WfujVlwMQrzr/6F7bd2mjY4YQv7lvRHHyhZ+U5TJ7ij4Pw==
X-Received: by 2002:a05:6602:2b07:b0:886:c53c:9172 with SMTP id ca18e2360f4ac-886c53c932cmr1606713739f.18.1756138127315;
        Mon, 25 Aug 2025 09:08:47 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8f0a83esm502245639f.10.2025.08.25.09.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:08:46 -0700 (PDT)
Message-ID: <b387ebdd-ae5d-4711-9e10-c61cb06f4b5b@riscstar.com>
Date: Mon, 25 Aug 2025 11:08:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/7] mfd: simple-mfd-i2c: add SpacemiT P1 support
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>, lee@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, alexandre.belloni@bootlin.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl, dlan@gentoo.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux.amoon@gmail.com, troymitchell988@gmail.com, guodong@riscstar.com,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250813024509.2325988-1-elder@riscstar.com>
 <20250813024509.2325988-3-elder@riscstar.com>
 <089D29348F246F2C+aJ6bPgJsp5GjhDs5@LT-Guozexi>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <089D29348F246F2C+aJ6bPgJsp5GjhDs5@LT-Guozexi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 9:28 PM, Troy Mitchell wrote:
> Hi, Alex,
> 
> I did not find any accesses to the P1 shutdown or reboot registers here.
> Does this mean that the current series does not support reboot or shutdown?

Yes, that is correct.

> If so, do you have any plans to support this functionality?

At this time I personally don't have any plans to add this, but
it could be added later (by anyone).

I actually attempted to do this initially, but gave up.  The PMIC
is accessed via I2C, and I needed to implement a non-blocking
version of the I2C register write operation.  I tried that, but
then found that the shutdown or reboot still did not work reliably.
As it was, this was more than I originally planned to do, so I just
implemented the simple RTC operations instead.

					-Alex

> If I have misunderstood, please correct me.
> 
> Best regards,
> Troy
> 
> 
> On Tue, Aug 12, 2025 at 09:45:03PM -0500, Alex Elder wrote:
>> Enable support for the RTC and regulators found in the SpacemiT P1
>> PMIC.  Support is implemented by the simple I2C MFD driver.
>>
>> The P1 PMIC is normally implemented with the SpacemiT K1 SoC.  This
>> PMIC provides 6 buck converters and 12 LDO regulators.  It also
>> implements a switch, watchdog timer, real-time clock, and more.
>> Initially its RTC and regulators are supported.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/mfd/Kconfig          | 11 +++++++++++
>>   drivers/mfd/simple-mfd-i2c.c | 18 ++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 425c5fba6cb1e..4d6a5a3a27220 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1238,6 +1238,17 @@ config MFD_QCOM_RPM
>>   	  Say M here if you want to include support for the Qualcomm RPM as a
>>   	  module. This will build a module called "qcom_rpm".
>>   
>> +config MFD_SPACEMIT_P1
>> +	tristate "SpacemiT P1 PMIC"
>> +	depends on I2C
>> +	select MFD_SIMPLE_MFD_I2C
>> +	help
>> +	  This option supports the I2C-based SpacemiT P1 PMIC, which
>> +	  contains regulators, a power switch, GPIOs, an RTC, and more.
>> +	  This option is selected when any of the supported sub-devices
>> +	  is configured.  The basic functionality is implemented by the
>> +	  simple MFD I2C driver.
>> +
>>   config MFD_SPMI_PMIC
>>   	tristate "Qualcomm SPMI PMICs"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
>> index 22159913bea03..47ffaac035cae 100644
>> --- a/drivers/mfd/simple-mfd-i2c.c
>> +++ b/drivers/mfd/simple-mfd-i2c.c
>> @@ -93,12 +93,30 @@ static const struct simple_mfd_data maxim_mon_max77705 = {
>>   	.mfd_cell_size = ARRAY_SIZE(max77705_sensor_cells),
>>   };
>>   
>> +
>> +static const struct regmap_config spacemit_p1_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +};
>> +
>> +static const struct mfd_cell spacemit_p1_cells[] = {
>> +	{ .name = "spacemit-p1-regulator", },
>> +	{ .name = "spacemit-p1-rtc", },
>> +};
>> +
>> +static const struct simple_mfd_data spacemit_p1 = {
>> +	.regmap_config = &spacemit_p1_regmap_config,
>> +	.mfd_cell = spacemit_p1_cells,
>> +	.mfd_cell_size = ARRAY_SIZE(spacemit_p1_cells),
>> +};
>> +
>>   static const struct of_device_id simple_mfd_i2c_of_match[] = {
>>   	{ .compatible = "kontron,sl28cpld" },
>>   	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>>   	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
>>   	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
>>   	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
>> +	{ .compatible = "spacemit,p1", .data = &spacemit_p1, },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
>> -- 
>> 2.48.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


