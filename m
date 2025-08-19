Return-Path: <linux-kernel+bounces-775344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9AB2BE33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9179585EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C6321F5C;
	Tue, 19 Aug 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVzwx3MT"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F73218BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597177; cv=none; b=VJocIJU/SdZ2moSd8LZsPpc5MfrkvgVqrSFRMUSNrKmKvgAuNdPjvSujEYUIucdgJjubPgkG8zZULjG1FcSJtjCuOoc5swgcFg+KJQB/sfqIHO9ysOuDfMmUDM2A80eqUEfACc+NOp7pnergKeI+mtr7MD/D3UvNfWqO+COU5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597177; c=relaxed/simple;
	bh=D7ULAKtYONClt57a6AjnjqdTGtyDYDEhUbl2DruBwCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lb2ZAliSvCXdZR80HnsjT+mBygGmvflB9sOp89fzW7WpKqJTJPoabUl9w4OBxLY2uA37nnpBT4Lm9FvCLR/9dBv/Kn/2FRXFxaZ3/CZ+59/NoGpBdMkInBoEFEUBwODwrtKngFAAUh+TuqQsNdQYu8/dGQ5M4y+1iUOhxCPab38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iVzwx3MT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so25856865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755597174; x=1756201974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0h1IqL/4MIVenVvNd5Jvok7Pym6fhE62Ycqm04pTo+s=;
        b=iVzwx3MTbZ48iIyb+5hBFgD4VEmw33zcAx2aGEXSo0cs8IZFPihvcHm4n4DcM0wF2M
         UgGtDTyTmNBclcIFKWH3bmyuQBLCJWDLBnvWJzuQ6daDkL4FV6IQNITZpLnRudr++SJg
         PgEhYy2fBBoIYGezYghQHaxqjbU3w5NRozhJZCxBIJHIuXWcaI6BFj8hRIduMLfUU2/7
         Irq/4TJoyidlDIuzl2E+9NLgPzQq5uRZcmdmU0lXakKPptwjHOfpyuCqzzMJp64Q9LTD
         yRfAzU7T2rY4owrm2eNCg+0UeUuYogPMQaF8LeFKPCbekoOd6vW0poRE+wZHQesV9MmE
         Hm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597174; x=1756201974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0h1IqL/4MIVenVvNd5Jvok7Pym6fhE62Ycqm04pTo+s=;
        b=xEeH/jSK0ROXLW3dpL4errWnguzbQDgIZkhPsrnx3REXv8x3m/F7JIspOOlFlQwcJa
         yeNwiGV7+2YtC5BWcUqSsFQDWnirVXLN5nE7GlElYEvll7xij8SX2/jMWndPG1nypW9k
         cws3VwVZ6X3V4T9cAjxevAtUMUmrbEM3u0Oamd2K76dZuSnBBuEL7nDp6Ob9lIrrEhoK
         lO87cuGR2aOFlYIzN8SxysCPKNKLuxIJELJljlVWaEzoFBbTXZGeweApIhm1e/T3GubG
         eZ8vLu1bKlWJ/ZHXNu2mOQFNHGBB/algf35gWAth6rfdVXwv66AValwCQR9gzKPslhQe
         khgw==
X-Forwarded-Encrypted: i=1; AJvYcCUSPN6qiVV1pge8BdrcehYa9D8Iv5Wi03O9ITJzRQyskPsyJsUVXPZhtiur2e9GSISaHMPZ752eHC2SGxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjTEmG191b85+hSvD1iMlX/y4cY1sexmUfijscuCfNL5wypH+I
	wHozGUG8JPpA1WfuNTO0yCS5y5FsO4hKEnWrirmHUg+wCuZqnEAJ8NQQe2M+YMvt6i4=
X-Gm-Gg: ASbGnctD+0ERaJYc8i/fEDA4jocp7t3JzqJMOxUBx9nG+hbOKGe5+VESVctTS7lU79i
	o03sYFyu3khONARTi3R+TgrowOlQ0TcW62fhHDvL55v7T2cdo4ZAZ+Gk9ddiuNp1p+d+g1Sp0SI
	UTAOe9bqTpud9dzy3QnXlY4ZqlA58OZmFmcQTIxY1lFnblXxY9u2C8FEXdTYL0ALH5rva872BRh
	6MOwS6V86CNpJsecKswyGzZbXsD4LaOUS5724+wJShC0hbE+gdraNoN4a+DQvy9PK56H+iU9aly
	Re+s6lsEBqZMOuJj4KnwHJ64ZKw1+IlVWeOxjdo4uvXmf5NDnHvZBjO3QsZCGQvDIYs/vaQKYZX
	R0WevE1WQJNqe2Lv3mCGlhESx394=
X-Google-Smtp-Source: AGHT+IGlP+6ysDxLZ9KBBa3uZiR0t6DXx2J2w37t28LWBAiGheosRQfe24PXM+YBFSqepDRsvanIuQ==
X-Received: by 2002:a05:6000:2881:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3c0ea5ba0b6mr1523055f8f.10.1755597173972;
        Tue, 19 Aug 2025 02:52:53 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b33csm214351585e9.25.2025.08.19.02.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:52:53 -0700 (PDT)
Message-ID: <05701887-f78c-4de5-b7fa-d34afdb53af9@linaro.org>
Date: Tue, 19 Aug 2025 10:52:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
To: Frank Li <Frank.li@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
 Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
 Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
 <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
 <bd59344b-9dc0-42bd-98c8-80ab9ca97123@linaro.org>
 <aKNJFJDf1Clnkbex@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aKNJFJDf1Clnkbex@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/08/2025 4:39 pm, Frank Li wrote:
> On Mon, Aug 18, 2025 at 03:47:45PM +0100, James Clark wrote:
>>
>>
>> On 14/08/2025 7:19 pm, Frank Li wrote:
>>> On Thu, Aug 14, 2025 at 05:06:52PM +0100, James Clark wrote:
>>>> Document the two valid pincfg values and the defaults.
>>>>
>>>> Although the hardware supports two more values for half-duplex modes,
>>>> the driver doesn't support them so don't document them.
>>>
>>> binding doc should be first patch before drivers.
>>>
>>> binding descript hardware not driver, you should add all regardless if
>>> driver support it.
>>>
>>
>> Replied to same on "[PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for
>> S32G"
>>
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>>>> index ce7bd44ee17e..3f8833911807 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>>>> @@ -70,6 +70,19 @@ properties:
>>>>      power-domains:
>>>>        maxItems: 1
>>>>
>>>> +  nxp,pincfg:
>>>> +    description:
>>>> +      'Pin configuration value for CFGR1.PINCFG.
>>>> +        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
>>>> +                             output data
>>>> +        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
>>>> +                             output data
>>>> +      If no value is specified then the default is "sin-in-sout-out" for host
>>>> +      mode and "sout-in-sin-out" for target mode.'
>>>
>>> why need this? are there varible at difference boards? look like default
>>> is more make sense.
>>>
>>
>> + Larissa. I think this might also be a question for the hardware designers
>> about why the feature to swap the pins was deemed worth including.
>>
>> I'm assuming the flexibility is given for routing reasons. If you have
>> another device with the pins in one order then you can route it without a
>> via if they happen to be in the same order.
> 
> DT team need reason to judge if a new property is reasonable/neccesary. You
> need  mention the reason why need this property. Here, some board design
> swap sin/sout.
> 

Let's wait for Larisa to reply. If there's no board and it was only for 
testing maybe we can drop it.


