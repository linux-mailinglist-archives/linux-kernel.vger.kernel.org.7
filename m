Return-Path: <linux-kernel+bounces-772224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85AB29028
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863AA587524
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1330220C00C;
	Sat, 16 Aug 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S1igk2Qo"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2961E1A17
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755370537; cv=none; b=obxkT9q9SdOncZUBnCyJl/B8LiP3t5Nt1mZadMzVNWKYbFBhUKK1PhmpuwB6kBBFssTv4bAa9HnCZieHebsDQ2exv5gmgkLnC/jx41vjPnUyNuduQ8RIqqaQNLOrcP8j0btvRI3dzmDSQYjvapLcEoPvwGaBqlxhTMLvZ6pKAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755370537; c=relaxed/simple;
	bh=e7uChWhGMvZHa6Mpyo4vNChVMnVBmFr56RHl7o6kiq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpYdrqQSU4JHgmPB66p8Y1vldfjqOispoXvLNUSYe8seAz4yNIOJT/JyRgfw6juh8qqqKFKNgelZMw6UrKuGxJ+RDZoNu/qDHzKMpWeDlELy43te5Zseom/jBjsFzNG6RT4FXVOfZTtBxiN7smkQ6Q3VRcWrH/e2ra+o9upD5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S1igk2Qo; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381e0a227so2125447a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755370534; x=1755975334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffPmnzaqLO3di+HvejIJSUJDzn9TWvgequfo9PXfSM0=;
        b=S1igk2Qoa9bDBOAF/e5k3FdjHD1V2HTomiRHp40QZE0MPI3d92UOrh22x7QsJlZIz5
         uKaTMObYlBAiLh52RXauM/3mpg1x1A8lNz/UxUgLw/JoKiXeeEF87axSVbip7bg40IKH
         LqNsft42EzC7NKB6vhfpfYwp7Hi3P31dviBnmQzoni9pp1zPwmuuWGf7E6Gf+4aoEgtc
         H1mFKNCGllFy04RF2g0qW5MqrgYWphclRO/EX67pYUd/2+SUB9w41hpMFIDlJ3Dsd0kc
         CW8KIiCyORqODQSrwQJ1oHub2DrYhP8OK0T4iTSgCPVzMegokvMd5/tw1M8wwj7naVE4
         FLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755370534; x=1755975334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffPmnzaqLO3di+HvejIJSUJDzn9TWvgequfo9PXfSM0=;
        b=lgouwXG4E8aqwqUYjbvcJKamwt/kBov5c7/VaOHjjF9+drDGSxGVYgAzAMulbaIeyV
         prgxJXYREBNj1t8FIwm7J4LzhKQGUE5k1+2C9zhuan8vX1vmNl2Ytl5Ed3xYenzKtxiu
         /WSurysjaFer7jC1zQkZY9mj9+cbUZnr6w8eZRUcugNm1LFI8LGb6dI8MbGGDhZ97kOZ
         usLvyCBJAUIzWaQdNoXBHVLWaLhQGubvQ9JF29tv/Rv/xipQL8w5nWV180+9QuGClCXl
         TJzeW/j/iTFsILaVVMd66+T60BoOONQdqS/NC/BzwfHOoeqAmmgyPzP8DJjWtR0pB0Gx
         x4pg==
X-Forwarded-Encrypted: i=1; AJvYcCUPnYLO6Oyf/X2MmTuryxxq7CFL5ASHs7lI82JpIGzJqtAv8am9VB2/MEzesOGpd6U+sZCjzFvBUncp8X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHHccwZRrA5PNCUYyEovjohP9CSglF15OWqQjQ8k0s+TetMBKG
	ZolkeWStQXb61p467svTEUPBpDgpBqtWB7QAZ3BUK8fuRXgjg6OjiyUItlUzNt6tjyc=
X-Gm-Gg: ASbGncs5IJaUis73VHwYivwCSNyZs1bGb+1JIe9avK8q8U3p2E/XhWNY86pTm0nFL/T
	dFuzYQA5pbKtvljwfNAJHhBqWwI+bUq3KXah1wK5jfEqxYe9y/+qOQMyxxk2roMrxp+z1Sjrbof
	QZ6a2uv23qdUVRj2XnzsW1e5231Jlkf+454tKkPF3ZZ+XVm54SUp7CpaMUua0UWJnRmrdM1Cftj
	KSWPqxfDLaW7I9H72opBCRrBP3t7eCGoRhK/iz5butiORGQrFZt2qDxiwCOd904mOymIj3T+Q3p
	6lJ+kmlJrJahL6WRzO1ir5fzAXgNYwEa+41D7ZLIql++Kwq8y2T0QkVszDGBwaQGXFzSb+wuUaa
	IjCbqQcICZjLbPVRISS3JkfIveMOeyXDPILBpCSVfvO9iP51jfXC9qAPs7bXR9eGnoaRymcFT
X-Google-Smtp-Source: AGHT+IEo6Cd9FfYudnBVmWWkFVcb8dBQtaWN3pYM49rfwJr5rFglXZnKGElmuA2TlxnPrLBE2fctyw==
X-Received: by 2002:a05:6830:6f8c:b0:741:a842:18a8 with SMTP id 46e09a7af769-7439bae80a5mr1909896a34.22.1755370533643;
        Sat, 16 Aug 2025 11:55:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bebfb34f2sm488110eaf.10.2025.08.16.11.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 11:55:32 -0700 (PDT)
Message-ID: <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
Date: Sat, 16 Aug 2025 13:55:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
To: Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-2-bcollins@watter.com>
 <20250816105825.35e69652@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250816105825.35e69652@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 4:58 AM, Jonathan Cameron wrote:
> On Fri, 15 Aug 2025 16:46:03 +0000
> Ben Collins <bcollins@watter.com> wrote:
> 
>> The mcp9600 driver supports the mcp9601 chip, but complains about not
>> recognizing the device id on probe. A separate patch...
>>
>> 	iio: mcp9600: Recognize chip id for mcp9601
>>
>> ...addresses this. This patch updates the dt-bindings for this chip to
>> reflect the change to allow explicitly setting microchip,mcp9601 as
>> the expected chip type.
>>
>> The mcp9601 also supports features not found on the mcp9600, so this
>> will also allow the driver to differentiate the support of these
>> features.
> 
> If it's additional features only then you can still use a fallback
> compatible.  Intent being that a new DT vs old kernel still 'works'.
> 
> Then for the driver on new kernels we match on the new compatible and
> support those new features.  Old kernel users get to keep the ID
> mismatch warning - they can upgrade if they want that to go away ;)
> 
> Krzysztof raised the same point on v2 but I'm not seeing it addressed
> in that discussion.

One could make the argument that these are not entirely fallback
compatible since bit 4 of the STATUS register has a different
meaning depending on if the chip is MCP9601/L01/RL01 or not.

Interestingly, the existing bindings include interrupts for
open circuit and short circuit alert pins. But these pins
also only exist on MCP9601/L01/RL01. If we decide these aren't
fallback compatible, then those properties should have the
proper constraints added as well.

> 
> Jonathan
> 
>>
>> Signed-off-by: Ben Collins <bcollins@watter.com>
>> ---
>>  .../bindings/iio/temperature/microchip,mcp9600.yaml         | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>> index d2cafa38a5442..d8af0912ce886 100644
>> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Microchip MCP9600 thermocouple EMF converter
>> +title: Microchip MCP9600 and similar thermocouple EMF converters
>>  
>>  maintainers:
>>    - Andrew Hepp <andrew.hepp@ahepp.dev>
>> @@ -14,7 +14,9 @@ description:
>>  
>>  properties:
>>    compatible:
>> -    const: microchip,mcp9600
>> +    enum:
>> +      - microchip,mcp9600
>> +      - microchip,mcp9601
>>  
>>    reg:
>>      maxItems: 1
> 


