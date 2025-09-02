Return-Path: <linux-kernel+bounces-797019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EEB40ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC603B03D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202733A000;
	Tue,  2 Sep 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLeTeQSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D72E92BB;
	Tue,  2 Sep 2025 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756831130; cv=none; b=LVfzudwBY3Xhz4vP0UPAHFZ490qjIke8FoQzCQpAtro2wwwhqp13VfvxU7LAGwgROp3kkLUlrtN0y4gayB8PibAZyWxijtUAxLDFSDO3UtGEVqW9017pe+EJaNmVxW4lhXLQ6l6K8EsCyYbze+FjMUDmloaD57Nk/Lu0KM2mDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756831130; c=relaxed/simple;
	bh=SOwG/JggJkNLJ7PLQmoB7+r3ga5C1jVReif7jB291cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnP6oGvL2OoR9Rj3FkOGmZ7FwbsKDX/bfsG6eQYFZkngmO55Yy6SUzw3toSYFeoLhLP4FQAMB6CYzAn1RiuYB0u0O5DXJ/lSPlfUapn5NCekRoKj3ViOFw9DBfOZtFp3Z8sMOHgSvRuE5eFCSirocr+QOHfqEwNxmbpMk6OdflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLeTeQSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8D2C4CEED;
	Tue,  2 Sep 2025 16:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756831129;
	bh=SOwG/JggJkNLJ7PLQmoB7+r3ga5C1jVReif7jB291cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLeTeQSbDbxWwofKraRIxLA8TMJY5DKSbNCb8FZ0IBY5QNkB7ozq2DS9yJTzz2rQc
	 KVPqViua/jWAMzHNFiggZ4v0O61XyT1DTX4u04muwo3mJOqvKg/4CALoypYOv9pK/H
	 CcwCo2mcfgna2YoDzpOyF1VBnZRWXWczviWsgRgLu0CK4SXt5m0AiVUp0oSYssKQgi
	 3mLTRtRHYy6z4n76zByagohFvyZwLZaoViuNCvZNNUW7qRFfeizqDjacRYF336wja1
	 gxODHHYjQ/7Xrvcsw8keMoWTzyvo51anIGHeoZgCMmLve//mRX01I+WIQle9WbdKPX
	 yOM4HPNkGNtng==
Date: Tue, 2 Sep 2025 17:38:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Valentina.FernandezAlanis@microchip.com, Conor.Dooley@microchip.com,
	Daire.McNamara@microchip.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, robh@kernel.org, krzk+dt@kernel.org,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Message-ID: <20250902-crucial-hankering-193be936a139@spud>
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
 <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
 <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
 <bb5b0d71-41b1-48a0-82fc-bdb362cc3db1@microchip.com>
 <0d90eeb4-e6ac-459c-a6b1-26368f102e0e@kernel.org>
 <20250902-affair-scrambler-2771df16372e@spud>
 <677aad27-66b9-4c4f-8fbe-6b9aabcd375a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfy5KQiTquK7clHG"
Content-Disposition: inline
In-Reply-To: <677aad27-66b9-4c4f-8fbe-6b9aabcd375a@kernel.org>


--cfy5KQiTquK7clHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2025 at 03:47:56PM +0200, Krzysztof Kozlowski wrote:
> On 02/09/2025 10:31, Conor Dooley wrote:
> > On Tue, Sep 02, 2025 at 08:22:02AM +0200, Krzysztof Kozlowski wrote:
> >=20
> >>>>> +     refclk_ccc: cccrefclk {
> >>>>
> >>>> Please use name for all fixed clocks which matches current format
> >>>> recommendation: 'clock-<freq>' (see also the pattern in the binding =
for
> >>>> any other options).
> >>>>
> >>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> >>> The fabric dtsi describes elements configured by the FPGA bitstream.=
=20
> >>> This node is named as such because the Clock Conditioner Circuit CCC'=
s=20
> >>> reference clock source is set by the FPGA bitstream, while its freque=
ncy=20
> >>> is determined by an on-board oscillator.
> >>>
> >>> Hope this clarifies the rationale behind the node name.
> >> No, because there is no style naming clocks like this. Neither proper
> >> suffix, nor prefix. Use standard naming.
> >=20
> > So you want all fixed frequency clocks to be named "clk-foo" when
> > "clk-<freq>" is not suitable? Fine if you do, but I didn't realise that
> > it was required and haven't been keeping an eye out for it.
>=20
> Recommended is to just use consistent suffixes or prefixes. Binding asks
> for "clock-" so that's what I propose to use here.

Okay, I'll keep that in mind.=20

--cfy5KQiTquK7clHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLcdlAAKCRB4tDGHoIJi
0naiAQCA8RkE9d4x3vSDRj7Kp9DvNgViBknLJEn4NtKmLmp/LgD/QsstMwVI9pFE
OMOYdXSwcCVahsURInTVKGD8lpIeqgk=
=xt6D
-----END PGP SIGNATURE-----

--cfy5KQiTquK7clHG--

