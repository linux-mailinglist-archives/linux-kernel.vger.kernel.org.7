Return-Path: <linux-kernel+bounces-819483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D2B5A17F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55936484453
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659027AC37;
	Tue, 16 Sep 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2hr0L+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEEA25DAEA;
	Tue, 16 Sep 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051258; cv=none; b=BqNxMjTuT7XbKvELYc7VxkMHC7MfMkGynajH23ysyX0zyqKNzTUNk+4JVCtmMlD76+uvEAvhkikJVmvIkluCBHuxRnt9I7gEZwDVQ5SWzFpOTSf6pAPslTy9P6f7QFExm+La4RYoWzIxKoD89AScWG28CexQO5rq5j0LsxClpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051258; c=relaxed/simple;
	bh=QgN0tp5+BnqROHw9FXVqQqC/BdaT6YsmUWPyx8F9M30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSaP73MwfZHHcfQVxEyoesBqmWILds5oHcAo31F+oEoxb+2IxB/hJeBzG8vOAobRyw7Yz7y2WVxXWB9eFPVdjXM2tORcxOjjhLE2J+dagVT/3SbZcduuNYRQ2wjzOpFUv1xuGR9biaL1gr6TZOk3bJCPJ7Ntx5nxd9Q4L/XJ8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2hr0L+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED8FC4CEEB;
	Tue, 16 Sep 2025 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758051257;
	bh=QgN0tp5+BnqROHw9FXVqQqC/BdaT6YsmUWPyx8F9M30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2hr0L+H3wxrcQZIUsuKqZsZWLrrHlmNQ1AAvyCZTvqcbG5G349TozInbMZk+K2cA
	 tQsNximPD64tdqmQFTjVg0ONSCSbIGFiBcHxS9BxL+KHsm1KMArXtHWAr6hbEPZhKC
	 RhTXUHnhxhEOx9DaYGTMmCB67HjP2IQQlGZxzMaS1Tlo1880FAVtQngbHydIRgR8Wu
	 6pkZx1YaAFQd5Hx8Qxf26Sw/IdSNHCupAYhLpjFq9vGvNqS86VzhXHE0HAYrhBiE1o
	 ADOrSwwOjqHx+zLF3lk8ar1axaBU/alChU7qPUgSYwlp8usKHldPTv6UL8PQYZ5usH
	 kYtaP4FvBdKGA==
Date: Tue, 16 Sep 2025 20:34:13 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: Re: [PATCH v3 0/5] riscv: dts: starfive: Add Milk-V Mars CM (Lite)
 SoM
Message-ID: <20250916-retired-unloaded-fd141b2a12a0@spud>
References: <20250905144011.928332-1-e@freeshell.de>
 <20250911-smoked-aviation-b514261e547e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ruQ4PJfRzjetgeGw"
Content-Disposition: inline
In-Reply-To: <20250911-smoked-aviation-b514261e547e@spud>


--ruQ4PJfRzjetgeGw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2025 at 07:07:10PM +0100, Conor Dooley wrote:
> Emil, This look okay to take?

I'm just going to take it so it can make 6.18. Please yell Emil if you
don't want me to.

--ruQ4PJfRzjetgeGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMm7tQAKCRB4tDGHoIJi
0nMMAPsGxNydWe0mP+15KraqnLZrrZxrsZJlFeeqeonAZ3VLTgEAnIwLs7kafDth
bWJ3osir+X20IMY6ZeJLkAmDemJotQ4=
=d0iP
-----END PGP SIGNATURE-----

--ruQ4PJfRzjetgeGw--

