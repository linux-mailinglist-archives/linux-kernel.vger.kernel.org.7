Return-Path: <linux-kernel+bounces-856064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A07BE2FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1366B4FB09D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B84302CA2;
	Thu, 16 Oct 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYBd3f0e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E72D4803;
	Thu, 16 Oct 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612299; cv=none; b=M+qO5QNCfWLjC0SHgE/iZcxdOnUl/0ZweZAkYa/b8Vj9jOWivu96KXeHf3J9kFHhIo3sb5gpPwXmHKHvqKu/G+pqYZCVbxU6LAcvMSyj39vVTyusVdujUE0lUV18QzuuSgrwwxHHphfbkCQgcjSfm66ArRmg7+6U/yij0xCaTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612299; c=relaxed/simple;
	bh=cIG0LBA0EBE4pS7e8v8i1abU52KH42lFqM/1hKG+T6g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qySxScIMyfwPZvpZjOhzTkxkayeuRHnLchoBOL2qXLbDAeiK2OgCNKnq0RcSyy/xWAc87FV2anMSv72UtH2QantGANWnA+Pof6bESRBFcUJVc2FJSReruTqvCNKWlWUYsb7Z/cKE15Jhs4rwCsQzSesTiU3vR3cjRsI1TfyyY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYBd3f0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77777C4CEF1;
	Thu, 16 Oct 2025 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760612298;
	bh=cIG0LBA0EBE4pS7e8v8i1abU52KH42lFqM/1hKG+T6g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=BYBd3f0ebCSEqSY4LkrtI2chwVdG0GQV1G2g4B5u+2iH3pLG9kYf0TC/ID6fo0Gi4
	 ryaH3/5tOCaI5/Mp49yRY/Ef2LCzCJkvw5tS9ZT7pzsL64mhp33fgCd0rYxpLoGRko
	 zlHNDp3AbhMG4GbNwZVFKugrNXZTWRw2LwTkaCfr3bF6YPfP6NlybRL/uWA8GvADmb
	 Js+ukJRejbcbpugBEi8Umjeo2kVPp7TwPVkSfYC1IRuB2iyyGWWND5IJi1wOnlHJPh
	 7Hs4S6Oz9OU0/ucPCyr7nwvfIobj1d3OPd2s4rfOvWT1Y4LFvVWywSs1lyVq1dwvlP
	 PSY6HLf/Sl+mg==
Date: Thu, 16 Oct 2025 05:58:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: broonie@kernel.org, igor.belwon@mentallysanemainliners.org, 
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, kernel@collabora.com, 
 matthias.bgg@gmail.com, wenst@chromium.org, devicetree@vger.kernel.org, 
 krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, conor+dt@kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20251016093054.126293-2-angelogioacchino.delregno@collabora.com>
References: <20251016093054.126293-1-angelogioacchino.delregno@collabora.com>
 <20251016093054.126293-2-angelogioacchino.delregno@collabora.com>
Message-Id: <176061229682.2195705.7053755296248416631.robh@kernel.org>
Subject: Re: [PATCH v9 1/9] dt-bindings: regulator: Document MediaTek
 MT6316 PMIC Regulators


On Thu, 16 Oct 2025 11:30:46 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
> 
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6316b-regulator.yaml | 78 +++++++++++++++++++
>  .../regulator/mediatek,mt6316c-regulator.yaml | 78 +++++++++++++++++++
>  .../regulator/mediatek,mt6316d-regulator.yaml | 77 ++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.example.dtb: pmic@6 (mediatek,mt6316c-regulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$', '^vbuck(124|3)$'
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316c-regulator.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.example.dtb: pmic@8 (mediatek,mt6316b-regulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$', '^vbuck(12|34)$'
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316b-regulator.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.example.dtb: pmic@7 (mediatek,mt6316d-regulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316d-regulator.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251016093054.126293-2-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


