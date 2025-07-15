Return-Path: <linux-kernel+bounces-731129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E2B04F84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F83D561206
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086442D12E2;
	Tue, 15 Jul 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u85R6wB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C419F42D;
	Tue, 15 Jul 2025 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551554; cv=none; b=L3lZCBVjxl4S6G91RYv1y9zoaH/GL8XQrzrQfISKUMolb7DyRcr/0sIHF1B8XkOZm84SeaGPmczzGIiyGF30o0faZIVCFuchdQn+oBK22msWJBM5XpfTGCfy5rywwKvWwtdS7KiFK40zbTG5JTvCJBPmw8SBZTGynUJEOw3nr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551554; c=relaxed/simple;
	bh=eZMtR6qc160LSQfy2R2nzmb7TLffw3Cjw/mnP6iSrNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvMZ0NJJM0Ak1saFgQyBT1Eq3kO8SEQywwai/Io0ivcMa70A8UN/kjDm88lHgRordtzRPcGx7M8oQy9M3ItsgYEy8Sk02dMC82igzvp0Ciw40as6gr4GXw5v/Pd6D3n7Ob4h2T7SSfIjL5HHCIe5a5QfnubR0JysBE5QsOQvXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u85R6wB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DEAC4CEE3;
	Tue, 15 Jul 2025 03:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752551553;
	bh=eZMtR6qc160LSQfy2R2nzmb7TLffw3Cjw/mnP6iSrNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u85R6wB/DAFpO2wTL3J9UWPWbvmZK+vBH/YzS/aPI9CRE52SjN9odtU198L2NIuyI
	 eNFU1BPvz6l3nAvbIYuNljznjGbnY5pxVcO5q3wcZ4e+SxDbVjfwZ1hKC/sBRO/qj6
	 gQsCf6jbfA82Pa/c8eqRZwbrCyPmnRVaqIuYkJR39cHYGwALOloenctFvML6S7EAAk
	 yO60L7IYE18FqI65OyWVqt20264ola4bY/oPZYiVsDF+d2KrjRnT0nsrRZUwHDq1M/
	 uFrHJ92WTH1sXMf4ewwXR9jD0FB93McpR94/b+YBjRvQQQDNIHouUSCXF4uuZ5RdXv
	 aFKEmeXSl+Q6w==
Date: Mon, 14 Jul 2025 22:52:33 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: airoha: add SMC eFuses schema
Message-ID: <20250715035233.GA7855-robh@kernel.org>
References: <20250714151349.28368-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714151349.28368-1-ansuelsmth@gmail.com>

On Mon, Jul 14, 2025 at 05:13:46PM +0200, Christian Marangi wrote:
> Add Airoha SMC eFuses schema to document new Airoha SoC AN7581/AN7583
> way of accessing the 2 eFuse bank via the SMC command.
> 
> Each eFuse bank expose 64 eFuse cells of 32 bit used to give information
> on HW Revision, PHY Calibration,  Device Model, Private Key and
> all kind of other info specific to the SoC or the running system.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/nvmem/airoha,smc-efuses.yaml     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
> new file mode 100644
> index 000000000000..399c3c14f6ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/airoha,smc-efuses.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/airoha,smc-efuses.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha SMC eFuses
> +
> +description: |
> +  Airoha new SoC (AN7581/AN7583) expose banks of eFuse accessible
> +  via specific SMC commands.
> +
> +  2 different bank of eFuse or 64 cells of 32 bit are exposed
> +  read-only used to give information on HW Revision, PHY Calibration,
> +  Device Model, Private Key...
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,an7581-efuses
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  '^efuse-bank@[0-1]$':
> +    type: object
> +
> +    allOf:
> +      - $ref: nvmem.yaml#
> +
> +    properties:
> +      reg:
> +        description: Identify the eFuse bank. (0 or 1)

Drop "(0 or 1)". You say that here:

> +        enum: [0, 1]
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    airoha-efuses {

efuse {

And put this under a /firmware node (not here, but in your .dts).

> +        compatible = "airoha,an7581-efuses";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        efuse-bank@0 {
> +           reg = <0>;
> +        };
> +    };
> +
> +...
> -- 
> 2.48.1
> 

