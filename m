Return-Path: <linux-kernel+bounces-775217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13754B2BCB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C8F189BBDC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8784E31B126;
	Tue, 19 Aug 2025 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpWA2o8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45B31197F;
	Tue, 19 Aug 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594633; cv=none; b=rlGaZF4LUyzqhZaXvgPENTKj2MMbnIqV7kya9PdRtvgDjb0gWJfQlwH+dr6DZd30qi2deiVxCYi1hI0hmm4BMeK70ee47w7gGSX2IGj+uwajDM9/n3MUJmLVPcBbKj4XCN/BgEHsR9UfpPvBnT7V1SBsTmXN9bEiE7AB2EK8Afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594633; c=relaxed/simple;
	bh=1SSq/D6eu62T9bEwfEUnKWuT8GJ3sZYRtk3+0ypHiO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP0WAF4dqIQk0D/Fp1aGGhBmDqc3TLN9CdwE9K9VkXi14YX7vvSSeFJ+jTDvRb/523HVlbZC044ZrPAApVfEZNyR/7GK+niZ3ysAU7j0ludWg0aJIIxo5Z5YdnAmpK9ZP7dLQpVMUNPJhq3Hhczqs2SOhOF2wJRgYEBtvltnI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpWA2o8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1689C113D0;
	Tue, 19 Aug 2025 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594633;
	bh=1SSq/D6eu62T9bEwfEUnKWuT8GJ3sZYRtk3+0ypHiO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dpWA2o8o62EMJn53RjU4ScLXk7JM7wTmqEeQjhWKianQBl/rqaFNZD3r0S3Xma184
	 v6FVm34S8QvvQ7VhIIrYqjfS63GLvHOco/6UC1x/jDA+dG4yoYf0KOLzuqXrKKDDd6
	 kVQbb24xFIRfoGcFU/ru9mVz54XGIQGfnf1V416goKXbz8+wnVOhWGLpSMYPMDD/sj
	 CHFqdjiQMNuBbIOn+KSIMSenwomibyee/XqNcriqihBdnbUYC5JubKajKbMD8UrDdq
	 i1aOios9lF94JuyheDaP5yrqSE66p34pLD75/MoDjCjCtn3DPCSgRI6s4byMfWo+Zt
	 S3kHFp4yRA+aA==
Message-ID: <bfa23779-9861-4ae4-9ced-9f347394f033@kernel.org>
Date: Tue, 19 Aug 2025 11:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] riscv: dts: eswin: Add clock driver support
To: =?UTF-8?B?6JGj57uq5rSL?= <dongxuyang@eswincomputing.com>,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, linux-riscv@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093754.1143-1-dongxuyang@eswincomputing.com>
 <0ef61f03-0346-491d-ad2a-293e24cbc4a8@kernel.org>
 <3fa3950e.371.198c1770125.Coremail.dongxuyang@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <3fa3950e.371.198c1770125.Coremail.dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/08/2025 10:34, 董绪洋 wrote:
> Hi Krzysztof,
> 
> Thank you very much for your constructive suggestions.
> 
>>>
>>> Add clock device tree support for eic7700 SoC.
>>>
>>> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
>>> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
>>> ---
>>>  arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi | 2283 +++++++++++++++++
>>>  1 file changed, 2283 insertions(+)
>>>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi
>>>
>>> diff --git a/arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi b/arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi
>>> new file mode 100644
>>> index 000000000000..405d06f9190e
>>> --- /dev/null
>>> +++ b/arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi
>>> @@ -0,0 +1,2283 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/*
>>> + * Copyright (c) 2025, Beijing ESWIN Computing Technology Co., Ltd.
>>> + */
>>> +
>>> +/ {
>>> +	clock-controller@51828000 {
>>> +		compatible = "eswin,eic7700-clock";
>>> +		reg = <0x000000 0x51828000 0x000000 0x80000>;
>>> +		#clock-cells = <0>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		/* fixed clock */
>>> +		fixed_rate_clk_apll_fout2: fixed-rate-apll-fout2 {
>>
>> Such pattern was years ago NAKed.
>>
>> No, don't ever bring nodes per clock.
>>
> We have defined a large number of clock devices. 
> The comment of v3 is "Driver is also way too big for simple clock driver and I 
> am surprised to see so many redundancies.". Therefore, we modified the clock 
> driver code and moved the description of clock device from the driver to the DTS.
> 
> But, this comment is that don't ever bring nodes per clock. We’ve run into some

And? What is unclear in that comment?

> trouble and aren’t sure which approach aligns better with community guidelines. 
> Could you share your advice or suggestions on the best way forward?

Look at any other recent clock drivers.

Best regards,
Krzysztof

