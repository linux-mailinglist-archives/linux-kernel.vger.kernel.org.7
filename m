Return-Path: <linux-kernel+bounces-789360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7602B39446
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5048189A33E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA872882C5;
	Thu, 28 Aug 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn7yFfkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FC293C44;
	Thu, 28 Aug 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364065; cv=none; b=s/ees6UxClTpPdQ1kKyTimAShBLgulZZLweFQx1ZgUsOWuFyR3OzSGbrYR4DYZK/am9IzkBIUVsGrLKAqoqWzO/H75JWYaNuM1I5DneO+0S9kInOcVTPzjOL1KscB6iycd+mv0W/kTOWL66ywO5/tuoMyzIbuEY1ikRNgYFyN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364065; c=relaxed/simple;
	bh=/oR092HKV45JV2FK9wkNxV9iN8AAPJogbzc0CL8maV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHnW/7/vpLm3M4hYect/fILiLI/yRC5TBBMY0zkEbslXw68hJceKO5JMfYpfWBacQ73zbI+iE2uI5LZg65WXtU/TD5MQ1E19oqcTjOz7lCrNyga/rviZr2m4F6NnzDtCcvhpipiplhSMj6M15pncaATSPVSx6V39vvSkRyxhKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn7yFfkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59698C4CEEB;
	Thu, 28 Aug 2025 06:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756364064;
	bh=/oR092HKV45JV2FK9wkNxV9iN8AAPJogbzc0CL8maV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jn7yFfkhi0Q8T7wqXMOiT0KhKNDqQFrGSEMGmmwR/aNB+HgUaQErcXTxb9Vfyy3HQ
	 6PA3K1hXikCoVYicStbFZP7Wpg4dH/WR4WWZlwFXd0imGtK2cJBtqOHpYfmgR0EIxn
	 AhXhY3FkAShf80nMvjoavL6uyznZk9PCY1IdcRoPTiVp+uwMU/H5YsBb3FMcw0cJr2
	 hHaED8zRMnYQYYfhGtFDP9XS4QNZ7QESXA0vX/xuQIyjPkHl6ddNwZVz8N3ujwyUUb
	 g6hVOL+TlJuKy7TP+xwUQKvqcNrc+Vg+jluTa5oW3E4/A3pLJ6ys9CWTWi1L4rlTvQ
	 GZuHg7kd6sKvg==
Message-ID: <e8934b5b-ef75-4ee0-b1e3-cc5db72b99ec@kernel.org>
Date: Thu, 28 Aug 2025 08:54:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/22] dt-bindings: usb: snps,dwc3: Allow multiple
 iommus
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-1-172beda182b8@kernel.org>
 <20250822-skinny-clay-harrier-64dc58@kuoka>
 <e4c730d2-6ee1-46d7-850b-8ebbe0a1bfcd@kernel.org>
 <a89ba427-b174-42c3-b3b4-5e4079942c3c@kernel.org>
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
In-Reply-To: <a89ba427-b174-42c3-b3b4-5e4079942c3c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/2025 18:07, Sven Peter wrote:
> On 24.08.25 10:31, Krzysztof Kozlowski wrote:
>> On 22/08/2025 09:22, Krzysztof Kozlowski wrote:
>>> On Thu, Aug 21, 2025 at 03:38:53PM +0000, Sven Peter wrote:
>>>> Apple's dwc3 variant requires two iommus.
>>>>
>>>> Signed-off-by: Sven Peter <sven@kernel.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> index 4380bb6fa2f08a475b557e80467abc2861f622e2..6d35dcc605c01977f4fc6fdb6f12976f1cef2b9e 100644
>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>> @@ -60,7 +60,7 @@ properties:
>>>>     dma-coherent: true
>>>>   
>>>>     iommus:
>>>> -    maxItems: 1
>>>> +    maxItems: 2
>>>
>>> Never tested. You anyway need specific constraints.
>> I realized that's pretty vague, so clarifying: you changed all bindings
>> to have two iommus and that's unexpected. All other devices have only
>> one IOMMU mapping here, so they need to stay like that. If these IOMMUs
>> differ, you should also list them, but probably that's not the case here.
> 
> Makes sense, thanks for the detailed explanation.
> 
> I don't quite understand why this controller needs two iommus but they 
> must essentially be programmed to the same mapping for xhci to work.

That's fine.

> All of device mode goes through one of them and xhci buffers are split 
> between the two iommus (iirc I saw the command ring using the first one 
> and the event ring the second one and then just decided to program them 
> the same since anything else would result in a big mess).

Sure. But if you change existing bindings (existing devices) allowing
them to have two IOMMUs, this must be explicitly mentioned in commit msg
with some sort of rationale (even if rationale was "we just missed that").

Best regards,
Krzysztof

