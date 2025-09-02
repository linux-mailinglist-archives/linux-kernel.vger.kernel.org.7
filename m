Return-Path: <linux-kernel+bounces-795615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA2B3F557
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBD51A8380A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD212E336F;
	Tue,  2 Sep 2025 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUd59Pfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800142DF146;
	Tue,  2 Sep 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794129; cv=none; b=Jy1FGZ64YWHqQXwP8NgqD+GrBlHL0P9DE3YS3w3L4FO+vWnRCQkH+qD81Z4Fb2PMD+ocyF/eI55zBkqPufq4NKwEGkz+bwcMOxE8E+sFmUi7TcbW7zmyeGSV+rNkvWPzqx7CguwTMgoyjXh93FuRKEHNg2DmFqHXqWNmYfJS2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794129; c=relaxed/simple;
	bh=r81mtkTSMvg0n2cr7G909YBE9Pq0GkMchHirgi8Pb6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTrT4luK+J/oUQlRC5RWce1IHrEgP1UBz93q3lB2UZKFfaqFZ8HkXmDEXhYOQNBEAsMUIwQ5v2EsVPe6JoaaNkRtypWVkYMnejYKkK2go9NLQDxObyhp6Sg/MZdUWFTVfjPYGIinVHuYMwCTnOpoQgBBEuGIB7+c07sOjvx5rkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUd59Pfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B4DC4CEED;
	Tue,  2 Sep 2025 06:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756794128;
	bh=r81mtkTSMvg0n2cr7G909YBE9Pq0GkMchHirgi8Pb6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AUd59PfeXyGTwZ0pgiqu/lN9RNRJcHvIC4lX++5sdzlCjjCnieS8bK8g0JG38atRd
	 1nf4tdplKpGJ9GMsEmdAVfZXSMgnzWgs+zaWf3i9bdJuBhkrQGlh4lrh2Yy/v9YW4s
	 Cv7uszqL/tzRomst0Cqp24g9nRE1p7VDoL8i/zy4rrff7CTXlIq6y+Eek0jkdZhFFe
	 JZ5kh/gZao4hiLLaJ1n7wt8vOPZt6M8IROKUeF7SgUIMbj1T8e1p1q8RdP5RK/cBp/
	 cL1vhg8gZJbZ18H76NrjYkzIKGyndYlGxjaHM3Ykn4VSoKropsjEhUAwJeyp2KE6US
	 oEoD123gdzOWg==
Message-ID: <0d90eeb4-e6ac-459c-a6b1-26368f102e0e@kernel.org>
Date: Tue, 2 Sep 2025 08:22:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
To: Valentina.FernandezAlanis@microchip.com, Conor.Dooley@microchip.com,
 Daire.McNamara@microchip.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 robh@kernel.org, krzk+dt@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
 <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
 <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
 <bb5b0d71-41b1-48a0-82fc-bdb362cc3db1@microchip.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <bb5b0d71-41b1-48a0-82fc-bdb362cc3db1@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2025 17:28, Valentina.FernandezAlanis@microchip.com wrote:
> On 28/08/2025 18:46, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 25/08/2025 18:19, Valentina Fernandez wrote:
>>> +++ b/arch/riscv/boot/dts/microchip/mpfs-disco-kit-fabric.dtsi
>>> @@ -0,0 +1,58 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/* Copyright (c) 2020-2025 Microchip Technology Inc */
>>> +
>>> +/ {
>>> +     core_pwm0: pwm@40000000 {
>>> +             compatible = "microchip,corepwm-rtl-v4";
>>> +             reg = <0x0 0x40000000 0x0 0xF0>;
>>> +             microchip,sync-update-mask = /bits/ 32 <0>;
>>> +             #pwm-cells = <3>;
>>> +             clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
>>> +             status = "disabled";
>>> +     };
>>> +
>>> +     i2c2: i2c@40000200 {
>>> +             compatible = "microchip,corei2c-rtl-v7";
>>> +             reg = <0x0 0x40000200 0x0 0x100>;
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>> +             clocks = <&ccc_sw CLK_CCC_PLL0_OUT3>;
>>> +             interrupt-parent = <&plic>;
>>> +             interrupts = <122>;
>>> +             clock-frequency = <100000>;
>>> +             status = "disabled";
>>> +     };
>>> +
>>> +     ihc: mailbox {
>>> +             compatible = "microchip,sbi-ipc";
>>> +             interrupt-parent = <&plic>;
>>> +             interrupts = <180>, <179>, <178>, <177>;
>>> +             interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
>>> +             #mbox-cells = <1>;
>>> +             status = "disabled";
>>> +     };
>>> +
>>> +     mailbox@50000000 {
>>> +             compatible = "microchip,miv-ihc-rtl-v2";
>>> +             microchip,ihc-chan-disabled-mask = /bits/ 16 <0>;
>>
>> Does not look like following DTS coding style - order of properties.
>>
>>> +             reg = <0x0 0x50000000 0x0 0x1c000>;
>>> +             interrupt-parent = <&plic>;
>>> +             interrupts = <180>, <179>, <178>, <177>;
>>> +             interrupt-names = "hart-1", "hart-2", "hart-3", "hart-4";
>>> +             #mbox-cells = <1>;
>>> +             status = "disabled";
>>> +     };
>>> +
>>> +     refclk_ccc: cccrefclk {
>>
>> Please use name for all fixed clocks which matches current format
>> recommendation: 'clock-<freq>' (see also the pattern in the binding for
>> any other options).
>>
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> The fabric dtsi describes elements configured by the FPGA bitstream. 
> This node is named as such because the Clock Conditioner Circuit CCC's 
> reference clock source is set by the FPGA bitstream, while its frequency 
> is determined by an on-board oscillator.
> 
> Hope this clarifies the rationale behind the node name.
No, because there is no style naming clocks like this. Neither proper
suffix, nor prefix. Use standard naming.

And all other comments you ignored?

Best regards,
Krzysztof

