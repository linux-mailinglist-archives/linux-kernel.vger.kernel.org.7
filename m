Return-Path: <linux-kernel+bounces-829535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6CB974AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7481119C60BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866030275F;
	Tue, 23 Sep 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0aHUkUf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912A2DE70D;
	Tue, 23 Sep 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654506; cv=none; b=V0ugycANv2ZxHd28mobwYGmy2dd+ZOWMGnggFS+HGWAFKyXugfUIilYkPfiACnyj/QPZzfg0lC//+XAD8GEdcO9JHtwnE1rZRpO31sL27W4M3rTRK016CMnfXv09kEMO7ph5aR++m9MOqX9OpgNGkI1R2VR5XWTL0BWqlfWczb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654506; c=relaxed/simple;
	bh=/oko3GJ0c3Ps6VD1HRcbOt4yyfXiylFIVm0FvKl7VWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eppPk5YkQXTeA/lPSGW159nf1XRcu2FPch6M2/vBPl83wNYeR10Rv03J9TOkxNIOlk2wzzyO7xdLFAZjndz+BqQfL0N+Bmj93sGpetKQk8WNS0szF+1yLLoz4fFnolPYaDwVLiVQcQzN1mgsp1UVccXhEsPLhMgulz6vC6QrQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0aHUkUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F04DC4CEF5;
	Tue, 23 Sep 2025 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654505;
	bh=/oko3GJ0c3Ps6VD1HRcbOt4yyfXiylFIVm0FvKl7VWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0aHUkUfGiipbWUkL4pI6Z4NZvNfClCr1uJDctIBqiY7RYIHFsREswxH3jgnJFseH
	 O6sEW+VigOVhoborHB4QRoWe7iwXPmua1yOAARrIQ4IyRTE/TPrEFIW5LQs3hFaBUS
	 xSArSJTjd81ScRyqJsqnIvIltN5F7g/sSSVxa7QgXPL0H2J8BNADw6v3xknCUcSmpy
	 E+d40iBhGW/xdWFwfgEGSukPcAf3S2e2dyhMYknSPln95Z3aXjDd1zb+Q7zOMSu36J
	 IjdN+KjLhIoN35OuS7EX5ZTcUuphMAz6BF8QUEwkKJ5AbmiDs4sP4c4/3S+vgT8kfJ
	 MFfUbqVJjbGCA==
Date: Tue, 23 Sep 2025 20:08:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 08/11] riscv: dts: Add initial Anlogic DR1V90 SoC
 device tree
Message-ID: <20250923-overshoot-ancient-4f7cf5570b56@spud>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
 <20250922-dr1v90-basic-dt-v2-8-64d28500cb37@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yVWL28TGn3RScTs"
Content-Disposition: inline
In-Reply-To: <20250922-dr1v90-basic-dt-v2-8-64d28500cb37@pigmoral.tech>


--6yVWL28TGn3RScTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--6yVWL28TGn3RScTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNLwJAAKCRB4tDGHoIJi
0pljAQCHomHCirCJIk/0haJUJMrTJD2Y8uhiq8/1y/5ivI3xcAD/Zocsc/2+a/In
UlAr8HoqRAFdDdVnsuCdaQy4ySW7Hgs=
=PzzZ
-----END PGP SIGNATURE-----

--6yVWL28TGn3RScTs--

