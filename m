Return-Path: <linux-kernel+bounces-895023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E8C4CBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688E73BFE06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD852F0C66;
	Tue, 11 Nov 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM7wlviz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840C52EBBAF;
	Tue, 11 Nov 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854081; cv=none; b=ateTgBJZ/y1PLAB4wjYM+96f/KnKqI1ra3G6aDgoDlNclSbS1qV6eL0xnxyu40bpHyQaXuQKUNDMJr72Zon3WbPRfoTDc8jfSOkbt6GN3u0x5fhHxWyLIaOj1W7veIX6dSbFKSNfvMPvY2GWp1nTpuxfPjmEmhr+EMGtNh+5uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854081; c=relaxed/simple;
	bh=2i0hV2jgS6G4URPcDhKEjaK3KmOgwDs3Q6+MPXea1m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+heYIE7LNwLor6rp/DSVvZ7PKmlxXqPbLIgDv4BHhjIhUQese9zfjHhoiSNtjmWcgKL6rlpwi7uUixb0dEBTGNiKwqDreKuFI/argNqGpNYhSsLBKUgir8uH2K+YIDqy9Zc+Wd+qDTmsfOQwbatw3r4zKu66bC9CXIoGOM8JT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM7wlviz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A81C4CEFB;
	Tue, 11 Nov 2025 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762854081;
	bh=2i0hV2jgS6G4URPcDhKEjaK3KmOgwDs3Q6+MPXea1m0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rM7wlvizC3kIpozE93RQghnemvOqj2wv1CL6MBU8PFrIjJwXzt/eE2g+xi/jO1IlO
	 XnmT1pFd2ut4IMg1Y12JRLdJr5aS/8VK0Gx3JuDrfuRlsK6x1ew0WuIkhP6JMN40Pf
	 LLJ8QC7QmSq1nG5tGM6gk0BIlCUKFE2vWBKOYAd96o5TnD6o7fMWDjJM35Wd/TPH9q
	 aR8Bxuxpvz1LTpKEe2QijnqQ2CbkXOYSNW9azFjqOLxqdDT08MLVq1gqUwQsEHLCXf
	 uZWWEXCzXQjC1xf7/BwvVscxFfOIlz4UHcA+OK1KyNFaUufrvgmJasCCORlHeH+Xv2
	 9GcKC+B2onyoQ==
Message-ID: <cabb047c-7c58-407e-831e-72567937dd1c@kernel.org>
Date: Tue, 11 Nov 2025 10:41:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: timer: Add Realtek SYSTIMER binding
To: Hao-Wen Ting <haowen.ting@realtek.com>, daniel.lezcano@linaro.org,
 tglx@linutronix.de
Cc: jinn.cheng@realtek.com, edwardwu@realtek.com, phelic@realtek.com,
 shawn.huang724@realtek.com, cy.huang@realtek.com, james.tai@realtek.com,
 cylee12@realtek.com, phinex@realtek.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251111092959.616089-1-haowen.ting@realtek.com>
 <20251111092959.616089-2-haowen.ting@realtek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251111092959.616089-2-haowen.ting@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 10:29, Hao-Wen Ting wrote:
> Add device tree binding documentation for the Realtek SYSTIMER, a 64-bit
> timer that can be used as a tick broadcast timer on multi-core Realtek
> SoCs.
> 
> The SYSTIMER remains active during deep CPU idle states where local

Systimer or SYSTIMER? What is this acronym about?

> timers are powered off, allowing all CPUs to enter power-cut idle states
> simultaneously for improved power efficiency. The timer operates at a
> fixed 1MHz frequency and supports oneshot mode for tick broadcast
> functionality.
> 
> This binding defines the required properties for memory-mapped register
> access and interrupt configuration needed by the timer driver.
Drop sentence, completely redundant. We can read the diff.

> 
> Signed-off-by: Hao-Wen Ting <haowen.ting@realtek.com>
> ---
>  .../bindings/timer/realtek,systimer.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/realtek,systimer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/realtek,systimer.yaml b/Documentation/devicetree/bindings/timer/realtek,systimer.yaml
> new file mode 100644
> index 000000000000..28ab9b91f45d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/realtek,systimer.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/realtek,systimer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek SYSTIMER
> +
> +maintainers:
> +  - Hao-Wen Ting <hao-wen.ting@realtek.com>
> +
> +description: |
> +  The Realtek SYSTIMER is a 64-bit timer that can be used as a tick
> +  broadcast timer on multi-core Realtek SoCs. It remains active during
> +  deep CPU idle states where local timers are powered off, allowing all
> +  CPUs to enter power-cut idle states simultaneously for better power
> +  efficiency.
> +
> +  The timer operates at a fixed 1MHz frequency and supports oneshot mode
> +  for tick broadcast functionality.
> +
> +properties:
> +  compatible:
> +    const: realtek,systimer

This is clearly wrong, please read writing bindings. You ALWAYS need SoC
compatible.

See also guidelines for beginners in DTS.


> +
> +  reg:
> +    description: |
> +      Physical base address and length of the timer's memory mapped
> +      registers. The register range contains the 64-bit timestamp counter,
> +      compare value registers, control and status registers.

Drop. Please use recent bindings as your starting work. If you generated
this with LLM, it would mean it is huge waste of our time.

NAK

> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Timer interrupt specifier. This interrupt is triggered when the
> +      timer compare value matches the current timestamp counter.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    systimer: systimer@89420 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

Drop label, you do not use it.

Best regards,
Krzysztof

