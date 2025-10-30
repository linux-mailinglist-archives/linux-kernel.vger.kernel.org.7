Return-Path: <linux-kernel+bounces-879043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7768DC221E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5573B1A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D536CE0E;
	Thu, 30 Oct 2025 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OCcvECLQ"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF53678DC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854696; cv=none; b=fzS4H2P5ssJUtdhkLXo7R0XfTithBu3pC1VQe6BisSy4MQo6phFLuTlQ9N338nVw+aABaDD+4P6Wl5t4tkAGa2w6vmgk/TdW63i8E7gXFqkhFSeHUOF2s4DsSXECtAAwvcVEU+nc2MNUAwo43+6aKV4ylZYvp+oQbgXVcbP7iyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854696; c=relaxed/simple;
	bh=pqR2twSqOGM4sGtKUKqSOw/m20SLXlt0O+4cajvhO3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4B2uCI66MkWMtSIcj5u7ZlVYDAoNpYmjlNaVxG2qur6ezjmD0+SH4uGfudDpb1ZonnGTjp90SV2yH9MDSE++iOBCTRdktIh3wdhoCzUXoNiaUGv7XrFVT5fw8D/41KK6PUCnZfdUearnP224IZVJMDsKxwxeSZk9GvWRmUm21o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OCcvECLQ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c281c649ccso1030264a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761854693; x=1762459493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Hd6daBLsyD7x4GoT4BnZnJBmthb0n09ST/82FiiXUI=;
        b=OCcvECLQMz2S0mvhvUVEdOZDtYWS++nPr/AfB2DsUV4mbWU6aXuSgKfRCN/OtXFPK+
         OFeSIAYqJ4K0hhHrVhwpbhWuFf/ywm5oxS21IBetIMWOOdMcpjpguiRIhy5ucRteCKVi
         O/B5HdpfT0c3YK9tenf4mJkH+oUcG0+Vo9GAATFw1DWuQwVRsXC56QEXO3DU2o4Rdc3m
         4ZObWuy9VgV1OvOlZCoxzLsEkGeNnxhgx/jpY1zXGrcgTbYj3hC26RhkSI5hMqMOZ6di
         22hravu2nNzGoHEsk3Ic0Zd/nm65TvAu99OQsdDed9Pu3qP9hFLsUTHx0P1tgpnbcYs7
         MQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761854693; x=1762459493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Hd6daBLsyD7x4GoT4BnZnJBmthb0n09ST/82FiiXUI=;
        b=QOmO5ZrKgBDjRJl2hWkdjA3W0OBv4NzIM6sZ8vpN1vWB0wRL7rxqlqagCmX/DZhXnm
         fP2YXgGVFoBwaH+Y7YqZbV8CtNHx6E7HsKCPCmsNwQggriKCYGtiy+jm9+w2JvZHBxOP
         ScDe+IJvSGJ7ymUasVUxclrc9lWwYfS6TJQ8KBej8iI0j60YTui2u9TwoiEfn6cSjgaN
         C70DyEtn+jKQKKAVA85OE1+SS5n6jkEqmubIxsGzVKQjuIBHbEllv408bb/zoJtSj8Tn
         lJlszZDqdRnJLy+eW7CRQ0/4r8RZjxQPC0zwhm7zzmU21Gz/qzsv2/zShUOSSYnxWaQB
         f/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWCaZlwvVnTyt7Prljq4YfQxZrxzoak3E6JfDjUD92Q1gSuNB0yFsvVCjCkaSEP5Bd9RjD1vDs8oFGEJM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXB5EZKm0GSAY3ILWNWIPoHYMqQHHUL+uIfnuw1XF1cjvaajIU
	6CC3Vc/olK2kwjGnFydWIIZJhCDpdiOGoupXh4BcWu8LyF/v2/APIOzR5ljp+58STlw=
X-Gm-Gg: ASbGncvujSxoo2wjFXhPG0SS+EvmPlDIbuwHrFbDy7NOrhklzWHel7KO0Jvk91jXL8g
	mrLXoA2UzjXITyFM5VY8XP27hsJhGRpPkRXPGMVmlw/WjBeHg5xeSLLmyqdxLUgtx/0UL8HI7gC
	ArH0R1qHbiDRvE3NAuJc25/YtX7E3Dw4ESS44/XXrA+GHOu0l8YBsZkvEa3oQV/RxwlNuxJwHVj
	PGhk65ETgKPV+tcxsL9W1EWI2nOKIpvoZKIp5GjL2ni7oL72Hhmd3EilpiENfygQMvt7AMEwvtv
	xdRpmeJzWrPH7OI/VCyPbvDvk2TVBoDXoxHYGTte5mh1CUjBvQIXg/7kWR8XkUxjGbfj4dwnECY
	wymEf3QiE93tUFybZQcExpHyuVhI2e/OwK/4Hqz8G4DswtUvaD30Xm8b4ZUvpX2o6Whl5rZmflO
	FNk5qowr6HBM1dCNVDqkFVo5+fP6elnasvWVKMeGwgBy4l7B3CBw==
X-Google-Smtp-Source: AGHT+IF3d0tBzTvmcS+/xfeWwxQ6Lq0czWZ+p8zE1S8eYr96+SbUGR6bnT4WG1sWseccttHI7KklFQ==
X-Received: by 2002:a05:6808:4489:b0:43f:21bb:32ae with SMTP id 5614622812f47-44f95ff5dfdmr403347b6e.50.1761854693378;
        Thu, 30 Oct 2025 13:04:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:aa90:4f8c:bf59:360a? ([2600:8803:e7e4:500:aa90:4f8c:bf59:360a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-44da3e80083sm4501853b6e.14.2025.10.30.13.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 13:04:52 -0700 (PDT)
Message-ID: <31d3d3f9-c9e2-4ad9-a3c6-e85fab4520d6@baylibre.com>
Date: Thu, 30 Oct 2025 15:04:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] dt-bindings: iio: adc: Add TI ADS1120 binding
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-2-ajithanandhan0406@gmail.com>
 <20251030171212.00004069@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251030171212.00004069@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 12:12 PM, Jonathan Cameron wrote:
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
>>  .../bindings/iio/adc/ti,ads1120.yaml          | 50 +++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
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
> 
> Power supplies should be here and required (even if real boards
> rely on stub regulators). 
> 
> Looks like there is an optional reference as well - so include that
> but not as required (use internal ref if not supplied).

Actually, there are two. REF{P,N}1 is an alternative function of
the AIN{0,3} pins.

It is also possible that the analog power supply can be used as
a reference source instead of the internal one.

This came up recently and we glossed over it. However, I think
it would make sense to have a flag property that means "the
AVSS supply is of sufficient quality that it is better than 
the internal reference supply", e.g. ti,avdss-is-ref. And
drivers can use this info to decide if they want to select it
as the reference voltage or not.

> 
> There is a data ready pin as well so I'd expect an interrupt.

There is actually two DRDY pins. One is shared with DOUT, so we
should have two interrupts and interrupt-names so we know which
pin is actually wired up.

> 
> All these should be in the binding from the start as we want it
> to be as complete as possible.  The driver doesn't have to use everything
> the binding supplies.
> 
Another trivial one is an optional clocks property for the external
clock. It doesn't need clock-names since there is only one.

Additional bindings needed when this is used with temperature sensors
are not so trivial though, so we don't need to add those until someone
actually needs them.

