Return-Path: <linux-kernel+bounces-773727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCDCB2A7DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FCD5A000D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3AB335BBE;
	Mon, 18 Aug 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPNJqgXd"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D262B335BAF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524940; cv=none; b=Kzfm9zJKW+yQymKOQCojffCT3BZboZawvKADqyUuuc5pqd1rvoIp2WF1OelA+CxpkPSdDQ60lbyGJtqgzdlN8IILiEd00Eir7hKPOJc6K6RRRMdZNLuMsdVw825r3GbjOfbkPfF8DUiaklFRX1s5pmqwLvl0TiQNv4I8hIBVyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524940; c=relaxed/simple;
	bh=Iq41YliHm0d8n8rWWR3bza0G/ceeGQ4+coO+hydkSXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmautl1e5uzDRf1Mi2JQYhN2MT1zjWSkl3z8v1w3hCKX4TeN3R4Gn5oiYbNRyzEEvVRU0HRMBtdDgEN29WCLLQRSBBH8UBNuCi9k4k6CwuMg/tBUcSgfregr7yF0uLDf8QRBV+j6+eM4FhTAr5pDhn94Bq79lE3gAsEedE/RC6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPNJqgXd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e415a68eso2128355f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755524937; x=1756129737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sh+bHoKKtm/hsPtjkx/NyjNhDEo2COTVB4L7LsR7sJ4=;
        b=HPNJqgXdAJU7G6N3CBwRg5bE1IrspC8AyG4V1Xd04ZTS0q+WVCV2Uqdj3cePJGvh2M
         jKQ+UaEJUR1vhSpNtcdAJ5kzeu4IcqXysa+/v5SinH/FAJRH9khJxVXas0B2N8eYXFri
         FFMmz9STTViKkJCL0bG4AKLkdSYi552lAw0bmELSt8qzjKWNKDrk0tjCG0KZ9Ie428h7
         E247CYTUWBV2afJtmLR9+ni0nyLLw+TaJyIkHbzo55VeI+0CQuuuShvlibqwYrhxM+4E
         l54JcQsDSCY/gBPro51+QVxeAQx+6DdauLljn8UCznKvDq5oRzFcyvdwDohlhp4vVvCk
         pIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524937; x=1756129737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh+bHoKKtm/hsPtjkx/NyjNhDEo2COTVB4L7LsR7sJ4=;
        b=DnZGms1AlhuZjvEMyjYqewTHtwH98WI7u2RSHa9PzcmBGUozQmceOzOym78cfYDw7v
         qt5s1FSIYsuIIH7czpWZmw8cDTdy0xZOIKM3234/v2k6PPOXxAF0kGHt4oLJ6vHejw2y
         +1f57NhXlijaA9lNdW2Bgc7oPcxkb9MqlH2PN+3HP4w/RC20CANcDMyRiCp06ef56LI/
         mIDwIx/TpgEkaHerUfiHK5R/voXy4jQFgfF/wo2CNFecG56U6FF/03ylEnMqx8q15rnd
         M9DYrZJEQDmefDc+dZyHnbPHe3oS3RAJ4UK/sZurl5HK8Adk+kzlNIa4xV9VG5WNQjZ1
         NUJg==
X-Forwarded-Encrypted: i=1; AJvYcCWkQ2vFCNVdoIRc1whL4m934rcfyLqY9J/t0cvGdVuMuo0YwjPn5ap6gtQGVLa0w971TDvb/NbXNTqFrFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3J4XMA0qQHa+LOd91HjPPkiQuqJpj+DWr6sK+d3LyQUdlwON
	cLvIi+U6v8vb2rv3x1aWCkBVZKnq1G9GPV9bVNT2fp++c3URfBGw3HbEGGy9jRQc3B4=
X-Gm-Gg: ASbGncstRyQnW/U3qcpfSLObjes7D98Kycf+RPlfcP0kaE+rDjsQPZjRHLj9N2u5MBK
	8vmAgZCZyu4plzMzEFBV+F1+I5DzjNYPitCTNt34Onxm+aEFF9gz6l8SgSt91GRcXb1MZGK1hOd
	BzdI8tn8dsTMXE231+mqPDX7UPUl0VNUbD4/Al4M0l9XLEecFqXOMvJ7aEAWsq0hTJf1gLNn4EI
	Q3/Pmw5JTdL0ptKPMu2Gd4HiajeNfmYY5D5c6xB65JI80XuDdhng3mi1VCmdNZxFWiVUMBr8cJ1
	Q9nB7bACWTvl8G9fAF53N7xv55QKwO5OiYdhuvAWQeIbLSeiTFl0QfOcIySheMRyqL78HMiWIqd
	oCf/zLBNhmoJcK+RNRExlXrlwd7I=
X-Google-Smtp-Source: AGHT+IEKz79YyPVBfJQGlFogDcQJMYXgYE5WI5cAwBE2CTscdIWf8BDHmqXB1zUVqxIISepL6GSx+Q==
X-Received: by 2002:a05:6000:430c:b0:3b7:8984:5134 with SMTP id ffacd0b85a97d-3bb66a3b2ddmr9157492f8f.16.1755524936995;
        Mon, 18 Aug 2025 06:48:56 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5e232534sm10573878f8f.24.2025.08.18.06.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:48:56 -0700 (PDT)
Message-ID: <84498b4b-9023-4a39-bc75-d2b7a495821f@linaro.org>
Date: Mon, 18 Aug 2025 14:48:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] spi: spi-fsl-lpspi: Enumerate all pin configuration
 definitions
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-5-9586d7815d14@linaro.org>
 <aJ4mfDUcbrP7OSOH@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4mfDUcbrP7OSOH@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:10 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:45PM +0100, James Clark wrote:
>> Add all the possible options, use names more similar to the reference
> 
> Add all the possible pincfg options,
> 
>> manual and convert _OFFSET to _MASK so we can use FIELD_PREP() and
>> FIELD_FITS() macros etc.
>>
>> This will make it slightly easier to add a DT property for this in the
>> next commit.
> 
> Make it slightly easier to add a DT property ...
> 
> No funtionality change.
> 

Ack

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 79b170426bee..816e48bbc810 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -69,7 +69,11 @@
>>   #define DER_RDDE	BIT(1)
>>   #define DER_TDDE	BIT(0)
>>   #define CFGR1_PCSCFG	BIT(27)
>> -#define CFGR1_PINCFG	(BIT(24)|BIT(25))
>> +#define CFGR1_PINCFG_MASK		GENMASK(25, 24)
>> +#define CFGR1_PINCFG_SIN_IN_SOUT_OUT	0
>> +#define CFGR1_PINCFG_SIN_ONLY		1
>> +#define CFGR1_PINCFG_SOUT_ONLY		2
>> +#define CFGR1_PINCFG_SOUT_IN_SIN_OUT	3
>>   #define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
>>   #define CFGR1_NOSTALL	BIT(3)
>>   #define CFGR1_HOST	BIT(0)
>> @@ -411,8 +415,9 @@ static int fsl_lpspi_dma_configure(struct spi_controller *controller)
>>
>>   static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>>   {
>> -	u32 temp;
>> +	u32 temp = 0;
>>   	int ret;
>> +	u8 pincfg;
>>
>>   	if (!fsl_lpspi->is_target) {
>>   		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
>> @@ -422,10 +427,14 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
>>
>>   	fsl_lpspi_set_watermark(fsl_lpspi);
>>
>> -	if (!fsl_lpspi->is_target)
>> -		temp = CFGR1_HOST;
>> -	else
>> -		temp = CFGR1_PINCFG;
>> +	if (!fsl_lpspi->is_target) {
>> +		temp |= CFGR1_HOST;
>> +		pincfg = CFGR1_PINCFG_SIN_IN_SOUT_OUT;
>> +	} else {
>> +		pincfg = CFGR1_PINCFG_SOUT_IN_SIN_OUT;
>> +	}
>> +	temp |= FIELD_PREP(CFGR1_PINCFG_MASK, pincfg);
>> +
>>   	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
>>   		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
>>   				   BIT(fsl_lpspi->config.chip_select));
>>
>> --
>> 2.34.1
>>


