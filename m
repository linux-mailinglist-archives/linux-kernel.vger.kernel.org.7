Return-Path: <linux-kernel+bounces-819084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCBCB59B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADF22A0E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BAF34166A;
	Tue, 16 Sep 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="axAl4GnC"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502E2D9EFE;
	Tue, 16 Sep 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034776; cv=none; b=gqjp+n6ldLkyEOPu1sj3gSJSBFZXP9Jah2O9IOPrRMkDiETKz2fJuf97n28OUZCwDsEjfi6ELbWSzjR5MOMPuUR3bjyXIWfnzoSh47xRFUjOF4PQC4UuvWpbA1VYpkXvWTB836iqixaCFTYdIWeyS4DWj6SPy/xe4VmLOioxpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034776; c=relaxed/simple;
	bh=Z4yxPByTTztB3sFM24pH2Wpl4V1ijJZSaEJbVYamofs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gLnIeMKm8YC2i7dIU7UJVXvBcnRp6Q3vYBA8TgndGGpaIA7Hl3zzSmHEFTtqIkIHi4PL8gF5lQPwqqgMFX7+0/n2PJFhG2SpDp2Cw2GWSiJ8GrpE8k2MDSpYVMMWm5saIul901/g3Etn203INSZ/UxnM9//UOtnpbk+PaJbAUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=axAl4GnC; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1758034771; x=1758639571; i=christian@heusel.eu;
	bh=DHLESqABxDP34BOvNFzhwzlJxFfjxILjfvStq3LsGmc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=axAl4GnCqeKGQKmHE+t7VkSFUCiOV3CNf4c7X0YQCa4o6PAHFQN5rDBCTYo+DkGn
	 lEBepwBTthJLY4oR91eMt/vtqk17DQzAwG9orvJw6ZrsP7tJ7D9PeaUl9Xal3nJPA
	 kA/UgiZ2oXoP4/GYnIv2bjjI5D9cWQVxNUrOTVJebGyY5vbH1n/gJG0qsOV4ty9nF
	 3k2XImgKHMhj57SDLQOzyXQUcVeOnoSKrHBo4CV52Glf0/PL9LcyAzSRnsTxdE4UD
	 ENR7yI9h5nTpKoYn1JYxOZR0qwLp4MxFMS9BtHBaXitpi43zHjk/UjgYSTI6m21xT
	 eHrzmqdIKovUyRuriA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MqapC-1uccOM0JtI-00gGFn; Tue, 16 Sep 2025 16:45:50 +0200
Date: Tue, 16 Sep 2025 16:45:49 +0200
From: Christian Heusel <christian@heusel.eu>
To: Mark Brown <broonie@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: Build break due to merge commit in linux-next 20250916
Message-ID: <0fee48bb-7411-4414-b4e7-395a8c3d0f6c@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="soqtuarrnej3pntp"
Content-Disposition: inline
X-Provags-ID: V03:K1:KLBvgUOUZ/Tmyex3ihBWRR17/OkITuu5wgiFZAEW9vFLwdCZHi9
 4EuzkApEl62S6yg68f+JRrNULWWuZodNpGFWOLbKeff2xH5EIDdfb6Tj9PoDjoXUkkwH9v5
 Q0QVA+1C5nM/o/b2oIdVqs9JVxiOrgFBEGZh6Ynm5xHACWwwM6AZzisRaTGG/fYv75g/E9E
 BhK+GQmUTXEyAiEU72DUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8oU+DmRmbqo=;8NBUvP4CjAFLkshwMU28MwxMePE
 qjp9fEfdW0ngCKTVITRBXu1eUZDGIFbAJPLMEI+i2jJ5Odg4DcZpK2yTXPjEfiHF5rzInGV8z
 nphcydgnTxbeY4CgSHnm4IMIlZFSJjZ/ogOPyE9nRaQy2W4ody0HjlhCe6WTIJdHCglfMcB+s
 3g3c75rMHsdbZ1vg4b21Q6SVMluwUjaWQhJi1J/DYqpzqFmo49phztEz0QmTRMyXbCsxK3VkQ
 vaZkL7/REs7I3zT6VBhmgsc3+w7cm/NFkA7MN0QuUOdOYHOPsGvelj59BGhXtJUJ+sR5ZQ4ud
 wyGGFMxgPsXhzphXcrhIDAjOm42Jsh8ZpBAyxxKE/yf641tZc/mNFQ/JyD0E96lLKWYXR4iwI
 H2JGCeqyEpLWT6d00M+EbYjZoWASSy86PFI1RiQH73+F5kJScLJTL5nOEFt/gVT0X30OrHlBK
 E7ik6FHIP3Kkt6wlaMmYABeyJoQkxU75nDmapjuHMUvtLeRZE7yIU/xL+Eo2x9rrfnRfeZuGS
 b7nOkQYoK9C0rZbB+tVk2k7yugcMmhYJgvR5wgtN9uUiDjibgk/95jpt5wQOszD2+d16hW3rI
 OLL0I4xFLNR91nUKUfJbiAUSLUXy0KvLiqr03x8fCMFdF1cBaKWY7h/UXAZMqWAJgSMW1G8F2
 EX9FscaefCQX804V1QTu8QFDr5ZOhC3cAye8ES4KOtf2JZZYeHggu70EhpKgOu/h+Aza1wXdn
 80ivs+7HvFBqSfn2m0GTO1+5DUC5WUjQDoA5hhAI469Dg/kCx1q7mHC/nvgo87K+a1km7iLbm
 t4pRevcIitm7opBfd+aZWtTdoeuMdXPk7VosgwEZVJey4mFIyTnYardTL0IBVhMRnn2exA9BA
 ABlJPITqF+BMLljaIsgOYlutjPxA2vhSsPJSHALOVYa0fAoI+um5FJ9+Iw8QGDL27mwGdS2bC
 WGPd66aAmIdR2cDArh5hfqn51TLdzWHKr98x1/dW40aSJWzFYg5CBRIv5ehmg99sAJuFdR4F+
 FloRYu/3DHG3MnWwfCHbHdXDZllaYFZqMO7ajV8SbxkvGQ/HaFo/jloatJs84JeIg5InlptJa
 KVG8+B2EX8w4GsIYFcLHBgNDZ9454bqgswjYTcN+ilYw2Fwngnrue3dyBY9+KCJgWlER+MP5H
 5m0EUpaQhU6CxbRR04mc29BGPOsgrPXJKQL1idu7kgbIiLEv/kaAz4zB4QbL1ykYzwxrxBdpE
 jL2E9JKn6bNWqxLl51iZ2kfNCkReyWfGWsP6S7u0rGc7R/8DI5vZwvQXD+mB9k/XgWAlVuGS0
 MHrvCjHWY02TpiLZ0DunM8yi5Ikpf66WqasGpeZb7ksLVX40sFDeoBITHj8QEndWFvVhIF4G3
 rwNUr+IR/l+CBn3rXdf1UkOOekWGPbqaQxIIkwEUwQcUkotqI7ozGNML8bXh+QOgOcUltSFkw
 26LETixl5Fy+SGZ8QHC1iVEWa81/x6P6wqRC0UZ86N4aigLNXk+MHRrEqlmyhr9OK2nn2ZWVZ
 RU6DyPcTmJdX2OpoieJ+YCPvUN7WLXLvLpPGSadar7YFFqiB44T6Rzyv8HRsjiHfdRStNeLgs
 w7EbsY8WspGh8wlIAqwe5LS3AYuOAiDSNns/Pl0DbFTsFabLbVEYXGA9tNQ1iP3VS4DsZhes4
 SIn1XbdbsqgBBsDfQn/18v7ngfTgkF4nv2KgvJFwcUBkx5Qw98zFJggVUnk1IaZ28B3ESmRJa
 K9/k3kOpY+Q+PMxi5Jgyu1Tz4cgqszxlWLEoe+pFFpq3Bn4MxW9d8nK8=


--soqtuarrnej3pntp
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="oirrfxxu7ldff2jk"
Content-Disposition: inline
Subject: Build break due to merge commit in linux-next 20250916
MIME-Version: 1.0


--oirrfxxu7ldff2jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Mark,

I have noticed that the recent linux-next release fails to build due to
a syntax error in the rust code:

      EXPORTS rust/exports_bindings_generated.h
      RUSTC L rust/kernel.o
    error: expected one of `,` or `}`, found `;`
      --> rust/kernel/block/mq/gen_disk.rs:12:23
       |
    12 |     fmt::{self, Write};
       |                       ^
       |                       |
       |                       expected one of `,` or `}`
       |                       help: missing `,`

    error: aborting due to 1 previous error

    make[2]: *** [rust/Makefile:553: rust/kernel.o] Error 1

It seems like this error was introduced in 6e86e08cdc19 ("Merge branch
'rust-next' of https://github.com/Rust-for-Linux/linux.git") and
introduced with the merge, the attached patch fixes it.

Cheers,
Chris

--oirrfxxu7ldff2jk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="linux-next-20250914-fix-rust-compilation.patch"

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 51a239118ead..1ce815c8cdab 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -9,7 +9,7 @@
     bindings,
     block::mq::{Operations, TagSet},
     error::{self, from_err_ptr, Result},
-    fmt::{self, Write};
+    fmt::{self, Write},
     prelude::*,
     static_lock_class,
     str::NullTerminatedFormatter,

--oirrfxxu7ldff2jk--

--soqtuarrnej3pntp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmjJd/gACgkQwEfU8yi1
JYWhcRAAg9hc0wPAhl6CBaDNZ6Q5WPj9jqXOhYtRJB/OyzY/QEBk7v9tVrG4GXQ7
cfuo+ydiBEYLd1lW2dBBGtvzLuhnrR5JqAe3d5mYgJvf5Fgdk34iy1TUv5pZayBN
wglepAhz2nW075IkA8k4KfvI13NTbTP14dsOkNBv0Tp+s6nGefeNYmG7fetCHpzy
3aVbnSbNmHvTHkWxF7juEovsH9fyecjo6570XCH55jNrsfxJNSUtUMyBIzo7Mk4H
qZp+F3Gxl3UWjO2pamiJEGCw5mXDddQ3QrjrJ4WiNu2tgEd6NkIMaOp6J4hgGjLt
CQ6ditGl8P/96wrugL96VJnyuMTKHJ4+7jkfVfYyLaPQDuM+tFaV6gdy8K3BiI3R
gHvsKQ3aKZ39pZdD0VQlGXlCbRPEVZaiIazVnYjZnxuH+itH3N2I3wSL1o4wZoz7
xnH/vq1FAXsuGY89uCsMU79H64bGeRNaH48inv175N1R1JHJ9UZCfTK/I/e9Lanh
cU1WQD7wbfLt31/sW87Z+C1o9OYK6bTB5PoU7fQf7OEmkJpunvIC8Y3mpfx/+7Xm
jwMyyHa3ZKU4+R+RHK+e7hoo/M9m4vytXLJQMTvt8kgNDw1BWOXHVD2ggpn9fvhe
yZYEbKQxgBJXBrChq8kTZBai4d/+UlMS1KF2W8RLRESFRtQGOB8=
=rJIi
-----END PGP SIGNATURE-----

--soqtuarrnej3pntp--

