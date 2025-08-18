Return-Path: <linux-kernel+bounces-773731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D123EB2A734
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55EF04E3BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49698335BBE;
	Mon, 18 Aug 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aH7Emne3"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255F335BBB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525040; cv=none; b=EP98R0ZclmwTcz/uXWGnaCHS9kaqQ4NMp9Hrv6le9WN9oMGDEZxnbu4kD9u80dL5WlhbzrLAiED7vHyX6P2nEXo+DBM3CSHsfxf86DLArfIcZF21OsCog/2MPMTWfMKl4OZV1UD5pvohmtnl9yM5HBTgaVvD2aF57p6h+kB2af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525040; c=relaxed/simple;
	bh=7yHgSWeRbcyIHbjLHLnRwx4d4C71Zhhg/Zdke7nbkOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXeb5g88b5aX6IdYdeHQd1w/veyYIv3Zds9lEDDIYXzkdkJaW/D3QFhoWegSaAvPNLcxstYXCbA8HIG0FMKlv6nLlpoyznBW8x47+vGngHxPaashnwi+jGE1n1dsvvxCnmukTaSc8e+/SDG+BvLeizNie6isbzY80vmMmEinTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aH7Emne3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e4193083so3942296f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755525037; x=1756129837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DVVUnvtZO4/Z08Z1SdfbMyHejdi9PdhiDncUyyHKx0=;
        b=aH7Emne3U+UkgKJDzVJS7F6bcfdWp/nQxhcWitu9crpnm1ipo8o4CqXyUqL4aWNWXv
         Zp/xALcU11IRJLUdRKMynxrmQfpmc5snOYkiqz0gCKmnu9wIdzga7fZPMuwR6cxKmFT1
         1L/NQHQLur5ltp6HPU3H+zXmpauLVEuCGq/6IkD/4o+53XoQDJ6P8IXuzgd/EJa9u5r8
         6MWQ8Rs2VYPgPcCTP8D6NJOwmjaOneF0tY/11Fj/V976tAZYS+cLIlpw0RXgFz5X8TSF
         GTz5hNOoNG7Zmu4Lef4lWio1AN0T4AwubR3DGWoEGZ70D7ZkCke17vxvUeJ7QgmZ4NVm
         w1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525037; x=1756129837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DVVUnvtZO4/Z08Z1SdfbMyHejdi9PdhiDncUyyHKx0=;
        b=CMbtshbH+dklB9nzsqy9cdFxWcY3f9i5wczmkigjqlchCP39SzPG188tGaSQPzKedA
         tWhAU60pE4/TR4RJgX67FZ27gYZbdaLrwRz8gFJh6joJzxk180wAM0J/sztBuTgkzEcn
         vsrPb79aA07pnWlCTNMjpUSlXBf80nedtW4QBjno15b31CNruVeyAlPrLJ4wm5BgyazW
         TknXLtI7f9FH7nN60U2vxJUIyP1JcEI+gaHvjDLUpR1zECcXNrKZogfpBIw7PjeL30T2
         pyutRGa2f3HLK+VocwstmvNY9T/zdDd5pc3ZHfsj6Imovg9GKTy0AQcQlCm+hniFs9/r
         iChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxx643/CIduqB3B16kk9UO2kOZw/nTbTPVRi59gldq8aAN6Il3EA2uLT58/j2e9zFhWoII5Qz/MBruSWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7nZjIJAQphnkpwD+DzYBhR8FGvgUtvGZe6nFLCGmpdrm6xLe
	7IiEBf+n0I/5CaAlgADO4nCH4H9XjNLNCysrJ8Lu2YyXSnD6DIz+oIfS2TrqdR48d+M=
X-Gm-Gg: ASbGncviS7ARkBfdVrnKZoFN1Qp6SC9o1fe1sBksP1KLj5gR09hIRgry48LkqcBxT9D
	58pyDANMBvgXZIWJtkWDWOELPTiQHYxqAhizgVRrdK4QxLtZAwENeAnziuP8VOintiKCTqJDnlE
	yNzUFaNEaVD/HCizBCaSqiSOwZaskCMhXGabX1Dosh1jxgU8xEqWQ8ZfBwxe2ZkrIHcw9EAbI2K
	g+v7E5bVrcs97DpemRxMFLovh20ZB8KhYCY+r6/bvpx6I6gD0EKw85q/xa5fQW0oJseOTyVkc+b
	KW4pzUNeZa9G5NkfOlz+OxJ19YZ6iHhCPfxWXnPNXnUJd3SaaEHT7oa6SixQ1yBDafwLBRqvGbB
	x7ypgNZL/mpNjR1ffJ76vEh/L2sA=
X-Google-Smtp-Source: AGHT+IFYGhlIbmElePo7wESeoOURpi8z/foNFggrXzWJl9Ckz2bQUv6UqjNpy4xJdPri66mHTNKaFw==
X-Received: by 2002:a05:6000:2886:b0:3b7:8d70:dac5 with SMTP id ffacd0b85a97d-3bb665647dcmr9959991f8f.2.1755525037164;
        Mon, 18 Aug 2025 06:50:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm12603170f8f.58.2025.08.18.06.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:50:36 -0700 (PDT)
Message-ID: <a1e7f857-79ec-4cc3-ac64-0f1f43efb7f2@linaro.org>
Date: Mon, 18 Aug 2025 14:50:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] spi: spi-fsl-lpspi: Constify devtype datas
To: Frank Li <Frank.li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-7-9586d7815d14@linaro.org>
 <aJ4tITKLkfto1ltJ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aJ4tITKLkfto1ltJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 7:38 pm, Frank Li wrote:
> On Thu, Aug 14, 2025 at 05:06:47PM +0100, James Clark wrote:
>> struct fsl_lpspi_data->devtype_data and fsl_lpspi_dt_ids that point here
>> are already const, so these can be too.
> 
> Add const for all devtype_data.
> 
> Frank

Ack

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/spi/spi-fsl-lpspi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
>> index 98da6a5d7013..332a852b746f 100644
>> --- a/drivers/spi/spi-fsl-lpspi.c
>> +++ b/drivers/spi/spi-fsl-lpspi.c
>> @@ -145,11 +145,11 @@ struct fsl_lpspi_data {
>>    * ERR051608 fixed or not:
>>    * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
>>    */
>> -static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>> +static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
>>   	.prescale_max = 1,
>>   };
>>
>> -static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>> +static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
>>   	.prescale_max = 7,
>>   };
>>
>>
>> --
>> 2.34.1
>>


