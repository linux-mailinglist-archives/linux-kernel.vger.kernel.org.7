Return-Path: <linux-kernel+bounces-748973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A968B14844
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416C83A83C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51928259CAB;
	Tue, 29 Jul 2025 06:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkPl4yLP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59E204C0C;
	Tue, 29 Jul 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770708; cv=none; b=D1Mc/TP90AuB3r2phWQ6W2xBs8zBNZb533NJIAzkKEaddhIUntZ55xmI16npVp2dE8m6k/mJdJ6xv4oQkLK0ujblCXDgKNht5iHtkp0GrohoGLt6q/KTh+G3W5WemTyizPdRU83CtO56vbthh0jIpAgL216lSZdd06pLBcGoTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770708; c=relaxed/simple;
	bh=xAfwh6wgqze8HrtArGsHCkx82E6hstOtlosrB8BG9f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5uqcI93Ai9/gKgJTTY01cjZkb1XceLojh74XSZu4TywwKQMbyBvfAKFfGyikwgkTDDnfFEfg+tthq2fcDDitreHpgEJQpybOUFgRrfV8qH1B38474UhY1MpADN8EEFY41G3hm2tZHHfFP4KnnHelVdI/wYBKPEmKQLomdEVtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkPl4yLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24810C4CEEF;
	Tue, 29 Jul 2025 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753770708;
	bh=xAfwh6wgqze8HrtArGsHCkx82E6hstOtlosrB8BG9f4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SkPl4yLPw+2X4ckxsOazOSKTMl5VNEaZCyChjoXb7XNvESprG/DJO/YR+OKLw95xj
	 GlhXDE6sYsSG/kgkubB5fZQReGRCdT6oec1CgXMUgmDtMufWzIN5qRczETGCTPC8OA
	 X0m6Go7RaeH8MTm/Rer72wdb/FxXGgWRjr7jxJDU3kNWgQmqXHef8FzLqkGbKjYq3B
	 opwxIK8r624YFy7IZTdFKI99M7Cr3N7poeZ6vATs5LGaI4PZz3dW+AngY7k5gRZoUS
	 MMM/xVOP2UHepXdew6AAv6aWjKfMNlKtgrI4/AZEygXZX1FbRCKTGsVoHaQSbrCq5Z
	 JUomL6giH0bGA==
Message-ID: <c09da948-6e31-454d-acca-99c226c18c61@kernel.org>
Date: Tue, 29 Jul 2025 08:31:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] dt-bindings: misc: Add binding document for SB-RMI
 I3C
To: Akshay Gupta <akshay.gupta@amd.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net,
 Anand.Umarji@amd.com,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-5-akshay.gupta@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20250728061033.1604169-5-akshay.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/07/2025 08:10, Akshay Gupta wrote:
> - Document the dt-binding for AMD SB-RMI

Why every commit is a one-item list?

> 
> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>

I don't believe these reviews. Code was obviously buggy, but still reviewed.

> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
> ---
>  .../bindings/misc/amd,sbrmi-i3c.yaml          | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml

Your previous patches make no sense with this...

> 
> diff --git a/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml b/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
> new file mode 100644
> index 000000000000..1d19571c2095
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/amd,sbrmi-i3c.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/amd,sbrmi-i3c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: >

From where did you take such syntax of title?

> +  Sideband Remote Management Interface (SB-RMI) compliant
> +  AMD SoC.
> +
> +maintainers:
> +  - Akshay Gupta <Akshay.Gupta@amd.com>
> +
> +description: |
> +  SB Remote Management Interface (SB-RMI) is an SMBus compatible
> +  interface that reports AMD SoC's Power (normalized Power) using,
> +  Mailbox Service Request over I3C interface to BMC.
> +  The power attributes in hwmon reports power in microwatts.
> +
> +properties:
> +  reg:
> +    - description: |
> +        Encodes the static I2C address.
> +      Socket 0: 0x3c
> +      Socket 1: 0x38
> +    - description: |
> +        First half of the Provisioned ID (following the PID
> +        definition provided by the I3C specification).
> +        Contains the manufacturer ID left-shifted by 1 (0x224).
> +    - description: |
> +        Second half of the Provisioned ID (following the PID
> +        definition provided by the I3C specification).
> +        Contains the ORing of the part ID left-shifted by 16,
> +        the instance ID left-shifted by 12 and extra information (0x00000002).
> +

And this entire patch is just noop. Makes no difference, makes no impact.

Drop it and write proper bindings with proper description of problem you
are solving.

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

Best regards,
Krzysztof

