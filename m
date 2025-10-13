Return-Path: <linux-kernel+bounces-850243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3364ABD255E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FCC84E24B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25C2FE045;
	Mon, 13 Oct 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghOvtoQE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047A26290;
	Mon, 13 Oct 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348490; cv=none; b=QiN3+OhT52yrp8oaW5ThkS6WuYJPd21NHO645CF/0VTREOGpHsduISlVqDN44mAO0hjn4h8164En0KoT75189hZy4lLWOyunBfx4ZffTvl0maJvDzcKmLm8dMEjHr5OX+/d3AX1HIsgirwfCNK9A6PDTUmnEklVhex6DeqNgXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348490; c=relaxed/simple;
	bh=JBGlttPgEcGlkaapqMF5MSjaQ9HOMIlfMMQ6JxCDE5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEuvRexpzKfxKKN5VCta0Ng3WBdMMO7q9M3vAcjRx/sSVRR1fZAMkI33yBqy+sCqcQ0ZWCJkTiNAHC4nxsei8L9n1S5kSHPg/YX6DNyjmKzQH2DoXnb01aHam4GksroGsKn+ou0TS6R/5kPM5BshQB3Fg+fekO5dxChy2Kzl9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghOvtoQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3123C4CEE7;
	Mon, 13 Oct 2025 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348490;
	bh=JBGlttPgEcGlkaapqMF5MSjaQ9HOMIlfMMQ6JxCDE5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ghOvtoQEypW4ImDFAnvNW097AJNEiEI/mn84ZnGrE7duaFTXttFY6ynUP93zxgcoN
	 UVSCSBCgW6w5yEA15RO2jl1IKoot9Brls/zcCsAM/URqQE+M1fvIkglh516Nu6BhFF
	 9qLJ+Nl/qjjbbJkx0ibduyp0LAOwDbWKaTboOc8LekZCPQN4oN28yCNe6tZJ+39u9a
	 RJCI7tL0xK6TBhCQfiE8689ET2H3LItOVUqHvX6W6f2uVcILc6CisSIKQ3b+rsAVrN
	 A+XRIVhG+HweZs2RCCu1hcWiwxX9J5nqBQuiz+Oi8ccvAnBefn8qfon8Xp4DnZ9Y8e
	 tbq3D6U5syqFA==
Message-ID: <4c974736-f257-42a5-9d39-801a579d9771@kernel.org>
Date: Mon, 13 Oct 2025 11:41:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add support for Grinn GenioSBC-510/700 boards
To: Mateusz Koza <mateusz.koza@grinn-global.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com, andrew@lunn.ch,
 robh@kernel.org
References: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Content-Language: en-US
In-Reply-To: <20250909163052.446723-1-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 09/09/25 18:30, Mateusz Koza ha scritto:
> This patch series adds support for Grinn GenioSBC-510 and GenioSBC-700
> boards based on MediaTek MT8370 and MT8390 SoCs, respectively. It
> includes device tree files for both boards, updates to the device tree
> bindings, and necessary modifications to the Makefile.
> 
> As far as I know, <angelogioacchino.delregno@collabora.com> has access
> to the schematics for these boards, as we've shared them under NDA with
> Collabora.
> 
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
> ---
> v2:	Fixed the subject prefixes,
> 	Fixed alignment in dts files,
> 	Added missing SPDX-License-Identifier,
> 	Fixed the ordering in dt-bindings,
> 	Dropped redundant info from commit messages,
> 	Run checkpatch.pl on the patchset and fixed the issues,
> 	as suggested by Krzysztof Kozlowski <krzk@kernel.org>.
> 
> v3:	Changed eth phy-mode to 'rgmii-id',
> 	Changed eth mediatek,tx-delay-ps to 30,
> 	as suggested by Andrew Lunn <andrew@lunn.ch>.
> 
> v4:	Removed the nodes that are not present in upstream,
> 	as suggested by Louis-Alexis <angelogioacchino.delregno@collabora.com>.
> 
> 	Added default pinctrl to ssusb0,
> 	Enabled the scp_cluster node,
> 	as suggested by Bartosz Biłas <b.bilas@grinn-global.com>.
> 
> v5:	Did NOT move the chasis-type - Error: Properties must precede subnodes,
> 	Swapped underscores to commas in regulator names,
> 	Reordered properties (generic -> vendor -> status),
> 	Dropped the firmware property from the scp_c0 node,
> 	Added interrupts-extended to the pmic node,
> 	Dropped the mt6359key handle,
> 	Added blank spaces before the memory nodes,
> 	as suggested by AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Bartosz Bilas (1):
>    arm64: dts: mediatek: mt8370-grinn-genio-510-sbc: Add Grinn
>      GenioSBC-510
> 
> Mateusz Koza (3):
>    arm64: dts: mediatek: mt8390-genio-700-evk: Add Grinn GenioSBC-700
>    dt-bindings: arm: mediatek: Add grinn,genio-700-sbc
>    dt-bindings: arm: mediatek: Add grinn,genio-510-sbc
> 
>   .../devicetree/bindings/arm/mediatek.yaml     |   2 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>   .../mediatek/mt8370-grinn-genio-510-sbc.dts   |  20 +
>   .../mediatek/mt8390-grinn-genio-700-sbc.dts   |  20 +
>   .../dts/mediatek/mt8390-grinn-genio-sbc.dtsi  | 538 ++++++++++++++++++
>   .../dts/mediatek/mt8390-grinn-genio-som.dtsi  | 210 +++++++
>   6 files changed, 792 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-700-sbc.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-grinn-genio-som.dtsi
> 

Patches 1, 3 applied to v6.18-next/dts64

Thanks!

