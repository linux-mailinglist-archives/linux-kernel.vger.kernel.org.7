Return-Path: <linux-kernel+bounces-783184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F13B32A82
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987AA3ABF18
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717112E92DC;
	Sat, 23 Aug 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jGNB+A2F"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D93D481DD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965367; cv=none; b=YcZDVQMEgKh834inPPYW8PwsBshnvGGsT5ciODaidKP28I4ankGrCsMZ6WdvSi/wX74PKBfh6LLR/RgkbhZ8TFR5/+YpJSwD4EEsZ6qROJ0CIc9hHbhXWI1t4hsurX59GDuC9JddkaRtyd0IEPrqJeBgMwAoi3xkZ415Gz72+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965367; c=relaxed/simple;
	bh=FUwG/gxyGRQKB+JXXx4gl4iOhP78u/f5e7nmclaCeBQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ddk7U7B2msdxTopdz027YfbgXBLQGa5j05zRr1z3Tna8sKiUQQYVmyAkj1SziuOCyBgobgviDBenFgeMsoaQhHV7Uc6i++l2idtCo9Myyiq6ERvFeEotGqZ7mA8i/WdnY2aVPS6KIhxE0wnvTiDVAwNexpXem1vs3zyyiRM5flY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jGNB+A2F; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cceaaecd8so1325626fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965365; x=1756570165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5ldSROTTtv9X2BePkbpO0dlILqeRBO/FfySSS6QlUo=;
        b=jGNB+A2FuEYuDCudvAgrB3t2VSxPLsK17VqiRczwe2ZJMgRNW3ZO6OKRhlTHMUhXXe
         gldsn8a5JNQGeD1FfC0QLm8lttxHBEcpvKPpXBzFEx2uS44/S5pCI8Pl7Iddv6uKANg8
         eHZQECacCWqK9GoDDHGpw1oTCcZy83kkzrlvzjYKIQwDtbSWAqDsMrOXHhskafRE6lVx
         ZKQGCDLJTF7f4Wfp6aM0CfXQQoQT4BXZW6XBSzh/EJdToavrYUzTsWl1QF4X0hE0uNM7
         8bYxgSxgjKUpNIX5OSK/Ll1WPxp9d1a6tUJWF+tvRvjQuhNhKVAa4RzFzevZbzZFnd0R
         tK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965365; x=1756570165;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5ldSROTTtv9X2BePkbpO0dlILqeRBO/FfySSS6QlUo=;
        b=GE6kKpWjjghhUM1/1xq7YqfkRqIfOp7AWc9o3SQR/+8KIRhfvF1M37zGByB0jEwNrU
         yQrCAGwKHbWB12ALf6HIaICM8305LwOctOVT2QDqLZf1QGBatKtdat4I9o4HBFlXsffO
         Q9tC7N6io9r5FDCVqOmYkTZrO4z0WwM+Xws23DrMSd0PkF2wElk3zzE9K7oVzkPl56B+
         n7GtEN5vlHvr+QFL+c3yRltUr13G0pUDQLqxJg8N5R0Jv2hD+o5XuYFEe3gbYZ/cnSQW
         3xAb4CqAjfM6R0rD8Szbl2kvqfgJ1rKOUqbezba04vDeg58cjYPhI9+PnCpP4lYZmlzZ
         SHPg==
X-Forwarded-Encrypted: i=1; AJvYcCWulGvBrrNCcewQgBF7wwIYBoeXcIaNw2lgGtYdwPcWClohyMw68cs9ZhK05J/QYtYlYJQjjMRYPNceYVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyEzyGtF+p4LrSBNOCtwfOnNZ6qaEazZC3Tj+J6HES+b4n/B9
	95+n+Kb3G0BIf3eda8tjJYeK5D4VpxCs18OjAvBQU07gYZwVr6xrqAFOOHJbPgYufzz2iQ2oHKl
	NfEwi
X-Gm-Gg: ASbGncv1VRpAVFp3LLvok4Q/HeNz3OR6bwV8fr/AMH1OspB8vp2mOla3r4OKKWlNSJK
	vTDo/Fa4ryBjRdvHADkWV9ZtowPOGdKOJyJlfxm01j9GjsQMJwvXIgs96hGklB8y9n9hBFFr/5P
	fEzA0btzF2k7TVrSNzxLFTzV9NkBP25Av4grE3PUMKXw+I1a89fhG7WMygd7SJ0ad90pwS1rghy
	0hhJlVWkl40CAKbZMM5uVKuBCtaAmWG4mK4Bmrqac5E3yoryRnzS3R9zveri1NaHg/fBNHpdY7a
	EXRKdHZGwPGc2e7Tco8q3X4GdMrhQDGZ/wLddtG5TeKcJN0HcnRKG+PeCe4V77rOa5AgcB2HJa5
	vhw4+a7l0SmheSdW1Aq7+WS7eaAAQTPzbtQPyrlNjecG5nD1qjwwUQF+6xksXI5feTstzQoJ+
X-Google-Smtp-Source: AGHT+IE42Tt8rVMHMtIJU30KzWNte5aFQHwjUAqkCrWOHeQEzzuOgeRcfaGPnVLy2HOMvBY9suiAcQ==
X-Received: by 2002:a05:6808:50a5:b0:437:761b:9621 with SMTP id 5614622812f47-4378537acd5mr3108210b6e.48.1755965365195;
        Sat, 23 Aug 2025 09:09:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967da01asm388629b6e.12.2025.08.23.09.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:09:24 -0700 (PDT)
Message-ID: <04436186-254c-4e02-8536-5c9fd9c005c4@baylibre.com>
Date: Sat, 23 Aug 2025 11:09:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
From: David Lechner <dlechner@baylibre.com>
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-2-40bb1739e3e2@watter.com>
 <f7089447-f164-406b-8e59-3bd3e8f94d59@baylibre.com>
Content-Language: en-US
In-Reply-To: <f7089447-f164-406b-8e59-3bd3e8f94d59@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/23/25 11:06 AM, David Lechner wrote:
> On 8/22/25 8:23 AM, Ben Collins wrote:

...

>> +  - |
>> +    #include <dt-bindings/iio/temperature/thermocouple.h>
> 
> This header isn't used in this example.
> 
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        temperature-sensor@62 {
>> +            compatible = "microchip,mcp9601", "microchip,mcp9600";
>> +            reg = <0x62>;
>> +            interrupt-parent = <&gpio>;
>> +            interrupts = <22 IRQ_TYPE_EDGE_RISING>, <23 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "open-circuit", "short-circuit";
>> +            vdd-supply = <&vdd>;
>> +            microchip,vsense;
>> +        };
>> +    };
>>
> 
> With that fixed:
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

BTW, sometimes Jonathan is nice and fixes a one-line change like this
when applying patches, so don't rush off and send a v9 just quite yet
unless there are other bigger changes that need to be done anyway.

