Return-Path: <linux-kernel+bounces-812781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33441B53CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2D2164BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313425C6EE;
	Thu, 11 Sep 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRj/p7TT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82E2DC76E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620414; cv=none; b=X4lzvT+hlM1OpmQECN6pMLGK7caRgLU5lwsbr47uKAMqQvMcWeN9zxbx+6XC5Ej9/D4B35pd6iBU0niNtgJn0WMIMdBQzv3UYdHZDRytyJGwVwhDtqWbyHDGb+EaV5YOjdBudYQp+GL6punDTrKZJ7C3DyuNz5WqZlnMy0B/JTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620414; c=relaxed/simple;
	bh=AodW38A29sqmvvlSetUW/ZjjgJbifCGUivPqnBnvZ/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD2XZ03W7TQ9pRDEnc3EiaCq+Sq7oYMPgWHqC4AJNVSUtqWHDVDDMis4wVPA1PrYlCBsiODqvBRziGkanO+9axOj6Ix9N4US7MGi+/gSCooOAl/23/8R+0JrBsiL2+5oEo4sgurnyF8fpZkc8Zvlku81nOBlqzBhBrV+GfHcjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRj/p7TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ABCC4CEF0;
	Thu, 11 Sep 2025 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757620413;
	bh=AodW38A29sqmvvlSetUW/ZjjgJbifCGUivPqnBnvZ/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRj/p7TTc4VZV3zJp2FQAE1awUUZBHTY94GntEf9iosSZJDoxzebyvwvjDuuwxgJT
	 0uj4ycURxC7Wx9sErcvyOi04SzecJCqNd0tImUNF22T/0KQJBtDqe0lT0OLGuIF1ae
	 tlD6wlS8xt8JVVWadDBlDJCoZ85RSTDWsCUddRa+AprvZUW/Jv7U2GWrOZ9nM3098e
	 O0AUiCxqVXZcE+zqcLJE8MHSljkZO/imTdhEkjQInuv9UilOii53XDV0Vi2sOeyYGE
	 gXEKu+JsColDMIfi/Ptn5roDjQqAtr76gCI6+aHJ8B9IpWriAsyPztS5hJDi5UIxDs
	 M/VkKkRM7QyQw==
Date: Thu, 11 Sep 2025 12:53:32 -0700
From: Drew Fustini <fustini@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] RISC-V: Detect Ssqosid extension and handle srmcfg
 CSR
Message-ID: <aMMovMevjriDs/Ac@x1>
References: <20250910-ssqosid-v6-17-rc5-v1-0-72cb8f144615@kernel.org>
 <20250911-chaste-rare-fbc3b48a341a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zEbtGaWXMlB3uQ9r"
Content-Disposition: inline
In-Reply-To: <20250911-chaste-rare-fbc3b48a341a@spud>


--zEbtGaWXMlB3uQ9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2025 at 05:23:30PM +0100, Conor Dooley wrote:
> Why is there no binding change here? Is it not possible to use the
> extension on DT systems, or is this an oversight?

Thanks for pointing this out. My intention is to support QoS on both DT
and ACPI systems. I will add an entry after sstc in extensions.yaml.

Thanks,
Drew

--zEbtGaWXMlB3uQ9r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSy8G7QpEpV9aCf6Lbb7CzD2SixDAUCaMMorwAKCRDb7CzD2Six
DOfaAP96GGUAVpysr/h4ZBvQcIkHJzaMMI7OTwpxiLbcKu3WyQD9EeUoBIblbZhg
l85fP/yS4nkEhSof41ceaoNhMnF47gI=
=ZHZW
-----END PGP SIGNATURE-----

--zEbtGaWXMlB3uQ9r--

