Return-Path: <linux-kernel+bounces-738481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08240B0B8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F683B7832
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94421D3FB;
	Sun, 20 Jul 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SACH0dhn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7505173;
	Sun, 20 Jul 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753051972; cv=none; b=FS5SCNw7l+0SLmdQ6h7NPYX3pJOorRkwQE5bPVnXH1UfPCuq2RwPFa9+jmpRTiTqef+wmIkYGJ5W2PyX2F7psGunfOobOObk/ePXh/LTeNL8vCUFrhabpIKsFUpv7bv4A5dn80PI/zOzrcVw2lKJWfhfIWe0IYslYBmJzsTSSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753051972; c=relaxed/simple;
	bh=69EFAAHfaG2pfc1QkZ0KW3szZY+hPcbifoyUatFEqFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp6fKNZlTMySe9LhO++B/gB+Ptc/5z+aBXESFKRnUtxW0Rcyshikbtm6QGq/bokTn/iu/w2fTumWDfPfzdSW1SSXXf86K9BcUBNNe4/dAGXd7vsjQtiD+DWXLkNq5V+1bS+4U3TXEadJ+LgVzk2ihKO6QJlvmKCiPtMMvDmpQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SACH0dhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D939C4CEE7;
	Sun, 20 Jul 2025 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753051972;
	bh=69EFAAHfaG2pfc1QkZ0KW3szZY+hPcbifoyUatFEqFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SACH0dhntm3asf6vjiFhYqOVT8TlUpDC1YIJ4Y/oUit1p6d3TCqfdEs/40IseTdn7
	 Is/SnqaK3cfP/7TRjcaVaVdg7GlGWGX14b3WUtTmgcFmmciAS7rkNWGWzstlas47aU
	 5BhtdXuYBl7vVaAeSyGD8hr1Xj7AspsN7giSdQGRZLw3Rh6Ufr6LpLa0qy07BiBLyE
	 SA6njqRTHGPhBdDWHQMxxYZABxX/XSQWDtfJFq2MLftv/NHLjUcg+ARJPcBrdMRdU5
	 6a+THdqXUng2kCSSQFaTfivd2x+8NjuxPCj1AWpjottL7CsE2rR6SfDLaMUhTofDFi
	 4n66Sg/hARtdw==
Date: Sun, 20 Jul 2025 17:52:51 -0500
From: Rob Herring <robh@kernel.org>
To: Joseph Guo <qijian.guo@nxp.com>
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
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	victor.liu@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: Add waveshare DSI2DPI
 unit support
Message-ID: <20250720225251.GA2952017-robh@kernel.org>
References: <20250716-waveshare-v1-0-81cb03fb25a3@nxp.com>
 <20250716-waveshare-v1-1-81cb03fb25a3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-waveshare-v1-1-81cb03fb25a3@nxp.com>

On Wed, Jul 16, 2025 at 04:08:29PM +0900, Joseph Guo wrote:
> Add dt-binding documentation for waveshare DSI2DPI unit
> 
> Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
> ---
>  .../bindings/display/bridge/waveshare,dsi2dpi.yaml | 103 +++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..678922ebe138ec2fa7bd05902947a86ec73fc644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/waveshare,dsi2dpi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Waveshare MIPI-DSI to DPI Converter bridge
> +
> +maintainers:
> +  - Joseph Guo <qijian.guo@nxp.com>
> +
> +description:
> +  Waveshare bridge board is part of Waveshare panel which converts DSI to DPI.
> +
> +properties:
> +  compatible:
> +    const: waveshare,dsi2dpi
> +
> +  reg:
> +    maxItems: 1
> +    description: base I2C address of the device
> +
> +  power-supply: true
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description:
> +          Video port for MIPI DSI input
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                description: array of physical DSI data lane indexes.
> +                items:
> +                  - const: 1
> +                  - const: 2
> +
> +            required:
> +              - data-lanes
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Video port for MIPI DPI output panel.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +  - power-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    i2c0 {

i2c {

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

