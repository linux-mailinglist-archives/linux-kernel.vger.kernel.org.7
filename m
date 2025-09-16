Return-Path: <linux-kernel+bounces-819475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0BCB5A163
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463CC7A790C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591702FFFB3;
	Tue, 16 Sep 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BgnpJeaD"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44902DAFD2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050686; cv=none; b=VxwvLh95ate4lOKe8KwQS1cPR2UhizjgDwDiabgNWf4nAMnEHSS23F4AcsXShffZhPSH23y3/3rWFecDRoV4MQgt2eY+/T5wd/xZD1ALM/QMswQ6uxOEUONORDsTsUw4j3Xujjfnnle+Oy+viwqUpdaGpZyBshryM9A5eV8q4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050686; c=relaxed/simple;
	bh=l/JZXCZBRgafRG8M0P+GmzXgWrc1HTLlApXUzUZ7I5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QF/zZwBhu7p+jvsHtglpFS1ERFGAdloSpBsSRk7jlUc/ryadecwHwXt8yXX0O38bTZbT/rzb2qbRp3qUSHPEbZDF/kjsbAB6w9kKlB6+Pi73+PfX3bo+zIs59Hm6LU/C7apBfss9d/8/8ss0UkK4r4vnSZZYNII45xyO0+P4KfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BgnpJeaD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-752f88e0b59so157633a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758050684; x=1758655484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vkm1lKUO/vYiWqDIzIiDHaOIfHKbifmxiy9YuFgZPQ=;
        b=BgnpJeaDO1SvyYDgNPB6BKNso8jdpAUltM85Je81YK0bGU7tBwAv7cHlyaKyHeZHMH
         yX/9efAdL4VMqIf6jsC7uP8BvkgX8vShUTNtu5pb7GMQakAmnzX6e/qzHNUdn5CJAQK5
         8vfCf8qRfrj2uRu+tp2SvYY5HvFh9hnlkf4baTQbsaNVXSUp26M1L0CQGC5Eh3cWevh6
         UG7XIdiCPfRu6HPYpthER5JyzDnmbiu+EsExq/xuxtp65awayu3xHfwswO3kvgmy3aPJ
         NtJ2Uxz/J1R5Rr7pwUdxb198e+IxB5LOrdWIjgnpcqncITR8p/A9jwndmnwN/7xg8gMm
         9D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758050684; x=1758655484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vkm1lKUO/vYiWqDIzIiDHaOIfHKbifmxiy9YuFgZPQ=;
        b=baHwOeZB4YUl+yeX2xxIANaCcvGtjAXH0c3Xwty4K58PMjlAMyN29cd6R2WVC9GuJ3
         jn4jgrKh37+xzhwAiBzQ+1dD4CKVH/WoHMnSE6cH0FnR5fklWG6UjOjVjTTVcKOZ6IMU
         SO4vnaLuTjuq5Hl4tMYMEF1otelZf7Kurmiz9F2y4EDRrPhxcAU1hlKxv5hAMuZ+1uFV
         r23AMvHyeYyRqL/TKa67gmpb12rECDASeTrQVmeIKvQykce2622zD1N/0UVVRvbJhmjX
         iWapLMDutjPNqHf6DUhhqGcdYCsGW5XeNhWWSVFjI4AsehOI6k744aGvHqEn0MGoijHr
         QVzg==
X-Forwarded-Encrypted: i=1; AJvYcCXoUV5u7zuycf808o9o5T7KcZwF0cZtWF70VqXw0nn03yoQSk8wVVJFb3gVw5fplw4X+1QTBiQa4Fas1aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9jFM0YwOl4ChMXHu/uyept234BdsOgDko+0UJuVrZJDMAc01
	urHzLqOyGg7CAsJ4BqqpH34t9f2iibGPgmJ+DoMKaEpFQ/cOiunD5QHEKtIpg4bb4HU=
X-Gm-Gg: ASbGncs9geB/U4BNB1IbohI4HWwm7VjSr3tiaoJGZXdQanZ8DFOki1vAAfhwXypluUi
	Ts/tKJnmwyTyeytEfKPSKaWV+mQJXG5Hr9/JqirPtLCd7vauwFHoUV75WLFLaCXJb6QwIWjGKGC
	xeLPAjstLl5M1udqBB6DlyMXXqHK3DTuV+eeqkf6y58TmJZr8xkOLaLyKnbTcz8JRKGYJvXErfB
	7xxjD140OZjKSdRJOGVluNJqdqRKO1qxWWmv+ULxIK2CAJbN0sEtF7wcYzA8887ed4tP9+7u0JP
	l8l6zdhFDBekpYEOvBgp/KXlWDfRyIrXsm4UkHROLFeVrHW1AH3TN7yjslhXbFEDqDxzCXQYbi3
	IWiQIeYWqETRiy9bcThMFi+GUOH8aiH/PfjfAHThqN68TzGgGS8bRmfsLEGXcWZ3sCamnjwJI/w
	U=
X-Google-Smtp-Source: AGHT+IHNVfc46l96af2hwm84vsHZVNx+YJidQysneprrg+yCXxtsyfR4+pTIbrvZPACHeIwcoRauMg==
X-Received: by 2002:a05:6830:4988:b0:746:d097:9342 with SMTP id 46e09a7af769-75a7dde5068mr2339458a34.7.1758050683842;
        Tue, 16 Sep 2025 12:24:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7598664d715sm1552442a34.0.2025.09.16.12.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 12:24:43 -0700 (PDT)
Message-ID: <936e16dd-d11f-4452-8942-64366f173d6f@baylibre.com>
Date: Tue, 16 Sep 2025 14:24:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] regulator: dt-bindings: Add Linear Technology LTM8054
 regulator
To: Romain Gantois <romain.gantois@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 5:24 AM, Romain Gantois wrote:
> The Linear Technology LTM8054 is a Buck-Boost voltage regulator with an
> input range of 5V to 36V and an output range of 1.2V to 36V.
> 
> The LTM8054's output voltage level is typically set using a voltage divider
> between the Vout and FB pins, the FB pin being constantly regulated to
> 1.2V.
> 
> The output current limit of the LTM8054 may be statically set by placing a
> sense resistor on a dedicated pin. This limit can then be lowered by
> controlling the voltage level on the CTL pin.
> 
> Describe the LTM8054 voltage regulator.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../bindings/regulator/lltc,ltm8054.yaml           | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml b/Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..4db11be178b0e662ec51f3d3d73202f8c32625d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/lltc,ltm8054.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology LTM8054 buck-boost regulator
> +
> +maintainers:
> +  - Romain Gantois <romain.gantois@bootlin.com>
> +
> +description:
> +  This regulator operates over an input voltage range of 5V to 36V, and can
> +  output from 1.2V to 36V. The output voltage level is typically set with a
> +  voltage divider between the Vout pin and the FB pin which is internally
> +  regulated to 1.2V.
> +
> +  The output current of the LTM8054 can be limited by tying the Iout pin to a
> +  current sense resistor. This limit can be further lowered by applying a
> +  voltage below 1.2V to the CTL pin.
> +
> +allOf:
> +  - $ref: /schemas/regulator/regulator.yaml#
> +
> +properties:
> +  compatible:
> +    const: lltc,ltm8054

Looks like they got bought by Analog Devices Inc., so adi,ltm8054.

> +
> +  enable-gpios:
> +    description: GPIO connected to the RUN pin.
> +    maxItems: 1
> +
> +  lltc,fb-voltage-divider:
> +    description:
> +      An array of two integers containing the resistor values
> +      R1 and R2 of the feedback voltage divider in Ohms.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 2
> +
> +  lltc,iout-rsense-micro-ohms:
> +    description:
> +      Value of the output current sense resistor, in micro Ohms.
> +
> +  io-channels:
> +    items:
> +      - description: DAC controlling the voltage level of the CTL pin.
> +
> +  io-channel-names:
> +    items:
> +      - const: ctl
> +
> +required:
> +  - compatible
> +  - lltc,fb-voltage-divider
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    / {

Examples usually don't have a root node. Probably explains
the bot errors. (but you should have seen the same errors
locally with make dt_binding_check.)

> +
> +        regulator {
> +            compatible = "lltc,ltm8054";
> +
> +            enable-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +
> +            lltc,fb-voltage-divider = <1000000 68000>;
> +
> +            lltc,iout-rsense-micro-ohms = <20000>;
> +
> +            io-channels = <&dac 1>;
> +            io-channel-names = "ctl";
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45799dfe07de2f54de6d6a1ce0615..7160179e6bf9d45a241582c1b6df8c0ebf6c3641 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14517,6 +14517,11 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>  F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
>  
> +LTM8054 REGULATOR DRIVER
> +M:	Romain Gantois <romain.gantois@bootlin.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/regulator/lltc,ltm8054.yaml
> +
>  LTP (Linux Test Project)
>  M:	Andrea Cervesato <andrea.cervesato@suse.com>
>  M:	Cyril Hrubis <chrubis@suse.cz>
> 


