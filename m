Return-Path: <linux-kernel+bounces-644199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E751AB384B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9280817F224
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED32957AA;
	Mon, 12 May 2025 13:17:08 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172629552E
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055827; cv=none; b=PIzVqr5o0eU2J5xwMRp3EcRDErlITUqzPVnYJfyTL/HpNtRXSQaGICH8jFjT5jFsxNni5vRfXwQLQQgpMrHgXSlwaLCmXfQJBWIksYHgDRQqsHjgL3Dvc1y4s5n5yGv5coxM836Q4SL620Jv1N0eOixpaBUiAcHlgba2YOB+aIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055827; c=relaxed/simple;
	bh=qyGlqeoaX018wK20EkYJAUZufA8oVkUeenZJQTWOTzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2S3HBh+47k2bO9+G4yCieOehU6eGiw5vULeu5sIgPfbVgGJ7Nr6M1SgL5PPClVJcwNpyb+ZTz9cVAtYnc4SgpLZ+/Vzg1lCRbGHAR7mfVd1XJKFOwy6s9ivFdmSNOk9O9n0xYMsp8qrJtQYikfmnF2y6BbPkWocz3mx5TaOFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 10ECB5FE9E;
	Mon, 12 May 2025 15:16:17 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCHv3 0/6] make vendor specific subdirectory inclusion conditional
Date: Mon, 12 May 2025 15:07:27 +0200
Message-ID: <1926170.CQOukoFCf9@devpool92.emlix.com>
Organization: emlix GmbH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23936481.6Emhk5qWAg";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart23936481.6Emhk5qWAg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Date: Mon, 12 May 2025 15:07:27 +0200
Message-ID: <1926170.CQOukoFCf9@devpool92.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

I found it strange that the vendor specific subdirectories were uncondition=
ally=20
added. Everything in these directories obviously depends on the specific Kc=
onfig=20
option. This series cleans this up by making the directory itself depend on=
=20
the respective option which looks more natural to me.

I must confess that I am too lazy to find a good solution for the "arm/"=20
directory, so I left it as is.

Regards,

Eike

=2D--
Changes in v3:
=2D added Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
=2D rebased on top of 2e9b2ee2ba403cbe270a8256b8794ef5ad19b38d

Changes in v2:
=2D clean up subdirectory Makefiles to use obj-y now
=2D add arm/arm-smmu-v3 and iommufd patches
=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner
--nextPart23936481.6Emhk5qWAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaCHyjwAKCRCr5FH7Xu2t
/NGvBACQ++ncU9h70pXINUzTwksmp8QYS7bw5uht6BV/o0aqHCaFisMsBu5xsT/N
Q6AEn+ablK7oufZX2TqX8jKVZlPoEZYW6SEebCOytttzFqk/EFtoCNvLO66wISBe
vPSrcpiktcbYyuPMd9/rsvKiEkvYwwrY/Hs4eYWkS+DU6ppKRA==
=7yC0
-----END PGP SIGNATURE-----

--nextPart23936481.6Emhk5qWAg--




