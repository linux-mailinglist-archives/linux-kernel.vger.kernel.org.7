Return-Path: <linux-kernel+bounces-840230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215CBB3E41
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1671C38E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8EA537E9;
	Thu,  2 Oct 2025 12:30:12 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB6B652
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408212; cv=none; b=efdt6nFJbrjBjNA9Q5WBaPhRvEbEFc3P1b9wtZ40AQ3gIs6BxRCHfRGDslpIsU/NMHfQCj+xBkUKPWor9XYRQOJBP0EFF4Lh1WbD55LH0I8BQrO1pDLT0CKvCr4U1Nux/JMh0eo43T691a/UGuvMUjXnZGYJTkLdkHXTs94y3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408212; c=relaxed/simple;
	bh=ZCLWknI3Oohh8zMZTDOwt7rdXpb2pywh5AbVWLK0g3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh9iMV1waSC9FCBnIHrevHuQb1g28cjTRSm9w2TuOEIwHJaznVjzkJX6YBnOtmjIBppSDG3jnTkia2W9lysGzAU+OPc8UuH7CHskobzcdTkMOXcG/ulhZE/ow4pNUENlB376pb74OwYDB01jrVdBMGf0CdWM/X2u7+aJf+uG53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-362e291924aso8503001fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408206; x=1760013006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY10gBxAlncLft1B4e8e0H+E3DPfeVQijK8Ci3Ekn1c=;
        b=iL3xJNrKenRESFkU5OdtMzYoG+D3gRPd4YtEgrBnYSWaK/OE5IhsxdGfWm6+cMlwAm
         6F6ViMozOXrdpz1Iqq0uFESyjjwdJ6iD0z1IiwavDSO/UYOREVERTJB0/fmxqOfmvt5C
         yOXHYxTtll1s+DTXG0SV27WI88KlkYMwWNKjFmVIfeB2cTOE1UV843scyoPqwTXlIQ1V
         W9HGB/SudIWRMIBc9hvjbxUiSsiNAp4ExSCQZQQhC8+QPVTafpsw35uCqG0C+jz+RVGh
         E3uRw3ZYupo2PWizctQUg97TbRJ9a4nbod1SV09o8S4qrcIfb3BmkzJwtzf6QxZBiDnz
         DPCg==
X-Forwarded-Encrypted: i=1; AJvYcCUWQjaubCqDyzxkRSgC2cqLy7atvPuloMt95CSXa22L7hCXPMQ3dqQGmfkchz+MQ5A24Bwfn5uBqQnd8fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMP54oqpbrqCpuSyrmAfZKB5TPJcqezXu/qVLtcZXNn5yEN8fw
	MDEgTZXcfDySEkLOgjHJt3MSHJjjyybVZhPhFl/4/Z4ZlYexohpfTqzJCpniFq2B3Ak=
X-Gm-Gg: ASbGncvh99qM2FOJbqG+u7Ia63JafI/hKdDQTB61KPUlM+zwqMz3B7DI4p1id/Ve3Bw
	zxntU/OyYDVaMzab2sLYegZrSYjc7n0O18FfqjOAbypVy5qtpJIrINrQCFvSpS6DtJZEdAUckd9
	tRY0O3fegJ2RzsgUevUm0oqiaXECJz98KivJ6mnuCqRN5CHB5HQbZnKMA4+nJAveRdS4r1zlgZ0
	/tSeQFR6kdC2l9sWS7NRRCcxfWGTELuslP66C8+yoHaaj5L+2NVNtvqXtShg4ntvpxTi2gCIAPh
	Ir+XNE3Cp/zxduaU7C0rSdrslDYm0o48+4mMh0mhYfL3QfVSKb7b7cDD7csD+TVkhuYlUVMiu8b
	NiGxmu7O2ZRfjC5vY2DKKBRNB5BmfdOyPaDQspr0fRum7Bp1pJpv+Ad0TkGeCHzoEG+m/6Fv0qH
	9na8YcYFI+7agn
X-Google-Smtp-Source: AGHT+IFYIFaNl1P3HxCTaS3bUPBpA55VFCRJ8wg/zvQ095i/c1u1u3ndosWuqO8N+oRv0Z1bOuWwvQ==
X-Received: by 2002:a05:6512:15aa:b0:567:68ad:428e with SMTP id 2adb3069b0e04-58af9dd020emr2603791e87.0.1759408206228;
        Thu, 02 Oct 2025 05:30:06 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d84csm784483e87.68.2025.10.02.05.30.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:30:05 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3637d6e9923so7839661fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:30:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxfL/8g9bN8rEAo8D5v1uLPIJUsjKIZPxIC+XnJMCW6Mw0e5+yzLhCpFFMhUOhR/dZhZribz6turtaxyg=@vger.kernel.org
X-Received: by 2002:a05:6402:2748:b0:634:a32f:abbc with SMTP id
 4fb4d7f45d1cf-63678c7876cmr7743508a12.25.1759407734935; Thu, 02 Oct 2025
 05:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:22:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOWMvyGLz8HGEvosrGY070e2Xtm+dFTcd0EDTq+55nmg@mail.gmail.com>
X-Gm-Features: AS18NWABtGa2D2TwMrIq8k3cqO5ssX-ZOaNtMz3MgD0zeopDW4rX6Xc3PgPqoFQ
Message-ID: <CAMuHMdWOWMvyGLz8HGEvosrGY070e2Xtm+dFTcd0EDTq+55nmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Document the A/D 12-Bit successive approximation converters found in the
> Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.
>
> RZ/T2H has two ADCs with 4 channels and one with 6.
> RZ/N2H has two ADCs with 4 channels and one with 15.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> @@ -0,0 +1,160 @@
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
> +  with a 12-bit accuracy. Up to 16 analog input channels can be selected.
> +  Conversions can be performed in single or continuous mode. Result of the ADC
> +  is stored in a 16-bit data register corresponding to each channel.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - renesas,r9a09g077-adc # RZ/T2H
> +      - renesas,r9a09g087-adc # RZ/N2H

Given the number of channels is now handled completely through the
number of subnodes, I wonder if this should be changed to:

    oneOf:
      - items:
          - const: renesas,r9a09g087-adc # RZ/N2H
          - const: renesas,r9a09g077-adc # RZ/T2H
      - items:
          - const: renesas,r9a09g077-adc # RZ/T2H

...

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-adc
> +    then:
> +      patternProperties:
> +        "^channel@[6-9a-f]$": false
> +        "^channel@[0-5]$":
> +          properties:
> +            reg:
> +              maximum: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,r9a09g087-adc
> +    then:
> +      patternProperties:
> +        "^channel@[f]$": false
> +        "^channel@[0-9a-e]$":
> +          properties:
> +            reg:
> +              maximum: 14

... and the SoC-specific restrictions above dropped?
The number of channels is instance-specific anyway.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

