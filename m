Return-Path: <linux-kernel+bounces-759926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BDAB1E48B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA4518A32AA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5F263C9F;
	Fri,  8 Aug 2025 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="N2LjNYcL";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="r1PoWh6/"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B631A264F8A;
	Fri,  8 Aug 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642377; cv=none; b=mjoVD51tpIY+MYw2GZJMepGhPe9QmXE609aJmvi1egeOXJehiU/JJQVxt4LP46qGe49g2zz8VXBAWVr0AESHeeq1HgGCLjQ4K7x1uLsk35b6YE23eGhPs7FiQxxyxHuvSe/Fg2G1v9AnqPy9Eve9MQ2vD1vSGhPwIXrWbvZ9m+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642377; c=relaxed/simple;
	bh=C5oQDH2C4AYPc13lRN5KYUvuF+nlKWXe35dAwNKKKQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxl+Pq26/D1dwPGreWuEUsw4EracSTDbg2r0eqYBD3EFu/nTf2XhA8Zz94ZxJknc2s1MTWf1+wPb/CK42UxVK+/9lDiy/OXMf+1k8Kzyqdupa6ac6ULWaLIXaCDu3GkXSYj56TbSo7BH5w08YJ4qazEQgtKE0nZb/RF+5shQrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=N2LjNYcL; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=r1PoWh6/; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from localhost (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id C63E912FB458;
	Fri, 08 Aug 2025 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1754642373; bh=C5oQDH2C4AYPc13lRN5KYUvuF+nlKWXe35dAwNKKKQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2LjNYcL9eqKmruQHc21P2hU8hg2IOYCBvjctagJ2Az1XMnr6X1nETA8xEf6cn68q
	 MgPY5cR99L0oGpWxt4Pv4fXeSjjtE1YVzExFRvkVIIdZ61lBxWpOtrnMl0/rCyasdT
	 c+Ai+3jh+PASw0+utr1RVGMpTt8trDLutpwblovCkG0yHDTKBekvbs69ibIJ2IcEz2
	 BLaxkxk2vkzB+efa1tj1e5zWTjfUgqRgjdgNKBOOOQQ87q/vetYpegQKuTuzt5fuZP
	 CB4UbqLXJq6pzNRckiHoilscaf51nNRl/SXVCgmqLED2JGLVE+b47ND7SAO/pHarW8
	 3hf3Ae2OwHRzQ==
X-Virus-Scanned: amavis at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by localhost (bayard.4d2.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eWhw2vAtAcjx; Fri,  8 Aug 2025 01:39:29 -0700 (PDT)
Received: from ketchup (unknown [117.171.65.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 3CC5E12FB405;
	Fri, 08 Aug 2025 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1754642369; bh=C5oQDH2C4AYPc13lRN5KYUvuF+nlKWXe35dAwNKKKQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1PoWh6/voAcLo+G3AldL51Mrxwo3fgOzUJ231BYpZMALndqcZt3QlOBSfemJA19H
	 kwwY2YvN0/GRdNkrZ8jDY+l7vGohCA9EXKtKPKxiqmAUR14LPEekyJcdGlFjSHIxA0
	 SJMag4t3qxCnJ4iSOBLPoDTHMIHASCtek+9JGfIm6ceErU1zou5T/WXm0/SEN3HkdV
	 pOzk04iJZC62qCiRkrj1owif8d/dmrNPYYL526bNgqGAIgE3M+g7yn+z68mclJi09s
	 A6oiDTG5kllPNHkVts88BQMzzCA9LRBnzRda8JMAtBkWi3SKYAf08H/ZnXJpAfJHFq
	 m50KPmH+j6keA==
Date: Fri, 8 Aug 2025 08:39:22 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <aJW3uvqI--Bwrld3@ketchup>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
 <20250807-k1-clk-i2s-generation-v1-2-7dc25eb4e4d3@linux.spacemit.com>
 <aJQXKN_ccpWVJ5oZ@ketchup>
 <C7EA7A1D0F9884EB+aJVcqFqix0GF_RnX@LT-Guozexi>
 <aJV2EIC_0E1FQX7L@ketchup>
 <78351F50C5DA0C45+aJWaWKEyO_f2a6Kp@LT-Guozexi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78351F50C5DA0C45+aJWaWKEyO_f2a6Kp@LT-Guozexi>

On Fri, Aug 08, 2025 at 02:34:00PM +0800, Troy Mitchell wrote:
> On Fri, Aug 08, 2025 at 03:59:12AM +0000, Haylen Chu wrote:
> > On Fri, Aug 08, 2025 at 10:10:48AM +0800, Troy Mitchell wrote:
> > > Hi, Haylen!
> > > 
> > > On Thu, Aug 07, 2025 at 03:02:00AM +0000, Haylen Chu wrote:
> > > > On Thu, Aug 07, 2025 at 09:30:11AM +0800, Troy Mitchell wrote:
> > > > > Defining i2s_bclk and i2s_sysclk as fixed-rate clocks is insufficient
> > > > > for real I2S use cases.
> > > > 
> > > > This is a little misleading: they're modeled as gates with fixed-factor
> > > > for now whose rate is calculated from their parents instead of defined
> > > > statically. You could avoid possible confusion by replacing "fixed-rate"
> > > > with "fixed-factor".
> > > >
> > > I'll change it in next version.
> > > 
> > > > 
> > > > > Moreover, the current I2S clock configuration does not work as expected
> > > > > due to missing parent clocks.
> > > > > 
> > > > > This patch adds the missing parent clocks, defines i2s_sysclk as
> > > > > a DDN clock, and i2s_bclk as a DIV clock.
> > > > > 
> > > > > The i2s_sysclk behaves as an M/N fractional divider in hardware,
> > > > > with an additional gate control.
> > > > > 
> > > > > To properly model this, CCU_DDN_GATE_DEFINE is introduced.
> > > > 
> > > > Could it be represented as a DDN clock taking a gate as parent? Just
> > > > like what is described in the published clock diagram. Generally I'd
> > > > like to avoid introducing more clock types, there're already a lot.
> > > Uh, our new chip(K3) may uses this macro that I introduced..
> > > so I don't wanna take a gate as parent everywhere..
> > > how about we leave it? ;)
> > 
> > I wasn't proposing a workaround. What will go wrong if a gate is taken
> > as parent of DDN everywhere? 
> I think this a bit troublesome...

I don't agree. It just costs one extra line and one extra macro.

> > Not to mention this DDN variant actually
> > duplicates the code in ccu_mix.c.
> >
> So I’ve ultimately decided not to introduce DDN_GATE.
> I’ll change the macro for i2s_sysclk_src from
> CCU_MUX_DEFINE to CCU_MUX_GATE_DEFINE.
> 
> What do you think? From the clock tree perspective, this should be fine.

Thanks for the change, it's fine for me, too.

> > 
> > > > 
> > > > > The original DDN operations applied an implicit divide-by-2, which should
> > > > > not be a default behavior.
> > > > > 
> > > > > This patch removes that assumption, letting each clock define its
> > > > > actual behavior explicitly.
> > > > > 
> > > > > The i2s_bclk is a non-linear, discrete divider clock.
> > > > > The previous macro only supported linear dividers,
> > > > > so CCU_DIV_TABLE_GATE_DEFINE is introduced to support
> > > > > the hardware accurately.
> > > > 
> > > > The divider IS linear, from the perspective of functionality, it just
> > > > implies a 1/2 factor. Could it be represented as an usual divider and a
> > > > 1/2 fixed factor?
> > > ditto.
> > > 
> > > I know you don't wanna introduce new macro..
> > 
> > It's not about new macros. It's about new clock types. And the solution
> > I proposed for the divider with a factor isn't meant to be a workaround.
> > 
> > For the divider's case, I think combining a fixed-factor and a normal
> > divider looks more clean than introducing a new LUT. It solves the
> > problem for K1, right?
> yes, It solves.
> 
> > 
> > > But K3 requires this, so whether it is introduced now or future,
> > > the final result is the same.
> > 
> > Could you please confirm whether K3's dividers requiring this patch are
> > really non-linear or just imply a fixed-factor?
> I will confirm this point.
> 
> If I send v2 without removing the CCU_DIV_TABLE_GATE_DEFINE macro,
> that would mean K3 really needs it.

Thanks, this will help.

> > 
> > > Please leave it..
> > > > 
> > > > > The I2S-related clock registers can be found here [1].
> > > > 
> > > > So this patch actually does four separate things,
> > > > 
> > > > - Introduce a gate-capable variant of DDN clocks
> > > > - Make the pre-divider of DDN clocks flexible
> > > > - Support looking up mappings between register values and divisors
> > > >   through a table when calculating rates of dividers
> > > > - Fix the definition of i2s_bclk and i2s_sysclk
> > > > 
> > > > IMHO it's better to split them into separate patches for clearness.
> > > Ok, I will split them into separate patches.
> > 
> > Thanks, that'll be easier to review.
> > 
> > > ...
> > > > 
> > > > ...
> > > > 
> > > > > diff --git a/include/soc/spacemit/k1-syscon.h b/include/soc/spacemit/k1-syscon.h
> > > > > index c59bd7a38e5b4219121341b9c0d9ffda13a9c3e2..253db8a602fe43a1109e2ba248af11109c7baa22 100644
> > > > > --- a/include/soc/spacemit/k1-syscon.h
> > > > > +++ b/include/soc/spacemit/k1-syscon.h
> > > > > @@ -29,10 +29,11 @@ to_spacemit_ccu_adev(struct auxiliary_device *adev)
> > > > >  #define APBS_PLL3_SWCR3			0x12c
> > > > >  
> > > > >  /* MPMU register offset */
> > > > > +#define MPMU_FCCR			0x0008
> > > > >  #define MPMU_POSR			0x0010
> > > > > -#define  POSR_PLL1_LOCK			BIT(27)
> > > > > -#define  POSR_PLL2_LOCK			BIT(28)
> > > > > -#define  POSR_PLL3_LOCK			BIT(29)
> > > > > +#define POSR_PLL1_LOCK			BIT(27)
> > > > > +#define POSR_PLL2_LOCK			BIT(28)
> > > > > +#define POSR_PLL3_LOCK			BIT(29)
> > > > 
> > > > This reformatting doesn't seem related to the patch.
> > > It's worth that create a new commit to reformatting it?
> > 
> > IIRC, the indentation is intended to show the relationship between
> > register bits and offsets, which seems easier to read for me. 
> Sry I ignore this..
> 
> But isn’t the POSR prefix already sufficient to indicate the relationship?

I think the original form is easier to read, isn't it? Even if you don't
think so, this change obviously exceeds scope of this patch and please
separate a series for discussion.

> Have a nice day!
> 
>                 - Troy

Best regards,
Haylen Chu

> > Do you
> > have a good reason to change it?
> > 
> > >                 - Troy
> > > > 
> > > > >  #define MPMU_SUCCR			0x0014
> > > > >  #define MPMU_ISCCR			0x0044
> > > > >  #define MPMU_WDTPCR			0x0200
> > > > > 
> > > > > -- 
> > > > > 2.50.1
> > > > > 
> > > > 
> > > > Best regards,
> > > > Haylen Chu
> > > > 
> > 
> > Best regards,
> > Haylen Chu
> > 

