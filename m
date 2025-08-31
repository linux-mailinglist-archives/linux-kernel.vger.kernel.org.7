Return-Path: <linux-kernel+bounces-793375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0C3B3D29C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE28F7AE947
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F80254AFF;
	Sun, 31 Aug 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmhAPzRJ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA501E5718
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756640887; cv=none; b=IWe1qsDLaYfwFKYLiCBOuAjjHsx3P7Ii3FJFYuWueFStyb51shArXiV9o4DjGhEmwEALJd+nfqix2X5kXZ2Ts+FjP/J4iQhBDWK0HYnBthzK8VuDEDHEqVhjAPDZc1WPclctJpTfGyRJvhb2zlKaYKGO9XBixRWwq7LOV6O/pGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756640887; c=relaxed/simple;
	bh=VZ4sx+3TlkqzAyMbi9nFoe6b+vLSLfxoKimuGbCa1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g6ROjmCXjc9VRwA8vHW5WuatrRfSxfa1U59y6F+J8AyV/QCsdBcmOx1fJlAGE+cQ+1eDl6QnyBbGX322aEOMgpBR0SQDn5BjXmZg402ekLcaIRwftTxq+asu5mCWiMczoi/8lpU77kry2bishLm8rpfKdOXC2hCoATynZMNUNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmhAPzRJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b471751142aso242487a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640884; x=1757245684; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSoKCF0SZqjJfRcA1SFPyaO+CBXZboXgWGfawPD3X2k=;
        b=MmhAPzRJeM6VFZKy1TqFmQlyXFJnPMKWwdxY02HQkqRgtaDaTc2xKh1znD+jxXRsoA
         FZeVNk6Jms5wfrpKkXzRQH/ywbBXBnsyzMFvIL00pxyYYVYmUPRkfzNHvSyiJL8Msupt
         EkRI7FhYObk7iStzd7UmG7lprPvIgDiHgXICrmlLINrEvhiOtFgAZG5tGtZ1+pZJd7Yd
         4W/UYN9KS6DEtNt47/Or7BWYlte+STARKL6TNJFO309mNOOsAN8LYBmdRNdQfR4Rsc4X
         DoLJDoGtnB37aK6ErULKU5s5/yTkUmKqZ3/nv0cKJ1thng+cBDzz4sm63x0EhGa/ZTvS
         vDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640884; x=1757245684;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSoKCF0SZqjJfRcA1SFPyaO+CBXZboXgWGfawPD3X2k=;
        b=hc9628x8OXK2jcimDflakEPTfxt6aBVIU03zxuwvpN480shbFVFYojlUTSGymqCkBk
         XjOGuQRmL2Y2fmsrxl+H2gYWoRDQK9WDKH12lF//5GG/C9vs1QEBOj/11Zkkw3JwkQkP
         EFpAv1JUbChmtqdPkcYv7vKAMoV9DEn3YNqSdfLyof7nuuBY2o6kS9Y8mg6+S3BlDwQB
         818iZlFkGrKs0uBWvfvijJas5UlsFP6gDbIm0mfulHElDNE98G2q2IFfEXKciyuhbHuU
         Yz2wk1Fx+Elxc0crSbXgNojI9e0+UDEtky9KnJGJOutn7A0hPK+M/6YdxyA95++K+TsV
         5Ykw==
X-Gm-Message-State: AOJu0YyxkFAebq8/+ngZgrjChA8Nqu3mKJF1wfaVmbfvhNFgCEK2btzs
	fYDKqjTfzHTKDJd9AU/koJMI5sNduh/+n9GIOg3CC3AKLiID+xBsybfnA/BUPPqU
X-Gm-Gg: ASbGnct44OdMsG8fFNxC11KewqnOmcCmEZTIXC792ncrukyuNa0dm5BK70N76NHhw87
	Z3FF2PpsGmIZSTpXW7Eza40FRvBO0IgBXpp5mHrBXQSu5Yg9IUPFnZPY/MmEObVsHde2teJnI3/
	915DzpM/edtD2GoNudfyEb7XhJdO0gstnJo5gnxDa+puGoAmZ7mqkNRom7sS4t+F7io8IN2JcGf
	lDfErwTxYUxnRdLLBqE3D7wkfWl7hzSwhTgz9cbzhQ4De0vt42Nunk4VlR2af6j0AU3kCA9Mi85
	nG/WqUBWS50ioH5e5ym0v8izbSUg84fEp7FDHNMHOwF/eddHKuQ7DnKf/1+VCOJuBo+vveZL3sh
	KA9usrGNTYyxDbzLTTQ5Z
X-Google-Smtp-Source: AGHT+IH62/20/Entu4gjWsxdTIxzmN4nnDjHbbkoLQtOwmMjD1ns2mqqyO4tNds0HUeN+Mr8+6v0FQ==
X-Received: by 2002:a05:6a00:1889:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-7723284e978mr4418411b3a.4.1756640884190;
        Sun, 31 Aug 2025 04:48:04 -0700 (PDT)
Received: from hobbes ([2600:70ff:f833:0:8e07:c9e8:902c:6ffa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d7c42sm7636432b3a.39.2025.08.31.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:48:02 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:47:48 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] mm/memfd: remove redundant casts
Message-ID: <efbbe6093b64a5b19f974871d5262d6e75dff2c0.1756639225.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a4oqctm6juezf3de"
Content-Disposition: inline


--a4oqctm6juezf3de
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] mm/memfd: remove redundant casts
MIME-Version: 1.0

MFD_ALL_FLAGS is already an unsigned int. Remove redundant casts to
unsigned int.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
---
 mm/memfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index bbe679895ef6a191ba..1d109c1acf211b3c3c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -383,15 +383,15 @@ int memfd_check_seals_mmap(struct file *file, vm_flag=
s_t *vm_flags_ptr)
 static int sanitize_flags(unsigned int *flags_ptr)
 {
 	unsigned int flags =3D *flags_ptr;
=20
 	if (!(flags & MFD_HUGETLB)) {
-		if (flags & ~(unsigned int)MFD_ALL_FLAGS)
+		if (flags & ~MFD_ALL_FLAGS)
 			return -EINVAL;
 	} else {
 		/* Allow huge page size encoding in flags. */
-		if (flags & ~(unsigned int)(MFD_ALL_FLAGS |
+		if (flags & ~(MFD_ALL_FLAGS |
 				(MFD_HUGE_MASK << MFD_HUGE_SHIFT)))
 			return -EINVAL;
 	}
=20
 	/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
--=20
Cheers,
Joey Pabalinas


--a4oqctm6juezf3de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEx6b1SGGPTKxTmPDYqoHu9CTxowIFAmi0NmQACgkQqoHu9CTx
owInvBAAqC1a16w2WsJa7SqEebfyH0+msptOthtlyU2r57KCN4hj8vZiM0nB+3Qg
fQTCPrKqPXXs+0MMghYutj5+KPOfyAQHoXs92ECgSIh5norP6KdeyLpbpzjH+wGq
+ltBFbY/kL7SbEV28DqD6MGEAGHmy38Z1P09leLtzG5i8vcRQyq0zZXvqaf7lxAu
c+l8u1whxEqlYAh7r2WumkG1MiFidgg5kotLhGgGz4Se4wIISg+Jx0F2qrZIAjD4
KvJz5xmJXRoTyRRdOBxD50UuoCfZORFD3Veh74qwbYukd5RzTl0XeWhAgRPZxtFa
0vlz21zJIO+Uhu259sBP9XGmNFnsjavj6/vCgB+1Nl7BjXe0LyW6XbA6jBxa15dO
VhvH3CcQ1JnZE+4e9wMzesizhvhifFBYHdsILnNboXnTGvwwNWh2bt3SGfzureJk
hGc8ViTbIsSn/F3yM5yPKDAmoD0yj4z+IU92BOMaQAWBYDLXx7HMXxbS03S+gtt7
XBjkgFdL3EOmFc5CMD8lmWJN/RTn6zUvnpC2aF2Jis3N8nsZVyEbTPjAQyj2rpVF
QCAcOwHJ8mrsBzQpc70M9VwebZ9p4xs2Dl+5SLaHV3AXqGRKamXC8+yG2+gHKaai
OVZBPW7mW2LZ9TGvoRL++zBZZGNQ9WdAPHfmZs5U6M5RTtYyTnI=
=EyiD
-----END PGP SIGNATURE-----

--a4oqctm6juezf3de--

