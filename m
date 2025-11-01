Return-Path: <linux-kernel+bounces-881268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5183C27DF6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638C23B9311
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D992F692D;
	Sat,  1 Nov 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgqMCPri"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10C2F5338
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761999893; cv=none; b=hVMhUS44SC1HkZY2qU1rNWoe5xTWZGJLrZnt9w0ivaUBiudFEVR1WQCzF6miIKLycjBYeuCwc8tL6S9EpRIc8vlzKz2QtKAecrJi0DkZWJqDqZGZHJsQsv25RWotaYvtDlzdf1RMlvu5iQeR82CbTYXHIV/7WQpT6hmcxXDWFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761999893; c=relaxed/simple;
	bh=H3T42zwZoQOY918AUIfXPtQAQ8O4vJUH6zE5aMCtHeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjSVhNXdRh5ElgfymSSXyCgcBTh2zlukP29fLULczHNpXuLgRdBh1n7KUmaU8cwbXBZ6xJvVV4YThcWQ8xF4iikt0hvAUz6i0RMt95YWZYPX+Pak7AKkQ9W0tV8y1IOIXtNB2YXXbCnpGjsrueuQTVBawBxgglZkQ9KO/x5OAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgqMCPri; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2957850c63bso342505ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761999891; x=1762604691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AicKeGnMXx8PABK7v2yBnCUGk97CkJDInr2iWMYCK54=;
        b=RgqMCPrirpwlk8jFzakVb9m3YGeBglQjl+LMtpXvz4+DoWm1D06rkyklM5fBVfD62u
         2t/Lv0VNBgPVJoh74uAfHuvXh4D4gl4+D+pdcjm4Rrs8AWdx97Ofc4qyB2mkR0JMprc4
         aWwHykGm7aFq6SOm4ky1OuOvQJEP9HtwjYNcXRNRzOzL2cC0iOROVEomngPnKGz12Zhp
         m1cvqUjMU7mAgaeZ5sJTsSKUupH7tylCd9UmqD0GgHdmntQ377v/XD1xYz9ODEOXlLGp
         giZplxDzcy5wX8YlI+0yQT0FZHM+9O4rOmqfBR9kM0wKfdRGNi7MVBn7pknIPwd+pWy8
         2EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761999891; x=1762604691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AicKeGnMXx8PABK7v2yBnCUGk97CkJDInr2iWMYCK54=;
        b=KzZ1MAQF5NeSnUX4I5aIzj6RPiy57jQgZv+PhFEhGBWHy4K/FAjdwZmDezRtWWGzVo
         UoxSpb9fTfHKgffehPu0w/uZs1UWUCZqKEpB3XDpC8EMRPfAZQSjnLecl9WK2gF4YU7i
         1k/ICJ0zI9RPze1fRGiXCAax7Fus/M9IPS8+1atwdu+hqaPd5i1w/mUxchalc7bIAJVR
         iBI7IpD6a/EU1ZK0TcjNCUIc+f37+t7p4NZevkSRYbRhRGM4fMqNZFmkhY8nZqfS1MGW
         dbj4bbJCA75de8G3n4/95xLKlVtJinqMwUI5rXX1MtHq37zc5VOz4KceilIF/wPSjMg2
         HIIg==
X-Forwarded-Encrypted: i=1; AJvYcCUOqcNvQq/Utdromf2Ka+yTOn12/tkb5kV98jDQw/7/514AHY42OLdCoswQSS5aIm8bTV2C9s6d0p8RbFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQzjIy7ncw46pouF8xMMd0uRZoAYcqGPS6M1KHwYndlg/akZe
	l8LaCcIx3GRetF8PnHbMw6ZA1B20mHvLN3X3jOyfTCemWQXxddHq06cz
X-Gm-Gg: ASbGncv7/0cGBa4u4SQInn+T4bRo3QLGYpI00xmqtRUl3kLbqwOjvalKGnvTF5xpvAK
	yUMEswvitMkrfY+4jlMU4OMuo7jGOrbX7V7+DNqTRGE+Bhs4kIlxH4CISrPHWRKzBOhvsxlj7oZ
	8DXs+4biHBbeapsslDkNtfFG28EAU68Eeb35wD5mlc5GJJasusmucMZWpAaCtDK4NUNpJL6a1if
	L7v55R5LG7npNx1vGWuaCk9MOHOMdgcc9CkObY2jJk74e93TukGSfPA/jA5O+mTZbyks8Co43w/
	1zfBMyjN1yZItbjzFRsruK0lv59BU5u7prGBKXsiFILDIwbFyertx5sUlKhzHdPDcPw2xV+/Ux2
	+brgDMBRMwnprVlTPlAuJ/xcU1Ib/YNR0nczsAt59lN1mc9uz3fLX+M4QuUMiUKiRmttnWXcI3O
	uhY32j17ZbghzMP22Hp70MVrhqUfRSdc5YNOis83oFUQdaOCIrmptonRz49wf7t8eRhXLZWBSPk
	uER59Dqp50Alzi5KlydaBBkBcAamJqbqCyREVBrNdiCqRnw3ANIjnXuWDqpFtWshVYVCSqLEuZF
	xkuOvUgg
X-Google-Smtp-Source: AGHT+IEkansOp7TmntY6pjVJdWg2R+kz+hv16vydkYdNnNBGWpvEJ3956bhJwqof2q5MCUwJUJGaqg==
X-Received: by 2002:a17:902:e891:b0:24b:1585:6350 with SMTP id d9443c01a7336-295185b3b01mr86689115ad.11.1761999891327;
        Sat, 01 Nov 2025 05:24:51 -0700 (PDT)
Received: from ?IPV6:2402:e280:21d3:2:61a9:cfa6:c139:b812? ([2402:e280:21d3:2:61a9:cfa6:c139:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b785sm56474475ad.78.2025.11.01.05.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 05:24:51 -0700 (PDT)
Message-ID: <1c5a2683-77ad-4687-b47b-18732807d5e8@gmail.com>
Date: Sat, 1 Nov 2025 17:54:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] dt-bindings: iio: adc: Add TI ADS1120 binding
To: David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-2-ajithanandhan0406@gmail.com>
 <20251030171212.00004069@huawei.com>
 <31d3d3f9-c9e2-4ad9-a3c6-e85fab4520d6@baylibre.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <31d3d3f9-c9e2-4ad9-a3c6-e85fab4520d6@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 1:34 AM, David Lechner wrote:
> On 10/30/25 12:12 PM, Jonathan Cameron wrote:
>> On Thu, 30 Oct 2025 22:04:09 +0530
>> Ajith Anandhan<ajithanandhan0406@gmail.com> wrote:
>>
>>> Add device tree binding documentation for the Texas Instruments
>>> ADS1120.
>>>
>>> The binding defines required properties like compatible, reg, and
>>> SPI configuration parameters.
>>>
>>> Link:https://www.ti.com/lit/gpn/ads1120
>> Datasheet:https://www.ti.com/lit/gpn/ads1120
>>
>> Is a somewhat official tag for these. Though better to put it in the dt-binding
>> doc itself as well or instead of here.
>>
>>> Signed-off-by: Ajith Anandhan<ajithanandhan0406@gmail.com>
>>> ---
>>>   .../bindings/iio/adc/ti,ads1120.yaml          | 50 +++++++++++++++++++
>>>   1 file changed, 50 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>> new file mode 100644
>>> index 000000000..09285c981
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>>> @@ -0,0 +1,50 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id:http://devicetree.org/schemas/iio/adc/ti,ads1120.yaml#
>>> +$schema:http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Texas Instruments ADS1120 4-channel, 16-bit, 2kSPS ADC
>>> +
>>> +maintainers:
>>> +  - Ajith Anandhan<ajithanandhan0406@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,ads1120
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  spi-max-frequency:
>>> +    maximum: 4000000
>>> +
>>> +  spi-cpha: true
>>> +
>>> +  "#io-channel-cells":
>>> +    const: 1
>> Power supplies should be here and required (even if real boards
>> rely on stub regulators).
>>
>> Looks like there is an optional reference as well - so include that
>> but not as required (use internal ref if not supplied).
> Actually, there are two. REF{P,N}1 is an alternative function of
> the AIN{0,3} pins.

I'll add avdd-supply as required and vref-supply as optional to support 
both external reference configurations (REFP0/REFN0 and REFP1/REFN1).

>
> It is also possible that the analog power supply can be used as
> a reference source instead of the internal one.
>
> This came up recently and we glossed over it. However, I think
> it would make sense to have a flag property that means "the
> AVSS supply is of sufficient quality that it is better than
> the internal reference supply", e.g. ti,avdss-is-ref. And
> drivers can use this info to decide if they want to select it
> as the reference voltage or not.

I'll add the ti,avdss-is-ref boolean property to let the driver know 
when AVDD is suitable as a reference source.

>
>> There is a data ready pin as well so I'd expect an interrupt.
> There is actually two DRDY pins. One is shared with DOUT, so we
> should have two interrupts and interrupt-names so we know which
> pin is actually wired up.
Thanks for the clarification. I'll add support for up to two interrupts 
with interrupt-names ("drdy" and "dout") to handle both pin configurations.
>
>> All these should be in the binding from the start as we want it
>> to be as complete as possible.  The driver doesn't have to use everything
>> the binding supplies.
>>
> Another trivial one is an optional clocks property for the external
> clock. It doesn't need clock-names since there is only one.
Will add the optional clocks property for external clock support.
>
> Additional bindings needed when this is used with temperature sensors
> are not so trivial though, so we don't need to add those until someone
> actually needs them.

I'll incorporate all these changes in v2. Thank you both for the 
thorough review!


-- 
Best Regards,
Ajith Anandhan.


