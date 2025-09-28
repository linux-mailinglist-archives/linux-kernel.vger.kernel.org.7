Return-Path: <linux-kernel+bounces-835292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FBBA6A66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD2717CFC0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8729B77E;
	Sun, 28 Sep 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="wqvb3orp"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4C225D6;
	Sun, 28 Sep 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045966; cv=none; b=GgiaQbDGCT0S9S8GEVhPgZhlmasIwZuiFPgvL4y2DcO9zmqUUAi7GUm2dv+TfdeUVnBElw5F6pNqz4Uwz2YBlqc4hXxGDhxw8JTX9vTlQ6W+aBD/+vhkUmOWeG50zEaCB9QEjfg2fl6xupV2gpF8Xk9bTkEoDDD6pOZ1Ec1n/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045966; c=relaxed/simple;
	bh=b4KJSaVTwE4nEw8iUaY6p8BI0ISvO2zx9TUy1cOvD40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZiifgXNv1gBOZwhV/uGyiWfzuPlkLAGaxDKTlvQLjBLcs38+/S6aECvXjZXh76saiske7S9H3JAjIJ90q3p8clIX5tYCyATILYI9tn+E0rm29BqVRrb3sdYP/iPaHSoVRpgBCvfoKs0xUDsKANXPCZgMI+bQuG+JbXxYekhT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=wqvb3orp; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759045954;
	bh=LVmDmo6PMPQDtwg9AJ93IIu2tcqLRDiuOqFTJD+GAWo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=wqvb3orp9jeEXZmIg0q/2ZYak9d068QsVv+LC8k23HPHDYAV5FA/Z+ygqJT0evFiU
	 Uk+QGN9fvA0q8Fh/H3x450bhPonh8ggkmmqvt9Dk7qB1OrK8v0ieU1DdXmRDPfeyo5
	 nPMowstBOCNM7rqFHIRMN2tNkieN9if7z6Pc6mcw=
X-QQ-mid: zesmtpsz6t1759045953t24b1fd8e
X-QQ-Originating-IP: cCgCvlPvaxTaHT2HEXnf2C6AVB4pr5nTsaxpw0F2OhE=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 15:52:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2715566553721179058
EX-QQ-RecipientCnt: 15
Date: Sun, 28 Sep 2025 15:52:31 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>, Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <B015018225608C50+aNjpP35hN9KOyQph@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <20250928074914-GYA1344940@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928074914-GYA1344940@gentoo.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NpoapEztA32CjjGzIxr94u3/bNltrJGUM5FCj6BJwb1r1Y7h7WpXAX5K
	kJ7kJc3tGLgdtuHxNvX6BRCO2ERfJ72XlEAd0EhIcW+1SUfLE8lTILe9L1fIwysgjZB0bcw
	mLzn5HQYJxoBwPAMexmw3iBRgZZa3TmdXJ1uC1bLAN0/XcKJJTzgj8Y1myZAm3mfZ1dse4p
	6Zu/g3fQnjza/EJgBkvwn3QKROKnOY0btw0dW0Xh1CTLLbY01hb34h1cNw2xh5yc1nN1jnF
	p3HjFwuCcp3IfYXa/AwSkkdA3Tf/xUh1dOo68c72YMDCuz6RTMLj54+iL766zkoGCIuhOnY
	phlaDV7Zb/msSqjldhh4/fJ7OxlvFKmjDLEP2+suhhqn/YlEs41jHZrk1mI7KBT4WGSCWgL
	k1e5Jn21vGFdDwVmz8jNZHO44xS6wF6f7MyVt2BG7fH6tmbbrN4Pxd0irLScgSFH7Eu2j0P
	2yHnsHK2SC4M1TnzjmkBjOsR5SET9Oszy6i4ePSmFa28HGaoiY95eArPFRhENRQl0oau/Z9
	f+dd/gnO7QdJ1quxECLCK0ko0JFR+pkvuATUYrB9kE4Z8SGNlAGxTqHJIsRXXl5Di6ZNixu
	R0DvvKa16WumSkJWQ+Baeksq/wkDMU5YyTihof1UTl11ljxRQr2+DVHoumZXLgolA2pLSHy
	EIOELYZ122eakyIApy6DzsL0RUuFo+xeLo1oIVouZEqV+Mwcs0fO9NWID4KyR5cuoRJ8Jp8
	Ag+8IkTKJeJ+PdG7N6le7soxQ320aSSxmry5LtQCEAtWx/kj/YaQ2AuvKR4qpBTBmvTB71k
	AoTxqzMJJYtQGQ4AIyl1ektiPH+OAXq3KwqyLUybonljuWfocsvcHSgx3kqQR3IJDMVOYIb
	h7Z8Tfed8x0i4OGW3oF3r3Lr6k0cD1MRqo690VilHsk3UEzyPqksjuQjp6P9iy/mlytNprt
	GhhLsVGIWKZFT9+5qR0OFME77+6Y75sjTPGeZGXl1F2d/fOECnXMibLOIfpxvr5hdC2yBKk
	yiLMNSsWkXwJXzYRoKK1NlqglNvjzosgwh+LkzKWUfqTOynRcZ9coDjeK/xC8nufG8WsNoC
	/cMJc49eQKOLAFL1RdPw3eFUQyaPnTIl8sSw9yRetx18/nb8FVJtta1SQ8uKX3E2XKI9XF6
	1Oan
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Sun, Sep 28, 2025 at 03:49:14PM +0800, Yixun Lan wrote:
> Hi Troy,
> 
> On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > 
> > Document the compatible string for the MusePi Pro [1].
> > It is a 1.8-inch single board computer based on the
> > SpacemiT K1/M1 RISC-V SoC [2].
> you could wrap at slightly more characters, I remember 72 chars
> (haven't spent time to find a formal document link..)
Get it. Thansk.
> 
> > 
> > Link:
> > https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
> I'd suggest to list core features of this board, while using this link as a complement,
> base on previous experience, vendor may change the link address, thus the link vanish
I see. Thanks for pointing it out.

> 
> > [1]
> > https://www.spacemit.com/en/key-stone-k1 [2]
> > 
> pleae keep them in one line, no break, and no blank line between SoB,
> something as below
> Link: https://.. [1]
I will. Thanks.

                - Troy
> 
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > index c56b62a6299ac24d3cdef7edcdfc407dc62a1846..52fe39296031f21d1c28c4f1ea5ca9fe28caf45a 100644
> > --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> > @@ -22,6 +22,7 @@ properties:
> >            - enum:
> >                - bananapi,bpi-f3
> >                - milkv,jupiter
> > +              - spacemit,musepi-pro
> >                - xunlong,orangepi-rv2
> >            - const: spacemit,k1
> >  
> > 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> Yixun Lan (dlan)
> 

