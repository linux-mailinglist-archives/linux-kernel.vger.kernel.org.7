Return-Path: <linux-kernel+bounces-759637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC3CB1E07A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5930E18C4387
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CCE158DAC;
	Fri,  8 Aug 2025 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="Y3TOwgs6"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540822F30;
	Fri,  8 Aug 2025 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754619091; cv=none; b=AQQWmNfjQRz5Ly7LoSyBggLA4GRkeRWZkVl5OdOeT16q+OCb5D+49B2cvQ0dKWdplDMtgVR8Y9oxeCiHRH4+b76MvQu93VqMhyps2SusXTouHHGVJx1DRWqAin4Y2mzy22toT9dFH8OwW1Q5B/Vmqkx++zYqgc3Zzd/JNMHd0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754619091; c=relaxed/simple;
	bh=i9lpry8Igk1iVBOghldNQbrNw1AdbekEz7pm+wEbS7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgS03iogTwpyIN0uDa07S+TT/ni0RBDnoFBX98qdUaWXGoKeNeb3UvNzyLCX9YEnVXLvOU6CwZ4eLiHirfh7S6WSdm9OpX6Zk23NYZXrb0LR5uCyNJFJdE8ZzN1PEwiGVBCZViLmG0xAeHSD6JYRXA4wRMERGvp8rUxdetH1psI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=Y3TOwgs6; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754619051;
	bh=XruLpPGKKhIAXV5GiyK/wgZqZKwAzbK6bCViQs/BVy0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Y3TOwgs6uWHNHO0+6zs1Wrew+uQ4HO/Yfsy/e1K0i1mUb6nDjywRLiOMZkeWJQGhw
	 e9TQNLwJPFi+C69H2V2WsAqfkKekaMwV+Cav/xUejmHllowSrcnlgH4+2cp7A9udgE
	 Hdy0d0NxoAF4m83Xmvv07iaiqWTB4jj8LpMWOvWQ=
X-QQ-mid: esmtpgz10t1754619050t37e96f67
X-QQ-Originating-IP: r9yuw17eteziLvplyQDL5/oFpwlod3gjP0a44mCWCbs=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 Aug 2025 10:10:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4317720997078926859
EX-QQ-RecipientCnt: 16
Date: Fri, 8 Aug 2025 10:10:48 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Haylen Chu <heylenay@4d2.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>,
	Inochi Amaoto <inochiama@outlook.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH 2/2] clk: spacemit: introduce i2s pre-clock and fix i2s
 clock
Message-ID: <C7EA7A1D0F9884EB+aJVcqFqix0GF_RnX@LT-Guozexi>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
 <20250807-k1-clk-i2s-generation-v1-2-7dc25eb4e4d3@linux.spacemit.com>
 <aJQXKN_ccpWVJ5oZ@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJQXKN_ccpWVJ5oZ@ketchup>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NJRsSVeNb6U+SMVN1Hv92O9l6TojnhLKgMmfHiRYYWrcp58NKGb3kaaD
	aaBXlk20sL/FJbg6+z2YdCw3Mb7kb6wfoXkqFQH/3KR65x0TmFuUlCJ+2eU6Md559N6oWOF
	yUHRhUEveD23OnWF7NVvGQNXXM7MI37If4nVnFKM18APkhHjmpXKzo1fIvw+V+KibDWYyVP
	fKF2jfEdUf8+lUdIGdb8oHjEnSTKlXZ+kc6LcfLNqASZHzFZzK8Ori1r+omdaLvNzBVutsE
	KLucuciOIdaIfbRcK/DQVLuSYfLk+5g8iuiK/JH2ptSlhEq9leNwF7H69btmijYXpSQUgcv
	zqtLV7/6+jHFum8ZM1Yb58F/Eysj+KAc7zS9zTSHdzlXWk0Nv7cQpt4ts3a7nDwCmVfoNgb
	MDnSS3eM9Pm8AbS+Tg4H1SVQO22B3Yu095R8P+tcqcwO4NKEnRdbD0BzfhsJ5CWKZHmL1aK
	RPY2f4IX+xRkjGLtNqIHXPZ2msaHBDShE2kjHoVkGCnvJmLnM9lAHyg+mxRf5fkoTZogCTg
	6iD3L+RJLnpRtdnEpJRnY40nJbRB2AH0jIuKFYswWBMpnvOqw4c93YI0dDTF+zk762luhqB
	mAIwaCY3h6UySGcLSK1CZV8WskrlI20DqVSUPEgeV3eLXSlDyvwAxyA1bwSe/ASov5Vo0QX
	THGVnW0zG+4fhR9x60sRIlhGyGnt/54mN0wXQXnoT8MetTL9JPTo+XtFU/PC6Mf7d4kZFkj
	gMGhtbt/goYCwHLyzruWzOXwpc4hzswihFA7niCMBu6rkvvtTON9v8QHhFQUpyDffG4HEG2
	/LWC27w8cdgp6RKZdmaO9i8Kr4YmHAeciTXheHMiA+IES8F/ohsqtojOOr670OPKKbq/AIh
	A1BLU0hVcWUo2iBVs11u4CZfb5f54DdmKKUv7YIH8WA4cHQlD4XKWdVnvs9JvplYTGxGhrc
	EgAvVeDT1RfRggM822k5BuAb9hbW2WMNFAuVFzZKuEOQpY3+F6/gmU+e2LmJnD9evlDFxOz
	T4g507pLBDuXAlIp+ijkJ6PUgpHiQsGUFC6r1QkQJPYqXMKtjh0/w+fV8fzB8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi, Haylen!

On Thu, Aug 07, 2025 at 03:02:00AM +0000, Haylen Chu wrote:
> On Thu, Aug 07, 2025 at 09:30:11AM +0800, Troy Mitchell wrote:
> > Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
> > for real I2S use cases.
> 
> This is a little misleading: they're modeled as gates with fixed-factor
> for now whose rate is calculated from their parents instead of defined
> statically. You could avoid possible confusion by replacing "fixed-rate"
> with "fixed-factor".
>
I'll change it in next version.

> 
> > Moreover, the current I2S clock configuration does not work as expected
> > due to missing parent clocks.
> > 
> > This patch adds the missing parent clocks, defines i2s_sysclk as
> > a DDN clock, and i2s_bclk as a DIV clock.
> > 
> > The i2s_sysclk behaves as an M/N fractional divider in hardware,
> > with an additional gate control.
> > 
> > To properly model this, CCU_DDN_GATE_DEFINE is introduced.
> 
> Could it be represented as a DDN clock taking a gate as parent? Just
> like what is described in the published clock diagram. Generally I'd
> like to avoid introducing more clock types, there're already a lot.
Uh, our new chip(K3) may uses this macro that I introduced..
so I don't wanna take a gate as parent everywhere..
how about we leave it? ;)

> 
> > The original DDN operations applied an implicit divide-by-2, which should
> > not be a default behavior.
> > 
> > This patch removes that assumption, letting each clock define its
> > actual behavior explicitly.
> > 
> > The i2s_bclk is a non-linear, discrete divider clock.
> > The previous macro only supported linear dividers,
> > so CCU_DIV_TABLE_GATE_DEFINE is introduced to support
> > the hardware accurately.
> 
> The divider IS linear, from the perspective of functionality, it just
> implies a 1/2 factor. Could it be represented as an usual divider and a
> 1/2 fixed factor?
ditto.

I know you don't wanna introduce new macro..
But K3 requires this, so whether it is introduced now or future,
the final result is the same.

Please leave it..
> 
> > The I2S-related clock registers can be found here [1].
> 
> So this patch actually does four separate things,
> 
> - Introduce a gate-capable variant of DDN clocks
> - Make the pre-divider of DDN clocks flexible
> - Support looking up mappings between register values and divisors
>   through a table when calculating rates of dividers
> - Fix the definition of i2s_bclk and i2s_sysclk
> 
> IMHO it's better to split them into separate patches for clearness.
Ok, I will split them into separate patches.

...
> 
> ...
> 
> > diff --git a/include/soc/spacemit/k1-syscon.h b/include/soc/spacemit/k1-syscon.h
> > index c59bd7a38e5b4219121341b9c0d9ffda13a9c3e2..253db8a602fe43a1109e2ba248af11109c7baa22 100644
> > --- a/include/soc/spacemit/k1-syscon.h
> > +++ b/include/soc/spacemit/k1-syscon.h
> > @@ -29,10 +29,11 @@ to_spacemit_ccu_adev(struct auxiliary_device *adev)
> >  #define APBS_PLL3_SWCR3			0x12c
> >  
> >  /* MPMU register offset */
> > +#define MPMU_FCCR			0x0008
> >  #define MPMU_POSR			0x0010
> > -#define  POSR_PLL1_LOCK			BIT(27)
> > -#define  POSR_PLL2_LOCK			BIT(28)
> > -#define  POSR_PLL3_LOCK			BIT(29)
> > +#define POSR_PLL1_LOCK			BIT(27)
> > +#define POSR_PLL2_LOCK			BIT(28)
> > +#define POSR_PLL3_LOCK			BIT(29)
> 
> This reformatting doesn't seem related to the patch.
It's worth that create a new commit to reformatting it?

                - Troy
> 
> >  #define MPMU_SUCCR			0x0014
> >  #define MPMU_ISCCR			0x0044
> >  #define MPMU_WDTPCR			0x0200
> > 
> > -- 
> > 2.50.1
> > 
> 
> Best regards,
> Haylen Chu
> 

