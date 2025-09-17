Return-Path: <linux-kernel+bounces-821099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75912B80670
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44BA189C11B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6652F7477;
	Wed, 17 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxMhbcJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30F35AAB7;
	Wed, 17 Sep 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121236; cv=none; b=jSCyvTEN3+x9R1RSY7zcWLLGQ30e8UvGtu22yE/RAOJn02Gr6xY8dcuDtWkhRuddfrs06pr4fEypDntPZNuYBjxetk3pnGuhcveEdCrhkMR4MQzQSjLK2LUf1VOKnaMkmkvfL7S/augtlgrHLRwf9xP3in6cRjSfOzzZrlBol2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121236; c=relaxed/simple;
	bh=HDiQWb20Rtx+E1H2UYAaRAIpBHG5/mnMO3quayCJMb8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=OKC8/rxwzafZ1jrY/heQqisqMkGILLLHDASU4Q722rkXciWObLbaBorMk8+2H5nT7rHHOvA6L40fuK4mIGhwe+YG0UOFvTbYL8A1w+TEunHqY1JlBwB98uvk8n4GU4uexLfdsr70dYGkEDeFfvDa2X5M/YNLAjCMj+tzu8cMH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxMhbcJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78850C4CEF5;
	Wed, 17 Sep 2025 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758121235;
	bh=HDiQWb20Rtx+E1H2UYAaRAIpBHG5/mnMO3quayCJMb8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kxMhbcJaCqlaesBAyz9ojQ5gfElOWK6fTHmyiSiuEcBm6WaKozjkyVJ5H7yzSBzM4
	 g9fV9aZ6h7kKG6tewZw5FxRV32BwoxJ1vea2SnKK7jrm3euzAAaOikKCaMllXeDDvz
	 rjL5bXi3jwKnQEYXVqHvgE5OFUo+CMWmQm8nUd2zfLQIn+0eg84FndzMwXsqbnhcPO
	 wEuE7ia+whWx3768oewU75PUQxQZyn/L0pPj73bR44EMcxhpt2hE6tDafjD2VqmEd3
	 Vy7DTOjjpS37zxbQo7axGtZObUvwwOyEorcPQFHMKNiFtEmvYToo1NNmz6WVviz8pQ
	 mq6LFmcvoX0fA==
Date: Wed, 17 Sep 2025 10:00:34 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Peter Robinson <pbrobinson@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Dragan Simic <dsimic@manjaro.org>, Andy Yan <andy.yan@rock-chips.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
To: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20250916080802.125-1-kernel@airkyi.com>
References: <20250916080802.125-1-kernel@airkyi.com>
Message-Id: <175812100320.2051529.8331047555950941186.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable DisplayPort for
 rk3588-evb2


On Tue, 16 Sep 2025 16:08:02 +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The rk3588 evb2 board has a full size DisplayPort connector, enable
> for it.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>  .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250915 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250916080802.125-1-kernel@airkyi.com:

arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dtb: dp-con (dp-connector): type:0: 'full size' is not one of ['full-size', 'mini']
	from schema $id: http://devicetree.org/schemas/display/connector/dp-connector.yaml#






