Return-Path: <linux-kernel+bounces-763471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41344B2150E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0804179CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F4288C12;
	Mon, 11 Aug 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9fmZlHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129141F4C87;
	Mon, 11 Aug 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938936; cv=none; b=GhyV7DrAlslGlZ1t5wWtX2SyNifal6P5I9vgMFJy9wqv4jhfi7X5U/SkdN8CgYEE3wxXiae0aCeSXQ6Mxa/qd0OETXoRsYgmbspw4WlM76wJf4/uPv7JNcx/qcFmThedtiZgzr1hgw0xUPrKof1RgytT1i1qIyL8cPg1DvPTZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938936; c=relaxed/simple;
	bh=EuHdKiXutHB5yCcWa/HyoBa738jpXyt09EwqvOg7gbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIEevH3vlWDWDDVX9KCalrJxWXNenLy6alcI8OeQSKTVbSAOfwslyK7wcBAowT5dZJKTjAsPGPW154kvKD9/EGuUUd5nHehowToYJrbFuHPgKgYLYgmmt04zpat/fnIo5/cohpL/qFph1OJBgBMkayAw8YNoOAmcff1UopIFUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9fmZlHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1882DC4CEED;
	Mon, 11 Aug 2025 19:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754938935;
	bh=EuHdKiXutHB5yCcWa/HyoBa738jpXyt09EwqvOg7gbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9fmZlHNga6bWyg6CnIOo1gp7IQCRH5dWaiEV7mY1R+K+VhcuxldmtHC4I1nRoJJ9
	 lIe8TYW64z1QH3iefJojxZzNd/qZZZjXwLX5X9shFGSQCHbOPixQvOdybTlcpSDE8H
	 n4FfADLtHrLMSWTokWq9GXrhpvE83a184wgAMokm4Ls86nwN1LLyBBNxn5JpUGv8rN
	 dgom3tHM/avsNxExvmE8pIUZ6jfrj1UoGvw+tW8/tLaOb2AkzBHP54mJB52qvjZ9g3
	 WrH/uLw2kXV3w5udkBDV3nKeLIudl6YOcZjoNH0vDjOKCMdiIF5IS4eLRfvzxJxks7
	 MbLBoNoUkPfCA==
Date: Mon, 11 Aug 2025 20:02:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Nick Hu <nick.hu@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: Add SiFive vendor extensions
 description
Message-ID: <20250811-darwinism-punch-8eaffc197cb4@spud>
References: <20250801070112.12071-1-nick.hu@sifive.com>
 <20250801-lunar-stream-0fdb3f0febec@spud>
 <CAKddAkDMd27icz6sa5xONAiWGcb8Un8CddHKyX1=jQzH7DCvZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4OtjcrCPRSA3bkmJ"
Content-Disposition: inline
In-Reply-To: <CAKddAkDMd27icz6sa5xONAiWGcb8Un8CddHKyX1=jQzH7DCvZA@mail.gmail.com>


--4OtjcrCPRSA3bkmJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2025 at 11:38:34AM +0800, Nick Hu wrote:
> On Sat, Aug 2, 2025 at 3:31=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
> >
> > On Fri, Aug 01, 2025 at 03:01:12PM +0800, Nick Hu wrote:
> > > Add description for SiFive vendor extensions "xsfcflushdlone",
> > > "xsfpgflushdlone" and "xsfcease". This is used in the SBI
> > > implementation [1].
> > >
> > > [1] https://lore.kernel.org/opensbi/20250708074940.10904-1-nick.hu@si=
five.com/
> > >
> >
> > > Changes in v2:
> > > - Update the message to indicate the user of the extensions.
> >
> > This should be below the --- line.
> > With that,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > although I suppose it'll be me taking this and I can fix it up on
> > application?
> >
> Thanks! That would be really helpful.

Done, applied for 6.18 material.

--4OtjcrCPRSA3bkmJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJo+MgAKCRB4tDGHoIJi
0n5qAPsG0vDUej4A1/tAPPvzmlAg+1iAGhdOffqUAqvFfV+VYwD/dz/DCllAxpE1
Uz0QYaCyQA2a9FBfGhnPm6F9Jrv0WQQ=
=v+qd
-----END PGP SIGNATURE-----

--4OtjcrCPRSA3bkmJ--

