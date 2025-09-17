Return-Path: <linux-kernel+bounces-819925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406A7B7F5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E94520584
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF6A231A41;
	Wed, 17 Sep 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Kry9SWYt"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A92D288A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079856; cv=none; b=B6o4RjloSHizjph7rjVyzOz+Xe//bSuf9GInXYEmZJBr5b12a3WUBY5vequ0NhLNYXH9uxyMxQ0jFuw4ZDx1tcAniIF4Fdvzo/rtHYu5UG87zPf0xDnFknHhwmkX3HzlKmheaTV0gR3braPLa9H+hVsYbL+kfZtK2LKWCW2ZeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079856; c=relaxed/simple;
	bh=ZdcIOVGT3ZsynmB0gxhRALYi81mR/IT/DdkerSZfxRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DNUs2jTS5MdL7Zcgt+TsRcN2OyKEegYojJB9BQfgLw1n7by2kFkVhLaVhe/1m5/yFMwlgw7rPKZ5+s9zx7yzGtHPOskKiZH12DbvlH8fit5TuTDHZANGENLbQouKK2vCvnA6TmMchAiWs3yLKZhWUv9bhW+DD2w2isvHpklIZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Kry9SWYt; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UAVDs1VLham54ZqxWN+SHa6U1EiRrERwJc+azYqy1+I=; b=Kry9SWYtgvdutxvXmjz7kw2FjM
	D4Mh+YtXTIKEFOeFDFrG/Bs5kNB2DI0eCiJBF9ohZNNXeq4rT2h4WQ0Mj5VddscfGpMjkhpwEzPP1
	k9Jk65lptDjMFQ1n5wKbUMNl1cixjK1hCGT6sKxuL8UM5OU/jEohuJWv9W9ps8HAFECu5rVSE9aH3
	GALfPULwTqOmjtJc4lj7X1HCOeVELOJdXDob2cfiPWUFqNI7Ats4xtjXF4GBCoRkFydXdbkBZJIj/
	AcIpXLmHIVtcxTGBJ2bxNRsE5RWsJ/lfck6GQAtXFo5td7mpCKI9ouhrnjaeETlwY/KZkNaKQ6hNB
	vWMBRKoA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uyis8-000000003qc-1Q3q;
	Tue, 16 Sep 2025 23:30:20 -0400
Message-ID: <190cd3842bc0776611c73a439e49ba57c86849d1.camel@surriel.com>
Subject: Re: [RFC PATCH 06/12] mm/cma: define and act on CMA_BALANCE flag
From: Rik van Riel <riel@surriel.com>
To: Frank van der Linden <fvdl@google.com>, akpm@linux-foundation.org, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev
Date: Tue, 16 Sep 2025 23:30:20 -0400
In-Reply-To: <20250915195153.462039-7-fvdl@google.com>
References: <20250915195153.462039-1-fvdl@google.com>
	 <20250915195153.462039-7-fvdl@google.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 19:51 +0000, Frank van der Linden wrote:
>=20
> @@ -851,7 +862,10 @@ int __init
> cma_declare_contiguous_multi(phys_addr_t total_size,
> =C2=A0	list_for_each_safe(mp, next, &ranges) {
> =C2=A0		mlp =3D list_entry(mp, struct cma_init_memrange,
> list);
> =C2=A0		list_del(mp);
> -		list_insert_sorted(&final_ranges, mlp, basecmp);
> +		if (flags & CMA_BALANCE)
> +			list_insert_sorted(&final_ranges, mlp,
> revbasecmp);
> +		else
> +			list_insert_sorted(&final_ranges, mlp,
> basecmp);
> =C2=A0		sizesum +=3D mlp->size;
> =C2=A0		if (sizesum >=3D total_size)
> =C2=A0			break;

Wait, what is this supposed to do when presented
with a mix of CMA_BALANCE and !CMA_BALANCE ranges?

I can't convince myself this would always keep
the CMA_BALANCE range near the top of the list,
and the others near the bottom.

Also, does the regular compaction code pay any
attention to the order of this list?

I have the feeling I am overlooking something big
in how this patch is supposed to work, but I am
not sure what that would be...

> @@ -866,7 +880,12 @@ int __init
> cma_declare_contiguous_multi(phys_addr_t total_size,
> =C2=A0	list_for_each(mp, &final_ranges) {
> =C2=A0		mlp =3D list_entry(mp, struct cma_init_memrange,
> list);
> =C2=A0		size =3D min(sizeleft, mlp->size);
> -		if (memblock_reserve(mlp->base, size)) {
> +		if (flags & CMA_BALANCE)
> +			start =3D (mlp->base + mlp->size - size);
> +		else
> +			start =3D mlp->base;
> +
> +		if (memblock_reserve(start, size)) {
> =C2=A0			/*
> =C2=A0			 * Unexpected error. Could go on to
> =C2=A0			 * the next one, but just abort to
>=20

--=20
All Rights Reversed.

