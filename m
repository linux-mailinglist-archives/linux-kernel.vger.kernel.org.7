Return-Path: <linux-kernel+bounces-829563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9769AB9758D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB57442FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101561D798E;
	Tue, 23 Sep 2025 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="QHEOfqnS"
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAA194A6C;
	Tue, 23 Sep 2025 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655839; cv=none; b=dTnf2TZZEszHuvtkQTEug1Zc+gTGmb0u8zQsYqgZHlRSexhiarKvhZelEl8qEjMUJbJd5VtwFMUR7Gj0awnLfg3hcTPG9Uni8VDzlim/OGGwHQJoCNxpSE8TX1L3wgzkhqqHWOxfh4WPYApMbFz8OF6U5AlyxUHoKmbdHMyRT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655839; c=relaxed/simple;
	bh=tfZ+ZOZ8j9vKPx5WIBGgdSopL2mUnuMwusRKerM+Z1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxgESMOgmx2hnHV3Sh45SmEyhi1svZ3RIP+NNVda002A7L+fxMCSh9xF9FDEU7IXxlWjtgDtVp6ZeL6EEndKAYrOZlACjp+A2wrRl2VwULoI7MRBtxVnNCj/kBB3r95+Ev+nNqX1gfou7YYGMWKOzuFSLala5UEU8eGaHfxFMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=QHEOfqnS; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=sgmjEyjMA0qGIjylSrBYpm5Nywd0hmlcKcjCfl2hwTQ=; b=QHEOfqnSlEwD3ePlCOEjn3yC2y
	5Svz442J0yi94kyTZQYgWld+xcrqqrO4FwA48ETMWguVNynk7P1bIPFkG59mmefqglXNl3xARFwCA
	jaYPfEfnwlAQjzJNZwFD98+b8dQgKVi3x5+SEK1bu5I9QjLYM0YBW3yVU2QhS1vuD0qaYLuVLccNw
	YGd/TeJ413MNkLKJ90RDauoVMM+mUposnA9vnZ3dJKUJQWaHFFS5oVlt0TbntN1zvMGi6njfhhZ+G
	jhhe/yxo1xe2UsZ27lRdu/UsbC0KdyqExdoASjtB0AMV604nTpYkbbxFdByTO1L2sRHQJsU2URbQt
	Ud6+aSQw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <aurelien@aurel32.net>)
	id 1v18ia-00CAf4-2d;
	Tue, 23 Sep 2025 21:30:28 +0200
Date: Tue, 23 Sep 2025 21:30:28 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH 2/3] riscv: dts: spacemit: add 24c02 eeprom on BPI-F3
Message-ID: <aNL1VDm77voAHJlX@aurel32.net>
Mail-Followup-To: Vivian Wang <wangruikang@iscas.ac.cn>,
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
References: <20250921210237.943370-1-aurelien@aurel32.net>
 <20250921210237.943370-3-aurelien@aurel32.net>
 <54a959f7-a2e6-4622-97fa-18408afa0998@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <54a959f7-a2e6-4622-97fa-18408afa0998@iscas.ac.cn>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Vivian,

On 2025-09-23 14:32, Vivian Wang wrote:
> Hi Aurelien,
>=20
> On 9/22/25 05:01, Aurelien Jarno wrote:
> > The BPI-F3 contains a 24c02 eeprom, that contains among other things the
> > MAC addresses of the two network interfaces. For this reason, mark it as
> > read-only.
> >
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/ris=
cv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index 3b6e4f52e9aad..574d10fdf9b82 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -115,6 +115,15 @@ &i2c2 {
> >  	pinctrl-0 =3D <&i2c2_0_cfg>;
> >  	pinctrl-names =3D "default";
> >  	status =3D "okay";
> > +
> > +	eeprom@50 {
> > +		compatible =3D "atmel,24c02";
> > +		reg =3D <0x50>;
> > +		vcc-supply =3D <&vcc1v8_sys>;
> > +		pagesize =3D <16>;
> > +		read-only;
> > +		size =3D <256>;
> > +	};
> >  };
> > =20
>=20
> I wonder if it would possibly make sense to specify a nvmem-layout here.
> The BPI-F3 I have here has this in the 24c02:
>=20
> 00000000=C2=A0 54 6c 76 49 6e 66 6f 00=C2=A0 01 00 20 24 06 fe fe fe=C2=
=A0 |TlvInfo... $....|
> 00000010=C2=A0 XX XX XX 2a 02 00 02 23=C2=A0 0c XX XX XX XX XX XX XX=C2=
=A0 |...*...#.XXXXXXX|
> 00000020=C2=A0 XX XX XX XX XX fe 04 XX=C2=A0 XX XX XX ff ff ff ff ff=C2=
=A0 |XXXXX..XXXX.....|
> 00000030=C2=A0 ff ff ff ff ff ff ff ff=C2=A0 ff ff ff ff ff ff ff ff=C2=
=A0 |................|
> *
> 00000100
>=20
> (... with variable parts replaced with X)
>=20
> And, AFAICT, this is a "onie,tlv-layout" with fields:
>=20
> 0x24 mac-adddress
> 0x2a num-macs
> 0x23 serial-number
> 0xfe crc32
>=20
> As you can see the mac-address assignment looks bogus with fe:fe:fe (it
> is used by vendor code though, so at least it seems to be intended). It
> does appear at least to have useful information.

The reason I initially tried to dump the content of the eeprom was to=20
check the MAC addresses provided to the kernel by u-boot at they looked
strange to me starting with fe:fe:fe... But at least they match.

> Can you confirm on your hardware? What do you think about this: should
> we add it now or add it when we have users?

I also have the TlvInfo data on my board, but it misses the=20
serial-number field.

This is a good idea to use the "onie,tlv-layout" layout, I'll do that in=20
the V2.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

