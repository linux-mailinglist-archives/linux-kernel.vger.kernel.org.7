Return-Path: <linux-kernel+bounces-823035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC15B8559C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B803A69D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381972D94BB;
	Thu, 18 Sep 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z67xktK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A298221F26;
	Thu, 18 Sep 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207017; cv=none; b=DdPgcXnouthwuvydwbouzy5gK8N5kSQqf/IWkKR+HK4fhcKrjhsnRwADRJFMzjC4FIJtG//+T+8BUP1JxdGv7RAyrQQGbA+dpuq6FXOlvdONztuvpN9xBjZe+bDNWl2vkOV57LfDeSM407+HT4M09Bt+EURt6PZMv7IGMQlOr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207017; c=relaxed/simple;
	bh=rdKpK3nchvp/w38h4f46KmCsTfhjjVcybQBpTUeTe9Y=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=KHD+vKbPR/S9VAynxlQcGGG/b15X4z76LaSsxHHB+MuF/LpAUcf7LrKStEx0r9UXx52ql75AHsPjR8LHlEuFBOD/l8REuP9ikDANL/Jce4sRzz/8vbpkBrfYP06e97o/nZw1mjm408Z0VCe0+TfD78OkiY6DtHbllpWM57alhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z67xktK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC12C4CEE7;
	Thu, 18 Sep 2025 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207016;
	bh=rdKpK3nchvp/w38h4f46KmCsTfhjjVcybQBpTUeTe9Y=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Z67xktK32N/0SPPgxilFoJF1XbCI1YMq7szYokGU2rekjwG2KEwCkHufVLC4FF48s
	 1wuVqPA/hK97kJcLZOdyMzO4zd7fKcJ0D31BzcmRYuwr7TuCqo46bnQ6vg4D/jj8qN
	 /c1KWRYRfOAWZOLcNpw0ojkJPffXQZhr9w1zG/s4eRsRwnX55JNBHaqa4WQ8IBbGLC
	 9Pc3alfWtNYoTtW0Q0rDzpilTxsrnKQYyHsVmMP+yvS8yEuASGdI2Iz955TrIn6e9M
	 fB/ed7yGOAkZLdr8OsBhJqIJ6M9SzNkdK7brA3wOJPtCU/UEJQ22Dx09g9qXG237ZK
	 2Pa6QSJBGzwGQ==
Date: Thu, 18 Sep 2025 09:50:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: conor+dt@kernel.org, josua@solid-run.com, Markus.Niebel@tq-group.com, 
 frieder.schrempf@kontron.de, s.hauer@pengutronix.de, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, francesco.dolcini@toradex.com, 
 linux-arm-kernel@lists.infradead.org, alexander.stein@ew.tq-group.com, 
 kernel@pengutronix.de, marex@denx.de, dario.binacchi@amarulasolutions.com, 
 joao.goncalves@toradex.com, y.moog@phytec.de, linux-kernel@vger.kernel.org, 
 primoz.fiser@norik.com, imx@lists.linux.dev, festevam@gmail.com, 
 shawnguo@kernel.org
To: Rogerio Pimentel <rpimentel.silva@gmail.com>
In-Reply-To: <20250918014053.696710-1-rpimentel.silva@gmail.com>
References: <20250918014053.696710-1-rpimentel.silva@gmail.com>
Message-Id: <175820686275.1653785.13196624699524860361.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board


On Wed, 17 Sep 2025 21:40:52 -0400, Rogerio Pimentel wrote:
> Add device tree compatible string for the i.MX8MP FRDM board.
> 
> Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
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
 Base: remotes/next/fs-next-7200-gdcb597fa814c (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250918014053.696710-1-rpimentel.silva@gmail.com:

arch/arm64/boot/dts/freescale/imx8mp-frdm.dtb: gpio-leds (gpio-leds): 'blue', 'green', 'red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#






