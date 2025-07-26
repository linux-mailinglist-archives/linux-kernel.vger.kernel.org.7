Return-Path: <linux-kernel+bounces-746878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00FEB12C60
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4E227AB50D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9241DF968;
	Sat, 26 Jul 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eo8rusya"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3891D90DD
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562777; cv=none; b=f0f3tZv+rLV+mMFSjlwCSpaUFmsroizCgjulfLmVvawRHaCHEBC2qN5NuTgrXYjb4JqxWmQUIOWPSjOtq2xbMLReenDy2+fZErgxt2f1dV9e33eNLGaMaQURwO6+a/WIgOndPOsy2DhB6PEjWYzqXdt7A9F2l/zf5h8NGi34puU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562777; c=relaxed/simple;
	bh=AgFl8oYApeBrJhPG9hAm6A9ogSmb60gaE3IC/9S0mSM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=fbVVE3FxXXPFWPyj7q9kCkThXtWIq3r+AzTCLIpyIiIUtJ+ha1bi8m3epWnh44xB6mKmzCzO3/PEjEAhQlJYWWEbFXKlnCJ22DQMdxr3pLohMrxXdhL5LIuEFR3qjdHB2c3/sUyttl3YFXia3MV+++dnUtjWU1DuiB0wqdxegJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eo8rusya; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73e88bc3891so1858438a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753562774; x=1754167574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adVyS8ykePUpCxVa6P/qJ+4OYY/RJo9Vkh0bwyU9BA4=;
        b=eo8rusyafloyFYiF3i/916Rlbwhgj0y1HsdrGHI4It2dHVim3gORD7FP+qz0cK/PFu
         UZ4GHeDmbvnZI5mPkJpl9MQRi+fwk3iJLbkIqo2d0xq4w/iTdowIpjSXSnmX66X/OtWN
         U0DCXfFS8EqhA8yV/n/L8sropIEMz+yOuo11r8NfbbnI3wRYa4Yfw+kKsgpCcg/YXVTZ
         2U+1KfMCzTjAxbigxbXwNWZjkZJK7SS0pG4uQ+PDk4/eHvmq8eZhTgQ2vD1DevLbM+4Q
         zxD5Xbi2ZuUVlEK0MUzBkNi7LwMvCMhVkC++xO94iAXh92mUbEK2XT3w0WnkwI/qXGNd
         OiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562774; x=1754167574;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adVyS8ykePUpCxVa6P/qJ+4OYY/RJo9Vkh0bwyU9BA4=;
        b=ZMfxwzshYx6lG/2iyT2UtVdeP5o5uaBXJodLpfbFWohpPd8wC6ry1w5ul8EHCUz645
         SkDESrugFDiZBgj3o5tROf4ATMduvUtqSaR2KCsoCrTMmH1IVfTrppH/9IheqygmRSFb
         8+08lJ0BqFzlB8vso7ANShpWs6w1RZWH8avrw1xAh0eoexR/Locx/cyn613wNV9Nmh1o
         40uhktKhREpveZ9PSBCi3V/N/laNnInxGWghdXHD0S8emzIbZKo6OuDlNPd3K0rwK7J7
         U2w8MSA1TgXz/mvvHWk38TFB6Y+rEtlwu7VKJs9EC+EY9ZJijC4RAlJEpaocvXGxGEBS
         EQRw==
X-Forwarded-Encrypted: i=1; AJvYcCXz5wH47TVKbA+ug9qFxIGpSQ3VvjjYsguQvxHExyy9fg1641E5EZi8Ux7G3Wi7biXLlyyCE2XxyvgWAd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kF5El04r64eOWrisFtsy+JyCMRptKqJNOaqRNnfZ1hRbGMD4
	FG0KeiQlwAgXxuAPu8+fVQFQJ+vmr9iZ0UIL1Slavn3DCK1+C5XDZS8m1XADOTB71CI=
X-Gm-Gg: ASbGncte22X4yo87WSaVM+Yz1EnlW006NZ5N3S3x8ODzGkKaNCGLz1lrkk6Jff4MFTk
	mDu2mmUoP/1B4Kertr8MsxrYN1GWx3jPTYgnRkRzSI97JPWcidjnw72IliWwqn1FyiNY1OnIcgy
	95aqx/ol0HI59xdHCQSY6kjrHvWEk1M71bEQKlimyW5zOTCYa03GQcpQjy6pEHRi+seldeE4TNE
	tHKBbvHlMJhRuwatVNycVz4P2jl+yQtn34TX6KVzfj1m1iZAEtGs2rMleo95IyVbmQZ5J3/XxCT
	Ho3w4D1BwxJZU2cIP57GHgr9LUGic3DqSCkCYRj/xteMiymu7BejP9bg4VoEmFkW5zRTrzIeX8q
	Yxl620ZybaIHpw6IA3RSD2FW6VxXJ+Qda+7aQ1jkg92l8SoWAwnMd1aEOQgVk00FbdZxw3riW
X-Google-Smtp-Source: AGHT+IH9t28zTolDysbNhdXb23sMoRkURov5APnmp/JHYYlxIDPTMz/ZosJ9ofjYg1FWWz24zqLsng==
X-Received: by 2002:a05:6830:924:b0:73e:9857:9839 with SMTP id 46e09a7af769-7413d96e6a6mr3842789a34.0.1753562774403;
        Sat, 26 Jul 2025 13:46:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:63fb:769a:c359:cee? ([2600:8803:e7e4:1d00:63fb:769a:c359:cee])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74148230156sm445250a34.49.2025.07.26.13.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 13:46:12 -0700 (PDT)
Message-ID: <b09d59ed-8bc8-4db4-b758-78e05af399df@baylibre.com>
Date: Sat, 26 Jul 2025 15:46:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: iio: adc: add ade9000
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
 <20250721112455.23948-2-antoniu.miclaus@analog.com>
Content-Language: en-US
In-Reply-To: <20250721112455.23948-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 6:24 AM, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - move interrup-names near interrupts
>  - remove properties related to the waveform buffer and make them runtime attributes
>  - remove egy-time property and make it a runtime attribute.
>  - remove wf-src and use filter_type in the driver.
>  - add vref, vdd support.
>  - use adc standard channels instead of phase channels.

It seems that you ignored some of my v1 comments without saying why.

>  .../bindings/iio/adc/adi,ade9000.yaml         | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..0176252aae35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,122 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 s a highly accurate, fully integrated, multiphase energy and power
> +  quality monitoring device. Superior analog performance and a digital signal
> +  processing (DSP) core enable accurate energy monitoring over a wide dynamic
> +  range. An integrated high end reference ensures low drift over temperature
> +  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to- digital
> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ade9000
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: irq0
> +      - const: irq1

I still think that there should be 3 interrupts, the 3rd one being
the C4/EVENT/DREADY pin.

> +
> +  reset-gpios:
> +    description: |
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vref-supply: true
> +

There is also a clock input and clock output that we can add
clocks and #clock-cells for.

> +patternProperties:
> +  "^channel@[0-2]$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    type: object
> +
> +    properties:
> +      reg:
> +        description: The channel number (0-2 for phases A, B, C)
> +        minimum: 0
> +        maximum: 2
> +
> +    required:
> +      - reg

Why do we need channel properties? Do we expect in some cases to
only have 1 or 2 phases wired up? Otherwise, this provides no additional
information.

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
> +  - vdd-supply
> +

