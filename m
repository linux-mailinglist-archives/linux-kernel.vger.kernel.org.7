Return-Path: <linux-kernel+bounces-867571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5DC03058
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6518C505ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8227E7F0;
	Thu, 23 Oct 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8kh5zRd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1129408;
	Thu, 23 Oct 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244253; cv=none; b=TRaWHBoxVLoWIY3vXlnQdK2kR/cmzjylYFgoCyWUayWlsUC+mT3UOuPlpWsp6v1jyDE2Z/YGCxkqQLnl8SQ6DliI6YN33H+9s4Ug7A7THn5MaA9ZRpmSww8vFgsFiTRcv9WqBLRAWTwGkPYjDV8VdUTN5QaxlH7p8fRieH4qu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244253; c=relaxed/simple;
	bh=4FMfhKfwT45zNZYWzsFfHSI11HycY9Zq+anG78kko6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6yvoAcp7EJmxWeVMutIEqsGmTVkRmEXWv7G0dTaz0Wd9ReJdBJLLH7VCBvp+TxnLiDhWOSaeRBMTSYBB0UJVbyqqUxKpQcgwkwua201w39EWbkehcIcp2lK0lKq/j2+ZfgBJLhW+xEOMccaQU5NsrkdQ2xTQjX0007xVs/alQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8kh5zRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9430C4CEE7;
	Thu, 23 Oct 2025 18:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244252;
	bh=4FMfhKfwT45zNZYWzsFfHSI11HycY9Zq+anG78kko6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8kh5zRdhJ8DfNXO+pXijXPP16eIKBATNaSTTwiBFAxn9OS6noJRgaeBoCnOom4QP
	 2+Dq4jNtITFcanQIZ//0gbrUnkGrdf2K7y6+PGo+CNShe3uiN29vmhWJtM6+eOmpuY
	 WT6JIfO45BRUmhm5mNCZr/iO80fNGjbTIAFGa2awQ94FLsr7VVYcVJE2hHaD+3oBjn
	 ieSPZD2n64i50ERiYGpEjQlRvsToTaJgenqLfouNVgmvT+ZpyapzK4V6nUwsb0wgin
	 rVm5pLztevxcCZtvnZIgAO401tIas/DjvqsBaxfLmWlnsNukE80qnpS21O181ltuIs
	 2eI85t5rQWAZw==
Date: Thu, 23 Oct 2025 19:30:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
Message-ID: <20251023-lizard-sharpie-70f2a000327f@spud>
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
 <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
 <f8a55f89-2612-49e3-88c6-acb523ac74d3@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZhGqk7lYBtXKeshE"
Content-Disposition: inline
In-Reply-To: <f8a55f89-2612-49e3-88c6-acb523ac74d3@iscas.ac.cn>


--ZhGqk7lYBtXKeshE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 01:58:22PM +0800, Vivian Wang wrote:
> Thank you so much for the patch and testing results. Only some nitpicks
> follow.
>=20
> On 10/23/25 04:18, michael.opdenacker@rootcommit.com wrote:
> > From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> >
> > The OrangePi RV2 board ships two RGMII ethernet ports.
> > Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
> > for reset pin control.
> >
> > Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.
> >
> > Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
> > CC: Yixun Lan <dlan@gentoo.org>
> > CC: Vivian Wang <wangruikang@iscas.ac.cn>
>=20
> Firstly, it is usually spelt "Cc:", with one upper-case C and one
> lower-case c.

I don't think this matters at all, the git tooling at least doesn't
care.

> Secondly, "Cc:" should not be necessary in the patch/commit message.
> From Documentation/process/submitting-patches.rst:
>=20
> =A0 =A0 If a person has had the opportunity to comment on a patch, but ha=
s not
> =A0 =A0 provided such comments, you may optionally add a ``Cc:`` tag to t=
he patch.
> =A0 =A0 This tag documents that potentially interested parties have been =
included in
> =A0 =A0 the discussion.
>=20
> If you look through the git logs of Linux, Cc tags are really not a
> regular occurrence except those marking patches as suitable for
> backporting to stable.

If people want to handle CC lists by putting it in the patches (it's
what I do when I have no cover letter) just put them after the --- line
and git send-email will still pick the CCs up but they won't end up in
the history.


--ZhGqk7lYBtXKeshE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPp0VwAKCRB4tDGHoIJi
0hv0AP9BsJs+SKApne1B/5qPw5tzPqgF8dkrHmZDpyswXTvZ1AD8CSR4yC0q1TNO
+DjxnBOkx44cBcpZmewCQVdDbx2apAo=
=RpiQ
-----END PGP SIGNATURE-----

--ZhGqk7lYBtXKeshE--

