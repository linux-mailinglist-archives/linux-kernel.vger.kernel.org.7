Return-Path: <linux-kernel+bounces-867920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7702AC03EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350CA4EB5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70973158DA3;
	Fri, 24 Oct 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="erOz7Tk8"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27E41547C9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264257; cv=none; b=Ul+QcJQfYuVS+YIFgwSNb+GoYp4UPqLKjiu967rHnLoTrhU0Btx275M6CKlweka2kgfrp089M1Dzx4gdpygZN+VQ5T/1dyUzUTGaIpOAuXwsFlPMWdC5gvXKQVBmG7TGCUuuVf9lj+mbkRiav7ahQyY73+wZM12uw+KnD+Cqwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264257; c=relaxed/simple;
	bh=0a1a4wJl0mNN+XeKmiOrjUVWC1hr2y3wlT7/+yelLHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhKBFY+PPZdWasEwn6dSYbMB3TGuGkCgohDyiOiJglCZwlMPIKfPE9BP/uwSb3zcHlAuJYCx8NtNMl/v2gmvacmSVq/lks6AuAoxUl/7k0VMS8tBkm4cvTAaS9WJbk0PX1wERLaVpyASYUEzldLRrmynd4Bk2nJoMZ1ON9ZyC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=erOz7Tk8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78118e163e5so2442345b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761264255; x=1761869055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=st9SBmAbK+pJ23fMLr1ycY9DK+4vkS9Hx7Sl87k4JR8=;
        b=erOz7Tk8sM7M+Y/v6P02GMG2F3Q3yZ/otgZ3vwE0+Ao/pLVY/L3KNtVHY/ILnHMLlS
         jziWnEZZY+3fFWaUdGG4FC9B5Kp/H3rouKhpiR8vhXrgcap3pxIqMcpt1FLE/F40hcVj
         NGxtnyTPf+6bQFzLYNBUKB0A2KjSdWml+Ow5gi5HzL+SHchk4daSaaaV0/s8J2KIZ51Z
         f0FUXx3aQ/iv6hb5kRH5BTNxTtyJVKu6DZneS0CyX4ZAPdyymfAQXsplxOrX85OxImdH
         D2NVAkVMKEMN6PYxPqoTMmdMgkDiHzTaXt7YnM9J1qwDEPq/imObsKlZ0gUf5BYHkILI
         YmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264255; x=1761869055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=st9SBmAbK+pJ23fMLr1ycY9DK+4vkS9Hx7Sl87k4JR8=;
        b=Q7CAwmwnxN03eIBYKRq6zf6JRfM6q5JiIgulSJf3Lbio/G5NbDpQ8QDIhWnTQTHxjE
         NbknInvdNt7HkV2+NIF1M0lJ+L5wclfM8C89rYDzrJQaFWGWU2Yn87Cz1WDPkXVfa2du
         vt3xA2zKxqc5tyLuAxmD/fAQKnCnLtyx21r7VYv+MBOx1zb3Gze5pWf5a4HhEGRh8ExS
         iz13zmZRWh7KikfddU7VE0X0QakKmtygZNOBRe4RJh4cuLycKwpQccTDVbaBRua8TRe1
         pLbtwZiwcAcrrml2TmXh18e/F1Wma+cu9fUiMSJvWvyR+eNXBj0FZ2VSQoSC/Bbj4/Eu
         6UCA==
X-Forwarded-Encrypted: i=1; AJvYcCXV6yJvPYeYaDzgCcCRZI5GGy9OeL3LcELbnISN0LLYIjxRVt+Y0frtDY1yeEs02OzmqDgKtmFBL+4OVDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUYPKC0DoXqhVQBjo0FaUAXtqrvkQ3ucCLXfYWF1EpfiElwP9
	jGj80Ts9mQESQY5jVPmrmK4lYIruXx35FFYzwRRp6CUFKXsL0ry1IfqgKckpobs10RU=
X-Gm-Gg: ASbGncsjozVQDJqMQZ9g2x3MJXjD0Yg1NT/ZPzff2MON0fKYBI3EJ0gzeE/95K8s5h4
	mFsUj7fe+0Ey2vwQxfwnJviJ4mda6AYL5/GkOIGK9igKamBMyR1F/doflVRmrRsKvTVHCDTMbKI
	/JkqabCZME0cCyYgJqRy9Kw8ycw6LGdjciqegy6hb9qZMJiRT/OBdMKsNB1S1gKJ9a2HCIu7Qqn
	6gJxRspttRO2Xi6ae9GELuVHioYetbhiDcnrG0gU++RskpwM6BzUYFdOW+AzgZBk6SD0JjOvPrR
	nSYdIoSIomkzTqFNQaIiYgiVvTCqW7+Kr9PVm9R8/U6bF/Ng0YUvBzUcw33XY26FOAvsb6AJYCX
	QOttfzmJaFPzNxpHPEOsrnadfe+SLMP5T+K5vLN5tOpAVylr1wEx9r5YxFsngFzua+IfT6p4EsW
	PZEvSi0nXsteV1AX9QDKXiXkVIqns=
X-Google-Smtp-Source: AGHT+IG4cAqt2nwKmVZj2ECX6/woNYxm9obKHW2gmp+s3pOMBjf8gp6N1gNa2I6RxiJ8JXE2VP7MyQ==
X-Received: by 2002:a05:6a20:394b:b0:2c2:f61b:5ffd with SMTP id adf61e73a8af0-33db34e5145mr934623637.10.1761264255098;
        Thu, 23 Oct 2025 17:04:15 -0700 (PDT)
Received: from [10.211.55.5] ([208.115.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff373easm3702460a91.5.2025.10.23.17.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:04:14 -0700 (PDT)
Message-ID: <aa306536-f09b-414c-9e6d-0b69d69040a4@riscstar.com>
Date: Thu, 23 Oct 2025 19:04:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] spi: fsl-qspi: allot 1KB per chip
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-7-elder@riscstar.com>
 <aPq8ibj2KzQhtYQT@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPq8ibj2KzQhtYQT@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 6:38 PM, Frank Li wrote:
> On Thu, Oct 23, 2025 at 12:59:18PM -0500, Alex Elder wrote:
>> In fsl_qspi_default_setup(), four registers define the size of blocks of
>> data to written to each of four chips that comprise SPI NOR flash storage.
>> They are currently defined to be the same as the AHB buffer size (which is
>> always 1KB).
>>
>> The SpacemiT QSPI has an AHB buffer size of 512 bytes, but requires these
>> four sizes to be multiples of 1024 bytes.
>>
>> Define a new field sfa_size in the fsl_qspi_devtype_data structure that, if
>> non-zero, will be used instead of the AHB buffer size to define the size of
>> these chip regions.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - New field fsl_qspi_devtype_data->sfa_size now defines the size of
>>         the serial flash regions if it's non-zero
>>
>>   drivers/spi/spi-fsl-qspi.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index c21e3804cb032..a474d1b341b6a 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -207,6 +207,7 @@ struct fsl_qspi_devtype_data {
>>   	unsigned int txfifo;
>>   	int invalid_mstrid;
>>   	unsigned int ahb_buf_size;
>> +	unsigned int sfa_size;
>>   	unsigned int quirks;
>>   	bool little_endian;
>>   };
>> @@ -737,6 +738,7 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>>   {
>>   	void __iomem *base = q->iobase;
>>   	u32 reg, addr_offset = 0;
>> +	u32 size;
> 
> I think use 'sfa_size' is better to read code.

OK I'll rename in the next version.  Thanks.	-Alex

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>   	int ret;
>>
>>   	/* disable and unprepare clock to avoid glitch pass to controller */
>> @@ -795,17 +797,17 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
>>   	 * In HW there can be a maximum of four chips on two buses with
>>   	 * two chip selects on each bus. We use four chip selects in SW
>>   	 * to differentiate between the four chips.
>> -	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
>> -	 * SFB2AD accordingly.
>> +	 *
>> +	 * By default we write the AHB buffer size to each chip, but
>> +	 * a different size can be specified with devtype_data->sfa_size.
>> +	 * The SFA1AD, SFA2AD, SFB1AD, and SFB2AD registers define the
>> +	 * top (end) of these four regions.
>>   	 */
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
>> -		    base + QUADSPI_SFA1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
>> -		    base + QUADSPI_SFA2AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
>> -		    base + QUADSPI_SFB1AD);
>> -	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
>> -		    base + QUADSPI_SFB2AD);
>> +	size = q->devtype_data->sfa_size ? : q->devtype_data->ahb_buf_size;
>> +	qspi_writel(q, addr_offset + 1 * size, base + QUADSPI_SFA1AD);
>> +	qspi_writel(q, addr_offset + 2 * size, base + QUADSPI_SFA2AD);
>> +	qspi_writel(q, addr_offset + 3 * size, base + QUADSPI_SFB1AD);
>> +	qspi_writel(q, addr_offset + 4 * size, base + QUADSPI_SFB2AD);
>>
>>   	q->selected = -1;
>>
>> --
>> 2.43.0
>>


