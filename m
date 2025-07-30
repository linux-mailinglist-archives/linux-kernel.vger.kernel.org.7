Return-Path: <linux-kernel+bounces-750297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F29B159AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE954803B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D6D28ECD8;
	Wed, 30 Jul 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyXofFu8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB051EEA3C;
	Wed, 30 Jul 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860917; cv=none; b=QErwxFACwWdCphMZldYQwFqJIMynajyfGhBZNOfJaJiP3xPfqsDuiiqFIIhGC19xYty11L/d07NX0RIwDfVGr5ZNgw/NtUZ5eVBcitQe23ZdJXBpTFg275juAyVNgtQNwHm9oDf77ORnnEXIdSYJFNEFbd8R4VSlD9hz6EXHwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860917; c=relaxed/simple;
	bh=Rb42T9aQ/AvFB04Um0C8TnqGFJJMEejYJB7uNmy/X7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2HTImEc6kWN5Rn1MrEI4Ip0ZyqS34Kt6bOc+4meHhkbv2iBlssIiO7hwMYHRfQJpXW2Un+jwcCW0KlK9EN8EOhSWEi51HGdC+pAm8cJL0diykP6chYYNNfsEgIxYYBOSqZ+ga4RgXdmWZLBJbxoUnVhhwt+6EHvs55U0SYNAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyXofFu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CEEC4CEE7;
	Wed, 30 Jul 2025 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860915;
	bh=Rb42T9aQ/AvFB04Um0C8TnqGFJJMEejYJB7uNmy/X7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyXofFu8g8SSyulnEKipqT2pOCKv+cop+PA7ESplvce5MRGTqNlVUjnLgz/DgTKnT
	 Qr1msG/NOCq5NC4G3D0vr4xL1GHxj/7mI/6dBp8NGoHTokAr1pzK1jk/1qUR3n/IxJ
	 lTJfOJVDIjylOZ1QnwCvyHVHIC6+B/QpW2o9eVsKR7bX3N8VsCfBv4hzVT7qWrk+4u
	 WbwWmEQH67o8hVqDOQeBuDmHDZyd2HB6uJHZSeqlhmHHoT+pMgg+FX9676Jn7R2Quq
	 GRyPuKp8BNJMFu+dJPuX7m5PvNv6PYIcD4Edhtk1PRNwgBYS+6E8UCC5BGYvlwUxrA
	 oO6+qJ8rcpEdw==
Date: Wed, 30 Jul 2025 09:35:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: add support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20250730-aromatic-optimistic-hyena-f1db1a@kuoka>
References: <20250728-tja1145-support-v1-0-ebd8494d545c@liebherr.com>
 <20250728-tja1145-support-v1-1-ebd8494d545c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250728-tja1145-support-v1-1-ebd8494d545c@liebherr.com>

On Mon, Jul 28, 2025 at 05:39:29PM +0200, Dimitri Fedrau wrote:
> Adding documentation for NXPs TJA1145 CAN transceiver.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++

Why isn't this in can directory with rest of CAN bindings?

>  1 file changed, 79 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..10bf2bce1b35788b3284c42e544a56eda6d79947
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml

Filename should match compatible.

> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/nxp,tja1145-can.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TJA1145 CAN transceiver
> +
> +maintainers:
> +  - Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

Missing ref to transceiver properties. Look at other CAN bindings.

> +
> +properties:
> +  compatible:
> +    const: nxp,tja1145
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1

reg is the second property, also in "required:" block.

> +
> +  spi-max-frequency:
> +    maximum: 4000000
> +
> +  spi-cpha: true
> +
> +  spi-cs-setup-delay-ns:
> +    minimum: 50
> +    default: 50
> +
> +  spi-cs-hold-delay-ns:
> +    minimum: 50
> +    default: 50
> +
> +  spi-cs-inactive-delay-ns:
> +    minimum: 250
> +    default: 250
> +
> +  vcc-supply:
> +    description:
> +      CAN transceiver supply voltage
> +
> +  vio-supply:
> +    description:
> +      Supply voltage for I/O level adaptor
> +
> +  vbat-supply:
> +    description:
> +      Battery supply voltage
> +
> +required:
> +  - compatible
> +  - "#phy-cells"
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        canphy@0 {

can-phy if something like this exist. If not, then probably can-transceiver

> +            compatible = "nxp,tja1145";
> +            #phy-cells = <0>;
> +            reg = <0>;

Please follow DTS coding style.

Best regards,
Krzysztof


