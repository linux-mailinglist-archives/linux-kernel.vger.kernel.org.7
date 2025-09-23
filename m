Return-Path: <linux-kernel+bounces-828079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6183CB93E56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B574445D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2226A0B3;
	Tue, 23 Sep 2025 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="gk1yB/bB"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46692AD25;
	Tue, 23 Sep 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591791; cv=none; b=nI5NrbckfU9kfVdxZwBqqVlRZCTybsJ9aRFNRAWIy2aK6oAvN8FCapEhNNJESTyeqKkfun53xuMBLwO38GOxvxOlsoHJKH0Rk6bHZcZ3I5bGSu2SYo4WRj6jebSB2DcIVwuWTp9SyrMvRxLwdSvKcIiZmL6oWGaCDYantmksZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591791; c=relaxed/simple;
	bh=YG2r7FX0EQ72xa46H0A6wQ+v8sKKfzXoRvvr1immiVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCHUVm1adI9QVHbenuA3o0RKWfluYmrfu0bv2i2rDhhntVU7n5JExPxDDdVDiYuar8jqSKLWFV7NXnFks4dzKKCg8pR4qs+ptsuFH8cNQJs9iFmRQAoGfuSzGp8qS8G5pEErjx/AkLfB+JB1WEtTEWsd6oErhI8Chd066VjChoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=gk1yB/bB; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1758591782;
	bh=N39OL6Pr7pWEkA5vpwKdJPI+E73Ce/KceXwnANzYhDU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=gk1yB/bB2wpBkihaOHi585/SyVvDE9xm7UC2lWdeXFzoH/SX2LFN9OqnVzEWlREAc
	 305CrnXdGCdq7jzOgtpz3/vUU/4VrGiWT6BIZ8l1jbzBmgnv667HA+nmKdqHdaitYW
	 FVwZPo3s+xy+mC1PgROKL4kOdFVjL/YuCq8B8S9Q=
X-QQ-mid: esmtpgz16t1758591778t13d40fcd
X-QQ-Originating-IP: Hc+LH0UrY3yVBAKjC/pyw1ys3jmxXTRFpK918+xs/uk=
Received: from = ( [14.123.255.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 23 Sep 2025 09:42:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9024809329057754653
EX-QQ-RecipientCnt: 13
Date: Tue, 23 Sep 2025 09:42:57 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Message-ID: <2A310AE601C62BAA+aNH7IfsDeD7-Vrxf@LT-Guozexi>
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-3-aurelien@aurel32.net>
 <20250922032158-GYA1291757@gentoo.org>
 <aNDVX9IrDbH2w7yJ@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNDVX9IrDbH2w7yJ@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NOIkHYnr7Vzd8790Gx1xi3851SIeElPASkIo5KtzGvFc6ygAyIxbbgiM
	0hfGXJUwj8Qmr/+nlGa9oZ1W1cO8QY6tMzEX6X4WcMowLDCq92ICcavDvGXagJihxPjGJmW
	8Kfale83RGCaXeacg01jD5/zIL4MEhEzr6V0h7M/vVZ65rN7DxibNiw4iAi4hM0Cs+KFyA1
	AbiPaWaeTrqLgt6Ca5LAFnr4o6kXXU2Ac5XN9Xe54Y2zqqhMOiBcRkbzhOMG5oVMCRb7iSv
	z1NbslIm3axYBmlIpDQ09ieakicJPhXbB9qjJcHsyBEId0U2z7I23HZV6ipz8BwySXG86u/
	eVjVbMOtBpXShUKqf2mED059gqw38qtaOPi6hTcFNd7dPmit5tsv5X7k14CFyGN0kJ+B8ux
	CqnmP33A+rEuy9l+7nAYwaO1FbELpZ6Dj+PpLZUKVsh4ZOlVks2Wt7mpTan5fo4F4PAP7za
	opL1k99VYYwoUGBil9QRx5MZwoDcVCgBZhAAqyAzvVW5OD0yzQkrhfHy1oM1COO1ogFv+01
	0fsgr6GjFsHLCktHyOZknN+ucXAlVDYT/X/jbaDd4sJ4p16HL+SV22VLbl69fkT446+sORP
	fFfpYZWi7XC8VF7vp8OxorP6dFvVTv4p8Xli+jWOHS/fzfvFwZH/zvS+irBtwquzRbl/m/4
	NHJKh3iwaVdWuBy+6/zVqVvg6IC/JP0B7xwuG8Q7UM59FWYV6gRWJ5OiQvyRXVrnh/555sT
	sx//6r5DdYpbzAKs+vpI16rEHaPkMizEF0T0HWYfySLwIDU/pE99wDTzfmLHrSm4ToBsOqo
	iT+NrhoUEYfLWccz3d6QJnwaiO1WaHnnETcsG/JGRXXKISCMmNtA8jpXZKFBhvUpEws8riH
	MdVO4U4C30Sq1pi4UO6rBB8DXo8nOtrW9hiokCTUGqCfrNiOlGGIqkBEtC+Cc/nZuZRJ6TK
	uWQtZiZabgL0rdGB5Yk5eL9skNm1fB3xki5TaKPJylm28PsYfolycZuqY+4r0wcdycO6rx9
	2Y7aoBeYQShf4E1e3ouJb7f3EIX+wtFd/PB2qCdpHj3PzeAND6QNwjQ7kSy/mLO9Y2pTcVJ
	9u43DOaN9qb
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Mon, Sep 22, 2025 at 06:49:35AM +0200, Aurelien Jarno wrote:
> Hi,
> 
> On 2025-09-22 11:21, Yixun Lan wrote:
> > Hi Aurelien,
> > 
> > On 23:01 Sun 21 Sep     , Aurelien Jarno wrote:
> > > The BPI-F3 contains a 24c02 eeprom, that contains among other things the
> > > MAC addresses of the two network interfaces. For this reason, mark it as
> > > read-only.
> > > 
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > > ---
> > >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > index 3b6e4f52e9aad..574d10fdf9b82 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > @@ -115,6 +115,15 @@ &i2c2 {
> > >  	pinctrl-0 = <&i2c2_0_cfg>;
> > >  	pinctrl-names = "default";
> > >  	status = "okay";
> > > +
> > > +	eeprom@50 {
> > > +		compatible = "atmel,24c02";
> > > +		reg = <0x50>;
> > > +		vcc-supply = <&vcc1v8_sys>;
> > > +		pagesize = <16>;
> > ..
> > > +		read-only;
> > so you're sure there is no demand to write data to eeprom?
> > (update info at linux env)
> 
> It seems to only contains board infos (mac addresses), but if there are 
> other use cases, that can indeed be dropped.
Then you can split the EEPROM into different parts.
Each part can be described as an individual nvmem cell in the device tree.
Some of them can be marked as read-only, while others remain writable.

Documentation/devicetree/bindings/eeprom/at24.yaml +15:
```
  - $ref: /schemas/nvmem/nvmem-deprecated-cells.yaml
```

                - Troy
> 
> > > +		size = <256>;
> > > +	};
> > >  };
> > >  
> > >  &i2c8 {
> > > @@ -143,7 +152,7 @@ buck2 {
> > >  				regulator-always-on;
> > >  			};
> > >  
> > > -			buck3 {
> > > +			vcc1v8_sys: buck3 {
> > I'm not sure if adding an alias here is a good idea, it occurs buck3
> > serve the suppy for many devices, besides, to me it's more proper to
> > name it as eeprom_vcc1v8 for the eeprom according to schematics in
> > this case..
> 
> We need to add a label to be able to reference it for the eeprom 
> vcc-supply, but we'll have to also reference it for other devices (e.g.  
> emmc, wifi, phys, etc... It tried to choose a common name, ie the right 
> most one on the schematics. Another option could be to call it buck3, 
> but other name suggestions are welcome.
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

