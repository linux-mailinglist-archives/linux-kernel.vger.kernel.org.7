Return-Path: <linux-kernel+bounces-795656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D7B3F5FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE76B7A4C89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0B2E613A;
	Tue,  2 Sep 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLMoUTaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB12E54B0;
	Tue,  2 Sep 2025 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796039; cv=none; b=CJzay+zEWdlagDSkLwTt8AyYb/AZ64IQy/eYhjExCtFClrxnksTAUj4YHH7zv6W7TC6bpG3skS/0plCUbygQMYC9x70L942ZvYj9FiQYFcZqJ4turVKg53CJJyFeLB7u4iCREpVfhG/CINujRO+g9pyIe8qK/yDDnfQ1xo2oYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796039; c=relaxed/simple;
	bh=x2x3SnSKVvJVv3s4/yWgywKxKMJHOQ8RIYjZEfRYGl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7VObpfS6KZA/gvmiHE7x8yye18UKNrk7IoQqoo9yw9eSDO/MVEF9KJDKUIO01TBR/rWSKIixdpAZ8mR5HCACyAcAMz13pIe5Kv7Gwfp1jzBsKmrbKB7RY5wbtSHgfdVi6VxsUTvTdE1NL0WoKsoWNSeFangh2t/IeHFxTEDX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLMoUTaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E57C4CEED;
	Tue,  2 Sep 2025 06:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756796038;
	bh=x2x3SnSKVvJVv3s4/yWgywKxKMJHOQ8RIYjZEfRYGl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oLMoUTaFmYvyv5ivEDZ6JxzrlEqkLnU54G0icnWI7GYPUiNNczVaQYq6/AozkqOUO
	 FIwWkJrZITT7h4/N6CefdGBe7yoxKk6ybtzHlpn54cuDQpNID4M6kWhBX0s/nyfmAP
	 9zXIECVdzmYei5Bf3x6h40aews96iobv60+aNmg659j7mqPph2ti9Tsjta0pL8Y4+l
	 phQ+rIP6UBjWNKutAcus4awAMRaxTc7JTe66HF8M+Qnd1oOsvmAhxzrck0qi9kmdtR
	 VbtLyYjNfML8aGRGXAn5ncC60v+pRYH50eKsXZkQsearNRoXbWWQE76dyPcaM46oCu
	 0ApB/3oZ8Z6tA==
Date: Tue, 2 Sep 2025 08:53:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: drm/bridge: ti-tmds181: Add TI
 TMDS181 and SN65DP159 bindings
Message-ID: <20250902-hasty-spry-nautilus-c05c6a@kuoka>
References: <20250901142958.843678-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.edc18686-244f-441e-a6ac-0b62492b96c8@emailsignatures365.codetwo.com>
 <20250901142958.843678-2-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901142958.843678-2-mike.looijmans@topic.nl>

On Mon, Sep 01, 2025 at 04:29:01PM +0200, Mike Looijmans wrote:
>  .../bindings/display/bridge/ti,tmds181.yaml   | 152 ++++++++++++++++++
>  1 file changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> new file mode 100644
> index 000000000000..c6387c482431
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tmds181.yaml
> @@ -0,0 +1,152 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ti,tmds181.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TMDS181 and SN65DP159 HDMI retimer/redriver chips
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Texas Instruments TMDS181 and SN65DP159 retimer and redriver chips.
> +  https://www.ti.com/product/TMDS181
> +  https://www.ti.com/product/SN65DP159
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,tmds181
> +      - items:
> +          - const: ti,sn65dp159
> +          - const: ti,tmds181
> +
> +  reg:
> +    enum:
> +      - 0x5b
> +      - 0x5c
> +      - 0x5d
> +      - 0x5e
> +
> +  oe-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for OE pin (active high).

So that's reset-gpios or powerdown-gpios (see gpio-consumer-common). At
least datasheet calls them that in one place.

> +
> +  vdd-supply:
> +    description: Core power supply, 1.1V
> +
> +  vcc-supply:
> +    description: IO power supply, 3.3V
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for HDMI (ish) input
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Video port for HDMI output (panel or bridge)
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +  ti,source-mode:
> +    type: boolean
> +    description:
> +      Force chip to operate in "source" mode. Allows to use
> +      a TMDS181 chip (which defaults to sink) as cable driver.
> +
> +  ti,sink-mode:

Aren't these two mutually exclusive? Can same device operate in source
and in sink mode simultaneously?


> +    type: boolean
> +    description:
> +      Force chip to operate in "sink" mode. Allows to use
> +      a DP159 chip (defaults to source) for incoming signals.
> +
> +  ti,retimer-threshold-hz:
> +    minimum: 25000000
> +    maximum: 600000000
> +    default: 200000000
> +    description:
> +      Cross-over point. Up until this pixel clock frequency
> +      the chip remains in the low-power redriver mode. Above
> +      the threshold the chip should operate in retimer mode.
> +
> +  ti,dvi-mode:
> +    type: boolean
> +    description: Makes the DP159 chip operate in DVI mode.

This suggest it is not applicable to TMDS, so you need to restrict it to
disallow it there (see example-schema).

Actually several other properties say they are applicable only to DP159.

> +
> +  ti,slew-rate:

Common property is "slew-rate" - see pincfg-node.yaml

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    default: 3
> +    description: Set slew rate, 0 is slowest, 3 is fastest.
> +
> +  ti,disable-equalizer:
> +    type: boolean
> +    description: Disable the equalizer (to save power).
> +
> +  ti,adaptive-equalizer:
> +    type: boolean
> +    description: Set the equalizer to adaptive mode.

Can equalizer be disabled and adaptive the same time?

> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +additionalProperties: false

Best regards,
Krzysztof


