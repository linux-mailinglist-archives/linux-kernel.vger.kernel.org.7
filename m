Return-Path: <linux-kernel+bounces-741762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FAAB0E8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419A717113B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC71DDC0B;
	Wed, 23 Jul 2025 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="X8pxPJaG"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD073111BF;
	Wed, 23 Jul 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237921; cv=none; b=PvoLDh07n8vq+OpArkdsfDSKzk1kAuvan2hgvpNtRcWtHU17SG7N47zHAa1RfJoRx5o/SKLVAqH8WgiaZN08gPM7dGS0GsgF8tG+p1xot4Qm7x/WiKfJmgbc5EKnTcyFYVYPFuD3MW6IDKecPYYGPMy1hsbL+8HBvGhYigEz1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237921; c=relaxed/simple;
	bh=BXVaixxl5lZR8iSLt+bmTUALSyDNWih+fzYDKSkRgYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDNTQ9FmgrU5VWj8S/WSY3n1PrmTnF4Wo/8pTCAuN7QmK1TFjM6rWL8DCoeZDJGGL6e4SnPTe8jtCtyDWOPqkb9cNgwm25FODG53YapFnCZmHDOqh3yiM1No76Pvk6LNXJum8RyMlDPsyUogVMC7aPYUPMpCrU7LmGQByHxIxzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=X8pxPJaG; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1753237890;
	bh=Bnp2BUKVCzXylStMV6W/TL+x0ZAeLVKUXfGzHGOGBss=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=X8pxPJaGrVtCYl8/aQ8Fqj7jzXlD3nBTw0z8CfpTJ9ZAW0BErURZQEvxhL8xTHBku
	 gGhVGj6CEBIQHZx4+cQlZNsmWb1z1GFTEqotLYCpu46oQzX9qBVdKqNFR8TRfnKjcJ
	 a/F6nS2icR3KwGkz5cH+nHnjcgGiNPE0pkx2YdoQ=
X-QQ-mid: zesmtpgz8t1753237884t3e8b57a8
X-QQ-Originating-IP: 46uxbKdLiWrhnfUPVJqnTu6FVuy3GBQSZ/edRE17lwY=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 23 Jul 2025 10:31:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12801568592757599976
EX-QQ-RecipientCnt: 16
Date: Wed, 23 Jul 2025 10:31:22 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Yixun Lan <dlan@gentoo.org>,
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
Message-ID: <C0DC185A2866E4E2+aIBJeguvlpvCWDrI@LT-Guozexi>
References: <20250722-k1-clk-i2s-v2-0-2f8edfe3dab4@linux.spacemit.com>
 <20250722-k1-clk-i2s-v2-2-2f8edfe3dab4@linux.spacemit.com>
 <20250722092101-GYB724801@gentoo>
 <B79CAF56E128A7B3+aH9Zb9zNm6y_ovvW@LT-Guozexi>
 <aH9jUyzGb53B-aOu@pie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH9jUyzGb53B-aOu@pie>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MgIyGr9KWTnB3fw14xCeBEjuofzoBYYWBTv3dnxTt65QIMZ3MZo0wl3b
	zgEi7GOYla1idv/FvqGcx4TorzQw80rpircxFWtS2xxYE3f6y5i0F9IsshWJ4WxHZ526o6b
	S8PSvJ/3y17rRKYhwxfaV5AOZnMc45ePNKXUV4PC/hr/9cRt9QNR5Yi0MISzFNZ9jmkC/bt
	bbx22Mzyc4ucnzwhh8A2MZavbvKrD+K9YeUdSGEhfYY6/eYkdsbkNAh+cPJn2qe6vUvtipn
	hRw5Ok5kXtCYhdTdEmtgXYCE08nWHThVuKQUcMDayew2UtQIsfoDygphl7FMHZBuM+0kRTV
	JAQiaiJzSZZONlFMDzmPLcgTT0MKdXX/xqvIPouC+pMD7amZ5t9z0kP3xGC2n1tT/13UpSM
	hP+eqVjbwQULImAi2nLk3Whesxkb2SRvn2JfUcDs/tRCJ8Vh1kYvXObhkIe9SGzGUCQiI7w
	E0uRKRKBWaG64xO65zjxA9PMIynxFDzYQy/GwdeA0AzlMfBw1Z+cN6zBSgHIl8qb0+Wfscu
	0qBdwplRJqGQ098CI4N08ZnS88fLXDsMbwov3JndE2pL//uu48ZaLep74dRdggc76Va8hzx
	6pSUUFtJLA1QYz9CHNz0+hBdMOLjw0+39EAajJP7FN59p67KUyRUJ5DZnmVffJc1oQpMq4/
	tI9WN0pDJvyJzk+BzdTUjsiAoQaXeYbQhwFVqRAWMXFOmJGxZ6zh4wtwrn/5iz4y8QolGDK
	+en2b2oHTroP56xp7fafQM8srVQjpTKrVflVe2q9wDS9YOErKrst29/TZnpplFPoAK1bvrK
	qlh8yi+g6OSB5xkGzqsPgE8g5JGx5Z0N6bLZWu5woe0528aKamWw8fP43QD2hdr+yxCIEOC
	bW0zPR654FGsYHgaPSzZCI1hsPCEbRicRCt4O+BepIlLp4COI5ajnHLbHR186nuJWavSn9J
	AyJnZ3UNaSaeDtI3veHrePSPPsLg7Mke7alEQ84DCk+ykigR3ZsI+WSUzW4fKYf3aoJaAjn
	5qwmyNoGx7mWIEovxh
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, Jul 22, 2025 at 10:09:23AM +0000, Yao Zi wrote:
> On Tue, Jul 22, 2025 at 05:27:11PM +0800, Troy Mitchell wrote:
> > On Tue, Jul 22, 2025 at 05:21:01PM +0800, Yixun Lan wrote:
> > > Hi Troy,
> > > 
> > > On 15:36 Tue 22 Jul     , Troy Mitchell wrote:
> > > > This patch adds macro definitions: SSPAx_I2S_BCLK,
> > > this is obvious, so no need to repeat, please add something useful
> > > 
> > > > to introduce a dummy gate for i2s_bclk.
> > >                 ~~~~~~ 'virtual'? if it isn't a real gate clock,
> > > 	but I'm not sure it's a good approach to introduce such
> > > 	virtual clock if underlying hw doesn't comply with this
> > I'll leave this question to others.
> > 
> > > 
> > > > 
> > > > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > ---
> > > >  include/dt-bindings/clock/spacemit,k1-syscon.h | 114 +++++++++++++------------
> > > >  1 file changed, 58 insertions(+), 56 deletions(-)
> > > dt-binding patch should always go first
> > get it
> > 
> > > 
> > > > 
> > > > diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
> > > > index 35968ae98246609c889eb4a7d08b4ff7360de53b..6914ccf5be45a1071d5b6eac354cacb67888e00c 100644
> > > > --- a/include/dt-bindings/clock/spacemit,k1-syscon.h
> > > > +++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
> > > > @@ -123,62 +123,64 @@
> > > >  #define CLK_TIMERS2		41
> > > >  #define CLK_AIB			42
> > > >  #define CLK_ONEWIRE		43
> > > > -#define CLK_SSPA0		44
> > > > -#define CLK_SSPA1		45
> > > > -#define CLK_DRO			46
> > > > -#define CLK_IR			47
> > > > -#define CLK_TSEN		48
> > > > -#define CLK_IPC_AP2AUD		49
> > > > -#define CLK_CAN0		50
> > > > -#define CLK_CAN0_BUS		51
> > > > -#define CLK_UART0_BUS		52
> > > > -#define CLK_UART2_BUS		53
> > > > -#define CLK_UART3_BUS		54
> > > > -#define CLK_UART4_BUS		55
> > > > -#define CLK_UART5_BUS		56
> > > > -#define CLK_UART6_BUS		57
> > > > -#define CLK_UART7_BUS		58
> > > > -#define CLK_UART8_BUS		59
> > > > -#define CLK_UART9_BUS		60
> > > > -#define CLK_GPIO_BUS		61
> > > > -#define CLK_PWM0_BUS		62
> > > > -#define CLK_PWM1_BUS		63
> > > > -#define CLK_PWM2_BUS		64
> > > > -#define CLK_PWM3_BUS		65
> > > > -#define CLK_PWM4_BUS		66
> > > > -#define CLK_PWM5_BUS		67
> > > > -#define CLK_PWM6_BUS		68
> > > > -#define CLK_PWM7_BUS		69
> > > > -#define CLK_PWM8_BUS		70
> > > > -#define CLK_PWM9_BUS		71
> > > > -#define CLK_PWM10_BUS		72
> > > > -#define CLK_PWM11_BUS		73
> > > > -#define CLK_PWM12_BUS		74
> > > > -#define CLK_PWM13_BUS		75
> > > > -#define CLK_PWM14_BUS		76
> > > > -#define CLK_PWM15_BUS		77
> > > > -#define CLK_PWM16_BUS		78
> > > > -#define CLK_PWM17_BUS		79
> > > > -#define CLK_PWM18_BUS		80
> > > > -#define CLK_PWM19_BUS		81
> > > > -#define CLK_SSP3_BUS		82
> > > > -#define CLK_RTC_BUS		83
> > > > -#define CLK_TWSI0_BUS		84
> > > > -#define CLK_TWSI1_BUS		85
> > > > -#define CLK_TWSI2_BUS		86
> > > > -#define CLK_TWSI4_BUS		87
> > > > -#define CLK_TWSI5_BUS		88
> > > > -#define CLK_TWSI6_BUS		89
> > > > -#define CLK_TWSI7_BUS		90
> > > > -#define CLK_TWSI8_BUS		91
> > > > -#define CLK_TIMERS1_BUS		92
> > > > -#define CLK_TIMERS2_BUS		93
> > > > -#define CLK_AIB_BUS		94
> > > > -#define CLK_ONEWIRE_BUS		95
> > > > -#define CLK_SSPA0_BUS		96
> > > > -#define CLK_SSPA1_BUS		97
> > > > -#define CLK_TSEN_BUS		98
> > > > -#define CLK_IPC_AP2AUD_BUS	99
> > > > +#define CLK_SSPA0_I2S_BCLK	44
> > > > +#define CLK_SSPA1_I2S_BCLK	45
> > > just append the clock at the end, instead of doing massive renaming
> > The c file is written in the same order as the h file,
> > and I don't want to disrupt this order..
> > 
> > So should I keep this style or just append at the end?
> 
> This isn't only a style issue. This patch breaks devicetree ABI, old
> devicetree won't work with the change. Please don't modify existing
> definitions but only add new ones.
Tnx!
And if I append it at the end, should I also need to change the current c file?
> 
> >                 - Troy
> > > 
> > > > +#define CLK_SSPA0		46
> > > > +#define CLK_SSPA1		47
> > > > +#define CLK_DRO			48
> 
> Regards,
> Yao Zi
> 


