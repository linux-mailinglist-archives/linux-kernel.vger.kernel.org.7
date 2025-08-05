Return-Path: <linux-kernel+bounces-756582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F55B1B640
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFEC16C895
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0E27510D;
	Tue,  5 Aug 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkNCQekX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BC274FDA;
	Tue,  5 Aug 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403678; cv=none; b=sZM+yKqm4hg+Q6kf1Rc3WZbiQQQl45oHUZ+Ir9Bb8Pq74m6w75PHcLjt3kGo/g9p2lia1jwHZMW8f59XU6Mecbq1yC8Z5MYpRjaAPZvhmQApKTMCZr+bMvn6sui1ieV+Ehr3lLf8q+vcfNwllX0QqR+9gwOJTABB2nV/muBSpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403678; c=relaxed/simple;
	bh=whNVERXr8/AN2Vvfa653Gd5vcbSu7aoK+Gs6t3i+W5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PegIfl/P6xIwPU2CzseQLBmlWRNG8Yz4BRJeyVPBUF/I1YjoqlO7TRMWKIqkGwke5nlC5JHGddax46Iq8hBxZfrBfpQgMpWgYt39B5hMxIUiM4PLbni9tJm/XrLjRJsOveATVUHzZxtXLSHz/Biu/8cu456kHeKA18h9DrRdww8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkNCQekX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B1C4CEF0;
	Tue,  5 Aug 2025 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754403677;
	bh=whNVERXr8/AN2Vvfa653Gd5vcbSu7aoK+Gs6t3i+W5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkNCQekXfQ5zz7SFOm1X7LU/T8JpA9F6gAsS3c6+9y+qglrwIbLwFIyBWP0D7ry9L
	 GNhbEPDSTXig2ETCkjlyEQjsdVC+Esbhv/Mb6sC4EIXYY6JR+pDMVBPqqMyLZbPmV7
	 zCXEyHeM3myKgWKd3MxjVBE8NTyWb7P0zROsiSR2Ao8hISoyvyhrvyXOgF3UaB+Klv
	 nppZ4E0Y9K/XyXaSW7LqmDdDoxSCWK+Fgvj0t1nTVbxwcdQp5c/QjtjWZvjgaTOo29
	 +Qi5Lyikzld4at0TH6QtlFDyU5soOqU4XCrww1smX/qa1O+f2NrdrUwYW5PN9JBJ3u
	 OORGr+Kr6H51w==
Date: Tue, 5 Aug 2025 15:21:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>, Aradhya Bhatia <a-bhatia1@ti.com>,
	"rafal@milecki.pl" <rafal@milecki.pl>,
	Anup Patel <anup@brainfault.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v4 0/7] Basic device tree support for
 ESWIN EIC7700 RISC-V SoC
Message-ID: <20250805-equinox-setup-cd37520d2586@spud>
References: <20250616112316.3833343-1-pinkesh.vaghela@einfochips.com>
 <SA3PR04MB8931098CC4A73E8FDD481DA78326A@SA3PR04MB8931.namprd04.prod.outlook.com>
 <2ed69301-f787-4257-8d44-a8544c1a43c9@kernel.org>
 <SA3PR04MB89312063FB96E85ABB6F3D3E8323A@SA3PR04MB8931.namprd04.prod.outlook.com>
 <72354ec9-7dc8-4192-9c25-d37abf33b5f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="90osRGvCEAKF0z/s"
Content-Disposition: inline
In-Reply-To: <72354ec9-7dc8-4192-9c25-d37abf33b5f0@kernel.org>


--90osRGvCEAKF0z/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2025 at 04:45:10PM +0200, Krzysztof Kozlowski wrote:
> On 04/08/2025 15:10, Pinkesh Vaghela wrote:
> > Hello Krzysztof,
> >=20
> > Sorry to bother you. I pinged because we addressed all the review comme=
nts of V3 in V4. But on V4 we have not received any comments since last 6 w=
eeks.
> > Could you please let us know what should be the further steps?
>=20
> Please don't top post.
>=20
> That is a bit different question than you asked before: "Gentle reminder
> to review DT patches.".
>=20
> Please read SoC subsystem maintainer profile document. For ARM platforms
> you would send now pull request or patches to soc.
>=20
> I would suggest following standard SoC way, same as for every other new
> SoC (but carefully observe the kernel process cycle). You can easily
> check archives to see how people also did it...

Yes, standard SoC way please. Arnd expressed recently a preference for
the initial series for a new SoC vendor to go as a patchset to
soc@lists.linux.dev rather than as a pull-request.

> For RISC-V - not sure
> some trees are handled by Conor, but rest go directly to soc tree.

I'm only doing the canaan/sifive/microchip/starfive ones that were there
when I started, all the "new" platforms have dedicated maintainers that
send direct to Arnd.

Cheers,
Conor.

--90osRGvCEAKF0z/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJITVQAKCRB4tDGHoIJi
0rfRAPsE27O+0eBI7GpGuWCrShsC8OmvPSMg1HZpeLJfBi4P4QD/dHgMhoqf1QeQ
1euvTqb8q7cSCtui9wi8PvuYBEqxoAQ=
=0EsT
-----END PGP SIGNATURE-----

--90osRGvCEAKF0z/s--

