Return-Path: <linux-kernel+bounces-657387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF92ABF395
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B8C7A426A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAEB264A9D;
	Wed, 21 May 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODoWPQco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153C25F99A;
	Wed, 21 May 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828790; cv=none; b=Sze2EbRS7M2pXA9NP/UWll0E2b+kvOPtraKAnzvDseI647KfTxp1IL1zgIi/9m46DvlkLGVt7qc9/+vKFePEkl/ZGRqql4p5AECMpPtNlGwN9g/xRUECJBHj/vDZDrJilVCkiP/Qvd10PPI7KMHsHn3oupVkvpvElHZRUwAPwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828790; c=relaxed/simple;
	bh=agX0mZHJvTfw2UVHmhLTALRKExst9ZXIJ+Q2cytq7tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRa9wR+uLGCDyuFkRCnSVTtYngn+Bf0x6KIKantuRWgvtHua1GQhELxjcfUz0eqIbixPrFsMemzAWNIS8SPuvcI/CIRo20ZRsZnAWiR5ZvZuXntJWc/sF2WMFX7veG6QdnuUaYhaqL8+/mmmXTSKbnF8Jlapzjawdpo2viTzwN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODoWPQco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D3C4CEE4;
	Wed, 21 May 2025 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747828789;
	bh=agX0mZHJvTfw2UVHmhLTALRKExst9ZXIJ+Q2cytq7tk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ODoWPQcoz69PrZGw2fUeJCpgiNeidU66WTKUjvrWyurNZ0Tq/s8BugtOA3/LztIHF
	 9/aT3wUsjmoQ/Gr0tzDyXZ+IqC082XGomBp7riRZsD9X3iDTvdhc/JASS836jn8NY4
	 +LP/8ocwOTGKM5zWJs6lIc7ulEkxt7x6FXEkViud4+EtlefVdNVtFi3JUJVP5A4cum
	 QEnDsCoQuiftKCeqfchy+qoiBHsoekowpTtvBpT/VUBFyHwCuoPUIdP7vjDdqb5WnB
	 +RxdMepVipZ0gqfSm+WBmx7JMqshIpdL/0ZA+QwLJSbDqRW0FMPFMyhv0yWpXxsy1S
	 3HskpVHzuCyrA==
Message-ID: <a27741c1-5ac5-43e8-a784-5023f1784676@kernel.org>
Date: Wed, 21 May 2025 13:59:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: codecs: add support for ES8375
To: Zhang Yi <zhangyi@everest-semi.com>, broonie@kernel.org, robh@kernel.org,
 tiwai@suse.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, perex@perex.cz, krzk+dt@kernel.org
Cc: amadeuszx.slawinski@linux.intel.com
References: <20250521104247.6595-1-zhangyi@everest-semi.com>
 <20250521104247.6595-3-zhangyi@everest-semi.com>
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
In-Reply-To: <20250521104247.6595-3-zhangyi@everest-semi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2025 12:42, Zhang Yi wrote:
> +
> +static struct snd_soc_component_driver es8375_codec_driver = {
> +	.probe = es8375_codec_probe,
> +	.suspend = es8375_suspend,
> +	.resume = es8375_resume,
> +	.set_bias_level = es8375_set_bias_level,
> +	.controls = es8375_snd_controls,
> +	.num_controls = ARRAY_SIZE(es8375_snd_controls),
> +	.dapm_widgets = es8375_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(es8375_dapm_widgets),
> +	.dapm_routes = es8375_dapm_routes,
> +	.num_dapm_routes = ARRAY_SIZE(es8375_dapm_routes),
> +
> +	.idle_bias_on = 1,
> +	.suspend_bias_off = 1,
> +};
> +
> +static int es8375_read_device_properities(struct device *dev, struct es8375_priv *es8375)
> +{
> +	int ret;
> +
> +	ret = device_property_read_u8(dev, "everest,mclk-src", &es8375->mclk_src);

These are not documented for DT, but you have here other interfaces. We
do not have such case nicely solved, so please add explicit comment that
usage of this and dmic-pol in DT based platforms is not allowed and this
is not considered ABI.

> +	if (ret != 0)
> +		es8375->mclk_src = ES8375_MCLK_SOURCE;
> +	dev_dbg(dev, "mclk-src %x", es8375->mclk_src);
> +
> +	ret = device_property_read_u8(dev, "everest,dmic-pol", &es8375->dmic_pol);
> +	if (ret != 0)
> +		es8375->dmic_pol = DMIC_POL;
> +	dev_dbg(dev, "dmic-pol %x", es8375->dmic_pol);
> +


Best regards,
Krzysztof

