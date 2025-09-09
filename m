Return-Path: <linux-kernel+bounces-808721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98420B503FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9725E7D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF7362072;
	Tue,  9 Sep 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUPs6TMA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB125C804;
	Tue,  9 Sep 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437482; cv=none; b=qNHmNUxdMLMPUHnphC3KSLeNMG7Cf6SRAQawNftXDE+OqNV9v5+4L6oiYwLpaNNO4wYYt41+hz6UCDQpP8aLIyhZlOCwSzpIL/pmitMOOz7duxPwJW91t4Zl80h1sh97cnDH+JyyVi4PLqG+MyByV3kZJQ0L7S3jjliJdVVTt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437482; c=relaxed/simple;
	bh=1Rd9o6WpxdFjdYOqLhQLHzTPUyEZ/qZjJs+LfJAwKOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT8gYUOmUBxyTBTTMx4no5GBXVtKhJjD/enDQriiOr7lNeMpBGTOu8nD645sNi57xF2eTJ7uiQ8oNzzHQAvia/IzImD4IBnGSvsesC15oJ2TaaP1fh8BU/fTx/LTs0T29PXJx2zFrcH6J0sdkrn8xl0kpcYi6cGewR7izZt3C+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUPs6TMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53DEC4CEF4;
	Tue,  9 Sep 2025 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757437482;
	bh=1Rd9o6WpxdFjdYOqLhQLHzTPUyEZ/qZjJs+LfJAwKOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUPs6TMATyIsWv6eZBfXU7qjW1nEZmICjT6oS3/xu7zFuKp8OcsoeErMoi07Z2RCI
	 oPUCzCXj0E1rmAfcOUJX7Fhz3e18+/ouV0NrfSZFlClTWj92UxKW3sENkvB2epdKnu
	 45nGcuV3mGiHPK0AdR72XnrIx4mEY2vQgTCtr0t6cq65oxgtYIjY75RRDQlQ3/paqt
	 RXYCQ5jQ7MfQ65NIuO9EBiWi48jZCEQqF3CaBU3uBPGJJKeXEyVMUj7q/wIQk9vJcN
	 kVcUJdgoenXFGcaqzIwqRXWHSlReJ4LTsEgzx1wcYQu38gC7zP975f1OtGsytT1WR5
	 uJ5qWE2zpZsww==
Date: Tue, 9 Sep 2025 12:04:40 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 16/22] dt-bindings: phy: Add Apple Type-C PHY
Message-ID: <20250909170440.GA3343344-robh@kernel.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-16-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-16-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:29PM +0000, Sven Peter wrote:
> Apple's Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
> USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon
> SoCs.
> 
> The PHY handles muxing between these different protocols and also provides
> the reset controller for the attached dwc3 USB controller.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  .../devicetree/bindings/phy/apple,atcphy.yaml      | 213 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 214 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/apple,atcphy.yaml b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..a863fe3a8f6d80a113e495e8425775c91e4cd10c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/apple,atcphy.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/apple,atcphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Type-C PHY (ATCPHY)
> +
> +maintainers:
> +  - Sven Peter <sven@kernel.org>
> +
> +description:

Add '>' to to maintain paragraph formatting.

> +  The Apple Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
> +  USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon SoCs.
> +
> +  The PHY handles muxing between these different protocols and also provides the
> +  reset controller for the attached DWC3 USB controller.
> +
> +  The PHY is designed for USB4 operation and does not handle individual
> +  differential pairs as distinct DisplayPort lanes. Any reference to lane in
> +  this binding hence refers to two differential pairs (RX and TX) as used in USB
> +  terminology.
> +
> +allOf:
> +  - $ref: /schemas/usb/usb-switch.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apple,t6000-atcphy
> +              - apple,t6020-atcphy
> +              - apple,t8112-atcphy
> +          - const: apple,t8103-atcphy
> +      - const: apple,t8103-atcphy
> +
> +  reg:
> +    items:
> +      - description: Common controls for all PHYs (USB2/3/4, DisplayPort, Thunderbolt)
> +      - description: DisplayPort Alternate Mode PHY specific controls
> +      - description: AXI to Apple Fabric interconnect controls, only modified by tunables
> +      - description: USB2 PHY specific controls
> +      - description: USB3 PIPE interface controls
> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: lpdptx
> +      - const: axi2af
> +      - const: usb2phy
> +      - const: pipehandler
> +
> +  "#phy-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 0
> +
> +  mode-switch: true
> +  orientation-switch: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Output endpoint of the PHY to the Type-C connector

SS port of the connector?

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Incoming endpoint from the USB3 controller
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Incoming endpoint from the DisplayPort controller
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Incoming endpoint from the USB4/Thunderbolt controller
> +
> +  apple,tunable-axi2af:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      AXI2AF tunables.
> +
> +      This array is filled with 3-tuples each containing three 32-bit values
> +      <register offset>, <mask>, and <value> by the bootloader.

That sounds like a 3xN matrix. Use uint32-matrix type.

blank line between paragraphs and use '>' modifier.

> +      The driver will use these to configure the PHY by reading from each
> +      register, ANDing it with <mask>, ORing it with <value>, and storing the
> +      result back to the register.
> +      These values slightly differ even between different chips of the same
> +      generation and are likely calibration values determined by Apple at
> +      manufacturing time.

This could be worded more simply. The first part sounds like fixed for a 
given SoC, but from manufacturing time setting I gather these vary even 
for a single product/device.

I gather all this is being copied out of Apple FW?

> +
> +  apple,tunable-common:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Common tunables required for all modes, see apple,tunable-axi2af for details.
> +
> +  apple,tunable-fuses:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Fuse based tunables required for all modes, see apple,tunable-axi2af for details.
> +
> +  apple,tunable-lane0-usb:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      USB tunables on lane 0, see apple,tunable-axi2af for details.
> +
> +  apple,tunable-lane1-usb:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      USB tunables on lane 1, see apple,tunable-axi2af for details.
> +
> +  apple,tunable-lane0-cio:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      USB4/Thunderbolt ("converged IO") tunables on lane 0, see apple,tunable-axi2af for details.

Wrap lines at 80 char.

> +
> +  apple,tunable-lane1-cio:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      USB4/Thunderbolt ("converged IO") tunables on lane 1, see apple,tunable-axi2af for details.
> +
> +  apple,tunable-lane0-dp:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      DisplayPort tunables on lane 0, see apple,tunable-axi2af for details.
> +
> +      Note that lane here refers to a USB RX and TX pair re-used for DisplayPort
> +      and not to an individual DisplayPort differential lane.
> +
> +  apple,tunable-lane1-dp:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      DisplayPort tunables on lane 1, see apple,tunable-axi2af for details.
> +
> +      Note that lane here refers to a USB RX and TX pair re-used for DisplayPort
> +      and not to an individual DisplayPort differential lane.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#phy-cells"
> +  - "#reset-cells"
> +  - orientation-switch
> +  - mode-switch
> +  - power-domains
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy@83000000 {
> +      compatible = "apple,t8103-atcphy";
> +      reg = <0x83000000 0x4c000>,
> +            <0x83050000 0x8000>,
> +            <0x80000000 0x4000>,
> +            <0x82a90000 0x4000>,
> +            <0x82a84000 0x4000>;
> +      reg-names = "core", "lpdptx", "axi2af", "usb2phy",
> +                  "pipehandler";
> +
> +      #phy-cells = <1>;
> +      #reset-cells = <0>;
> +
> +      orientation-switch;
> +      mode-switch;
> +      power-domains = <&ps_atc0_usb>;
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +
> +          endpoint {
> +            remote-endpoint = <&typec_connector_ss>;
> +          };
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +
> +          endpoint {
> +            remote-endpoint = <&dwc3_ss_out>;
> +          };
> +        };
> +
> +        port@2 {
> +          reg = <2>;
> +
> +          endpoint {
> +            remote-endpoint = <&dcp_dp_out>;
> +          };
> +        };
> +
> +        port@3 {
> +          reg = <3>;
> +
> +          endpoint {
> +            remote-endpoint = <&acio_tbt_out>;
> +          };
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e147e1b919d5737a34e684ec587872ce591c641a..c4cbae63b0c0d42042e12d366e4a32d7ca3711ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2393,6 +2393,7 @@ F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>  F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
>  F:	Documentation/devicetree/bindings/nvmem/apple,spmi-nvmem.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +F:	Documentation/devicetree/bindings/phy/apple,atcphy.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	Documentation/devicetree/bindings/power/apple*
>  F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
> 
> -- 
> 2.34.1
> 
> 

