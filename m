Return-Path: <linux-kernel+bounces-731979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18EB06047
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BAE5005D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE922EF9AE;
	Tue, 15 Jul 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RQlBVBSM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D727470;
	Tue, 15 Jul 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587834; cv=none; b=arnBr3jdpwdGC5Ij3NkN/nh/vnMksIItX+Ng5I2BB7bL+MpkL2NLXAOpOLLmoz0Rj0+Imcq4OpwnpRXySqPARqrb9AomTjf7IFcinnf/8zONP5IFu5N9puZjofJEBWb+wwuSQPPU5ghGyuJRZfyHW/TG87/6DDroLzmUGiYmK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587834; c=relaxed/simple;
	bh=VcoITfCDsF67h3hBQmDuBarBljyPQh2YV8UKRsZfVmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8sb8w/uRhOtZHU9HRe8Fdrkusj4YMq7ZDJVGOdtVnOE9x45sTVqFkH/+TZlmnRcrO1bI1p7vPMjX7EUwCAggtJu2q7nbEqf6xNpE6o4MulYB6JEj6f2QaLDTuo8H5PnMxPyeqi2noPTnp8I9cAi6dadBUhQ3YzSIyZm4BqjBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RQlBVBSM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752587830;
	bh=VcoITfCDsF67h3hBQmDuBarBljyPQh2YV8UKRsZfVmo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQlBVBSMdmKKKX3dY5vPWcDUMiXRwa8DBqYjx2o5An3IXCbDXsBri6CUZUaaDSCT1
	 D6afaCOZhejdPJyj6mKp1UKMgF3rUX70AUNYmS8PcqTEtfgjjzlgUM08C+yy/o/Riq
	 w7bVG+lg6xbtaZ4N3JMWsGWoXupNJomHfFG+Ry5cRZjCI99eQVEBGSxF8OZ7fEghcW
	 YWDueW5aCWEhItpy+8luatBmaqdCMmnfSMu75gominLtK4KUOinCy1rcPa2VVXtglS
	 JryzLWDVyKCFdIkfGDNTDyMgCfRVs9t6G7oi1ZQkdB4XULWLzlfMo/U23SNp85E8ot
	 tBCXuotie9wYA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0962317E1293;
	Tue, 15 Jul 2025 15:57:09 +0200 (CEST)
Message-ID: <4facd10a-f46f-4cb9-bdef-71cc88ebc059@collabora.com>
Date: Tue, 15 Jul 2025 15:57:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] dt-bindings: mfd: Add binding for MediaTek MT6363
 series SPMI PMIC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: broonie@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org,
 matthias.bgg@gmail.com, conor+dt@kernel.org, wenst@chromium.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 krzk+dt@kernel.org, lgirdwood@gmail.com
References: <20250715115718.176495-1-angelogioacchino.delregno@collabora.com>
 <20250715115718.176495-8-angelogioacchino.delregno@collabora.com>
 <175258775126.1133153.9935401889666941502.robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <175258775126.1133153.9935401889666941502.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/07/25 15:55, Rob Herring (Arm) ha scritto:
> 
> On Tue, 15 Jul 2025 13:57:17 +0200, AngeloGioacchino Del Regno wrote:
>> Add a binding for the MediaTek MT6363/6373 (and similar) multi
>> function PMICs connected over SPMI.
>>
>> These PMICs are found on board designs using newer MediaTek SoCs,
>> such as the Dimensity 9400 Smartphone chip, or the Chromebook
>> MT8196 chip.
>>
>> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> Link: https://lore.kernel.org/r/20250623120038.108891-2-angelogioacchino.delregno@collabora.com
>> Link: https://lore.kernel.org/r/20250707134451.154346-8-angelogioacchino.delregno@collabora.com
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../bindings/mfd/mediatek,mt6363.yaml         | 110 ++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6363.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: pmic@4 (mediatek,mt6363): adc@1000: 'reg' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: pmic@4 (mediatek,mt6363): regulators@30: 'oneOf' conditional failed, one must be fixed:
> 	'reg' does not match any of the regexes: '^buck-(sshub[124]|vb[1-7]|vs[1-3])$', '^ldo-v(aux|m|rf-io|tref)18$', '^ldo-va(12-1|12-2|15)$', '^ldo-vcn(13|15)$', '^ldo-vio(0p75|18)$', '^ldo-vrf(0p9|12|13|18)$', '^ldo-vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$', '^ldo-vufs(12|18)$', '^pinctrl-[0-9]+$'
> 	'reg' does not match any of the regexes: '^pinctrl-[0-9]+$', '^v(ant|aud|aux)18$', '^v(cn18io|efuse|ibr|io28|sram-digrf-aif|usb)', '^v(f|t)p', '^vbuck([0123456789]|4-ufs)$', '^vbuck4(-ufs)?$', '^vcn33-[123]$', '^vmc(h)?$', '^vmch-(eint-low|eint-high)?$', '^vrf(09|12|13|18|io18)-aif$', '^vsim[12]$'
> 	'mediatek,mt6373-regulator' was expected
> 	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6363.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: regulators@30 (mediatek,mt6363-regulator): 'reg' does not match any of the regexes: '^buck-(sshub[124]|vb[1-7]|vs[1-3])$', '^ldo-v(aux|m|rf-io|tref)18$', '^ldo-va(12-1|12-2|15)$', '^ldo-vcn(13|15)$', '^ldo-vio(0p75|18)$', '^ldo-vrf(0p9|12|13|18)$', '^ldo-vsram-(apu|cpub|cpum|cpul|digrf|mdfe|modem)$', '^ldo-vufs(12|18)$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6363-regulator.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt6363.example.dtb: adc@1000 (mediatek,mt6363-auxadc): 'reg' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250715115718.176495-8-angelogioacchino.delregno@collabora.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Uff. I've sent the wrong series. Sorry for the noise.

Sending v5 asap.

Sorry again,
Angelo

