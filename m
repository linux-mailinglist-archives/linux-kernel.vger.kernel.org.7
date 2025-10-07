Return-Path: <linux-kernel+bounces-843650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0422BBFEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BD964EDEAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8751FBEB0;
	Tue,  7 Oct 2025 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvH0Po/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B01F4C92;
	Tue,  7 Oct 2025 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799811; cv=none; b=fkVZxYO7x6r/9PcqgvB6XlAJocybRe1gXT/HYwzbx2TS6xyn4vGMG4gwzNRryYd82oRqxOrSYh7FU8w81A0fmzYpzc2m068e1iOi1okr1chv8H6qzsZ/unl/rUVt25I6IMTyVnJS/yRVyWynuNTPmGlvugQ7vGomjbhTKFU+ChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799811; c=relaxed/simple;
	bh=VkYVtLFgQexQtimeL6NDgPce5j2dOZq1WRCxOFF/sYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDkLmCtvXW3qyV9Onhs3mO+4oEravBZA0wDn97v4yIg7nsFnOS7X1/yx0Ju6AmpE5mFhPlDvtITQJKsHC2gX2chJfyGCdQe1R8XMYjX0s7fYwXT5Y671tvgCSljr4al5OiT+/77n9cGDJ9aS3gUN0iX/nXaaFXRWYa+M6s39Y8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvH0Po/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E3BC4CEFF;
	Tue,  7 Oct 2025 01:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759799810;
	bh=VkYVtLFgQexQtimeL6NDgPce5j2dOZq1WRCxOFF/sYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvH0Po/++UegnyFFL583yXrXD7wUBY1ICMvd/rBNHzMWAq0U8K1wJqrWbvPoNCJhh
	 KXM0kuD+pCG+M92ZdcogrD4PrKSPAYrerddUW4DaWD1uN6ukrjIKk/kQ4SyHw98oFq
	 EEJZUrPRoLYtpVfA2pbeqJJUQqFoFD8pm9aQ5lvEsHvNlMxMVPFfjC2A0Rnr4zWIqX
	 n/h46PQfqI9JL4zWgeb/Xe6JBE6QT4szIfKJ2pgYrK6ueMtHgcuNsyfpe3NlUM3elR
	 DBH3K/mC2t3ozVA8GIbRXGKwYbDaMq6z7uGeaNPrwAu2Wmhc14MlixdY607J77W5J9
	 bMRzox0shQ4sQ==
Date: Mon, 6 Oct 2025 20:16:49 -0500
From: Rob Herring <robh@kernel.org>
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com,
	airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	dianders@chromium.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Add Tianma
 TL121BVMS07-00 panel
Message-ID: <20251007011649.GA706748-robh@kernel.org>
References: <20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com>
 <20250930075044.1368134-2-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930075044.1368134-2-yelangyan@huaqin.corp-partner.google.com>

On Tue, Sep 30, 2025 at 03:50:43PM +0800, Langyan Ye wrote:
> Add device tree bindings for the Tianma TL121BVMS07-00 12.1"
> MIPI-DSI TFT LCD panel.
> 
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  .../display/panel/tianma,tl121bvms07-00.yaml  | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml b/Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml
> new file mode 100644
> index 000000000000..e654b86782e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/tianma,tl121bvms07-00.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tianma TL121BVMS07-00 12.1" MIPI-DSI TFT LCD Panel
> +
> +maintainers:
> +  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> +
> +description: |

Don't need '|' if no formatting to preserve.

> +  The Tianma TL121BVMS07-00 is a 12.1-inch MIPI-DSI TFT LCD panel.
> +  It requires multiple regulators (AVDD, AVEE, and 1.8V logic)
> +  and an enable GPIO. Optional properties such as backlight and
> +  rotation are inherited from panel-common.yaml.

Wrap lines at 80 char. The last sentence can be dropped as it says what 
the schema do.

> +
> +allOf:
> +  - $ref: panel-common.yaml#


> +
> +properties:
> +  compatible:
> +    const: tianma,tl121bvms07-00
> +
> +  reg:
> +    description: DSI virtual channel number
> +    minimum: 0
> +    maximum: 3

Just 'reg: true'. dsi-controller.yaml already has these constraints.


> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: GPIO specifier for the enable pin
> +
> +  avdd-supply:
> +    description: phandle of the regulator that provides positive voltage
> +
> +  avee-supply:
> +    description: phandle of the regulator that provides negative voltage
> +
> +  pp1800-supply:
> +    description: core voltage supply
> +
> +  backlight:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Already has a type in panel-common.yaml. Drop.

> +    description: Phandle to the backlight device.
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: Input port of the panel, connected to the DSI host.

Already in panel-common.yaml.

Either just 'true' for both of these or drop and use 
'unevaluatedProperties' instead of 'additionalProperties'.

> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - avdd-supply
> +  - avee-supply
> +  - pp1800-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi0 {

dsi {

> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      mipi_panel: panel@0 {

drop unused labels.

> +        compatible = "tianma,tl121bvms07-00";
> +        reg = <0>;
> +        enable-gpios = <&pio 25 0>;
> +        avdd-supply = <&en_pp5800_mipi_disp>;
> +        avee-supply = <&en_pp5800_mipi_disp>;
> +        pp1800-supply = <&mt6359_vcn18_ldo_reg>;
> +        backlight = <&backlight>;
> +
> +        port {
> +          panel_in: endpoint {
> +            remote-endpoint = <&dsi_out>;
> +          };
> +        };
> +      };
> +    };
> +
> +...
> -- 
> 2.34.1
> 

