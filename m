Return-Path: <linux-kernel+bounces-800046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72CEB432C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7085517285C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D512028466D;
	Thu,  4 Sep 2025 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avFzIVsN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78227FB30
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968398; cv=none; b=XY+uTCiq34jq66CBqltQSlphxLi+TCgaHFIeYC8uquqNPsXDVMIjXnvh6Pmt2SAYBluLPPvotYjyMAf5LqmbPU/Ol9pHSH57NTA33xG0QCP0/fjrkCisWkU7Ew8r+ReTXll9HNMsHczER2tfoO6gWri++k0XKKYJVVNu3seBa7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968398; c=relaxed/simple;
	bh=lJSvInSeUQW1SnN8lY1JMpupjUu9RsxmM24J2NhIGfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kcJH4Gjk7Rw//GQmZx2QwKpa06/0IbebJmiFweFwWJRHo5YK8VzO59ta3NJBzBxxbhFoyEusmejudvL2fJhbBzJZTyZIXuhVuc5yqrPETCxC+WN7Y1aB5Q5mNv91qmwLPQZPaoWhGvLFOwTQIjsso6i2GBId4Xy2jSvk0+8bQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avFzIVsN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24b157ba91bso1425255ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756968396; x=1757573196; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2eG0cp/psHFj43Kk8cgZo/jfowPJyGr/xhcWREGoSQ=;
        b=avFzIVsNW6297i5MmcLAph41c43tvwqPiMnHbRSJ9QaxE0u0focJzNMlixvnU00L7j
         MqjkYU4tZuBVgL4LYkpV3Woph5tkzcvFgcdTYln5nt2PdyqXnTIhM/Ic6Ict14zGZ7fV
         ZSK8XtcyOhqTpaqgq3GzDeUNPLqMnQKsxXkNL3uVtVAIfgFtYhsW0g7CmLN6PxOnhvbI
         ZCW3w/8OrZhbAbKzA7M4n+3xfig5rycN9CQHDVRjkI6KQmH8u+aP/AbnKmxfB3AnmiiD
         4TfUk3CucMnQwvSIgIizoufaNIB/s92zGwmYOh55xRlMERNjqooXttvmiRRowUX0vjmK
         HtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968396; x=1757573196;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2eG0cp/psHFj43Kk8cgZo/jfowPJyGr/xhcWREGoSQ=;
        b=fjCc/AHB0RAZQwwfWLCwF9j+GM75hVybQ8slbhxREArd1gfSSAlMVzKZcYyggCczMA
         DgpBxdwizbZNIlVs/+VDEleWr/2ps8EAWHY4s4cxVVgrSyS4g3abUIdW2cBLOYAISptB
         RlSZgp1Q3kyXzZkaGoC4MW57XwC030xb0JmqSf+TsoPYLY02qL9KsdBYGGNBISpN3VS7
         l+wrLgfJGDOSkFTTuB8MuUC0VqaPzNslZO1DK2hxioyhf4h97To3TkkNSycRqklBbptR
         Favkw/NaWmDVtqgRuEMpTAvSn3jBQ+DZBtt/xBd8ntebzfAIVXlT5MnxK34RlHcqlP8A
         L97Q==
X-Gm-Message-State: AOJu0YxHmcf2fA3fTxApzDTCnbIUj/JlJeKSxWvrkC8e6Zf/ZsTLr47g
	4QvINs93KvowckoLvF15gU3l58LewM/X0odyhCzypqfPJ7L1Sebh2cWHrhOadjX0
X-Gm-Gg: ASbGncvuw9LxQXvrARUxYy4B43ZqI72DW9+i/HJSlBKeBF0q0703bAznRN9DfdGOhoC
	93+7wJy94cy5pu04cYB2SGBnEB7e1Pqx+BLWlvFot1pLLSWXVB8MuimNbUIR6QuQ4kmxy0DKMpU
	9pAZ1EEQO6dsvQpVoK0JrhE52rw0CVbD3WZX8dEDOs+o+xOA9W67kb81n/F7ANEIHCVSLTp3Zek
	/3GLlj4Kdc8zNegurFgOUmBLgTfYUEGa96cWdlKFaNvuSpsP9RtlkVRrlwfWXbz+OhNVR49/byT
	fDC72ZqXYumHZNpZNvkWVOG3IPQB7Zav/8CkZ1Am6/49qA21nsZsiedDcDKwLLiJkeRJghjIsOg
	qfZc1L8YOYdxq+sRmnGpZXS+XFAPI9N4=
X-Google-Smtp-Source: AGHT+IFclv4NiXp9FbGogUUf1GeeupNytVlkU6Odib54NEEYIdfA6qp3hjHR2VZ9Kz6lEd/nz9L/IQ==
X-Received: by 2002:a17:902:db03:b0:246:e1ff:b223 with SMTP id d9443c01a7336-2491f1393cemr154002715ad.6.1756968395591;
        Wed, 03 Sep 2025 23:46:35 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3110sm20635085ad.120.2025.09.03.23.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:46:34 -0700 (PDT)
Date: Wed, 3 Sep 2025 20:46:29 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Kees Cook <kees@kernel.org>, 
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] fork: simplify overcomplicated if conditions
Message-ID: <357638f71edc7f1d9814b1851a64e09a8895bffc.1756968204.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zoii5ckt5ukh55ig"
Content-Disposition: inline


--zoii5ckt5ukh55ig
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] fork: simplify overcomplicated if conditions
MIME-Version: 1.0

Since `((a & (b|c)) =3D=3D (b|c))` is the same thing as `(a & (b|c))`, use
the second version which is simpler.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499dcaa35e..cb49f25e30e69edaa5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1930,14 +1930,14 @@ __latent_entropy struct task_struct *copy_process(
=20
 	/*
 	 * Don't allow sharing the root directory with processes in a different
 	 * namespace
 	 */
-	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) =3D=3D (CLONE_NEWNS|CLONE_FS))
+	if (clone_flags & (CLONE_NEWNS|CLONE_FS))
 		return ERR_PTR(-EINVAL);
=20
-	if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) =3D=3D (CLONE_NEWUSER|CLONE_=
FS))
+	if (clone_flags & (CLONE_NEWUSER|CLONE_FS))
 		return ERR_PTR(-EINVAL);
=20
 	/*
 	 * Thread groups must share signals as well, and detached threads
 	 * can only be started up within the thread group.
--=20
Cheers,
Joey Pabalinas

--zoii5ckt5ukh55ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmi5NcUACgkQqoHu9CTx
owLeNw//RtKFfg6M05Wc2B+EejqcACdFpV7ikpBe/Y0ip72QbXbcqF11LwyZeOCs
W7Utk9hFPb6HekYUI3o2xRMbfWjv5+NyiXUE5SBg4U0xQ7klO6oihnBI5SKyX7Wc
BxgR6Qe/+Rx4oEaE3XSBl0bNAIsQMxSQaYDHPuGzmPKsV0UVpqN4VGWdhPt2H4Ro
ap04G4VjU4Bjx+BQrzNYIwrTS4+end3rp2nYalisYFzWdPdPGxXf8Y5arNM81ZRV
1rWaLz2L5PrqHqIQBjfkxoRsCQGW8xWGZWcf9jcN2E5tC56ouAqojIsV5Q1JtGMi
+1zMLSRVRvCR9h1V9BXbUsS2Qu/xZtJfKDOjdyFgThQdAZqFeh956AAW0CxWwyIT
tNn3dJNa1ZEK82MpRDLhuLjSgjFwahYnKJgF+iXUFwp90+OUK3JhPOdewFfOWKto
O3h2z5PqznRddO4cwSUnsBWfjgLHKpN49X2g7ErKLd6m2xtKGh7H6PaotxomE3Bs
NEmBgdev1ID9i1XUGbjq+oAlAaaMMeIhwtbh6cbFotIlxsKtNWbeWLcZsHWzw8in
MDVx81zbCojqUjCp5fL+FyESAVnQbmG9eMBCRUchZrOUfRSpSExl7h4u/XryAQ1/
dE5VhaHbYE22ui/lDNVUGkAGHY/Vkvwz/XhMXH0msVo4amsB9k0=
=+ZzT
-----END PGP SIGNATURE-----

--zoii5ckt5ukh55ig--

