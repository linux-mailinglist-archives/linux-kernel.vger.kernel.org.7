Return-Path: <linux-kernel+bounces-803511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB60B46194
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86708188D882
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8536CE1A;
	Fri,  5 Sep 2025 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfUGGSFQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCB3191A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095188; cv=none; b=QgU28UIlclARgtpeUpU94aBSeMbABnMab/0EyX7niMfpVEL9muGNF74VOygPS9ebER+q4FZUjze85AJ4LEtHTEhPner8LkoVvL2s+Mb3LPGcCsf4O/rIAxI1g3djnNFZ/b2PzzFn8N6MYvgfp53oWG2lS2bRyiaPaltUGPL9iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095188; c=relaxed/simple;
	bh=RfocDEQ8STZhmKXIceyp9Y5mY3oqvpHaVGG/fjgE2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fin5hrtcukMiuwBdzqKSW1F70NArYAKYSO/w7Jbd9arqtSu2DC9F/nWdIk0kW1yaJ9QqXUOrAMpqwNdaTS9lXx+qbs+JK4sKydMsKn8AYHjmB89tz2XL1Frrn4qED8I/Pek2lL+qSc20OkFregwXHmGYTvkHTS3emapLCtlVZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfUGGSFQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248f2da72edso3971545ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095187; x=1757699987; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84y7R8L3ryGAm25MZB6b3F+KCKxPwUp8NhRcu5FNuxc=;
        b=cfUGGSFQy1nsCtI4ji1CmvNDY2leQyVjjHHYl9PIti0khlk9RVTEIQK67ASVhaH6+o
         tLKFa7ha8JI9ANdxU9hVKY0Aqan0unZE+nGOR3zALwzBZ7nWNWkzQ1TUFXlfXOFpK3wy
         8YavVc2Q6FIj8O1n9B07ytCxXGs3uoc3IPKHcMT9Wr+DF8tKmCaa3pA/44D8C+psM0uH
         bifoHhYZrkQy/WvrCg9FCPcBDmJ/rbY2e0JuaS2+m+kD0VcbY6pOSWkog8zs+RqUyOKV
         cNKHEw+IyStgDNG6tdS0xRFw8/5QKHgPdfl5ltcOXcZ+eRVoTudGkfgNdl6wR1vU0mxT
         9Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095187; x=1757699987;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84y7R8L3ryGAm25MZB6b3F+KCKxPwUp8NhRcu5FNuxc=;
        b=LOURG/NJcfF/C97AgZ2K9jil1AIzHtf8kjPof0yg61qUvOsxv/nhSCCOBeYZVQI6+g
         6GPyglYT1jkjPJu/uetoPE7BeW9VH49wo+RFa+uCSUsqdQXapNWZHgzNo6B+r8sCGv5y
         quXar/7/rX/Zjn4hsUuJgt9F8zJAJDcjCdUe2X4M7QdasGlg3eMtdTjCmcvw7jZgEgQI
         Grb04+LsU29qUqaXPAe+MmbqWrbHj22Y1P7Yupg/6ER9xFQfDHXlFd+A4BgNxyfO1m05
         ZhSlhv7/6MU4BnyPk0gIuf/hNx5bLwdYgeTL2ahsAiiIWvvbpI3YZ0/cBXG43dF8s4oW
         Ckww==
X-Gm-Message-State: AOJu0YxqUnFh0wAhn7En0Fw8gpn60isxZOLX5xhGiyUaXrzd20fm3ZrJ
	XZjHmgtqH18w/oLgsXCS434V2BtHtCsz1Lgk9yFgKVPRIrjrskf1hwNtzVHwXofB
X-Gm-Gg: ASbGncv5O1Vsyzi6pal0XBsZ3KBdL8SupwMxVK3WFSnoL7kKeXuEgUtyb2ZeUEaAWpB
	VLTN4bdRQVu481Mk+P0ZEEPH6fVIadGdo315qhnq030gAbfmNQ9eRhkl+BAaoBkwXoT1Nni0SvV
	aMqLQ+uG/EZdxTJpKlNXuqEbxOi7cpxMGQY+VNt62V6C0X5N7b/lgRohjJmhaolT9hn6ooZCvWi
	h8bzub2pvgX7q4/ROvf9yzIN1/5X4/AYzhkI8oOI7A2Re1e+nBLmSWJEoX9iOb2ghBnmyitcPoN
	13sVCm7mFyUxEcFptd96o00EQwkzr5qaIWZsX8iZsV7lWa+96g1CpEA8rY0fiZPcU8tmqaahx2g
	pLOnw4oAeRTnBztiSmHQDyyvpx/o6hRgxeV4MFvY=
X-Google-Smtp-Source: AGHT+IHESFFMXTh71CI/es42Dr8DjPo/Aa3p2ZgDqBXH5Extad5drmT9tyWim/aqjTc4tf6ymZ9Sbg==
X-Received: by 2002:a17:902:e74f:b0:246:ed8f:c63e with SMTP id d9443c01a7336-2491be7d2a2mr205510985ad.0.1757095186582;
        Fri, 05 Sep 2025 10:59:46 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:85d:f376:d78:d2b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1ba1718bsm100294495ad.39.2025.09.05.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:59:45 -0700 (PDT)
Date: Fri, 5 Sep 2025 07:59:40 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cdrom: add parentheses around macro arguments
Message-ID: <13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tigtnzjs7psh642r"
Content-Disposition: inline


--tigtnzjs7psh642r
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] cdrom: add parentheses around macro arguments
MIME-Version: 1.0

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 31ba1f8c1f7865dc99..462ee74621da6f32da 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -408,11 +408,11 @@ static int cdrom_get_disc_info(struct cdrom_device_in=
fo *cdi,
  * hack to have the capability flags defined const, while we can still
  * change it here without gcc complaining at every line.
  */
 #define ENSURE(cdo, call, bits)					\
 do {								\
-	if (cdo->call =3D=3D NULL)					\
+	if ((cdo)->(call) =3D=3D NULL)				\
 		WARN_ON_ONCE((cdo)->capability & (bits));	\
 } while (0)
=20
 /*
  * the first prototypes used 0x2c as the page code for the mrw mode page,
--=20
Cheers,
Joey Pabalinas


--tigtnzjs7psh642r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmi7JQwACgkQqoHu9CTx
owI9yxAAmTV43dSlxY58YYVoX+ubwKSKJZINoZH3nwPLqDy7J8ocDlT4rKFFBc5p
qPVo/a7frbEME8I8cvCjaWugnkpX+R8mjgusZJo89R5Av6uMLq5mJGDuwAYWI4B7
K6f/O3wdE/LTYFtHb1liBo0sJZaYSCQ943m2fXT/wPWFeK33of13jpkz+RenYdOJ
OI0yEcPQXV4YKRZ9hDNtNJ+QTQANizVXGNxAzlFNzWaULzOufwzOGmrvVhwCkryO
LKlNcVwG208MEnB8iQQAkxk2aG2WBfClU8Zq6AgdAMn5Vw3ANrKvckBq0ZfcOiAz
Upx5RCIs8GETEHQeoVi24NvfnphWdTm4T9x5hh/Zo5e3C3tTl3iliTxKr+v8bjWd
OkGpq/9u9Nm7mbA2o6/Dlt+fU4kfqqXmBzQzzd0LlLBKbq5s1VFYhYNY4C2ipOaJ
NsSIhguDx1YV5Mj0A/I9lXON5zgDdUPWa1PhDOo3+yd2YBHLrgGHBgofF0ISj1Zw
bc+EtieJ2lVW68pJonYWLUbjh+881ySGWxrHVDsk9KWq0M9pv+oP38kt5ywMtoqA
fAZuK6Jj8hsEL1dh2QGq3BTuJrNPXkOyKcD6XFmNW2TbWn+F8rkbpr3milzZC5tX
Ey7m+mIY5gkDN9GIJAnNJ2Ce6j2OoABrQwkBdOPLg1iMoRirfBg=
=DISJ
-----END PGP SIGNATURE-----

--tigtnzjs7psh642r--

