Return-Path: <linux-kernel+bounces-613422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CEA95C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 04:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A68D164170
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 02:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F9C1519A7;
	Tue, 22 Apr 2025 02:41:42 +0000 (UTC)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712E347A2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289702; cv=none; b=BdO4sUaBdFgZjce/AljhNgxIzJ6nAK0LLLJwtAa+dCD9+CyMWWNfbq8Kz9e6sgbTLkYeLfPpJ159tcqdi0NTSIUvY/u9IXHk7PUPm1v/S6R4iHrBPFfP93x+4K+PqmpFwivoEBtVqqdupNvC9cXloJqs/ebdW143iJSkmztfaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289702; c=relaxed/simple;
	bh=S5ZUK07EsukMBHfpg0440asIguDijC68crG+9cB3/rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DRj6UOK8D/zv/8mYFqCPDur2iAErZn2Fu8V7K0tof4vnaCW/jasDKIDv1dMOWjQ/cVE8K/tqg9ali6jKVgRLgfS8jv798DpmKSK9/vxEE0/ee1hN+sS3uUdwdEUkiZJd0eTWctAqJtCGpAnGGlH85LXlaAgIom6pfjLabpfGR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 21 Apr 2025 22:41:33 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Horia =?utf-8?Q?Geant=EF=BF=BD~C?= <horia.geanta@nxp.com>, 
	Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] caamalg: Make use of dev_*() instead of pr_*()
Message-ID: <2025042122-infrared-bumblebee-b2d3dc@boujee-and-buff>
Mail-Followup-To: linux-crypto@vger.kernel.org, 
	Horia =?utf-8?Q?Geant=EF=BF=BD~C?= <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
	Gaurav Jain <gaurav.jain@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xah4jqu6xngy66gh"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--xah4jqu6xngy66gh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] caamalg: Make use of dev_*() instead of pr_*()
MIME-Version: 1.0

It's nice when messages line up with the device, and easy to implement
since it's already available in the functions.

Signed-off-by: Ben Collins <bcollins@kernel.org>
Cc: "Horia Geant=C4=83" <horia.geanta@nxp.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/caamalg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 2cfb1b8d8c7cf..d964a62ef9668 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -3633,7 +3633,7 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 		fallback =3D crypto_alloc_skcipher(tfm_name, 0,
 						 CRYPTO_ALG_NEED_FALLBACK);
 		if (IS_ERR(fallback)) {
-			pr_err("Failed to allocate %s fallback: %ld\n",
+			dev_err(ctx->jrdev, "Failed to allocate %s fallback: %ld\n",
 			       tfm_name, PTR_ERR(fallback));
 			return PTR_ERR(fallback);
 		}
@@ -3814,8 +3814,8 @@ int caam_algapi_init(struct device *ctrldev)
=20
 		err =3D crypto_engine_register_skcipher(&t_alg->skcipher);
 		if (err) {
-			pr_warn("%s alg registration failed\n",
-				t_alg->skcipher.base.base.cra_driver_name);
+			dev_warn(ctrldev, "%s alg registration failed\n",
+				 t_alg->skcipher.base.base.cra_driver_name);
 			continue;
 		}
=20
@@ -3866,8 +3866,8 @@ int caam_algapi_init(struct device *ctrldev)
=20
 		err =3D crypto_engine_register_aead(&t_alg->aead);
 		if (err) {
-			pr_warn("%s alg registration failed\n",
-				t_alg->aead.base.base.cra_driver_name);
+			dev_warn(ctrldev, "%s alg registration failed\n",
+				 t_alg->aead.base.base.cra_driver_name);
 			continue;
 		}
=20
@@ -3876,7 +3876,7 @@ int caam_algapi_init(struct device *ctrldev)
 	}
=20
 	if (registered)
-		pr_info("caam algorithms registered in /proc/crypto\n");
+		dev_info(ctrldev, "caam algorithms registered in /proc/crypto\n");
=20
 	return err;
 }
--=20
2.49.0


--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--xah4jqu6xngy66gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgHAd0ACgkQXVpXxyQr
Is+PHxAAkuVmbjiT6BXdT+UMBepVdhR/hu7gz6u/s/7FhvdH41O9qXLJNLDnT90q
lN2Z/oWVFyi9l2dN+YNtfWOP0EJn2seq6oTjN/ngQEBv1WU0dUgPS5LoDnFmfIGo
001Mh7h5YLZPApUfmE14z3FwV7tFCrbo+OJFaNNk1uCIkkA2jDugRmiCsNhFwEgQ
kX0NCRTTUyVT0Pi2pB5BKGBdk403UwdSlOvEWQjBASdVG7TVtQ1XTvuUsjHavja5
Hf6BWb8uvJFKp4MrsrQ5ms8DRa2edb8Q8kM5AkVC8T+nu/ulxml7rz3mvefpNExk
B9ZxDsTvF4kJWyIiZjNSAyDjB8vllPdZZWEzb9UJxcS3u+NVwSOKbut/jFgfI8j8
dJYQ1bCUj3NDOG9uywi3RGpS+Go+K9Bz9IMBrott8Ee7gIhQz1dpwwtZz7ej3Yoo
ky1DQqL0vtppSyvO0nPm86Mq4woI61j/dnvQdJm9rn7N7UFUKuhw188V3xl8X8aY
sWcos5aVMdMQyZsfR2IkZhFAhdOKfgvzeND/bMoR6ZhmPJpwp5sAj90QOp0ZQyJt
63+5cGxv5M/VFAjvZTEqPwbsliRjh8tilgQHPByrrUqGIg0hM1A873IsAfPqAQLA
hQLiO1vXpdnoG0JPgE+Jxpk3Xb8xCcbLLyPo0+ZotVzEB2UYwvw=
=8BB9
-----END PGP SIGNATURE-----

--xah4jqu6xngy66gh--

