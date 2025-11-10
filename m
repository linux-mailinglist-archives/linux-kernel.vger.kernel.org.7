Return-Path: <linux-kernel+bounces-893388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC9FC473B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6675B4ECD7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D506314A90;
	Mon, 10 Nov 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8ZH2TZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18393148BA;
	Mon, 10 Nov 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785274; cv=none; b=kZadoJ8EFITfCYoIrqvQ/cko/tE5gWN/KoTtMZO5/mioCPxIzTEcFXgbbkfzoBZ6IaGkyb6crZ3lOsiKP6c6XmtE47VTmxx4UcQWDbwAfeBbzmlbdx24zd9ENLcyAeG7Q299xRxoVhwpARD20rx+6ct7R8MNEXpobCCnw52u9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785274; c=relaxed/simple;
	bh=ll1L30KbYHKUhO1b4cfOa+rewJpoZ0v1yvioiCyAD2k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Zddl0NhfMi9wwTWYlS6Z7qWYsMmr7+Yu/rXT/KWYONeUFooIY2/Le3dccja8JUFUjqNedHjUo/kobd5/ziRzWhRDzwtQIQOtcA2QGZp7ubq5O0jsqETIOPGO3JLu52JvuOezoZJoF/BaQ0LIzAFN0SAiZAmWDlS/U9pMaYC+M50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8ZH2TZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245E4C113D0;
	Mon, 10 Nov 2025 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762785274;
	bh=ll1L30KbYHKUhO1b4cfOa+rewJpoZ0v1yvioiCyAD2k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=E8ZH2TZxLfcGQtOswmwWlIDHCoWtaO2s9leIhb1rNokZIWfFt9dKZ5yvmR1WOxCwL
	 XWlIRbEVOQXaDL4pJc5dtzKJutxZi+RkTNfgGI89ddWj3xnn/vXMQqjwgJ2E5+jevn
	 rLJUyaDnMDUNJPoTs8EC8WFGn5Pi7dk6AduTEQbKWAJNPOA8FsDMQhiRZQSAnssorm
	 AjF6RIAGYN7SAzRyU1xAfP9jV0bEnaxNAcMmWZBH2eTF4aQYUoJbmV4Lzp9X4ve8ZE
	 /j+ANtgN2VpTnOEUCYQmfkQNNOeW5HqCrn7GAc8jVgTEPON9BJxzQCoMMsE57S7mVE
	 z+4cPjEOGhsKQ==
Date: Mon, 10 Nov 2025 08:34:33 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Shawn Guo <shawnguo@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
In-Reply-To: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
References: <20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de>
Message-Id: <176278493286.154609.17548604407386943510.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add support for Skov Rev.C HDMI variant


On Fri, 07 Nov 2025 15:49:50 +0100, Marco Felsch wrote:
> Hi,
> 
> this small patchset adds the support for the Rev.C HDMI board variant.
> 
> Regards,
>   Marco
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Marco Felsch (2):
>       dt-bindings: arm: fsl: add Skov Rev.C HDMI support
>       arm64: dts: imx8mp-skov: add Rev.C HDMI support
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml          | 1 +
>  arch/arm64/boot/dts/freescale/Makefile                  | 1 +
>  arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dts | 8 ++++++++
>  3 files changed, 10 insertions(+)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251107-v6-18-skov-revc-hdmi-1e8d4bbac26a
> 
> Best regards,
> --
> Marco Felsch <m.felsch@pengutronix.de>
> 
> 
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
 Base: 3a8660878839faadb4f1a6dd72c3179c1df56787 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20251107-v6-18-skov-revc-hdmi-v1-0-595549e5b496@pengutronix.de:

arch/arm64/boot/dts/freescale/imx8mp-skov-revc-hdmi.dtb: switch@5f (microchip,ksz9893): pinctrl-names: ['default'] is too short
	from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml






