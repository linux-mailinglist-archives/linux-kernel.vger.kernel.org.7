Return-Path: <linux-kernel+bounces-839931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3AEBB2C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEC7189C81C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF92C08CD;
	Thu,  2 Oct 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d/u8+HlQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84071D88A6;
	Thu,  2 Oct 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392117; cv=none; b=HY2Nhs1AK5lCySsoENR7WnceIhEVUt0Cp8FRABlTryXUP3BHKJZmKE0zDgc+wfCM/pWTDSzjohRFApWuCC5cuUSuDH8tHBEEliaiYLyewAGVL1qsgRo85xTR8XQNMKsPRWp+4Dri0VfYlVSSSuvDWN+ykDiOMkjnY0GcPSeN6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392117; c=relaxed/simple;
	bh=Hr60drvLfL1YnuE4KY5/qlJit8NkSU47rT83xTzVQdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L2MvVBmBEQXgs5lMbDgVn9oAprtVf2cAetxs2+d0bGrwlk3jsHsQ4+dJopz32DYGvKySqgVGid6oDV91dC9rpEsPOVr43VuGZq7el5+lrDUKU+P439FkVJI8AhPebj7Xt5W1BCJ33zE8WX3gaKiAP9UnbapaGB0qsWc7uWGIiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d/u8+HlQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759392113;
	bh=Hr60drvLfL1YnuE4KY5/qlJit8NkSU47rT83xTzVQdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d/u8+HlQ67vxa1gJdWO61ZfwqBsj1e2ZElsUb60KjXiUbvJ4qmXGss70wU9RjDaH+
	 p62WaCtaIwoypiQfBJw8qRFyHofPfaKMAMpADrFEGwpOniIQB6Ss/G+lixLZTlotIh
	 G9RGIWiDepWsNZ7lgyPhR4BMumef6/6GdIyOyrnanP8vVaSSQNmxXdGaw5UlE3Amh/
	 qiO1qflTR9B6JlE9O6lgOCgQATvR6syetO95kpmnazYDRUps4D4qpTQYlLr3qZRzxg
	 9R4wuOdOdP8vjfsZ2MurG4quvfJDMBHIUFJ7a0a/uwf5J+vJBPO1PKKz4vQjGnzDD8
	 IQXFRFKpkj6CA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C91617E038B;
	Thu,  2 Oct 2025 10:01:53 +0200 (CEST)
Message-ID: <c14d80e9-f383-4311-afa7-4d2879e1e4cb@collabora.com>
Date: Thu, 2 Oct 2025 10:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
To: Rob Herring <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org,
 igor.belwon@mentallysanemainliners.org
References: <20251001111316.31828-1-angelogioacchino.delregno@collabora.com>
 <20251001111316.31828-2-angelogioacchino.delregno@collabora.com>
 <20251001154537.GA1833526-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251001154537.GA1833526-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 01/10/25 17:45, Rob Herring ha scritto:
> On Wed, Oct 01, 2025 at 01:13:08PM +0200, AngeloGioacchino Del Regno wrote:
>> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
>> usually found in board designs using the MT6991 Dimensity 9400 and
>> on MT8196 Kompanio SoC for Chromebooks.
>>
>> This chip is fully controlled by SPMI and has multiple variants
>> providing different phase configurations.
>>
>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>> Link: https://lore.kernel.org/r/20250715140224.206329-2-angelogioacchino.delregno@collabora.com
> 
> Why do we want a link to v5 here in the git history forever? You've seen
> Linus' recent comments on Link usage?
> 

Yes, I've seen that, and I fully agree with him.

That was a mistake and was totally unintentional - I actually wanted to, but then
forgot to, remove the links.

I really have to spend those 5 minutes to configure b4 correctly.

Sorry about that, will fix in v7.

>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../regulator/mediatek,mt6316b-regulator.yaml | 46 +++++++++++++++++++
>>   .../regulator/mediatek,mt6316c-regulator.yaml | 46 +++++++++++++++++++
>>   .../regulator/mediatek,mt6316d-regulator.yaml | 41 +++++++++++++++++
>>   3 files changed, 133 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316c-regulator.yaml
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6316d-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>> new file mode 100644
>> index 000000000000..e7a6b70cdab2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6316b-regulator.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6316b-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek MT6316 BP/VP SPMI PMIC Regulators
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  The MediaTek MT6316BP/VP PMICs are fully controlled by SPMI interface, both
>> +  feature four step-down DC/DC (buck) converters, and provides 2+2 Phases,
>> +  joining Buck 1+2 for the first phase, and Buck 3+4 for the second phase.
>> +
>> +properties:
>> +  compatible:
>> +    const: mediatek,mt6316b-regulator
>> +
>> +  vbuck12:
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +
>> +  vbuck34:
>> +    type: object
>> +    $ref: regulator.yaml#
>> +    unevaluatedProperties: false
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    pmic {
>> +      regulators {
>> +        compatible = "mediatek,mt6316b-regulator";
>> +
>> +        vbuck12 {
>> +          regulator-min-microvolt = <450000>;
>> +          regulator-max-microvolt = <965000>;
>> +          regulator-always-on;
>> +        };
>> +      };
>> +    };
> 
> One complete example for the pmic please rather than incomplete child
> node examples.
> 

Thanks for making me notice - actually, this example is even wrong... as I
eventually changed the node, but for whatever reason I completely forgot
about updating the binding. UGH.

The MT6316(x) are PMICs themselves, providing only regulators.

I'll come up with a decent example.

Cheers,
Angelo


