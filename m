Return-Path: <linux-kernel+bounces-872838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB2C12259
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1D560DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7147137932;
	Tue, 28 Oct 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW3QOCmk"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98611713
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610207; cv=none; b=VTTqiAMesd/623dY68bXrUYBBlYGB/Ur+M0WCloAsnKIASD3E6GZILOaV9WzAUpdLol/nYyy1i+uo9zOfF8eUXBD74yjUbBc9v81kuwgHplHtcyGAUA1vdTIh9TYZC7XLAbgtKs3VJHVS38F03da9T6VphLh+p2uNdeEukyhseA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610207; c=relaxed/simple;
	bh=Ln6MTZMf7Roaz2eLLRtP5Q2hRt99qqbVFZF2QvRBpqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+79K+7z/xcaT6ub3ep89G+7o1b3dHnY+fA+oh7vjHrGwHFdttLI0K2HQikBkhJLOgH2UStI817CwM7nYWTC5Ax1AL54B9ZsUmair7Cbw0ohePvJgQBVa0ZzetfqWIcYK50UBxLqMflX5y/CoTyz8CEiMMUBo6uVxWKkwwnN4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW3QOCmk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475daf41e47so2137045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761610203; x=1762215003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8+oMsbGflHDfzB6g+KwpVRq6AklZwySWJYH0p0oO6U=;
        b=XW3QOCmkXILC3Hmtjq6n9loadnYnmd4x8WMsl5vs47nQr4gutRCAP4D0koNw0MBlL5
         /TXOKbXT2XNjf/3PWLtADxNUFBNRWTL/m68r6RPp1+yEwLrs0BGWBcP7jMRL+hkdfyLf
         9HNb0+mM5fedX9kQgDAPjX3HSKunwrP6gAG1XR565KoiB3EDAULf7wp9cJZBeOlJmJ7Y
         R9ZJjCBQxa0pSZ48WeXbmH9YbUVaROZjW9t1Amg+amihqbwlzzq6dLpmjNIMafxuLuuW
         7dubuXOhuNbW3IKCwqwAQqaSj1k69QOjcnVx3mgG7NldqAJSGOgYjWUTPvCpjyzqU7+P
         6SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761610203; x=1762215003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8+oMsbGflHDfzB6g+KwpVRq6AklZwySWJYH0p0oO6U=;
        b=UX1Rg+o70fkSwJyyeMI+cP2A0mVxeGG6OXukDcZAr5ltEmIKQUokjwZ64CI4UPVDcH
         ryol2y1i6WDvbOIpMMr+uerLPA5XOwwqXE5TqUrTiFhHCxsohR3bSCMvfXJx2Jx3dvp3
         oHvb3QoM58LawWkmtg+zufLTY2MD+KlHj9uhJ77PAjIrEYKtDwOf4/YIpMzTggKAL11N
         GcCN1Hi+V/tdXQ5kmdlNljSexcN57GM3fOVoU8gQcy9x90mm6a+Btkvieh3CIsC0fo5n
         AW/lJhhhENciEhs1HWpgGNsnwUa39ZK88F0UuCUncIu9rwsLwUl7oms3888PGUtj2eJC
         Y4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUY0uzH8p0bSp6qQfU2m4n0jZTfbeExzZZZqotnwf5rsSVS87t71Q+Gd1dmC60S88Jf2WhtBFzrsbAZnpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssIzrNu5ZzMOpj78IcCh+lIX+BDCbW6qlJ3FH3B3m6Ayu8wFu
	c/XFIDzRlJaHFB00zc/epH17z7JzqWbdiANPWRengXX/REhcU6c9g9IX
X-Gm-Gg: ASbGnctJQLH2Bz+JGgQJh+W87N/IJtAl+OcvTwmZsLTJd0G4d3FjX2oq8wfTpf2YodI
	lWehdwlJ/g0ZTN77CH4rboMCTGkdmTa5NB6ta2XSNLpFpZWc/uHVhwlzbbCn1OJTW+p/BUDzjAq
	GSxX+uob12QPjAWdsCDiys1g1Hky/x/AnH6Z7DEKTsLFM5u8eEV1Mn2+MH71nsAIbnjbOQ0YiHp
	qeyAuGzduteai0Ktzpww4ZRDWVn6xw4Y6qplnRjGxqgd89KhQNNygNStaOFvyyavwqIYnjH0QcU
	2YFFTQ7gcuWAQSlVns0kt6lgP72uCwbiCMl+/EuVbGFmglMckH0RCPPEklk4dHv/qerHHHt3qAt
	zCSnQ5eV4yi4SK30IEA2hL02d97vS8RNlnTrVXLo7ZUcrzdGWGeDx89VIdpRQT+sF3b24uZVfW1
	kX/Qk=
X-Google-Smtp-Source: AGHT+IHXYqqVrTGE8Skw7UGat9z2Cm9jZbgM8Jh6J5i7FvFkzhUYHjf888d1NXBdnbc2Yplb16m6Hg==
X-Received: by 2002:a05:6000:184b:b0:427:2bf:54c3 with SMTP id ffacd0b85a97d-429a7e7afdbmr619058f8f.8.1761610202797;
        Mon, 27 Oct 2025 17:10:02 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7dcsm17600480f8f.11.2025.10.27.17.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:10:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 02:09:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 10/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MaxLinear GSW1xx switches
Message-ID: <20251028000959.3kiac5kwo5pcl4ft@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>
 <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>
 <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:48:06PM +0000, Daniel Golle wrote:
> Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
> GSW1xx switches which are based on the same hardware IP but connected
> via MDIO instead of being memory-mapped.
> 
> Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
> and GSW145 switches and adjust the schema to handle the different
> connection methods with conditional properties.
> 
> Add MaxLinear GSW125 example showing MDIO-connected configuration.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3:
>  * add maxlinear,rx-inverted and maxlinear,tx-inverted properties
> 
> v2:
>  * remove git conflict left-overs which somehow creeped in
>  * indent example with 4 spaces instead of tabs
> 
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 275 +++++++++++++-----
>  1 file changed, 202 insertions(+), 73 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index dd3858bad8ca..1148fdd0b6bc 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -4,7 +4,12 @@
>  $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Lantiq GSWIP Ethernet switches
> +title: Lantiq GSWIP and MaxLinear GSW1xx Ethernet switches
> +
> +description:
> +  Lantiq GSWIP and MaxLinear GSW1xx switches share the same hardware IP.
> +  Lantiq switches are embedded in SoCs and accessed via memory-mapped I/O,
> +  while MaxLinear switches are standalone ICs connected via MDIO.
>  
>  $ref: dsa.yaml#
>  
> @@ -34,6 +39,108 @@ patternProperties:
>              description:
>                Configure the RMII reference clock to be a clock output
>                rather than an input. Only applicable for RMII mode.
> +          maxlinear,rx-inverted:
> +            type: boolean
> +            description:
> +              Enable RX polarity inversion for SerDes port.
> +          maxlinear,tx-inverted:
> +            type: boolean
> +            description:
> +              Enable TX polarity inversion for SerDes port.

How urgently do you need these two properties? They are truly general,
not vendor-specific, and while I wanted to add such support to the
Synopsys XPCS, I started working on some generic variants.

There's some cleanup and consolidation to do. "st,pcie-tx-pol-inv" and
"st,sata-tx-pol-inv" are defined in .txt bindings but not implemented.
Then we have "st,px_rx_pol_inv" and "mediatek,pnswap" which would also
need deprecating and converted to the new formats.

Where I left things was that I haven't decided if there's any value in
defining the polarity per SerDes protocol (like
Documentation/devicetree/bindings/phy/transmit-amplitude.yaml) or if a
global value is fine. I.e. if the polarity is inverted for SATA, it's
normal for PCIe, or something like that. The existence of the independent
"st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" properties would suggest
yes, but the lack of an implementation casts some doubt on that.

Anyway, I do have some prototype patches that add something like this:

    phy: phy {
      #phy-cells = <1>;
      tx-p2p-microvolt = <915000>, <1100000>, <1200000>;
      tx-p2p-microvolt-names = "2500base-x", "usb-hs", "usb-ss";

      /* RX polarity is inverted for usb-hs, normal for usb-ss */
      rx-polarity = <PHY_POL_INVERT>, <PHY_POL_NORMAL>;
      rx-polarity-names = "usb-hs", "usb-ss";

      /* TX polarity is normal for all modes */
      tx-polarity = <PHY_POL_NORMAL>;
      tx-polarity-names = "default";
    };

and a new drivers/phy/phy-common-props.c file (yes, outside of netdev)
with two exported API functions:

int phy_get_rx_polarity(struct fwnode_handle *fwnode, const char *mode_name);
int phy_get_tx_polarity(struct fwnode_handle *fwnode, const char *mode_name);

If you can split this up from the rest of the MDIO discrete switch
introduction series, I can accelerate work on these common properties in
the following weeks.

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - lantiq,xrx200-gswip
> +              - lantiq,xrx300-gswip
> +              - lantiq,xrx330-gswip
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +          maxItems: 3
> +          description: Memory-mapped register regions (switch, mdio, mii)
> +        reg-names:
> +          items:
> +            - const: switch
> +            - const: mdio
> +            - const: mii
> +        mdio:
> +          $ref: /schemas/net/mdio.yaml#
> +          unevaluatedProperties: false
> +
> +          properties:
> +            compatible:
> +              const: lantiq,xrx200-mdio
> +
> +          required:
> +            - compatible
> +        gphy-fw:
> +          type: object
> +          properties:
> +            '#address-cells':
> +              const: 1
> +
> +            '#size-cells':
> +              const: 0
> +
> +            compatible:
> +              items:
> +                - enum:
> +                    - lantiq,xrx200-gphy-fw
> +                    - lantiq,xrx300-gphy-fw
> +                    - lantiq,xrx330-gphy-fw
> +                - const: lantiq,gphy-fw
> +
> +            lantiq,rcu:
> +              $ref: /schemas/types.yaml#/definitions/phandle
> +              description: phandle to the RCU syscon
> +
> +          patternProperties:
> +            "^gphy@[0-9a-f]{1,2}$":
> +              type: object
> +
> +              additionalProperties: false
> +
> +              properties:
> +                reg:
> +                  minimum: 0
> +                  maximum: 255
> +                  description:
> +                    Offset of the GPHY firmware register in the RCU register
> +                    range
> +
> +                resets:
> +                  items:
> +                    - description: GPHY reset line
> +
> +                reset-names:
> +                  items:
> +                    - const: gphy
> +
> +              required:
> +                - reg
> +
> +          required:
> +            - compatible
> +            - lantiq,rcu
> +
> +          additionalProperties: false
> +      required:
> +        - reg-names
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +          description: MDIO bus address
> +        reg-names: false
> +        gphy-fw: false

If they're so different you could also define a separate schema for the
discrete switches, if that helps.

> +        mdio:
> +          $ref: /schemas/net/mdio.yaml#
> +          unevaluatedProperties: false
>  
>  maintainers:
>    - Hauke Mehrtens <hauke@hauke-m.de>
> @@ -44,78 +151,11 @@ properties:
>        - lantiq,xrx200-gswip
>        - lantiq,xrx300-gswip
>        - lantiq,xrx330-gswip
> -
> -  reg:
> -    minItems: 3
> -    maxItems: 3
> -
> -  reg-names:
> -    items:
> -      - const: switch
> -      - const: mdio
> -      - const: mii
> -
> -  mdio:
> -    $ref: /schemas/net/mdio.yaml#
> -    unevaluatedProperties: false
> -
> -    properties:
> -      compatible:
> -        const: lantiq,xrx200-mdio
> -
> -    required:
> -      - compatible
> -
> -  gphy-fw:
> -    type: object
> -    properties:
> -      '#address-cells':
> -        const: 1
> -
> -      '#size-cells':
> -        const: 0
> -
> -      compatible:
> -        items:
> -          - enum:
> -              - lantiq,xrx200-gphy-fw
> -              - lantiq,xrx300-gphy-fw
> -              - lantiq,xrx330-gphy-fw
> -          - const: lantiq,gphy-fw
> -
> -      lantiq,rcu:
> -        $ref: /schemas/types.yaml#/definitions/phandle
> -        description: phandle to the RCU syscon
> -
> -    patternProperties:
> -      "^gphy@[0-9a-f]{1,2}$":
> -        type: object
> -
> -        additionalProperties: false
> -
> -        properties:
> -          reg:
> -            minimum: 0
> -            maximum: 255
> -            description:
> -              Offset of the GPHY firmware register in the RCU register range
> -
> -          resets:
> -            items:
> -              - description: GPHY reset line
> -
> -          reset-names:
> -            items:
> -              - const: gphy
> -
> -        required:
> -          - reg
> -
> -    required:
> -      - compatible
> -      - lantiq,rcu
> -
> -    additionalProperties: false
> +      - maxlinear,gsw120
> +      - maxlinear,gsw125
> +      - maxlinear,gsw140
> +      - maxlinear,gsw141
> +      - maxlinear,gsw145
>  
>  required:
>    - compatible
> @@ -130,6 +170,7 @@ examples:
>              reg = <0xe108000 0x3100>,  /* switch */
>                    <0xe10b100 0xd8>,    /* mdio */
>                    <0xe10b1d8 0x130>;   /* mii */
> +            reg-names = "switch", "mdio", "mii";
>              dsa,member = <0 0>;
>  
>              ports {
> @@ -228,3 +269,91 @@ examples:
>                      };
>              };
>      };
> +
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch@1f {
> +            compatible = "maxlinear,gsw125";
> +            reg = <0x1f>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    label = "lan0";
> +                    phy-handle = <&switchphy0>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    label = "lan1";
> +                    phy-handle = <&switchphy1>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@4 {
> +                    reg = <4>;
> +                    label = "wan";
> +                    phy-mode = "1000base-x";
> +                    maxlinear,rx-inverted;
> +                    managed = "in-band-status";
> +                };
> +
> +                port@5 {
> +                    reg = <5>;
> +                    phy-mode = "rgmii-id";
> +                    tx-internal-delay-ps = <2000>;
> +                    rx-internal-delay-ps = <2000>;
> +                    ethernet = <&eth0>;
> +
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                    };
> +                };
> +            };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                switchphy0: switchphy@0 {
> +                    reg = <0>;
> +
> +                    leds {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        led@0 {
> +                            reg = <0>;
> +                            color = <LED_COLOR_ID_GREEN>;
> +                            function = LED_FUNCTION_LAN;
> +                        };
> +                    };
> +                };
> +
> +                switchphy1: switchphy@1 {
> +                    reg = <1>;
> +
> +                    leds {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        led@0 {
> +                            reg = <0>;
> +                            color = <LED_COLOR_ID_GREEN>;
> +                            function = LED_FUNCTION_LAN;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.51.1


