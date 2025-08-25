Return-Path: <linux-kernel+bounces-785656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FBB34F20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35918167B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D80A2BE02C;
	Mon, 25 Aug 2025 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuzhpasJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593F19D8BC;
	Mon, 25 Aug 2025 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161669; cv=none; b=h7r+HAvWWgRYq9AKldeWpDusVHnb2DYRKB+i6eIHUnhm7vqfowIQWhLphSHCU+4cO3lC7sKjZSqas+vv+qVF6u4SITnVeP2G6BPA06OwDWma6+YyhdMy94c8BqwCPCXwg5KjIWwxAaUtDCVqepXCIt2uEUDZdM+I8pjevWvrwig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161669; c=relaxed/simple;
	bh=hcgh5oqMsvEek9C9auiVRt+yT8DF3gRRdz8vIwAO460=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP5VvyVtBH3OhM7/5pll5Ml0isxKp3Hcb+YORxreKytxt442n4jlDxRQAnZwPT1jjE+OP5luT7hhSDIGgvCZQ8ZeCInRbT8gQfVBG9YK82by2u5DfQkX3IOJdbQikHW9aIpL8yVzsRX06eZ/GDYNs7ekHmG6LtroaCrFV/HjjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuzhpasJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F71C4CEED;
	Mon, 25 Aug 2025 22:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161669;
	bh=hcgh5oqMsvEek9C9auiVRt+yT8DF3gRRdz8vIwAO460=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuzhpasJSKONwmodl29hxEeu1B+jNP9tEnNDVUu5J+c2hP06IPu8smtAiAy/paA5D
	 nQ7OpGab4minbAOsbjXXcQSkH/TI61SiMOxo7linJiZDbP6Jo2Fh2gtIHiIiZjiP/N
	 mf9A26nzWQ+DOGu7DynGHvPP7N0ZHQU2sT68opCJns/zJBs6HWbEVSHmxXzvpyh5pp
	 xl3cWCdgAOSNlciX9GaNuWSCTfhoxsI0v3bx0ke0VA8L3vRNHy/ALm9wKcVRs/LBDI
	 Jfa0gF4IsoAKqhjqPYzyz0kQSIj32X8rbLnBzfg2E6cmQXIvI3A4c5qKxfv4HGvFMC
	 zijfQ4ECgtsWA==
Date: Mon, 25 Aug 2025 17:41:08 -0500
From: Rob Herring <robh@kernel.org>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Collabora Kernel Team <kernel@collabora.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add
 rk3588 variant
Message-ID: <20250825224108.GA766877-robh@kernel.org>
References: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
 <20250616-rk3588-csi-dphy-v2-3-7a94f079b712@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-rk3588-csi-dphy-v2-3-7a94f079b712@collabora.com>

On Tue, Aug 19, 2025 at 01:00:37AM +0200, Michael Riesch wrote:
> The Rockchip RK3588 variant of the CSI-2 DPHY features two reset lines.
> Add the variant and allow for the additional reset.
> 
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>  .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 60 ++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> index 42da616ae2e3..10197cc9dc47 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> @@ -21,6 +21,7 @@ properties:
>        - rockchip,rk3326-csi-dphy
>        - rockchip,rk3368-csi-dphy
>        - rockchip,rk3568-csi-dphy
> +      - rockchip,rk3588-csi-dphy
>  
>    reg:
>      maxItems: 1
> @@ -39,18 +40,50 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    items:
> -      - description: exclusive PHY reset line
> +    minItems: 1
> +    maxItems: 2

Add a description for the 2nd reset here.

>  
>    reset-names:
> -    items:
> -      - const: apb
> +    minItems: 1
> +    maxItems: 2

Add 'phy' to the list here and just minItems.

>  
>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Some additional phy settings are access through GRF regs.
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-csi-dphy
> +              - rockchip,rk1808-csi-dphy
> +              - rockchip,rk3326-csi-dphy
> +              - rockchip,rk3368-csi-dphy
> +              - rockchip,rk3568-csi-dphy
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: exclusive PHY reset line
> +
> +        reset-names:
> +          items:
> +            - const: apb

Then just 'maxItems: 1' here.

> +    else:
> +      properties:
> +        resets:
> +          items:
> +            - description: APB reset line
> +            - description: PHY reset line
> +
> +        reset-names:
> +          items:
> +            - const: apb
> +            - const: phy

And 'minItems: 2' here.

> +
>  required:
>    - compatible
>    - reg
> @@ -77,3 +110,22 @@ examples:
>          reset-names = "apb";
>          rockchip,grf = <&grf>;
>      };
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        phy@fedc0000 {
> +            compatible = "rockchip,rk3588-csi-dphy";
> +            reg = <0x0 0xfedc0000 0x0 0x8000>;
> +            clocks = <&cru PCLK_CSIPHY0>;
> +            clock-names = "pclk";
> +            #phy-cells = <0>;
> +            resets = <&cru SRST_P_CSIPHY0>, <&cru SRST_CSIPHY0>;
> +            reset-names = "apb", "phy";
> +            rockchip,grf = <&csidphy0_grf>;
> +        };
> +    };
> 
> -- 
> 2.39.5
> 

