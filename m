Return-Path: <linux-kernel+bounces-781273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C8B31042
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235BCB602E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7D2E7BDF;
	Fri, 22 Aug 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stzro7uf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C1222587;
	Fri, 22 Aug 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847443; cv=none; b=sQHbYyNOSt8/NylU6MXNjcGCOdsHGgDILk4nXStbYqrQMeFZBbS6XnuA5BZHI3sM+6CIQFJKfj/Z1i1G50BBJyOb64aFIdqhywoF17aVbrBe7exjImNi7NI1FINCnq/q+2dInft2UEk8e1w1BJg+bzSmRyGbtWPzyibWDbDaMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847443; c=relaxed/simple;
	bh=WuDthur/naSlz9x9SdcEfVIvLuh26ZaWEM8NRd6Pykk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khrX5SdHGhTIa/WJFP9EO992NCcte4l38TLaLaJRx5HGGDU+YsPA8+iyRCQRU0sJdhR9cOYDGcoqRMDzZ+uz74Mk4MpYNSKgjJnZkfEqZDGbcp4aN4Fo/POHyW0g/KBuwwDjVJRNTbo31dbj6QR9Rziken9Z4Zj6LIdg+31zQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stzro7uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F5C4CEF4;
	Fri, 22 Aug 2025 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755847443;
	bh=WuDthur/naSlz9x9SdcEfVIvLuh26ZaWEM8NRd6Pykk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Stzro7ufnPBe9angyz46enQdBWHrKwFmd9T/VQcGvILXha1ulT3tW8OKmepm4mWZj
	 1j2TWmF3Sp0JkrV2MAOi3A28voPvdLBM/rw5MP2PZuI59lCJ4tiwEp+XNAxfgX8GYR
	 atgzOKqF4XCDTz3v/K7fqG5c7h3pmYohSBCww0HLHGBXibjeNXehjrJpdqMiKYKcZX
	 pMDWngELOgsdI/k+3H/6z79sqlBxIEKBsE7eE6De905l6ReWId2yH2y8IBJ14WgE2L
	 buLW/+xWUg5qKgc4o3w+xSw1XGi1b1Loe0h8UwFYiyisucKcINC+GvSxK3nHOsdWMY
	 2QIIWsh96WG1Q==
Date: Fri, 22 Aug 2025 09:24:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 02/22] dt-bindings: usb: Add Apple dwc3
Message-ID: <20250822-banana-ferret-of-opposition-0bcfad@kuoka>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-2-172beda182b8@kernel.org>

On Thu, Aug 21, 2025 at 03:38:54PM +0000, Sven Peter wrote:
> +
> +  The common content of the node is defined in snps,dwc3.yaml.

Drop sentence, redundant. Schema tells that.

...

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 2
> +
> +  resets:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +unevaluatedProperties: false

This goes after required.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - iommus
> +  - resets
> +  - power-domains
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    usb@82280000 {
> +      compatible = "apple,t8103-dwc3", "snps,dwc3";
> +      reg = <0x82280000 0x10000>;
> +      interrupts = <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
> +      iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
> +
> +      dr_mode = "otg";
> +      usb-role-switch;
> +      role-switch-default-mode = "host";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45799dfe07de2f54de6d6a1ce0615..0e085cb0762f765958d67be61ae0d3d773503431 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2399,6 +2399,7 @@ F:	Documentation/devicetree/bindings/power/reset/apple,smc-reboot.yaml
>  F:	Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
>  F:	Documentation/devicetree/bindings/spi/apple,spi.yaml
>  F:	Documentation/devicetree/bindings/spmi/apple,spmi.yaml
> +F:	Documentation/devicetree/bindings/usb/apple,dwc3.yaml
>  F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/bluetooth/hci_bcm4377.c
> 
> -- 
> 2.34.1
> 
> 

