Return-Path: <linux-kernel+bounces-750030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF848B15618
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1013D18A52E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0571288C16;
	Tue, 29 Jul 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m587MNY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6492877C1;
	Tue, 29 Jul 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832436; cv=none; b=N2Dz62xhV2QfxnwG/vxIscD8mifieUE3HvqLTm9jmFY2JSq6qFTqxSuPYl7fqoo529o8n9B9H9NYA4EgRUXbfrTo1vjMwmrZDzrPh1KBsZYNtc/lZGQ23ezPKHcPm+Ugq3NU4Q7jHKA9Gz5L/5OqvNXbGIE8ugrXp4V2wZsoGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832436; c=relaxed/simple;
	bh=bzcbXRGcR5ZlL1irSj4IgeNsQX/TLpHJlFs5OlX3x98=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=scBQu49xbRQgaHD0lTHsd3a4L9iczifpcdpJkF4ZrgltoHbY38afR+o1WtPmN37OVdbyTooo/uRj00haQ98/HN83QrlJ9VvsxLStdEd3w6DTTXHr3RZMGhrpA/b8HnEUl01G6jvrj/AcuPnmP2IXzIWtS2dG94j/8vWnvJUvLlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m587MNY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B80FC4CEF7;
	Tue, 29 Jul 2025 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753832435;
	bh=bzcbXRGcR5ZlL1irSj4IgeNsQX/TLpHJlFs5OlX3x98=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=m587MNY+7OnE9xu/Nrzk3L4s5s0O6JoZLNgTQaBS3KfmVCkgTWAGdbOu0VHgHhmmg
	 GeGKTK6Ody45FcPpSeGp8of2Tkx56YTd926xmhtD0yDcUIp7ViC17Y+sX96muoQszf
	 ryKei7zwJOwW884EyrAuuhkv/euf3ADurTwLFFVYXOWNPBFhfwIDuY/JAydt8DSRMk
	 XmOINJ0G6KrheTXmEvK6qUxTZnlTH6NA9/LYpEkZk0H6oiBJn5SUFCbVQVtElFMOUg
	 VihdqxHlgQ2k6m08loGu6BwPtjShhWUfU7L3myZQMFpdeleJ2K+OWMuPjGZSyn8kL7
	 uJprkotIeTUUw==
Date: Tue, 29 Jul 2025 18:40:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Macpaul Lin <macpaul@gmail.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, Ramax Lo <ramax.lo@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org, 
 Bear Wang <bear.wang@mediatek.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Pablo Sun <pablo.sun@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20250729093506.273337-1-macpaul.lin@mediatek.com>
References: <20250729093506.273337-1-macpaul.lin@mediatek.com>
Message-Id: <175383135876.1119178.16702228632604790873.robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm64: mediatek: add
 mt8395-evk-ufs board


On Tue, 29 Jul 2025 17:34:58 +0800, Macpaul Lin wrote:
> Add a compatible string for the MediaTek mt8395-evk-ufs board.
> This board is the origin Genio 1200 EVK already mounted two main storages,
> one is eMMC, and the other is UFS. The system automatically prioritizes
> between eMMC and UFS via BROM detection, so user could not use both storage
> types simultaneously. As a result, mt8395-evk-ufs must be treated as a
> separate board.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> Changes for v2:
>  - No change.
> 
> Changes for v3:
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
 Base: tags/next-20250729 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250729093506.273337-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dtb: pmic (mediatek,mt6359): '#sound-dai-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dtb: infra-iommu@10315000 (mediatek,mt8195-iommu-infra): interrupts: [[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long
	from schema $id: http://devicetree.org/schemas/iommu/mediatek,iommu.yaml#






