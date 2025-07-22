Return-Path: <linux-kernel+bounces-741212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34FB0E181
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3781C85CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269A027AC3C;
	Tue, 22 Jul 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlLjGUb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625627A47E;
	Tue, 22 Jul 2025 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201083; cv=none; b=OgLZnvvIYVAEfZ6ARwQ5OvTTLi3ZFe1C0kVe9vghNgzEzjfwx43Zx/RuIxD4cIDn5KBL0j6K/kXsX+/TM/bI+02/H5RgI+JbhqsTUgYLGmKECH16rQczmgrMo2GaMAskpj5g/tez/AL3Pa3mdaFu2m0X7JPfxXPyBtmqYZ+W8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201083; c=relaxed/simple;
	bh=J7LJKNLbK+TTtGd8sXeIJEYAW4as9aUTUYlUL2/0OC0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=HZ8F+yLxNu1qa50I8EAjw0t2ykhbnlDFTVkV+sPKLQeyd/v4B7iNmLYzinrcmKeqP0nxGL5896pc4Pm6WssLr6ceJjadUS0oyslM8CQMhnrM0RWUfgkDa+fRzh8pJ5SL5p7tYOLcIhvcHoXYwiH71mQFg/LN4KdkJ7dVKJbnF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlLjGUb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20BEC4CEF6;
	Tue, 22 Jul 2025 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201083;
	bh=J7LJKNLbK+TTtGd8sXeIJEYAW4as9aUTUYlUL2/0OC0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QlLjGUb1YgvAIYoDUCiYMGLxQbpz6UDUXOWYw3CPUxyORWw8DmtKQK6+Z3KCUBmsG
	 f5RHHFDZ09akPXY09QopF/YQQN0Wt4Yh1ZwCQtB6bnxxWC94SiSJFzAhUpX3hM5F5/
	 rJnH6gSqvEExmsR1Ufb6PAZU4KpRf/PnlT9p9LDlSEx4WXNinnSKw3itneLpJk+DEI
	 1izwOYnuJtVSxf5lZyP1n2J92x/br2XO94EU/jppUqIHf5TJ0WecPLbauqUw/NlDG0
	 hYX+/Wdtgwhbm60JNr5Itfdla9qF84Uc/+ARrRBEfzd07uQL3NG66bFD35m3raJn8x
	 rXJOjsR2i8Erg==
Date: Tue, 22 Jul 2025 11:18:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Bear Wang <bear.wang@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Macpaul Lin <macpaul@gmail.com>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Pablo Sun <pablo.sun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Ramax Lo <ramax.lo@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20250722085811.2062790-1-macpaul.lin@mediatek.com>
References: <20250722085811.2062790-1-macpaul.lin@mediatek.com>
Message-Id: <175320094841.3955034.3637479900814229901.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm64: mediatek: add
 mt8395-evk-ufs board


On Tue, 22 Jul 2025 16:58:08 +0800, Macpaul Lin wrote:
> Add a compatible string for the MediaTek mt8395-evk-ufs board.
> This board is the origin Genio 1200 EVK already mounted two main storages,
> one is eMMC, and the other is UFS. The system automatically prioritizes
> between eMMC and UFS via BROM detection, so user could not use both storage
> types simultaneously. As a result, mt8395-evk-ufs must be treated as a
> separate board.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> Changes for v2:
>  - No change.
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
 Base: tags/next-20250722 (best guess, 3/4 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250722085811.2062790-1-macpaul.lin@mediatek.com:

Error: arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dts:17.1-8 Label or path ufshci not found
FATAL ERROR: Syntax error parsing input tree
make[3]: *** [scripts/Makefile.dtbs:131: arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dtb] Error 1
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/mediatek] Error 2
make[2]: Target 'arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: mediatek/mt8395-genio-1200-evk-ufs.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'mediatek/mt8183-pumpkin.dtb' not remade because of errors.
make: Target 'mediatek/mt6797-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-kodama-sku16.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-fennel14.dtb' not remade because of errors.
make: Target 'mediatek/mt8395-genio-1200-evk.dtb' not remade because of errors.
make: Target 'mediatek/mt7986a-bananapi-bpi-r3.dtb' not remade because of errors.
make: Target 'mediatek/mt8173-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt7986b-rfb.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-willow-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-tentacruel-sku262144.dtb' not remade because of errors.
make: Target 'mediatek/mt8195-cherry-tomato-r2.dtb' not remade because of errors.
make: Target 'mediatek/mt7981b-openwrt-one.dtb' not remade because of errors.
make: Target 'mediatek/mt8173-elm.dtb' not remade because of errors.
make: Target 'mediatek/mt7622-rfb1.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-damu.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-willow-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-tentacool-sku327681.dtb' not remade because of errors.
make: Target 'mediatek/mt6779-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku4.dtb' not remade because of errors.
make: Target 'mediatek/mt8173-elm-hana-rev7.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-starmie-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt8370-genio-510-evk.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-voltorb.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-kenzo.dtb' not remade because of errors.
make: Target 'mediatek/mt2712-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8395-genio-1200-evk-ufs.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-tentacool-sku327683.dtb' not remade because of errors.
make: Target 'mediatek/mt7981b-cudy-wr3000-v1.dtb' not remade because of errors.
make: Target 'mediatek/mt8192-asurada-hayato-r1.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-ponyta-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt8390-genio-700-evk.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt8395-kontron-3-5-sbc-i1200.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-pico6.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt8195-demo.dtb' not remade because of errors.
make: Target 'mediatek/mt8173-elm-hana.dtb' not remade because of errors.
make: Target 'mediatek/mt6755-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-chinchou-sku16.dtb' not remade because of errors.
make: Target 'mediatek/mt8192-asurada-spherion-r0.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-chinchou-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-kodama-sku32.dtb' not remade because of errors.
make: Target 'mediatek/mt7622-bananapi-bpi-r64.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-chinchou-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-magneton-sku393218.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku7.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-magneton-sku393216.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku3.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dtb' not remade because of errors.
make: Target 'mediatek/mt6797-x20-dev.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-cozmo.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-krane-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt8365-evk.dtb' not remade because of errors.
make: Target 'mediatek/mt8195-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8395-radxa-nio-12l.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-steelix-sku131073.dtb' not remade because of errors.
make: Target 'mediatek/mt7988a-bananapi-bpi-r4.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-starmie-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-burnet.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku6.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-ponyta-sku1.dtb' not remade because of errors.
make: Target 'mediatek/mt7986a-acelink-ew-7886cax.dtb' not remade because of errors.
make: Target 'mediatek/mt8516-pumpkin.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-kakadu-sku22.dtb' not remade because of errors.
make: Target 'mediatek/mt7986a-rfb.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-kodama-sku288.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-krane-sku176.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku0.dtb' not remade because of errors.
make: Target 'mediatek/mt6795-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt7988a-bananapi-bpi-r4-2g5.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-tentacruel-sku262148.dtb' not remade because of errors.
make: Target 'mediatek/mt8167-pumpkin.dtb' not remade because of errors.
make: Target 'mediatek/mt7981b-xiaomi-ax3000t.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku2.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-steelix-sku131072.dtb' not remade because of errors.
make: Target 'mediatek/mt8195-cherry-dojo-r1.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-kappa.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-kakadu.dtb' not remade because of errors.
make: Target 'mediatek/mt7986a-bananapi-bpi-r3-mini.dtb' not remade because of errors.
make: Target 'mediatek/mt6795-sony-xperia-m5.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-magneton-sku393217.dtb' not remade because of errors.
make: Target 'mediatek/mt8192-evb.dtb' not remade because of errors.
make: Target 'mediatek/mt8195-cherry-tomato-r3.dtb' not remade because of errors.
make: Target 'mediatek/mt8195-cherry-tomato-r1.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-katsu-sku32.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-katsu-sku38.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-squirtle.dtb' not remade because of errors.
make: Target 'mediatek/mt8188-geralt-ciri-sku5.dtb' not remade because of errors.
make: Target 'mediatek/mt8186-corsola-rusty-sku196608.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-jacuzzi-pico.dtb' not remade because of errors.
make: Target 'mediatek/mt8183-kukui-kodama-sku272.dtb' not remade because of errors.






