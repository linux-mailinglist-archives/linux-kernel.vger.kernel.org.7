Return-Path: <linux-kernel+bounces-720185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CE2AFB853
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A9D1AA48D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FACB227563;
	Mon,  7 Jul 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub1JBSsk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74D225A37;
	Mon,  7 Jul 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904328; cv=none; b=X2C9Cjl/0vmWY/FHqG1BHcrFgMnB+vrkWPf+s3Px7AhlFHZO10frdjB38ccE7LYspfhw9fS3ziP/UZSshDAbFq35ZQhvQi1+6g+XV7p32swXQ1aC275mRfGyfzhnV+gexxK6uzE3U5W5XdEke4XH79Ssqzd50rvHJxVjA1rE4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904328; c=relaxed/simple;
	bh=6+DlCZShCCm2vWXqcGuG+JxpWy1yB9P/j6LWHUPaMJI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YPRUhaYFFtH7qBkBXv1CUrVRw0TrnyxMKuXyyBdBgnRdMEd5Plnj18gURj6y/R4d68BzN6SsDVw/5e6/JzCzNXNFqHLqGx7O90kcigkFHnyLN/qYX00jJ7lnQ+A3qRJuq2G89492tDZ2xHTvirzGYiJhtv/jslLtWhOr5PlGVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub1JBSsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7537EC4CEE3;
	Mon,  7 Jul 2025 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904328;
	bh=6+DlCZShCCm2vWXqcGuG+JxpWy1yB9P/j6LWHUPaMJI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ub1JBSskxGSTTBFzn6QuUrTt5XUwVwcbqQl/odQ0pDoRC+nOEme6Gt4Vy3HYAMWy5
	 gxBC6Y0y9R8HHLu2j/aeSFM1EpMSo4KOWmpJ5oRCCa+Rme98w5QXuzIeGJeoLRUwYp
	 fJ19LbbnhsiQ5KW5LQFZZwkzkCMaDm6neVXEZARyv7CPidUkYMVSWxkPrFrNcotXnZ
	 0tI9EsZEdn+xK0gVPd1uWCEAMn3BHDuFhW7A0fnS6VyiGGNL8wwD96F2pjziga0rBr
	 bv8rzqepRb3ICNb0cLv5Xp3bEcCnxrkwBB3GKyrvcsMtm1kQljFzYE3mx25oJ8Pwal
	 QpNGmLtaoBDOg==
Date: Mon, 07 Jul 2025 11:05:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, lee@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 linux-mediatek@lists.infradead.org, broonie@kernel.org, lgirdwood@gmail.com, 
 devicetree@vger.kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250707134451.154346-8-angelogioacchino.delregno@collabora.com>
References: <20250707134451.154346-1-angelogioacchino.delregno@collabora.com>
 <20250707134451.154346-8-angelogioacchino.delregno@collabora.com>
Message-Id: <175190432757.3224115.4908550014922842797.robh@kernel.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: mfd: Add binding for MediaTek
 MT6363 series SPMI PMIC


On Mon, 07 Jul 2025 15:44:50 +0200, AngeloGioacchino Del Regno wrote:
> Add a binding for the MediaTek MT6363/6373 (and similar) multi
> function PMICs connected over SPMI.
> 
> These PMICs are found on board designs using newer MediaTek SoCs,
> such as the Dimensity 9400 Smartphone chip, or the Chromebook
> MT8196 chip.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Link: https://lore.kernel.org/r/20250623120038.108891-2-angelogioacchino.delregno@collabora.com
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6363.yaml         | 115 ++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: pmic@4 (mediatek,mt6363): adc:compatible:0: 'mediatek,mt6363-auxadc' is not one of ['mediatek,mt6357-auxadc', 'mediatek,mt6358-auxadc', 'mediatek,mt6359-auxadc']
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6363.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: pmic@4 (mediatek,mt6363): adc: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6363.yaml#
Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: /example-0/spmi/pmic@4/adc: failed to match any schema with compatible: ['mediatek,mt6363-auxadc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250707134451.154346-8-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


