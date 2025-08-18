Return-Path: <linux-kernel+bounces-774238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC72B2B034
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8895188838F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1209535083D;
	Mon, 18 Aug 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMbzHIJs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98D32C33C;
	Mon, 18 Aug 2025 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541485; cv=none; b=c/IAwyu1Q8MtNezKXLNothDhvFJMe/hnlgnW4k62g+YUKchJcWXYeGs6S2oVRHN8ansOlr0f72j9F0gme2DQknu63A17PQeajtYuWDlTYx4+MHfIBCxW4AEfwRy55RN1Bvu4j5KycBBfCxJtq6NSrNxPI7HI2Zj97kdiJi7njrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541485; c=relaxed/simple;
	bh=4E7/tvM7UPMpgvdt/3bB3bqKVp91MTbvwZbxq37l81M=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ovVJaWEBm8pyj/dlg1UL1wcQZ5TZamltCvoeI5AeAlSpOuryJVcXK4DIpVVxGUdGkg2FRSyesALvlK/acONQ+zAziLDDl3p7Dv5NshsM77Te3ejhdc9GW06S6tiBEG7ZI1WQ5c3kzSMyFI/sHSWoekehfrElvRTZ/mLR3gU/N4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMbzHIJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94013C4CEF1;
	Mon, 18 Aug 2025 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541484;
	bh=4E7/tvM7UPMpgvdt/3bB3bqKVp91MTbvwZbxq37l81M=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=OMbzHIJsg1qjpEdG3Jr/e0aQcqLAvXk9Kn/YXnirekX8oFapce3DBgPubg0oyGz1W
	 64PzfeT4765uZq2JLRp8vn3E6GXf7kfs+VvmVn/BWs8YAGt4jU/ODpFNVLfu7IkxDu
	 noswaI4kYeV0gDWbQMBJugFJnpSjRJ4QpYCaxvIgFiCoPMtDIbEPP67uMe68cE1dMq
	 LtLESV0Aq3YiepfA3R2DwpeKkiFLiqjO8Ef7ykulfMwEih773+mwO8nNBVVss5B33C
	 MD7zH4OCsriwOlkqhr8LagHgA2JLc3IVqZpG7sm+HmWdnppJK++QX3A1uKV+2PAVOj
	 N2gFaY+8s4aew==
Date: Mon, 18 Aug 2025 13:24:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Luke Wang <ziniu.wang_1@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, 
 Joy Zou <joy.zou@nxp.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.Li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
Message-Id: <175554055785.1719742.4035330946121256179.robh@kernel.org>
Subject: Re: [PATCH v2 00/11] arm64: dts: imx95: various updates


On Mon, 18 Aug 2025 09:25:30 +0800, Peng Fan wrote:
> This patchset is to upstream various downstream changes.
> - Correct edma channel for lpuart7/8
> - Add System Counter, SCMI LMM/CPU, V2X MU, coresight nodes
> - Update alias
> - Add pca9632, pf09/pf53 thermal and etc.
> 
> dtbs_check will report a few failures, such as linux,code, db suffix.
> The failures are not related to this patchset.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Drop patch 8 because dt-bindings not ready, and patch 12
> - Per Frank's comments: Typo fixes, node name updates, sort properties
> - Add R-b from Frank
> - There is still dtbs_check error, but not related to this patchset, it
> is because https://lore.kernel.org/imx/20250718094723.3680482-1-peng.fan@nxp.com/
> not applied.
> - Link to v1: https://lore.kernel.org/r/20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com
> 
> ---
> Joy Zou (1):
>       arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid
> 
> Luke Wang (1):
>       arm64: dts: imx95-15x15-evk: Change pinctrl settings for usdhc2
> 
> Peng Fan (8):
>       arm64: dts: imx95: Add System Counter node
>       arm64: dts: imx95: Add LMM/CPU nodes
>       arm64: dts: imx95: Add more V2X MUs
>       arm64: dts: imx95: Add OCOTP node
>       arm64: dts: imx95: Add coresight nodes
>       arm64: dts: imx95-evk: Update alias
>       arm64: dts: imx95-19x19-evk: Add pca9632 node
>       arm64: dts: imx95-19x19-evk: Add pf09 and pf53 thermal zones
> 
> Richard Zhu (1):
>       arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2 regulator
> 
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts |  29 +++-
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  94 ++++++++++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi          | 165 +++++++++++++++++++++-
>  3 files changed, 280 insertions(+), 8 deletions(-)
> ---
> base-commit: ff837884a4642382a24d10fd503acf2c3a472f10
> change-id: 20250813-imx9-dts-664f7ba66ae7
> 
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
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
 Base: base-commit ff837884a4642382a24d10fd503acf2c3a472f10 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/next-20250818 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com:

arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dtb: scmi (arm,scmi): Unevaluated properties are not allowed ('protocol@80', 'protocol@81', 'protocol@82', 'protocol@84' were unexpected)
	from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml#






