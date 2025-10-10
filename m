Return-Path: <linux-kernel+bounces-847802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71191BCBC3A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6FD3A918E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496572376FD;
	Fri, 10 Oct 2025 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ki7qT/YS"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C6846F;
	Fri, 10 Oct 2025 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077226; cv=none; b=aSCAuj3uIwMwDKSh2LSEV3dc7zIUBPIHa41HQyphn7mLqcjGMKG+mTHStCgknoy9Y06N6BPS4cdtWmgATlkt6XG7AaxeapD+HC0n3PkdZlxSMNovATfx/hFp/c4+z9bn+5fAXaWN3luDmwZ6Mt5RbFKnSwSFMUTOxE9RzVbOGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077226; c=relaxed/simple;
	bh=oykrhFWgZesqcj52BXiP2fYebBEd0nAZ+ziXf30Adlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C16lTYnGluiDqPHUx6MlW+MdFPGIzPYB+Y8/ktzIKKHm3c3atJYqzNL8zFwY39mD4xg5bEMtzI0hUqNZFs7/V4m27cziLbzzxA85lGkrdgUj77GzEM/O3vHn28EWD/KL4W4LjBndyMU/M/ne7fVHCpd2YxRztH4aen4dTCXFhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ki7qT/YS; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760077218;
	bh=fY5GWREGM1F0WN0Uk0IHs1MX+GE6gCX44IiriVQy/ls=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ki7qT/YSOf+kcPr6slKUwIlmpgN8B5RvQnwful2oyHWyJOM1AtODgI6THTdA4jRCL
	 yzQqPXc9HjPat0vCVb7ovM+YW2UZo+dz+JS1QVSVuHR03py/w0Ro1dlPip2bvhEoL2
	 lqegGYG0gsvgLXjBAz4tqEuA5ApJZWiVAomyX/dc=
X-QQ-mid: zesmtpgz4t1760077214t21b1d401
X-QQ-Originating-IP: 1O0RQKLiP8/EwcUIGSXn7afoUGmd0envjFBUs20JX6E=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 14:20:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2431771121863430806
EX-QQ-RecipientCnt: 15
Date: Fri, 10 Oct 2025 14:20:12 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] riscv: dts: spacemit: add Ethernet support for
 MusePi Pro
Message-ID: <59657BBB86F7B678+aOilnA5Z-QL7xF9O@kernel.org>
References: <20251010-k1-musepi-pro-dts-v2-0-6e1b491f6f3e@linux.spacemit.com>
 <20251010-k1-musepi-pro-dts-v2-5-6e1b491f6f3e@linux.spacemit.com>
 <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02aec9a-976a-4b63-86cb-126b8ae71185@iscas.ac.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NojR6Ao/DkEDCEtdNkOXTN7XCFAHlCIYHTFitkP8yMIYFmefsG+bBBHp
	8UY+02ZC5zRhPix8Ftm17DHkSmDxvXXAuyrMPgGpEVVXe9Fyj37Sdq0DOxz948JJEMjKyqt
	ZhShDnxn04kM4+k+aAQ4ymnRrwUJJOJUWoQykdMXBZMV4zP31wcGlRcls3PTayPl1IuYs6O
	APAeg2kP82S8VlEYfbo2ZXl5ynI3rjbrM+meN1ZbpTequGxYw2BJYHyCMbeE6ZPYn5dPg39
	JXS/bnAtrQfrFfD2QTciMYCr+gnZ/AkJDLXv8DHpmcxLhGKnxgrk29pIJwlybbktGJ1B/HL
	D1V4r/IUR5sCp3QP+5tbhfqjoWfSLtmXLVTrHY0+2KO/M+bt/pLKg7ibKR3J9tV9ZaPe6B9
	HEsuSVaOPu5jnnFAZPoXoMZPhg+xyDyiLszqtO/Fv6cXOwGmYYCUQFt4fE6aIaVZSuqaLLI
	ALipr1RLK2phWSVNwCZyenzzZEqqKCAJxcziVoRx6jpT2VKFV3Q1KZlTgJuzqqJAXS6XcG3
	rRadMbthduXbyKWGP1ZG6T+YSBuYkKHjhEkUjoF1RGJLNuPZ8upr7oLHQY9kJ2EI0WkWcyC
	fxkwzB0OQk+ec+F02YASCaTxlpzn17lil3Vw095utbttTRfHEFaUwJO+cz/wT7fWGSu0+0G
	hq6NNzxVtwanIYaBBbaugLwZQojAcBdPMcxM1ACdz0binCZ0qgCiR9M33q0kUZxTa2G4K2I
	uLYL3j+KZIUEZheR8x72lwzouftnDwnBA+zbrvEdv17mBYVvSJ4IgFgfeGNnZQ/LfamTyWl
	uIGVT9Z/d1SuCgoqvxpL/LBcqsj0BvvAVVSu05C2pS0swvch8wpbf7zP2QRU/f4IXr4Cxm6
	u5FpeCSWPt653XAd1oKDu5yviyAz6S9B7Dq3fgRY+qsQO3hRUv8kTspJDckxVIlO0M4JjNZ
	I7+vpI/HmmUkXkpTnj44oLyQ8m1kP0e+NyWf6ajGH5UYinoGRjtjbInCGQgL+tD6hq2dBAh
	E8MXgFIzOounUUtv5lJHzJk6q93QhFAjVIzWP7deWpWZYpxUqhjOhYDfnsWD/riytONGiHb
	7B4L418/gVJ
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Fri, Oct 10, 2025 at 02:13:31PM +0800, Vivian Wang wrote:
> 
> On 10/10/25 09:56, Troy Mitchell wrote:
> > MusePi Pro features a single RGMII Ethernet port with
> > PHY reset controlled by GPIO.
> >
> > Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > index 89a35914710bfd15c6ad27cd8d0de7ccf62e2309..e9a53dc7a417117c82f3e467677290bdaeffc845 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> > @@ -47,6 +47,29 @@ &pdma {
> >  	status = "okay";
> >  };
> >  
> > +&eth0 {
> 
> For node orders in board DTS for SpacemiT devices, usually we follow
> node name order because there's no unit address to go off of here, so
> for what we have here it should be emmc, eth0, pdma, uart.
> 
> See e.g. arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts and previous
> discussion [1].
Thanks for you point out!

> 
> Also, personally I think it would be fine to just add the whole
> k1-musepi-pro.dts in the same patch instead of splitting it up like
> this. I feel it would be easier to manage this way. For previous devices
> these nodes have been added piecemeal mostly because the drivers were
> being developed in parallel, but if you're going to base this on
> v6.18-rc1 there shouldn't be dependency problems.
> 
> Maybe Yixun can chime in about this as well.
We have talked here [1]

Personally, I think splitting them makes the commit history clearer.
I'm happy to merge them if others also think it's more appropriate.

Link: https://lore.kernel.org/linux-riscv/35C0EFBB84167959+aNj6K33fl7utuqcf@kernel.org/ [1]

                          - Troy
> 
> Thanks,
> Vivian "dramforever" Wang
> 
> [1]: https://lore.kernel.org/linux-riscv/CAH1PCMa35n4dnJ94-EHGrJyU3kztQYO8_v2CkD=rid466zv3+A@mail.gmail.com
> 
> 

