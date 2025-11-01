Return-Path: <linux-kernel+bounces-881248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF23EC27D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E634A4DB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFD1FF1C7;
	Sat,  1 Nov 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGKh0mny"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3092566
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997993; cv=none; b=PorUzmr7kcRr/BxFVmaRL+/t+OcFANE2LsL2CAo3qjjcrD1J5vZhm9xojEUtOJ+0XsGIyNTjP9zOyFAcajpA4hn6nWkLGSs0Nf1nMNXZyPpw5qALe5Ux6P9qAcsPIpZRixVryIiZHj7H7sIU41VvBPfbcangV7JmVLq4OdXfW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997993; c=relaxed/simple;
	bh=oK4uPbJEHgdkkfoWapRa04Q8AETAcOvcyzklgbYEu+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3MkvdHGxBpBk0UnYw7tZzfH+CkzB1I8MJDs0MBCb8Yta60BoX405YPQN2Nz8MFX0Nbmc4KmkASE7Ip6pAwBMo5V3zRxcN5V1vmtjR5rHKl0N7Du+uVkfVib90iIivHulTSilKA/MtWqWBjtzPQUbaw7GSJ0leypvPPo7haLK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGKh0mny; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b95f573597eso751033a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761997990; x=1762602790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZcyG5Lpi31OFKPjHBo9IwkD5rxwA3cUQ7Lfix/dzXQ=;
        b=jGKh0mnyxXJxqbhcpapKzMtaTmnajDmgfosU7pg4IDBY2TTP/Wn97eEanhv1681o8g
         naVtnBjfLU86wltZRr+R2niIoHtbI+7HZUkGwmTBop0giuahZmJ/fI6qvkJK1P0/yQbB
         R8ojiH86h5bUILkH2QyoeXbKs3IGkzGnEK9iJNPB3O+WW7Z5efHqrjIrO06nQ0h2KBCj
         aDJyot/8Qz2l2Bnl4pRXuQPW5+hal9DaK5p9NaBMxVNjut13BHqIsLr+nn0us5m9GhLN
         ++UuX+ImCNuErG4QGZAPhCUBAerWEzS/4KK3dbxDOsM+Lj8iSIC0PW4T526j/xj6NWyD
         kDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997990; x=1762602790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZcyG5Lpi31OFKPjHBo9IwkD5rxwA3cUQ7Lfix/dzXQ=;
        b=MAL9nnba/O9VkcG6qUmiYHChzk4kjvf/3Ol+YfaBtmHhJLj8MdS/KvPbpxqdOZVRfL
         xWwex/wYYjaul/70hpWl4U/AQQ6q06PLCYv4BDIRzCje8tVIWYy+qLa/97wili13hr0D
         LWu5hciYDM5LcuvryD62VntD7lW9hk1J3GXtPjLzzwROxuxRsif9UyAi5P9Y5szzk7gq
         /999HLHcj+W7G0u2aZaL6ygeNkuVAzEuGJBH/wwnnO7MTw4YoKIUNy8c+WcQ3AGDtb7Q
         ehe9OvHAx5ukUpKW69G8dt8SXWrEwZtUsViQEVH69OPxBn/agLjPy8F8lXPLFZqLdLyL
         ze0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnYY+pCkDJ8u0VC2AZf8bVj6jaBRg4jH5ON5908BEqTAoiiKcz2CYeJTFisjVWMUJ0QBLMXKefXeMzw6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/PVzu183krHoYslYHBIqrQjenFJ6bT1ZdDrwgqY43CdzD7x+
	gOS4WB03EKJrHcTbVdThhiYX+/q5dXsh+ihgueZ8qEj7MKsh7IqT/6r3
X-Gm-Gg: ASbGncutk1P3WI8DEDo3tjJgm5x2MIVRSta5o8weMTvhE84rk0wYgoJVvuLxReZsL2V
	i+FIWubV44JWV0v4V58PYRmHuSsAfEq8wPs8J4nsrZoNh4mNjcYDhtUCaR6oVBKiJGZEUSJoDrV
	oIXs78zo6h5OTAGp0wsS+wnMMgdx9ed5DfwSw8jirFMwsTv2SnVGfOCMKv8WH9hbbEAxZuLweaB
	DmcEpwBkKQAaM0kpa0pTsi50ka8uRlOm6Ks1Uvd8RU1CedCDGZdzB11xq8PnZX2JjcGyHNr1XxS
	iHtDRkkaqJAbrfnm7DxGJcd4BaflHEYQ/viz2yKhsyRNNMZ6lNSkRExxifiols75FzmBi9U2pgl
	vstRpAMID5xwdmSz2LW5isuWDkNNty4sgjVCCiJ1Zf9QMYorI8BOM9WNS+P72stJS0DbXFEolhZ
	ckGTzE1rudIA1ENwMD9jBkjJNXhjAtxy3F4cZfLzfb8vdRmMWfXSxCbfBVGX1R2U77XzvlYWEps
	DR9x/+nhJoSoiCzCKwn8keQ44rTSOqrp6FVMHQt7q+4Q/BtZHKT8KUg5yFkrGcpgXHZFZB29ADv
	UzypxYWP
X-Google-Smtp-Source: AGHT+IGU7+DlaBTm5F6E4+pWRQT7EbXJbl3N21cibfZUUv++DUl8FVlOPBwjm7rse1lVhnN842pFsw==
X-Received: by 2002:a17:902:e850:b0:277:3488:787e with SMTP id d9443c01a7336-2951a39063fmr88909475ad.12.1761997990510;
        Sat, 01 Nov 2025 04:53:10 -0700 (PDT)
Received: from ?IPV6:2402:e280:21d3:2:61a9:cfa6:c139:b812? ([2402:e280:21d3:2:61a9:cfa6:c139:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871063sm54834445ad.21.2025.11.01.04.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 04:53:10 -0700 (PDT)
Message-ID: <3becedb7-97c2-4b9e-b669-2bd4dd91c11d@gmail.com>
Date: Sat, 1 Nov 2025 17:23:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] dt-bindings: iio: adc: Add TI ADS1120 binding
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-2-ajithanandhan0406@gmail.com>
 <20251030171212.00004069@huawei.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <20251030171212.00004069@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 10:42 PM, Jonathan Cameron wrote:
> On Thu, 30 Oct 2025 22:04:09 +0530
> Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:
>
>> Add device tree binding documentation for the Texas Instruments
>> ADS1120.
>>
>> The binding defines required properties like compatible, reg, and
>> SPI configuration parameters.
>>
>> Link: https://www.ti.com/lit/gpn/ads1120
> Datasheet: https://www.ti.com/lit/gpn/ads1120
>
> Is a somewhat official tag for these. Though better to put it in the dt-binding
> doc itself as well or instead of here.
>
>> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
>> ---
>>   .../bindings/iio/adc/ti,ads1120.yaml          | 50 +++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>> new file mode 100644
>> index 000000000..09285c981
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1120.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments ADS1120 4-channel, 16-bit, 2kSPS ADC
>> +
>> +maintainers:
>> +  - Ajith Anandhan <ajithanandhan0406@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,ads1120
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 4000000
>> +
>> +  spi-cpha: true
>> +
>> +  "#io-channel-cells":
>> +    const: 1
> Power supplies should be here and required (even if real boards
> rely on stub regulators).
>
> Looks like there is an optional reference as well - so include that
> but not as required (use internal ref if not supplied).
>
> There is a data ready pin as well so I'd expect an interrupt.
>
> All these should be in the binding from the start as we want it
> to be as complete as possible.  The driver doesn't have to use everything
> the binding supplies.
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@0 {
>> +            compatible = "ti,ads1120";
>> +            reg = <0>;
>> +            spi-max-frequency = <4000000>;
>> +            spi-cpha;
>> +        };
>> +    };
>> +...
>> +

Hi Jonathan,

Thank you for the detailed review and helpful suggestions.

I'll update the binding to include the following:
- Add required power supply property (avdd-supply) and optional vref-supply.
- Add interrupt and interrupt-names for DRDY and DOUT.
- Move the datasheet link into the dt-binding description.

I'll incorporate these changes and resend as a V2 (non-RFC) patch series.

-- 
BR,
Ajith Anandhan.


