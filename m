Return-Path: <linux-kernel+bounces-726554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DEB00EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B981888D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF29D295D99;
	Thu, 10 Jul 2025 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa6aYs06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5814884C;
	Thu, 10 Jul 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185939; cv=none; b=qdAQfclRTh9qlMz8uWPAJmGP8LdcLQ5pM33biX/pU3+tnAIGo/ItjRWIalR3SMeyOtwzCA3C8SGS7e2A8+wsOvKOiOLEFAGIGiNYfrV4/TNbxltfLHy/0FD9aZfttD51x6LktjUHC0XDNQreQTAXfglDJkcwuZQqLvhCQOZkAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185939; c=relaxed/simple;
	bh=RxVBwyXBv5LWziR/6/tS4iFFqMsUTBajjCGOPP5GU5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPwsIVBDk+ghHYHsbZtaz3Ui+S8jeC295atNC075tlAphWQkFAwYlsOyyX4QaQfcnDH0lnI438LeOM8SxKy0OrP+unb43uqeCPtnUpLHH1nz6bvrZpVyBIQTfMHc2m1gJQHIhdaSKzzRqlnmcAumBsBwLpTpk6K5BQkneigsvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa6aYs06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B35C4CEE3;
	Thu, 10 Jul 2025 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185938;
	bh=RxVBwyXBv5LWziR/6/tS4iFFqMsUTBajjCGOPP5GU5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa6aYs06ohrcMbMTOjTn2wKTdl/OLauQ6W1uuk6tcOhc/BzKbdCpMfuwzcJbPXGvz
	 P70J1etQPpq76UkNWWKPVIKYg259eOEdLiuqqWDn+teo3D1j2qLpziXm0g6CxYO+j2
	 Oli1odsGQatjX0+3xt5fsJdbkCJ66eIUc4IXqQQzxgMvDcjlOOYk5s+01tosaHUdCO
	 6WpwAhy3v6gZ3+L6vzB8RqjQ6a0K//jzWxb1pK/GwQnO1+5hYNtW0f+bWjQGtu2SV8
	 Ee1Zzmar2RDnXFfwBe9NrKV0nkjJM7CT2+1yBqlZAHLBsmYejYBfWfHGkHcZieUkkP
	 zA/U6VhCqVUeQ==
Date: Thu, 10 Jul 2025 17:18:55 -0500
From: Rob Herring <robh@kernel.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: display: imx: Add bindings for i.MX94
 DCIF
Message-ID: <20250710221855.GA4126646-robh@kernel.org>
References: <20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com>
 <20250709122332.2874632-6-laurentiu.palcu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709122332.2874632-6-laurentiu.palcu@oss.nxp.com>

On Wed, Jul 09, 2025 at 03:23:24PM +0300, Laurentiu Palcu wrote:
> DCIF is the i.MX94 Display Controller Interface which is used to
> drive a TFT LCD panel or connects to a display interface depending
> on the chip configuration.

Drop 'bindings for' in the subject. You already said 'bindings' once.

> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  .../bindings/display/imx/nxp,imx94-dcif.yaml  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> new file mode 100644
> index 0000000000000..e4cab43c77ebc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/imx/nxp,imx94-dcif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX94 Display Control Interface (DCIF)
> +
> +maintainers:
> +  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> +
> +description:
> +  The Display Control Interface(DCIF) is a system master that fetches graphics
> +  stored in memory and displays them on a TFT LCD panel or connects to a
> +  display interface depending on the chip configuration.
> +
> +properties:
> +  compatible:
> +    const: nxp,imx94-dcif
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description:
> +          Interrupt output for CPU domain 0 (controlled by common registers group).
> +      - description:
> +          Interrupt output for CPU domain 1 (controlled by background layer registers group).
> +      - description:
> +          Interrupt output for CPU domain 2 (controlled by foreground layer registers group).
> +
> +  interrupt-names:
> +    items:
> +      - const: common
> +      - const: bg_layer
> +      - const: fg_layer
> +
> +  clocks:
> +    items:
> +      - description: APB bus clock
> +      - description: AXI bus clock
> +      - description: Pixel clock
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: axi
> +      - const: pix
> +
> +  assigned-clocks:
> +    description: Reference to DISPLAYMIX CSR clock mux.
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    description: Parent of the clock mux.
> +    maxItems: 1

You don't have to document assigned-clocks. Allowed anywhere with 
'clocks'.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  nxp,blk-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: A phandle which points to NXP displaymix blk-ctrl.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: Display Pixel Interface(DPI) output port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        display-controller@4b120000 {
> +            compatible = "nxp,imx94-dcif";
> +            reg = <0x0 0x4b120000 0x0 0x300000>;
> +            interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "common", "bg_layer", "fg_layer";
> +            clocks = <&scmi_clk 69>, <&scmi_clk 70>, <&dispmix_csr 0>;
> +            clock-names = "apb", "axi", "pix";
> +            assigned-clocks = <&dispmix_csr 0>;
> +            assigned-clock-parents = <&ldb_pll_pixel>;
> +            power-domains = <&scmi_devpd 11>;
> +            nxp,blk-ctrl = <&dispmix_csr>;
> +
> +            port {
> +                dcif_out: endpoint {
> +                    remote-endpoint = <&ldb_in>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.46.1
> 

