Return-Path: <linux-kernel+bounces-736509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 619C6B09DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2C7BDFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32822676C2;
	Fri, 18 Jul 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3v6K64d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF0221557;
	Fri, 18 Jul 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827116; cv=none; b=je0zGXNU4PtX6A3SdaSjEZcl35dG0oQD/GUJesva1+MYE5VReR+q3pmIxgDwqI1LvVm+P6HgxZEoW4XHRDhkE0kZvotk+JihysMRKcxNUpt4KirfHDJz7zVIQDOaeX1ciXPL0X5BfRCZzv8ywHFW90JeTz7/EvGPpkAQ5dqrsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827116; c=relaxed/simple;
	bh=gpXICn11IMQTSwpyTqBxNS75wVJrjuLqjC0FBSJXjvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gRKLUq1aaVcubS+y6BDlAiMnkup//X4q/U+WttIywBPtXm7UUjXhFaGWmhqLdJeFJyaTsHegH+4BPY8TWaT/UzhCYDz+W6eL2dcDapTlGlOkw5So6O1gi5dLtXxFQJg7goUqKTP5U15YhhPOdi6zC7U5RzZaXjZd+7CXKBR6eGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3v6K64d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6828EC4CEEB;
	Fri, 18 Jul 2025 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752827115;
	bh=gpXICn11IMQTSwpyTqBxNS75wVJrjuLqjC0FBSJXjvE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=m3v6K64dOO7xCAf+4YLvT6PzA6lYbRD0Z1LRhio0iQzZoK4vLkjXgnUpiqiUWw0oM
	 GERYcHXCV9idZ+oUH0TuvbFn7mPk6q7b1Kt+c45kLbGwEO4bme8Y/jFEeAq6Kfmy1Q
	 rYK5nuYo55H9b26Z1ytoS5StNPCkZMPuv8XnPQQuEQR/eomGK09QHghOKBHOVoXV1+
	 SkcZYQKIvEFeR+BhwgTLnl6fhiLvGFIc+tH7V2do4EuKeo3+g/cQnK0EWo8MOUIqj1
	 c9vtRpGrbmXOYEw16tJrkDTzU7t7WuF2BqClidYEmLWW2ia4gM6209k009IhueESDa
	 NoiipSVQ6PwCQ==
Message-ID: <87fea8b4-950c-4dcc-9185-d473a1f36876@kernel.org>
Date: Fri, 18 Jul 2025 10:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: rt5133: Add DT binding document for Richtek
 RT5133
To: jeff_chang@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250718081432.2685902-1-jeff_chang@richtek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250718081432.2685902-1-jeff_chang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 10:12, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 
> Add DT binding document for Richtek RT5133 voltage regulator.


1. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching. For bindings, the preferred subjects
are explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

2. A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

3. Missing threading or user of the binding.

4. Please version your patches correctly, e.g. use b4 or git
format-patch -vX, and add changelog in cover letter or under '---' of
individual patches describing changes from previous version.



> 
> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
> ---
>  .../bindings/regulator/richtek,rt5133.yaml    | 178 ++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> new file mode 100644
> index 000000000000..c1ba2d9d83c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> @@ -0,0 +1,178 @@
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
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  RT5133 is an integrated chip. It includes 8 LDOs and 3 GPOs that can be
> +  used to drive output high/low purpose. The dependency of the GPO block
> +  is internally LDO1 Voltage. If LDO1 voltage output disabled, GPO cannot
> +  be used to drive output high. It need to pay more attention on the usage.
> +
> +allOf:
> +  - $ref: regulator.yaml#

No, this is not a regulator.

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
> +    description: A connection of the 'enable' gpio line.

Drop description, redundant.

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

What is in this node? Missing additionalProperties: false. Also missing
tests which would tell you that.

> +
> +  BASE:

I doubt this was ever tested... totally messed indentation.

Also, only lowercase.


Best regards,
Krzysztof

