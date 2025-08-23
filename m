Return-Path: <linux-kernel+bounces-783181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE58B32A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6CB4E2952
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5420297E;
	Sat, 23 Aug 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fvxG50VS"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4F1DB375
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965211; cv=none; b=r1Te+cbbKy6hJ6rzwGM5qe4nn5XoYF5/uZYYHreAryyRfp0HxZKRhppf0tYcmflnZ12daSMqcw/w0ag4kuOOr5+GbHhwzfPC6S7Wzxyj5DkoXS0gbR3/aiyJMS4kiEIoMUv37AoTrpp2NEHo+FePmL8xHiBzYsUKvKYGTGz6Wz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965211; c=relaxed/simple;
	bh=X1TmEq/uHKxFLbVs7AoCOdEDfHSKfGMWoOxHyk317mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh+baVIe5reZl/xv4QmpfxJ16UXlQXKM5aU6LGHk4ClqElXNLkCDFqOinPBNW9qpgHDqcPDiHpOXAR1gohgOpIpmP0fDyPtb59m2QvbltYFLOiNBl2OkrpOMJxXOAyxzXmlyTQ+ushhCOhsWFDBgErp1h6PtiCqgae0ut27ODtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fvxG50VS; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61bd4e24ac7so1264840eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755965208; x=1756570008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4xWDjHy7dybMcTQgi+MIUcku3Kv1UYV6zDqpzfzc0C0=;
        b=fvxG50VSVeM9ApW4J+vb5ZOPnalJ1fnja5kAqzyS4RUoiOpP2DnWLdeC8nhnpP9tAp
         AT+ciptx63xM3vRTzkAbMJHumPXaWFfG/hYngIX/I6xjdWZo1JskawMubFsxPtg0Nh6j
         cRhB6IomqGzDJio11d9TP6XSEuorAqadDFc/jdLSoofqjjupV9EAt00tymj+YMWKqWCr
         w4uLW4zjhQWy3jw69ZS+h3P+GN7pirM7kVDcAmnXE5f9YAtEx/i/2uSauvoqlYDHzkPW
         AM+FSEw6F/wql7UV1SKUv/5uxLDvi2fF+oRxse9IAM8y29WUfSzYbY4h+70tr/5qG/Ir
         vGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755965208; x=1756570008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xWDjHy7dybMcTQgi+MIUcku3Kv1UYV6zDqpzfzc0C0=;
        b=NU6ARrdPwOmwfzfcQBwcGgeMUfO4A1pbZ0AQrUHyiHf4j9NDohwPW2Y8wMh9C2LHq1
         oMqDYqTho3e/jTyBuuMaROCKNdHxFEUsxhDzOCY89yUV7kKYIVjmBZVJ0Eh/KtJmfFo4
         CCSdqFIGaHojznGaZEGRPrNxgfIZ82mWkBv30Ld3SurGQiGzqa9kdr6/8FqG1DYPmjLX
         uv5YVhQzAQxH1jAjtX9ZqF3Q1/AIosMAAPLZeWQTCRRX/v/GdEuIanJ73VAFivCu2SaJ
         PHCB6dbklXXgejsxetxAN00oyRwBQvB6MkduKSxg9xrDdrIAHwWqkkiH4GJjugr5ag2C
         sb9g==
X-Forwarded-Encrypted: i=1; AJvYcCWE9Y74iL0SiNVtix1RmO7qMeNAdmv8nXRZUDoktznM8HuVGz+3NH9ZZDWf51xvsmKqs6++haQAV/6CLV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEK+GxoFr/ISQ1HjtvsE5j9T+O6+ga4d1pthtquO7RCc/zpXuX
	LuDp4OEqx3IY7mGiYzauT5WKWcJYk6ACjs359CxGkDYLPbvJJb0ovUg/+H3CeAkVpZs=
X-Gm-Gg: ASbGncsi61rC+sw1bO59JC3HWZ8rsMt5KYrLdaYG3QNphq1+j1VMKWPi31A+DtDLNvG
	w30ZK8/EHmHi7UTvVmd8Vuhgvem4FFBYly0HakGIxAS5J6FF1G2KSpg9bMSoYlHFfras7WiEe5U
	omz3ZUTU4atQEvY+Swh0JDvjdaW0ApsxwOs2UHBU8/CxBBzZgP6TunQ5pvrJ/i24HBiIOY4Uzyf
	vtDjv3drIqzQDkRgvgcoLsZarx/CrCo4T80nWnlGsIu3VatI3eiwwaSrztRJsqZiP7BAn7dVB6U
	tpLmBo6gb3iMpN8uYjow7JdlyyRhoL2LlFb2/dvLnOlbiUyoxO2dVMG4sr/8CgRdvGFRXybIX7G
	2FiCiPwDvwUXF00+yxPGDyYHq8NgXL0Oo9mNNysL1v6X6weroXl2dFr73gDnHonSMlq3p1c2J
X-Google-Smtp-Source: AGHT+IFh1RdEOG+NrL+CtSosGlDMB5qW20v9HRwXhWw7QRFD7qwUhzzJWpPfwqdd7bOpnUVWO1bfvQ==
X-Received: by 2002:a05:6808:4fe7:b0:435:8535:c0cd with SMTP id 5614622812f47-4378526c6dbmr2916641b6e.2.1755965208410;
        Sat, 23 Aug 2025 09:06:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437969221dfsm383033b6e.33.2025.08.23.09.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:06:48 -0700 (PDT)
Message-ID: <a3f26804-d9fc-4e17-8485-40dfdc4e1eb7@baylibre.com>
Date: Sat, 23 Aug 2025 11:06:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/5] dt-bindings: iio: mcp9600: Set default 3 for
 thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250822-upstream-changes-v8-0-40bb1739e3e2@watter.com>
 <20250822-upstream-changes-v8-1-40bb1739e3e2@watter.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250822-upstream-changes-v8-1-40bb1739e3e2@watter.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/25 8:23 AM, Ben Collins wrote:
> As is already documented in this file, Type-K is the default, so make
> that explicit in the dt-bindings.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> index d2cafa38a5442e229be8befb26ae3f34bae44cdb..57b387a1accc776683500949a22ef0290fc876e8 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
> @@ -37,6 +37,7 @@ properties:
>  
>    thermocouple-type:
>      $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 3
>      description:
>        Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
>        Use defines in dt-bindings/iio/temperature/thermocouple.h.
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

