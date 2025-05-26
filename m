Return-Path: <linux-kernel+bounces-662362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC0AC397C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 07:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914EB1893790
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF41C861D;
	Mon, 26 May 2025 05:59:28 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A9189B80
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239168; cv=none; b=c4DBjBX1/nfNmKkEJ4hR1SHRt3FGlXnkTC/Eu4nohmBJ5N7/lGC5Zsd3fxYkPYLfYUVYeKZpi9ez99K6CTHLpRTewnpMpZKOHun/+BjiVkqR4i/vqgxzcoBpH/TwKASXOaek+IiTq9LCL0RqeHmIpq9R9MC7nuDhfS6erAy1HyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239168; c=relaxed/simple;
	bh=amVhOvtnVUkPexUHLNKgBsdD5EQGhZS6THqccPnBV6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3lIPLj9DzsIwF1JgIJ+8uVtV5GT+ZaaCYbaNxtfE9bypn0slLQVpSlLk79UjP3dXcqZo3PCpRUjEy5eYbk6pOb4/6ApZuEQKq/XQff0AL3HiyAQb4qGdz6dIV0c7+FgRJ607ZwkJTFu4cqZYvXtVUVTfZZXisgXj43y2j+3igs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id ADE455F7EC;
	Mon, 26 May 2025 07:59:17 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@kernel.org>
Subject:
 Re: [PATCH 6/6] iommu: make inclusion of iommufd directory conditional
Date: Mon, 26 May 2025 07:59:11 +0200
Message-ID: <2783720.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <aCc0-ClDbiUpNUgh@8bytes.org>
References:
 <1926170.CQOukoFCf9@devpool92.emlix.com>
 <5568089.Sb9uPGUboI@devpool92.emlix.com> <aCc0-ClDbiUpNUgh@8bytes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12672725.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart12672725.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>
Date: Mon, 26 May 2025 07:59:11 +0200
Message-ID: <2783720.mvXUDI8C0e@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <aCc0-ClDbiUpNUgh@8bytes.org>
MIME-Version: 1.0

On Freitag, 16. Mai 2025 14:52:08 Mitteleurop=C3=A4ische Sommerzeit Joerg R=
oedel=20
wrote:
> On Mon, May 12, 2025 at 03:15:52PM +0200, Rolf Eike Beer wrote:
> > Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the who=
le
> > directory can depend on that switch as well.
> >=20
> > Fixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and
> > makefiles") Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Had to remove this patch from the branch as it caused compile breakage
> with allmodconfig builds.

Given Arnds fix for smmuv3 this patch may work when the last part in iommuf=
d/
Makefile is omitted.

Regards,

Eike
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
--nextPart12672725.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCaDQDLwAKCRCr5FH7Xu2t
/PBLA/wJ/Ca4MJ2EAMowthdtYhMont3fj2J1QrmuqF6ygKe5KCtblj3s7otozgAw
6CklNpQHha31GfLwQz314OEbrXZfPJM++MRmkOcryxgJ9Rn3UWLfAPyP8GN9o3h0
JUr50iQaWSsacSa78sLhtevmydrfFltVEDJUFWxBHtDNMndDGA==
=5oq1
-----END PGP SIGNATURE-----

--nextPart12672725.O9o76ZdvQC--




