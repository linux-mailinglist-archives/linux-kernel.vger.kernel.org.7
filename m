Return-Path: <linux-kernel+bounces-740577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9057B0D5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DAC3B4E52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692692DCBFA;
	Tue, 22 Jul 2025 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="GZxr7HQ6"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8112DAFC8;
	Tue, 22 Jul 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176452; cv=none; b=sukgYFzOmnrzFMTiPZdnSr6mN5YGVdViwsg6dmn2J3/sfo9lunHk0SXhxz84NtfqpzEHbuN7XKm96pLKHUVSwK2ZWiXV2o93xzPNOUMh5oifGU/YZFpbHfW18imZxYiiDMguv3gNaDZsJoNUUOyi24V2y9IE+lCSAEvcSEPGjz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176452; c=relaxed/simple;
	bh=hm0MDNVGTHkfEQyNclOVv9LrcVhjQQoSmlBG0fSQl8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLcGql8e/Zxvd3v79bhNodsi6m8sqmgWd3QdhRqsddef9LC4YRoB7pC8e9C4qbeh+k1E5RBK9wqOsxPS1zEOisp5Ig3G7S9x5KJVKwfNeRe3PNa8zE6LOevK8YQ+QDoyhIngqXAiXEDOiALMd3QPsm9sLcmfNazjkHjz6OQkDrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=GZxr7HQ6; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753176435;
	bh=TRVPd71zeoiK4DPqUkd8EQStv1Rk+guI8JA/3LPZ5WI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=GZxr7HQ6IZ8qn13M0xgEFMJs7C5xiGNJioPvIfU/yziu3oxbUprl5fm8SDxWZvHsm
	 SFbVyyPP/WoQ5Wg/L5qQVOmLsr0cZP63iBEoDgD7QT8oMLRtm6+dHt27FLiIygKsY5
	 fa/tW0EjIle4O3mf31R+BDCOGCpuJfj9CmrBLUuw=
X-QQ-mid: zesmtpsz3t1753176433ta948de66
X-QQ-Originating-IP: hZhfkR09qBGZB9GkqYYtLQZx8UBF6GjcT9szJH6ufho=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 17:27:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4925773881467516370
EX-QQ-RecipientCnt: 15
Date: Tue, 22 Jul 2025 17:27:11 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <B79CAF56E128A7B3+aH9Zb9zNm6y_ovvW@LT-Guozexi>
References: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
 <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>
 <20250722092101-GYB724801@gentoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722092101-GYB724801@gentoo>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: ND42uzdxTIzrTStEG2OTrO65ZHeduLJCLcFAQPsYqgyD3b7xZimz/LJu
	y+i7RxhPZPbHS0WUvvQQtJu/M/nxHaBfJm/z86UqPuqC91lbinPT6WRjZVwK2MP/hJGktkx
	loU5sWzhfuuhAam5L52Qur6PgDNaG0ZfT7oj30Ebr5ZBYuFe8f7nBKoU4ancz8Uehg9pV8L
	X6q+PvQNaLQbr96JXdxcsQ45vOsRB0YuWk4r0chEliAX6AvvkY/xl2qbdLdAzXEhURrvBne
	Xpu9sL7hIXrD+CKCKuszMU8lCetx4p/GKd3XYcasMmMOF6GN8EIZS8I9irw62igWefc2JnU
	nY7+5ufrnQ2zMsZj3eYSIFZdLuk+ZPOhn/O/Z//mrNIvIjxhd1djwgvr5gYt9oSyNc6o1E4
	RQyA9kLskKY42Sc0vDNCOqs9ew0MZzwzdkCdMvWF2oYkcaspXLPg/pOim3Q1j7n4T7lALMc
	nYQ1QYQhOBeHg+OjCw1ODAFeVm0EjYsjHCll5M6eLwHTxD9CFZowgHyilf1sv/oH7FSC6IB
	718uV6cNtgY/325LBjzi2qWcfokc7rby1lzkvsmxjSIPM7+12Xsj43lETcWye9Vrt/JOdcp
	dOcsQ/0bmscl61tnj9SoDACuaGSoIFxO1Gh3pntyrXfjcOBMqobTPqHgMPaKI/f5Wk7k4Sa
	mY37namuF6TblkcRDEuaAnkRWt/TsMKtxRw2n1goR8i5hs569hwED9mbojAfh8LLYYuEc7P
	d45mhsSwWktrXgBLgk5vueiC67++Gkah2QhwdBdItMB9XFDaKpjNIXDZRv5sXtfsOEjzVm2
	KE5vTvwnePewP/wWXkZAeeIHVfU8pjTpnpBn9bSaNRhz+CfhzWh8uiJS+zRW+hA5qf+rYeY
	Z4uZF0Lqq8VpL6T9sBMLo2nEUvN+0ChpT++sSo25mtkpTthc0K6FrmemxMoQaVlKzBPyJQs
	J0AanLIQpPoxbHCJLrq2BZaAFzsuT1GyxiUEu2ylfeKyuGREuJ5kVbBlgRfcvRmA7Olyp1E
	ExeI1/QeIs0UTFNFcZcGg6HbvzFFwk0GIbQjW0LQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 05:21:01PM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 15:36 Tue 22 Jul     , Troy Mitchell wrote:
> > This patch adds macro definitions: SSPAx_I2S_BCLK,
> this is obvious, so no need to repeat, please add something useful
> 
> > to introduce a dummy gate for i2s_bclk.
>                 ~~~~~~ 'virtual'? if it isn't a real gate clock,
> 	but I'm not sure it's a good approach to introduce such
> 	virtual clock if underlying hw doesn't comply with this
I'll leave this question to others.

> 
> > 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  include/dt-bindings/clock/spacemit,k1-syscon.h | 114 +++++++++++++------------
> >  1 file changed, 58 insertions(+), 56 deletions(-)
> dt-binding patch should always go first
get it

> 
> > 
> > diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
> > index 35968ae98246609c889eb4a7d08b4ff7360de53b..6914ccf5be45a1071d5b6eac354cacb67888e00c 100644
> > --- a/include/dt-bindings/clock/spacemit,k1-syscon.h
> > +++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
> > @@ -123,62 +123,64 @@
> >  #define CLK_TIMERS2		41
> >  #define CLK_AIB			42
> >  #define CLK_ONEWIRE		43
> > -#define CLK_SSPA0		44
> > -#define CLK_SSPA1		45
> > -#define CLK_DRO			46
> > -#define CLK_IR			47
> > -#define CLK_TSEN		48
> > -#define CLK_IPC_AP2AUD		49
> > -#define CLK_CAN0		50
> > -#define CLK_CAN0_BUS		51
> > -#define CLK_UART0_BUS		52
> > -#define CLK_UART2_BUS		53
> > -#define CLK_UART3_BUS		54
> > -#define CLK_UART4_BUS		55
> > -#define CLK_UART5_BUS		56
> > -#define CLK_UART6_BUS		57
> > -#define CLK_UART7_BUS		58
> > -#define CLK_UART8_BUS		59
> > -#define CLK_UART9_BUS		60
> > -#define CLK_GPIO_BUS		61
> > -#define CLK_PWM0_BUS		62
> > -#define CLK_PWM1_BUS		63
> > -#define CLK_PWM2_BUS		64
> > -#define CLK_PWM3_BUS		65
> > -#define CLK_PWM4_BUS		66
> > -#define CLK_PWM5_BUS		67
> > -#define CLK_PWM6_BUS		68
> > -#define CLK_PWM7_BUS		69
> > -#define CLK_PWM8_BUS		70
> > -#define CLK_PWM9_BUS		71
> > -#define CLK_PWM10_BUS		72
> > -#define CLK_PWM11_BUS		73
> > -#define CLK_PWM12_BUS		74
> > -#define CLK_PWM13_BUS		75
> > -#define CLK_PWM14_BUS		76
> > -#define CLK_PWM15_BUS		77
> > -#define CLK_PWM16_BUS		78
> > -#define CLK_PWM17_BUS		79
> > -#define CLK_PWM18_BUS		80
> > -#define CLK_PWM19_BUS		81
> > -#define CLK_SSP3_BUS		82
> > -#define CLK_RTC_BUS		83
> > -#define CLK_TWSI0_BUS		84
> > -#define CLK_TWSI1_BUS		85
> > -#define CLK_TWSI2_BUS		86
> > -#define CLK_TWSI4_BUS		87
> > -#define CLK_TWSI5_BUS		88
> > -#define CLK_TWSI6_BUS		89
> > -#define CLK_TWSI7_BUS		90
> > -#define CLK_TWSI8_BUS		91
> > -#define CLK_TIMERS1_BUS		92
> > -#define CLK_TIMERS2_BUS		93
> > -#define CLK_AIB_BUS		94
> > -#define CLK_ONEWIRE_BUS		95
> > -#define CLK_SSPA0_BUS		96
> > -#define CLK_SSPA1_BUS		97
> > -#define CLK_TSEN_BUS		98
> > -#define CLK_IPC_AP2AUD_BUS	99
> > +#define CLK_SSPA0_I2S_BCLK	44
> > +#define CLK_SSPA1_I2S_BCLK	45
> just append the clock at the end, instead of doing massive renaming
The c file is written in the same order as the h file,
and I don't want to disrupt this order..

So should I keep this style or just append at the end?

                - Troy
> 
> > +#define CLK_SSPA0		46
> > +#define CLK_SSPA1		47
> > +#define CLK_DRO			48
> > +#define CLK_IR			49
> > +#define CLK_TSEN		50
> > +#define CLK_IPC_AP2AUD		51
> > +#define CLK_CAN0		52
> > +#define CLK_CAN0_BUS		53
> > +#define CLK_UART0_BUS		54
> > +#define CLK_UART2_BUS		55
> > +#define CLK_UART3_BUS		56
> > +#define CLK_UART4_BUS		57
> > +#define CLK_UART5_BUS		58
> > +#define CLK_UART6_BUS		59
> > +#define CLK_UART7_BUS		60
> > +#define CLK_UART8_BUS		61
> > +#define CLK_UART9_BUS		62
> > +#define CLK_GPIO_BUS		63
> > +#define CLK_PWM0_BUS		64
> > +#define CLK_PWM1_BUS		65
> > +#define CLK_PWM2_BUS		66
> > +#define CLK_PWM3_BUS		67
> > +#define CLK_PWM4_BUS		68
> > +#define CLK_PWM5_BUS		69
> > +#define CLK_PWM6_BUS		70
> > +#define CLK_PWM7_BUS		71
> > +#define CLK_PWM8_BUS		72
> > +#define CLK_PWM9_BUS		73
> > +#define CLK_PWM10_BUS		74
> > +#define CLK_PWM11_BUS		75
> > +#define CLK_PWM12_BUS		76
> > +#define CLK_PWM13_BUS		77
> > +#define CLK_PWM14_BUS		78
> > +#define CLK_PWM15_BUS		79
> > +#define CLK_PWM16_BUS		80
> > +#define CLK_PWM17_BUS		81
> > +#define CLK_PWM18_BUS		82
> > +#define CLK_PWM19_BUS		83
> > +#define CLK_SSP3_BUS		84
> > +#define CLK_RTC_BUS		85
> > +#define CLK_TWSI0_BUS		86
> > +#define CLK_TWSI1_BUS		87
> > +#define CLK_TWSI2_BUS		88
> > +#define CLK_TWSI4_BUS		89
> > +#define CLK_TWSI5_BUS		90
> > +#define CLK_TWSI6_BUS		91
> > +#define CLK_TWSI7_BUS		92
> > +#define CLK_TWSI8_BUS		93
> > +#define CLK_TIMERS1_BUS		94
> > +#define CLK_TIMERS2_BUS		95
> > +#define CLK_AIB_BUS		96
> > +#define CLK_ONEWIRE_BUS		97
> > +#define CLK_SSPA0_BUS		98
> > +#define CLK_SSPA1_BUS		99
> > +#define CLK_TSEN_BUS		100
> > +#define CLK_IPC_AP2AUD_BUS	101
> >  
> >  /* APMU clocks */
> >  #define CLK_CCI550		0
> > 
> > -- 
> > 2.50.1
> > 
> 
> -- 
> Yixun Lan (dlan)
> 

