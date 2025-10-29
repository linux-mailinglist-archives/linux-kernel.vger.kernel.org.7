Return-Path: <linux-kernel+bounces-876853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD487C1C8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AFDA4E7223
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46D32868A9;
	Wed, 29 Oct 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wowakova"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB415350D53;
	Wed, 29 Oct 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759655; cv=none; b=BbAi75J+jDI2N21A+AcoHwMoTHE4Y+ZdI1MakIDBhIFn1xWioIREQAqJ6nKBTDLiJB4Pze+1ENaP4E1JHdmkrMylltpURlw0MP2AHnsbAmToeLLat0Rq/pfMIxxDrWjn+C6xQegoETQa30jUfV/Lp/djVaXLg7rQpGf7SGmIoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759655; c=relaxed/simple;
	bh=G5AVuuO4OvaB/g2hqRGjeUqGZO8dywJnL9ft+gh8LLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrcBlT017kvDbMRN1beAFAMAYOXSjI55ssaPeZdfhT4IW0Zl2QneeEnL0XyG8DqveO3IKzCFo9QtcRFP/N2UDOSe2Mb/8SSTh9rzQCraCkh4M3K5twz+9mmheGorRsxXqdB5dfjaKxR1PaxZLSQ1+cHHtDDLx2kBZXsmYDhCq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wowakova; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE97C4CEF7;
	Wed, 29 Oct 2025 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759654;
	bh=G5AVuuO4OvaB/g2hqRGjeUqGZO8dywJnL9ft+gh8LLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WowakovaH3G1wjWocbBcTRtRf/6UE7oycdmWXopI77MPBbj+pMnIhoKfInAmhDI0Z
	 f15YfUswKHLQRdaXgA7OCsOr/MYlGfALt90ZyFLOadZ3SkZVcTew6VbO8xB6s3OaZB
	 O8NTaJIeyn0ueyEAlrlhz1mJdDLDlK6jR6RI5/AaloPGLvnP70hc8zcLBHJwZJvMNx
	 IRpegQEDtJ3K34aXuM7SV/GXifXp9C2XjBhQfQdKmakiMYBnI21ndyVAfEKWyOxMLy
	 2V3oZ7eFgstXcdqDISDM5swMCZ4WcEENqlQ5A6CAAz402tnHVn/Na+P+RU3LAA/Xc/
	 4Z6rYqkoKdTDQ==
Date: Wed, 29 Oct 2025 17:40:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Update license for MIPS GIC header
Message-ID: <20251029-plunging-casualty-d0c5f78def7e@spud>
References: <20251029-fix_gic_dt_licence-v1-1-af70840c5e61@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7YTlVNBx2flFfosT"
Content-Disposition: inline
In-Reply-To: <20251029-fix_gic_dt_licence-v1-1-af70840c5e61@bootlin.com>


--7YTlVNBx2flFfosT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 08:22:20AM +0100, Gregory CLEMENT wrote:
> According to Documentation/devicetree/bindings/submitting-patches.rst:
> "DT binding files should be dual-licensed." The second license should
> be a BSD-like license, allowing the use of the binding in projects
> other than Linux. Initially, this file was submitted without any
> license and was later automatically converted to the default Linux
> license. Let=E2=80=99s now update it to follow the preferred license for =
the
> binding.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

I think the subject prefix here is wrong, and should be "dt-bindings:
interrupt-controller: <bla>" or similar.

--7YTlVNBx2flFfosT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJRogAKCRB4tDGHoIJi
0pVkAQD1xcm4yumAJfeV1VOJwSbun6CM1c3GLtXx8GPEX4sh5wD+KV7Gj6+tceyb
+mO1KAvYQoWrm7XGIu2taVh6nkCohwY=
=Sk4/
-----END PGP SIGNATURE-----

--7YTlVNBx2flFfosT--

