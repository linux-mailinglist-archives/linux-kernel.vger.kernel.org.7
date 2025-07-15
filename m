Return-Path: <linux-kernel+bounces-732190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 665FAB0633B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516C41AA2967
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B582E246BA5;
	Tue, 15 Jul 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQOsRPUg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CE2AD2D;
	Tue, 15 Jul 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594089; cv=none; b=O+kghZhT4jaEPFWI+mT6FBH09DcTHJplUZn3Rv/ZoRGTN5S2cOU0NLtrpiQFH1T5EGWvqujExUDWxsiVGTZnVFnbXFsayuUflYPTjVn2SPb+JTlL8ZKZRcsfmVMyyws0MERtrsiL0JQoRDRDt7/8US2MUUHqpvjnugwDL0h0k8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594089; c=relaxed/simple;
	bh=roilGmIfKYzXuFiRYwvO0+MCsCf6IWm8MYDEAQnmBAI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Dev7sVYVNcm0JiuhPHBU7+TCKkstU2ftrTOVB0FhOto19PDdpv28vitsWonLAPwj+6oMYSYZbhge2QNg8VV9fMyUBX9rLV2DS8u5sQcZ0nwfuBf902LNDy7IcIV8u8xsdrfiv7O7VXmOkWdiRK58+stwT3jwFmdySto0j5cGxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQOsRPUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A394FC4CEE3;
	Tue, 15 Jul 2025 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594088;
	bh=roilGmIfKYzXuFiRYwvO0+MCsCf6IWm8MYDEAQnmBAI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pQOsRPUg5Jz/V95mUCNaqMAGPHagKaUjLxLNXUM5i9JUT9YIRYP6qcjgRGo5pIsN1
	 UEoXjE0vMvamFXxvLqt7WOQ+KrSxj7B+TnxC9tZW3pmU2lxF5sraKFcgUhZg0d7Giq
	 tmOLwnn6G+cp6N34u9NXuiQWD9zzEZzXg9CjWROK4dC0Nvyquoxii02s40xSEQNGAQ
	 TsniATFy0bW+GdVcNAnHeHQfF0SjtWZr7+VblN7mLy0v9ZM0qD++W3xVJfDfqesI+P
	 wo9D+Nk1gb+xsaxDENYDspnGPmVXtpmK38zB5h1AtUXluAYclUGap7pdOHFr4yr1jB
	 Nppi7p1R+T7lg==
Date: Tue, 15 Jul 2025 10:41:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: broonie@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, linux-mediatek@lists.infradead.org, 
 lgirdwood@gmail.com, kernel@collabora.com, wenst@chromium.org, 
 linux-arm-kernel@lists.infradead.org, lee@kernel.org, 
 matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250715140224.206329-4-angelogioacchino.delregno@collabora.com>
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com>
 <20250715140224.206329-4-angelogioacchino.delregno@collabora.com>
Message-Id: <175259408592.1379929.8736544816494320074.robh@kernel.org>
Subject: Re: [PATCH v5 3/8] dt-bindings: regulator: Document MediaTek
 MT6363 PMIC Regulators


On Tue, 15 Jul 2025 16:02:19 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
> MT6373 PMICs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6363-regulator.yaml  | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.example.dts:27.21-22 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/regulator/mediatek,mt6363-regulator.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250715140224.206329-4-angelogioacchino.delregno@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


