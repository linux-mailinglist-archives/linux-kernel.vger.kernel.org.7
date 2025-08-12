Return-Path: <linux-kernel+bounces-764655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98BEB225A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9ADB3BAA05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C22ECE8A;
	Tue, 12 Aug 2025 11:13:12 +0000 (UTC)
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9A2EAD15
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997191; cv=none; b=bmZQT8QKIrNltTfYpuJ5MRYqltZb1y6D6MknMp/TSD53TPgUjYYpMmntnFmk6YYIDBVrXsPaGaK5UGsCA1c851GS9KXeQKaV3pkV/gvAXiq3WGv7GCf+Hesdr/iB8eTlACqWcGLM8193qVUTQ+ICxmBkU/rIWX+fgt54+zwxI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997191; c=relaxed/simple;
	bh=0OTulO0TrVaj/t5LScgyrH005tzhIUqyO+zSODJfLVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bEw47C4RtNF+Ba8njHloe02+AEJWR2AVGXeaCBfXNIB1Tve9b8nCZhHwDtnii1HeZJYvscFJkKKFiwBxRGOqN8GeP81qg+Ri2M8GNHxVh37Mruufh66xdjCEfnfyWx7rZiiXnv2FYG66PML73L7JDFl0/NFJ/C5/ChPNF1ux8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 07:12:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@anaog.com>, 
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH] iio: iio_format_list() should set stride=1 for IIO_VAL_CHAR
Message-ID: <vidvwybkm3vwmtopihyaj6tlvswwa5ixmgptfzpk5ujl2ixjjb@olz6275ftabs>
Mail-Followup-To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@anaog.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vdu2yj32lit53a2q"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


--vdu2yj32lit53a2q
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] iio: iio_format_list() should set stride=1 for IIO_VAL_CHAR
MIME-Version: 1.0

iio_format_list() sets a stride across the val array of 1 for INT
type, and 2 for all others. Add IIO_VAL_CHAR so it also gets a
stride of 1 assuming val is an array of integers with char type
values.

No drivers currently use this, but I found this issue adding an
avail callback for IIO_INFO_THERMOCOUPLE_TYPE for a driver I'm
working on.

Signed-off-by: Ben Collins <bcollins@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno S=E1 <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>

---
 drivers/iio/industrialio-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-cor=
e.c
index 159d6c5ca3cec..eb6a54f8115de 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -790,6 +790,7 @@ static ssize_t iio_format_list(char *buf, const int *va=
ls, int type, int length,
=20
 	switch (type) {
 	case IIO_VAL_INT:
+	case IIO_VAL_CHAR:
 		stride =3D 1;
 		break;
 	default:
--=20
2.50.1

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--vdu2yj32lit53a2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmibIboACgkQXVpXxyQr
Is9KFRAArz2LNaIYXkr3/HgyJk78e924E3WyQ1bjODM/Qc2z7+vJ0PI0o3Ea57Ft
3bVRzIqyHR8yQ3xBQbI56vrsqd4W80ybnMfk/4ZGSlh+ffBKp0kkWknqxaJIz3S7
3XCWAFsC1OQgunxumyTaz8QCJxChD5p4aOyJXo+U+Eo1za3Xo014A0x5R+5JiM4s
a8jRq9QxaN/oxkfZoOV8S5Rvrys5pF215qbqlX4qRXgkjL6KzhGOurY4JUylNXIi
YqiGoWNSXh9qiy3BaiFE3kJzhUfGdhp1GYDv9F0rPyy6DWiJRYp4nIFSBLk+NN5r
9E7OORe8boQl9jjtWECp/9c1Gn1LnacC9I+Ty2YYPMLfrXa+72NjG630tzLIBVQD
riHfxJn4JfK71G1LESgnA5UQLIaemigDrFy0I3p0lveie+Fd2g16aCZWwYOPSsOl
zSZhM9KAdVk67q7m8It1stZqz7yQh1ra3LQyp8hbwSMQzOIeeuYPp1Dp+Ad+MG5n
szMGxS5+6kBqNXYOyu2zXfFLNHE6ZR/8k/jkpQeavzZjGiYjPPXD7wnnHBhCe9Ef
38C8CfB+FMz22a+/UYA/TYO1/ggk1BJUTbZ4awdV1KoWDXYfsFSEAX5HXMIv6WaC
ouzPaDSHcnOr5q72A4zysieyVauiVD5PvV41XvH95etr1ikQpjY=
=ebh1
-----END PGP SIGNATURE-----

--vdu2yj32lit53a2q--

