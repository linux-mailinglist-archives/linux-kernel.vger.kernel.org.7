Return-Path: <linux-kernel+bounces-797705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE437B4143A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA6E5600A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6BF2D59F7;
	Wed,  3 Sep 2025 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="O6ZwNqm2"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAD221DB0;
	Wed,  3 Sep 2025 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876598; cv=none; b=SvSGHW2IrogHslBF2P+t9HezFEpS3LYrQloAxcrGitVquBa1wBSeA/Qrk/ZAtbyDZ5dm8/J8ckylCefCCdy23TCyalw2uvNeKwaHvcPhVMlpuBZFNI8lCPjEcxRZnYRFEu7y1vXQjIpSjQlICkwUKRBcGxz4imtEdIB7W2BhTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876598; c=relaxed/simple;
	bh=VxqW1+HVqZt8tNdYWLOekx1h+1GGvAsmtTB9R2oJ/V0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMOgMhBZY5aH3frjceRX/zKkPXmdlS/Kx6hQDLfn101eRSI4PHba7kjiCOS43gs23GQdajQ6ih9b+r1GR/y2x52OexhF06H0mh1ZSN6ishhXefnk7o6WGEzTnIeHJq+Q9uOI5NHZX11to0NgRbnjbIJ5nbO9Y3jrMDnaEew4aaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=O6ZwNqm2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756876594;
	bh=VxqW1+HVqZt8tNdYWLOekx1h+1GGvAsmtTB9R2oJ/V0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O6ZwNqm2xWP5UVmWTAh/vmC9/Iv0DHsjJ9LS1ak4NXOYFWnbcjDIZ6vNXkLlC9YEg
	 OLljPDxHBzYs1mptfy4DnBLEAnujJ8vbmmpnd3Gnd3GunjnkGx9XPJ/zp3JhlMCIKc
	 yblsFpJb/kETW9SUoNODv8q7sxvz7djFActkyYveGNIxVIySrtM6I0KNxkU1ksGdNY
	 B1VEHcsBShr+T3wPmm1J5oORFNBY6ehYLXRBfFl+trkrxjgMyAq2pcuB+xzHn1Qmeq
	 tOnKep1DBIeJsDbMgEQFeSMYD5iBK1rPyzbsYiTZiSAIXOOn61gF21VU6NBelnJGWk
	 UrOpZtsgrpQRA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BF2DB6E02C;
	Wed,  3 Sep 2025 13:16:33 +0800 (AWST)
Message-ID: <ab4c3c62e3b48dfac1bcce15e0aea402d66bc198.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] Revise Meta Santabarbara devicetree
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Fred Chen <fredchen.openbmc@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>
Date: Wed, 03 Sep 2025 14:46:33 +0930
In-Reply-To: <175529259974.3212367.16366822597087067588.robh@kernel.org>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
	 <175529259974.3212367.16366822597087067588.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Fred,

On Fri, 2025-08-15 at 16:19 -0500, Rob Herring (Arm) wrote:
>=20
> On Thu, 14 Aug 2025 21:16:56 +0800, Fred Chen wrote:
> > Summary:
> > Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> >=20
> > Change log
> > v1 -> v2:
> > =C2=A0 - add 'bmc_ready_noled' LED and update commit message
> > =C2=A0 - add sgpio line name for leak detection
> > v1:
> > =C2=A0 - add sensor nodes for extension board
> > =C2=A0 - add mctp node for NIC
> > =C2=A0 - adjust LED configuration
> >=20
> > Fred Chen (4):
> > =C2=A0 ARM: dts: aspeed: santabarbara: add sensor support for extension
> > =C2=A0=C2=A0=C2=A0 boards
> > =C2=A0 ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
> > =C2=A0 ARM: dts: aspeed: santabarbara: Adjust LED configuration
> > =C2=A0 ARM: dts: aspeed: santabarbara: add sgpio line name for leak det=
ection
> >=20
> > =C2=A0.../aspeed-bmc-facebook-santabarbara.dts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 857 +++++++++++++++++-
> > =C2=A01 file changed, 853 insertions(+), 4 deletions(-)
> >=20
> > --
> > 2.49.0
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> This patch series was applied (using b4) to base:
> =C2=A0Base: attempting to guess base-commit...
> =C2=A0Base: tags/v6.17-rc1-9-g8e4021078863 (exact match)
>=20
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>=20
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm/boot/dts/aspeed/' =
for 20250814131706.1567067-1-fredchen.openbmc@gmail.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: mctp@10 (m=
ctp-i2c-controller): 'label' does not match any of the regexes: '^pinctrl-[=
0-9]+$'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/net/mctp-i2c-controller.yaml#
>=20

Can you please address this warning and send v3? Check that it no-
longer appears after you fix the dts. You can test it with the command
suggested above. More thoughts here:

https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sourc=
es-with-the-devicetree-schema/

Thanks,

Andrew

