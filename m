Return-Path: <linux-kernel+bounces-819386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B96B59FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3DB1C016F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DB22750E1;
	Tue, 16 Sep 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vVSZRgAM"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37A2905;
	Tue, 16 Sep 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045271; cv=none; b=IXwe087Cw6SOdEfLcon2ypM93vhBSFTWwnoIEGK3wYbipN5o9vZOGCoDmd2umOSEWQu+vxRvGBII21mBUF2jJQt1MZ4ee25fN3GVaQEdgZvcTtFnO/wA+yCSk56/o1Kqq3+7k2JAJkjgkvvBgR50L4Dp63i78N2mayCIgcbNV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045271; c=relaxed/simple;
	bh=Sk/RCuhSUiWEAkfioVy7CwI4/EjkVgbwbCk9oBl1uDg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ushh//vbCjprKHp7JiRHjhBlQHqDE89KKrn9jJAr4Q1ESs8zP7fLelCle70ZIrMA85Ojgva6XbVOxJHtfV/UUM6U3PKd/Rk/atyaeEhqBvgH7ju0KzGk0P2YkwOabcxG91sLalHFq1NiYOaMd09UrxWMVpraeJtrkFIMik08g9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vVSZRgAM; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GHsGp51327943;
	Tue, 16 Sep 2025 12:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758045256;
	bh=Uug7wVSmmaDIog/FTb4xuMPNsCp7il7OH1L7Ma1pUR8=;
	h=Date:From:To:CC:Subject;
	b=vVSZRgAMC5HzVSlAb5hnO/ITWkKouWifwrNptg2jSJSf4zJADI0uG7wrX44di2Iie
	 lbL6qcaYnUzrnNGGr89XygItYAMh641Ecpyw4wXTDbz9CXuo8/c23mab1GD2IbKqTP
	 Nii2w5SeE7NmVRBaP3NjdaG1amKSLedW9uT3rPe0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GHsGJK904788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 12:54:16 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 12:54:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 12:54:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GHsFmi1696995;
	Tue, 16 Sep 2025 12:54:15 -0500
Date: Tue, 16 Sep 2025 12:54:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, SoC list <soc@lists.linux.dev>
CC: SoC <soc@kernel.org>, <arm@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] ARM: dts: ti: keystone: Updates for v6.18
Message-ID: <20250916175415.o2zvkxsbiqdk5i7q@almost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ywgrfb7et7qwizn"
Content-Disposition: inline
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--4ywgrfb7et7qwizn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following - PS, my updated keys are available in [1]
if that is needed.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keys=
tone-dt-for-v6.18

for you to fetch changes up to 20b3c9a403ee23e57a7e6bf5370ca438c3cd2e99:

  dt-bindings: arm: Convert ti,keystone to DT schema (2025-08-13 09:46:06 -=
0500)

----------------------------------------------------------------
Keystone2 device tree updates for v6.18

Cosmetic cleanups:
* dt-bindings: Convert ti,keystone to DT schema

----------------------------------------------------------------
Rob Herring (Arm) (1):
      dt-bindings: arm: Convert ti,keystone to DT schema

 .../devicetree/bindings/arm/keystone/keystone.txt  | 42 ------------------=
----
 .../devicetree/bindings/arm/ti/ti,keystone.yaml    | 42 ++++++++++++++++++=
++++
 2 files changed, 42 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/arm/ti/ti,keystone.ya=
ml

[1] https://keys.openpgp.org/search?q=3DF8A2869354EB823217A31A34DDB5849D173=
6249D
    or https://lore.kernel.org/keys/20250916155707.gyyy5tiu4swqlwwo@gecko/
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D
https://ti.com/opensource

--4ywgrfb7et7qwizn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmjJpD4ACgkQ3bWEnRc2
JJ3Jqg/7BalXAgx7+4UNVUWYJv6eCx9yHWT1qQFFcUccSyc4C+R6w9PRH9fCs4yP
0MN+VF9IWzQBaFSRT5CVOl7ZfTPruxB6EPC5NWjRVI/vsCIn4Xu+0N6Qerpv7FRY
IpFkxQGomKZfo/zQvuTN+l1zilhwRVYS7FU4CHzJgB25h3AkR52NwpQ8M1mOJ7IL
G5kfkNVrZm4w1XRwq8+9mdtcldtfWQzqrpHaWynX+ZyE3c7Wwgu7airEHp1U0Qrq
XPTlQZx+pJ/i+VvoMGHzNVCoGSXZjLQlXDYYas7pMv35PpA6+Yjsvj/uKgp3Niti
HM/b+RyawuPgYh5kevXKsW6RBskxZStUvJrmk9SBXFgaMtOaDSHSmXVlqzEesTcb
WADMMjAH/NJNyaV9nEppMsQtSfTfbuudwcySqB/Qx2Q0h+KE92Zxv51zuNzXeREh
cnA/KMNuQLt3GVtsf1L5KCRl78Iu+X99/UsyvpRE6FiRCS5YlZNNBZgI1IZ92X4p
5LQ6f6v6jHP73YwXJIcnGtMJ3UGE6jSdknp4cYssKs6c5N4u95UcJ2Q+dvhjV3hp
ZtopmGLmUeBzmzyEMsIa0jZMd9y4Lx4TQCdfo3AzcYzNAsfv/5bG1tyOLV/5hGsH
Kugh9mKbubQJFXXjR41jG2xb7shFZ9dzL74qZzBD3IoN0dafXds=
=3ndw
-----END PGP SIGNATURE-----

--4ywgrfb7et7qwizn--

