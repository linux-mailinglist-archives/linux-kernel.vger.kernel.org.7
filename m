Return-Path: <linux-kernel+bounces-772222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12009B2901F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 20:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B29E1B68AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618EB2046A9;
	Sat, 16 Aug 2025 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xxGf0Zo+"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6C20458A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755369833; cv=none; b=PeZ0Z7WwHvby4JEZiP6cxNbUqBu4WM7UCLJQp2mKPLYSgnmozb4EuRbvX07wMYs0+dtRz6cvL01zyZFiMKupIhDYGDGivx2RUyB7jCYC7DIhIdTTsgWQqBeCDJpvurCF8ymaBReqLKAAeQBbnvvxdB2EA8CZF1yrejFb3W1549c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755369833; c=relaxed/simple;
	bh=K8MMx+BgUTjelkpi5h0lubeR2iZfAo8T07Wso3PSfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qfClybJ+R0oTAquuO8cn1hljBF7lWnRq3k7Yhz2utsF5IPkHxhmSjDhPPWKo4jiuUCZ00wTOb/KLymJXmQAQ9U2TaKPFA2delvgI5F02TSqvyhP91JpouTCWSSnPASsTcc8H01XPaLrxbH8nenz5LML4HXgIZ7wb7RN+E1Ge7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xxGf0Zo+; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cceb3be82so2629650fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755369831; x=1755974631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1jsNiINDg+jou+qZJDnS2+osG4c6UiQjY6RKX9f5D4=;
        b=xxGf0Zo+yiejmMKJbwWScO6yq+wN2TLozAIyHh30rdmRoSUysNpked6os91zG0T1kd
         QxrStajuQvN5/uK9PWrMoMGGJsrLhimZrAwAKDR6h1oHuQK5b3Vwe/MxzKGGbbdOdkik
         ckis1zgiPe6xnoru2VcadeMrv8cDAgoEjDyRMXGFi1ou54t8v1AvhcZ/uOW8yFyDmVaa
         bYzTOfjYYoS6pKAun9dayLbL4ieiHMk/Zx4n2txyZNm7NthuiXv20C7E3jrwhR2Cqv8k
         wrZFr99R8wMiyXsvA7d/fpf33CsbYP1yQp+VgEZ6VymP8+v/0GtCsRzvuZeRaK7Jfkee
         y2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755369831; x=1755974631;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1jsNiINDg+jou+qZJDnS2+osG4c6UiQjY6RKX9f5D4=;
        b=kEUBptL03kBuN1+Uo5eIatbFiYW9Zz0u6UIP5oYC3ecM000vtZDJjftPmQAQQs2zEp
         AyStnOmuEuKfDJG6SWUVgO+p0ua/gR3j9N42GTkdfzyc1cwcb7e0UcqWhByvqNnMwPrC
         OBWGqe+Hd3aU8QfX44Ki/iXgSLl58MC4XJvoluVdET7TEkSDI36ZfOWNA9G4Lmr71o0G
         Lep/iFNJRkB15Eafq/UkHbIERjGqENsIDBhWbmymD/wpEgyTEi641RhonjSQ0MYKKn1K
         SoC03wEuOSkKBD+UcTRya7bggTBSlRjKi+FS/keaOZJADHsbDcfioKkcmmEVgTVJHROW
         7/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXvHgVjChgNruT4CRqukXtUJBayMU3tcTojL3MX/9roEdC1qlAlm+3uSe7EHo5hX8wgW9OD9k5JK3JO1eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ekQ3wbbEeTG+aOdvpOHAlL3G1GCdCMsDajS1079GGShXLK+C
	elyfwDOYagO5l37LpzdwPHKd0vh/NcCaEfrjFh5yTMzyv2f/u1uRvxkR5gNZlcqmVWM=
X-Gm-Gg: ASbGncs1gJAsNBX53VQW+gPfe+02Yos2vmupkBjTW8wJNfy5gKPTukFCbKYv9A8T36+
	BU6oouFmyhuvTjBytTkJitBbbiAyBZVfsaio7rgWd2LtHlaZymmBEPFh80ZFM0Gq7lbG1HX7TqL
	mAiNB05VPm0TUNAaMOL9ho/rNxrWsMBm4zqnfDfhp4pLAw6SsGyUAMTJwSD/MnL3DLG+GQi7baS
	u9qkrYgJrzv6VJaPrLFGiS6UWmJ6rXET6/mcZ9/QeX0sbe5GybxayNijQzSZ9gqPUfI54qroy9J
	ogavmIUqcPMcHjTxwhQgjd2rmejeRh60ieeqBfbzrAUpgmXpv/I65uO3pDiAx9f1ASYdCT74atB
	harfWuD9ZckFSviDv4iI1pKcwQvQ2dCFCtOiZI9mWWFodXqbTbvHGvbX2D3jp04kEL9e2Pp39
X-Google-Smtp-Source: AGHT+IGBoWnvKFnrL59tcdrwycUM3/742dFlpnhv7GOYA9WCbLlFcoq+rdKa3z0jczLqd4y3TNBh0Q==
X-Received: by 2002:a05:6871:409b:b0:308:fc2b:b7a with SMTP id 586e51a60fabf-310aaf3c403mr3608587fac.43.1755369830805;
        Sat, 16 Aug 2025 11:43:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbb405asm1383455fac.30.2025.08.16.11.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 11:43:50 -0700 (PDT)
Message-ID: <4fd47b7c-84e0-4a7c-8e5d-5bb6f0982f59@baylibre.com>
Date: Sat, 16 Aug 2025 13:43:49 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
To: Ben Collins <bcollins@kernel.org>, Ben Collins <bcollins@watter.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-2-bcollins@watter.com>
 <623c0ef4-98c0-410c-abf3-fa9563f52688@baylibre.com>
 <2025081319-abiding-muskox-c434f3@boujee-and-buff>
Content-Language: en-US
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081319-abiding-muskox-c434f3@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/25 7:04 PM, Ben Collins wrote:
> On Wed, Aug 13, 2025 at 04:11:59PM -0500, David Lechner wrote:
>> On 8/13/25 10:15 AM, Ben Collins wrote:
>>> MCP9601 is a superset of MCP9600 and is supported by the driver.
>>>
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---


Looks like reply-all was missed on this one and it ended up in my spam,
so I'm just now seeing the reply for the first time. Adding back the
others since I don't think that was intentional.

>>
>>
>> Please include a cover letter with a changelog in v3.
> 
> I had one, but I'm not sure why it didn't get Cc'd around. I'll check on
> that in the v3.
> 
>>>  .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>>> index d2cafa38a5442..d8af0912ce886 100644
>>> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>>> @@ -4,7 +4,7 @@
>>>  $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
>>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>  
>>> -title: Microchip MCP9600 thermocouple EMF converter
>>> +title: Microchip MCP9600 and similar thermocouple EMF converters
>>>  
>>>  maintainers:
>>>    - Andrew Hepp <andrew.hepp@ahepp.dev>
>>> @@ -14,7 +14,9 @@ description:
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: microchip,mcp9600
>>> +    enum:
>>> +      - microchip,mcp9600
>>> +      - microchip,mcp9601
>>>  
>>
>> It sounds like it would be useful to have a fallback in this case:
>>
>> properties:
>>   compatible:
>>     oneOf:
>>       - const: microchip,mcp9600
>>       - items:
>>           - - microchip,mcp9600
>>           - microchip,mcp9600
>>
>>>    reg:
>>>      maxItems: 1
>>
>> Usage would then be:
>>
>> 	compatible = "microchip,mcp9601", "microchip,mcp9600";
> 
> The main reason for the compatible is so I can designate the difference
> between 9600 and 9601 for the next patch I am working on which supports
> open-circuit and short-circuit detection. This is a feature in the 9601
> variant.
> 
> The feature depends on the chip being wired to support it, which means
> there will need to be a way to let the driver know that reading
> the OC and SC register bits will produce useful information. I'm leaning
> toward device-tree props to enable this and limiting that for only when
> the driver is told it should assume a 9601.
> 
> Given this info, what seems like the best approach here?
> 
> Thanks
> 


The devicetree already has open-circuit and short-circuit interrupts
for the corresponding pins. So it looks like the binding was written
for both chips already.

If those aren't wired up, falling back to reading registers to get
the status is fine.

I also see there is a V_SENSE pin. So I think it would make sense
to add a microchip,vsense boolean property ($ref: /schemas/types.yaml#/definitions/flag)
that indicates that the V_SENSE pin is wired up.

The driver could then use that to know if it can actually provide
events short/open circuit events or not.




