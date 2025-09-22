Return-Path: <linux-kernel+bounces-827916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7ECB936A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D368F2A4391
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7A31815E;
	Mon, 22 Sep 2025 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PTyUHbk0"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F653115B5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578362; cv=none; b=Gu5OHJxh3b+Og354RO0+vqD7+CJFzVeDNRVtDZOfWV4bm7Q0cCa9Tqenfv1r489Qmj2G59qd5DfRFAw7dbf12XBeUmE3UvwcZY9TVgN+WytqCIBG8ALzfxZXIKcE7qRq/ZBr8WhEFehVknBn2Cthg5Ssn6HiJQ/YKOPsN7h59kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578362; c=relaxed/simple;
	bh=lPFkSA4urPrryk0oH1I0ODDGcpZpW1YuO+eJG87x5/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YK9ZNutP9hIeNwR0LtEiK44c3IUq5LVcPlNsqiFI766Z789Qs3TmxkL+g1BzZ5OeBlcAJz31yyZbczmskswIfDdhb7a2VGpW52hBGdkzzrxPRklC/GGl26Mykk6N1O3+r6ZeHFyE8sR821GA+RyXnQVmhQZGKqbtbmTO2tZ3oiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PTyUHbk0; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7459d088020so2782329a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758578358; x=1759183158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQFriecXyyC8g9C9fp+Jbl0vuN1bPs3xTfIEODghZ8c=;
        b=PTyUHbk0hnTFMTiS5xqcPzXH7ZViHucV3IImNPaqo0atHVmPB0pV1tw4Ghr/ZOn54K
         gwaUKO9GMYTaZ32/Cws3DzVOLOf5FSZ9XWEw9TEHvB+L/BBJt4rtxEDPqAxMHFAEF/QH
         Fg7oZ6Zt7nTpnjE3A/j0SSvpZD3cs/LDaKwSEgEsyYGNtHXP3bxMC0CJHl4Rf3ajOlmr
         D+eSm95//F0az9tQEuHf4WIK1rP0VtRde4f4JYv8JwPKU5A7EuwTlO0WOzJJppjQ4oYs
         +Yk9ElvqYZYoXq7sng7TczN9+/JD6DJyCRNMyzk/b2+dVXpanIrwl6Nax6f3CgpldaQM
         6ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578358; x=1759183158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQFriecXyyC8g9C9fp+Jbl0vuN1bPs3xTfIEODghZ8c=;
        b=bVo/1d4auQ1cjDwRmwKuE9lG8t8GdzmWfIk6fxfXsh45MTlo68Dgc2x7NmZ8uAjeHg
         ppPA1UgUwoqfv+6ZXlH8n8zPfAX4B+mlCuTPm2bneWe76XG7MSSLlwbEl+iUFhVUlc/j
         c8Opj8U8LrhsPjwR40oSVP+mcltjQ4q+nwmmEL7hyLi1HrGh79NdBP+Wd28tLB3s80z2
         vWTH3xJkqtJvZie6brQuDcIHbh8YKnyXCKBknalHi7jtbjmLR5C4iEsfE/VFbF2yjtyS
         UKMrOwSiQ8UNtvF7aYKyI0E7Lo3+7HePlJtEgXzN79eQb3SuGgZ0+N1B1o2a5XBRIfWf
         C+vw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQinSYhWImR3LS6RCFFJ45v6EEvkWFE+XzbibDvLuCnfXbis8GCGrgBaFY1osDn/mEpo1hdAtiZEkL+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcRBL1wfIuz9WxlQurskVYaelllPxBKrfW/2JDE93ECnkYL0j
	Pp/XylyMq9QYRPFQukFqMuolgEAavPsNJiaJ4SwvR85M/bEh9v/i5vZ9WkdPHsA4vTI=
X-Gm-Gg: ASbGncvHsIzm2B6LK6ulqVY9Nut4cDajeplOxMo96d2iynQ+mqHcxNAXHI9PVk/Jdbg
	s0H91/MDTeJofik4x0A1LFRuknR2Qe+pLspjCx9X26QaK7LwPSHegq0zVur0t4tZDAbnq5afr/i
	2DQvliKrXK7z38QlGNXVa3pDPoeWM+audTcyJ6qOFar9VtNBGLsA0XbhPtwYM2vwBuwTXccaxf9
	ytW9nWObGjgVVaGsTWPOPEzrpXgIFDFYCQXR/BmiUkGWV9kqHoUv8NVdNnipImkMdroWt/zkqZt
	xPq9VXwLnmyXQ9w5QwK4RNcrH3X+oY3qVQdV8B5dzD6IOKstQ7RaG3mkFlbR6EeAG3XY6sjLnv8
	g20UTwU2kYsaTW6PwFc9j1aZJFUX/0tFey1AplZ9cgsiqPxYNZPdl29bivU7O7NYOEASUXDWAZ3
	8=
X-Google-Smtp-Source: AGHT+IF4Zg64S4aMZbd52FqAlHa6Y4jsFMYO1DZaZDxK8iMMiuU2UfjpCvAUqb8C14Wa5++Dt4DliQ==
X-Received: by 2002:a05:6830:3784:b0:749:fac2:92fe with SMTP id 46e09a7af769-7912f920a14mr216371a34.0.1758578358464;
        Mon, 22 Sep 2025 14:59:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625dbab5cf1sm4209952eaf.22.2025.09.22.14.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:59:18 -0700 (PDT)
Message-ID: <7836f862-5320-4a81-b15b-4ada08e78077@baylibre.com>
Date: Mon, 22 Sep 2025 16:59:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
 <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 6:30 AM, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and
> MCP47F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 305 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 311 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d05ddafa37540bc1f6b6ce65a466b95913925c10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -0,0 +1,305 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp47feb02.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP47F(E/V)B(0/1/2)(1/2/4/8) DAC with I2C Interface Families
> +
> +maintainers:
> +  - Ariana Lazar <ariana.lazar@microchip.com>
> +
> +description: |
> +  Datasheet for MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
> +  MCP47FEB22 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
> +  Datasheet for MCP47FVBXX can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
> +  Datasheet for MCP47FEB04, MCP47FEB14, MCP47FEB24, MCP47FEB08, MCP47FEB18,
> +  MCP47FEB28, MCP47FVB04, MCP47FVB14, MCP47FVB24, MCP47FVB08, MCP47FVB18,
> +  MCP47FVB28 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
> +
> +  +------------+--------------+-------------+-------------+------------+
> +  | Device     |  Resolution  |   Channels  | Vref number | Memory     |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB01 |     8-bit    |      1      |      1      |   EEPROM   |
> +  | MCP47FEB11 |    10-bit    |      1      |      1      |   EEPROM   |
> +  | MCP47FEB21 |    12-bit    |      1      |      1      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB02 |     8-bit    |      2      |      1      |   EEPROM   |
> +  | MCP47FEB12 |    10-bit    |      2      |      1      |   EEPROM   |
> +  | MCP47FEB22 |    12-bit    |      2      |      1      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB01 |     8-bit    |      1      |      1      |      RAM   |
> +  | MCP47FVB11 |    10-bit    |      1      |      1      |      RAM   |
> +  | MCP47FVB21 |    12-bit    |      1      |      1      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB02 |     8-bit    |      2      |      1      |      RAM   |
> +  | MCP47FVB12 |    10-bit    |      2      |      1      |      RAM   |
> +  | MCP47FVB22 |    12-bit    |      2      |      1      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB04 |     8-bit    |      4      |      2      |      RAM   |
> +  | MCP47FVB14 |    10-bit    |      4      |      2      |      RAM   |
> +  | MCP47FVB24 |    12-bit    |      4      |      2      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FVB08 |     8-bit    |      8      |      2      |      RAM   |
> +  | MCP47FVB18 |    10-bit    |      8      |      2      |      RAM   |
> +  | MCP47FVB28 |    12-bit    |      8      |      2      |      RAM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB04 |     8-bit    |      4      |      2      |   EEPROM   |
> +  | MCP47FEB14 |    10-bit    |      4      |      2      |   EEPROM   |
> +  | MCP47FEB24 |    12-bit    |      4      |      2      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP47FEB08 |     8-bit    |      8      |      2      |   EEPROM   |
> +  | MCP47FEB18 |    10-bit    |      8      |      2      |   EEPROM   |
> +  | MCP47FEB28 |    12-bit    |      8      |      2      |   EEPROM   |
> +  +------------+--------------+-------------+-------------+------------+
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp47feb01
> +      - microchip,mcp47feb11
> +      - microchip,mcp47feb21
> +      - microchip,mcp47feb02
> +      - microchip,mcp47feb12
> +      - microchip,mcp47feb22
> +      - microchip,mcp47fvb01
> +      - microchip,mcp47fvb11
> +      - microchip,mcp47fvb21
> +      - microchip,mcp47fvb02
> +      - microchip,mcp47fvb12
> +      - microchip,mcp47fvb22
> +      - microchip,mcp47fvb04
> +      - microchip,mcp47fvb14
> +      - microchip,mcp47fvb24
> +      - microchip,mcp47fvb08
> +      - microchip,mcp47fvb18
> +      - microchip,mcp47fvb28
> +      - microchip,mcp47feb04
> +      - microchip,mcp47feb14
> +      - microchip,mcp47feb24
> +      - microchip,mcp47feb08
> +      - microchip,mcp47feb18
> +      - microchip,mcp47feb28
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  vdd-supply:
> +    description: |

Don't need `|` unless formatting needs to be preserved, like for the table in
the description above or the bullet lists below.

> +      Provides power and it will be used as the reference voltage if vref-supply
> +      is not provided.
> +
> +  vref-supply:
> +    description: |
> +      Vref pin is used as a voltage reference when this supply is specified.
> +      Into the datasheet it could be found as a Vref0.
> +      If it does not exists the internal reference will be used.

It looks like there is also the possibility to use V_DD as the reference
voltage. Not sure the best way to handle that though.

> +      This will be used as a reference voltage for the following outputs:
> +        - for single-channel device: Vout0;
> +        - for dual-channel device: Vout0, Vout1;
> +        - for quad-channel device: Vout0, Vout2;
> +        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
> +
> +  vref1-supply:
> +    description: |
> +      Vref1 pin is used as a voltage reference when this supply is specified.
> +      If it does not exists the internal reference will be used.
> +      This will be used as a reference voltage for the following outputs:
> +        - for quad-channel device: Vout1, Vout3;
> +        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
> +
> +  lat-gpios:
> +    description: |
> +      LAT pin to be used as a hardware trigger to synchronously update the DAC
> +      channels and the pin is active Low. It could be also found as lat0 in
> +      datasheet.
> +    maxItems: 1
> +
> +  lat1-gpios:
> +    description: |
> +     LAT1 pin to be used as a hardware trigger to synchronously update the odd
> +     DAC channels on devices with 4 and 8 channels. The pin is active Low.
> +    maxItems: 1
> +
> +  microchip,vref-buffered:
> +    type: boolean
> +    description: |
> +      Enable buffering of the external Vref/Vref0 pin in cases where the
> +      external reference voltage does not have sufficient current capability in
> +      order not to drop it’s voltage when connected to the internal resistor
> +      ladder circuit.
> +
> +  microchip,vref1-buffered:
> +    type: boolean
> +    description: |
> +      Enable buffering of the external Vref1 pin in cases where the external
> +      reference voltage does not have sufficient current capability in order not
> +      to drop it’s voltage when connected to the internal resistor ladder
> +      circuit.
> +
> +  microchip,output-gain-2x:
> +    type: boolean
> +    description: |
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: dac.yaml
> +    type: object
> +    description: Voltage output channel.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        minimum: 1
> +        maximum: 7
> +
> +      label:
> +        description: Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47feb01
> +              - microchip,mcp47feb11
> +              - microchip,mcp47feb21
> +              - microchip,mcp47fvb01
> +              - microchip,mcp47fvb11
> +              - microchip,mcp47fvb21
> +    then:
> +      properties:
> +        lat-gpios: true
> +        lat1-gpios: false
> +        vref-supply: true
> +        vref1-supply: false
> +        microchip,vref-buffered: true

Everything is already true, so we can leave out all of those
lines. It make it hard to see what is actually being modified.

> +        microchip,vref1-buffered: false
> +      patternProperties:
> +       "^channel@[1]$":
> +        properties:
> +         reg:
> +          items:

No items: here.

> +            maximum: 1
> +        "^channel@[2-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47feb02
> +              - microchip,mcp47feb12
> +              - microchip,mcp47feb22
> +              - microchip,mcp47fvb02
> +              - microchip,mcp47fvb12
> +              - microchip,mcp47fvb22
> +    then:
> +      properties:
> +        lat-gpios: true
> +        lat1-gpios: false
> +        vref-supply: true
> +        vref1-supply: false
> +        microchip,vref-buffered: true
> +        microchip,vref1-buffered: false
> +      patternProperties:
> +       "^channel@[1-2]$":
> +        properties:
> +         reg:
> +          items:
> +            maximum: 1

Isn't maximum 2 in this case?

> +        "^channel@[3-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47fvb04
> +              - microchip,mcp47fvb14
> +              - microchip,mcp47fvb24
> +              - microchip,mcp47fvb08
> +              - microchip,mcp47fvb18
> +              - microchip,mcp47fvb28
> +              - microchip,mcp47feb04
> +              - microchip,mcp47feb14
> +              - microchip,mcp47feb24
> +              - microchip,mcp47feb08
> +              - microchip,mcp47feb18
> +              - microchip,mcp47feb28

Should the 8-channel chips be include here? This
limits the channel@ to 1-4, so that doesn't jive
with having 8 channels.

> +    then:
> +      properties:
> +        lat-gpios: true
> +        lat1-gpios: true
> +        vref-supply: true
> +        vref1-supply: true
> +        microchip,vref-buffered: true
> +        microchip,vref1-buffered: true
> +      patternProperties:
> +       "^channel@[1-4]$":
> +        properties:
> +         reg:
> +          items:
> +            maximum: 1

And 4 here?

> +       "^channel@[5-7]$": false
> +  - if:
> +      not:
> +        required:
> +          - vref-supply
> +    then:
> +      properties:
> +        microchip,vref-buffered: false
> +  - if:
> +      not:
> +        required:
> +          - vref1-supply
> +    then:
> +      properties:
> +        microchip,vref1-buffered: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        dac@0 {
> +          compatible = "microchip,mcp47feb02";
> +          reg = <0>;
> +          vdd-supply = <&vdac_vdd>;
> +          vref-supply = <&vref_reg>;
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          channel@0 {
> +            reg = <0>;
> +            label = "DAC_OUTPUT_0";

These aren't particularly useful labels. It gives
the same info as the register number.

> +          };
> +
> +          channel@1 {
> +            reg = <0x1>;
> +            label = "DAC_OUTPUT_1";
> +          };
> +      };
> +    };
> +...


