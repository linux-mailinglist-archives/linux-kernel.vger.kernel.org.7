Return-Path: <linux-kernel+bounces-867089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95348C018F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636C6500AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2932142E;
	Thu, 23 Oct 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3vN6tmz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1F320A3E;
	Thu, 23 Oct 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227520; cv=none; b=OdaD6BzrCKoL/gwguYmtXpS+NbTUA59/6maQPRjDWef+/gaHZqhRCjbT9VBQYwkfomZRDJ1bPNuEp2J+p6kPwGXVdtM/SY1Q6YXs8NyUU3MK9CfpXZFRrL5/3OtyfzemROoKBCa7YQ8zXRCNkSnkFPpln6h9xXr7Vl9HuKkqv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227520; c=relaxed/simple;
	bh=+aURh5XSJ5XQcVDuus3rnZXEl2bPZX3zTBjzeKoakHc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=C0vLFmtkCILd65rRdJyJmZLty6VoOt7FUnMoAZjitt+bfRxMFKC86Q4vVwVLBG8kqPgGMaPC6tp7xjBKHj/Q6yvcjgKgOfJiNt9XdmOz+Kb4r9XT6COtEa3H6lmwrlmRM3ERVTOe2aGSlQBaRX2Jy2hmpNVUDHKB6RVCuj1X8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3vN6tmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D25C4CEE7;
	Thu, 23 Oct 2025 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227519;
	bh=+aURh5XSJ5XQcVDuus3rnZXEl2bPZX3zTBjzeKoakHc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=C3vN6tmz64b32YiU9KV5tcYgLyT2HBEnKpNNHF1bUG79/0r/UxyZzaTZHd+DSxhYb
	 bnZ8+IOrq/XlexDq8QYPlYVvvTDM0I4A3gHCWG4x0K8j/VLjb3p6gPwuKRB7+iV/yf
	 CWExmGwSxFcFflbAE3puyOAVVZ+p35ABydHDGmZ2JTa/Y7UJonoQv2nGns4lM25HmJ
	 pN8Gjv9czNRcNl84nWIM3UUZjee9iO+9xq3HBH8PFXp3TR9AvWvHvosHEjsk6ZHMpI
	 /EDKLgoRHTFg0riEEFjQyZunPG5Kjvysegx6dICinCYL+uDxvk8qsfu531rjTG3iaP
	 JdXjNHCcx/ssg==
Date: Thu, 23 Oct 2025 08:51:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
References: <20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com>
Message-Id: <176122700723.2723267.1526103667842275891.robh@kernel.org>
Subject: Re: [PATCH 0/2] dts: imx: cleanup warning cause by fsl,mpl3115


On Wed, 22 Oct 2025 16:43:20 -0400, Frank Li wrote:
> After commit f11e4374b(dt-bindings: iio: pressure: add binding for mpl3115 )
> vdd-supply and vddio-supply is required properties.
> 
> thread:
> https://lore.kernel.org/imx/0e00bb14-19c7-493a-9629-354bac3a273e@baylibre.com/T/#t
> not prefer change both to optional. So update dts to fix CHECK_DTB
> warnings for both ARM and ARM64 platform.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (2):
>       arm64: dts: imx8: add vdd-supply and vddio-supply for fsl,mpl3115
>       ARM: dts: imx: add vdd-supply and vddio-supply for fsl,mpl3115
> 
>  arch/arm/boot/dts/nxp/imx/imx53-ppd.dts         | 2 ++
>  arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi    | 3 ++-
>  arch/arm/boot/dts/nxp/imx/imx6q-bx50v3.dtsi     | 4 ++++
>  arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dts | 2 ++
>  arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dts  | 2 ++
>  arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts         | 2 ++
>  arch/arm/boot/dts/nxp/imx/imx7s-warp.dts        | 9 +++++++++
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts    | 9 +++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   | 9 +++++++++
>  9 files changed, 41 insertions(+), 1 deletion(-)
> ---
> base-commit: c31b21db1c04ba719c3889a57873f0f7eff54670
> change-id: 20251022-fsl-mpl3115-3bb541a56122
> 
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
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
 Base: base-commit c31b21db1c04ba719c3889a57873f0f7eff54670 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/v6.18-rc1-10-gc35cf4fe4b85 (exact match)
 Base: tags/v6.18-rc1-10-gc35cf4fe4b85 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/nxp/' for 20251022-fsl-mpl3115-v1-0-93187d095efc@nxp.com:

arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx7d-sdb.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx6q-b850v3.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx6q-b450v3.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx7d-sdb-reva.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx7s-warp.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx7d-pico-dwarf.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx7d-sdb-sht11.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx6q-b650v3.dtb: mpl3115@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml
arch/arm/boot/dts/nxp/imx/imx53-ppd.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply', 'vddio-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml






