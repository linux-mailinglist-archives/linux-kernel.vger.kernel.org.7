Return-Path: <linux-kernel+bounces-848882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1194BBCEC05
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D85B74E2C47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386827F012;
	Fri, 10 Oct 2025 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcCIPFhQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705B34BA2C;
	Fri, 10 Oct 2025 23:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760138857; cv=none; b=dBRWQhkuAPzroh89XFKVYatO0g8qIm9hVRvTSAJjT9VZhhcP31aVDtUMZFjWejmem+EqIOlXi1PIxknI3/vOsruGO1InD+TLOH7EieZ+t5a+LNUDfxxDNsZCpM/tYEbqBshwTz/Bhwd/tzL4Jk+nPeMPfaiQiJ/qqHt8z+0vzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760138857; c=relaxed/simple;
	bh=dQL1ozMDwa+WbsJxVGIqYcZ3jM3hy2DaQVM8ebSstwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJsTmAf0qHkZcNMPcwlH3ypDEDFIw9wGW/oLjelw15nIu4IMaD6G8rDNR5H0DNMeZxomy7xC1lvx+daN9lA/7nAzDAufWKrqSjzuFPGYKOFzvf1omSyttTohcpveROuxxt3tso/GKfqZLoNozw8UhkMtftucYY+jPTXjNog9Xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcCIPFhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D88CC4CEF1;
	Fri, 10 Oct 2025 23:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760138856;
	bh=dQL1ozMDwa+WbsJxVGIqYcZ3jM3hy2DaQVM8ebSstwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EcCIPFhQ/Sl29M9L9ayeq2R7DOGCcmuyBBd63aIqvE2+PUyZ46P86kD4DVWjb8HsV
	 a5ypWERAraqwk9pxL8rJGX8Twk22Rlr8QcR6ZXcIz0Js3bc9aFZCkMBpNE4UcU1trd
	 kNpUyByteMgYZrvfyHfZgn8lL1D80PydHdKYJywbtiSCfPKHHU95KTrDNaMAQXRVFt
	 +MkFUC6S3fhNybjim7oT3CwZAnnDvoRF+JYahaMdvt6FYWjgmQPK8o0wYW/RTkGjSA
	 zb2ivJS+vXpUCLYpY6hmYKqiJqLfw8+Jq3XCqXJgpgaugPknJ/JUhuRA1WX3cl+M5K
	 pvUon4R9rdOKw==
Message-ID: <0caca8b6-05b9-43a2-9108-9262a3ed1196@kernel.org>
Date: Sat, 11 Oct 2025 01:27:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: add yaml file for maxim,max3421
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, gregkh@linuxfoundation.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, davidm@egauge.net
Cc: ~lkcamp/patches@lists.sr.ht, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009182046.185520-1-rodrigo.gobbi.7@gmail.com>
 <c65f8b8d-9ee9-4aea-8f27-66c9fe12401a@kernel.org>
 <935dbd93-2b20-45fb-a5b1-04f6ac67615e@gmail.com>
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
In-Reply-To: <935dbd93-2b20-45fb-a5b1-04f6ac67615e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/2025 21:46, Rodrigo Gobbi wrote:
> On 10/9/25 22:34, Krzysztof Kozlowski wrote:
>> On 09/10/2025 03:15, Rodrigo Gobbi wrote:
>>> Convert maxim,max3421.txt to yaml format with a few extra properties like
>>
>>
>> Here and in subject, please do not use yaml at all. Look at other
>> commits, this is supposed to be:
>>
>> dt-bindings: usb: maxim,max3421: convert to DT schema
>>
>> (and all other things like "file for" are redundant")
>>
>>> maxim,vbus-en-pin, maxim,gpx-pin, reset pin and supplies. Also add a
>>
>> Why new properties? You must explain not only the difference but WHY you
>> are doing this.
>>
>> WHY is the most important question/answer.
> 
> The reason was that the device (the IC) supports that. Is it
> enough to justify? I mean, is a plausible answer in this case? If yes,
> I agree that my commit msg was not right since I didn`t mention that.


It's not relevant to conversion then, so must be done in separate commit.

> 
>>
>>> maxim,max3421e compatible with a fallback, since the actually PN is with
>>> the 'e' suffix.
>>
>> We don't add PNs usually, unless there is a need. So again, why?
>>
> 
> The PN of this is Maxim3421e, Maxim3421 without `e` doesn`t exists as far as I`ve
> searched it. If it exists, it`s a different thing. In this case, I would expect that
> the compatible string should be something that "matches" the device, but in this
> case, the compatible string is without the 'e'. In that way, I was suggesting in this patch to
> allow a more precisely compatible string to no break anyone using the original one. But if 
> it was a bad idea here, I can drop that for sure.

So again not relevant to conversion and you need separate commit with
its own rationale explaining WHY you are doing this.

> 
>>> +  spi-max-frequency:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> No, drop $ref. Do you see any binding like that? No, there is none.
> 
> I`ve a previous patch recently at [1], that added a "similar" thing of frequency:
> 
> +  sampling-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2500000
> +    maximum: 20000000
> +    description:
> +      Default sampling frequency of the ADC in Hz.
> 
> In that case, $ref and description were added. Why that case is different from this one here?
> [1] https://lore.kernel.org/all/20250522204130.21604-1-rodrigo.gobbi.7@gmail.com/

Yes it is very different. Please use git grep.

> 
>>
>>> +
>>> +  maxim,vbus-en-pin:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    description:
>>> +      One of eight GPOUT pins to control external VBUS power and the polarity
>>> +      of the active level. It's an array of GPIO number and the active level of it.
>>> +    minItems: 2
>>> +    maxItems: 2
>>> +
>>> +  maxim,gpx-pin:
>>
>> I don't understand. There is no need for this property. Drop.
> 
> During my other reviews of new bindings, my final premise was that we should add every "capability" of
> a device (the IC) regardless of the driver support. In this case, the maxim,gpx-pin, is an example of that,
> the device supports that despite the driver support. I`m wondering here why we cannot add that here.


Read your commit msg. You are doing conversion. You cannot add random
stuff or missing hardware, just becase you are doing conversion.

You need to organize commits in logical way. Please ready carefully
submitting patches document.

Best regards,
Krzysztof

