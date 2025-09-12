Return-Path: <linux-kernel+bounces-814845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48176B5594B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD25D7A6256
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E5253B71;
	Fri, 12 Sep 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu/SOl5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5831E5219;
	Fri, 12 Sep 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716555; cv=none; b=Zc/V1Ce0MwzG84ZaptRNzmOScFLonjnwMqV5PjjmcX6xKrsF0nWEpY6t3Xo1ot1FW9RyD50zPImmPFB8i92cG1LaMj11irpLAB78fsj2S2kr6hNQs8OePQFsyX3uXYEbsYboUYhCAhZuFKOAu1NjV6ZxXzgtCEy+M7AanoASsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716555; c=relaxed/simple;
	bh=2CnoRP2z2CLiNDktcdk7xPf8rU6fPu5yFoEfsAQ+Ojs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+Vk/umPUjm2ERGtaz6WJv3H+bWiQlcWxFE8JRLA0/K1CJrtXfroh59463/IzYbuUAwdSAKIcI9/6w56CFx24g+Vxc6AxatVRlOwUMabk37IqBaY3PetaceZMRgo1lh1rkPrbJxlt10oevAO3PumXej2vN3m0z240FwTzKVNvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu/SOl5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB511C4CEF1;
	Fri, 12 Sep 2025 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757716555;
	bh=2CnoRP2z2CLiNDktcdk7xPf8rU6fPu5yFoEfsAQ+Ojs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu/SOl5u4tRtqyhIOiqYNA6XR+OljawU94WoV3xl2KyKukaDgM3hrqX1oeitvy3fe
	 xl5QuU3ysL1uJUsjgCMz1KBdUHW7TrgQc5lE1NRoP7oqzXuicalQzfseXQPZZVv1AW
	 64r5Me63yOJf0e2v9qKH4UHZoXbB9O3QrAOun2q1UvEElh09kY7ryfg8mPjtdplex0
	 Qqy6SZ/6x6jTUcsJzY0SPPCenlwjeCZc+ypWUuk8gpDl0ejgeOwhjvVkxqHpbvraua
	 4EQ6RnAnqNrFmjxjPeF8OAaTvof5TB4h8WptdYxIlSygut+PuL7dgiOheOYXmRnVyG
	 ZANYc3XlgMgaA==
Date: Fri, 12 Sep 2025 17:35:54 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Ian Ray <ian.ray@ge.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: display: bridge: convert
 megachips-stdpxxxx-ge-b850v3-fw.txt to yaml
Message-ID: <20250912223554.GA1536924-robh@kernel.org>
References: <20250912181419.1114695-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912181419.1114695-1-Frank.Li@nxp.com>

On Fri, Sep 12, 2025 at 02:14:18PM -0400, Frank Li wrote:
> Convert megachips-stdpxxxx-ge-b850v3-fw.txt to yaml format.
> 
> Additional changes:
> - Only keep one example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../megachips,stdp2690-ge-b850v3-fw.yaml      | 105 ++++++++++++++++++
>  .../megachips-stdpxxxx-ge-b850v3-fw.txt       |  91 ---------------
>  2 files changed, 105 insertions(+), 91 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml b/Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
> new file mode 100644
> index 0000000000000..6b5cfc41f7414
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GE B850v3 video bridge
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +   STDP4028-ge-b850v3-fw bridges (LVDS-DP)
> +   STDP2690-ge-b850v3-fw bridges (DP-DP++)
> +
> +   The video processing pipeline on the second output on the GE B850v3:
> +
> +   Host -> LVDS|--(STDP4028)--|DP -> DP|--(STDP2690)--|DP++ -> Video output
> +
> +   Each bridge has a dedicated flash containing firmware for supporting the custom
> +   design. The result is that, in this design, neither the STDP4028 nor the
> +   STDP2690 behave as the stock bridges would. The compatible strings include the
> +   suffix "-ge-b850v3-fw" to make it clear that the driver is for the bridges with
> +   the firmware specific for the GE B850v3.
> +
> +   The hardware do not provide control over the video processing pipeline, as the
> +   two bridges behaves as a single one. The only interfaces exposed by the
> +   hardware are EDID, HPD, and interrupts.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - megachips,stdp4028-ge-b850v3-fw
> +      - megachips,stdp2690-ge-b850v3-fw
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port

Need to state this is the input port.

> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port

And this is the output.

Aren't both required as well?

> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: megachips,stdp4028-ge-b850v3-fw
> +    then:
> +      required:
> +        - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bridge@73 {
> +            compatible = "megachips,stdp4028-ge-b850v3-fw";
> +            reg = <0x73>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +
> +                    endpoint {
> +                        remote-endpoint = <&lvds0_out>;
> +                    };
> +
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +
> +                    endpoint {
> +                        remote-endpoint = <&stdp2690_in>;
> +                    };
> +               };
> +            };
> +        };
> +    };
> +

