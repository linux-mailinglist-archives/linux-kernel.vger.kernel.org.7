Return-Path: <linux-kernel+bounces-862658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4933BF5DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52891466738
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC22ED167;
	Tue, 21 Oct 2025 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0Dqe4uw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83625A659
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043465; cv=none; b=kooSXch7EvXFm+bb03bNjEU13RHLr8Pt0GHDX0rSYyufXaoVHI+tfaAFnQiYSAJCCiih4jAKHcRFtOPbBy8s4yL90B04m0twUbfG1fwwfi5DcwF7yeyogAYzAHPTekDjfJbjkuM0xBEplCWCIi1sIpRbYBIwfFsxb+LuwRIsaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043465; c=relaxed/simple;
	bh=e3IMvVedBqfEjFLCSEowShucMDlxYs8t/v7ILi0x3V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WT7/jR/ZhnTc9WyLV3XEWoyD7+MiYjzXInnpUpReWDq3iK/UgGMn1X8kkzhTymDqCv35lzfUM258aEOtgBu5RZeoapDAMnCkys7x0wwOdBQtucYM5yxFqA96vwrHzSH0OVPWE6DoDjnuqr9BT/qvMRg0bOrWZQywYCJrzQ/kvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0Dqe4uw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471810a77c1so4639955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761043462; x=1761648262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0f/FYjEk/V+C1sQ52NQZj2N9GUstTQXv62cwWX4veF4=;
        b=G0Dqe4uw1sc+7zZvCcTkdK5kHEs1FDbkYZz/7WdMSEuxYFhlkMKn/NmoRqFseikDjq
         MAx1SLHHevRY3v8ryKZAWWvCiZFeLtoDOHkKzBZgXaBm/4BZiiFYY2xdj6G3fhIK+xhk
         lIUp2uECBHKVgN7jZhL9CHXCrc0iRFwAGIkA/yDrm/Ir7M8Qe/ee7We02Fc4WEH56Mte
         eeToGT9zBAgCRMn2oa6ESNSyfbOp/E6ujjaBQzOVjdMt2OpQbU19KdQP8yi1wB+7OiAE
         QoAMd72nNzYYMY6ZWwbjVZfYu/ZLulFqA2KhdKohOeLm00QBTg3y/SCOBC9574deLklO
         YIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043462; x=1761648262;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0f/FYjEk/V+C1sQ52NQZj2N9GUstTQXv62cwWX4veF4=;
        b=e6BdS2n6Uyxjp3YaqLQWnAnPDzMAfBXv1NFMRoSulo2ZnGIGG98CEb+7fdgqz9yGXA
         PsAm7cUybxU8RTW56LV9ZZXvmf+BliYoL+CznAMRphpbz/Y5l/KdXAchkvDkaONYOK1U
         r2Now5WrTqC0I8xqg7FpngzSf5QMXn+i5vqeu2bLhWmZHLb8guZ7DN2/8IZJsDXaS42o
         BadfxXfgCI8gDLlfABX/8cifK9DhhC4/utVp4Oe5uTd+d4T68SF6rmCjGZMQZp3DZdVK
         9Rs0UCHTl7HJ7v00U81X0/i5VUz9NRZqCbWNcMLarCRO73KFlex8VtRNoNVH9AE0nz2b
         bCPA==
X-Forwarded-Encrypted: i=1; AJvYcCWNIcBeb5kJNAfFX33UkWWLH+wuno2eOxj/SwQM6qSbtit/g+27b/bGNow67loI+ERPW6XQJgzjR9qKWOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwNnqqEVyoL1kO9b6ODtKzKjaLeIHkAHEKC8CCvYvxRnvNN1g
	IFmAxOYnVixx6Xs8Aw7+8K7a9NZvtScIkJpItYOYeSczjaJ6LnYeTSeHj2kkbnt0YVs=
X-Gm-Gg: ASbGncv7SdWigSAFu/qaVaZjEMn7qskysC+mMz8qWyGWMFlZdTlw9GrtpdyQWElG/DC
	ZHrjepWlJTABfqX7hcYzJxV5ULvBbhm73vWBHhsijPZ6atC7uKSe6LFctwxE8gPmsKph5BXs37w
	7by5KhyOeob8nB553mCTfEWVBiFdxUBmiJBS8nsb8tNe6AZSRglAE1z2EBE3ZJ2CxJKAUivQi2h
	bFRrs1rhQ7XAyEIi7T00rM8YdDaR6j/mHdtDN0rsy9jgxSOEY/OPSSP9rLtssF+uCfNRC/fX52K
	8JoiU76TikhfhWLugqYmZCigdy0l8QGq7PiYTp0l6ECaUOpUgR6z+ZaXb+pMsmLK04lRFRXlPWi
	7iQOARXYTe0GLNs4gqW/wfuvf6e52x6WrnO2oWWkwfBhW94GDRj5+aPnmtP2ey+cJX5DRpv0HKC
	7B1doVnhYWWmIjeYfN0hYw5U/3Yv8aWgG54jeKs9LZRA==
X-Google-Smtp-Source: AGHT+IF3NSziRPrbhxXTm98kuwwXO/z1y6F/Hzp2XZIk65XU/KBHeRfxgcDMUYvJ1ZAMA1FDO2S4JQ==
X-Received: by 2002:a05:6000:4009:b0:3e6:270e:3f64 with SMTP id ffacd0b85a97d-42704dc3594mr6050259f8f.8.1761043462033;
        Tue, 21 Oct 2025 03:44:22 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fa8sm20075497f8f.38.2025.10.21.03.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:44:21 -0700 (PDT)
Message-ID: <c7630eb1-2686-491e-81ed-fb43fff2dd31@linaro.org>
Date: Tue, 21 Oct 2025 12:44:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add sony,cronos-smc
To: Timothy Pearson <tpearson@raptorengineering.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Georgy Yakovlev <Georgy.Yakovlev@sony.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
 <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 20:12, Timothy Pearson wrote:
> +
> +properties:
> +  compatible:
> +    const: sony,cronos-smc
> +
> +  reg:
> +    maxItems: 1
> +
> +  timeout-sec: true

Drop, not needed.

> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      The Cronos LED controller is a subfunction of the Cronos platform
> +      controller, which is a multi-function device.
> +
> +      Each led is represented as a child node of sony,cronos-led. Fifteen RGB
> +      LEDs are supported by the platform.

Fifteen?

> +
> +    properties:
> +      compatible:
> +        const: sony,cronos-led
> +
> +      reg:
> +        maxItems: 1
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^multi-led@[0-15]$":

Unit addresses are hex.

> +        type: object
> +        $ref: leds-class-multicolor.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            description:
> +              LED channel number (0..15)

but here is sixteen...

> +            minimum: 0
> +            maximum: 15
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - compatible
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/watchdog/watchdog.yaml

Come with sensible, generic node name and update the schema like I did.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/leds/common.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      smc@3f {
> +        compatible = "sony,cronos-smc";
> +        reg = <0x3f>;
> +
> +        timeout-sec = <20>;
> +
> +        leds {
> +            compatible = "sony,cronos-led";

Keep consistent indentation. Use 4 spaces for example indentation.

> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            multi-led@0 {
> +                /*
> +                 * No subnodes are needed, this controller only supports RGB
> +                 * LEDs.
> +                 */
> +                reg = <0>;
> +                color = <LED_COLOR_ID_MULTI>;
> +                function = LED_FUNCTION_STATUS;
> +            };
> +        };
> +      };
> +    };


Best regards,
Krzysztof

