Return-Path: <linux-kernel+bounces-732138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A0B062AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9D1188EBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC80218AB0;
	Tue, 15 Jul 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H3LybZlK"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A02144C9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592492; cv=none; b=j2gy0/RKJsfAn4AHjXjmdcWYhQC3iqJaa0DOV8Ybui0MR7HyNL+JYWFqZ4eFzGgEcYI46JOMh5+zs7r1q49YgtmCughXeJCOCAJStoCYYlCZFqz7KnuooSg04iPcSIbTuNW4i/M86f/4RLoeFHx1H/a+3WW3oS5pof24gcU7xx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592492; c=relaxed/simple;
	bh=yFmzQwSMIFjNvglQa9XdXCijLr5Vn3oPqGM0Zlzio4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rg3V0ob8QkU4KjlmDe2i1otqGrhrr032knR/QJnXbgCNQEtcYJSitayoayDsWebBO5HyLoYHdUhIGgM91rUtNAWzu4gooGeppUk+Cg9d7y0uaj3bW3bQCHsb2RCFJS9wlyasjcA2uBkgcUBM+gbn9B80o1BmZPzSjfMYo4VuKbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H3LybZlK; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FFEVbQ038708;
	Tue, 15 Jul 2025 10:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752592471;
	bh=hVVjOb/TN1icCsh7cMGXZC40mnSkVzEFWomvt74Gc8A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H3LybZlKZ3cOB4VO+FPRUUjeyHgSiQRyIREkzKEM3yz3ln8pmdM3kNpkWTAadF1Ky
	 QtNTiBtEFxx5Hfo7oFf1yJVdkpGg05xr6dJe5pWDKfji3zxEc9MoQhTAXkgb+AYiMr
	 A3FaFv70/UgiZncT5Fq3eJwMvkqiJqRUweNtIo8w=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FFEVdR1340564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 15 Jul 2025 10:14:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 10:14:31 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 10:14:31 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FFESLV3108169;
	Tue, 15 Jul 2025 10:14:28 -0500
Message-ID: <5488ccd5-c999-4b72-bfc0-ba94bb9a360d@ti.com>
Date: Tue, 15 Jul 2025 20:44:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL 2/2] arm64: Kconfig: Updates for v6.17 for TI K3 platforms
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <a0401460-8c67-4c29-a6cf-fa4bdf33bc7d@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <a0401460-8c67-4c29-a6cf-fa4bdf33bc7d@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------wZWK4Gx41HaZe09BmvGF5917"
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--------------wZWK4Gx41HaZe09BmvGF5917
Content-Type: multipart/mixed; boundary="------------HJWeAli08ckFheguafpDshbP";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Message-ID: <5488ccd5-c999-4b72-bfc0-ba94bb9a360d@ti.com>
Subject: [GIT PULL 2/2] arm64: Kconfig: Updates for v6.17 for TI K3 platforms
References: <a0401460-8c67-4c29-a6cf-fa4bdf33bc7d@ti.com>
In-Reply-To: <a0401460-8c67-4c29-a6cf-fa4bdf33bc7d@ti.com>

--------------HJWeAli08ckFheguafpDshbP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-config-for-v6.17

for you to fetch changes up to 631ce8f743a5c85bd7f0a5e7dcca70566d88f43f:

  arm64: Kconfig.platforms: remove useless select for ARCH_K3 (2025-06-21=
 21:03:31 +0530)

----------------------------------------------------------------
TI K3 defconfig updates for v6.17

Cleanup select clauses for ARCH_K3 allow more modular builds

----------------------------------------------------------------
Guillaume La Roque (1):
      arm64: Kconfig.platforms: remove useless select for ARCH_K3

 arch/arm64/Kconfig.platforms | 4 ----
 1 file changed, 4 deletions(-)

--------------HJWeAli08ckFheguafpDshbP--

--------------wZWK4Gx41HaZe09BmvGF5917
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmh2cEgFAwAAAAAACgkQxEYeRXyRFuOg
3gf+KIgCkK+2i4hihExnymIUdaOln0LryX8pbIursQprGnwWlF3wqlipuB/pKt69MudPvf/ODjbn
AD+lI1eYB611FoH13pGOXBzI8wOd39ZJWtNou/dfxthpCoPjbEwtvdsN3MuxfjJIY5faqgIXFhlQ
QEn2kxh3DLaLE4K8OEnAf/8KLUIE+x/iFFQTUDO/3O+Jbv0kzsNuJNx5686xxGfc+YSm65J7dv4n
kJldosEEmtyL4HgCPxT1vFxENyMJFVBUt6EoEbKvUtYZW86Bzs8GE1xJE0+gv6Y9NurloFORJsDd
5x2x5MnuvCa8gZaybMer1taa1g6YV2xeyQjoTZEFLQ==
=Bbps
-----END PGP SIGNATURE-----

--------------wZWK4Gx41HaZe09BmvGF5917--

