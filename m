Return-Path: <linux-kernel+bounces-830613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87114B9A1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BA0325EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EB302167;
	Wed, 24 Sep 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9mgBRE7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23023504B;
	Wed, 24 Sep 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722073; cv=none; b=iGbytnXebrtkFB+DHiYTnVhcCXeLGj0vIlusNlppmQwmSv+SU7rx2F2VEg/XH8WvOK5Q3218vyDmAMzuK+Kdf8mu54uo+WqQ7Flh+UkVTUMvXgfrtOaXpsA9Y9VIjjqUGu7pxDwQVro5jX4NnSfCf9q7QHjax12RdGFfHdnuQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722073; c=relaxed/simple;
	bh=6j/GHnmpQtuCepYBArXOo7hgJmy5OohdGzQ6jgGXn4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCYREPdgN9rALYGeS0yWc1nzl+LDBLweU+f/QCipsaWZosrRWoTuKhbIha+EZ7evoJhLs4mMQQZ9dx+TJHInRnhg2xJwEcdhd12M1W7ZHKTj24l7ZIGA+4IZXBo0mG0DbOreodjwKJLeOVgL8ScfV7p70LGAQ46/hc0EgHJ7IHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9mgBRE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737C5C4CEF0;
	Wed, 24 Sep 2025 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758722072;
	bh=6j/GHnmpQtuCepYBArXOo7hgJmy5OohdGzQ6jgGXn4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9mgBRE7UXmgl8VoPmdEtdxCI1XFFC0a+EZLaHwyoRLORSQka9pzw0AnQzFhBlacG
	 Z8Jfdf8uKmLpcHsCCiMRbWDmjklgA95/2MZlVxkUewWJBzRjx2HYqu7gUAv6efX7F5
	 XOvDSZ9JsLbRwZkBOecWvSjcHC4ihlNkKqOw9zifSQJsiM/sfZWwUnHdo+NZJg4vtr
	 lZN7PetOCuM/0BGXNST5GrJCimdU3hhfV103RcbXAmy4utiijFWsp+CK0HB6/w0M+4
	 3By/cO2BHSS5ZOEVWfL86Sg5wTWxCkycpHcXC21yXZ90gj7RuFwRD0V+O5Y90Vi4ij
	 SYVIB4Wa8ZJKA==
Date: Wed, 24 Sep 2025 08:54:29 -0500
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250924135429.GA1523283-robh@kernel.org>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-13-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923194445.454442-13-vladimir.oltean@nxp.com>

On Tue, Sep 23, 2025 at 10:44:41PM +0300, Vladimir Oltean wrote:
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations on all SoCs to use it was a mistake.
> 
> They all share the same register map, sure, but the number of protocol
> converters and lanes which are instantiated differs in a way that isn't
> detectable by the programming interface.
> 
> Using a separate compatible string per SerDes instantiation is
> sufficient for any device driver to distinguish these features and/or
> any instance-specific quirk. It also reflects how the SoC reference
> manual provides different tables with protocol combinations for each
> SerDes. NXP clearly documents these as not identical, and refers to them
> as such (SerDes 1, 2, etc).
> 
> The other sufficient approach would be to list in the device tree all
> protocols supported by each lane. That was attempted in this unmerged
> patch set for the older Lynx 10G family:
> https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
> 
> but IMO that approach is more drawn-out and more prone to errors,
> whereas this one is more succinct and obviously correct.
> 
> Since this compatible string change breaks forward compatibility of old
> kernels with new device trees (which is OK with the known users), this
> is a good time to fulfill another user request, which is that individual
> SerDes lanes should have had their own OF nodes, so that we can
> customize electrical parameters:
> https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
> 
> This request requires #phy-cells = <0>, and because "fsl,lynx-28g"
> requires #phy-cells = <1>, we obviously cannot have both at the same
> time.
> 
> Change the expected name of the top-level node to "serdes", and update
> the example too.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2:
> - drop the usage of "fsl,lynx-28g" as a fallback compatible
> - mark "fsl,lynx-28g" as deprecated
> - implement Josua's request for per-lane OF nodes for the new compatible
>   strings
> 
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 146 +++++++++++++++++-
>  1 file changed, 140 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> index ff9f9ca0f19c..390c9ecd94cc 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> @@ -9,21 +9,113 @@ title: Freescale Lynx 28G SerDes PHY
>  maintainers:
>    - Ioana Ciornei <ioana.ciornei@nxp.com>
>  
> +description: |

Don't need '|' if no formatting to preserve.

> +  The Lynx 28G is a multi-lane, multi-protocol SerDes (PCIe, SATA, Ethernet)
> +  present in multiple instances on NXP LX2160A and LX2162A SoCs. All instances
> +  share a common register map and programming model, however they differ in
> +  supported protocols per lane in a way that is not detectable by said
> +  programming model without prior knowledge. The distinction is made through
> +  the compatible string.
> +
>  properties:
>    compatible:
> -    enum:
> -      - fsl,lynx-28g
> +    oneOf:
> +      - const: fsl,lynx-28g
> +        deprecated: true
> +        description: |
> +          Legacy compatibility string for Lynx 28G SerDes. The capabilities
> +          of managed lanes are limited to 1GbE and 10GbE (depending on the
> +          availability of an adequate PLL clock net frequency). Deprecated, use
> +          device-specific strings instead.
> +      - enum:
> +          - fsl,lx2160a-serdes1
> +          - fsl,lx2160a-serdes2
> +          - fsl,lx2160a-serdes3
> +          - fsl,lx2162a-serdes1
> +          - fsl,lx2162a-serdes2
>  
>    reg:
>      maxItems: 1
>  
> +  "#address-cells":
> +    const: 1
> +    description: "Address cells for child lane nodes"

You don't need generic descriptions of common properties.

> +
> +  "#size-cells":
> +    const: 0
> +    description: "Size cells for child lane nodes"
> +
>    "#phy-cells":
> +    description: "Number of cells in PHY specifier (legacy binding only)"
>      const: 1
>  
> +patternProperties:
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    description: Individual SerDes lane acting as PHY provider
> +
> +    properties:
> +      reg:
> +        description: Lane number
> +        maxItems: 1
> +
> +      "#phy-cells":
> +        description: Number of cells in PHY specifier for this lane
> +        const: 0
> +
> +    required:
> +      - reg
> +      - "#phy-cells"
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> -  - "#phy-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: fsl,lynx-28g
> +    then:
> +      # Legacy case: parent is PHY provider
> +      properties:
> +        "#phy-cells":
> +          const: 1
> +        "#address-cells": false
> +        "#size-cells": false
> +      required:
> +        - "#phy-cells"
> +      patternProperties:
> +        "^phy@[0-9a-f]+$": false
> +    else:
> +      # Modern case: children are PHY providers
> +      properties:
> +        "#phy-cells": false
> +      required:
> +        - "#address-cells"
> +        - "#size-cells"
> +
> +  # LX2162A SerDes 1 has fewer lanes than the others
> +  - if:
> +      properties:
> +        compatible:
> +          const: fsl,lx2162a-serdes1
> +    then:
> +      patternProperties:
> +        "^phy@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              description: Lane number (lanes 4-7 only for LX2162A SerDes 1)
> +              enum: [4, 5, 6, 7]
> +    else:
> +      patternProperties:
> +        "^phy@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              description: Lane number (lanes 0-7)
> +              enum: [0, 1, 2, 3, 4, 5, 6, 7]
>  
>  additionalProperties: false
>  
> @@ -32,9 +124,51 @@ examples:
>      soc {
>        #address-cells = <2>;
>        #size-cells = <2>;
> -      serdes_1: phy@1ea0000 {
> -        compatible = "fsl,lynx-28g";
> +
> +      serdes_1: serdes@1ea0000 {
> +        compatible = "fsl,lx2160a-serdes1";
>          reg = <0x0 0x1ea0000 0x0 0x1e30>;
> -        #phy-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        phy@0 {
> +          reg = <0>;
> +          #phy-cells = <0>;
> +        };

There's really no difference between having child nodes 0-7 and 8 phy 
providers vs. putting 0-7 into a phy cell arg and 1 phy provider. 

The only difference I see is it is more straight-forward to determine 
what lanes are present in the phy driver if the driver needs to know 
that. But you can also just read all 'phys' properties in the DT with a 
&serdes_1 phandle and determine that. Is that efficient? No, but you 
have to do that exactly once and probably has no measurable impact.

With that, then can't you simply just add a more specific compatible:

compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";

Then you maintain some compatibility.

Rob

