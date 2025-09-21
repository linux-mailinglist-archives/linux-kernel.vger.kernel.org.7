Return-Path: <linux-kernel+bounces-826392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9DB8E62E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F6018987F6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0628EA72;
	Sun, 21 Sep 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZbrg/c1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69A246333;
	Sun, 21 Sep 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758489758; cv=none; b=JBCUjYE56xEwH9WUDS0I+w92rigaSNrofqfWaB9ErIEtQWa8ulHYR1gN3at+v5R9TqlRbc6AouA78YDCDknF6//HxnbV31yoQHypR5CNv0s4IUC5OOJPFbMWpOzgqEMiCu8WZwPZRjwJGm+gfTbzBbzMWT+u+ZDqdHTBwhUYQes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758489758; c=relaxed/simple;
	bh=FfaSe140mcWx+5UOLTrRKCtyL3nIIKPUV/4Fn/ZxxyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1uNUSOScVvcKjKQGIRMy6G02JFFA8Q63fzOoj/MnhsoEZNA5heocsKWeoG2HI8hBdZn9ieoC2Er/kEpsls+0rWDVo0bgydQk42KEHRwg3Iq34YJVg6yISoPl+L3VClevyJgbX8EffMhgbnjRlnTPp6tCa11hiD0oWawBaVxzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZbrg/c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD94C4CEE7;
	Sun, 21 Sep 2025 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758489757;
	bh=FfaSe140mcWx+5UOLTrRKCtyL3nIIKPUV/4Fn/ZxxyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZbrg/c1Tlz/SC8p2ImWDZfmjBBXU5q5KqwYxyO3CdMFVDWWcyHa6psEzHuMzITaT
	 /YzgQkUj0iSec/ioqadcRy+uEc02QYcWkvwpgX/8WZoFGUnAzf/TvFVoamqU7P+mYY
	 pmulic5sQb7T3OTv3KXpGrifKDEHguTO7ulauMDHMqVZ+saKJzPGzYJaiU17k/PsLZ
	 L6/Czh8wtuBVPGlX24WHODb2tXetQrWR6ZihUgYAqAlpoEgEPMrWfes3M5POcGybpY
	 wjZDjDarKM/QwG7s4tp1E/RkDKgbzWrdS8nspHhRSCxWTc1q+LfDXaoM+JiIRQiwh0
	 5W+SU4eWBwkkg==
Date: Sun, 21 Sep 2025 22:22:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: riscv: Add Ssqosid extension
 description
Message-ID: <20250921-praying-module-6a94b3510482@spud>
References: <20250920-ssqosid-v6-17-rc5-v3-0-5093162922d8@kernel.org>
 <20250920-ssqosid-v6-17-rc5-v3-1-5093162922d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Im1OnXI+wDR1opM0"
Content-Disposition: inline
In-Reply-To: <20250920-ssqosid-v6-17-rc5-v3-1-5093162922d8@kernel.org>


--Im1OnXI+wDR1opM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Im1OnXI+wDR1opM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNBslwAKCRB4tDGHoIJi
0iBnAP9QK5OUnppWh5JFkOmqVjJHymCA82qhsBOC5l1deD+XxwD8DY86nmCWEIGK
0Vr5AbEic0vlD+Kfh3aiA61aRx6MqAs=
=4SqQ
-----END PGP SIGNATURE-----

--Im1OnXI+wDR1opM0--

