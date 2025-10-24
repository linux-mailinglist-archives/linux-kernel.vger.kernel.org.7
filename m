Return-Path: <linux-kernel+bounces-868571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3489C05864
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2AE3B1B93
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3EF30E83C;
	Fri, 24 Oct 2025 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC52BhPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D830E0F1;
	Fri, 24 Oct 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300604; cv=none; b=QkFbLzXxFE1aB1bckkgzkMrtoM9D/PXcZks4Pr5O6HM4RdV/Rht92LDmDm/KMFlZKItDRPW3YcpHBzhI0PtZ6vwC92Ye/wb/6T+qFnkxC47ULbOrKuZUKVMuPXAnvcwfYAewAgo1jppVsTIF6Bo1fPNkxXEhvmlPQQEeL3gWs7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300604; c=relaxed/simple;
	bh=h8OjTFqpeqF+Jo/iQAP6DDq4pBZz0197mn1PnYimu44=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=lXwAzLTTUYEwxH0tZ3qGNNSUs3IaIYn2bSEjDG1uGDMt1O+5YYQIvgxeZ9z8mixyuvnKxLWXvuInsfhSJwx0jPkYOcGnbLsQYKWh9ruMIPEpJDwV5qxdXDiHJ2+5JJDKcVpuSmAm9HdNeTzfwj2P+IeZn8lft0M3zRiBQ2BCPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC52BhPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52798C4CEF1;
	Fri, 24 Oct 2025 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761300603;
	bh=h8OjTFqpeqF+Jo/iQAP6DDq4pBZz0197mn1PnYimu44=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=vC52BhPZm7KGfPtJnth+IMAIqNx18X//zP6XDw3jR+vj8StfXD51PtSRO9Ag2oto3
	 3DjaM01UZxrN5JTMumBsqRayoHYaA9+bDLMuXS6gKc/WEiZka+ClgMOXl6E51F8Ajo
	 xWOQPvexiX+4CnmycAYxO1EyrhWd/i9+saW6OfkBzF8JVkqNVxq3HmIUeZztT46LvR
	 lDvEhEGaxz1Gy0bFgiTq/FORHhbSQDAHVCYIBvzIzR63ePHxNBTnKd9paanSajUzdv
	 RhKuhmr2DF4fL9ZgzUIwNgYX/wn1BeAsxeVAec64KGvsP20agdpLF7eIvketO8UtZ1
	 hyRprz8hW+Qnw==
Date: Fri, 24 Oct 2025 05:10:01 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: lgirdwood@gmail.com, conor+dt@kernel.org, matthias.bgg@gmail.com, 
 kernel@collabora.com, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 igor.belwon@mentallysanemainliners.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 broonie@kernel.org, linux-mediatek@lists.infradead.org, wenst@chromium.org, 
 lee@kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>
References: <20251024083221.25758-1-angelogioacchino.delregno@collabora.com>
 <20251024083221.25758-2-angelogioacchino.delregno@collabora.com>
Message-Id: <176130060160.1071538.6669975917646919183.robh@kernel.org>
Subject: Re: [PATCH v10 1/9] dt-bindings: regulator: Document MediaTek
 MT6316 PMIC Regulators


On Fri, 24 Oct 2025 10:32:13 +0200, AngeloGioacchino Del Regno wrote:
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
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316c-regulator.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.example.dtb: pmic@8 (mediatek,mt6316b-regulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$', '^vbuck(12|34)$'
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316b-regulator.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.example.dtb: pmic@7 (mediatek,mt6316d-regulator): '#address-cells' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6316d-regulator.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251024083221.25758-2-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


