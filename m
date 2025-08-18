Return-Path: <linux-kernel+bounces-773830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC280B2AAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CEC6831C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA88341AB7;
	Mon, 18 Aug 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwX8zWfI"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB57341AAD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526951; cv=none; b=g+ue+8y9hNvkKlZHE585/ChoSQmmE22yjDyroDfu8GfGWgDQBbO8kWI3RuPfPn/FWmeIQigoy3yMD/xtjlRASaCQdXGjnYgJ341OUKIqpSAobvLvb7lCkVXP266BbuJD0TSgLQ+Wr76iTefcJ6kPZkL0QxcszErkGi8jyRb2XB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526951; c=relaxed/simple;
	bh=Ld4BTbysJvvmlTmsob/shBMtAaRTdrmxmv8v8XzejBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDzCGZG6bkHRnK6Cx2UIB4o4a0P6dNjeLO0A5hHA7oiZEUlR8YWbv2RtlwraoDJTJBfGF3/HFltRdqLLqPvQec4+/KrMs+sGiPQhLc0n2ikAADCYaoZsO5AKgtml9xhYeGRJBBw/OZLt1jbeh3qq+0WcG7Z/4BaH9qwthnkgUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwX8zWfI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41c1964so2913431f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755526948; x=1756131748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFT7EYdl/U8S17HmCa7RikHeUwhOUF2kdHWiG5vKuDQ=;
        b=UwX8zWfI9Y9O0JWLzyJIfhLp4KSd5m0AY7K6K3LctpX/JPE0C6s7xd3Cwfv7cTYF7b
         y97C3ez/IjG1UIuMHk9urbb8Piojo3BxIBJ1HXzzrZdwHoWY8woeQVeOOSor2tnXtMr4
         P0HJwk1hfqz7ZEE8zOa3Budbp94NwevxazEmQfpQTyeFS+5tQzsAKCi8jn1hJ5sACE5Q
         3o3CrwC5IfnPSuoz1H2EzhELR+nLlBCVLnIRw2xJqRO+jmfIAzp3OgIzrwzpkL1L3AAx
         JZFlZnfR1Gc720z7Iyg+XnBevYFp/wSEZ2Zi9+uKeBW9r7qTnnAM2PD9FuakbW6U9q+I
         dR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755526948; x=1756131748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFT7EYdl/U8S17HmCa7RikHeUwhOUF2kdHWiG5vKuDQ=;
        b=c8UT5mrhVSnU5NSK+R6mSoDB3jTY0YyWnzNToJ+OB2bnZpS/HD9QSsSLzP4pxiGKgz
         PVeiIpglSYl7Bz2NJpV7lb3rllRLo/Ci2IdayjNwleBo0kyFyy2GmBjPr/SdgVdtSWoF
         3/4wxfiGe7SNwnvTDfuWhoEVR0NPe+NigRPthCcYYsriwGGg5oGRc/cSkaGi6gVopF20
         3uuRneDxMf4UdsFK+8kDPgq5aeWxlRJJd4jPI3szZspFXjSOOelfzQXHzRdEhYaOYU4A
         eME1lc0GxZvn2SbcKtxRRxFVXdwWEhQtun6J2Cc5C76zCj3ROr94BJP8sP5/+12PeONz
         lBMA==
X-Forwarded-Encrypted: i=1; AJvYcCXaweeh+/bC3iJe1yMD00Khl5Zb/qHn8zcLtvMuFwYCToAEUG3K1MJN3lTGOWumC1QHhCF97W06OgpwKH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoA0uqBgudRbeLG0lWu1ZYBqHhjF7ffMrwX3yleQOxgtrWXp1z
	KRil624zDscTc1lpXqMSKmn4sD8OoatZ47w1wfU6dMcbLVEuxKaYe4WSNNoZdjNj1y0b6wPGIHZ
	blPko
X-Gm-Gg: ASbGncsWQx+MuNprPrft5vxBk2nFK0WdWbdZBAW/YA9TVwORPk+m6RiXVobNZWp4nDc
	xPTLuCnajtGd2DSKvjSQ8RI5wUW8wAJ3+tWOViSSi6N3rdbloj8f690cX86zRPimJdxfTx3iLYm
	kkxybrjcwlIaYATRwq4iuX9eNWsAcU0aChQOORV6OgoBn69uRkyXydrwEAVypVTOluhLkBtl1uI
	HrzKJCu5DD6Pi8Ewykbfa6nqM69asb1ISGUWG9JG/r5Yo7AI9IKCoPHENggEoPpf1hzrF8czLvw
	LD8Ef0TkiWcAeW10wsQKcJdIOHJf6D27K3q5lLuy2FPhigkH1xnqTFlLpLoEXpqwMbeE/lenDYO
	2itRUYoPa6GAIfWcnKDlee/xn1iI=
X-Google-Smtp-Source: AGHT+IHXXBqcG5WtLIRqk/YWgEdHVWCYOOUWvQEUiJZ9gf9C/DO/NkLfo+uNFk8MgEI2qKitz8FZdg==
X-Received: by 2002:a05:6000:2c09:b0:3b7:882c:790 with SMTP id ffacd0b85a97d-3bb68a1644bmr9651163f8f.37.1755526947830;
        Mon, 18 Aug 2025 07:22:27 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm106540185e9.1.2025.08.18.07.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:22:27 -0700 (PDT)
Message-ID: <14fd2e7a-0fe6-4f00-b826-7f3971dd09ae@linaro.org>
Date: Mon, 18 Aug 2025 15:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] spi: spi-fsl-lpspi: Parameterize reading num-cs
 from hardware
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
 <20250814-james-nxp-lpspi-v1-9-9586d7815d14@linaro.org>
 <aJ4rmLgTm+A2hDA0@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4rmLgTm+A2hDA0@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:31 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:49PM +0100, James Clark wrote:
>> To avoid adding more string matching here for every new device, move
>> this property into devtype data.
> 
> Add query_hw_for_num_cs in devtype to avoid directly check compatible
> "fsl,imx93-spi".
> 
> No functionaltiy change.
> 
> Frank

Ack

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 1013d5c994e9..6d0138b27785 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -97,6 +97,7 @@ static const char * const pincfgs[] = {
>>
>>   struct fsl_lpspi_devtype_data {
>>   	bool prescale_err : 1;
>> +	bool query_hw_for_num_cs : 1;
>>   };
>>
>>   struct lpspi_config {
>> @@ -150,10 +151,12 @@ struct fsl_lpspi_data {
>>    */
>>   static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>>   	.prescale_err = true,
>> +	.query_hw_for_num_cs = true,
>>   };
>>
>>   static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>>   	.prescale_err = false,
>> +	.query_hw_for_num_cs = false,
>>   };
>>
>>   static const struct of_device_id fsl_lpspi_dt_ids[] = {
>> @@ -960,7 +963,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
>>   	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
>>   	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
>>   				 &num_cs)) {
>> -		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
>> +		if (devtype_data->query_hw_for_num_cs)
>>   			num_cs = ((temp >> 16) & 0xf);
>>   		else
>>   			num_cs = 1;
>>
>> --
>> 2.34.1
>>


