Return-Path: <linux-kernel+bounces-756777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3AB1B90E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A610E169699
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB6293C44;
	Tue,  5 Aug 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzsjP5ci"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7CD28136B;
	Tue,  5 Aug 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414033; cv=none; b=SoFgf1pW1b/WDR+M1o0vKvVF0M7prV7WN8B94/s8xg41e/BdMmJvjscO55H5HVBfottnh1RfPSOnMsbaCn3uK/0Pk1VaMcDyZzHSQHCNcLYAZ9bTs//BPCt1di6bXxb0kd5myhcc3KFGC7E6oYA94LxdTwf/77KQh8Zjj/DUIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414033; c=relaxed/simple;
	bh=kFLtP7kLi6TZXaFEe1UXPz9zTqnkNWTqbzGcM1j1sPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksCahA2xgyHdjYUpta+9LbxEw1HXr7p6xrhSfxeLKUT3ugGZXrXrvqsz9VRi020FTQ/nbT0lFyZHjeK+53CeJy3HKe8Up4m9mG6VqOTr75J2Lm4KtbTgOBOsR6VPtDeev/Wms3DUehV+FL9JQyFwfWhsFiSBrpbz8222CFB2AFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzsjP5ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE6C4CEF0;
	Tue,  5 Aug 2025 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754414033;
	bh=kFLtP7kLi6TZXaFEe1UXPz9zTqnkNWTqbzGcM1j1sPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzsjP5ciz19VA8OYXPXGI3ps14D5SxS7bD9pxYQPAycE7Y4pHpSw4SS0UcE7MZLJK
	 T0nkWr8PsG/9TjOF1GRpxVkvzT7db4zoXaZdRtioihy15x5sVlSB8Bs7VFkS4USG+H
	 Jh8TXTGLuuhc2eWztbTmwYGT/92FpvmiC7XnpNWVLkRkIATERWrsm+4LumZ0x/SisN
	 2Gugtnz8V8UuBGzMQgNBJ2r7eA4Qo27++wMMC4E07nPsGl+UN4J0Ds/hvhUs0pb2M1
	 GPJCs5jNFr05si0U+WdLxZcTfZde5GzbWAjEOalxyRTUAQY34FeGxmnKczRm4z5JzF
	 8oifLKq6fY5+w==
Date: Tue, 5 Aug 2025 18:13:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Cc: sboyd@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] clk: divider, gate: create regmap-backed copies
 of gate and divider clocks
Message-ID: <20250805-slit-scrunch-e19f8afec16d@spud>
References: <20250623-levitate-nugget-08c9a01f401d@spud>
 <20250623-spleen-rambling-8bd898f2788e@spud>
 <f059ef8e-1834-4d21-bb17-8670cf7cd90f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9zeZAJc7XAA2HBY"
Content-Disposition: inline
In-Reply-To: <f059ef8e-1834-4d21-bb17-8670cf7cd90f@foss.st.com>


--M9zeZAJc7XAA2HBY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 01:23:49PM +0200, Gabriel FERNANDEZ wrote:
>=20
> On 6/23/25 14:56, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Implement regmap-backed copies of gate and divider clocks by replacing
> > the iomem pointer to the clock registers with a regmap and offset
> > within.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Hi Conor,
>=20
> Excellent patch, thank you! I really needed this and will be using it.
>=20
> I would also be interested in having a similar regmap-backed implementati=
on
> for the multiplexer clock.=C2=A0 Do you have any plans to work on this as=
 well?
> If not, I=E2=80=99d be happy to propose a patch for it, with your agreeme=
nt.

The only types of clock my driver needed were gate and divider, so those
were all I focused on. I don't really have a plan to implement more,
particular given the lack of feedback here means that I don't even know
if what I have done is what Stephen wants. The rest of your comments
seem reasonable, and I'll try to implement them in a new version.

--M9zeZAJc7XAA2HBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJI7ywAKCRB4tDGHoIJi
0sR1AP4zQnrLebu8U863VAtOFHm+6M8gEW/WnUp3VMypOqgoIAEA6d9iEeY01BHW
S8o+uJeKAfF5/WvpbXoU0kZQT2osNwQ=
=urpw
-----END PGP SIGNATURE-----

--M9zeZAJc7XAA2HBY--

