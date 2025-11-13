Return-Path: <linux-kernel+bounces-899419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D401CC57DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B7D3ACF15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F635292A;
	Thu, 13 Nov 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb3H8O3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BF93491E1;
	Thu, 13 Nov 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040595; cv=none; b=XnsQA4ul17vDJGJydEbB5ioz/BmQ0A1CuA1sOBHIoXTRu5GCGmdU51FakZ2sWVgLiI74YT7ALua33Uk5Z41gOeJ2rfflUwfUe9q5GmmcL4ovnDLi4Omlt4LTqZJ0k1dkLE17onhCiHkUxzRmt2o2zJSLwOJtc6mhUWdeMJAiPLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040595; c=relaxed/simple;
	bh=A5x+83PnDTgNAEyAE1p8cNUzLQ6NIflPP4lgbqDUSPg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XaE/txjImoG2I+O3OOj0GVsZYsAQ9rA/mAJT+AO7bMdA+JsbGGOGTiUNvAto1YYPtSzBJ7oeCIFsn6Ckgja9Hk6ZUb02M1jiuUVkfLzE732DMuq/AgTfe4yJalAkwRF0GjMcGCoN4fUliyqVJCvsgwWb9c6FGeiiOM1zE0tguBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb3H8O3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F9C4CEF8;
	Thu, 13 Nov 2025 13:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040595;
	bh=A5x+83PnDTgNAEyAE1p8cNUzLQ6NIflPP4lgbqDUSPg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Nb3H8O3W84yfg9a30QMKTOVcfdaDiF9LT9HyvaOEaPElvS1MhYctzoBjmANb1xbO1
	 4l4/TGoz8mWlkg01RjAfYpfZZ2VylBUDeaLCZp8hEeJup8frK3NTN14wx2pA+/BiQA
	 LbcOysJVwxbr70rkfwjX5sGAO5RYFy3tUySX1+YnlYJPSuktCNJPZiR2e/mVeWzho2
	 KB0JnQCgx/CzO3uyaPl2ZxEqVc3qqj8Gw6gsVRvl3x5fodwpRcSLp9tI9cvJC8ebKk
	 Su1Rz/WabCHkV3sZ8I+86w8L26n3lH0hMaNzYHGPphMGSOb+YZ6ZpG3CNqzkArDtmt
	 PA2UO6LDsJBvg==
Date: Thu, 13 Nov 2025 07:29:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
Message-Id: <176304044264.4031532.14638465015514612185.robh@kernel.org>
Subject: Re: [PATCH 00/16] Led update for STMicrolectronics boards


On Wed, 12 Nov 2025 15:40:17 +0100, Patrice Chotard wrote:
> This series adds/updates LED nodes for STMicroelectronics boards by
> adding new LED nodes and function/color properties.
> 
> On STM32 MCUs boards (F4/F7 and H7 series) green LED is
> used as heartbeat.
> 
> On STM32MP1/2, blue LED is used as heartbeat.
> 
> On STM32MP1, red LED is used as status LED.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Patrice Chotard (16):
>       ARM: dts: stm32: reorder nodes for stm32429i-eval
>       ARM: dts: stm32: Update LED nodes for stm32429i-eval
>       ARM: dts: stm32: Update LED nodes for stm32f429-disco
>       ARM: dts: stm32: Update LED nodes for stm32f469-disco
>       ARM: dts: stm32: Update LED node for stm32f746-disco
>       ARM: dts: stm32: Update LED nodes for stm32f769-disco
>       ARM: dts: stm32: Update LED nodes for stm32746g-eval
>       ARM: dts: stm32: Add LED support for stm32h743i-disco
>       ARM: dts: stm32: Add LED support for stm32h743i-eval
>       ARM: dts: stm32: Update LED nodes for stm32h747i-disco
>       ARM: dts: stm32: Add red LED for stm32mp135f-dk board
>       ARM: dts: stm32: Add red LED for stm32mp157c-ed1 board
>       ARM: dts: stm32: Update LED node for stm32mp15xx-dkx board
>       arm64: dts: st: Add green and orange LED for stm32mp235f-dk
>       arm64: dts: st: Add green and orange LED for stm32mp257f-dk
>       arm64: dts: st: Add green and orange LED for stm32mp235f-dk
> 
>  arch/arm/boot/dts/st/stm32429i-eval.dts    | 65 +++++++++++++++++-------------
>  arch/arm/boot/dts/st/stm32746g-eval.dts    |  6 +++
>  arch/arm/boot/dts/st/stm32f429-disco.dts   |  6 ++-
>  arch/arm/boot/dts/st/stm32f469-disco.dts   |  6 +++
>  arch/arm/boot/dts/st/stm32f746-disco.dts   |  3 ++
>  arch/arm/boot/dts/st/stm32f769-disco.dts   |  5 +++
>  arch/arm/boot/dts/st/stm32h743i-disco.dts  | 27 +++++++++++++
>  arch/arm/boot/dts/st/stm32h743i-eval.dts   | 18 +++++++++
>  arch/arm/boot/dts/st/stm32h747i-disco.dts  |  6 +++
>  arch/arm/boot/dts/st/stm32mp135f-dk.dts    |  6 +++
>  arch/arm/boot/dts/st/stm32mp157c-ed1.dts   |  6 +++
>  arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi  | 10 ++++-
>  arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 10 +++++
>  arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 10 +++++
>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 23 +++++++++++
>  15 files changed, 176 insertions(+), 31 deletions(-)
> ---
> base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
> change-id: 20251112-upstream_update_led_nodes-30e8ca390161
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

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/st/' for 20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com:

Error: arch/arm/boot/dts/st/stm32429i-eval.dts:131.13-22 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.dtbs:131: arch/arm/boot/dts/st/stm32429i-eval.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm/boot/dts/st] Error 2
make[2]: Target 'arch/arm/boot/dts/st/stm32429i-eval.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1480: st/stm32429i-eval.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'st/spear310-evb.dtb' not remade because of errors.
make: Target 'st/spear300-evb.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-dk2.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-icore-stm32mp1-edimm2.2.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-ev1.dtb' not remade because of errors.
make: Target 'st/stm32mp153c-lxa-tac-gen3.dtb' not remade because of errors.
make: Target 'st/stm32mp135f-dhcor-dhsbc.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-odyssey.dtb' not remade because of errors.
make: Target 'st/stih407-b2120.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-codina.dtb' not remade because of errors.
make: Target 'st/stm32h747i-disco.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-codina-tmo.dtb' not remade because of errors.
make: Target 'st/ste-hrefv60plus-tvk.dtb' not remade because of errors.
make: Target 'st/stm32mp151a-dhcor-testbench.dtb' not remade because of errors.
make: Target 'st/stih410-b2120.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-phycore-stm32mp1-3.dtb' not remade because of errors.
make: Target 'st/stm32h750i-art-pi.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-dhcom-picoitx.dtb' not remade because of errors.
make: Target 'st/stm32mp153c-lxa-fairytux2-gen2.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-dhcom-pdk2.dtb' not remade because of errors.
make: Target 'st/spear320-hmi.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-ed1.dtb' not remade because of errors.
make: Target 'st/ste-nomadik-s8815.dtb' not remade because of errors.
make: Target 'st/ste-hrefprev60-tvk.dtb' not remade because of errors.
make: Target 'st/spear320-evb.dtb' not remade because of errors.
make: Target 'st/stm32mp153c-lxa-fairytux2-gen1.dtb' not remade because of errors.
make: Target 'st/stm32mp153c-dhcor-drc-compact.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-skomer.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-microgea-stm32mp1-microdev2.0.dtb' not remade because of errors.
make: Target 'st/stih418-b2264.dtb' not remade because of errors.
make: Target 'st/stm32f769-disco-mb1166-reva09.dtb' not remade because of errors.
make: Target 'st/stm32f429-disco.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb' not remade because of errors.
make: Target 'st/stm32mp151a-prtt1a.dtb' not remade because of errors.
make: Target 'st/ste-hrefv60plus-stuib.dtb' not remade because of errors.
make: Target 'st/stm32746g-eval.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-dk1-scmi.dtb' not remade because of errors.
make: Target 'st/stm32mp151c-mect1s.dtb' not remade because of errors.
make: Target 'st/ste-href520-tvk.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-stinger96.dtb' not remade because of errors.
make: Target 'st/stih418-b2199.dtb' not remade because of errors.
make: Target 'st/ste-snowball.dtb' not remade because of errors.
make: Target 'st/stm32f469-disco.dtb' not remade because of errors.
make: Target 'st/stm32h743i-eval.dtb' not remade because of errors.
make: Target 'st/stm32f769-disco.dtb' not remade because of errors.
make: Target 'st/ste-nomadik-nhk15.dtb' not remade because of errors.
make: Target 'st/stm32429i-eval.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-dhcor-avenger96.dtb' not remade because of errors.
make: Target 'st/stm32mp153c-mecio1r1.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-ultra-fly-sbc.dtb' not remade because of errors.
make: Target 'st/stm32mp151a-prtt1s.dtb' not remade because of errors.
make: Target 'st/spear1340-evb.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-icore-stm32mp1-ctouch2-of10.dtb' not remade because of errors.
make: Target 'st/stm32mp151a-prtt1c.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-golden.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-osd32mp1-red.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-dk1.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-kyle.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-janice.dtb' not remade because of errors.
make: Target 'st/stm32mp153c-dhcom-drc02.dtb' not remade because of errors.
make: Target 'st/spear600-evb.dtb' not remade because of errors.
make: Target 'st/stm32mp157f-dk2.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-emsbc-argon.dtb' not remade because of errors.
make: Target 'st/stm32f746-disco.dtb' not remade because of errors.
make: Target 'st/stm32mp151c-plyaqm.dtb' not remade because of errors.
make: Target 'st/stm32mp133c-prihmb.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-iot-box.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-lxa-mc1.dtb' not remade because of errors.
make: Target 'st/stm32mp135f-dk.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-lxa-tac-gen2.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-ev1-scmi.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-avenger96.dtb' not remade because of errors.
make: Target 'st/ste-ux500-samsung-gavini.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-ed1-scmi.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-lxa-tac-gen1.dtb' not remade because of errors.
make: Target 'st/stih410-b2260.dtb' not remade because of errors.
make: Target 'st/stm32mp151c-mecio1r0.dtb' not remade because of errors.
make: Target 'st/spear1310-evb.dtb' not remade because of errors.
make: Target 'st/stm32h743i-disco.dtb' not remade because of errors.
make: Target 'st/stm32mp157a-icore-stm32mp1-ctouch2.dtb' not remade because of errors.
make: Target 'st/ste-hrefprev60-stuib.dtb' not remade because of errors.
make: Target 'st/stm32mp157c-dk2-scmi.dtb' not remade because of errors.






