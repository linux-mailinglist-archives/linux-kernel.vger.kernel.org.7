Return-Path: <linux-kernel+bounces-820616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D759B7CE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171981B22F18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF0232BBE6;
	Wed, 17 Sep 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TYpfTG8X"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F342432BBED;
	Wed, 17 Sep 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111035; cv=none; b=s5pTnAdNAuAS773IbaZm4o2IjHsiqw5tIGlE9ivmb+KxKcMsu3egvdHUJ+0VlKqLCu0huw2Uipv1c3r1IarKq+0IkB/faI91wrtbKU9JWnvXivhnEP26WW7teP44yjwCZkneHt2vaNKvXtQkFqwS2oD7u+qARYshRrVDANJYMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111035; c=relaxed/simple;
	bh=hAQ+KeN3VG0PfLLgQCMRkpaPl35eqWnQFwZD5PcHz08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rktEqL6VVNcfI3QbTvroNjFjVaoFO88PVnZ6G5BDVPOy1hb7P0B2Q0DPFZILR3kkT6eH1YXH6/aVSaYYbjVVsI4lVVh4w7Js6NkHkH0eKw8YQm2j7Tub3hMcUqF0iDvCpTzWMklaEuPTTq+dhRLNkpqysvV/ACWYYc8fQpb1Ybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TYpfTG8X; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758111031;
	bh=hAQ+KeN3VG0PfLLgQCMRkpaPl35eqWnQFwZD5PcHz08=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TYpfTG8XL04KY+XUYVK5Pt3SCSUH1lzm0/hI+mgoqyqL112T0nyZ6rLa8C25X+UWL
	 iAAVy3iy+8cpCsXvrYWFgak7/mX8B+81nXiklDmwuU0PxzmQJRdJLEDYMLOoCeFB3P
	 lVS4LfZU2Th2Qzf3j63PABPdxjFUHoxD02UdtvtTPSXkPnPEpeYejsYEEEa/rAX+fX
	 kpE5h1nFpPE4FqkvYX6ytwMw8t8Q6k6Fvo1abiDIOx2iSYJmFAd13U8GeXnUR09u+V
	 EgQhybbOQ5ehgsY3v7KYNzom+RDroDzs5A8UZNY4Xbz9wkiXh/cRIn8tDte3Hg1+IJ
	 DNMSCBaqS7MWA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5909917E00EC;
	Wed, 17 Sep 2025 14:10:30 +0200 (CEST)
Message-ID: <27deb3bf-7b93-4049-b3a4-b0c9bfcb5c43@collabora.com>
Date: Wed, 17 Sep 2025 14:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
To: "hailong.fan" <hailong.fan@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250917075336.5985-1-hailong.fan@mediatek.com>
 <20250917075336.5985-2-hailong.fan@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917075336.5985-2-hailong.fan@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 09:53, hailong.fan ha scritto:
> From: Hailong Fan <hailong.fan@mediatek.com>
> 
> Add device tree binding documentation for the MediaTek
> MT8196 DSP. The DSP is used by the Sound Open Firmware
> driver node and includes registers, clocks, memory regions,
> and a mailbox for DSP communication.
> 
> Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
> ---
>   .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 98 +++++++++++++++++++
>   1 file changed, 98 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> new file mode 100644
> index 000000000000..af0f9d71200f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mediatek,mt8196-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek mt8196 DSP core

mt->MT (MT8196)

> +
> +maintainers:
> +  - Hailong Fan <hailong.fan@mediatek.com>
> +
> +description: |

Drop the colon |, you don't need it.


> +  The MediaTek mt8196 SoC contains a DSP core used for advanced pre-

mt->MT (MT8196)

Also document *which* DSP core this SoC contains. Specifically, say that this SoC
contains a dual-core Cadence HiFi5 Audio Engine DSP - because this is what it is.

> +  and post-audio processing. This DSP is typically used by the Sound
> +  Open Firmware (SOF) driver and requires registers, clocks, memory
> +  regions, and a mailbox for communication.

..snip..

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8196-clk.h>
> +    #include <dt-bindings/power/mt8196-power.h>

Before including binding headers with the same names as downstream, refer to the
series that are currently on the mailing lists, because that's what will ultimately
get upstream.

dt-bindings/clock/mediatek,mt8196-clock.h
dt-bindings/power/mediatek,mt8196-power.h

> +    adsp@1a000000 {
> +        compatible = "mediatek,mt8196-dsp";
> +        reg = <0x1a000000 0x5000>,
> +              <0x1a210000 0x80000>,
> +              <0x1a345000 0x300>,
> +              <0x1a00f000 0x1000>;
> +        reg-names = "cfg", "sram", "sec", "bus";
> +        clocks = <&cksys_clk CLK_CK_ADSP_SEL>,
> +                 <&cksys_clk CLK_CK_TCK_26M_MX9>,
> +                 <&cksys_clk CLK_CK_ADSPPLL>;

and use the upstream names for those clocks.

<&topckgen CLK_TOP_ADSP>,
<&clk26m>,
<&apmixedsys CLK_APMIXED_ADSPPLL>,

> +        clock-names = "audiodsp",
> +                      "sys_clk",
> +                      "adsppll";

clock-names fit in one line; plus, please "sys-clk" instead.

> +        power-domains = <&scpsys MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT>;

power-domains = <&spm MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT>;

> +        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
> +        mbox-names = "rx", "tx";
> +    };

Regards,
Angelo

