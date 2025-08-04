Return-Path: <linux-kernel+bounces-755487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB10B1A6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A021882322
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECCB238C08;
	Mon,  4 Aug 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZeOAckk"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085C2040BF;
	Mon,  4 Aug 2025 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323154; cv=none; b=r2ziU3K2+CxY1BBA4ldTJXfFcJCOqzdvZkD3gO1uss7+Tq2Z23ecEFhsIy8cucFHItvgRTSSxe4MCBPVB20Ukfv5y/TqHTxTFSIhMg70U8nf2a8vkbodGN1jbMyCCKJeCShIxjcOep9gVzhur8t+zyGZ/FohlmHg+3S3tNOZEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323154; c=relaxed/simple;
	bh=sd1DyY6a3415VkW6baLPe78I+RH8CXZI1Y8mTPQ+22M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qurcWxcjAZTTU0MCoO0rcQ0ia3ndH5unRL0qntsktohfUEmOhLdCSiJ5GdhdwhHmQBgqzTGzA1j5H6Sb0R9jYGG2uH1uR77aAtlGOr/qqezR/hqP/iBvvBsA5ZiKkpF16lS6y5P/jKdPTCGRWa+6MYOVpLC4PuHhktNR86uZcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZeOAckk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso4396863b3a.0;
        Mon, 04 Aug 2025 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754323152; x=1754927952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3D7R9Rrhve+hM9PUIlOpvhIjLJ/daYnHplpqSry3RH0=;
        b=DZeOAckkqx54sPj2QecnVdkeWOoNT/uf9s0J+j1cL8zdYtRlu4wtvMCT+sjZdM4pBK
         lENSR1XkY9xXLku3eyAVjva5jgUoyPButjzfhDJ64Ek4uqNcmYE18Jk2nvYXZRlgXlAs
         /GB729PNT48IgIk7hT6xqQzS9UQGkVfjJW9nz5sYu7Us98HKSCFStu4nnmEnikdcAsiQ
         nvihj0fxLGYOJfBoq3BMApiuWFqx/Q7fBMJgo+CIqYzfFXdydf93cGr5pGRd4Fsg0tLj
         B+hEEOQLxf12z+sbtTQ803PVPMtBdKZOk/BcHlZVHUGLqmlGIHAUr/EAs51AsVM0ySFP
         Enpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754323152; x=1754927952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D7R9Rrhve+hM9PUIlOpvhIjLJ/daYnHplpqSry3RH0=;
        b=o1wlqCpCmZ8oYOZDfJ1E47Po6svZdpgVQM9uu8fvjwdKx3DPQRnYOsWezk5VqJXrEL
         nAyFXKQEw6a81AehbArHTPeMMHUZoe6imFwOiIeR6E2G3JySLOZ8704kyKhmLyTKrnt8
         wahMmjQZwOsjwNL/8qlCkyAISiWq4xSrW9HkicousGMZeIGbwrOABjPXK+4+hBc2C5bO
         c9AKprZezYwrz5UTWNl7An0ipCediO2lwPikIcisJGtE1iZMesOqtzJ9B0q3j2LekGH5
         vXmY3n7n7V+eVC7tmWXAF+/ZEYlDEBBz+c0ywkcDzkf+IdKZILLbjTLmNIw8dSSN62Y2
         OB8A==
X-Forwarded-Encrypted: i=1; AJvYcCV2bF1qEyxvfS9rZwdO3y5rlGXQeyHf9LtnPryU57PfnderUv+Pqsm19wWIPXKj9qETQ8Yy0yASDzYQ@vger.kernel.org, AJvYcCWU61isSw0g+mnUKWoGVUQKNAG/kZZ2VIzOAMN6VJ6DJmDvnw/KPy/kjQn01RT8z9NcJSK61VDg+WFkuE57@vger.kernel.org, AJvYcCX8283uotJHtbl2rwHiZuCi1y/iFCvHFk7/q3pwnYEB+LVUezHbgG3QuX0wTNExXBOOtXV8M/O6Pj9XitM=@vger.kernel.org, AJvYcCXp0uoCaVa4O+Zgn5G0hwuL9COGqUjJ9f/HrD4bdkUVgf52s1QihodAaCx25tz2dl3hGSHgmt98qZey@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOPbX5omS4VptUGJurtTtXDC+dIxgRk2FC8TIVWy2u2OBkKKa
	LjGFpb1MbdmWlyWCs01apq46WTKUALRMERXPU/luODevGbeMC2iCII5Q
X-Gm-Gg: ASbGncufoMiLhfi4dKvIEqJhCezPJnMwlLV3XhOz3ejzYJ4dW9WSC7JvlwJCSVBv64T
	IPIybvOZlq5PPVjrPE7PI0hhB2ctne4eRgmSJrPgYOZfkhI9YeESwHvpzhpXyfDY2fe4FygUsaO
	2MA2l4ICbiUMA6HH+RYEaX2qJHI7OX/qefS1IGfnOl+txB0ZCQ1myu36dML9sgGta5kBQbER4dI
	mM8S/Qx/QMkZWAoFwYUNK5xcJALdMIKNaDxSWzFrK9tr2LBKsiyjHVnkBjAHYsk0OFbmRht8xJ/
	kP0GrPFlqAfQg+cQvoaF7uZiPMEcGzRSkPYJuWOf9EvD5T+mngfCxeHb3u20Cy+4uCsqAKlEf9Z
	qj+yyGRuCByIg2rqklabpgtjYg6q2w8ydZ6KHlIpWVgN/qErXvkq8N+Xw3SDHLU+sKUPNZ8Y=
X-Google-Smtp-Source: AGHT+IFIjfh7+B5gIa+W7wBeAos+g9NcG4vkouxm4nYWg0auWlvWAzh5TCtv529Y+kQX/Tuai8CTqw==
X-Received: by 2002:a05:6a20:b598:b0:23f:fd87:427c with SMTP id adf61e73a8af0-23ffd875051mr8683696637.18.1754323152281;
        Mon, 04 Aug 2025 08:59:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7ceb3fsm9293138a12.22.2025.08.04.08.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:59:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <48996ed0-8d5f-4bb0-ab66-8be71c0a59e4@roeck-us.net>
Date: Mon, 4 Aug 2025 08:59:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: adm1275: add sq24905c support
To: ChiShih Tsai <tomtsai764@gmail.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, t630619@gmail.com
References: <20250804124806.540-1-tomtsai764@gmail.com>
 <20250804124806.540-2-tomtsai764@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250804124806.540-2-tomtsai764@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/25 05:48, ChiShih Tsai wrote:
> Add support for sq24905c Hot-Swap Controller and Digital Power Monitor.
> 
> Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>
> ---
>   .../bindings/hwmon/adi,adm1275.yaml           | 20 +++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index ddb72857c846..6aa300086c84 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -30,6 +30,7 @@ properties:
>         - adi,adm1281
>         - adi,adm1293
>         - adi,adm1294
> +      - silergy,sq24905c
>   
>     reg:
>       maxItems: 1
> @@ -46,6 +47,18 @@ properties:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       enum: [1, 2, 4, 8, 16, 32, 64, 128]
>   
> +  silergy,volt-curr-sample-average:
> +    description: |
> +      Number of samples to be used to report voltage and current values.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +
> +  silergy,power-sample-average:
> +    description: |
> +      Number of samples to be used to report power values.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +
>   allOf:
>     - $ref: hwmon-common.yaml#
>     - if:
> @@ -96,12 +109,17 @@ allOf:
>                 - adi,adm1281
>                 - adi,adm1293
>                 - adi,adm1294
> +              - silergy,sq24905c
>       then:
>         properties:
>           adi,volt-curr-sample-average:
>             default: 128
>           adi,power-sample-average:
>             default: 1
> +        silergy,volt-curr-sample-average:
> +          default: 128
> +        silergy,power-sample-average:
> +          default: 1
>   

I personally don't think this warrants new properties. However, if warranted,
this needs to be qualified to only apply for the Silergy parts.

Guenter

>   required:
>     - compatible
> @@ -121,5 +139,7 @@ examples:
>               shunt-resistor-micro-ohms = <500>;
>               adi,volt-curr-sample-average = <128>;
>               adi,power-sample-average = <128>;
> +            silergy,volt-curr-sample-average = <128>;
> +            silergy,power-sample-average = <1>;
>           };
>       };


