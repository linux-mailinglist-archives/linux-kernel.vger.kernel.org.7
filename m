Return-Path: <linux-kernel+bounces-750265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA0B1594A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3278718A75CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D01FDE3D;
	Wed, 30 Jul 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgTLrhnx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F01F1932;
	Wed, 30 Jul 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753859201; cv=none; b=RqBfryc/MGhfVxcdCsPggaN4R6msS/8J5BoSszyOOiRpeGEH2MeyVdrsh+/fg7Wu4Nw+HC75b7Y+fdKY7+qqkOsAlitSf1Gy9uCXX9e1U8wuNi2eReNJCiEoEwx/tsags7e26zy9LFf3r3N7iEfvI0m5k2FS9srSNjf/udso/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753859201; c=relaxed/simple;
	bh=KlI1XPaFmUg2EcZ0srrQoO2VB9R/Kuj5mD2SUgA4Yho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L74n9/yFjp6Z4BVzXlmrVxHVs6If/Mq4zfapwp/5EhibtM1kvFjm78w6iUWCQSqe99EpvjBB70ThF/iGN39/nRCdh+GSDbTPGE+mRfvkoleYjwIKKx3nH2RbLyFLZHqx9qeVg7sEsHgfWRH+VdJwOxpAlWMv83ln/4DVrs2kMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgTLrhnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA33C4CEE7;
	Wed, 30 Jul 2025 07:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753859201;
	bh=KlI1XPaFmUg2EcZ0srrQoO2VB9R/Kuj5mD2SUgA4Yho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgTLrhnxvCTrx9QaVzU9EIM2tTnQ9jk06DoDKo1YEgouN01AsKMo5YVcOkoliFp0u
	 0uxNM2NW9iHq2EgCrzaBF14wUjCbVtGUQCPSghydc1Sd1nwxEz+fuce4nC1mluLc+C
	 a7Rn+9kfaD6COIA5FHkWtfnTqQ9Jd1kRvFSx6i6xJQu8QHdZnw3zqzkTSg3X4v+a2C
	 0e3yibcFCUcyWUPUIY+kE+0eg0E7+A4EaNfgwqeMqThVaH9WmuOkqvnu992OSc5s9L
	 k/PV2AnKGPgMrndn5g8nn39Vi1hcF/m65dVdPcRG/MobFxDuH+o9nIF43sm5HHDY/P
	 I2fNRSVSURb1A==
Date: Wed, 30 Jul 2025 09:06:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xukai Wang <kingxukai@zohomail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Samuel Holland <samuel.holland@sifive.com>, Troy Mitchell <TroyMitchell988@gmail.com>
Subject: Re: [PATCH v7 3/3] riscv: dts: canaan: Add clock definition for K230
Message-ID: <20250730-laughing-dancing-emu-5540d6@kuoka>
References: <20250730-b4-k230-clk-v7-0-c57d3bb593d3@zohomail.com>
 <20250730-b4-k230-clk-v7-3-c57d3bb593d3@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250730-b4-k230-clk-v7-3-c57d3bb593d3@zohomail.com>

On Wed, Jul 30, 2025 at 02:43:53AM +0800, Xukai Wang wrote:
> This patch describes the clock controller integrated in K230 SoC
> and replace dummy clocks with the real ones for UARTs.
> 
> For k230-canmv and k230-evb, they provide an additional external
> pulse input through a pin to serve as clock source.
> 
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  arch/riscv/boot/dts/canaan/k230-canmv.dts | 11 +++++++++++
>  arch/riscv/boot/dts/canaan/k230-evb.dts   | 11 +++++++++++
>  arch/riscv/boot/dts/canaan/k230.dtsi      | 26 ++++++++++++++++++--------
>  3 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts b/arch/riscv/boot/dts/canaan/k230-canmv.dts
> index 9565915cead6ad2381ea8249b616e79575feb896..6579d39e2c1690d9e9c2b9c884db528c37473204 100644
> --- a/arch/riscv/boot/dts/canaan/k230-canmv.dts
> +++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
> @@ -17,8 +17,19 @@ ddr: memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x20000000>;
>  	};
> +
> +	timerx_pulse_in: timer_pulse_in {

Follow DTS coding style.

Please use name for all fixed clocks which matches current format
recommendation: 'clock-<freq>' (see also the pattern in the binding for
any other options).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml?h=v6.11-rc1

Best regards,
Krzysztof


