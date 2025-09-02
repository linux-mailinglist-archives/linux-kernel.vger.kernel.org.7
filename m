Return-Path: <linux-kernel+bounces-797232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E1B40DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B65548555
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D1346A1F;
	Tue,  2 Sep 2025 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APdUxPVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE320C038
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756840788; cv=none; b=M1RZbiwOvaSrpreF+/3YcUqibx9OkjTrc3xBhRdbv1Gj1tdI8fzwypO8KkHj2DJBW2VGML/64GSw+kxy3hQ7RPBMIiM6KtfmQNOxeWOuAQDhmFpQJ53PZwWFwkjxnt0Vr51qmrKTsBPLQ95v9IGYHfk9BqVIwd537ZKn3MneA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756840788; c=relaxed/simple;
	bh=tcLLYTcRYt48I3W/Ep3mMkVrvP2q8p83mvDYSbd0/xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkekbClDPBA04e0bFRdBnrK2kN1j6WyoRHRPgpwAjua3cqdtbHaWR1fYxezCXZXWgCN1ZHwg9B2I7KPDQ2LZz6/4pDq2/XJTQqAqzOTr+EIhjBnbv07p3IzWsZ2D0Mb+BKiPhe0oEv7mKDSusqKTnU5NrEjzJJZD592gQ1FQhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APdUxPVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D21C4CEED;
	Tue,  2 Sep 2025 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840788;
	bh=tcLLYTcRYt48I3W/Ep3mMkVrvP2q8p83mvDYSbd0/xw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=APdUxPVRQGErP8muX5bY0UW/39+5c9aYMq1srVihu0395whOZUjRjcfhjTpi2rFOk
	 eCq9L2qp7fKEYm1k3qQEkt9FstercErXq3UirRNHbCgbwF48S8cNaBHuYxjpam3cXd
	 zk3Xgh0MCQUxDGcFrhGR+QCjQ2lUgv03ugUo1Y9HtJDmFOmr+BN2SHBR09HhgXuvH8
	 TKe3wvzwq7CDcxLHoVAEaYe9uoE8CEm6SqkLHSsNYxSg6RPlwXA8rabMZ83gI+5B53
	 C0K+7nOc2OMHmh7ImC90p6Pu87s06I+xMM2FFaLutUFG948bG3TcYF7Nw3TZ8uqrfs
	 uQ9iitOPbMKaw==
Message-ID: <5b975250-554f-4785-9825-fe93138fad31@kernel.org>
Date: Tue, 2 Sep 2025 21:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regulator: pf530x: dt-bindings: nxp,pf530x-regulator
To: Woodrow Douglass <wdouglass@carnegierobotics.com>,
 linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
References: <cover.1756822704.git.wdouglass@carnegierobotics.com>
 <a33794ed2caeefc8a79419f35b7e28546996dec9.1756822704.git.wdouglass@carnegierobotics.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <a33794ed2caeefc8a79419f35b7e28546996dec9.1756822704.git.wdouglass@carnegierobotics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 16:21, Woodrow Douglass wrote:
> Bindings for the pf530x series of voltage regulators
> 
> Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
> ---
>  .../regulator/nxp,pf530x-regulator.yaml       | 74 +++++++++++++++++++

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>


>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
> new file mode 100644
> index 000000000000..f1065b167491
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml


Filename should match compatible, so nxp,pf5300.yaml.

> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/nxp,pf530x-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PF5300/PF5301/PF5302 PMIC regulators
> +
> +maintainers:
> +  - Woodrow Douglass <wdouglass@carnegierobotics.com>
> +
> +description: |
> +  The PF5300, PF5301, and PF5302 integrate high-performance buck converters, 12 A, 8 A,
> +  and 15 A, respectively, to power high-end automotive and industrial processors. With adaptive
> +  voltage positioning and a high-bandwidth loop, they offer transient regulation to minimize capacitor
> +  requirements.

Wrap according to Linux coding style.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pf5300
> +      - nxp,pf5301
> +      - nxp,pf5302

Your driver clearly suggests these are compatible, so express it (see
example schema).

> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:

No need for this node.

> +    type: object
> +    description: |
> +      list of regulators provided by this controller
> +
> +    properties:
> +      SW1:

No need, drop the node.

> +        type: object
> +        $ref: regulator.yaml#
> +        description:
> +          Properties for the regulator.
> +
> +        properties:
> +          regulator-name:
> +            pattern: "^SW1$"

No, drop entirely regulator-name. Just embed the properties in parent node.

> +            description:
> +              Name of the single regulator
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c1 {

i2c

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        vddi_0_75@28 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

See also DTS coding style.



Best regards,
Krzysztof

