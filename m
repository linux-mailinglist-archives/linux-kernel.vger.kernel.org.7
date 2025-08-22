Return-Path: <linux-kernel+bounces-781376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19900B311B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CE416308D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4C2EDD6D;
	Fri, 22 Aug 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm9SIROR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132D2EDD51;
	Fri, 22 Aug 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851026; cv=none; b=TB3rQ77VjylMfUdtIiFssu4mbvgmdQG0h68CDLWmI9U5Cn7cjEfOjXrJV9auvO/C26DBFo4CF7yupsCdAVH2y8A2j4pNDxc3wv+Ms9MSFNsVNYwiInIB+gBXsfm5eXe2xMSMvXL7Y8U/QGVIKyjz6ADCe6Fpm2ZgZQDw8sIyBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851026; c=relaxed/simple;
	bh=03Yx5LsV5HItH5QD6ggezJ6636qthAU/TCRiuL0s6Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOFYy3Y/N5jsJOYjscVPwHQq2l4I0LFCAB2Mb7POk9xLx1eAzAFeiEJgJAPUJFVpdr1GW//0YZ8j76Tb2C31hm/j16F0EDUhpnkCdfyz2NWFxJP/INB1XY8VlDxlyjtS2vXrbXUjF/y5SVC1+zzfNXeSQoRHqLnA2Ec1+Ktyv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm9SIROR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B9AC4CEF4;
	Fri, 22 Aug 2025 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755851026;
	bh=03Yx5LsV5HItH5QD6ggezJ6636qthAU/TCRiuL0s6Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bm9SIRORzl86UdGbHLm1Ms0KwZAMngOfadY+IvoGnbquFnazG1NnAYHBVt2tOPDsm
	 HNAiSKCVAlS4KwVP1dK9/RGv9bKMYqNteVt2KmLUW4Li5zuu9gmsRp6nfHBA5BbvEY
	 /Tc+MJk852doMdH5aGPZbDoFA4FJSFBYjer+enngRv0XMquboez/V1sJjj2IUge+VJ
	 xCRjDGr7CCTiGQYYBbRpxgF48rREh87d5wJnc2iq/oPZzaJ6vy70yIeJrrv8bu2MrJ
	 zU5qWKdRWNrSNjVtU+iQLC2qW3qgnPEFvhbrWvHLRP3unP8Dd4deWXy1qcMme+/tYZ
	 Y7PSytC6wwRDA==
Date: Fri, 22 Aug 2025 10:23:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 3/4] dt-bindings: usb: microchip,usb2514: add support
 for port vbus-supply
Message-ID: <20250822-maize-elk-of-growth-2a30bb@kuoka>
References: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
 <20250821-v6-16-topic-usb-onboard-dev-v3-3-6d2b38a5d818@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-v6-16-topic-usb-onboard-dev-v3-3-6d2b38a5d818@pengutronix.de>

On Thu, Aug 21, 2025 at 06:31:57PM +0200, Marco Felsch wrote:
> Some PCB designs don't connect the USB hub port power control GPIO and
> instead make use of a host controllable regulator. Add support for this
> use-case by introducing portX-vbus-supply property.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> index 4e3901efed3fcd4fbbd8cb777f9df4fcadf2ca00..ac1e5f1a5ea2e66c61ce92154385952b15e78e55 100644
> --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> @@ -49,6 +49,12 @@ patternProperties:
>      $ref: /schemas/usb/usb-device.yaml
>      additionalProperties: true
>  
> +  "^port[1-7]-vbus-supply$":
> +    type: object
> +    description:
> +      Regulator controlling the USB VBUS on portX. Only required if the host
> +      controls the portX VBUS.

Your commit msg should briefly describe status of previous discussion:
why Rob's comment was not applied. Otherwise we repeat: this looks like
property of specific port.

The binding does not list ports now, but lists hard-wired devices, so my
question is now: is this per hard-wired device or per port (even if port
is hot-pluggable)?

Best regards,
Krzysztof


