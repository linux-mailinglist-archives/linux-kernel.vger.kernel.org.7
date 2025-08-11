Return-Path: <linux-kernel+bounces-761999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EE9B200EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4264A1896249
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B675A2D9ED1;
	Mon, 11 Aug 2025 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqY+U/0g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6C142E83;
	Mon, 11 Aug 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898905; cv=none; b=umvtjNEs6FA5XoCkK3LYzsmnJtZ/QonOk297u+xpsGIV/97SFe0tZdonpTH3tLMIUFHgbROnpMd1nPPok2gmz/OZA1c3ccgQMBMP7A8DpUiACBI/InxtnbzzuvrITvOKMX/KB6IVSJAQPiipuYoPo8h8Q6+zhnmNGAWYuJGJQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898905; c=relaxed/simple;
	bh=T6S5RGpXvEebt20lVpqzNu6jotmv7zyrpQ5ocjd9L10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8PljFc7A5jQ60LO0T/cqgMyjwRryaGVe+Zva0ZYnGeqkXmVtOI31CFtQjtwoX2P5p/94+qlrl39dAX100dx/9dtNLSnIZnsifi3GdAXdHr89oLGZQK8UpxZE2Pik9teZS8Gh8l4kKMIZapeX42ShOvvgPA4qfhu1IlFkIfngk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqY+U/0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C6DC4CEED;
	Mon, 11 Aug 2025 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754898904;
	bh=T6S5RGpXvEebt20lVpqzNu6jotmv7zyrpQ5ocjd9L10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqY+U/0gvevmegRF7Xt5jlEtg6Wcj7bSH1HlacearcGr1diJGXrkNgb+Tc+ThIqFM
	 tfcjQb82VVGZekDiJfDUm9ttU+tdDcHRo+aj3JqP7q9hMt3AZX5l7xAYMN0XQ8q2E0
	 oD5GjOLbrNEzqbHusdNzCYKPbIJFVcwJKgmBiMuxNhMqnWxGUBsI3EFDaBlL847J4H
	 HaKG9WD7FwBHj6kHxCgt/WS9VxsXFu8ZGJ0uFxCgH9tfuYS1mO+meRu0N9+qHaeYli
	 h9tGyIYM6xu9BBeJ6njlwK/z6NwLoHK28Wd47WPQC0y2lngVnYWgSeUjjcV6G5fsIh
	 /jB4j/Rr5VV/A==
Date: Mon, 11 Aug 2025 09:55:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org, 
	alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, broonie@kernel.org, lee@kernel.org, vikash.bansal@nxp.com, 
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: i3c: Add NXP P3H2x4x i3c-hub support
Message-ID: <20250811-bittern-of-abstract-prestige-aaeda9@kuoka>
References: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808132033.3996614-1-aman.kumarpandey@nxp.com>

On Fri, Aug 08, 2025 at 04:20:32PM +0300, Aman Kumar Pandey wrote:
> +        hub@70,236153000c2 {
> +            reg = <0x70 0x236 0x3000c2>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            assigned-address = <0x50>;
> +
> +            cp0-ldo-microvolt = <1800000>;

So you just duplicated regulators?

> +            cp1-ldo-microvolt = <1800000>;
> +            tp0145-ldo-microvolt = <1800000>;
> +            tp2367-ldo-microvolt = <1800000>;
> +            tp0145-pullup-ohm = <1000>;
> +            tp2367-pullup-ohm = <1000>;
> +            cp0-io-strength-ohm = <50>;
> +            cp1-io-strength-ohm = <50>;
> +            tp0145-io-strength-ohm = <50>;
> +            tp2367-io-strength-ohm = <50>;
> +            cp0-supply = <&cp0>;
> +            tp0145-supply = <&tp0145>;
> +
> +            regulators {
> +              cp0 {

Messed indentation

> +                regulator-name = "cp0";
> +                regulator-min-microvolt = <1000000>;
> +                regulator-max-microvolt = <1800000>;
> +              };
> +
> +              cp1 {
> +                regulator-name = "cp1";
> +                regulator-min-microvolt = <1000000>;
> +                regulator-max-microvolt = <1800000>;
> +              };
> +
> +              tp0145 {
> +                regulator-name = "tp0145";
> +                regulator-min-microvolt = <1000000>;
> +                regulator-max-microvolt = <1800000>;
> +              };
> +
> +              tp2367 {
> +                regulator-name = "tp2367";
> +                regulator-min-microvolt = <1000000>;
> +                regulator-max-microvolt = <1800000>;
> +              };
> +            };
> +
> +            target-port@0 {
> +                reg = <0x0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                mode = "smbus";
> +                pullup-enable;
> +
> +                eeprom@57 {
> +                    compatible = "atmel,24c32";
> +                    reg = <0x57>;
> +                    pagesize = <32>;
> +                    wp-gpios = <&gpio2 2 0>;
> +                    num-addresses = <8>;
> +                };
> +            };
> +
> +            target-port@2 {
> +                reg = <0x2>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                mode = "i3c";
> +                pullup-enable;
> +
> +                sensor@68,39200144004 {
> +                  reg = <0x68 0x392 0x144004>;
> +                  assigned-address = <0xa>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4262e8d833c4..b33e90030188 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15477,6 +15477,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
>  F:	sound/soc/codecs/tfa989x.c
>  
> +NXP P3H2X4X I3C-HUB DRIVER

Does not look ordered according to rules in this file.

Best regards,
Krzysztof


