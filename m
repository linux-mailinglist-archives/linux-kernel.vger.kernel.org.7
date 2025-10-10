Return-Path: <linux-kernel+bounces-847656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB3BCB5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E69D4027B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6CF2264B8;
	Fri, 10 Oct 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8B7QSKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07A4414;
	Fri, 10 Oct 2025 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060054; cv=none; b=oWcqMDWUu25p9AZQvq6KJwPIjTnIKaFaHIqJh/qTre7ojGgry9taE4nf+UXDjWb0P/MZNBTGGXb4uIK4dmbQlDDozLrx/yHnu4NOXcSdTwcds6Mhp3gLmsk9Bxi03mprwxex3phyOKNhXVDIxkFxhsQ4+7fOllLXJduxa2gK4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060054; c=relaxed/simple;
	bh=8ZJbDaeBCqI+FE70wCqh8LvKqtIC9KwiaPD3ESDri3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHHwcnsbxdeGPncUz1dwkCeED9DWT7PLpB2oF29PU00GN18zRyHVspcO3VKCYrorQ9DOHupbWsYoUsnoGYx6xP3G9bZEktMjl6f20wtAEs7oevgYxCz8/Q2D3I7czFky8/62yPNUzk6AIQabrBYdVSP5ym62FF1J+FEgDtBQOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8B7QSKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A691C4CEE7;
	Fri, 10 Oct 2025 01:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760060054;
	bh=8ZJbDaeBCqI+FE70wCqh8LvKqtIC9KwiaPD3ESDri3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a8B7QSKRJfXQG+1MHOg1EZ4tlQyUuIcHbb2gUOkpXixjGjxsle2lDsY/nh3MmEVQi
	 kQVoNlvGmK9hrJ0HwXynXziKgY7u58hNv7peX17sUOTKJDXWBrP0Pk3DBOWI9dTdep
	 PhgttlGZ6w7v5OiAcSAHdsP6BRCRiAxio6XOiTsPdwiXl02loySG+M0p+icvkdxhea
	 e37dijbq7+rI89CH2mXaecQjXNY3K5MqYq1PYde+8CBi4ldlKHTnartrrsrsb26e+j
	 VwddVN5GG4qKc52vjcfVyKK+q9aOdyT45Piuhwo+4q8ZVkv6FsHFK+MuVhrM645u9V
	 4h52MAl185tuA==
Message-ID: <c65f8b8d-9ee9-4aea-8f27-66c9fe12401a@kernel.org>
Date: Fri, 10 Oct 2025 03:34:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: add yaml file for maxim,max3421
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, gregkh@linuxfoundation.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, davidm@egauge.net
Cc: ~lkcamp/patches@lists.sr.ht, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009182046.185520-1-rodrigo.gobbi.7@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251009182046.185520-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2025 03:15, Rodrigo Gobbi wrote:
> Convert maxim,max3421.txt to yaml format with a few extra properties like


Here and in subject, please do not use yaml at all. Look at other
commits, this is supposed to be:

dt-bindings: usb: maxim,max3421: convert to DT schema

(and all other things like "file for" are redundant")

> maxim,vbus-en-pin, maxim,gpx-pin, reset pin and supplies. Also add a

Why new properties? You must explain not only the difference but WHY you
are doing this.

WHY is the most important question/answer.

> maxim,max3421e compatible with a fallback, since the actually PN is with
> the 'e' suffix.

We don't add PNs usually, unless there is a need. So again, why?

> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> I've converted the txt into yaml with a few extra things as mentioned
> in the commit msg. All of them were extracted from the datasheet and also
> looking at the current state of the driver.
> 
> About the maintainer ref inside yaml, I'll quote the driver author:
> 
> Dear @David Mosberger, the binding file for this driver was not converted
> to YAML format. This patch address this. I've noticed you were the original
> driver author, so I`m "quoting" you at the maintainer ref inside yaml.
> I would appreciate your comment or suggestion over this topic.
> 
> Tks and regards to all.
> ---
>  .../devicetree/bindings/usb/maxim,3421.yaml   | 88 +++++++++++++++++++
>  .../devicetree/bindings/usb/maxim,max3421.txt | 23 -----
>  2 files changed, 88 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,3421.yaml
>  delete mode 100644 Documentation/devicetree/bindings/usb/maxim,max3421.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,3421.yaml b/Documentation/devicetree/bindings/usb/maxim,3421.yaml
> new file mode 100644
> index 000000000000..bccb22be74ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/maxim,3421.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/maxim,3421.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAXIM MAX3421e USB Peripheral/Host Controller
> +
> +maintainers:
> +  - David Mosberger <davidm@egauge.net>
> +
> +description: |
> +  The controller provides USB2.0 compliant with Full Speed or Low Speed when in
> +  the host mode. At peripheral, it operates at Full Speed. At both cases, it
> +  uses a SPI interface.
> +  Datasheet at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/max3421e.pdf
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - maxim,max3421e
> +          - const: maxim,max3421
> +      - const: maxim,max3421
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No, drop $ref. Do you see any binding like that? No, there is none.

> +    maximum: 26000000
> +    description:
> +      SPI interface that operates up to 26MHz in Hz.

Drop description, again, look at other bindings.

> +
> +  maxim,vbus-en-pin:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      One of eight GPOUT pins to control external VBUS power and the polarity
> +      of the active level. It's an array of GPIO number and the active level of it.
> +    minItems: 2
> +    maxItems: 2
> +
> +  maxim,gpx-pin:

I don't understand. There is no need for this property. Drop.


> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: A property to define the behavior of the GPX pin, which is an
> +      output that may be selected in a 4-way multiplexer between OPERATE(0),
> +      VBUS_DETECT(1), BUSACT/INIRQ(2) and SOF(3) signals.
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +  reset-gpios:
> +    description: Active low to clear all of the internal registers except for
> +                 PINCTL (R17), USBCTL (R15), and SPI logic.
> +
> +  vdd-supply: true
> +
> +  vlogic-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - maxim,vbus-en-pin
> +

Missing ref to spi props.

> +additionalProperties: false

unevaluatedProperties instead.


Best regards,
Krzysztof

