Return-Path: <linux-kernel+bounces-815960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6DAB56D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504221773DE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DC1C84C0;
	Mon, 15 Sep 2025 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvlOtZTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D445288D2;
	Mon, 15 Sep 2025 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757896765; cv=none; b=sj9qHCHmjVscF5h4Ofj4V65HunFe7+9RCe3h4EhD+ppEhJSVVE7RE+l64Qh9V8YWdm33z0EawhDgDsX6KQGH9kePFwt+olDKOu+3NVxC9tvRY0fIdyk2hIPke6W9LjE+6oxeip4oNVZw4jVsKq5/Jja5Z2gJyhwkuWiUQJzXVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757896765; c=relaxed/simple;
	bh=vDxmUu7YJlQgVbF88x8fTIcNgzFy6exjw8d6QlvDjNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8m69KJ0qAB0rTJueHQH52jPVhcaHiT3JjHJO499aoEpHOql3f96IU9bRbKvMPXevkvRhxpXNeidcOEgfgBe9dfAU4FopZMeoVJMakzQyqviGQEBN1usQ895igEY/+7eTYXR6lI+jeJzAgssker74oOKC5zoENSv62ae2ZZq7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvlOtZTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFDBC4CEF0;
	Mon, 15 Sep 2025 00:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757896764;
	bh=vDxmUu7YJlQgVbF88x8fTIcNgzFy6exjw8d6QlvDjNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rvlOtZTuBn0PODzXNM327Z8d8TnEu0ZpwbDWDh3SZGa/WHvx0pU5yuSw9K8eEFirt
	 ODmnsYgjsbFcbUFCUz3bupVb4Af0On5PirAd7LIvrFjmojuDHMAXt8KSlsfEjhLqEM
	 VMlEGN3d48PpuyGiySUbvz6sj9QQx/h3Aca3AbbgPlh1ct7d70h8TVaVRvYUnJcU/s
	 sdCxuhwrxk7LCSkY7evmGtv0HLoGdNtVM2cHN3NTI/h0Z6lsR/togxYouk6fxRyPfS
	 vHOR5urm4fKSdZoSzYtA/I0hewozcqRfwFKNwhkAY3vU+h7vkaTMHr1Uc4gTiOWJvd
	 PPUA53yDQ8RyQ==
Date: Sun, 14 Sep 2025 19:39:23 -0500
From: Rob Herring <robh@kernel.org>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	David Heidelberg <david@ixit.cz>,
	Amir Dahan <system64fumo@protonmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Add devicetree
 documentation for lg,sw49410
Message-ID: <20250915003923.GA2318579-robh@kernel.org>
References: <20250910-judyln-panel-v1-0-825c74403bbb@postmarketos.org>
 <20250910-judyln-panel-v1-2-825c74403bbb@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-judyln-panel-v1-2-825c74403bbb@postmarketos.org>

On Wed, Sep 10, 2025 at 08:08:21PM -0700, Paul Sajna wrote:
> Document how to use lg,sw49410 in a devicetree
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  .../bindings/display/panel/lg,sw49410.yaml         | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)

Looks like you can just add the compatible to panel-simple.yaml. All the 
properties here are valid for it. And whether you use the simple driver 
or not doesn't matter.

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7e0db98687d9cfc4da7137e8781752e1401d5ed7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,sw49410.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG SW49410 MIPI-DSI panels
> +
> +maintainers:
> +  - Paul Sajna <hello@paulsajna.com>
> +
> +description:
> +  LG SW49410 6.1" 1440x3120  panel found in LG G7 ThinQ smartphone.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: lg,sw49410
> +
> +  reg:
> +    maxItems: 1
> +
> +  backlight:
> +    description: Backlight device reference
> +
> +  reset-gpios:
> +    description: Reset pin reference
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        display_panel: panel@0 {
> +            reg = <0>;
> +            compatible = "lg,sw49410";
> +
> +            backlight = <&pmi8998_wled>;
> +            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +
> +            pinctrl-names = "default", "sleep";
> +            pinctrl-0 = <&sde_dsi_active &sde_te_active>;
> +            pinctrl-1 = <&sde_dsi_sleep &sde_te_sleep>;
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&mdss_dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +...
> 
> -- 
> 2.51.0
> 

