Return-Path: <linux-kernel+bounces-771859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5FB28C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766DC3B553F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513923D7EA;
	Sat, 16 Aug 2025 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="FOSCCvBK"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DE11713;
	Sat, 16 Aug 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335652; cv=none; b=jAOgL59Rec+ykWYDTrbFNgC3cmFF4BO5QBlYAqyuvM3UbVcEkAgVvGPKxgYH2W4tenyqAQ63YWjWRJ276zKB2R2+IbKo4pYrMKM/uG57ldny4B93PmMgDyTKbHLcBv7sbAvuEZzs6jOteaXflTjaV9GzNiht76pttcFcWuPG7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335652; c=relaxed/simple;
	bh=ZdKnQYRuR3HrfaBPrfJ2dVRybAc1Vk+EPmW79NieZ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QirnJmBjFk4ClANALid33ZB4KHfXRFTcmiAh3K/m+vmJdlXb2cVeEsOoguPDOhW5L73Uyc4mT+6HdwFhRvYhtxHNNHEsHrOpBjFwccCf9g2TPxz5t0ch6I/IgnI7oXrVjkBWTq8t9luiGnhviWMaOl2MLtk9aSMMtNsllcSxAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=FOSCCvBK; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755335630;
	bh=hbXtoR3uWxiKczQIaq//GQkhVV7HPaIDh8JT8/clkDc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=FOSCCvBKymEN0pkkf1IIPQKjNhpVz06HRqr0F6cclv01GpdoC6gAWTA26rpDgpJ8w
	 vR9vWitVXhe1//uRya04izDDpZTRrHNc2YRycmqCctfHZQ8d1yp4K1J4doD/7R7VQk
	 5SUL4l36MPwc1kg7ko5eDYBheEP6n3d9TdiK3nuM=
X-QQ-mid: zesmtpip3t1755335624tdfc22a4d
X-QQ-Originating-IP: q1QVFsw6Qn/8GxGPXxJhBWdr66tYEr9pdlAVtNoZFY4=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 17:13:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8634151311153834424
EX-QQ-RecipientCnt: 15
Date: Sat, 16 Aug 2025 17:13:42 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 1/2] dt-bindings: i2s: spacemit: add support for K1 SoC
Message-ID: <67A5AD581BFFAEE1+aKBLxuQLDlf3JFVN@troy-wujie14pro-arch>
References: <20250814-k1-i2s-v1-0-c31149b29041@linux.spacemit.com>
 <20250814-k1-i2s-v1-1-c31149b29041@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-k1-i2s-v1-1-c31149b29041@linux.spacemit.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MjlOSqg8Riw0VUfjb59dP+uHGYzwZfcwx2tAA5V9Kb/KKrSY6eXtwg8w
	XNobfaFx1wmWRRut5/IMl6uJArv7IHbzpT2LVKRVQ5nrpAxKX89M6DGk3vRw3DISWKCfo3o
	UuU9CF+jGMmQKM3lpzHYtoYK/bpvF9s/OFRPWtVEtogR4TtnaDrhZ15CipnEzOxFCkZVsDh
	/JxtduDGBlIvcH09BqyP+J8O3h/u3OSeTGIIcV+ZXGeOBZ0nO7UFTcwAOW2QVN2REgfvi+j
	MgFBDpM0ONjZU1/J2mvP7tNHLh8yddjVqaABzwVtMz69zOcNt7o3vo0ZyChOdTb9v080NqK
	tsmcjM5KpS0kjLq22AugfOoNBEltrf3ITeDI+Y9S72sqWiUjku3gOKb23SfPoHg2V4dl4sk
	5y7L/sj/UFxQSszUuXHs4X3PBpz0r29QWKnoYHlerapVusJFvKKSmHkicS6wGIPdMvAoeNz
	FNc/+J7IoYrSxjNtZ8XF/+8ekXMxgrOBTaKtjU9B5SuCLdu+F6Qgf4zdbJClilfNwNiNqvp
	ETQ2YG5qAzv5+F9AXvK5ZwM6qjRICREE5MHq8D0CN7fkYWU/uOhR+IGtdqX9zFBtjYaUBf+
	ihdOyRlC7mYZxD5Wa6V7LJewEyCvXfuSPEVYuL1F0dsi0qRq5cUYEfGmWldn2JdFjrWwonK
	wReDtTaoD+yT6lCPsX03mtVeO4pbqxoTuro1upq3KyUgj1wwNuHChslQRpK6/U19NP3nIzW
	neZyE7VhRhluZrab/11JllfZ1tsNp1OqZY0ycg1VsSxkXpuzhS+0RMLRzw8/3PpZuXdq4UH
	/p+YDRkdaoEiVmYpa+SwIRU09mOYiJcOuuU9OOrbmD2zbJdYPMSNk9HAxyiLJkf+CkfMpqz
	Gr9337zyx/Gq7kNgTO2GJCCQBFDkeUQ1gC7rFr/X704kr5DLniQTA85aolE/gjO3V2wlDI8
	24mdwUrjL2JrhISv6jbmd+ScM+AL5vF36iZaFRyWb0duDoEYdpLjYXGccgQoGK48RyPHSfa
	EuRZ3tFxje5/1UB0zwtXXTQGsbHsF1J21AohlOOv4rEPVCmoafsg84tYqxt0M=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Thu, Aug 14, 2025 at 04:54:19PM +0800, Troy Mitchell wrote:
> Add dt-binding for the i2s driver of SpacemiT's K1 SoC.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  .../devicetree/bindings/sound/spacemit,k1-i2s.yaml | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..7d9110638d71792db6e5bb72559f6abaf4cb59bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/spacemit,k1-i2s.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/spacemit,k1-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: K1 I2S controller
> +
> +description:
> +  The I2S bus (Inter-IC sound bus) is a serial link for digital
> +  audio data transfer between devices in the system.
> +
> +maintainers:
> +  - Troy Mitchell <troy.mitchell@linux.spacemit.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for I2S sysclk
> +      - description: clock for I2S bclk
> +      - description: clock for I2S bus
> +      - description: clock for I2S controller
> +
> +  clock-names:
> +    items:
> +      - const: sysclk
> +      - const: bclk
> +      - const: bus
> +      - const: func
> +
> +  dmas:
> +    minItems: 1
> +    maxItems: 2
> +
> +  dma-names:
> +    oneOf:
> +      - const: rx
> +      - items:
> +          - const: tx
> +          - const: rx
> +
> +  resets:
> +    maxItems: 1
> +
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +  - resets
> +  - "#sound-dai-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> +    i2s@d4026000 {
> +      compatible = "spacemit,k1-i2s";
> +      reg = <0xd4026000 0x30>;
> +      clocks = <&syscon_mpmu CLK_I2S_SYSCLK>,
> +               <&syscon_mpmu CLK_I2S_BCLK>,
> +               <&syscon_apbc CLK_SSPA0_BUS>,
> +               <&syscon_apbc CLK_SSPA0>;
> +      clock-names = "sysclk", "bclk", "bus", "func";
> +      dmas = <&pdma0 21 1>, <&pdma0 22 1>;
I'll keep to 1 cell in the next version.

> +      dma-names = "tx", "rx";
> +      resets = <&syscon_apbc RESET_SSPA0>;
> +      #sound-dai-cells = <0>;
> +    };
> 
> -- 
> 2.50.1
> 

