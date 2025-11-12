Return-Path: <linux-kernel+bounces-897393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 30586C52B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC603343CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1833BBA1;
	Wed, 12 Nov 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qve7G4L0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758733B6DE;
	Wed, 12 Nov 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957617; cv=none; b=gfj3WWO3cRVyKC8IZGmbkIP4XHc3ggkbODLApNHmBwCNywnJ+Z7NFCkLKwXLxRUgB6UqMn3Rq0F/C0DYr0DUmzpSVorj33Tdz2qsl48Nfr2DR5zH5mEhYYGAcLVrlncw+8NQxR4uwCkSobHnHuT9V3VjIFX336P6HFi6BPgV1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957617; c=relaxed/simple;
	bh=qeuILCfLWad/qbdor3W9n5ZZy0hnPVSh5PPuu3qs/QE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XQvLjojS3uCWk30gUjr17c9Pp78kLJIWNZA//FhSlKjN5tEUdItgTunpQ3RhUIYodmsa6vKVb2OkChVGA73ztpS7jRE7JFWjOhz4hEC69v19913ySk071UL2r1z3i+7eZ7glxdsLe9uI/LFPYwbNEejb0pObQBOJBZyoLQq03f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qve7G4L0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E68DC4CEF5;
	Wed, 12 Nov 2025 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957616;
	bh=qeuILCfLWad/qbdor3W9n5ZZy0hnPVSh5PPuu3qs/QE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qve7G4L0YkbRYzSqsV764xHqJipSwJLZHj1ww/HX7HeUzWhQmoOkvD06mELydd+6p
	 vBe+03Yks5anblHWanxMmaKRFLYdBRYE2LXOk5OQ86x+FvMwLA8KvRjGvoM1tzyXBI
	 1AqRNa1RCPCD7VE/h9+O5DF8MyE5DTdGzUrZExQwCa6paTArLe6ncDc48usZtCgQpa
	 wix5EmQQky48KVxL1DGT6rU5y3wEH3cvA3WJvTD9yLPDVZV2zxcy2Ps0tNJEOapc1p
	 Y2UnYtiOi+pELcNjbWhpdzUjKNXZxsSTGMh/D3rlKMZRaStt2gWo2lS+nbPDKX1T7q
	 YpgzTjAvTymzQ==
Date: Wed, 12 Nov 2025 08:26:55 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
References: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
Message-Id: <176295563590.1637939.3347883345967436731.robh@kernel.org>
Subject: Re: [PATCH 0/6] Add boot phase tags for STMicroelectronics boards


On Wed, 12 Nov 2025 11:46:42 +0100, Patrice Chotard wrote:
> The bootph-all flag was introduced in dt-schema
> (dtschema/schemas/bootph.yaml) to define node usage across
> different boot phases.
> 
> To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
> present in all boot stages, so add missing bootph-all phase flag
> to these nodes to support SD boot.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Patrice Chotard (6):
>       ARM: dts: stm32: Add boot phase tags for STMicroelectronics f4 boards
>       ARM: dts: stm32: Add boot phase tags for STMicroelectronics f7 boards
>       ARM: dts: stm32: Add boot phase tags for STMicroelectronics h7 boards
>       ARM: dts: stm32: Add boot phase tags for STMicroelectronics mp13 boards
>       ARM: dts: stm32: Add boot phase tags for STMicroelectronics mp15 boards
>       arm64: dts: st: Add boot phase tags for STMicroelectronics mp2 boards
> 
>  arch/arm/boot/dts/st/stm32429i-eval.dts       | 11 +++++
>  arch/arm/boot/dts/st/stm32746g-eval.dts       | 10 +++++
>  arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi     | 12 ++++++
>  arch/arm/boot/dts/st/stm32f429-disco.dts      | 11 +++++
>  arch/arm/boot/dts/st/stm32f429.dtsi           |  9 ++++
>  arch/arm/boot/dts/st/stm32f469-disco.dts      | 12 ++++++
>  arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi     | 11 +++++
>  arch/arm/boot/dts/st/stm32f746-disco.dts      | 12 ++++++
>  arch/arm/boot/dts/st/stm32f746.dtsi           |  5 +++
>  arch/arm/boot/dts/st/stm32f769-disco.dts      | 12 ++++++
>  arch/arm/boot/dts/st/stm32h743.dtsi           | 19 +++++++++
>  arch/arm/boot/dts/st/stm32mp131.dtsi          | 21 ++++++++++
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts       | 11 +++++
>  arch/arm/boot/dts/st/stm32mp15-scmi.dtsi      | 26 ++++++++++++
>  arch/arm/boot/dts/st/stm32mp151.dtsi          | 29 +++++++++++++
>  arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts | 14 +++++++
>  arch/arm/boot/dts/st/stm32mp157a-dk1.dts      | 43 +++++++++++++++++++
>  arch/arm/boot/dts/st/stm32mp157c-dk2.dts      | 43 +++++++++++++++++++
>  arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts | 14 +++++++
>  arch/arm/boot/dts/st/stm32mp157c-ed1.dts      | 60 +++++++++++++++++++++++++++
>  arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts | 31 ++++++++++++++
>  arch/arm/boot/dts/st/stm32mp157c-ev1.dts      | 36 ++++++++++++++++
>  arch/arm64/boot/dts/st/stm32mp211.dtsi        |  7 ++++
>  arch/arm64/boot/dts/st/stm32mp215f-dk.dts     |  1 +
>  arch/arm64/boot/dts/st/stm32mp231.dtsi        | 22 ++++++++++
>  arch/arm64/boot/dts/st/stm32mp235f-dk.dts     | 11 +++++
>  arch/arm64/boot/dts/st/stm32mp251.dtsi        | 27 +++++++++++-
>  arch/arm64/boot/dts/st/stm32mp257f-dk.dts     | 11 +++++
>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    | 11 +++++
>  29 files changed, 541 insertions(+), 1 deletion(-)
> ---
> base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
> change-id: 20251112-upstream_uboot_properties-22480b0b4b1c
> 
> Best regards,
> --
> Patrice Chotard <patrice.chotard@foss.st.com>
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
 Base: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/st/' for 20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com:

arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dtb: pinctrl@50002000 (st,stm32mp157-pinctrl): qspi-bk1-0:pins1: 'pinmux' is a required property
	from schema $id: http://devicetree.org/schemas/pinctrl/st,stm32-pinctrl.yaml
arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dtb: pinctrl@50002000 (st,stm32mp157-pinctrl): qspi-bk1-0:pins2: 'pinmux' is a required property
	from schema $id: http://devicetree.org/schemas/pinctrl/st,stm32-pinctrl.yaml
arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dtb: pinctrl@50002000 (st,stm32mp157-pinctrl): qspi-bk2-0:pins1: 'pinmux' is a required property
	from schema $id: http://devicetree.org/schemas/pinctrl/st,stm32-pinctrl.yaml
arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dtb: pinctrl@50002000 (st,stm32mp157-pinctrl): qspi-bk2-0:pins2: 'pinmux' is a required property
	from schema $id: http://devicetree.org/schemas/pinctrl/st,stm32-pinctrl.yaml






