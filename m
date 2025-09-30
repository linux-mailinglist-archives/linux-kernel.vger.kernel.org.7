Return-Path: <linux-kernel+bounces-838056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3669BAE544
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F42419449D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED783267F58;
	Tue, 30 Sep 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3lbHwOi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47433EC;
	Tue, 30 Sep 2025 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257740; cv=none; b=UirF+9Yg5QzdVhPsonW+U3K/U9C8u5xGI069kQ/2yIO/hUKgWm3FOhm0AkBozrLr0L11O8poCDPRaXuWNfX4ernr6L7+L7TK53r1Cgsgu4Y1AnmzwE6uqUJ3YzILWyYoXdpJxdeObqhNaogpWr9mpQ7pyhmzlxbyu/MWcMhsw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257740; c=relaxed/simple;
	bh=AwClXOYIL3t1a+GcEAIFfJ5ozI19kjStSruDq1e6QzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnVk6LGHkapsGZ8jM3dk3r+yZtRtl3DutRURdFr9nT2OK9j/lZflmzDThdDWTgs0hoULI1uRWLyVCzaidJxyRAxDYjItYMXSJbly2R5yic7JmRWoYnT2YB6iNivS3Zbnv2CEgygg4PSDd3WtRr69vtr75Kp4kYgVA/abik7Me6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3lbHwOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19C4C4CEF0;
	Tue, 30 Sep 2025 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759257739;
	bh=AwClXOYIL3t1a+GcEAIFfJ5ozI19kjStSruDq1e6QzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3lbHwOiw/l6OtXSoVCd+MvPx2z/KJMMGsJmHIKetnAmrqrMnasM533hO/fTvkhzh
	 2pHQ5mWEKXvHA/8TcefUyGMS0IYrHQ7bgz1bsX67XgJMp1+Q45TKVV7m3tJ+iYYEar
	 cyqryGRRswWMzAL/Vdtyqis67qPoAmtG1J4YT3sEaMqKuqNVGyb2c/qzsrJ7ILOBxG
	 gKUbHTJy597H7jlVEyGhgZHI6nm1FKWxbj/JZKxocuIDV+RlrPP2mA28t+urgGbLIp
	 drpoe/dmDNZFZ1lNwJgRKwb9+BSidxSheYblUlNRSvGA2NsTZRte1lq6uSrysWNO4U
	 LcLBlBedLWiiQ==
Date: Tue, 30 Sep 2025 19:42:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>, Yao Zi <ziyao@disroot.org>,
	E Shattow <e@freeshell.de>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: starfive: add Orange Pi RV
 board compatible
Message-ID: <20250930-sloped-recluse-41f839700f8c@spud>
References: <20250930100318.2131968-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+R1FBGQkGC0sH56x"
Content-Disposition: inline
In-Reply-To: <20250930100318.2131968-1-uwu@icenowy.me>


--+R1FBGQkGC0sH56x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+R1FBGQkGC0sH56x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwkhgAKCRB4tDGHoIJi
0loyAQDpGBt5M5Bt9rdbp4ZweJ7+EI45IWFhPPwUfdR6Q9NnnQEAx5F8PPjO9K8X
I4bstGW4wkTMmwE0NHStZJHEMbSwXwQ=
=daU6
-----END PGP SIGNATURE-----

--+R1FBGQkGC0sH56x--

