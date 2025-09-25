Return-Path: <linux-kernel+bounces-832744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1933BA03AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029485625E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15A30BB8B;
	Thu, 25 Sep 2025 15:11:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB402E2F1F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813070; cv=none; b=nctpehfsaHQoYF+xszLbFdxUFJ30aaq69t0tVZ6GNORqK3Oe+fkbEYQ+mcHqFD2s3LzCalVOrzXgSR8PnWiB7tSLwmZwR3T9fh26fYDZVIvX/WszpGB/WIJnt3DPFkan9aqDqCAWtgkIXHfWYriXnu/PZWy+sbo+6RRKymhJmA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813070; c=relaxed/simple;
	bh=OL7jojLeKQE6iSoWJ81v+KSjAjTKYwtKJwHgcWiKL+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EftNQGaKEluLG5vt6yZbJbPZj2IxUA0UED6a9gUnILhEieOBuTIZJdCJd29zX/K5jpWKUhmNmeDQdZ6kQhhHT7Vbc7VaDN0vKf4tnd+I3hGbwaZiAv1nLUKp0zUTyUapvIdR1pbOqkYXs4Aum2aERWjtLqGEP4cRnukWrQBqdkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1v1ncM-0003PJ-O1; Thu, 25 Sep 2025 17:10:46 +0200
Message-ID: <3a0ba202-23e5-41d1-8b0c-5501a6d73bb4@pengutronix.de>
Date: Thu, 25 Sep 2025 17:10:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Mainline Protonic PRT8ML board
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-sound@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 imx@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Conor Dooley
 <conor+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 David Jander <david@protonic.nl>, Lucas Stach <l.stach@pengutronix.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
 <175876283065.3268812.10851892974485151512.robh@kernel.org>
Content-Language: en-US
From: Jonas Rebmann <jre@pengutronix.de>
In-Reply-To: <175876283065.3268812.10851892974485151512.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

Regarding the warnings:

On 2025-09-25 03:18, Rob Herring (Arm) wrote:
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: codec@11 (asahi-kasei,ak4458): '#sound-dai-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#

Updated bindings have already been applied to broonie/sound for-next.

> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e10000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 1]] is too long
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): 'power-domain-names' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#
> arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dtb: isp@32e20000 (fsl,imx8mp-isp): power-domains: [[77, 6], [77, 4]] is too long
> 	from schema $id: http://devicetree.org/schemas/media/rockchip-isp1.yaml#

This is an issue in imx8mp.dtsi, introduced in commit 9c60bc7f10d0
("arm64: dts: imx8mp: Add pclk clock and second power domain for the
ISP").

Regards,
Jonas

