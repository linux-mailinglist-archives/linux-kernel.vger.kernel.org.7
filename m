Return-Path: <linux-kernel+bounces-890808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4BC4102F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB2544E2BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3732BF4B;
	Fri,  7 Nov 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5DqYg68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF22261581;
	Fri,  7 Nov 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536025; cv=none; b=Bm4sVLUeYX/0je2pNHUxRYFY9gSyocWI7Ph07QC7tnIBMG1y+nuic8Xwdb0a4nP+ZTHe6cHWQWIMyLiL/gJGx1iUnGqjQrvmG6LEnE+DrUryqEQeSDpSp8HIhSugdXclbizQTJs8bRbcYfOW/Y2OlwTO99/Tm0abBj1ecy4UkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536025; c=relaxed/simple;
	bh=oxDwYCkrdj5zrZ8eK9rx/ixf+coTfobB+mmKr0plunM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5uH0UsEOhGgiFLj8rePmhxLYkF5zvshjzLH4zeWp0hxeU8sQdQngz3MxwoIitmGn/0JH69+Akr3Nkptv2m1FGxDz6BkqNWX1VLTSMTF+CoP1yweTdVQ7EEDpqzDsVRRr1KE9SMvaqqKrp6CG0ANAv/rgd4Escju+8R4e4cVlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5DqYg68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F5DC4CEF7;
	Fri,  7 Nov 2025 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762536025;
	bh=oxDwYCkrdj5zrZ8eK9rx/ixf+coTfobB+mmKr0plunM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5DqYg68rq3zVGZMHb1G+n9EpqbvDQKJrpFVNHiVJLLFbZ5pY6AViB9hzMd9VqC5M
	 mGKjRFnWZnyQf3T+SFj/OvyzEJ8mg297kyCDFXE8zqDRflD3BtHcB9pBRu9hxSBaOr
	 pHXELra7/krwGXctjJ24pwXMVHH+dquYdiHz56qvXcVCJQhbVCxGqNnlFaBZ/EItv7
	 DWCCMZrrJnLsBlmLOUdloFLYrlZ5bzI+xKmCmxRnQeEsPMZPlfpEBGYLMliTYsQVI8
	 NNolAV9+5w7V/+MtAMJ8LA6bjUaFChAq1Lk/AtvtxGz+llwFdFOxuOBd0wZKT3M1T4
	 t1NH4Y2MCHWAA==
Date: Fri, 7 Nov 2025 17:20:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: E Shattow <e@freeshell.de>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
Message-ID: <20251107-frenzy-cloning-4b279cfe932c@spud>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <c05d8bcc-3024-45cd-8630-b0595682e778@freeshell.de>
 <6d0fb6aa-6d88-4069-a5e5-9e910523888e@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="98XJ8Lpr/rFGdbIm"
Content-Disposition: inline
In-Reply-To: <6d0fb6aa-6d88-4069-a5e5-9e910523888e@canonical.com>


--98XJ8Lpr/rFGdbIm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 12:21:46PM +0100, Heinrich Schuchardt wrote:
> On 11/7/25 12:11, E Shattow wrote:
> >=20
> >=20
> > On 11/7/25 01:55, Hal Feng wrote:
> > > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industr=
ial
> > > SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
> > >=20
> > > Board features:
> > > - JH7110S SoC
> > > - 4/8 GiB LPDDR4 DRAM
> > > - AXP15060 PMIC
> > > - 40 pin GPIO header
> > > - 1x USB 3.0 host port
> > > - 3x USB 2.0 host port
> > > - 1x M.2 M-Key (size: 2242)
> > > - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> > > - 1x QSPI Flash
> > > - 1x I2C EEPROM
> > > - 1x 1Gbps Ethernet port
> > > - SDIO-based Wi-Fi & UART-based Bluetooth
> > > - 1x HDMI port
> > > - 1x 2-lane DSI
> > > - 1x 2-lane CSI
> > >=20
> > > VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2L=
ite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
> > > VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/Visio=
nFive2Lite/VisionFive2LiteQSG/index.html
> > > More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_li=
te.html
> > >=20
> > > Changes since v1:
> > > - Drop patch 1 because it is applied.
> > > - Rename jh7110.dtsi to jh711x.dtsi.
> > > - Move the content of jh7110-common.dtsi to the new file
> > >    jh711x-common.dtsi and move opp table to jh7110-common.dtsi.
> > > patch 4:
> > > - Move the uncommon nodes to jh7110-common.dtsi instead of board dts.
> > > patch 5:
> > > - Add jh7110s-common.dtsi and include it in jh7110s-starfive-visionfi=
ve-2-lite.dtsi.
> > >=20
> > > Changes since RFC:
> > > - Add jh7110s compatible to the generic cpufreq driver.
> > > - Fix the dtbs_check error by adding the missing "enable-gpios" prope=
rty
> > >    in jh7110 pcie dt-bindings.
> > > - Rebase on the latest mainline.
> > > - Add VisionFive 2 Lite eMMC board device tree and add a common board=
 dtsi
> > >    for VisionFive 2 Lite variants.
> > > - Add usb switch pin configuration (GPIO62).
> > > - Improve the commit messages.
> > >=20
> > > History:
> > > v1: https://lore.kernel.org/all/20251016080054.12484-1-hal.feng@starf=
ivetech.com/
> > > RFC: https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@star=
fivetech.com/
> > >=20
> > > Hal Feng (8):
> > >    dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
> > >    dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite
> > >      board
> > >    riscv: dts: starfive: Rename jh7110.dtsi to jh711x.dtsi
> > >    riscv: dts: starfive: Split jh7110-common.dtsi and move opp table =
to
> > >      it
> > >    riscv: dts: starfive: jh711x-common: Move out some nodes to jh7110
> > >      common dtsi
> > >    riscv: dts: starfive: Add common board dtsi for JH7110s and Vision=
Five
> > >      2 Lite variants
> > >    riscv: dts: starfive: Add VisionFive 2 Lite board device tree
> > >    riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
> > >=20
> > >   .../bindings/pci/starfive,jh7110-pcie.yaml    |   4 +
> > >   .../devicetree/bindings/riscv/starfive.yaml   |   6 +
> > >   arch/riscv/boot/dts/starfive/Makefile         |   3 +
> > >   .../boot/dts/starfive/jh7110-common.dtsi      | 653 +--------------=
--
> > >   .../boot/dts/starfive/jh7110s-common.dtsi     |  27 +
> > >   ...h7110s-starfive-visionfive-2-lite-emmc.dts |  22 +
> > >   .../jh7110s-starfive-visionfive-2-lite.dts    |  20 +
> > >   .../jh7110s-starfive-visionfive-2-lite.dtsi   | 126 ++++
> > >   .../boot/dts/starfive/jh711x-common.dtsi      | 656 +++++++++++++++=
+++
> > >   .../dts/starfive/{jh7110.dtsi =3D> jh711x.dtsi} |  16 -
> > >   10 files changed, 879 insertions(+), 654 deletions(-)
> > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
> > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-vi=
sionfive-2-lite-emmc.dts
> > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-vi=
sionfive-2-lite.dts
> > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-vi=
sionfive-2-lite.dtsi
> > >   create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dtsi
> > >   rename arch/riscv/boot/dts/starfive/{jh7110.dtsi =3D> jh711x.dtsi} =
(99%)
> > >=20
> > >=20
> > > base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
> >=20
> > Small nit that "lite-emmc" is confusing together. In patches to U-Boot
> > dev mailing list the EEPROM product id is demonstrated to be with "SL"
> > suffix when compared to VisionFive 2 (JH7110) so I suggest avoid
> > confusion in upstream and use for VisionFive 2 Lite (JH7110S) these
> > compatible names:
> >=20
> > starfive,visionfive-2sl-lite
> > starfive,visionfive-2sl-emmc
> >=20
> > Also filenames:
> >=20
> > jh7110s-starfive-visionfive-2sl-lite.dts
> > jh7110s-starfive-visionfive-2sl.dtsi
> > jh7110s-starfive-visionfive-2sl-emmc.dts
> >=20
> > What do you think?
> >=20
>=20
> This is a serial number for the Lite board:
> VF7110SL-2310-D002E000-xxxxxxxx
>=20
> Here E000 encodes that we have no eMMC.
>=20
> The S is part of 7110S which we already have in 'jh7110s'. And the L is
> already decoded as 'lite' in this patch series. Duplicating this informat=
ion
> as 'sl' as you suggested provides no benefit.
>=20
> Let's just stick with Hal's suggestion.

The marketing materials etc call it the visionfive 2 lite, for example
on kickstarter: https://www.kickstarter.com/projects/starfive/visionfive-2-=
lite-unlock-risc-v-sbc-at-199
I'm happy enough with what Hal has here as a result.

--98XJ8Lpr/rFGdbIm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ4qUwAKCRB4tDGHoIJi
0syIAQD+Er+PMhGz0kEbUyrWG+rkw0VQZymPYFA4k1wpI8zTpQD/c/7P+rG/2fm/
YoL8btigKOHdPBIBOGqtNCtKrN3/QAI=
=NTsO
-----END PGP SIGNATURE-----

--98XJ8Lpr/rFGdbIm--

