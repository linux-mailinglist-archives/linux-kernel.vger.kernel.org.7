Return-Path: <linux-kernel+bounces-839918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C0BB2BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00FC3424645
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687C52D0C75;
	Thu,  2 Oct 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fc5bfpOI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F81DD9AD;
	Thu,  2 Oct 2025 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391266; cv=none; b=gBVG59G9zsArRvC9ZtpYmt49qswMJ3uHPWFrMVXW263e2wd0qGZ8/bdYEhIP9s9RM9bB3RIxBbpAMBBPzxNSvPEQN+5b2vSKDBy9fMt19zFjdb2InG+F0IU0lSQ30Jly3nkkqvKWenTXjvYtjKYB6YKZ67sNWSPr+KC2ZxJ/SMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391266; c=relaxed/simple;
	bh=dI0wrkAckMH7G1m4ya3Dj7swPNyC71r0eGahUHaJytU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAOGV7yPOpORmpLjbqG5Hyk9JPlQTC1e9hvKT0XIqr6hKaaxiRJzv+BE7+7NUooRLd7mXGAwBdjsQX2PGPTk9f0ALmV8cqEKhwcBcy5EiaN2bcnZR9H2JIP5pNtRBYvTjcoBzkA344LclbMTZOx4Kpsc7NmS5pnpVJnpGbuHczA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fc5bfpOI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759391262;
	bh=dI0wrkAckMH7G1m4ya3Dj7swPNyC71r0eGahUHaJytU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fc5bfpOIErakjiawbB16GBvXBuIlkWOx6lN+lhFFd2c2EYdM3RMGjx2N67KBbKkpN
	 7PkU3vq1K8q9COKVq2uAXa1j5uyXD2eGedNVXUKGmLGUHYpAfB7wTnnJJoQJoQmGTk
	 Y6S3qS+xhO5/at0687V8duOoCnGKnvI9krkjVN7g7cuRHKh7UMRyGxzBS2XncgBzoz
	 PywfQNyp3y4GBa7mDDAYnxXj8lDAIUBetdeUNt5WEyn2B80LOA/K/3lu6eqOfR4Qyb
	 C24m2gWXQV8n/Cetp0eecCloTXmxVouVe+ERYiQvXBIztkFsDT8B7X3FvaUwukC5j9
	 tvZ7jYtqHpuMw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D22817E0AC3;
	Thu,  2 Oct 2025 09:47:42 +0200 (CEST)
Message-ID: <6d5553da-4c0e-4957-8d74-314a9ef23301@collabora.com>
Date: Thu, 2 Oct 2025 09:47:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] dt-bindings: regulator: Document MediaTek MT6373
 PMIC Regulators
To: Rob Herring <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org,
 igor.belwon@mentallysanemainliners.org
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
 <20251001111316.31828-6-angelogioacchino.delregno@collabora.com>
 <20251001155300.GC1833526-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251001155300.GC1833526-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/10/25 17:53, Rob Herring ha scritto:
> On Wed, Oct 01, 2025 at 01:13:12PM +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
>> usually found in board designs using the MT6991 Dimensity 9400 and
>> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
>> MT6363 PMICs.
>>
>> Link: https://lore.kernel.org/r/20250715140224.206329-6-angelogioacchino.delregno@collabora.com
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../regulator/mediatek,mt6373-regulator.yaml  | 137 ++++++++++++++++++
>>   1 file changed, 137 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
>> new file mode 100644
>> index 000000000000..cb721d81b77c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
>> @@ -0,0 +1,137 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6373-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek MT6373 PMIC Regulators
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  The MT6373 SPMI PMIC provides 10 BUCK and 23 LDO (Low DropOut) regulators
>> +  and can optionally provide overcurrent warnings with one ocp interrupt
>> +  for each voltage regulator.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt6373-regulator
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vsys-vbuck0-supply:
>> +    description: Input supply for vbuck0
>> +
>> +  vsys-vbuck1-supply:
>> +    description: Input supply for vbuck1
>> +
>> +  vsys-vbuck2-supply:
>> +    description: Input supply for vbuck2
>> +
>> +  vsys-vbuck3-supply:
>> +    description: Input supply for vbuck3
>> +
>> +  vsys-vbuck4-supply:
>> +    description: Input supply for vbuck4
>> +
>> +  vsys-vbuck5-supply:
>> +    description: Input supply for vbuck5
>> +
>> +  vsys-vbuck6-supply:
>> +    description: Input supply for vbuck6
>> +
>> +  vsys-vbuck7-supply:
>> +    description: Input supply for vbuck7
>> +
>> +  vsys-vbuck8-supply:
>> +    description: Input supply for vbuck8
>> +
>> +  vsys-vbuck9-supply:
>> +    description: Input supply for vbuck9
>> +
>> +  vs1-ldo1-supply:
>> +    description: Input supply for vant18, vaud18, vcn18io
>> +
>> +  vs2-ldo1-supply:
>> +    description: Input supply for vrf12-aif, vrf13-aif
>> +
>> +  vs3-ldo1-supply:
>> +    description: Input supply for vrf09-aif, vsram-digrf-aif
>> +
>> +  vsys-ldo1-supply:
>> +    description: Input supply for vcn33-1, vcn33-2, vmc
>> +
>> +  vsys-ldo2-supply:
>> +    description:
>> +      Input supply for vaux18, vcn33-3, vefuse, vfp, vibr, vio28, vtp, vusb
>> +
>> +  vsys-ldo3-supply:
>> +    description: Input supply for vmch, vmch-eint-high/low
>> +
>> +patternProperties:
>> +  "^v(ant|aud|aux)18$":
>> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
>> +
>> +  "^vbuck([0-9])$":
> 
> Don't need ().
> 
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    properties:
>> +      regulator-allowed-modes:
>> +        description: |
>> +          Allowed Buck regulator operating modes allowed. Valid values below.
>> +            0 - Normal mode with automatic power saving, reducing the switching
>> +                frequency when light load conditions are detected
>> +            1 - Forced Continuous Conduction mode (FCCM) for improved voltage
>> +                regulation accuracy with constant switching frequency but lower
>> +                regulator efficiency
>> +            2 - Forced Low Power mode for improved regulator efficiency, used
>> +                when no heavy load is expected, does not limit the maximum out
>> +                current but unless only a light load is applied, there will be
>> +                regulation accuracy and efficiency losses.
>> +            3 - Forced Ultra Low Power mode for ultra low load, this greatly
>> +                reduces the maximum output power, makes the regulator to be
>> +                efficient only for ultra light load, and greatly reduces the
>> +                quiescent current (Iq) of the buck.
>> +        maxItems: 3
>> +        items:
>> +          enum: [ 0, 1, 2, 3 ]
>> +    unevaluatedProperties: false
>> +
>> +  "^v(cn18io|cn33-[123]|efuse|fp|tp|ibr|io28|sram-digrf-aif|usb)":
> 
> Missing '$' anchor.
> 
>> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
>> +
>> +  "^vmc(h)?$":
> 
> Don't need ().
> 
>> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
>> +
>> +  "^vmch-eint-(low|high)?$":
> 
> vmch-eint- is a valid name?
> 

Whoops. No, that was supposed to allow vmch-eint-low, vmch-eint-high.

>> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
>> +
>> +  "^vrf(09|12|13|18|io18)-aif$":
>> +    $ref: "#/$defs/mediatek-mt6373-ldo-common"
>> +
>> +$defs:
>> +  mediatek-mt6373-ldo-common:
> 
> The name is local to the schema, so 'ldo-common' would be sufficient.
> 

Okay, I was trying to avoid pollution - but effectively being this local it's not
necessary to make this name that long.

Will come up with a v7 sooner than later.

Thanks!
Angelo

>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +    properties:
>> +      regulator-allowed-modes:
>> +        description: |
>> +          Allowed LDO regulator operating modes allowed. Valid values below.
>> +            0 - Normal mode with automatic power saving, reducing the switching
>> +                frequency when light load conditions are detected
>> +            2 - Forced Low Power mode for improved regulator efficiency, used
>> +                when no heavy load is expected, does not limit the maximum out
>> +                current but unless only a light load is applied, there will be
>> +                regulation accuracy and efficiency losses.
>> +        maxItems: 2
>> +        items:
>> +          enum: [ 0, 2 ]
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> -- 
>> 2.51.0
>>


