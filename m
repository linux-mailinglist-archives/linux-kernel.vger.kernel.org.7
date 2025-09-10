Return-Path: <linux-kernel+bounces-810436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CCEB51A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894D6B61056
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78B32C33B;
	Wed, 10 Sep 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN0wJOtD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BD32C33D;
	Wed, 10 Sep 2025 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515720; cv=none; b=ShG2wkfMPf7IR5rayU8Omh6UYAwU0JfHExCCAZR2/J2TDxzQz+daITRzInc4Rmd5qFT3JqpR4MPmG7HAE8v8KyTm4Im3RllqHyl2v+RdgF38hdH8By/JVmqE606WKgeZUchEP0fRy/fjgGDt/MGFWFNjsCRLNK4EyNhwwky4fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515720; c=relaxed/simple;
	bh=YlY//Pvz8+fMkbtb+RnIB4jbU50kH014LcVifhtNo2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr8EBXT8dspMPMMTORVXWcI78b84bRJMceN6i4rrmr8ymn118nqEnsWSyRIzTpkv7fo69sMhP/MEHhC6mSVcoqhwuKBfrS106N0qOO7p4LReXxQ/qhzutZE5syDHYEi19xw3NyHRdcpxS6Dza2/CUAKWwHio+agO32pQokjrSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN0wJOtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607FFC4CEF7;
	Wed, 10 Sep 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515719;
	bh=YlY//Pvz8+fMkbtb+RnIB4jbU50kH014LcVifhtNo2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dN0wJOtDOVFSWz3OD3pu1qROLgPzvE1lQ4NFgkhOwW0BXocTJajpVUlj37ka45TOI
	 d5JGpAxX43CCT1KuHn9YxPJNbmVfqR2tmf6WKjLdgLvQqauln+6jNDmw+oN3Rj28e1
	 oC6UyhzMdvt3/Sd9xH7P8SZtPxXUcyM/w5wFd/kh+V6Ez/eE9nr6rXkmQWZZXZdll9
	 ggegkxc6PqC4hwI5vVRm1xlhqGOclA/5VPzHdkxUcit1CG6PFldqWKUHtzjZWiPpv0
	 l6JnNmy8/PvX4Nur68jo7PO1HmPm2QY7R/CSYK2V4/X8Gh8JJl+t7358fFaiWk6qhE
	 DF9hdiu/FZyHg==
Date: Wed, 10 Sep 2025 09:48:38 -0500
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: document Sharp
 LQ079L1SX01 panel
Message-ID: <20250910144838.GA4169578-robh@kernel.org>
References: <20250909073831.91881-1-clamor95@gmail.com>
 <20250909073831.91881-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909073831.91881-2-clamor95@gmail.com>

On Tue, Sep 09, 2025 at 10:38:30AM +0300, Svyatoslav Ryhel wrote:
> Document Sharp LQ079L1SX01 panel found in Xiaomi Mi Pad.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../display/panel/sharp,lq079l1sx01.yaml      | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> new file mode 100644
> index 000000000000..1dbb4a4bb772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sharp,lq079l1sx01.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sharp,lq079l1sx01.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sharp Microelectronics 7.9" WQXGA TFT LCD panel
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +description:

Needs '>' modifier to maintain paragraph formatting.

> +  This panel requires a dual-channel DSI host to operate and it supports
> +  only left-right split mode, where each channel drives the left or right
> +  half of the screen and only video mode.
> +
> +  Each of the DSI channels controls a separate DSI peripheral.
> +  The peripheral driven by the first link (DSI-LINK1), left one, is
> +  considered the primary peripheral and controls the device.
> +
> +allOf:
> +  - $ref: panel-common-dual.yaml#
> +
> +properties:
> +  compatible:
> +    const: sharp,lq079l1sx01
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: regulator that supplies the analog voltage
> +
> +  vddio-supply:
> +    description: regulator that supplies the I/O voltage
> +
> +  vsp-supply:
> +    description: positive boost supply regulator
> +
> +  vsn-supply:
> +    description: negative boost supply regulator
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  backlight: true
> +  ports: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - vddio-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi0 {

dsi {

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "sharp,lq079l1sx01";
> +            reg = <0>;
> +
> +            reset-gpios = <&gpio 59 GPIO_ACTIVE_LOW>;
> +
> +            avdd-supply = <&avdd_lcd>;
> +            vddio-supply = <&vdd_lcd_io>;
> +            vsp-supply = <&vsp_5v5_lcd>;
> +            vsn-supply = <&vsn_5v5_lcd>;
> +
> +            backlight = <&backlight>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    panel_in0: endpoint {
> +                        remote-endpoint = <&dsi0_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    panel_in1: endpoint {
> +                        remote-endpoint = <&dsi1_out>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> -- 
> 2.48.1
> 

