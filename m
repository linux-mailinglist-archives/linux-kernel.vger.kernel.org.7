Return-Path: <linux-kernel+bounces-870027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0415CC09B36
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FCA1A667FD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0281306D50;
	Sat, 25 Oct 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C3NE8JJL"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE22571C3
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409866; cv=none; b=H5LU7jvERZUaOsUrCMS9UUIchnwF6/4T9cA91y0SW5iUXBVD06pW/CV8I8/7kDO5mBWYaAob8gxm/qSi1YlK1zqynk2yC1869HuLq5TJFFDU/cSZYksJ529zdQ7+i9JC4l92HysJrOaWso7UwMlUvmQODFA8Mnz4FWH5Qk/jJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409866; c=relaxed/simple;
	bh=2o70kdIbqvA0gkvd1LuK+te6zY7HpF1YCAlRbS1nEDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgsD1T0clUjvVybxosltzIQIxtYZHUmPdGPRTFnAaI34vXviAEq3kUwGepyV43IzNvSJf/StAUsT9+IA9mp73t411ysTKuO14KJI8cuCSwDFQK19DVa6YQb9jOyrdUgIi62acAlzP0nfr2tkL1JSQOCSoY0NSWETgUHFR6y1d+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C3NE8JJL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D6E87C0AFE0;
	Sat, 25 Oct 2025 16:30:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9037B60704;
	Sat, 25 Oct 2025 16:30:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D445102F24BA;
	Sat, 25 Oct 2025 18:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761409857; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KDblosft9JEzFezgNrXQf1MGlAEA61JB3YECBruuEkM=;
	b=C3NE8JJLe7ovfjjwuA73fK6qhfg5naY+Rg73kp1VPMXDQVA3HcgmV8+y9xP80pD9EVyjw/
	R1vizbrSt2Ri/BdhpxiZNNnKjDCyubNxhe/7ntGlr5BOeDFXei+wZNMf0Q8gCfzUcn+DZW
	8hI0RbdHZU94641nOMKkm1z3kMxGSao2/Hbb3aHqRoo8+FQBaSbqylFzDPh8DE/BZEhGuS
	6Y4U53ALW5kZNuxcWHu+FJQfYYll/oDvePzoOHVOBK64ysHtouCxjMcJ/reIlLZn2G/YG+
	anY+YPj0zEBMJXlPi5wz3uqGUQd3ZnIVIA8SqaPbRxuHWKP3enTCeJlfjWuSww==
Message-ID: <59511487-6aa2-4615-9eb3-79aa0e9954ee@bootlin.com>
Date: Sat, 25 Oct 2025 18:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/13] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
To: Daniel Golle <daniel@makrotopia.org>, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Peter Christen <peter.christen@siemens.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, Bing tao Xu
 <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
 Juraj Povazanec <jpovazanec@maxlinear.com>,
 "Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
 "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1761402873.git.daniel@makrotopia.org>
 <73d0de129a6fc9f8a8a087a2759f9c2ab0d710c0.1761402873.git.daniel@makrotopia.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <73d0de129a6fc9f8a8a087a2759f9c2ab0d710c0.1761402873.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Daniel,

On 25/10/2025 16:49, Daniel Golle wrote:
> Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> properties on port nodes to allow fine-tuning of RGMII clock delays.
> 
> The GSWIP switch hardware supports delay values in 500 picosecond
> increments from 0 to 3500 picoseconds, with a default of 2000
> picoseconds for both TX and RX delays.
> 
> This corresponds to the driver changes that allow adjusting MII delays
> using Device Tree properties instead of relying solely on the PHY
> interface mode.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/net/dsa/lantiq,gswip.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> index f3154b19af78..ed274bfb8d49 100644
> --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> @@ -8,6 +8,24 @@ title: Lantiq GSWIP Ethernet switches
>  
>  allOf:
>    - $ref: dsa.yaml#/$defs/ethernet-ports
> +  - properties:
> +      ports:
> +        patternProperties:
> +          "^port@[0-6]$":
> +            type: object
> +            properties:
> +              tx-internal-delay-ps:
> +                enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> +                default: 2000
> +                description:
> +                  RGMII TX Clock Delay defined in pico seconds.
> +                  The delay lines adjust the MII clock vs. data timing.
> +              rx-internal-delay-ps:
> +                enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> +                default: 2000
> +                description:
> +                  RGMII RX Clock Delay defined in pico seconds.
> +                  The delay lines adjust the MII clock vs. data timing.
>  
>  maintainers:
>    - Hauke Mehrtens <hauke@hauke-m.de>
> @@ -115,6 +133,8 @@ examples:
>                              label = "lan3";
>                              phy-mode = "rgmii";
>                              phy-handle = <&phy0>;
> +                            tx-internal-delay-ps = <2000>;
> +                            rx-internal-delay-ps = <2000>;

I guess that in this example, with a 2ns delay, this is no longer
"rgmii" but "rgmii-id", as delays are inserted by the switch. It would
make sense to update the phy-mode.

>                      };
>  
>                      port@1 {

Maxime

