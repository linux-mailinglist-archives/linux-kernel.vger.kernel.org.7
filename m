Return-Path: <linux-kernel+bounces-816099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D59B56F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1221817A7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22B2727ED;
	Mon, 15 Sep 2025 04:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="j9l6rePl"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEF1EB5D6;
	Mon, 15 Sep 2025 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757910869; cv=none; b=tZnNVQ/bci26A0FmKCjkyjtEqzeRKzW87YbS82ssRbpuX2acneSsWiVksyFMd4pIjZXJBOeThYEiRTsnPAEE9Lwf3yBnWEm21rgTq1vTZxkmGwL44A5om9NT/PsVjpHWG5P0MF2ZhV5KKk1bp5bSh/KpoOofe0wzHAM/spqdPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757910869; c=relaxed/simple;
	bh=R59jfh34yGxkC7W3AEGjJY6dRX+yKJOmXEt1HBSy8j0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGw5n9byLezATedv/dfqdVbdd9Keg47NyA9muocj8Terdf8FzEip9+cvGK2Zds1pARCdQfdDhMgNPCL2vz+lDbjsck37y/axX8QQscNbE/zTYI/AkaithR5nY5ghToo2qsRxjKARvRHsTCW55cFDLEGgvq/Cu4PeNFxrNdzN5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=j9l6rePl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757910865;
	bh=jGd9kLzjDaoi+l0HOQu5KE2dhKkmGdqUdNlJgfKDaQ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j9l6rePl1LUachlMBzH84pJ4kBHHVvbIl05HfsxlWo/BECrz1cj/oTJUcTE+mwMxJ
	 1zhFaWpOsMOT+ws5vGcBytUoqpX60OAE2NGwm7D45vwRgVNN0oHUYMe/MVhyC4KyTz
	 WDq4LX4lbyF+4K/MdLmV2a5A1ag5A27ZrLDtKbHgyBhHaS/1eNp1XLeS7bCD4Au4HZ
	 Z5K6pTKPx4A9glzNAfLgQutJM+RqCu1DPmf9H3q+8nKyicoSF2LckL67+bC/qWSkN3
	 ij1vnEAI/uYsdu3Q8/nv4/oQRdRwiZDEd1crElwzz5MlsqhSSMsGMvotAV+bRScjPa
	 78Ag7Bu3F/cUA==
Received: from [IPv6:2405:6e00:2430:fb15:b2b4:1872:3690:c682] (unknown [120.20.190.44])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0452B64CF0;
	Mon, 15 Sep 2025 12:34:21 +0800 (AWST)
Message-ID: <ae46aa8e57d01208deb56a8fd01f26a9a0bf359b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA VR144NVL board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Donald Shannon <donalds@nvidia.com>, robh@kernel.org,
 krzk+dt@kernel.org, 	conor+dt@kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, etanous@nvidia.com
Date: Mon, 15 Sep 2025 14:04:19 +0930
In-Reply-To: <f0b75151-d355-4d03-a356-dfbfb7a9e803@nvidia.com>
References: <20250822203818.4062595-1-donalds@nvidia.com>
	 <20250822203818.4062595-3-donalds@nvidia.com>
	 <f9cd6015c47d390eef9c689d2cb4fcd301c4d123.camel@codeconstruct.com.au>
	 <fcd64668-4232-4d7b-98ec-5326d40d19d7@nvidia.com>
	 <f0b75151-d355-4d03-a356-dfbfb7a9e803@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Donald,

On Wed, 2025-09-10 at 09:46 -0700, Donald Shannon wrote:
> On 9/9/25 16:05, Donald Shannon wrote:
> > On 9/3/25 00:07, Andrew Jeffery wrote:
> >=20
> > > Hi Donald,
> > >=20
> > > On Fri, 2025-08-22 at 13:38 -0700, Donald Shannon wrote:
> > > > This is an Aspeed AST2600 based BMC board for the NVIDIA VR144NVL
> > > > Platform.
> > > >=20

*snip*

> > > > +
> > > > +&mdio0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ethphy0: ethernet-phy@0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compatible =3D "ethernet-phy-ieee802.3-c22";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > +};
> > > > +
> > > > +&mac0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy-mode =3D "rgmii-id";=20
> > > Is this correct, in the context of the query here?
> > >=20
> > > https://lore.kernel.org/all/6a3d7eb4-c091-437f-98f8-2b8577e539a7@lunn=
.ch/
> > >=20
> > > If not, please drop the node from the patch until the MAC driver is
> > > fixed with respect to the RGMII delays.
> > >=20
> > > Andrew=20
> >=20
> > Hi Andrew,
> >=20
> > I will change this to alphabetical order.
> >=20
> > The extra space in our flash is for root of trust application. I will n=
ote this in the next patch.
> >=20
> > I see that the ftgmac100 drivers do not use the phy-mode parameter so I=
 will leave it out.
> >=20
> > Thanks,
> > Don
> >=20
>=20
> Hi Andrew,
>=20
> I am getting conflicting messages in my v3 patch series and want to confi=
rm what the consensus
> is for removing or keeping the unused phy-mode parameter.
>=20

The background is that there's been some concerns over phy-mode wrt to
where the RGMII delays are inserted, and the impact on the phy
configuration. My intent was that if you were unsure that you would
remove the entire mac node rather than just the phy-mode property. That
way there's no networking that can break when ASPEED sort out issues
with the ftgmac100 driver. You would have to carry a downstream patch
to add the node back for networking, but I feel that's an improvement
on carrying the entire devicetree downstream.

However:

>  There is some inconsistency in
> the existing dts-es as well.

Yes, this is part of the problem.

>=20
> Our board phy implements tx and rx delay, so -id would be the appropriate=
 one to use if we
> decide to use it.

Right, so long as there's no delay configured for the MAC in the SCU
(see SCU340-35C) and networking functions for your board then I think
it's fine to keep the node and specify `phy-mode =3D "rgmii-id";`. Any
fixes to the driver shouldn't break that arrangement (as in this
configuration it should deconfigure any delays for the MAC in the SCU).

There's some good documentation here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/net/ethernet-controller.yaml?h=3Dv6.16#n264

and relevant discussion here:

https://lore.kernel.org/all/f28736b5-f4e4-488e-8c9b-55afc7316c5e@lunn.ch/

Sorry for the confusion.

Andrew

