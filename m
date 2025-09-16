Return-Path: <linux-kernel+bounces-819388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6FBB59FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37C24671F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BDF27990C;
	Tue, 16 Sep 2025 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nmcjTU3B"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8626657D;
	Tue, 16 Sep 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045297; cv=none; b=fd6shaRNM7qJceSRqEJIoJiEVGSKgbe9M/s1WBu498J3kjikGlWdU7NwS1sTIUn8KLCTaAtNHJBpFBMmcHrTLrs9E57st7Dnh8czPS9Abg03DzvGHDkBI/omNlKuXhgZAU9ZqXrVyYqhrsbQPrgEHH5HekYRQnP1aE/o6Rbm7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045297; c=relaxed/simple;
	bh=IGIoVf/htYaNLahqpaN1mMKe4VOIY+cuCnl9kdntRqQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BV4XHWy4nyocVC5qDZnvBTX1L047SRnmgrYfCcOr/maIVJNHEuqLxOMNMTAM7+ynPUMuxGalF12d67zwVc12DHa1HVj6uz3ApfSuvUGC9Y7Doy+3dGel5eyClJN3YrVIGCswJeFOVQExGlxz99t06j0UyzwYw5dYjeoTWoyRY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nmcjTU3B; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GHsfOq1422194;
	Tue, 16 Sep 2025 12:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758045281;
	bh=CRXwPuz/NhaSoWFa7GAAxsUPAsedTFcjoey/0ALnry4=;
	h=Date:From:To:CC:Subject;
	b=nmcjTU3BS8/SUDGlEU1E8SXbYGXkqXR5y4eayT1pziueEjhKCNgXTyQHQQMENJ6ea
	 fJOKutd3Zu2XE/KnaMfzLbQZizDBZD/E3UmtnJr8Lg1txEtQoZr8+0fjbc1VcmEQ+Q
	 u2AaT8ZUvF4kCbH7+2oG9aNZWXqeF4YnSRuwd8dM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GHsfHU148743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 12:54:41 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 12:54:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 12:54:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GHsfd61997140;
	Tue, 16 Sep 2025 12:54:41 -0500
Date: Tue, 16 Sep 2025 12:54:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, SoC list <soc@lists.linux.dev>
CC: SoC <soc@kernel.org>, <arm@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] soc: ti: Driver updates for v6.18
Message-ID: <20250916175441.iehltsk2377rg5c6@alike>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="onodo5ysbkjttlvm"
Content-Disposition: inline
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--onodo5ysbkjttlvm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull the following - PS, my updated keys are available in [1]
if that is needed.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.18

for you to fetch changes up to 037e496038f6e4cfb3642a0ffc2db19838d564dd:

  soc: ti: k3-socinfo: Add information for AM62L SR1.1 (2025-09-12 09:42:44=
 +0530)

----------------------------------------------------------------
TI SoC driver updates for v6.18

- ti_sci: Add support for abort handling of entry to Low Power Mode
- k3-socinfo: Add decode for AM62L SR1.1 silicon revision
- pruss: Replace usage of %pK in printk with safer %p formatting

----------------------------------------------------------------
Bryan Brattlof (1):
      soc: ti: k3-socinfo: Add information for AM62L SR1.1

Kendall Willis (1):
      firmware: ti_sci: Enable abort handling of entry to LPM

Thomas Wei=DFschuh (1):
      soc: ti: pruss: don't use %pK through printk

 drivers/firmware/ti_sci.c   | 57 +++++++++++++++++++++++++++++++++++++++++=
++--
 drivers/firmware/ti_sci.h   |  3 +++
 drivers/soc/ti/k3-socinfo.c | 10 ++++++++
 drivers/soc/ti/pruss.c      |  2 +-
 4 files changed, 69 insertions(+), 3 deletions(-)

[1] https://keys.openpgp.org/search?q=3DF8A2869354EB823217A31A34DDB5849D173=
6249D
    or https://lore.kernel.org/keys/20250916155707.gyyy5tiu4swqlwwo@gecko/
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D
https://ti.com/opensource

--onodo5ysbkjttlvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmjJpFkACgkQ3bWEnRc2
JJ0czg//XkBISt/S5WiVy4yfPRuPoJrQd98Ppq7oaiAyOFlKwNgpNd2t759zFIdp
JTM9Yr2LEBbbwwMTOBZ7ImSsK5xUfBd+4k12RcNuiXhEjqwdHj60McU+d28JiqTM
WSuutCeCGa0LO+R9OHZiF9pbLbOgCCd8wZ1jClKrsR3OfrQdoRnLL4jjox/EJCcu
rI5ZOoxHjJh8LmhwHR41a2PkKdXKjjtSY1nU2rs8Awohxnd88Wxs3gC/3edngvzH
CiRQmUWC5iImRZbOm192AlMufETGoCNh1j9VQ2WgkIkec3kS8g7RwglfEST09PXA
NZLDoH9e9PdytM0i6uUhqXl0jAqAyXGcf1MBcory6vYnoeZlK5FAuNQRUpGvUeEx
+NtP0s4EB+ezOVscxf325nU5PqRSAuZzMDxtTZVXhGJnhlaCvHUTrEr3S2hQETfi
jCT64Z700gr/vOgclVvi7ulmxf/nKyD4rsYvOKH3T7AJ1NvKLY2IS1rQB9mJmYQ/
+MXuwKpK+ib7UbA6BjoduEYUqYfPeU5Ug8ykuUhlLxg1Ur5ndlA6TndoBMECM/3s
S0DEJtI5fWM04TIhLahFjebJFFia354wF1Bn2LQscXsc8kyjw6ViIEWpy1FkECaM
Lb41zk1mPS57qNlj1+9w50VyzLqAMrOQNKa4vRVeoDevZgnEiyY=
=dX79
-----END PGP SIGNATURE-----

--onodo5ysbkjttlvm--

