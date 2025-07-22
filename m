Return-Path: <linux-kernel+bounces-740565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0AEB0D5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82887174A85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183D92DC348;
	Tue, 22 Jul 2025 09:21:14 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899A238C21;
	Tue, 22 Jul 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176073; cv=none; b=jNQNri0i4O0d0Mz32Zr0I9TdO7fErsdLBcrWwzJOIEMWUqOP4LorRxzyX6lrMwvqNnNWvbtVWXm2HKqPc6zNCcf1eZr5NrwiGyVDGKAFwGaSQf290xSNg6+/n0ZPPg5eNC9aGwBvh82VqeJMsne/wLjBJN48f/e63LyOwPWdr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176073; c=relaxed/simple;
	bh=gD+1KoPxD7j0X9n4QTuWeNii1Ldwc+riVNjyd3Y0S+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3Sx72Hd+NqyD5JYrp7knQb3c9db55cmhdWMvHA3Ro5rLWbhIKZrt121d54iJ2dnfQx08HiMOQJoeyB0W4xqpREybG9N+E6MDDBtn70IbY6jksi3Y5wkZakZgfDVhQxtPTi7+S7L04MWq1YtcLn57rhFdflum5S8Cpxy5LP30gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A2A59341707;
	Tue, 22 Jul 2025 09:21:10 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:21:01 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Alex Elder <elder@riscstar.com>,
	Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: spacemit: CLK_SSPA_I2S_BCLK
 for SSPA
Message-ID: <20250722092101-GYB724801@gentoo>
References: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
 <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>

Hi Troy,

On 15:36 Tue 22 Jul     , Troy Mitchell wrote:
> This patch adds macro definitions: SSPAx_I2S_BCLK,
this is obvious, so no need to repeat, please add something useful

> to introduce a dummy gate for i2s_bclk.
                ~~~~~~ 'virtual'? if it isn't a real gate clock,
	but I'm not sure it's a good approach to introduce such
	virtual clock if underlying hw doesn't comply with this

> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  include/dt-bindings/clock/spacemit,k1-syscon.h | 114 +++++++++++++------------
>  1 file changed, 58 insertions(+), 56 deletions(-)
dt-binding patch should always go first

> 
> diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
> index 35968ae98246609c889eb4a7d08b4ff7360de53b..6914ccf5be45a1071d5b6eac354cacb67888e00c 100644
> --- a/include/dt-bindings/clock/spacemit,k1-syscon.h
> +++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
> @@ -123,62 +123,64 @@
>  #define CLK_TIMERS2		41
>  #define CLK_AIB			42
>  #define CLK_ONEWIRE		43
> -#define CLK_SSPA0		44
> -#define CLK_SSPA1		45
> -#define CLK_DRO			46
> -#define CLK_IR			47
> -#define CLK_TSEN		48
> -#define CLK_IPC_AP2AUD		49
> -#define CLK_CAN0		50
> -#define CLK_CAN0_BUS		51
> -#define CLK_UART0_BUS		52
> -#define CLK_UART2_BUS		53
> -#define CLK_UART3_BUS		54
> -#define CLK_UART4_BUS		55
> -#define CLK_UART5_BUS		56
> -#define CLK_UART6_BUS		57
> -#define CLK_UART7_BUS		58
> -#define CLK_UART8_BUS		59
> -#define CLK_UART9_BUS		60
> -#define CLK_GPIO_BUS		61
> -#define CLK_PWM0_BUS		62
> -#define CLK_PWM1_BUS		63
> -#define CLK_PWM2_BUS		64
> -#define CLK_PWM3_BUS		65
> -#define CLK_PWM4_BUS		66
> -#define CLK_PWM5_BUS		67
> -#define CLK_PWM6_BUS		68
> -#define CLK_PWM7_BUS		69
> -#define CLK_PWM8_BUS		70
> -#define CLK_PWM9_BUS		71
> -#define CLK_PWM10_BUS		72
> -#define CLK_PWM11_BUS		73
> -#define CLK_PWM12_BUS		74
> -#define CLK_PWM13_BUS		75
> -#define CLK_PWM14_BUS		76
> -#define CLK_PWM15_BUS		77
> -#define CLK_PWM16_BUS		78
> -#define CLK_PWM17_BUS		79
> -#define CLK_PWM18_BUS		80
> -#define CLK_PWM19_BUS		81
> -#define CLK_SSP3_BUS		82
> -#define CLK_RTC_BUS		83
> -#define CLK_TWSI0_BUS		84
> -#define CLK_TWSI1_BUS		85
> -#define CLK_TWSI2_BUS		86
> -#define CLK_TWSI4_BUS		87
> -#define CLK_TWSI5_BUS		88
> -#define CLK_TWSI6_BUS		89
> -#define CLK_TWSI7_BUS		90
> -#define CLK_TWSI8_BUS		91
> -#define CLK_TIMERS1_BUS		92
> -#define CLK_TIMERS2_BUS		93
> -#define CLK_AIB_BUS		94
> -#define CLK_ONEWIRE_BUS		95
> -#define CLK_SSPA0_BUS		96
> -#define CLK_SSPA1_BUS		97
> -#define CLK_TSEN_BUS		98
> -#define CLK_IPC_AP2AUD_BUS	99
> +#define CLK_SSPA0_I2S_BCLK	44
> +#define CLK_SSPA1_I2S_BCLK	45
just append the clock at the end, instead of doing massive renaming

> +#define CLK_SSPA0		46
> +#define CLK_SSPA1		47
> +#define CLK_DRO			48
> +#define CLK_IR			49
> +#define CLK_TSEN		50
> +#define CLK_IPC_AP2AUD		51
> +#define CLK_CAN0		52
> +#define CLK_CAN0_BUS		53
> +#define CLK_UART0_BUS		54
> +#define CLK_UART2_BUS		55
> +#define CLK_UART3_BUS		56
> +#define CLK_UART4_BUS		57
> +#define CLK_UART5_BUS		58
> +#define CLK_UART6_BUS		59
> +#define CLK_UART7_BUS		60
> +#define CLK_UART8_BUS		61
> +#define CLK_UART9_BUS		62
> +#define CLK_GPIO_BUS		63
> +#define CLK_PWM0_BUS		64
> +#define CLK_PWM1_BUS		65
> +#define CLK_PWM2_BUS		66
> +#define CLK_PWM3_BUS		67
> +#define CLK_PWM4_BUS		68
> +#define CLK_PWM5_BUS		69
> +#define CLK_PWM6_BUS		70
> +#define CLK_PWM7_BUS		71
> +#define CLK_PWM8_BUS		72
> +#define CLK_PWM9_BUS		73
> +#define CLK_PWM10_BUS		74
> +#define CLK_PWM11_BUS		75
> +#define CLK_PWM12_BUS		76
> +#define CLK_PWM13_BUS		77
> +#define CLK_PWM14_BUS		78
> +#define CLK_PWM15_BUS		79
> +#define CLK_PWM16_BUS		80
> +#define CLK_PWM17_BUS		81
> +#define CLK_PWM18_BUS		82
> +#define CLK_PWM19_BUS		83
> +#define CLK_SSP3_BUS		84
> +#define CLK_RTC_BUS		85
> +#define CLK_TWSI0_BUS		86
> +#define CLK_TWSI1_BUS		87
> +#define CLK_TWSI2_BUS		88
> +#define CLK_TWSI4_BUS		89
> +#define CLK_TWSI5_BUS		90
> +#define CLK_TWSI6_BUS		91
> +#define CLK_TWSI7_BUS		92
> +#define CLK_TWSI8_BUS		93
> +#define CLK_TIMERS1_BUS		94
> +#define CLK_TIMERS2_BUS		95
> +#define CLK_AIB_BUS		96
> +#define CLK_ONEWIRE_BUS		97
> +#define CLK_SSPA0_BUS		98
> +#define CLK_SSPA1_BUS		99
> +#define CLK_TSEN_BUS		100
> +#define CLK_IPC_AP2AUD_BUS	101
>  
>  /* APMU clocks */
>  #define CLK_CCI550		0
> 
> -- 
> 2.50.1
> 

-- 
Yixun Lan (dlan)

