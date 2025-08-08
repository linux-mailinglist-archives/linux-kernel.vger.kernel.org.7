Return-Path: <linux-kernel+bounces-759614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D9B1E024
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F7C561FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC372604;
	Fri,  8 Aug 2025 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="xUo8yl40"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C071939FCE;
	Fri,  8 Aug 2025 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616091; cv=none; b=lU6tcZMVkQuaXEt1eUbrjGSI/+nEk1FlyY4DSd2ApWa0i/F/m4ZgefS380iMjNdn6mg3MjcZmZWzGQfFzymOTwEC37cIfPkbgcTtOsTyPI2++zFr2srnVPVE55VLgiZylcFeOkRYWOxYkv8mYd8hlQGg8crh9Dga7VnOwkuO6rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616091; c=relaxed/simple;
	bh=+DX8W+FwNNw/MDG6n2LqOQwHvg6cOglOY7bkGn1f49I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNn9SUx2J1LwZuYcC8TXsQ3Jexo8t2vxtmpvrt+7Ovju6MO0nQpNgJ8Sa7Vqs1DJ64QsNgTLLe8kmJHZ+aeJFXxvfBVwzHWkhkJja8qR/p6pH+QRyOWDjC08j8pMdtd7vBIgWtFLjo0DjsqZJ+2aYZswv1qk2Hwx0E5GIFJ+DV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=xUo8yl40; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1754616067;
	bh=YONhLCtVxAOKYtMTLs/xNzYwEhqj7k/VVs38rD2tJdw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=xUo8yl40om/6vyjsJ/vdKWhKnFTTL68dj7Oazlh8QICVZD1NOzFifQ6iTFuWNy8nb
	 E117VGekHAigoQJRaT1dOkEljJBJ/lVoEMxBbhDuchHBOEC8kQx6G0ZAoDnghzcBa/
	 FGfegd+0k50JIxaRzAtn2JmuXkUgqJrWAXjGwffM=
X-QQ-mid: zesmtpsz6t1754616061tbef0d426
X-QQ-Originating-IP: zQHRZWbedkVaYFV1bT3lY2wArHNnLUL6AKgzsJCZB+0=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 08 Aug 2025 09:20:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11874263861845849413
EX-QQ-RecipientCnt: 17
Date: Fri, 8 Aug 2025 09:20:59 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Conor Dooley <conor@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Alex Elder <elder@riscstar.com>, Haylen Chu <heylenay@4d2.org>,
	Inochi Amaoto <inochiama@outlook.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jinmei Wei <weijinmei@linux.spacemit.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: spacemit: introduce i2s pre-clock
Message-ID: <D09A72E63AAF75B3+aJVQ-75A7NL4CJtb@LT-Guozexi>
References: <20250807-k1-clk-i2s-generation-v1-0-7dc25eb4e4d3@linux.spacemit.com>
 <20250807-k1-clk-i2s-generation-v1-1-7dc25eb4e4d3@linux.spacemit.com>
 <20250807-untrained-anthology-bcf760fe73cb@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-untrained-anthology-bcf760fe73cb@spud>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NhdiEwnVOUqExbdtneD2Nu7R21a/RIjfbpDCHKhuWw+YFgDMDdesIbFO
	FYhNDcg+NENbRxTOrEdxgHHbIloslw7CpMBVbMhB2nwu4/albAHvopLankj7E/SKTL2KR8Y
	7vWpf4b5klEq+2qBGF0dbZcwatcwru1XQ2GGOxUxNqGhC+S5wvfQd8yFK6vj+X8fy6sgeEB
	p8DNMB0YM+12s9cBHANgFTvIefFSO+3UGDK4wsqAo+jYRYmzByy2SPeRTK+d0sj28bNEYk6
	V8JRB3HZr13+hKYzy9K18aTYEPagOW4tY+rT5F45wAyaVe36T9kzIwPpHEMfKyfgVZRK6Pb
	uA6ZFzjiIWhdCNJyNeJ8vUrPRQbfjY56Sug8CDfv0BYgmI1d1vKQL2EwDAPYdsefFB2jC/a
	tmEy22MEEkh+dXNL9aA1G8f+icwe2LbkxJKikzQnDwJyY6iBf/Ansr2gSxJWVgMXY3f4reQ
	3l7XwQEo0AHpSjpm+pZszBltS9Eqip8qIRKfEnCKW6WoR5MGTEunhf3wlWqJtGepV7LTZMd
	oZRXwxjrQDrkH87JxR5edVr2iokLfxAh4fFcn3OrxZ8Qj/aIMdJdUFEhWTP3QAs/oGWHVHM
	USdHbL2NsDtVPkdbK/u4RNRmwuDwG4frdQ/r58KSPQr9ETbqUPvcf1Oule65O7Hvx+de2ED
	xcPIxQY+JcemPcF9l7W7VLB+XAoxzEx469nXjRBtoCKa8+KnZN60VwsVGdabxI1Otwiw9T8
	zX0zdkGP+Z7YXnC/USdz6KnObRg/fZqA7xaYwkNCKXEjO8d+beF+I/A480du1B3V2r09MYK
	fermrziemzJfHLXt0m4g6+sN3yhEy7qUoD/HcZ/iW0UCIc4XACU5MK14TIKjs/e5z0WwN+s
	lVxOPxyNDQn7s3d5gB0PRo76r+0cOsRqyVVrS7jwHPUf6mq2rEYBdAu9T9zqoVRRKfVICQS
	HAtm/4mJ0KPns9MutoA++ZUQcuBCLmQP1RzMfBYi8VwGCHizSg0c+qrF8NHJ7lIb0/E9yh1
	bL6Z1YU1+qndZwBe4epRnBKmkdin4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Thu, Aug 07, 2025 at 05:19:51PM +0100, Conor Dooley wrote:
> On Thu, Aug 07, 2025 at 09:30:10AM +0800, Troy Mitchell wrote:
> > Previously, the K1 clock driver did not include the parent clocks of
> > the I2S sysclk.
> > 
> > This patch adds their definitions to allow proper registration
> > in the driver and usage in the device tree.
> > 
> > Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
> 
> I'm not sure that a fixes tag is suitable here, seems to be some new
> feature/development. The driver change seems to talk about how modelling
> as a fixed-clock is incorrect, but this change mentions none of that.
> Without whatever context that provides, it's hard to see how this can be
> justified as a fix rather than a new feature being added.

Introduce pre-clock to fix I2S clock; otherwise, the I2S clock may not work as expected.

I'll explain it in next version.
> 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  include/dt-bindings/clock/spacemit,k1-syscon.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/dt-bindings/clock/spacemit,k1-syscon.h b/include/dt-bindings/clock/spacemit,k1-syscon.h
> > index 2714c3fe66cd5b49e12c8b20689f5b01da36b774..524268246fedd3f1238320f35244baf32354fbd2 100644
> > --- a/include/dt-bindings/clock/spacemit,k1-syscon.h
> > +++ b/include/dt-bindings/clock/spacemit,k1-syscon.h
> > @@ -77,6 +77,9 @@
> >  #define CLK_I2S_BCLK		30
> >  #define CLK_APB			31
> >  #define CLK_WDT_BUS		32
> > +#define CLK_I2S_153P6		33
> > +#define CLK_I2S_153P6_BASE	34
> > +#define CLK_I2S_SYSCLK_SRC	35
> >  
> >  /* MPMU resets */
> >  #define RESET_WDT		0
> > 
> > -- 
> > 2.50.1
> > 
> > 



