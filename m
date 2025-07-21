Return-Path: <linux-kernel+bounces-739800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC5B0CB24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E3717D1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E232376F7;
	Mon, 21 Jul 2025 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+OvJE49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C41BD035;
	Mon, 21 Jul 2025 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127163; cv=none; b=SKt14S4IIBwprJZB+tnKg3rV9TRFy1//GhQawGvkiH9zZCG0icuJS94iGK9K3OQ2OH3Hq53KtO5f9PpIasYGBnVDFFCJ0UCyLiH2IM56d5CUtp2WN+DNX46XX2DCdQ47Nvn92vZI/XYfwOdeE0TtiVwZ7s+P7rde/ZYn5NEo1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127163; c=relaxed/simple;
	bh=F7yMPeJHWavbLIzzBKdHmEFybFadY1nYAD4poeuN01M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8WZhV+1zXEdn4guBCd/77aPAaV6IySSHGAxCBDTduYjfszXETvAPafP+QX94JBJqFQ0dC1bKW8Nx9ypoJKeSm0oKwd9sMZ56XJFa2GAzlmCFI9rn5X2e3Aeg0cfWGDFx2ngsYTJSz06m88f4wLlgeEJmJWT0fc/qUoZl3tmM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+OvJE49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF49BC4CEED;
	Mon, 21 Jul 2025 19:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753127162;
	bh=F7yMPeJHWavbLIzzBKdHmEFybFadY1nYAD4poeuN01M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+OvJE49SfumM4G9FAuZbs/szaYHfRu0pGAjF8aHSQZiDpdxIJge3OCZjEyflGjk6
	 F2ZOnCFbch2cvBUO83nNzfTeXPGBH6u1H+fKKp3YtcePBVIAXJR924AWpe5LoUr4ML
	 wEZOT0oqx5K95Xsq2dJbcew+rxGY3r1TcqCty5B5hnAmaYBo9o5BBycPJwv1Hm0smo
	 2P/HVWL/RmPJQtR31gRNS133i+gAGw1nlmHm08ItUD+1+F/RYqiKBFfJ/Z/T5L+oug
	 IYn0/8/7wLeamisPHoSL0RCQaSv3XSh679juSSPVyYTlaj5hwsrYtUytn++Iv7NG9P
	 GAh5SHC3nrY0Q==
Date: Mon, 21 Jul 2025 14:46:01 -0500
From: Rob Herring <robh@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: regulator: Add Richtek RTR5133 DT
 Binding Documentation
Message-ID: <20250721194601.GA1142912-robh@kernel.org>
References: <20250721060215.2718217-1-jeff_chang@richtek.com>
 <20250721060215.2718217-2-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721060215.2718217-2-jeff_chang@richtek.com>

On Mon, Jul 21, 2025 at 02:01:35PM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 
> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
> ---
> 
> PATCH v3
> 1. fix Subject format
> 2. using correct patches version
> 3. remove '|'
> 4. remove allOf: &ref regulator.yaml#
> 5. remove redundant description
> 6. move BASE to base property with correct indentation
> 7. only using lowercase node name
> 8. make DT_CHECKER_FLAG=-m DT_SCHEMA_FILES=richtek,rt5133.yaml dt_binding_check pass
> 
> 
>  .../bindings/regulator/richtek,rt5133.yaml    | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> new file mode 100644
> index 000000000000..a92e7f775832
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> @@ -0,0 +1,197 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt5133.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5133 PMIC Regulator
> +
> +maintainers:
> +  - ShihChia Chang <jeff_chang@richtek.com>
> +
> +description:
> +  RT5133 is an integrated chip. It includes 8 LDOs and 3 GPOs that can be
> +  used to drive output high/low purpose. The dependency of the GPO block
> +  is internally LDO1 Voltage. If LDO1 voltage output disabled, GPO cannot
> +  be used to drive output high. It need to pay more attention on the usage.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt5133
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      base:
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for base regulator which for force-off base circuit
> +
> +        properties:
> +          regulator-compatible:

regulator-compatible was deprecated so long ago we don't even document 
it now. Why are you bringing it back?

> +            description: Compatible string for regulator
> +            $ref: /schemas/types.yaml#/definitions/string
> +
> +          oc-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of LDO OC state, shut down all channels.
> +
> +          pgb-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of PGB OC state, shut down all channels.

Is 'base' an actual regulator or are these just common properties for 
all regulators? If the latter, then just move them up a level and add a 
vendor prefix.

Rob


