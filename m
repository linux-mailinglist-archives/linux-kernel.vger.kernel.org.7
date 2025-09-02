Return-Path: <linux-kernel+bounces-796667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31B3B405C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E813565A38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2052D9EEA;
	Tue,  2 Sep 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0FKmOQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7D3594B;
	Tue,  2 Sep 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820882; cv=none; b=iwt5fw6z+HnrlRDdQUIpZihyGXXmXECNrrk/hX7IJs/qvp3i0RpeikJchS4/PsIg3o5lGBw1fJPwf2gJutt0sjH/anr5Ie+c0PFqkmqssysaAWNnBikA4Le3UKfVMzea8jdsHm4hCdO4efuOxF+RGxERyeD64uzkIvmJdyenVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820882; c=relaxed/simple;
	bh=0mFNiXS1ZYRpaAsAJURJYSZgLBLj8Xl7c8WmeKefqQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLeJWIRHJPgcX4n6mIJUrW/SfPx5TWGqPZmOc0gaXG5n6jQ+zcyR3y0CHPjBbZM9Bob18Rma5jGyrMkW1aba9j+umZ7+6rv1zxg5rvOWcS3GdKY6g+2Lb+U94499TaBcC1DkvbcpIprG8w5Y1N+Ry1qgcgFJHnFnSUwphV+/PZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0FKmOQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D599CC4CEED;
	Tue,  2 Sep 2025 13:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820882;
	bh=0mFNiXS1ZYRpaAsAJURJYSZgLBLj8Xl7c8WmeKefqQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G0FKmOQAjY1UCkqqGObi3FX33lMx/mOyGi54mNPwKEi5uqnQbO/FelW6YsCtU517x
	 QU4HMhBxAGlSZgcxV4fhzCI855utWhe/+PlVBMEsCWkf3r9p1gNoGVS8y5MfT0CKk3
	 +MGNcLLV6W3BrhsPuz/nwQKLbgeB+vUqKbUsJiraL5mzHHiLnqwiJVYe3/BLq/2upc
	 ViFFJ1HBD0sy89DJ8PIaZgmF5ogZAI3HmNeQympKt9yA85G3py4/lssULr7U+cdoBI
	 usT/TEr5V26Fo80czFmeearHc30z+t6W10+Q8pa9o88SfigSitFSlYakDaI82hLzmQ
	 HVgR/fwcBx7Eg==
Message-ID: <677aad27-66b9-4c4f-8fbe-6b9aabcd375a@kernel.org>
Date: Tue, 2 Sep 2025 15:47:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
To: Conor Dooley <conor@kernel.org>
Cc: Valentina.FernandezAlanis@microchip.com, Conor.Dooley@microchip.com,
 Daire.McNamara@microchip.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 robh@kernel.org, krzk+dt@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
 <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
 <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
 <bb5b0d71-41b1-48a0-82fc-bdb362cc3db1@microchip.com>
 <0d90eeb4-e6ac-459c-a6b1-26368f102e0e@kernel.org>
 <20250902-affair-scrambler-2771df16372e@spud>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250902-affair-scrambler-2771df16372e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2025 10:31, Conor Dooley wrote:
> On Tue, Sep 02, 2025 at 08:22:02AM +0200, Krzysztof Kozlowski wrote:
> 
>>>>> +     refclk_ccc: cccrefclk {
>>>>
>>>> Please use name for all fixed clocks which matches current format
>>>> recommendation: 'clock-<freq>' (see also the pattern in the binding for
>>>> any other options).
>>>>
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml
>>> The fabric dtsi describes elements configured by the FPGA bitstream. 
>>> This node is named as such because the Clock Conditioner Circuit CCC's 
>>> reference clock source is set by the FPGA bitstream, while its frequency 
>>> is determined by an on-board oscillator.
>>>
>>> Hope this clarifies the rationale behind the node name.
>> No, because there is no style naming clocks like this. Neither proper
>> suffix, nor prefix. Use standard naming.
> 
> So you want all fixed frequency clocks to be named "clk-foo" when
> "clk-<freq>" is not suitable? Fine if you do, but I didn't realise that
> it was required and haven't been keeping an eye out for it.

Recommended is to just use consistent suffixes or prefixes. Binding asks
for "clock-" so that's what I propose to use here.

Best regards,
Krzysztof

