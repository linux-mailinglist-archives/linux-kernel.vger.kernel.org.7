Return-Path: <linux-kernel+bounces-897407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753D1C52E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B77242421B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769722BEFFE;
	Wed, 12 Nov 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5Pc9sz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17523F42D;
	Wed, 12 Nov 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958220; cv=none; b=kXZRmlRlh+VoGOtEtPgHJ9InGYVr/GyhMHCMDuq624Hnv7oydXHtBaKxb+GkiqyDGejanwZ7Qn3VS2Q9cVFbqgAr4rGZumdvR5fuGHNbWG5N/BixT9HT7RzRdhBiPLMw8JHtSa7yKSW6+eb+WUTV0VwA9hBsWK6Be1aWQAhQVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958220; c=relaxed/simple;
	bh=kW69Kf9o5S8zAmla0BViTMcfmqbpqmg9hgv823cP6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA4aaWDRNhjk6RiHbXd7gzBawsbgkOYvcHNhf9yk7XjYatzmkFBRmAjz1wIZm8CxG+PkRgZUsKRzdE2lb6TlcHIbZe3py47NXT0HNuhi3Oejvue608bWnKZZZbz/hWmNpmfGneMBrBr1g0W+m/P79u//ueAwGX8ux09IWhM2TOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5Pc9sz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0CBC4CEF7;
	Wed, 12 Nov 2025 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762958220;
	bh=kW69Kf9o5S8zAmla0BViTMcfmqbpqmg9hgv823cP6d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5Pc9sz3+/yovtxkLBKtBDwrYtuE5AOaF2kG5baEnDmGz+l1LUY3Folwf7QfBUXlL
	 2KTV8NPWmhhuGqOkSWcCKgV9Tlgfue44+27qLy+XgKwFGvk1FXBbeMpVWQ7vhbEmlX
	 UX8XgQfo3HqBViE6wQ4eBOsE2pH96zzUDG6eKGXvcm8KlZ67Ja//yPYLFR5nT/xE6m
	 Qx162FvNapub7pi0XPPg5URXNtkDBCDMxUZFyi/8r7Y0pwZOUqLjVXZgDhSuCsJnLI
	 C8sTZimywC032zzr+3DI7V1c46eiGPr55Wk3wqY8SvR24bMZkmZFC1WwvTon89HcIi
	 nKrHUvtzBEbFw==
Date: Wed, 12 Nov 2025 14:36:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>, E Shattow <e@freeshell.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
Message-ID: <20251112-abroad-taps-a207a5850301@spud>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yw7K4rG5QeI0qQ6x"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com>


--yw7K4rG5QeI0qQ6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 05:54:09AM -0800, Emil Renner Berthing wrote:
> Quoting Hal Feng (2025-11-07 10:55:22)
> > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
> > SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
> >
> > Board features:
> > - JH7110S SoC
> > - 4/8 GiB LPDDR4 DRAM
> > - AXP15060 PMIC
> > - 40 pin GPIO header
> > - 1x USB 3.0 host port
> > - 3x USB 2.0 host port
> > - 1x M.2 M-Key (size: 2242)
> > - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> > - 1x QSPI Flash
> > - 1x I2C EEPROM
> > - 1x 1Gbps Ethernet port
> > - SDIO-based Wi-Fi & UART-based Bluetooth
> > - 1x HDMI port
> > - 1x 2-lane DSI
> > - 1x 2-lane CSI
> >
> > VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lit=
e/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
> > VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionF=
ive2Lite/VisionFive2LiteQSG/index.html
> > More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite=
=2Ehtml
>=20
>=20
> Hi Hal,
>=20
> Currently the JH7110 device trees are layed out like this, with a nice
> separation between the SoC description and board descriptions:
>=20
> jh7110.dtsi               # JH7110 SoC description
> |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
>    |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
>    |  |- <VF2 boards>     # Final VF2 board descriptions
>    |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
>    |  |- <Mars CM boards> # Final Mars CM board descriptions
>    |- <other boards>      # Other JH7110 board descriptions
>=20
> With this series it moves to
>=20
> jh711x.dtsi

Now that you notice it, why does this have an x to begin with, when both
users have jh7110 in them? Wouldn't to just be jh7110.dtsi for both?

> |- jh711x-common.dtsi
>    |- jh7110-common.dtsi
>    |  |- <jh7110 boards>
>    |- jh7110s-common.dtsi
>       |- <jh7110s boards>

--yw7K4rG5QeI0qQ6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRSbhQAKCRB4tDGHoIJi
0uCyAQD6iyco1k52HApf+TuleXVFcj9M+okHsL5PCeHgiR1lrgD+Kf0oe/4gPuR8
huqT5G5w/WaU0u5fU/kL21v/JrdjuwA=
=DBaw
-----END PGP SIGNATURE-----

--yw7K4rG5QeI0qQ6x--

