Return-Path: <linux-kernel+bounces-772386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93119B2920E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2951670FF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 07:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE005244664;
	Sun, 17 Aug 2025 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGinFA0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F4EEA8;
	Sun, 17 Aug 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755416490; cv=none; b=FeEGTJo4EHZVPmCYDxWarVyApCFNXCiGzq4SoQt7vEUL+wdotzdWy++3dQu/VZ+Jr54JMK2690lpk8WZhcN+lEPaxGaq9/ostsaWiaACB1divwU4fqJgfcsDbC4lkl3Uv1gR/lXSR6ftiR31QvvgBHzMmX/75qtL7YfEF7fBhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755416490; c=relaxed/simple;
	bh=ZgDLxmEnnxsb+eXkicpW9/APIJQWDK7vOOfuyjgVd3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVhw/0rvX4chIQB3oFDDlWdY6N4DBAT6JRTMBu1FvFk0GJSVPQOps2lW0ErUHiXs3PhcYZZ1zJcwrgbYBmSUgt4RwkOj5tu1rEIJBMpI5sEDDIqgGXI1kRJheSIqbxCjzskCWv2X2OZSpTu71HbiDgQ6SYcqDqSw/xKTfbi3qsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGinFA0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2271CC4CEEB;
	Sun, 17 Aug 2025 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755416489;
	bh=ZgDLxmEnnxsb+eXkicpW9/APIJQWDK7vOOfuyjgVd3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZGinFA0yLKubQM5H6PoAN4KxfrWUPXjnRYF39jYxJ5WWI1x3m0NBExwCicrERkhGr
	 TLYNhT0frrXlGVUY70Caa2j5pu8BRk+b/fMt7WlV3P4pVWETg+AQTkLwSr9IcE9dgK
	 yRFAR3KlmtxKup1Mt0EqN8ZNcwX3Cw/H9Asl0ukp5oS+i3PmeFkpR7Ry4hLHYpvLJd
	 AUpSHkaMa2sb3Aa+qlFOrwj9CZU3M8vTXzfMJIJ3qPPkg8KWzDlV+oyUgdCAV2x60F
	 9I71bcBL3bM5m040W7HtIfONtl5k1B7n3A9o1HMMix9P5WARK7mXPi+QL/O3Ri2xw5
	 NH2NgzeCe77Vw==
Message-ID: <3ff4b3f9-cc8d-4044-b2eb-33010d8951c0@kernel.org>
Date: Sun, 17 Aug 2025 09:41:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: Add support for export-symbols node
To: Ayush Singh <ayush@beagleboard.org>,
 Herve Codina <herve.codina@bootlin.com>,
 David Gibson <david@gibson.dropbear.id.au>, Rob Herring <robh@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250430125154.195498-1-herve.codina@bootlin.com>
 <20250430125154.195498-2-herve.codina@bootlin.com>
 <0770a47e-fd2f-4b6f-9a9a-b0d539ace30c@kernel.org>
 <20250528185740.4bf91bef@bootlin.com>
 <49e1e1fc-412d-4334-8337-16e352a34788@kernel.org>
 <20250618113232.6d237208@bootlin.com>
 <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
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
In-Reply-To: <ed6beb97-12f1-4d71-b4dc-b34d4d611b81@beagleboard.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/06/2025 11:54, Ayush Singh wrote:
> 
> On 6/18/25 15:02, Herve Codina wrote:
>> Hi Krzysztof,
>>
>> On Wed, 4 Jun 2025 20:35:51 +0200
>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> ...
>>
>>>> Symbols are exported only when an overlay is applied on the node where the
>>>> export-symbols node is available. Those symbols are visible only from the
>>>> overlay applied. Symbols exported thanks to export-symbols are not global
>>>> to the all device-tree (it is not __symbols__) but local to a node.
>>>>
>>>> If an overlay is applied at connector1 node, it can use the 'connector'
>>>> symbols and thanks to export-symbols, the 'connector' symbol will be
>>>> resolved to foo_connector.
>>>>
>>>> If the overlay is applied at connector2 node, the 'connector' symbol is then
>>>> resolved to bar_connector.
>>> OK, this explains a lot. Unless I missed it, would be nice to include it
>>> in binding description.
>> Sure, I will add something in the next iteration.
>>
>> ...
>>
>>>>>> +patternProperties:
>>>>>> +  "^[a-zA-Z_]?[a-zA-Z0-9_]*$":
>>>>> This messes up with coding style which I would prefer keep intact.
>>>>> Basically these properties will be using label style.
>>>> Yes, those properties remap phandles.
>>>>
>>>> Their names are the name of the label used from the overlay and their
>>>> values are the phandle mapped.
>>>>
>>>> You already have this kind properties using label style in __symbols__,
>>>> __fixups__, __local_fixups__ nodes.
>>> I have them in DTB, but I don't have these in DTS. The exported-symbols
>>> would be in the DTS and that is what coding style is about.
>>>
>> I think export-symbols has to be in DTS.
>> Maybe it could be described in an other way in order to avoid the coding style
>> issue you reported.
>>
>> Hardware:
>>    i2c0 from SoC --------- connector 1, I2C A signals
>>    i2c1 from SoC --------- connector 1, I2C B signals
>>
>>    connector1 {
>>        export-symbols {
>> 	  i2c_a = <&i2c0>;
>> 	  i2c_b = <&i2c1>;
>>        };
>>    };
>>
>> In order to avoid the coding style issue, this could be replace
>> with:
>>   connector1 {
>>        export-symbols {
>> 	  symbol-names = "i2c_a", "i2c_b";
>> 	  symbols = <&i2c0>, <&i2c1>;
>>        };
>>    };
>>
>> Krzysztof, Rob, do you think this could be accepted ?
>>
>> Ayush, David, do you thing this could be easily implemented in fdtoverlay ?
>>
>> Best regards,
>> Hervé
>>
> 
> Well, it is possible.
> 
> However, on connectors like pb2 header, there will be 50-100 export 
> symbols. So it will start becoming difficult to maintain.


And the first syntax solves this how? I don't see the practical difference.

> 
> Additionally, the further away we move from __symbols__ style, the more 
> difficult the implementation will become since we can currently very 
> easily piggy-back on __symbols__ resolution implementation.


I care more how I read DTS, so complexity in dtc is less important to me
than consistent DTS style.

Best regards,
Krzysztof

