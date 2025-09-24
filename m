Return-Path: <linux-kernel+bounces-830087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C6B98B51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D06817DCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853262882C9;
	Wed, 24 Sep 2025 07:51:35 +0000 (UTC)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81492286D55
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700295; cv=none; b=i2O0+2yRN82nUSunTkhrZO8haNAK545Yxdun5JXZhxdsQOE7+HvQgU2OiYKK4bP6RD+MK5Wou1VNMkzdc8P1Ho0Xx14yXWulLVN0kM3O5K8P3m2RJSpvVjXB512DlHkJ2BDkPqxJoIWqyUbQ/ph1846BDOCWLVGBauDSY0dvh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700295; c=relaxed/simple;
	bh=aWLfvJIhJGUp5ivux4F05IzZUz29wUscuHa27oPNgME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhGobhI4GHVT71PCoVgr4iDd7iyJv18f1DWs7ceYKWXMQMVIkplm0eS1wUnMAfWW4bnR7xEZKVgAbF0w8AQnvVqnYtKkuU4HhOoZ3jQgWAckmroMKOCy1Nm6jeNGLfa7G+M3qSqfHcNAJcHkQURvGcP8exITnalUDgt+0MbGrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-90dd3b43f8eso621476241.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700291; x=1759305091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh+Khf6unZqbzxNHEU+Ts8bq4BIxlEWA7Rzthe6aDww=;
        b=dKOKZV2+Tswo81jQe7vZbDJV/GgFvqKCKGZv+UQo0cQcGa+KCKp1zT0mRjGBX38uu1
         UhzP+qlcGdM0059OvldINX7UzBJ4CIVjGAn/JufC+Ibe9plRvgAd1UvYmCoz8b5MOiF/
         YeyB9HjDFlmZTgmIfAsfaI0xLW0gQSW1ZD/kfqglzWho2cnG0q1fyqDIFbZvHMOwJD4a
         pcHcxWuilhbrDEOU/UZkYHL7DGJVdXey+qKgkE8OKCEzYgbOHRx1HgfPO8kllDOnkpsP
         9cHMTE8efu+unnTJnI9PlI1p5JUEivWK6efNYIMMeoAdYcI9SSJGTLYOB96TUN6Nex8X
         v+KA==
X-Forwarded-Encrypted: i=1; AJvYcCVxnrnvCqF/M+u159CZZqufOIcqZ39FzsbFgauqgq+ZSu9/Rl+io2AoPyApSeG89InVMUJ9x+49p26OmSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHuZRGiN5CqTayBvjJIaWtac2L1vXpibdAQMdhahj0fixkggE
	y8pxCoTsJveDWt77fHDZ/i7THPaA8BDUBb9kTrLDRj9Pi11BrEBjvDznctq41rBK
X-Gm-Gg: ASbGncti3GCzvuGdNFEmB/01nGrYFPcOpR6LvkxXJn2Ah6bld6SPBWZHxaq3Cw+ouVR
	KV0oEjOUl/IZ8uz6V2j/IfgzKSiQ+s/ZCaius7k9vxed8Iq3Sv9f0f7nmMRrCkIcuA3EvSdQk/x
	KpF0wOXjBwUYxVPRqK9umrHqEeV3aisho07rxvt1rpHgZcBTwRcuj8bac/slJA+SHfsUxCHazEt
	cpbIaq8HLu7bDWg2ocKhcRvMc7L7pPv4cWkltq05WB+/8RQ41pwOkjgMyqeJt3Z3XPpQz+mnz5E
	1kivqFS8DfsC8hKSeGnKnABrJXbmW//2gj6pFvcEAoyhKSDn42CdkIjIQ+39yqAO93iFJijna1E
	SpFoHXNOkk6WfeEQD6pvk84eOfSE2TPo+XIzWG+2et1TCJ7O92AzyB9MrZOe/
X-Google-Smtp-Source: AGHT+IGPNagFG3wPbqDMG+2blk87CddY9AKWIshubW24WMg91vw9tREjE/9HtQc02ii7CS7+sM18lQ==
X-Received: by 2002:a05:6122:6d16:b0:54b:d7b6:2f34 with SMTP id 71dfb90a1353d-54bd7b680eemr1136080e0c.0.1758700291112;
        Wed, 24 Sep 2025 00:51:31 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e5dc2d3esm3024033241.9.2025.09.24.00.51.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:51:30 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-59dff155dc6so2249897137.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:51:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbR1k6lMn4D2dYno0jKaA3DzeBq3fFKFQRR+boyQ0GjUEaxftEhpZERnui5MQvu6ISQTfu9KtCxF/3fB4=@vger.kernel.org
X-Received: by 2002:a05:6102:6884:b0:569:93c9:b572 with SMTP id
 ada2fe7eead31-5a57695d27dmr1659602137.9.1758700290135; Wed, 24 Sep 2025
 00:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com> <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 09:51:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com>
X-Gm-Features: AS18NWCUnOtI9sni6QIPbp0MqkmfhYYAKBnwNUuJbeyYXQXVL2FCMeoJiSjFxRk
Message-ID: <CAMuHMdVEDJZ6wdGZs_CDs=jLPV1u382o6=cZ1HfKQOffGf7jGw@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Tue, 23 Sept 2025 at 18:06, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/T2H / RZ/N2H ADC12
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> +
> +description: |
> +  A/D Converter block is a successive approximation analog-to-digital converter
> +  with a 12-bit accuracy. Up to 15 analog input channels can be selected.

The documentation for several registers talks about bitmasks for ch0-ch15,
so the actual hardware block supports up to 16 channels.

> +  Conversions can be performed in single or continuous mode. Result of the ADC
> +  is stored in a 16-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r9a09g077-adc # RZ/T2H
> +      - renesas,r9a09g087-adc # RZ/N2H
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: A/D scan end interrupt
> +      - description: A/D scan end interrupt for Group B
> +      - description: A/D scan end interrupt for Group C
> +      - description: Window A compare match
> +      - description: Window B compare match
> +      - description: Compare match
> +      - description: Compare mismatch
> +
> +  interrupt-names:
> +    items:
> +      - const: adi
> +      - const: gbadi
> +      - const: gcadi
> +      - const: cmpai
> +      - const: cmpbi
> +      - const: wcmpm
> +      - const: wcmpum
> +
> +  clocks:
> +    items:
> +      - description: converter clock

Converter

> +      - description: peripheral clock

Peripheral

> +
> +  clock-names:
> +    items:
> +      - const: adclk
> +      - const: pclk
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  renesas,max-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Maximum number of channels supported by the ADC.
> +      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
> +      RZ/N2H has two ADCs with 4 channels and one with 15 channels.

According to the documentation, both SoCs have three instances?

I agree with Connor that this should be dropped: the same information
is available from the channel@N subnodes, and future SoCs could have
gaps in the numbering.

FTR, from a quick glance, it looks like this module is very similar
to the ADC on RZ/A2M, so I hope we can reuse the driver for that SoC.

> +patternProperties:
> +  "^channel@[0-9a-e]$":

0-9a-f

> +    $ref: adc.yaml
> +    type: object
> +    description: The external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        maximum: 14

15
But I don't think it is needed, as the dtc check for non-matching unit
addresses and reg properties should already enforce this.

> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-adc
> +    then:
> +      properties:
> +        renesas,max-channels:
> +          enum: [4, 6]
> +
> +      patternProperties:
> +        "^channel@[6-9a-e]$": false

6-9a-f

> +        "^channel@[0-5]$":
> +          properties:
> +            reg:
> +              maximum: 5

Not needed as per above.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

