Return-Path: <linux-kernel+bounces-817766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65A6B58642
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF652A20F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D92BCF4C;
	Mon, 15 Sep 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZeXzPDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033772610;
	Mon, 15 Sep 2025 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757969931; cv=none; b=WXe2c2GbmzXRmxEyW1Ab7jNpI9hrAU5nbkrmZDLVnj4cvyrIrkob8GMQAwrRh5Jy7W2iymxm5b8Ox3nCE96GDo6AHKax9lEhVvM03oV8pUsAcIsukmA6QlT/gDO5+mxjI1qFPqTCXuXwDT8aUPL5AGft0iFdY0zHyZjma7fx1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757969931; c=relaxed/simple;
	bh=t9q3ouWsJp0hUNsNL8ForeCLdz8chqTcTMColwepR+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1RO9THAUZG2Oq7kvlMC9nJ/LP/xAFJASnFF1qfRme+SL/gLIbs1b5YtJ1b1HBP4aD2qchNWCrzNDr+mB1F5gnQr8ga0e3FIgTVho+PlrxzK1pE4sNKOyluPdy+9BOEVyLRVFJ/9lrHx20h+fxwOiR+JPdjyTyXelRasc9ZiRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZeXzPDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84527C4CEF1;
	Mon, 15 Sep 2025 20:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757969930;
	bh=t9q3ouWsJp0hUNsNL8ForeCLdz8chqTcTMColwepR+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZeXzPDGOjtQmsgL6BNUGp11/XFVSj8f0i3/LRMiyfD8MEe8UesDcuoM3C3dkBFJ7
	 nxZhoZVjUuOquQ3Fx/Pj2/HhMGg/asr3PHst9jXU23roHPb5t4Q6XGTsQg4+P6NLsz
	 gB3RHDugh1TqeIXQ6IYU9YLmLCoKYZb+XEfxnMdAEUhP+2R69G1EH26XJUmHwtq6fN
	 0VJCPCdZra5sWkYKF0vKqUtrMzHRkXUY2J1MNwBxIyRpIX/z2hS7xqBpAU5tti/TJS
	 ty06y5cPs6on3u4SCYqe9/fWcvstjskIqglYue9N0XX9wvfI4ZGiE2NQ3NRs6Zhddq
	 6cRt08SVesvig==
Date: Mon, 15 Sep 2025 15:58:49 -0500
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v4 3/5] dt-bindings: usb: usb-device: add usb hub port
 vbus-supply suppport
Message-ID: <20250915205849.GA3379566-robh@kernel.org>
References: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
 <20250911-v6-16-topic-usb-onboard-dev-v4-3-1af288125d74@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-usb-onboard-dev-v4-3-1af288125d74@pengutronix.de>

On Thu, Sep 11, 2025 at 10:22:44PM +0200, Marco Felsch wrote:
> Some PCB designs don't use the dedicated USB hub port power control GPIO
> to control the port VBUS supply. Instead host managed GPIOs are used to
> control the VBUS supply.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/usb/usb-device.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
> index 09fceb469f10525e9dcdb91435b142b0d21964b8..2f891a05ab9bca095eb881c5f601ac27ac63b542 100644
> --- a/Documentation/devicetree/bindings/usb/usb-device.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
> @@ -53,6 +53,12 @@ properties:
>    "#size-cells":
>      const: 0
>  
> +  vbus-supply:
> +    description: USB hub port VBUS supply.
> +      The host managed regulator which controlls the USB hub port VBUS. This

controls

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +      regulator is only required if the hub internal control signals aren't
> +      used to control the VBUS regulators.
> +
>  patternProperties:
>    "^interface@[0-9a-f]{1,2}(,[0-9a-f]{1,2})$":
>      type: object
> 
> -- 
> 2.47.3
> 

