Return-Path: <linux-kernel+bounces-653747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3509ABBDE2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817CC3A651D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC842777FB;
	Mon, 19 May 2025 12:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAUBTEVP"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC392749FF
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657920; cv=none; b=bwaCCERINtn5p4/c8xH3mOiGUOuGy6EFAGlVZvXSF6CXt0VPpkuHhjz1J79Q1Iizc+Wy65hqndSGLfIjTiZ+T4P0LtwKjQzFSCXkxEyZlnzQu0JQ5G4zZeYYHPIBDvwUii9yTRuvdNSsgaJKfZH2DkMujPu3G+wDdBArfEUJCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657920; c=relaxed/simple;
	bh=3r5j8ewUTdDD9cAVaQUvMIgt76uz3t6q02hyODKU56A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpPxBdQDRZPYklZaZX1K03O0kqyqa6JwO4fVqFrXnKzXyYfSMRAXPnZP82rDxx0AqPQN2B45QqBu0JabVseSzHYh5+d46IdEu3tmomVuMU3+P6kqmthycp444692w0/pyMS0X9jno3goiXrUst1AD/aPcSZFjVo4ig8slbH2omE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TAUBTEVP; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7b943bcf0cso1241108276.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747657918; x=1748262718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Y4tapDB2lInfWCMbvdtqDDZUxcIGcJpTNFG1RgCRM=;
        b=TAUBTEVPNAtUTnSocO9UXH8p7zkbiPqhzN1PXMbkEhTMWkNAgythz+VL0CTXcJhmbU
         AlzJDSqWtzkgp3WQ9ge6OpyeaW+MChvEQ3mAbdH3wpFXqCbLlprcDtPNUaoUgCZHk2Oz
         SufzhHIhd0dC2BrNjcW8Qme3T0Qzk0fTl/duFp/i5y0c0y9oeGHyCqFP9WZYpTDa3P8n
         sn/vSAZ0kC3yOj6I4QA3Ns0tlOnbwlFcAfT7CfD32eqgbYu7Z9to8KVUdSIj5AACB5q/
         2eeU6VkXA7JNPibFcbl26xBjHl5qdmv4isC6q3R2le3NeDVK/jeheJxW1UgOWrACh9yY
         Dp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657918; x=1748262718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/Y4tapDB2lInfWCMbvdtqDDZUxcIGcJpTNFG1RgCRM=;
        b=JMXFr0IIkZHaWxK02o4JPZDTlC+Uz8P5LvQ5XgTNPMSLyTjDgU6L/y7Cz9iIyjFGBr
         Q3mayxE7IgldkHu7N9H1aybemKsjvyE3Bz0jsepm77CcZAVZQ71q53hNOE/lsl10iSVX
         k5ye8OrGoWWvCZFHhMBCaSZA7P84GCSlEJcj7iA/tc6Wc8kU7aX71WCe2cid5lrOqH2m
         PgeNterPo4dVl6ssWWQH/8mqflhU6eOvstx7xuYUCIj/gbbUgUFVGscVcD4SLi03xdWt
         ezD8GEFBW7tswVuK9kzATj7cqd/tChFomQinS+zf/Ww7qM99Nw+PfCzf4Ux8joLG2ELB
         H9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWd8afDiHvxu9AY5myEHTMZmQg5J8UHjLYSvAUXeWwhW6/EGBiGZlSXscb4xkSxLgvK2USjzXKyabxkRm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1Sknfw1tDD8MMF0hNIozRBQ2XKs8adDZser61bCf6v1Dgt4L
	Jn5u54/NIQXtwedmoEBxRalc4OCx+afAaXIkb+A63OlqtvZZLQKBVY8ORg+g52RsTRhqYCQHdHu
	GfYcF+RkEY5eEJulkEh50wWRp00b3y1c4kEjPT9exPA==
X-Gm-Gg: ASbGnct6E/MysSloMeTpVbivILux2jghpIxs53pIURKJrpUz3KXn7pnIqnPsuu1mJ7u
	JJLk++hTToXRJlOMbyclnbvWA2s6wfWmGEbvlvyVNwWmbrduQrj+e1rDoMqn3D/hzIXc+A9gXwL
	Vq9asJ99PO9OViIfV3jpTuo89PAL/Q5si4Ug==
X-Google-Smtp-Source: AGHT+IEmv/WGUjKBm+/A1/4GEydyk8TOzWy7/Tild6Q46xMQvO171ETGSmplGkezWXGMNntuDWyD2TLLNFfhysgWzEI=
X-Received: by 2002:a05:6902:1547:b0:e7b:9763:6676 with SMTP id
 3f1490d57ef6-e7b97636a60mr5784680276.17.1747657917592; Mon, 19 May 2025
 05:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-mchp-sdhci-v1-0-ed29de05295a@gmail.com> <20250507-mchp-sdhci-v1-2-ed29de05295a@gmail.com>
In-Reply-To: <20250507-mchp-sdhci-v1-2-ed29de05295a@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:31:21 +0200
X-Gm-Features: AX0GCFuWDdcxOPuDxhAtLQnUgrmqueC7zHJtPdPiN6hagUd_-Xv9el2wmRphFWc
Message-ID: <CAPDyKFqPhxOfzZOYuF_yG9TyUx0FQ7p=TE8krSdLkM7AjOmp_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-binding: mmc: microchip,sdhci-pic32: convert text
 based binding to json schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 08:32, Charan Pedumuru <charan.pedumuru@gmail.com> wrote:
>
> Update text binding to YAML.
> Changes during conversion:
> Add appropriate include statements for interrupts and clock-names
> to resolve errors identified by `dt_binding_check` and `dtbs_check`.
>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

Applied for next, thanks!

Note that, I leave patch1 for SoC maintainers to pick up, thanks!

Kind regards
Uffe



> ---
>  .../bindings/mmc/microchip,sdhci-pic32.txt         | 29 ----------
>  .../bindings/mmc/microchip,sdhci-pic32.yaml        | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> deleted file mode 100644
> index f064528effed31f30d1d1c6e0b49c02e215d99af..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -* Microchip PIC32 SDHCI Controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-pic32 driver.
> -
> -Required properties:
> -- compatible: Should be "microchip,pic32mzda-sdhci"
> -- interrupts: Should contain interrupt
> -- clock-names: Should be "base_clk", "sys_clk".
> -               See: Documentation/devicetree/bindings/resource-names.txt
> -- clocks: Phandle to the clock.
> -          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
> -- pinctrl-names: A pinctrl state names "default" must be defined.
> -- pinctrl-0: Phandle referencing pin configuration of the SDHCI controller.
> -             See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> -
> -Example:
> -
> -       sdhci@1f8ec000 {
> -               compatible = "microchip,pic32mzda-sdhci";
> -               reg = <0x1f8ec000 0x100>;
> -               interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&rootclk REF4CLK>, <&rootclk PB5CLK>;
> -               clock-names = "base_clk", "sys_clk";
> -               bus-width = <4>;
> -               cap-sd-highspeed;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&pinctrl_sdhc1>;
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.yaml b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca0ca7df9ee991d8402bc4c62b1235ef5db2e85f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/microchip,sdhci-pic32.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PIC32 SDHI Controller
> +
> +description:
> +  The Microchip PIC32 family of microcontrollers (MCUs) includes models with
> +  Secure Digital Host Controller Interface (SDHCI) controllers, allowing them
> +  to interface with Secure Digital (SD) cards. This interface is used for reading,
> +  writing, and managing data on SD cards, enabling storage and data transfer
> +  capabilities in embedded systems.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: microchip,pic32mzda-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: base_clk
> +      - const: sys_clk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/microchip,pic32-clock.h>
> +    mmc@1f8ec000 {
> +        compatible = "microchip,pic32mzda-sdhci";
> +        reg = <0x1f8ec000 0x100>;
> +        interrupts = <191 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&rootclk REF4CLK>, <&rootclk PB5CLK>;
> +        clock-names = "base_clk", "sys_clk";
> +        bus-width = <4>;
> +        cap-sd-highspeed;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_sdhc1>;
> +    };
> +...
>
> --
> 2.43.0
>

