Return-Path: <linux-kernel+bounces-684265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8065AAD785D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332351729F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371429ACD1;
	Thu, 12 Jun 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="No8ZUA6E"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023382F4328
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746233; cv=none; b=HnapbL55+f7mGMZ6R/Yl76fb08hBFFiSRAvVvKdmhYL7qGfcRxa7HymSkuFpoqjA7WCpjDmyjKF5v38oqnj2kSriNhH5cxzav5sC8jULOsKCiJbFrD9bOc72/oOVpbJIz3o8m/p7lZEHyVuNxmJjOZwIcVWBF1NRgUxdOzeBsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746233; c=relaxed/simple;
	bh=9Nb7AXJLlEbXoamLJyNG30DwaOR9qVo/4ptyzH07SVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzQsVaJN+Th0IdUvlNi8Gv+QCMG7kM57rLP663itFP3yRgJP0hFJ19EbHmNZGjbXjdSS1K8I1Bne53oZXYkqKAgZqIIGTMHWCwLiFigSCxUkqCrKHpNALO2FfwKgpY3OfYfzk1aGdHB7ZdToIX0iIhlrV4ikaDY25PuXxc60yGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=No8ZUA6E; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so568709fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749746230; x=1750351030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0tBsmp06+xhTQYUif87CyCLEMF3dBxrJAjjS712b3U=;
        b=No8ZUA6EGZNg36+V0vEQW6Stq8dS0dFBY1QfEN0e7efpyASwz0jFHsxs6h6CywU0S+
         QPD190fZQa4fOxrX2uNNzDLpNh24C5WL37bdqB1wQrHg7h8Eo7yk8MqMD96f4nKUdEx4
         rxCZ57iLQTeIMRlh4ODoE6yH2SZLky7brq6vg+Xsp016RRYJDEPOEkALAYlGMKaD7XhF
         TQvgGbzQjUV5sf4OSzWNnBQcQm1kP3/HveU2flMNW3xHGpW43cux9awX7CN21ofJmKxy
         +qg2zZY3OwmDGTm3guGaMGwHayjllwUyoMmZl9Ic2j90xYIsya0vx266sDgT4wX1hTe9
         nRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749746230; x=1750351030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0tBsmp06+xhTQYUif87CyCLEMF3dBxrJAjjS712b3U=;
        b=dE6rikext5JqrZw4n85dJMZFTOhmoSFGWaLyD9qWg3uDQPGMQeAh78o1DRc7IxrOZI
         vM++BiAfeYuDFEXUbef22mJuDKP3mEGfsMXwIOEqqTIKJuxPF3APRafyoVkzC3xR0iQx
         p6EVNiEJW2Fkjuv/emZ2esyL6iDuZ0YxDEyEoLyqWI2094aanJDcA+sheehcTxusMvdw
         sye0DcAeqzH+5e3o5UrS+mee+RQSDcFHDyE1v8ztToZNprBRMwauiqjuvXTZciBzUv3o
         dzF9NHcBnDOiQ+IzsfpPTBFsdKlG4mXAiNj0tiqK9VNxnTEWa+pCI5QeSYMtEYNxvwJI
         DD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUshcXfNhIYhpreUb+Xiu2sW/m3Cz0ja70lJl/AdgEF4SE4ZshSvuYcFNuVIrgigjwDwmnJjYGMhm45BiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWAtfxl1lF/0WDxZGcvJnogUgxRzD4O/OLw2dnpFwueh6MhTL
	3N9kroRpu0I8h7xYMW4HAp9bwKrIc+XyBhC2MM47XtV+NhVBi5UfoRoLIm70Qf5S1I8=
X-Gm-Gg: ASbGncv6CL/tl3c2ov5/Uwq/CHO/0Wy7jb+Kx5haReVNhzlTSME9gt/XDrNK2uNWRcH
	RpyX6H8DQaIIOvQpe+QT/67hGhuYL8bY3OhXeLzMf7GDZvVqjSaUWlYqGBaB1mq2TTc4T+yecVM
	LRECSYoGR7bSr7hpGlSxtj6QdKxSkcN0dibnnccmCZvX1PEQaoUuF1hJHvQiBw9WUlGl/VBUBcj
	W8WC9rHas1hDpmeeMC4InPrBaui25N9M12eKajq5/tz30KyCnig3HKGpI30WaaeNjFKdNlVM9H1
	1cPnFoAVjCujcRRP2DWEzKJXgxeS0QwAt2kantQkformAGC/M8eXgbLKtTmkdvKqtg8mCQurRj7
	it/6zuCaJOcum3mmA674MQ3cbrlLGOOyvjVd4
X-Google-Smtp-Source: AGHT+IHHdXOO9hKMebpo+GWoY9JTcAG3EbxaHK4i0jKE8C9cGARxojbOf3B430AtmHG5MNWBG4EggQ==
X-Received: by 2002:a05:6870:a922:b0:29d:c832:7ef6 with SMTP id 586e51a60fabf-2ea96ffd990mr4262728fac.39.1749746229940;
        Thu, 12 Jun 2025 09:37:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f808:847:b3ae:ff1a? ([2600:8803:e7e4:1d00:f808:847:b3ae:ff1a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eab88ae983sm351337fac.2.2025.06.12.09.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 09:37:08 -0700 (PDT)
Message-ID: <654c6750-9359-4d66-934a-e936c0b86009@baylibre.com>
Date: Thu, 12 Jun 2025 11:37:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: chemical: Add sharp,gp2y1010au0f
To: surajsonawane0215@gmail.com, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
 <20250612100758.13241-3-surajsonawane0215@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250612100758.13241-3-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 5:07 AM, surajsonawane0215@gmail.com wrote:
> From: Suraj Sonawane <surajsonawane0215@gmail.com>
> 
> Add device tree bindings for Sharp GP2Y1010AU0F optical dust sensor.
> The sensor measures particulate matter concentration via infrared
> scattering with pulsed LED illumination and analog output.
> 
> Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
> 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
> V1: https://lore.kernel.org/lkml/20250425215149.49068-1-surajsonawane0215@gmail.com/ 
> V2: 
> - Updated timing properties to match datasheet exactly
> - Added reg property for multi-sensor support
> 
>  .../iio/chemical/sharp,gp2y1010au0f.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
> new file mode 100644
> index 000000000..b4e5110d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sharp,gp2y1010au0f.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sharp GP2Y1010AU0F Optical Dust Sensor
> +
> +maintainers:
> +  - Suraj Sonawane <surajsonawane0215@gmail.com>
> +
> +description: |
> +  Optical dust sensor measuring particulate matter concentration via infrared scattering.
> +  Requires ADC for analog output and GPIO for pulsed LED control with strict timing.
> +  Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
> +
> +properties:
> +  compatible:
> +    const: sharp,gp2y1010au0f
> +
> +  reg:
> +    maxItems: 1

There is no SPI or I2C bus, so reg doesn't make sense.

> +
> +  vdd-supply: true
> +
> +  led-gpios:
> +    description: GPIO connected to the sensor's LED control pin (V-LED)
> +    maxItems: 1

From the looks of the datasheet it seems like the light requires
a PWM rather than a GPIO to control it. I don't see how a GPIO
could be accurate enough in the timing.

> +
> +  io-channels:
> +    description: ADC channel connected to the sensor's analog output (Vo)
> +    maxItems: 1
> +
> +  io-channel-names:
> +    const: dust
> +
> +  sharp,led-on-delay-us:
> +    description: |
> +      Delay in microseconds after turning the LED ON before reading ADC.
> +      The datasheet recommends 280µs after LED ON for accurate measurement.
> +      (See Section 6-1 of the datasheet: Sampling timing = 0.28ms)
> +
> +    default: 280
> +    minimum: 0
> +    maximum: 320

For this, I would expect the same or a synchronized PWM output to trigger
the ADC in order to be able to get accurate enough timing.

> +
> +  sharp,measurement-window-us:
> +    description: |
> +      Duration in microseconds the LED remains ON for measurement.
> +      The recommended pulse width is 320µs ±20µs. (See Section 6-1)
> +
> +    default: 320
> +    minimum: 300
> +    maximum: 340

And this would be the duty cycle of the light PWM.


> +
> +required:
> +  - compatible
> +  - reg
> +  - led-gpios
> +  - io-channels
> +  - io-channel-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dust_sensor {
> +        compatible = "sharp,gp2y1010au0f";
> +        reg = <0>;
> +        vdd-supply = <&vcc>;
> +        led-gpios = <&gpio 44 GPIO_ACTIVE_HIGH>;
> +        io-channels = <&adc 0>;
> +        io-channel-names = "dust";
> +        sharp,led-on-delay-us = <280>;
> +        sharp,measurement-window-us = <320>;
> +    };


