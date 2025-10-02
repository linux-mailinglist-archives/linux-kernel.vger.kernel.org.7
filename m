Return-Path: <linux-kernel+bounces-840075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29993BB3779
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141CD19C327C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612F2F9DAF;
	Thu,  2 Oct 2025 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzLVSutp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B82ED154;
	Thu,  2 Oct 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397767; cv=none; b=DC6cD3h0cAIp6dt1/eTYFc1kRORkKTz/BHUtd569x/axoY/B7piGoAERam+QdVMPMKHxcCe2QkBbxnowQcvwCpbu3NgD8Rr2IJL94LUdZjNAkJNYhAPs7djvHSXUrpj9Ywuop1+HLHNkqItxzo34UhMCnnl/AH2pSxaRV4mxwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397767; c=relaxed/simple;
	bh=bolpaLjsSmPCM0rXF6ePFMhixKRVDli27uVWmbGLTdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh+VmWn7YO4PdrvQrGYG9Omdrq02Q+dnIHTYI7Jnmk9bqFE8SwG7cXgw1RcvvHkv18Ukp1qQ9dAw8zD04EeLr033yV71mzyS2F/PV7kJoiW+j0Ud/JWr6YnjoyLNygCsfuMf2Dt3H48EpDznZHGs9+Yk8PUdUlYHaMhgXOg8eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzLVSutp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A75C4CEF4;
	Thu,  2 Oct 2025 09:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759397766;
	bh=bolpaLjsSmPCM0rXF6ePFMhixKRVDli27uVWmbGLTdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TzLVSutpbF3K1sI4Tt8076iyPL/gyGCh7yBtkMzjgrnsBWmJQpentUbqnFoDpc/A1
	 eFLuai0OaGQJDiJTl6u5yfsZgpRwOB9yT2YxnKC3c6UgtQSdWCELHC25L9kUHc560a
	 lWfjpy3wjSQcxdkE+HO0Fyjyl1ntmkdq2ZrdvkEbzjr9/RJmZVqZ0TdEA6f1LxqpI6
	 7Bywv7CxNYrFU1mx2dZnzy3TYV5r+vvAHAraRG2JZX8UfYJBNANR5F1Nc3p29aZasT
	 3nZmLb/rdzTlb1MRgMmWzZmp/e11iqTF6r8qE83CXNYRFMSf/2IktLhQopisbEIg3K
	 pCa1LGtND33RQ==
Date: Thu, 2 Oct 2025 10:36:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: COMMON_CLK_RPMI should depend on RISCV
Message-ID: <20251002-rubbing-nucleus-b353e09be786@spud>
References: <ed37635b59b0765ed3dbed6ea33c562a40b9e287.1759243789.git.geert+renesas@glider.be>
 <6555b47f-919b-b56c-4a76-352c904343c2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X3zY6r0kZPU8RzaL"
Content-Disposition: inline
In-Reply-To: <6555b47f-919b-b56c-4a76-352c904343c2@kernel.org>


--X3zY6r0kZPU8RzaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 07:15:56PM -0600, Paul Walmsley wrote:
> On Tue, 30 Sep 2025, Geert Uytterhoeven wrote:
>=20
> > The RISC-V platform management interface (RPMI) is only available on
> > RISC-V platforms.  Hence add a dependency on RISCV, to prevent asking
> > the user about this driver when configuring a kernel for a different
> > architecture.
> >=20
> > Fixes: 5ba9f520f41a33c9 ("clk: Add clock driver for the RISC-V RPMI clo=
ck service group")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Thanks Geert for catching this.
>=20
> This patch is against unmerged patches in -next.  So I'll plan to add thi=
s=20
> to the PR that I plan to send to Linus tomorrow -- unless any of the=20
> drivers/clk maintainers would prefer that I not.
>=20
> > And perhaps the "default RISCV" should be dropped, too?
>=20
> Probably.  I guess we should just add this to the arch/riscv defconfig=20
> instead.  Let's wait on this one for a few days to see if anyone has any=
=20
> comments, and consider that change for v6.18-rc fixes.

There's little point having "default RISCV" if it's only available on
RISCV in the first place, may as well just be "default y" and be
simpler.

My 2c is that putting it in defconfig is barely worth doing, unless there
are actual platforms that use it.
Does QEMU provide a useful test for it that exercises the various code
paths, that would make it worthwhile to have in defconfig Anup?

--X3zY6r0kZPU8RzaL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN5HbQAKCRB4tDGHoIJi
0hCxAP9qMjBA9+QO8ktTeHc/pequI7z96SimmSjrHSVx09FE9AEA5DRhJFgRmgYs
YN8wWBv7xA8cwGsr6+oBkTOSUoj1WQk=
=YMaO
-----END PGP SIGNATURE-----

--X3zY6r0kZPU8RzaL--

