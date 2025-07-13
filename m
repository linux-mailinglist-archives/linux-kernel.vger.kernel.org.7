Return-Path: <linux-kernel+bounces-729133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14190B03230
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C643A99CB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED5277CBC;
	Sun, 13 Jul 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="D79b8Dc4"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CBF283FE9;
	Sun, 13 Jul 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752425365; cv=pass; b=LllCzV9AtaZ48rcJhU3202cHgCQPjBHc2yahMaD0E84YasklrV7BY0M5utDzQyyPkWC7H5b7/YQXrnowUIjqnBZ7NpGrDFFZbDTtvPmgxoqPwbn8VGP6PkR/1LFGyamyfpXBqDg02nAHFcs7JcSK/qegyqyA5QcdQqqhwSQmz+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752425365; c=relaxed/simple;
	bh=Dpmyiq8FH8vpGmMMwnfxM9hYW7gNx3icTsVMSFQWlcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1LdlrT0c/WV09XldFEeM0S2ReSGxtg1jhWOTGLfWH5zwErLvqMY5wXTEivjqx46vqV8paFllm1x4pKysCVSX//B9Q9JJRl+Vm1zq5Chg2ptforcVZeIlrza15DQbG4vqkirVkzqO1H0VtFEowecOBnCaQJdRW4OJ2vR4yICqEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=D79b8Dc4; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752425346; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c7MZevP3sKW018gKsWxOJeNgAaXx7fdFn5HXYJv1SepzHzM9aTHYQ9ueEUfHp7Wonmh+dHBvlI3RJIfFpF3Fww/2LYhs6zCwEn1ct9ySZyvYH8cFtInxufyuYgxKOYIbmrETzaFRWQfp86AafdgIDfy8alc6HR+0Bt27Zymb8Yc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752425346; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rjQcOjdpmHK6mcrEnsIMoe5s+xZNboblDGM+pP9AkVc=; 
	b=Sf1jeh++32agAO8glEe3BMz/0tx0hE2nHIZZ1RSAX7cEcBPjMwUC6OTgmrxKema5wxW+Btl0SZ/npVsBpolzXCVCUQrj15BqLFeYsAotr/YtUtPgZhkBNqm3NCP8BOW5Qfl1WLEkZBuehtIKfqHiWI3C8I5wUpUWS31dk3Ia8wE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752425346;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=rjQcOjdpmHK6mcrEnsIMoe5s+xZNboblDGM+pP9AkVc=;
	b=D79b8Dc4y66g5Nh/b08lMEgR758ic0VQ5UuqHkJ15B5D+Wv0I7zD2lnW5BBDAyAX
	Iz6fF0wJKaBjvg3Aj0KwKXxDguKIFaadxZtUh4tvj1QVfl0TVdZGonh+unlfwPxZH9E
	zcascARpbwEtZgCCW/XF9ho61xMK8k4aQ95wQhKI=
Received: by mx.zohomail.com with SMTPS id 175242533137147.170436231877716;
	Sun, 13 Jul 2025 09:48:51 -0700 (PDT)
Message-ID: <776638cc-cbd9-4747-82eb-e11bcc6c8bdd@zohomail.com>
Date: Mon, 14 Jul 2025 00:48:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] riscv: canaan: Add support for K230-Canmv clock
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Troy Mitchell <TroyMitchell988@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com>
From: Xukai Wang <kingxukai@zohomail.com>
Content-Language: en-US
In-Reply-To: <20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227880f38caa1930ad1c9b780930000faaf536ef634abd61e4f6519b99c87b19288cacb14dd802076:zu08011227e2968d9b4ed54629e843bd360000cb99e0991875710b13ecb368d541820e68b7cad0360fbc2f1a:rf0801122d3a7a9663a8acbc1f2172599900004c3708170fa28df8c0b3ab9b75822793432367716206bb0a8d6cbcdbe80463:ZohoMail
X-ZohoMailClient: External


On 2025/4/15 22:25, Xukai Wang wrote:
> This patch series adds clock controller support for the Canaan Kendryte
> K230 SoC. The K230 SoC includes an external 24MHz OSC and 4 internal
> PLLs, with the controller managing these sources and their derived clocks.
>
> The clock tree and hardware-specific definition can be found in the
> vendor's DTS [1],
> and this series is based on the K230 initial series [2].
>
> Link: https://github.com/ruyisdk/linux-xuantie-kernel/blob/linux-6.6.36/arch/riscv/boot/dts/canaan/k230_clock_provider.dtsi [1]
> Link: https://lore.kernel.org/linux-clk/tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com/ [2]
>
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>
> ---
> Changes in v6:
> - Remove some redundant comments in struct declaration.
> - Replace the Vendor's code source link with a new one.
> - Link to v5: https://lore.kernel.org/r/20250320-b4-k230-clk-v5-0-0e9d089c5488@zohomail.com
>
> Changes in v5:
> - Fix incorrect base-commit and add prerequisite-patch-id.
> - Replace dummy apb_clk with real ones for UARTs.
> - Add IDs of UARTs clock and DMA clocks in the binding header.
> - Replace k230_clk_cfgs[] array with corresponding named variables.
> - Remove some redundant checks in clk_ops.
> - Drop the unnecessary parenthesis and type casts.
> - Modify return value handling in probe path to avoid redundant print.
> - Link to v4: https://lore.kernel.org/r/20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com
>
> Changes in v4:
> - Remove redundant onecell_get callback and add_provider function
> for pll_divs.
> - Modify the base-commit in cover letter.
> - Link to v3: https://lore.kernel.org/r/20250203-b4-k230-clk-v3-0-362c79124572@zohomail.com
>
> Changes in v3:
> - Reorder the defination and declaration in drivers code.
> - Reorder the properties in dts node.
> - Replace global variable `k230_sysclk` with dynamic memory allocation.
> - Rename the macro K230_NUM_CLKS to K230_CLK_NUM.
> - Use dev_err_probe for error handling.
> - Remove unused includes.
> - Link to v2: https://lore.kernel.org/r/20250108-b4-k230-clk-v2-0-27b30a2ca52d@zohomail.com
>
> Changes in v2:
> - Add items and description.
> - Rename k230-clk.h to canaan,k230-clk.h
> - Link to v1: https://lore.kernel.org/r/20241229-b4-k230-clk-v1-0-221a917e80ed@zohomail.com
>
> ---
> Xukai Wang (3):
>       dt-bindings: clock: Add bindings for Canaan K230 clock controller
>       clk: canaan: Add clock driver for Canaan K230
>       riscv: dts: canaan: Add clock definition for K230
>
>  .../devicetree/bindings/clock/canaan,k230-clk.yaml |   43 +
>  arch/riscv/boot/dts/canaan/k230.dtsi               |   25 +-
>  drivers/clk/Kconfig                                |    6 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-k230.c                             | 1710 ++++++++++++++++++++
>  include/dt-bindings/clock/canaan,k230-clk.h        |   69 +
>  6 files changed, 1846 insertions(+), 8 deletions(-)
> ---
> base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
> change-id: 20241206-b4-k230-clk-925f33fed6c2
> prerequisite-patch-id: deda3c472f0000ffd40cddd7cf6d3b5e2d7da7dc
>
> Best regards,
Dear all,

I'm working on a Linux clock driver and have encountered a question
regarding how to properly represent a particular type of clock source.

In K230 SoC, there's a mux clock whose parent can optionally be an
external pulse signal, which is counted via a pin (the input is not
generated internally but comes from an external source). I’m wondering:

Should this external pulse signal be modeled as a clock within the
Common Clock Framework (CCF)?

If so, what would be the correct way to register or describe such a
clock in the driver?

Any guidance or examples would be greatly appreciated.


