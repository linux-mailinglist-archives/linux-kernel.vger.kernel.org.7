Return-Path: <linux-kernel+bounces-870529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DEEC0B0EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0957B189DE45
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBC2FD69D;
	Sun, 26 Oct 2025 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENuykc5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250C1D555;
	Sun, 26 Oct 2025 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506128; cv=none; b=eeGQMPEI0r0KwI0sTg4DEMD2bsFAR3luakBvYYMqcKr2kAqLazSsEpTOUn7qvk2CUpC4OplKXuMpazyYKwzq1Tm03iNtR75TGCE7SQZYmN59f8dZFS2L3mXRpmn4V1XfLg/8xJIYljr3RfmC1XQv7dLm069w0UJ3eTj7+8mFjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506128; c=relaxed/simple;
	bh=pliB5Ap7K2x1BmXOBTstd+ICLJ6Oz1r01E/QuMU7mNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i09B5qBhOU0QIaFNC/XuVURP35O5HG3hT0pLxj4U2nNpu/a5+oCb3e2B557AjJX7rAaV9DiwO1rpOZq7Cqh0DckMcF2d2mAopvPNhYpmoMP3BNIy4zzlswt/RJKabIVyfBvyT55EJE3HLQsOg1NcHFj1ehs9nygBgwIMPc0TAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENuykc5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA154C4CEE7;
	Sun, 26 Oct 2025 19:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761506127;
	bh=pliB5Ap7K2x1BmXOBTstd+ICLJ6Oz1r01E/QuMU7mNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ENuykc5OU/grHxEdvSV0wYLbH5rsvd2MSQU0NPH/QqIFTCEWZ13CB9B0y/SMzMPOh
	 j6mT8mDEyoXOaS0m3oCJJTRRyboxLRJpN+a8et8EnhoSMtsDSQdu+U5LG7yUCi2nP3
	 WPlPUcyZCqF0nyZY6WV6VVY3Huglb0wIw5+PzpdVAUZWPOoCiHPW/YbJjzJQZ7k3Jz
	 U6h3Bm7t4dDiOQ1Rp8FOi46jDxyrgJq3eaDIVFzsCwZHICb6tJrJ35FfVy2VqwV2I8
	 UuruCle0yz4K9LyAhWtDQJOIHqX6s7BM5kLamlLY2jyFf/DWog7HGqSnl8MFHcCdDD
	 ynEgxqKMv9cMg==
Message-ID: <d0ebc09a-6122-4a52-823b-7cbb2b05741b@kernel.org>
Date: Sun, 26 Oct 2025 20:15:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641
 power monitor
To: Guenter Roeck <linux@roeck-us.net>,
 Igor Reznichenko <igor@reznichenko.net>, linux-hwmon@vger.kernel.org
Cc: conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, skhan@linuxfoundation.org
References: <20251022044708.314287-1-igor@reznichenko.net>
 <20251026065057.627276-1-igor@reznichenko.net>
 <20251026065057.627276-2-igor@reznichenko.net>
 <408c1698-a8ad-4e16-8def-352c2c265f5a@kernel.org>
 <635af2ab-969b-4390-b661-44bf171eda7c@roeck-us.net>
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
In-Reply-To: <635af2ab-969b-4390-b661-44bf171eda7c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2025 18:22, Guenter Roeck wrote:
> On 10/26/25 09:32, Krzysztof Kozlowski wrote:
>> On 26/10/2025 07:50, Igor Reznichenko wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: st,tsc1641
>>
>> Subject: I asked to drop "binding" and not add "support for". "Support
>> for" makes little sense in terms of binding. How binding can support
>> anything? This is the "ST TSC1641 power monitor" not support.
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  shunt-resistor-micro-ohms:
>>> +    description: Shunt resistor value in micro-ohms. Since device has internal
>>> +      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
>>> +      655.35 mOhm.
>>> +    minimum: 100
>>> +    default: 1000
>>> +    maximum: 655350
>>> +
>>> +  st,alert-polarity-active-high:
>>
>> Isn't this just interrupt? You need proper interrupts property and then
>> its flag define the type of interrupt.
>>
> 
> This is a value to write into the chip. It is orthogonal to how the interrupt
> is reported to the interrupt controller. It may be active low by the chip and
> inverted, or it may be active high by the chip and inverted. How does one express
> an additional inverter in the interrupt signal path in a devicetree property ?
> Can you give an example ?


If that is the interrupt to the CPU, then it's just like I said - proper
flag to the interrupts property. There is no need to express inverter
separately from the interrupts, because that would mean you first
express interrupts incorrectly and then you add inverter to make it
correct. Just like people expressing RESET_N GPIO with ACTIVE_HIGH and
then making reversed set high/low in the driver :/

Best regards,
Krzysztof

