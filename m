Return-Path: <linux-kernel+bounces-804207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92455B46CD2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB151891264
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7A928B3E2;
	Sat,  6 Sep 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gygq9he6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC4283151;
	Sat,  6 Sep 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757161491; cv=none; b=VSHPB4ApReTGgNl14JMH8x2Lko8xhe4pt0Con675TjX9oUnK4U8ZskouZoxOCZjqx7Htrf6FmADi3wQPHad9k6mSMeTSmuPuLvkeIZG7TF3x1cndMsax/TrG2scLGcLrhCxzwR9jfIDoHeqEvJv5JwgKyl+piX5rwlv9XaMDMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757161491; c=relaxed/simple;
	bh=gJXU2U5xy0/jjw5rCnpX1JJEexVKVcos6FHRn+Gwj+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jA13R2xCfV6QTnhc3Tdgtny0UBIvXOVC282azU0TOcLO5evbKjWmmHud1ItOV72o1QnhoY8rLjrqGotGOvxRIv5n546j2Gl6pmtjs1/MkpBNg/aq+Q180WYM5CSkw+h7aimzuGOFy5/vymskL7P856InUYCMsSHZlMTElvxpvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gygq9he6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685FEC4CEF4;
	Sat,  6 Sep 2025 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757161490;
	bh=gJXU2U5xy0/jjw5rCnpX1JJEexVKVcos6FHRn+Gwj+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gygq9he6QH9d+LK/Z9k8fQWs7bfcFjso2fliKwcuY69Vefj+3cnIrdkbdgI7GF4RM
	 AmaO+6oQ57AuAhMw1GHTkL++PJDMtiffDaNabbOCLlomJdwOmD9OAekYZX46/g2qa2
	 4HSbul4Gt7geP/p52akGIdctjs1ptE8xQDEs6GuEYJI5/2XaTNqS8tqU0sqjUUuChP
	 bNEN28/3tyzxhGMXRkmFrfS3Tf4zJFZZ+2sPVa/H0d5B9+YWXIrfogAdZsxpJvRo+7
	 FPFuwWKnfz8wg90RawQsm6uUolA8j+OANes0GyDW/npcIvzH60B8T2FxZOTomLYDdt
	 wb5Jx5zCsSIow==
Message-ID: <f49b5db9-88b7-4419-90ab-647c048c9ddb@kernel.org>
Date: Sat, 6 Sep 2025 21:24:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: extcon: rt8973a: Convert DT bindings to YAML
To: Artur Weber <aweber.kernel@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250817-rt8973a-dt-bindings-yaml-v1-1-150eb4599dc9@gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20250817-rt8973a-dt-bindings-yaml-v1-1-150eb4599dc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Applied it. Thanks


25. 8. 17. 17:52에 Artur Weber 이(가) 쓴 글:
> Convert the device tree bindings for Richtek RT8973A MUIC to the YAML
> format. No functional changes.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> I've added Chanwoo Choi as the binding maintainer as he is listed
> as the author of the driver for this device; I can change this if
> needed.
> ---
>  .../devicetree/bindings/extcon/extcon-rt8973a.txt  | 23 ----------
>  .../bindings/extcon/richtek,rt8973a-muic.yaml      | 49 ++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt b/Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt
> deleted file mode 100644
> index cfcf455ad4deffc1e4819934e6dc6fb3f95a54a5..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-rt8973a.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -
> -* Richtek RT8973A - Micro USB Switch device
> -
> -The Richtek RT8973A is Micro USB Switch with OVP and I2C interface. The RT8973A
> -is a USB port accessory detector and switch that is optimized to protect low
> -voltage system from abnormal high input voltage (up to 28V) and supports high
> -speed USB operation. Also, RT8973A support 'auto-configuration' mode.
> -If auto-configuration mode is enabled, RT8973A would control internal h/w patch
> -for USB D-/D+ switching.
> -
> -Required properties:
> -- compatible: Should be "richtek,rt8973a-muic"
> -- reg: Specifies the I2C slave address of the MUIC block. It should be 0x14
> -- interrupts: Interrupt specifiers for detection interrupt sources.
> -
> -Example:
> -
> -	rt8973a@14 {
> -		compatible = "richtek,rt8973a-muic";
> -		interrupt-parent = <&gpx1>;
> -		interrupts = <5 0>;
> -		reg = <0x14>;
> -	};
> diff --git a/Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml b/Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f9e0d816c025957e8b96b15bdf478e589e653e90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/richtek,rt8973a-muic.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/richtek,rt8973a-muic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT8973A MUIC
> +
> +maintainers:
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +
> +description:
> +  The Richtek RT8973A is Micro USB Switch with OVP and I2C interface. The RT8973A
> +  is a USB port accessory detector and switch that is optimized to protect low
> +  voltage system from abnormal high input voltage (up to 28V) and supports high
> +  speed USB operation. Also, RT8973A support 'auto-configuration' mode.
> +  If auto-configuration mode is enabled, RT8973A would control internal h/w patch
> +  for USB D-/D+ switching.
> +
> +properties:
> +  compatible:
> +    const: richtek,rt8973a-muic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        usb-switch@14 {
> +          compatible = "richtek,rt8973a-muic";
> +          reg = <0x14>;
> +          interrupt-parent = <&gpio>;
> +          interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> 
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250817-rt8973a-dt-bindings-yaml-46c26fc14ac0
> 
> Best regards,

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


