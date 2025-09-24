Return-Path: <linux-kernel+bounces-829884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F02B981E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B964C1D01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E1224234;
	Wed, 24 Sep 2025 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="KeQxo4ia"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F224728F4;
	Wed, 24 Sep 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758683666; cv=none; b=NdExUFSxRQbzDrxwkarYrd8RQx18dpY+HPwwF4NPdYsC0FZYfKVd4tgqF1r8/HqEEI8HuVo1epTzU/EHTBvad/IfT2RQrKzfyO32hxGidwvVJYYxC6a3/8bj9V6Txf1P1AwF/3YpFtW+PKagu1hQ5WLYXlf2MqYuynfUv67Xffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758683666; c=relaxed/simple;
	bh=J7cjqqmGmaZOUF2MR4huwKNqe4ctVzq9atEsqXRsgSw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6iSbwqmwrgsksvjDzhWCYqR3QFTGyYTQsB6/iIR5RhmB9hm9enXbiLGggga4WgyF8zr6d0ievBOS72sA+KWHTxxvRUSmOV8/5Qth+Gus8bAeHwSaeOLQ+WXogDw3bx5IlJhMXrR6V+fwlqTBmYN6qFqZPT2wodSbjgS+tcG/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=KeQxo4ia; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758683650;
	bh=8plg955rJ+oOWjx5qksQHnCtK++GUsWnoWgH1rOaedc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=KeQxo4iaNBSQFrXfM9Z1QYTFvV4NyCDo3LQPNRtrw7CPNfm1AeN08/v7Atx/vOzIq
	 Bsui+psjkWs1xtPO/VcwbQaT24Cc7VO+8eeG+Jz+ADn/V3l0wLL9KGhJUJv0DD9cO8
	 yyANutXko2uVRiQjazMO9JEVe09gNVq5DuADAhsQ=
X-QQ-mid: zesmtpip3t1758683646tf49888df
X-QQ-Originating-IP: 1MO73cqQ/QgVrFm41SIJypanScGWd08wL3EKzL6AuWc=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 11:14:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13436328211902165598
EX-QQ-RecipientCnt: 13
Date: Wed, 24 Sep 2025 11:13:58 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 1/3] riscv: dts: spacemit: enable the i2c2 adapter on
 BPI-F3
Message-ID: <B8749086963B3B54+aNNh9hw4TX6tVMdP@troy-wujie14pro-arch>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-2-aurelien@aurel32.net>
 <DC360EB139FD9DE5+aNH4l-7SP5KNu-Br@LT-Guozexi>
 <aNLyIvS-UFfplmpu@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNLyIvS-UFfplmpu@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NVjywrp/tdK0a7ZnYB++mZYqj9bmJBO1lVscCYOs0fpLBdbVGivrWHw0
	UR6AA7vqzrCWZ0mY/MT3EDgEcZgCukkVZlNdfwtErdyIXSxRcJnW1BRFzEJRn+5Hb/CMx/b
	z9Lb7ij52XS2gTCG9U0Icy5S5n2n2WJJGmTAUyfn5QFkDaUUXe3JioSNWVVz1Ne7ZB3n4Dd
	pUDmpbq25XjTRwuNgUFCUtqj+39v1ygRIE1QAOghW9NQ9xHJfJ9xDdtJHIAm4l2RDAuoDkE
	00g9LnGGe0S64aoehsIdXdfqf7Krd+z67bScXiAfzvcW0/ICZyWpEnjvt7H7Mfvyv7kUeG8
	bVzWY3owyJYDflbwe92XZD9ptMO8KtIZJSITvjiTYHiZXcMwjrXtFgVmMLQ0Nu+61DopXrY
	GJiLOMYXTovIAI3KrJ0HZFRQhtrYKuOx9Jsj3L3/1RQT7rAzefCpVDg7yfX8jmjiPE7z9vW
	B4PEgF8WjjXp7U964ffLfrHlYvjaeiErq0RPjy2KDfqc4i6hbIdo2heiPnTeB/OYm8VKFhc
	E7a6up3nB7kUtGzgR2Reiw6KVveC23/+yypEY2gcUMcIuYkxB/mEg9T2J4qMPr43zDw/F5A
	H3dyzu8bK5U673McIAo+o8neauwHS2O4gt+s5Gn4cwsphPI+AZm2EXrwV8AcfSBAj1TfC2d
	fdNDsMqrzBNxW+GBniEuhm1UPHN6OHVRdThlS0a/g+gcaGpi9BVIryxyZIWPENGkmPSN1mc
	Ia7U5Md9DGOplAvc1aA4cWuOKM+w8eAA82yyDlyXwU5Ih4vDJwBN3O9DoylzkuQ8QCifUD1
	+SMftzmMdP2pc271UCauvaKNgURnC2j41OIlDrMiVaA32+OdxUe5JiKDC0bgbRcxgvbXbgE
	Pf0mpbe1nPxQ0ghq1gbPlkiO5/wQqf7XlJIGOUoQS7Ag4INap8Ou67jT7T/nh8K7ZxoII5u
	r1JZsbls/MM8FBzHlAiwGbJaufdt1EQeFIFRgMFR5UrNGfXNupzuEy6hYFh3AjFmOMcdojD
	S45yjKH1Sgg754tVnsvtOOcdQKrYA60thlr9hBm3YBcluaOdY93KDoxZ5+RBDZLxDW3cteK
	fjNxgd2SMwdjA49tzUa7z9P704FmMx+ow==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Tue, Sep 23, 2025 at 09:16:50PM +0200, Aurelien Jarno wrote:
> Hi Troy,
> 
> Thanks for the review.
> 
> On 2025-09-23 09:32, Troy Mitchell wrote:
> > On Sun, Sep 21, 2025 at 11:01:41PM +0200, Aurelien Jarno wrote:
> > > Define properties for the I2C adapter, and enable it on the BPI-F3. It
> > > will be used by the 24c02 eeprom.
> > > 
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > > @@ -92,6 +92,13 @@ gmac1-pins {
> > >  		};
> > >  	};
> > >  
> > > +	i2c2_0_cfg: i2c2-0-cfg {
> > Should this be i2c2_4_cfg here?
> > From what I see, in the initial version the second cell was meant
> > to be the function number rather than the serial index.
> 
> Ok, I wasn't aware of that convention, I just reused the same numbering 
> of the downstream 6.6 kernel. I'll fix that and use i2c2_4_cfg.
I'm wrong..
The second number isn't function number.
You can find a more detailed discussion here:
(riscv: dts: spacemit: define a SPI controller node)

                - Troy
> 
> > It looks like the pwm part is also incorrect.
> 
> Yes, and also the submitted PCIE patches.
> 
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 

