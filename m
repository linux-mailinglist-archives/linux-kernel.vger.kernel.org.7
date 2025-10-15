Return-Path: <linux-kernel+bounces-854581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F6BDEC95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D2E3E6ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42729237180;
	Wed, 15 Oct 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgho6UND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596422F76F;
	Wed, 15 Oct 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535706; cv=none; b=iEXSR+m6msii3jQKbXPQXk9HLnLBj/UrOJY3R4Akz5+v4UK2niWAGNXtHjlevciEpj5QArQgvXh/nRNK542AujZE5cqsnB41TTDOLLhZyh43CJV2Jjh6TMeCbtREFaHm7EmKsY/z6dJjtliee2Itctg6ejpBHAef0Ak3U464M30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535706; c=relaxed/simple;
	bh=8Tz8/kXqpMNiULuP0/E6Rg1I5xQIyPrkfUQdjOvtY4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS7xhGrNeE5nOwCoFBKo8+X/BmxcYccPlzSGBiMBeEyHtleaag5SZKegqKmET/k5ZyWaOQjhPsaXdQd7c7iJTluiW6r8LhxMsJqzrgHnfnax2Bwa+XseYAj2JuQau0cnTg4RewLQx3g59mmv3CvOOESCLS16tsAgS1B830YbnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgho6UND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174D8C116C6;
	Wed, 15 Oct 2025 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760535706;
	bh=8Tz8/kXqpMNiULuP0/E6Rg1I5xQIyPrkfUQdjOvtY4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgho6UNDGSzmVjh8u6zRS71JzTXSqZDIVq6ENT+PnLraaBPb+eznD1zErKl8Ki2Or
	 6O/8uTr4Es9MUcb7YkdpaVArrvI6k15i03Ig2N7e5iGEda2C1tBKwwyeFv4P1V0d75
	 KlOECk+y3HMnhB9UoLfl74I0Q4Hu0q+wRjJTj74aG+tPBg6k0x41Zquhj42YCeI/Io
	 MtscByVFmq2Euom+pRyYMFbnGvwCySlassHULb75c/D6ddyqEK83OF8s9AYL1lxTOe
	 2eBinkHGlttD77fJr9tSQthj4l3kU+rTozPDLRzFx/VQSe+81CzBXw8ffcIUTgsEVl
	 oAYrTgOLHGftQ==
Date: Wed, 15 Oct 2025 08:41:44 -0500
From: Rob Herring <robh@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <20251015134144.GA3265377-robh@kernel.org>
References: <20251012022555.6240-1-looong.bin@gmail.com>
 <20251012022555.6240-2-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251012022555.6240-2-looong.bin@gmail.com>

On Sun, Oct 12, 2025 at 10:25:52AM +0800, Longbin Li wrote:
> The Sophgo CV1800/SG2000 SoC top misc system controller provides register
> access to configure related modules. It includes a usb2 phy and a dma
> multiplexer.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Longbin Li <looong.bin@gmail.com>
> ---
>  .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
> new file mode 100644
> index 000000000000..d1993f2156b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-syscon.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800b-top-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo CV18XX/SG200X SoC top system controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +description:
> +  The Sophgo CV18XX/SG200X SoC top misc system controller provides
> +  register access to configure related modules.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: sophgo,cv1800b-top-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1

Also need 'ranges'

> +
> +patternProperties:
> +  "dma-router@154":

This allows 'foodma-router@154bar'. It's not a pattern as-is, but 
generally we don't put fixed unit-addresses into the schema. So instead, 
should be "^dma-router@[0-9a-f]+$".

> +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> +    unevaluatedProperties: false
> +
> +  "phy@48":

And similar here.

> +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@3000000 {
> +      compatible = "sophgo,cv1800b-top-syscon", "syscon", "simple-mfd";
> +      reg = <0x03000000 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;

Please make the example complete with child nodes.

> +    };
> +
> +...
> --
> 2.51.0

