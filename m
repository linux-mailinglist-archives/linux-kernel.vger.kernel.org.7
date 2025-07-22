Return-Path: <linux-kernel+bounces-741117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C4B0E03A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3D86C45E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8325334B;
	Tue, 22 Jul 2025 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QANBn87i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E01E990E;
	Tue, 22 Jul 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197497; cv=none; b=fqX2tIOkGsC5VThnIC/jIPyYZA31JXSi2jGfO93FhURzwXzdsjHIsniMQINvIMRlXkLGaae0U4g7KYo03lQaovQkn6tMKLCnV00v/jdr9NxkTHDHsMyfnsD01FTnE4rLquT1Ubsja+As5cLI+AVFdKSnJO50n24bG0rL/0fOgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197497; c=relaxed/simple;
	bh=fGAsWfNt/z2iWfbEh9n7rz2FAHRGTRMDGKrGQIo3ivc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWMHJ38bAcu04scOG+Q4f9HRaSXCYU7gCDaaxou0BokzCmI8in2EYp7CV5CQYYeLIk9TK0WKkSBqDy5e+Tsb9lxLQHWy9t8OT7i0GiSls52l5JMHa8gsQASZRm2IwnsIxykUUup1kJ/8MfYuBIPlsCYQMtRVXv+VJBxYssH8g1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QANBn87i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA2BC4CEEB;
	Tue, 22 Jul 2025 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753197497;
	bh=fGAsWfNt/z2iWfbEh9n7rz2FAHRGTRMDGKrGQIo3ivc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QANBn87iMG9qnMcejys0/rBOp/MPEBt2RfiqQ4Z3kAl0CdUwvRsnjmpobqFpfXitG
	 0xQ9+/qwCPyAs+3UlRxho4xxG/kua6Xc9t9TIOUOXu9DQ5EKZEIkxPQbCvmX6IVsL/
	 ZjHCsp73PPQZEpbAa/OpjLkHQcZ0rurpFcALk1i1r1JgVH1GXHvsr+oBw2zDe/6z8d
	 2L8LVv8/1vEX6TE3xmt53Jt3rhMNDqbwhHPjqfFJr70a1AYEc7r3r0z3Ru+cHXKkcE
	 H4Y2cd72e4TUodbeB/hSNHKlQeiUx1UiLgGpsGeU4gaPnFyzgNannH2XsESjxEDowC
	 XyLigMYiK+y/Q==
Date: Tue, 22 Jul 2025 16:18:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V 64bit
 compatible
Message-ID: <20250722-glitzy-worshiper-7574af025084@spud>
References: <adf316c097ae416eb8565f2f1d67a98c413a71d2.1753169138.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r+Au2k4XYYAgwXda"
Content-Disposition: inline
In-Reply-To: <adf316c097ae416eb8565f2f1d67a98c413a71d2.1753169138.git.michal.simek@amd.com>


--r+Au2k4XYYAgwXda
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 09:25:40AM +0200, Michal Simek wrote:
> 32bit version has been added by commit 4a6b93f56296 ("dt-bindings: riscv:
> cpus: Add AMD MicroBlaze V compatible") but 64bit version also exists and
> should be covered by binding too.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Although maybe I should pick this up myself? LMK if you want me to,
rather than it going via the xilinx tree.

--r+Au2k4XYYAgwXda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaH+rtAAKCRB4tDGHoIJi
0vacAP4zbN3Fu+D/dt7INleDrr3nJ9mrPD2r+G3p5CicM2ALCAEA08iTkS686xJY
Uu4OrgvMrLyDB2t1mClhYrqsyJcw0wM=
=Lceo
-----END PGP SIGNATURE-----

--r+Au2k4XYYAgwXda--

