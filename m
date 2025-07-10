Return-Path: <linux-kernel+bounces-725198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A9AFFBD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FD01C84BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CD28B7FC;
	Thu, 10 Jul 2025 08:11:53 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F028B7DA;
	Thu, 10 Jul 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135113; cv=none; b=XPmhSZlBsgDc9LDf43iKIxoEz+xLGXr1ckLGjfNC38YmJ5dT0daX4BlEchcwL03m5gIIDab5nIA91ttDQa2hdvj+PwSuSrPGC4Ol21zUWtkxSd1CkZh3KSBT4j5FOy4FCGO+PpMwv7KVQ3epYfSj7i/aLnRsLnJGKpS0yyqzs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135113; c=relaxed/simple;
	bh=KdRG9hQox2LIVg5BQbJagwBCdXub17DTK0Abf1w5+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iob7tMiepsMK1OOy/NbAPZ9sE0gdysloBzprTAIq79bWfyw679SofW1zhLpG9w5Jfj3t9eypWAmktU+11Ng9QA1vMVILcWwi4vDdULQCI2nHGR24eAGXw8WTJ8RnWYmkUJdSp+3cQ6rnrwZPfGIp3jVgPydYpPEqnC66q7xuad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz8t1752135064t9362b96b
X-QQ-Originating-IP: r3LYCXsJvRGu4NM29rklbYDyiBmQ2Aw00APHKgzq3Aw=
Received: from localhost ( [183.17.231.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 16:11:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14875192277165604199
EX-QQ-RecipientCnt: 14
Date: Thu, 10 Jul 2025 16:11:02 +0800
From: Nick Li <nick.li@foursemi.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, perex@perex.cz,
	tiwai@suse.com, xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com, like.xy@foxmail.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: Add schema for FS2104/5S audio
 amplifiers
Message-ID: <BD2D8A14FDC941B8+aG91lowfru0KiWWW@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
 <20250708112901.25228-3-nick.li@foursemi.com>
 <20250709-invisible-frigatebird-of-felicity-7e87c4@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-invisible-frigatebird-of-felicity-7e87c4@krzk-bin>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MmIUUz9KGMMd5/Ko+h+fnJi05RQWsq8reqQBiAt6oWi59ZBkTF/AFz90
	Z/h2SSR2NpjrPRMrsXNqumktM4Pz1/6xVSwKsmnp2CYopdv49p+XfHAfo9dbShYpE9s3gTL
	/zHE+Vyd7bRdltaiRVGnOR5bUiT3hj4MRPAZhbW3jVXAcKbglRTJsj/vYjalkFpJWHrm/Vo
	GvArP8Ao9I9/jhHQRthfbcbK4mM1cq5kNgo1sQcoVbMUN7/kO3FxYTQ8jNmU/SEIOcl1qUH
	1L65sng1sAEZzrNEYDNAnBLzSywiyk36ytXoM8/2TgSAKVvnbA3CisadctPHZcp+OAJqNzV
	p2/d0jpsKm8+/4CUfeRxCZ5FNjjYaR4n450qHfJmmQ3FXn5lL9vyPjEclgdTOa80Ga4Zc89
	+nxOmEHz4CRY/jVLQ6q2RbHVEUDKRXnBxez8RrdvAcN6fNtLtINkhiNTrbWi36GQsWANm3B
	Qv1+YH28gT3HUgQHK0no4d6bHCFC/vEDl4El3xiFgaL//HwnCE3+uksBP/svby2guLPX8aS
	hUuhWRN1SpFB/R/RWSLSa9GXNci55rugKpTQOkF1NvwykErSr8JCVOi6Woj6B6Ce/UgxRy6
	AtzjSUjkhkHoBgxWTzyqx9rqIp5urcAF7Y+FFDjMe53pxbADC9FXecvc44D4Z2O6sYuD+sz
	kI1790MKbyPM/x8uQGSvvQ6tJ4/Ewp9YGDorqq6HReNLLDX5LHCRsjLj6a/FP6GSvAuwyYh
	1YBTzceS2p2TenxVqiWW7Knt1jgs+5esClDChFgDZlq+/3jKPf2gSuH6fYy4oIXRbf6WR4+
	uYJrLY/XaOGpAuyJA/1K/zI/ng5lCelkF0grgIhalmN4VZVHAXFEsn5GUzlV9FnCvaoAfgZ
	PuMIMF3w7K8fvC29fAAqWTKAtorM4YZ7zTl12J5H9WRG3sOz2h3KyxhGNvFSHR0UsDApiPM
	LbGLs6hy+gCrteV4MlWPTx3xI/HCMxZIHXUCkszjI011YM3PepOVxUp9nJjFU4WwTMzUdjM
	DrH5vsy1qbyYibpps/2DFOfrEk8zVPZEFKxWxoqA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Wed, Jul 09, 2025 at 12:40:33PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jul 08, 2025 at 07:28:59PM +0800, Nick Li wrote:
> > +description:
> > +  The FS2104 is a 15W Inductor-Less, Stereo, Closed-Loop,
> > +  Digital Input Class-D Power Amplifier with Enhanced Signal Processing.
> > +  The FS2105S is a 30W Inductor-Less, Stereo, Closed-Loop,
> > +  Digital Input Class-D Power Amplifier with Enhanced Signal Processing.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - foursemi,fs2104
> > +          - const: foursemi,fs2105s
> > +      - enum:
> > +          - foursemi,fs2105s
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      I2C address of the device. Refer to datasheet for possible values
> 
> Now the description is entirely redundant, brings no value. Drop.

OK.

> 
> > +
> > +  clocks:
> > +    description: The clock of I2S BCLK
> 
> This was different... Previous code was correct, this is not correct.
> And nothing in changelog explains this. Do not make random changes after
> review.
> 

OK, I will recover it to version v1.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: bclk
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  '#sound-dai-cells':
> > +    const: 0
> > +
> > +  pvdd-supply:
> > +    description:
> > +      Regulator for power supply(PVDD in datasheet).
> > +
> > +  dvdd-supply:
> > +    description:
> > +      Regulator for digital supply(DVDD in datasheet).
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      It's the SDZ pin in datasheet, the pin is active low,
> > +      it will power down and reset the chip to shut down state.
> > +
> > +  firmware-name:
> > +    maxItems: 1
> > +    description: |
> > +      The firmware(*.bin) contains:
> > +      a. Register initialization settings
> > +      b. DSP effect parameters
> > +      c. Multi-scene sound effect configurations(optional)
> > +      It's gernerated by FourSemi's tuning tool.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - firmware-name
> > +  - '#sound-dai-cells'
> 
> Keep the same order as in list of properties. OTOH, missing supplies.

OK, we will fix the order, but the supplies may not be used as regulator,
we mark them as required, is it OK?

Best regards,
Nick

> 
> > +
> > +allOf:
> > +  - $ref: dai-common.yaml#
> > +
> > +unevaluatedProperties: false
> 
> Best regards,
> Krzysztof
> 
> 

