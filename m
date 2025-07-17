Return-Path: <linux-kernel+bounces-735088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA94B08AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5E67B0661
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFD29992E;
	Thu, 17 Jul 2025 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ntDdZyBH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCCB1DE8A3;
	Thu, 17 Jul 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748593; cv=none; b=DcCAjK35uFB20CSdjrC6oWEUMogwzt8mSTaqChf9uduI8m4Jd5SY6ovPQ23vEKqLhLGWSQitlbAKvo1dpLsOncjEz8cKfyFHIXz4ZYJMJddL0fNlcpKEnwimSib0tBQqFJrBsBTQX3jb74Xu/vvRk3l70SZB6x5508oJCXilBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748593; c=relaxed/simple;
	bh=xqQlXd0lb1r+JYcGwIbgeT/oRINSjbiPGiuQzE3If+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2OBFTcWjX/JwopKRdA3R7OKU1hd04Vkj8gHbJnbq9tVJifFaPq73sbKFHSU6SnczTZxebuy7HBxNU5KT5TeAl9mLPJzNQNhjX91DFGUAnVHTVGSqOjwIC4V7JqJ2KhG9SpB9owu0+gd7EerWnWrj5OIUqdM66CRGnzNSnPk3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ntDdZyBH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752748590;
	bh=xqQlXd0lb1r+JYcGwIbgeT/oRINSjbiPGiuQzE3If+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ntDdZyBHOgKnPOdEGQw/I5EL8KR2PXe6U3DisRLzypC795hgqWv+OLRQf+cWqSflJ
	 2YeI3EMt87mUa5Cg0s575h9jR8fm13kTDSxreIvCvw/lVco+wq4FdPBTk7yC0DHQqm
	 gV2pFTBonGcj0SPoICTLc4SrvRHRhgikxbb/HVonr+dl7pj+GKyMBnoUjd90nQcvkA
	 y6W+3henmYDkJKk4A6F/HhMNTa13xyIjYIN1RFNzhAMBiKoEKwnkrAW2xdC5FHB9I2
	 EpKeLcPsKbpTntbNSjiXw/dM72FLmBCfJJf96r9gbbpDTISuXkU8npuvY43xaSAOUa
	 /G34kMeufYjng==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4FAD317E0B72;
	Thu, 17 Jul 2025 12:36:29 +0200 (CEST)
Message-ID: <0089a5e5-4e16-4d30-8b56-3811a6d7af88@collabora.com>
Date: Thu, 17 Jul 2025 12:36:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: mediatek: Describe MT6789
 clock controllers
To: Krzysztof Kozlowski <krzk@kernel.org>, Arseniy Velikanov <me@adomerle.pw>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250715222221.29406-1-me@adomerle.pw>
 <20250716-manipulative-dormouse-of-current-9af4e6@krzk-bin>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250716-manipulative-dormouse-of-current-9af4e6@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/07/25 09:04, Krzysztof Kozlowski ha scritto:
> On Wed, Jul 16, 2025 at 02:22:20AM +0400, Arseniy Velikanov wrote:
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - mediatek,mt6789-afe
>> +          - mediatek,mt6789-camsys
>> +          - mediatek,mt6789-camsys-rawa
>> +          - mediatek,mt6789-camsys-rawb
>> +          - mediatek,mt6789-imgsys
>> +          - mediatek,mt6789-imp-iic-wrap-c
>> +          - mediatek,mt6789-imp-iic-wrap-en
>> +          - mediatek,mt6789-imp-iic-wrap-w
>> +          - mediatek,mt6789-ipesys
>> +          - mediatek,mt6789-mdpsys
>> +          - mediatek,mt6789-mfgcfg
>> +          - mediatek,mt6789-vdecsys
>> +          - mediatek,mt6789-vencsys
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    afe: clock-controller@11210000 {
>> +        compatible = "mediatek,mt6789-afe";
>> +        reg = <0x11210000 0x1000>;
>> +        #clock-cells = <1>;
>> +    };
>> +
> 
> Drop the rest of nodes. One example is enough. They are ALL THE SAME.
> 
> ...
> 
>> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml
>> new file mode 100644
>> index 000000000000..d6f70ee918ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt6789-sys-clock.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/mediatek,mt6789-sys-clock.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek System Clock Controller for MT6789
>> +
>> +maintainers:
>> +  - Arseniy Velikanov <me@adomerle.pw>
>> +
>> +description:
>> +  The Mediatek system clock controller provides various clocks and system configuration
>> +  like reset and bus protection on MT6789.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - mediatek,mt6789-apmixedsys
> 
> Why this does not fit existing binding file? Or Mediatek maintainers
> preference was to switch to one-binding-per-SoC?
> 

We have been using one binding per soc for sys-clock and multimedia clocks because
the sys-clock has multiple clock controllers in one macro-block, while all of the
multimedia (and peripheral, depending on the soc) are in different macro-blocks.
There are also some historical reasons which aren't really relevant anymore.

So, we do have mt{soc}-sys-clock.yaml, mt{soc}-clock.yaml - that's right.

> 
>> +          - mediatek,mt6789-topckgen
>> +          - mediatek,mt6789-infracfg-ao
>> +          - mediatek,mt6789-mcusys
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    mcusys: syscon@c530000 {
> 
> Drop unused labels, everywhere.
> 
> Also, node name is supposed to be clock or reset controller, not syscon.
> 

MCUSYS is all three - but please use clock-controller.

Cheers,
Angelo



