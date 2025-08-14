Return-Path: <linux-kernel+bounces-767745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF4B25889
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4CC727E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051E51E4A4;
	Thu, 14 Aug 2025 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GQZefl78"
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C557D182B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132441; cv=none; b=O2q9ZDNMGOOlpSwn29jnfSrZFIdyr9ETkg1BUOgiC1OidJuSNg+rU93UFgAovLDzT75f6a3qKah/QCSoI89nVxdeC1rTWr9f9dC4nHa4FiPrRCNA/ISzZ1Y6Kb6253YwAAQWEwayy0YEomGJJkcekcvcy8EeHKrKv5I0UAsWfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132441; c=relaxed/simple;
	bh=h6TZNYNdslHx0L36UHuxcqKA4zVzfHXe6M7yqVXVCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RG6jgWi2fQyya2jMBYMBtYbFB67EsMhGRARrJmfNVEky58ioSeoGKFnWjiSyPD6Jh/DDaPJ8GhxTV9xRSL7hWLf6dKFisQ8stA13tSi3gZrCLv4lqVYCY27YgCUNdzJ+DT9OkCztAKUsNBp2pV/VSm3ALQylNrzRY1V56qeKg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GQZefl78; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNgJ7j027255
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=+W1C
	FszVGIZi3P5h7WgbYekgaYS6L9gBwMa5nUeu698=; b=GQZefl78Yy5HEyH/Kuat
	73tqz0UKEstWC/QVBVwKZd1bZBHhRlE+c9QqVt5qfUUjQaAj2RFXbqW4BJwds9SQ
	nepfXcDmSC/LCNmEtKkcBZyXL0ZomqEssu+NII9+eJZtZ/1/30ZrpKoZxD2jHsNI
	3aOGAohKSm452mAyw6fVpcJv7MRvConX0nFhgtzqikYuj3zMvpJUFTFmtlRg5yCf
	whtSiKu9UOBvcK8OyB7lslh7yOdsl8OfmbUo6MVYv1u0brZ2OCg7+2zhSqB+bDrh
	W1+HC6n+H86riYDK55mQ9oHJOaLAsQTf6C5lBmBuOjPwiwRoIKs18ycYEaOg4xIj
	0w==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 48h0dtja8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:47:18 -0400 (EDT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71d60b39826so6508387b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755132438; x=1755737238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W1CFszVGIZi3P5h7WgbYekgaYS6L9gBwMa5nUeu698=;
        b=d/W+erv6PtW/iZoq6qyoy7DJva2CQz3iD6XKTIqovkM9vALbZQNeHscnRkCff/w7FF
         KkiSX6EvN2bExBkkNlEhHhAECkrpyEyBqsaP2RPRQzFYp5t3nW3Fp5VYVMQEX/SccXFn
         5fzJsRvw8k2wZEPUac/lrkefxJU+obGopBzs6E4z/GC3qixeGPD8gs19SfvLkqeHmnCy
         iF1jrHBRZTLzC81dDwN38e9G535bKolYVyoiEwx0v8KUnbq6l4iB9bI6fwXOKt4SXL5m
         GgxVVEYxFDGB0LEy1x+dtYf6ehcJxRFJx2/iP3BfYYvRbmluxDV7yERKed2S8ZInOBuk
         X1lw==
X-Forwarded-Encrypted: i=1; AJvYcCUFRKw1jFDiGJiqiEyw0yUGRQorBd+JzReKuQE3bv3UpwdHaFE77njm3OWrefUNtcyZ2mBFZ8LOr7BB2Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0jSa9uPQvTzJONVncoqU5BWYpvTngIuamsW1hXPIYUZTkH6h
	GlJr6qx33jD4Aq1fDWE6zLHuWCFRzWehjD9BXCp7uO/alnreJrYckmpfCI/fxf/WZZI10z9jcjV
	hX/F9YCtRyQZD8O+vs/FJbTHKsMxTbdL/vR5h9dQinlnhcU1DoUEAg20dS9WtNSWZKQR5uuVP4N
	xrY5JER4vGfPtMJjIvcWUAXckzlXZOwHKumr4G
X-Gm-Gg: ASbGncsogHILYoe01SWGMSlNM3wOkPLh1IG30g1wZtJ3ixk0Crp9mYS87gUOdE0KjHx
	P+KkKJ3BSAHuy5nogh/ZnAMXXsWllDOZjLzXDMMyvmBs5UniAxTgyxK+MKySyFKH5eLKUhfg9xC
	g+dmJW7ZB4c/yVfjfiy6zS
X-Received: by 2002:a05:690c:48ca:b0:71a:2299:f0d8 with SMTP id 00721157ae682-71d63436ce4mr13895207b3.16.1755132437668;
        Wed, 13 Aug 2025 17:47:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeeYjMmAgiZ7FysL4G/SYNLSiM8yZ29h7XEmQJd9HgHMUKuGSYyn53OrcPwrkmvLyqFM0CBFJxp3Jo4TiwRUU=
X-Received: by 2002:a05:690c:48ca:b0:71a:2299:f0d8 with SMTP id
 00721157ae682-71d63436ce4mr13894937b3.16.1755132437227; Wed, 13 Aug 2025
 17:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-crypto_clean-v1-1-11971b8bf56a@columbia.edu>
In-Reply-To: <20250813-crypto_clean-v1-1-11971b8bf56a@columbia.edu>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 14 Aug 2025 03:47:05 +0300
X-Gm-Features: Ac12FXw3AkDGEST3MJ3X56ZlPppVghiVg3EgvhCnyh2Gy9Ho0QSrXxNEMgFTNaw
Message-ID: <CAKha_srSRA9HftM+zLeRVrONKmPdtm-wTXq3n2NC60Gynuvwyw@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: ensure generated *.S files are removed on
 make clean
To: Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAwMyBTYWx0ZWRfXxyaWTY7xNCF/
 qDyMBh18flE4+WJzmuA8P8zxpcaDwBtr2FEn0grARDx1goTFQJpXu0Wk5rJIECOgibWoXGEJVRR
 r1bxaRbpUXPlZxDGE2yFaf9PtefISdh743FlBh/cEsStSSK0wlx/B1QCGMmjlal5cXa0cZppKih
 xD0NYS10CQCb6P2KlrhkLLw7Lo9aQPdxDFTugo7cu1DpoK8izBDFKSQHD2OhQaYsHl1DIvEON3Q
 mpMUA+L5hBuEFGBev9PZkhC8x9E6ZdDi0wh1BIgvFG+FIJiZNrwjkYYjItUrmnd/slEF0bvGdWj
 8ZQhCu5Flj5mM+HidBy1oRbxRDV7LfXVKwAOYv7EVc+u21afidXwXbRIFiyEU+6gzMl+zj4EwvA
 C2Kedz3L
X-Proofpoint-GUID: Pe-c0i8LZDyg4uH-DAQUuKdDFo3Smm0a
X-Proofpoint-ORIG-GUID: Pe-c0i8LZDyg4uH-DAQUuKdDFo3Smm0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=441 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=10 impostorscore=0
 mlxscore=0 lowpriorityscore=10 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2507300000 definitions=main-2508140003

On Thu, Aug 14, 2025 at 3:39=E2=80=AFAM Tal Zussman <tz2294@columbia.edu> w=
rote:
>
> make clean does not check the kernel config when removing files. As
> such, additions to clean-files under CONFIG_ARM or CONFIG_ARM64 are not
> evaluated. For example, when building on arm64, this means that
> lib/crypto/arm64/sha{256,512}-core.S are left over after make clean.
>
> Set clean-files unconditionally to ensure that make clean removes these
> files.
>
> Fixes: e96cb9507f2d ("lib/crypto: sha256: Consolidate into single module"=
)
> Fixes: 24c91b62ac50 ("lib/crypto: arm/sha512: Migrate optimized SHA-512 c=
ode to library")
> Fixes: 60e3f1e9b7a5 ("lib/crypto: arm64/sha512: Migrate optimized SHA-512=
 code to library")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
> An alternative approach is to rename the generated files to *.s and
> remove the clean-files lines, as make clean removes *.s files
> automatically. However, this would require explicitly defining the
> corresponding *.o rules.
> ---
>  lib/crypto/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index e4151be2ebd4..44f6a1fdc808 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -100,7 +100,6 @@ ifeq ($(CONFIG_ARM),y)
>  libsha256-y +=3D arm/sha256-ce.o arm/sha256-core.o
>  $(obj)/arm/sha256-core.S: $(src)/arm/sha256-armv4.pl
>         $(call cmd,perlasm)
> -clean-files +=3D arm/sha256-core.S
>  AFLAGS_arm/sha256-core.o +=3D $(aflags-thumb2-y)
>  endif
>
> @@ -108,7 +107,6 @@ ifeq ($(CONFIG_ARM64),y)
>  libsha256-y +=3D arm64/sha256-core.o
>  $(obj)/arm64/sha256-core.S: $(src)/arm64/sha2-armv8.pl
>         $(call cmd,perlasm_with_args)
> -clean-files +=3D arm64/sha256-core.S
>  libsha256-$(CONFIG_KERNEL_MODE_NEON) +=3D arm64/sha256-ce.o
>  endif
>
> @@ -132,7 +130,6 @@ ifeq ($(CONFIG_ARM),y)
>  libsha512-y +=3D arm/sha512-core.o
>  $(obj)/arm/sha512-core.S: $(src)/arm/sha512-armv4.pl
>         $(call cmd,perlasm)
> -clean-files +=3D arm/sha512-core.S
>  AFLAGS_arm/sha512-core.o +=3D $(aflags-thumb2-y)
>  endif
>
> @@ -140,7 +137,6 @@ ifeq ($(CONFIG_ARM64),y)
>  libsha512-y +=3D arm64/sha512-core.o
>  $(obj)/arm64/sha512-core.S: $(src)/arm64/sha2-armv8.pl
>         $(call cmd,perlasm_with_args)
> -clean-files +=3D arm64/sha512-core.S
>  libsha512-$(CONFIG_KERNEL_MODE_NEON) +=3D arm64/sha512-ce-core.o
>  endif
>
> @@ -167,3 +163,7 @@ obj-$(CONFIG_PPC) +=3D powerpc/
>  obj-$(CONFIG_RISCV) +=3D riscv/
>  obj-$(CONFIG_S390) +=3D s390/
>  obj-$(CONFIG_X86) +=3D x86/
> +
> +# clean-files must be defined unconditionally
> +clean-files +=3D arm/sha256-core.S arm/sha256-core.S
> +clean-files +=3D arm64/sha512-core.S arm64/sha512-core.S

Sorry this is broken, needs the following fix on top.
I'll fix in v2.

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 44f6a1fdc808..539d5d59a50e 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -165,5 +165,5 @@ obj-$(CONFIG_S390) +=3D s390/
 obj-$(CONFIG_X86) +=3D x86/

 # clean-files must be defined unconditionally
-clean-files +=3D arm/sha256-core.S arm/sha256-core.S
-clean-files +=3D arm64/sha512-core.S arm64/sha512-core.S
+clean-files +=3D arm/sha256-core.S arm/sha512-core.S
+clean-files +=3D arm64/sha256-core.S arm64/sha512-core.S

